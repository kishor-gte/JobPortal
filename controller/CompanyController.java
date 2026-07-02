package com.example.demo.controller;

import com.example.demo.dao.*;
import com.example.demo.model.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.io.File;
import java.io.IOException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Controller
public class CompanyController {

    @Autowired
    private JobDAO jobDAO;

    @Autowired
    private JobApplicationDAO jobApplicationDAO;

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private ResumeDAO resumeDAO;

    @Value("${gemini.api.key}")
    private String geminiApiKey;

    private static final String GEMINI_API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=";

    private User getLoggedInUser(HttpSession session) {
        return (User) session.getAttribute("loggedInUser");
    }

    // =================== JOB LISTINGS (Public / Students) ===================

    @GetMapping("/jobs")
    public String jobListings(HttpSession session, Model model,
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) String experienceLevel,
            @RequestParam(required = false) String skills) {
        User user = getLoggedInUser(session);
        if (user == null) return "redirect:/login";

        List<Job> jobs;
        boolean hasFilters = (keyword != null && !keyword.isEmpty()) ||
                (location != null && !location.isEmpty()) ||
                (experienceLevel != null && !experienceLevel.isEmpty()) ||
                (skills != null && !skills.isEmpty());

        if (hasFilters) {
            jobs = jobDAO.search(keyword, location, experienceLevel, skills);
        } else {
            jobs = jobDAO.findAll();
        }

        model.addAttribute("user", user);
        model.addAttribute("jobs", jobs);
        model.addAttribute("keyword", keyword);
        model.addAttribute("location", location);
        model.addAttribute("experienceLevel", experienceLevel);
        model.addAttribute("skills", skills);
        return "job-listings";
    }

    @GetMapping("/jobs/{id}")
    public String jobDetail(@PathVariable Long id, HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null) return "redirect:/login";

        Job job = jobDAO.findById(id);
        if (job == null) return "redirect:/jobs";

        boolean hasApplied = false;
        if ("STUDENT".equals(user.getRole())) {
            hasApplied = jobApplicationDAO.hasApplied(id, user.getId());
        }

        model.addAttribute("user", user);
        model.addAttribute("job", job);
        model.addAttribute("hasApplied", hasApplied);
        return "job-detail";
    }

    // =================== JOB APPLICATION (Students) ===================

    @PostMapping("/jobs/apply")
    public String applyForJob(@RequestParam Long jobId,
            @RequestParam(value = "resume", required = false) MultipartFile resume,
            @RequestParam(required = false) String coverLetter,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole()))
            return "redirect:/login";

        Job job = jobDAO.findById(jobId);
        if (job == null) {
            redirectAttributes.addFlashAttribute("error", "Job not found!");
            return "redirect:/jobs";
        }

        if (jobApplicationDAO.hasApplied(jobId, user.getId())) {
            redirectAttributes.addFlashAttribute("error", "You have already applied for this job!");
            return "redirect:/jobs/" + jobId;
        }

        try {
            JobApplication app = new JobApplication();
            app.setJobId(jobId);
            app.setApplicantId(user.getId());
            app.setCoverLetter(coverLetter);
            app.setStatus("APPLIED");

            if (resume != null && !resume.isEmpty()) {
                String uploadDir = System.getProperty("user.dir") + "/uploads/job-resumes/";
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                String fileName = UUID.randomUUID() + "_" + resume.getOriginalFilename();
                String filePath = uploadDir + fileName;
                resume.transferTo(new File(filePath));

                app.setResumePath(filePath);
                app.setResumeFileName(resume.getOriginalFilename());

                // Calculate resume match score for the job
                String extractedText = extractTextFromFile(filePath);
                Map<String, Object> scoreResult = calculateResumeMatchScore(job, extractedText);
                app.setResumeScore((int) scoreResult.getOrDefault("score", 0));
                app.setScoreSuggestions((String) scoreResult.getOrDefault("suggestions", ""));
            } else {
                // Check if user has an existing resume
                List<Resume> resumes = resumeDAO.findByStudentId(user.getId());
                if (!resumes.isEmpty()) {
                    Resume latestResume = resumes.get(0);
                    app.setResumePath(latestResume.getFilePath());
                    app.setResumeFileName(latestResume.getFileName());

                    String extractedText = extractTextFromFile(latestResume.getFilePath());
                    Map<String, Object> scoreResult = calculateResumeMatchScore(job, extractedText);
                    app.setResumeScore((int) scoreResult.getOrDefault("score", 0));
                    app.setScoreSuggestions((String) scoreResult.getOrDefault("suggestions", ""));
                }
            }

            jobApplicationDAO.save(app);
            redirectAttributes.addFlashAttribute("success", "Application submitted successfully! Resume Match Score: " + app.getResumeScore() + "%");
        } catch (IOException e) {
            redirectAttributes.addFlashAttribute("error", "Failed to upload resume: " + e.getMessage());
        }

        return "redirect:/jobs/" + jobId;
    }

    @GetMapping("/my-applications")
    public String myApplications(HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null || !"STUDENT".equals(user.getRole()))
            return "redirect:/login";

        List<JobApplication> applications = jobApplicationDAO.findByApplicantId(user.getId());
        model.addAttribute("user", user);
        model.addAttribute("applications", applications);
        model.addAttribute("totalApplications", applications.size());
        return "my-applications";
    }

    // =================== COMPANY DASHBOARD ===================

    @GetMapping("/company/dashboard")
    public String companyDashboard(HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null || !"COMPANY".equals(user.getRole()))
            return "redirect:/login";

        model.addAttribute("user", user);
        model.addAttribute("totalJobs", jobDAO.countByCompanyId(user.getId()));
        model.addAttribute("activeJobs", jobDAO.countActiveByCompanyId(user.getId()));
        model.addAttribute("totalApplications", jobApplicationDAO.countByCompanyId(user.getId()));
        model.addAttribute("shortlisted", jobApplicationDAO.countByStatusAndCompanyId("SHORTLISTED", user.getId()));
        model.addAttribute("jobs", jobDAO.findByCompanyId(user.getId()));
        model.addAttribute("recentApplications", jobApplicationDAO.findByCompanyId(user.getId()));
        return "company-dashboard";
    }

    @PostMapping("/company/post-job")
    public String postJob(@RequestParam String title, @RequestParam String description,
            @RequestParam String location, @RequestParam String salary,
            @RequestParam String experienceLevel, @RequestParam String skills,
            @RequestParam String jobType,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(session);
        if (user == null || !"COMPANY".equals(user.getRole()))
            return "redirect:/login";

        Job job = new Job();
        job.setCompanyId(user.getId());
        job.setTitle(title);
        job.setDescription(description);
        job.setLocation(location);
        job.setSalary(salary);
        job.setExperienceLevel(experienceLevel);
        job.setSkills(skills);
        job.setJobType(jobType);
        job.setStatus("ACTIVE");

        jobDAO.save(job);
        redirectAttributes.addFlashAttribute("success", "Job posted successfully!");
        return "redirect:/company/dashboard";
    }

    @PostMapping("/company/update-job-status/{id}")
    public String updateJobStatus(@PathVariable Long id, @RequestParam String status,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(session);
        if (user == null || !"COMPANY".equals(user.getRole()))
            return "redirect:/login";

        jobDAO.updateStatus(id, status, user.getId());
        redirectAttributes.addFlashAttribute("success", "Job status updated!");
        return "redirect:/company/dashboard";
    }

    @PostMapping("/company/delete-job/{id}")
    public String deleteJob(@PathVariable Long id, HttpSession session,
            RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(session);
        if (user == null || !"COMPANY".equals(user.getRole()))
            return "redirect:/login";

        jobDAO.delete(id, user.getId());
        redirectAttributes.addFlashAttribute("success", "Job deleted successfully!");
        return "redirect:/company/dashboard";
    }

    @GetMapping("/company/applicants/{jobId}")
    public String viewApplicants(@PathVariable Long jobId, HttpSession session, Model model) {
        User user = getLoggedInUser(session);
        if (user == null || !"COMPANY".equals(user.getRole()))
            return "redirect:/login";

        Job job = jobDAO.findById(jobId);
        if (job == null || !job.getCompanyId().equals(user.getId()))
            return "redirect:/company/dashboard";

        model.addAttribute("user", user);
        model.addAttribute("job", job);
        model.addAttribute("applicants", jobApplicationDAO.findByJobId(jobId));
        return "company-dashboard";
    }

    @PostMapping("/company/update-application-status/{id}")
    public String updateApplicationStatus(@PathVariable Long id, @RequestParam String status,
            @RequestParam Long jobId, HttpSession session, RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(session);
        if (user == null || !"COMPANY".equals(user.getRole()))
            return "redirect:/login";

        jobApplicationDAO.updateStatus(id, status);
        redirectAttributes.addFlashAttribute("success", "Application status updated to " + status + "!");
        return "redirect:/company/applicants/" + jobId;
    }

    @PostMapping("/company/schedule-interview")
    public String scheduleInterview(@RequestParam Long applicationId, @RequestParam Long jobId,
            @RequestParam(required = false, defaultValue = "") String aptitudeLink, 
            @RequestParam(required = false, defaultValue = "") String codingLink, 
            @RequestParam(required = false, defaultValue = "") String hrLink,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User user = getLoggedInUser(session);
        if (user == null || !"COMPANY".equals(user.getRole()))
            return "redirect:/login";

        jobApplicationDAO.scheduleInterview(applicationId, aptitudeLink, codingLink, hrLink);
        
        // If at least one link is provided, update status to INTERVIEW_SCHEDULED
        if (!aptitudeLink.trim().isEmpty() || !codingLink.trim().isEmpty() || !hrLink.trim().isEmpty()) {
            jobApplicationDAO.updateStatus(applicationId, "INTERVIEW_SCHEDULED");
            redirectAttributes.addFlashAttribute("success", "Interview links updated and candidate scheduled!");
        } else {
            redirectAttributes.addFlashAttribute("success", "Interview links cleared.");
        }
        
        return "redirect:/company/applicants/" + jobId;
    }

    // =================== HELPERS ===================

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

    private Map<String, Object> calculateResumeMatchScore(Job job, String resumeText) {
        Map<String, Object> result = new HashMap<>();
        result.put("score", 50);
        result.put("suggestions", "Upload a detailed resume for better matching.");

        if ("YOUR_GEMINI_API_KEY_HERE".equals(geminiApiKey) || geminiApiKey.isEmpty()) {
            // Fallback: simple keyword matching
            int score = calculateSimpleMatchScore(job, resumeText);
            result.put("score", score);
            result.put("suggestions", generateSimpleSuggestions(job, resumeText));
            return result;
        }

        try {
            RestTemplate restTemplate = new RestTemplate();

            String prompt = "You are an expert HR recruiter. Compare the following resume against a job posting and provide a match score.\n\n" +
                    "Job Title: " + job.getTitle() + "\n" +
                    "Required Skills: " + job.getSkills() + "\n" +
                    "Experience Level: " + job.getExperienceLevel() + "\n" +
                    "Job Description: " + job.getDescription() + "\n\n" +
                    "Resume Text:\n" + resumeText + "\n\n" +
                    "Provide output EXACTLY in this format:\n" +
                    "SCORE: [A number 0-100 representing match percentage]\n" +
                    "SUGGESTIONS:\n- [suggestion 1]\n- [suggestion 2]\n- [suggestion 3]";

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

            ResponseEntity<String> response = restTemplate.exchange(
                    GEMINI_API_URL + geminiApiKey, HttpMethod.POST, entity, String.class);

            if (response.getStatusCode() == HttpStatus.OK) {
                JsonObject jsonResponse = gson.fromJson(response.getBody(), JsonObject.class);
                JsonArray candidates = jsonResponse.getAsJsonArray("candidates");
                if (candidates != null && candidates.size() > 0) {
                    JsonObject firstCandidate = candidates.get(0).getAsJsonObject();
                    JsonObject contentObj = firstCandidate.getAsJsonObject("content");
                    JsonArray resultParts = contentObj.getAsJsonArray("parts");
                    if (resultParts != null && resultParts.size() > 0) {
                        String generatedText = resultParts.get(0).getAsJsonObject().get("text").getAsString();

                        Pattern p = Pattern.compile("(?i)SCORE:\\s*(\\d+)");
                        Matcher m = p.matcher(generatedText);
                        int parsedScore = 50;
                        if (m.find()) {
                            parsedScore = Integer.parseInt(m.group(1));
                        }

                        String suggestions = generatedText.replaceAll("(?i)SCORE:\\s*\\d+\\n?", "").trim();
                        result.put("score", parsedScore);
                        result.put("suggestions", suggestions);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            int score = calculateSimpleMatchScore(job, resumeText);
            result.put("score", score);
            result.put("suggestions", generateSimpleSuggestions(job, resumeText));
        }

        return result;
    }

    private int calculateSimpleMatchScore(Job job, String resumeText) {
        if (resumeText == null || resumeText.isEmpty()) return 20;

        String resumeLower = resumeText.toLowerCase();
        int score = 30; // base score

        // Check skills match
        if (job.getSkills() != null) {
            String[] skills = job.getSkills().split("[,;\\s]+");
            int matched = 0;
            for (String skill : skills) {
                if (skill.length() > 2 && resumeLower.contains(skill.toLowerCase().trim())) {
                    matched++;
                }
            }
            if (skills.length > 0) {
                score += (int) ((double) matched / skills.length * 40);
            }
        }

        // Check job title keywords
        if (job.getTitle() != null) {
            String[] titleWords = job.getTitle().toLowerCase().split("\\s+");
            for (String word : titleWords) {
                if (word.length() > 2 && resumeLower.contains(word)) {
                    score += 5;
                }
            }
        }

        // Check experience level
        if (job.getExperienceLevel() != null && resumeLower.contains(job.getExperienceLevel().toLowerCase())) {
            score += 10;
        }

        return Math.min(score, 100);
    }

    private String generateSimpleSuggestions(Job job, String resumeText) {
        StringBuilder sb = new StringBuilder("SUGGESTIONS:\n");
        String resumeLower = resumeText != null ? resumeText.toLowerCase() : "";

        if (job.getSkills() != null) {
            String[] skills = job.getSkills().split("[,;\\s]+");
            List<String> missing = new ArrayList<>();
            for (String skill : skills) {
                if (skill.length() > 2 && !resumeLower.contains(skill.toLowerCase().trim())) {
                    missing.add(skill.trim());
                }
            }
            if (!missing.isEmpty()) {
                sb.append("- Add experience with: ").append(String.join(", ", missing)).append("\n");
            }
        }

        if (job.getExperienceLevel() != null && !resumeLower.contains(job.getExperienceLevel().toLowerCase())) {
            sb.append("- Highlight your ").append(job.getExperienceLevel()).append(" level experience\n");
        }

        sb.append("- Tailor your resume specifically for the ").append(job.getTitle()).append(" role\n");
        sb.append("- Include relevant project experience and achievements\n");

        return sb.toString();
    }
}
