package com.example.demo.controller;

import com.example.demo.dao.*;
import com.example.demo.model.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import java.util.Map;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

@Controller
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private QuestionDAO questionDAO;

    @Autowired
    private InterviewDAO interviewDAO;

    @Autowired
    private ResumeDAO resumeDAO;

    @Autowired
    private PerformanceDAO performanceDAO;

    @Autowired
    private AIEvaluationDAO aiEvaluationDAO;

    @Autowired
    private CategoryDAO categoryDAO;

    @Autowired
    private FeedbackDAO feedbackDAO;

    @Value("${gemini.api.key}")
    private String geminiApiKey;

    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=";

    private User getLoggedInUser(HttpSession session) {
        return (User) session.getAttribute("loggedInUser");
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole()))
            return "redirect:/login";

        model.addAttribute("user", user);
        model.addAttribute("totalAttempted", performanceDAO.countAnswersByStudent(user.getId()));
        model.addAttribute("totalCorrect", performanceDAO.countCorrectAnswersByStudent(user.getId()));
        model.addAttribute("performances", performanceDAO.findByStudentId(user.getId()));
        model.addAttribute("interviews", interviewDAO.findByStudentId(user.getId()));
        model.addAttribute("resumes", resumeDAO.findByStudentId(user.getId()));
        model.addAttribute("progress", performanceDAO.findProgressByStudentId(user.getId()));
        model.addAttribute("recommendedQuestions", questionDAO.findRecommendedForStudent(user.getId()));
        model.addAttribute("evaluations", aiEvaluationDAO.findByStudentId(user.getId()));
        model.addAttribute("feedbacks", feedbackDAO.findByStudentId(user.getId()));
        return "student-dashboard";
    }

    @GetMapping("/coding-practice")
    public String codingPractice(HttpSession session, Model model,
            @RequestParam(required = false) Long categoryId,
            @RequestParam(required = false) String difficulty) {
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole()))
            return "redirect:/login";

        List<CodingQuestion> questions;
        if (categoryId != null) {
            questions = questionDAO.findCodingByCategory(categoryId);
        } else if (difficulty != null) {
            questions = questionDAO.findCodingByDifficulty(difficulty);
        } else {
            questions = questionDAO.findAllCodingQuestions();
        }

        model.addAttribute("user", user);
        model.addAttribute("questions", questions);
        model.addAttribute("categories", categoryDAO.findAll());
        model.addAttribute("selectedCategory", categoryId);
        model.addAttribute("selectedDifficulty", difficulty);
        return "coding-practice";
    }

    @GetMapping("/coding-question/{id}")
    public String viewCodingQuestion(@PathVariable Long id, HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole()))
            return "redirect:/login";

        CodingQuestion question = questionDAO.findCodingById(id);
        if (question == null)
            return "redirect:/student/coding-practice";

        model.addAttribute("user", user);
        model.addAttribute("question", question);
        return "attempt-question";
    }

    @PostMapping("/submit-answer")
    public String submitAnswer(@RequestParam Long questionId, @RequestParam String questionType,
            @RequestParam String answer, @RequestParam(defaultValue = "0") int timeTaken,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole()))
            return "redirect:/login";

        StudentAnswer sa = new StudentAnswer();
        sa.setStudentId(user.getId());
        sa.setQuestionId(questionId);
        sa.setQuestionType(questionType);
        sa.setAnswer(answer);
        sa.setTimeTaken(timeTaken);

        // Simple AI-like evaluation
        int score = evaluateAnswer(answer);
        sa.setScore(score);
        sa.setIsCorrect(score >= 60);

        performanceDAO.saveAnswer(sa);
        performanceDAO.updatePerformanceScore(user.getId(), null);
        performanceDAO.updateDailyProgress(user.getId(), sa.getIsCorrect(), timeTaken);

        redirectAttributes.addFlashAttribute("success", "Answer submitted! Your score: " + score + "/100");
        if ("CODING".equals(questionType)) {
            return "redirect:/student/coding-practice";
        }
        return "redirect:/student/mock-interview";
    }

    @GetMapping("/mock-interview")
    public String mockInterview(HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole()))
            return "redirect:/login";

        model.addAttribute("user", user);
        model.addAttribute("interviews", interviewDAO.findByStudentId(user.getId()));
        model.addAttribute("interviewQuestions", questionDAO.findAllInterviewQuestions());
        model.addAttribute("categories", categoryDAO.findAll());
        return "mock-interview";
    }

    @GetMapping("/upload-resume")
    public String uploadResumePage(HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole()))
            return "redirect:/login";

        model.addAttribute("user", user);
        model.addAttribute("resumes", resumeDAO.findByStudentId(user.getId()));
        return "upload-resume";
    }

    @PostMapping("/upload-resume")
    public String uploadResume(@RequestParam("file") MultipartFile file,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole()))
            return "redirect:/login";

        if (file.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Please select a file to upload!");
            return "redirect:/student/upload-resume";
        }

        try {
            String uploadDir = System.getProperty("user.dir") + "/uploads/resumes/";
            File dir = new File(uploadDir);
            if (!dir.exists())
                dir.mkdirs();

            String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
            String filePath = uploadDir + fileName;
            file.transferTo(new File(filePath));

            Resume resume = new Resume();
            resume.setStudentId(user.getId());
            resume.setFileName(file.getOriginalFilename());
            resume.setFilePath(filePath);
            resume.setFileSize(file.getSize());
            resumeDAO.save(resume);

            // Generate AI feedback via real API
            String extractedText = extractTextFromFile(filePath);
            Map<String, Object> aiResult = generateResumeFeedbackAPI(file.getOriginalFilename(), extractedText);

            String aiFeedback = (String) aiResult.getOrDefault("feedback", "AI Feedback unavailable at this time.");
            int aiScore = (int) aiResult.getOrDefault("score", 65);

            Resume savedResume = resumeDAO.findByStudentId(user.getId()).get(0);
            resumeDAO.updateAiFeedback(savedResume.getId(), aiFeedback, aiScore);

            redirectAttributes.addFlashAttribute("success", "Resume uploaded successfully! AI feedback generated.");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to upload file: " + e.getMessage());
        }

        return "redirect:/student/upload-resume";
    }

    @GetMapping("/performance")
    public String performance(HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole()))
            return "redirect:/login";

        model.addAttribute("user", user);
        model.addAttribute("performances", performanceDAO.findByStudentId(user.getId()));
        model.addAttribute("progress", performanceDAO.findProgressByStudentId(user.getId()));
        model.addAttribute("totalAttempted", performanceDAO.countAnswersByStudent(user.getId()));
        model.addAttribute("totalCorrect", performanceDAO.countCorrectAnswersByStudent(user.getId()));
        model.addAttribute("answers", performanceDAO.findAnswersByStudentId(user.getId()));
        return "performance";
    }

    // Map frontend language names to Wandbox compiler names
    private static final Map<String, String> WANDBOX_COMPILERS = new HashMap<>() {{
        put("java", "openjdk-jdk-22+36");
        put("python", "cpython-3.12.7");
        put("c", "gcc-13.2.0-c");
        put("c++", "gcc-13.2.0");
        put("javascript", "nodejs-20.17.0");
    }};

    @PostMapping("/run-code")
    @ResponseBody
    public Map<String, Object> runCode(@RequestBody Map<String, String> payload, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole())) {
            result.put("error", "Unauthorized");
            return result;
        }

        String language = payload.getOrDefault("language", "java");
        String code = payload.getOrDefault("code", "");
        String stdin = payload.getOrDefault("stdin", "");

        String compiler = WANDBOX_COMPILERS.getOrDefault(language, "gcc-13.2.0-c");

        try {
            RestTemplate restTemplate = new RestTemplate();
            Gson gson = new Gson();

            JsonObject requestBody = new JsonObject();
            requestBody.addProperty("code", code);
            requestBody.addProperty("compiler", compiler);
            if (stdin != null && !stdin.isEmpty()) {
                requestBody.addProperty("stdin", stdin);
            }

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<String> entity = new HttpEntity<>(gson.toJson(requestBody), headers);

            ResponseEntity<String> response = restTemplate.exchange(
                    "https://wandbox.org/api/compile.json",
                    HttpMethod.POST, entity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                JsonObject jsonResponse = gson.fromJson(response.getBody(), JsonObject.class);

                String programOutput = jsonResponse.has("program_message") && !jsonResponse.get("program_message").isJsonNull()
                        ? jsonResponse.get("program_message").getAsString() : "";
                String compilerOutput = jsonResponse.has("compiler_message") && !jsonResponse.get("compiler_message").isJsonNull()
                        ? jsonResponse.get("compiler_message").getAsString() : "";
                String programError = jsonResponse.has("program_error") && !jsonResponse.get("program_error").isJsonNull()
                        ? jsonResponse.get("program_error").getAsString() : "";
                String status = jsonResponse.has("status") && !jsonResponse.get("status").isJsonNull()
                        ? jsonResponse.get("status").getAsString() : "0";

                int exitCode = 0;
                try { exitCode = Integer.parseInt(status); } catch (NumberFormatException e) { /* default 0 */ }

                String output = programOutput;
                String stderr = "";

                // If compilation failed, show compiler errors
                if (exitCode != 0 || !compilerOutput.isEmpty()) {
                    stderr = compilerOutput;
                }
                if (!programError.isEmpty()) {
                    stderr = stderr.isEmpty() ? programError : stderr + "\n" + programError;
                }

                result.put("output", output);
                result.put("stderr", stderr);
                result.put("exitCode", exitCode);
                result.put("success", true);
            } else {
                result.put("error", "Execution service returned status: " + response.getStatusCode());
                result.put("success", false);
            }
        } catch (Exception e) {
            result.put("error", "Code execution failed: " + e.getMessage());
            result.put("success", false);
        }

        return result;
    }

    private int evaluateAnswer(String answer) {
        if (answer == null || answer.trim().isEmpty())
            return 0;
        int length = answer.trim().length();
        if (length < 20)
            return 30;
        if (length < 50)
            return 50;
        if (length < 100)
            return 65;
        if (length < 200)
            return 75;
        return Math.min(95, 70 + (int) (Math.random() * 25));
    }

    private String extractTextFromFile(String filePath) {
        if (!filePath.toLowerCase().endsWith(".pdf")) {
            return "File is not a PDF. Text extraction not supported for this format.";
        }
        try (PDDocument document = PDDocument.load(new File(filePath))) {
            PDFTextStripper stripper = new PDFTextStripper();
            String text = stripper.getText(document);
            return text != null ? text : "";
        } catch (Exception e) {
            e.printStackTrace();
            return "Could not extract text from file: " + e.getMessage();
        }
    }

    private Map<String, Object> generateResumeFeedbackAPI(String fileName, String fileText) {
        Map<String, Object> result = new HashMap<>();
        result.put("score", 65); // Default fallback score
        result.put("feedback", "We were unable to analyze the resume via AI at this time.");

        if ("YOUR_GEMINI_API_KEY_HERE".equals(geminiApiKey) || geminiApiKey.isEmpty()) {
            result.put("feedback",
                    "API Key is missing. Please configure 'gemini.api.key' in application.properties.\n\n" +
                            "Dummy Analysis:\n✅ Strengths:\n- Document uploaded\n\n⚠️ Suggestions:\n- Configure API Key for real feedback.");
            return result;
        }

        try {
            RestTemplate restTemplate = new RestTemplate();

            String prompt = "You are an expert tech recruiter and AI Resume Analyzer. Given the following extracted text from a candidate's resume ("
                    + fileName + "), analyze it constructively.\n"
                    + "Provide the output EXACTLY in the following format:\n\n"
                    + "SCORE: [A number between 0 and 100 representing the resume's overall strength]\n"
                    + "Analysis:\n[A short paragraph of overall analysis]\n\n"
                    + "✅ Strengths:\n- [strength 1...]\n\n"
                    + "⚠️ Suggestions:\n- [suggestion 1...]\n\n"
                    + "---\nResume Text:\n" + fileText;

            // Build Gemini Request using Gson
            Gson gson = new Gson();

            JsonObject part = new JsonObject();
            part.addProperty("text", prompt);

            JsonArray parts = new JsonArray();
            parts.add(part);

            JsonObject content = new JsonObject();
            content.add("parts", parts);

            JsonArray contents = new JsonArray();
            contents.add(content);

            JsonObject requestBody = new JsonObject();
            requestBody.add("contents", contents);

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<String> entity = new HttpEntity<>(gson.toJson(requestBody), headers);

            String finalUrl = GEMINI_API_URL + geminiApiKey;

            ResponseEntity<String> response = restTemplate.exchange(finalUrl, HttpMethod.POST, entity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                JsonObject jsonResponse = gson.fromJson(response.getBody(), JsonObject.class);
                JsonArray candidates = jsonResponse.getAsJsonArray("candidates");
                if (candidates != null && candidates.size() > 0) {
                    JsonObject firstCandidate = candidates.get(0).getAsJsonObject();
                    JsonObject contentObj = firstCandidate.getAsJsonObject("content");
                    JsonArray resultParts = contentObj.getAsJsonArray("parts");
                    if (resultParts != null && resultParts.size() > 0) {
                        String generatedText = resultParts.get(0).getAsJsonObject().get("text").getAsString();

                        // Extract Score and textual feedback
                        Pattern p = Pattern.compile("(?i)SCORE:\\s*(\\d+)");
                        Matcher m = p.matcher(generatedText);
                        int parsedScore = 65;
                        if (m.find()) {
                            parsedScore = Integer.parseInt(m.group(1));
                        }

                        // Clean up the output string to not display the raw "SCORE: XX" part
                        String cleanFeedback = generatedText.replaceAll("(?i)SCORE:\\s*\\d+\n?", "").trim();

                        result.put("score", parsedScore);
                        result.put("feedback", cleanFeedback);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            result.put("feedback", "Error communicating with AI service: " + e.getMessage());
        }

        return result;
    }
}
