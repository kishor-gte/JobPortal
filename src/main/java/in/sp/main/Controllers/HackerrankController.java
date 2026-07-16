package in.sp.main.Controllers;

import in.sp.main.Entities.JobSeeker;
import in.sp.main.dao.QuestionDAO;
import in.sp.main.dao.InterviewDAO;
import in.sp.main.dao.ResumeDAO;
import in.sp.main.Entities.MockInterview;
import in.sp.main.Entities.Resume;
import in.sp.main.Repositories.JobSeekerRepository;
import in.sp.main.Entities.Admin;
import in.sp.main.Entities.JobApplication;
import in.sp.main.Repositories.JobApplicationRepository;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.ResponseEntity;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import java.nio.file.Path;
import java.nio.file.Paths;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.util.Map;
import java.util.HashMap;
import java.io.*;
import java.util.concurrent.TimeUnit;
import java.util.List;
import java.util.ArrayList;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import in.sp.main.Repositories.UserActivityRepository;
import in.sp.main.Entities.UserActivity;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Value;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

import in.sp.main.dto.ResumeAnalysisResponse;

@Controller
@RequestMapping("/hackerrank")
public class HackerrankController {

    @Autowired
    private in.sp.main.Services.ResumeParserService resumeParserService;

    @Autowired
    private in.sp.main.Services.AtsScoreService atsScoreService;

    @Autowired
    private QuestionDAO questionDAO;

    @Autowired
    private in.sp.main.Services.JobServices jobServices;

    @Autowired
    private JobSeekerRepository jobSeekerRepository;

    @Autowired
    private InterviewDAO interviewDAO;

    @Autowired
    private ResumeDAO resumeDAO;

    @Autowired
    private in.sp.main.Repositories.CompanyRepository companyRepository;

    @Autowired
    private in.sp.main.dao.PerformanceDAO performanceDAO;

    @Autowired
    private JobApplicationRepository jobApplicationRepository;

    @Autowired
    private in.sp.main.Services.NotificationService notificationService;

    @Autowired
    private UserActivityRepository userActivityRepository;


    @Autowired
    private in.sp.main.Repositories.SavedJobRepository savedJobRepository;



    @Autowired
    private in.sp.main.Services.MatchingService matchingService;

    // Map frontend language names to Wandbox compiler names
    private static final Map<String, String> WANDBOX_COMPILERS = new HashMap<>() {{
        put("java", "openjdk-jdk-22+36");
        put("python", "cpython-3.12.7");
        put("c", "gcc-13.2.0-c");
        put("c++", "gcc-13.2.0");
        put("javascript", "nodejs-20.17.0");
    }};

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String hackerrankIndex(Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        model.addAttribute("user", user);
        model.addAttribute("jobSeeker", user);
        return "hackerrank/index";
    }

    @RequestMapping(value = "/student/dashboard", method = RequestMethod.GET)
    public String studentDashboard(Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if (user != null) {
            user = jobSeekerRepository.findById(user.getId()).orElse(user);
            
            int totalCorrect = performanceDAO.countCorrectAnswersByStudent(user.getId());
            model.addAttribute("totalAttempted", performanceDAO.countAnswersByStudent(user.getId()));
            model.addAttribute("totalCorrect", totalCorrect);
            model.addAttribute("isQualified", true);
            try {
                model.addAttribute("interviews", interviewDAO.findByStudentId(user.getId()));
            } catch (Exception e) {
                model.addAttribute("interviews", new java.util.ArrayList<>());
            }
            try {
                model.addAttribute("resumes", resumeDAO.findByStudentId(user.getId()));
            } catch (Exception e) {
                model.addAttribute("resumes", new java.util.ArrayList<>());
            }
            model.addAttribute("performances", performanceDAO.findByStudentId(user.getId()));
            
            // For recommended questions, take a few coding questions
            java.util.List<in.sp.main.Entities.CodingQuestion> allQ = questionDAO.findAllCodingQuestions();
            if (allQ != null && allQ.size() > 3) {
                model.addAttribute("recommendedQuestions", allQ.subList(0, 3));
            } else {
                model.addAttribute("recommendedQuestions", allQ);
            }
        }
        model.addAttribute("user", user);
        model.addAttribute("jobSeeker", user);
        model.addAttribute("codingQuestions", questionDAO.findAllCodingQuestions());
        model.addAttribute("interviewQuestions", questionDAO.findAllInterviewQuestions());
        return "hackerrank/student-dashboard";
    }

    @RequestMapping(value = "/student/coding-practice", method = RequestMethod.GET)
    public String codingPractice(@RequestParam(required = false) String difficulty,
                                  @RequestParam(required = false) Long categoryId,
                                  Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        model.addAttribute("user", user);
        model.addAttribute("jobSeeker", user);
        model.addAttribute("selectedDifficulty", difficulty);
        model.addAttribute("selectedCategory", categoryId);
        
        // Add solved count for the logged-in student
        if (user != null) {
            int completedCount = performanceDAO.countSolvedCodingQuestionsByStudent(user.getId());
            model.addAttribute("completedCount", completedCount);
            model.addAttribute("solvedQuestionIds", performanceDAO.getSolvedCodingQuestionIdsByStudent(user.getId()));
        } else {
            model.addAttribute("completedCount", 0);
            model.addAttribute("solvedQuestionIds", new java.util.ArrayList<Long>());
        }
        
        // Add categories for filter dropdown
        java.util.List<java.util.Map<String, Object>> categories = new java.util.ArrayList<>();
        categories.add(java.util.Map.of("id", 1L, "name", "Java"));
        categories.add(java.util.Map.of("id", 2L, "name", "Python"));
        categories.add(java.util.Map.of("id", 3L, "name", "JavaScript"));
        categories.add(java.util.Map.of("id", 4L, "name", "Data Structures"));
        categories.add(java.util.Map.of("id", 5L, "name", "Algorithms"));
        categories.add(java.util.Map.of("id", 6L, "name", "SQL"));
        model.addAttribute("categories", categories);
        
        // Filter questions based on difficulty
        java.util.List<in.sp.main.Entities.CodingQuestion> questions;
        if (difficulty != null && !difficulty.isEmpty() && categoryId != null) {
            questions = questionDAO.findCodingByDifficultyAndCategory(difficulty, categoryId);
        } else if (difficulty != null && !difficulty.isEmpty()) {
            questions = questionDAO.findCodingByDifficulty(difficulty);
        } else if (categoryId != null) {
            questions = questionDAO.findCodingByCategory(categoryId);
        } else {
            questions = questionDAO.findAllCodingQuestions();
        }
        
        if (questions == null) {
            questions = new java.util.ArrayList<>();
        }
        model.addAttribute("codingQuestions", questions);
        
        return "hackerrank/coding-practice";
    }


    @RequestMapping(value = "/student/coding-question/{id}", method = RequestMethod.GET)
    public String codingQuestionDetail(@PathVariable Long id, Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        model.addAttribute("user", user);
        model.addAttribute("jobSeeker", user);
        model.addAttribute("question", questionDAO.findCodingById(id));

        // Load previously saved answer so the editor can be pre-filled
        if (user != null) {
            in.sp.main.Entities.StudentAnswer savedAnswer = performanceDAO.findAnswerByStudentAndQuestion(user.getId(), id);
            model.addAttribute("savedAnswer", savedAnswer);
        }

        return "hackerrank/attempt-question";
    }

    @RequestMapping(value = "/student/submit-answer", method = RequestMethod.POST)
    public String submitAnswer(@RequestParam Long questionId,
                               @RequestParam String questionType,
                               @RequestParam String answer,
                               @RequestParam int timeTaken,
                               @RequestParam(required = false, defaultValue = "java") String language,
                               @RequestParam(required = false, defaultValue = "NORMAL") String submissionStatus,
                               HttpSession session,
                               RedirectAttributes redirectAttrs) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if (user == null) {
            return "redirect:/jobSeekers/login";
        }
        
        in.sp.main.Entities.StudentAnswer sa = new in.sp.main.Entities.StudentAnswer();
        sa.setStudentId(user.getId());
        sa.setQuestionId(questionId);
        sa.setQuestionType(questionType);
        sa.setAnswer(answer);
        sa.setTimeTaken(timeTaken);
        
        try {
            boolean isCorrect = false;
            
            // If the exam was terminated due to cheating, it can't be correct
            if ("TERMINATED".equalsIgnoreCase(submissionStatus)) {
                isCorrect = false;
                redirectAttrs.addFlashAttribute("error", "Exam terminated due to violation. Submission marked as incorrect.");
            } else {
                if ("INTERVIEW".equalsIgnoreCase(questionType)) {
                    in.sp.main.Entities.InterviewQuestion iq = questionDAO.findInterviewById(questionId);
                    if (iq != null && iq.getExpectedAnswer() != null && answer != null) {
                        isCorrect = iq.getExpectedAnswer().trim().equalsIgnoreCase(answer.trim());
                    }
                } else if ("CODING".equalsIgnoreCase(questionType)) {
                    in.sp.main.Entities.CodingQuestion cq = questionDAO.findCodingById(questionId);
                    if (cq != null && answer != null && !answer.trim().isEmpty()) {
                        // Execute the code and compare with expected sample output
                        try {
                            isCorrect = executeAndValidateCode(answer, cq.getSampleOutput(), cq.getSampleInput(), language);
                        } catch (Exception e) {
                            System.err.println("Code execution error: " + e.getMessage());
                            redirectAttrs.addFlashAttribute("error", "Code execution failed: " + e.getMessage());
                            return "redirect:/hackerrank/student/coding-practice";
                        }
                    } else {
                        isCorrect = false;
                    }
                }
            }
            
            sa.setIsCorrect(isCorrect);
            performanceDAO.saveAnswer(sa);
            
            // Update performance stats
            performanceDAO.updateDailyProgress(user.getId(), isCorrect, timeTaken);
            performanceDAO.updatePerformanceScore(user.getId(), null); // Overall score
            
            if (!"TERMINATED".equalsIgnoreCase(submissionStatus)) {
                if (isCorrect) {
                    redirectAttrs.addFlashAttribute("success", "Correct Answer! Well done.");
                } else {
                    redirectAttrs.addFlashAttribute("error", "Wrong Answer. Keep practicing!");
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
            redirectAttrs.addFlashAttribute("error", "An error occurred while submitting your answer.");
        }
        
        if ("INTERVIEW".equalsIgnoreCase(questionType)) {
            return "redirect:/hackerrank/student/mock-interview";
        }
        return "redirect:/hackerrank/student/coding-practice";
    }

    @RequestMapping(value = "/student/mock-interview", method = RequestMethod.GET)
    public String mockInterview(Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if (user == null) return "redirect:/jobSeekers/login";
        model.addAttribute("user", user);
        model.addAttribute("jobSeeker", user);
        try {
            model.addAttribute("interviews", interviewDAO.findByStudentId(user.getId()));
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("interviews", new java.util.ArrayList<>());
        }
        model.addAttribute("interviewQuestions", questionDAO.findAllInterviewQuestions());
        return "hackerrank/mock-interview";
    }

    @RequestMapping(value = "/jobs", method = RequestMethod.GET)
    public String jobs(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) String experienceLevel,
            @RequestParam(required = false) String skills,
            @RequestParam(required = false) String jobType,
            Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if (user != null) {
            int totalCorrect = performanceDAO.countCorrectAnswersByStudent(user.getId());
            model.addAttribute("totalCorrect", totalCorrect);
            model.addAttribute("isQualified", true);
        }
        
        java.util.List<in.sp.main.Entities.Job> allJobs = jobServices.getAllActiveJobs();
        
        // Apply filters
        java.util.List<in.sp.main.Entities.Job> filteredJobs = allJobs.stream().filter(job -> {
            boolean matches = true;
            
            // Keyword filter (title or company)
            if (keyword != null && !keyword.trim().isEmpty()) {
                String k = keyword.toLowerCase();
                boolean titleMatch = job.getTitle() != null && job.getTitle().toLowerCase().contains(k);
                boolean companyMatch = job.getCompanyName() != null && job.getCompanyName().toLowerCase().contains(k);
                if (!titleMatch && !companyMatch) matches = false;
            }
            
            // Location filter
            if (matches && location != null && !location.trim().isEmpty()) {
                if (job.getLocation() == null || !job.getLocation().toLowerCase().contains(location.toLowerCase())) {
                    matches = false;
                }
            }
            
            // Experience level filter
            if (matches && experienceLevel != null && !experienceLevel.trim().isEmpty()) {
                String jobExp = job.getExperienceLevel();
                if (jobExp == null || !jobExp.equalsIgnoreCase(experienceLevel)) {
                    // Try to fallback on experienceRequired
                    Integer req = job.getExperienceRequired();
                    boolean fallbackMatch = false;
                    if (req != null) {
                        if ("FRESHER".equalsIgnoreCase(experienceLevel) && req == 0) fallbackMatch = true;
                        else if ("JUNIOR".equalsIgnoreCase(experienceLevel) && req >= 1 && req <= 3) fallbackMatch = true;
                        else if ("MID".equalsIgnoreCase(experienceLevel) && req >= 4 && req <= 7) fallbackMatch = true;
                        else if ("SENIOR".equalsIgnoreCase(experienceLevel) && req >= 8) fallbackMatch = true;
                        else if ("LEAD".equalsIgnoreCase(experienceLevel) && req >= 10) fallbackMatch = true;
                    }
                    if (!fallbackMatch) matches = false;
                }
            }
            // Job Type filter
            if (matches && jobType != null && !jobType.trim().isEmpty()) {
                if (job.getJobType() == null || !job.getJobType().equalsIgnoreCase(jobType)) {
                    matches = false;
                }
            }
            
            // Skills filter
            if (matches && skills != null && !skills.trim().isEmpty()) {
                if (job.getSkillRequirement() == null || !job.getSkillRequirement().toLowerCase().contains(skills.toLowerCase())) {
                    matches = false;
                }
            }
            
            return matches;
        }).collect(java.util.stream.Collectors.toList());

        model.addAttribute("jobs", filteredJobs);
        model.addAttribute("keyword", keyword);
        model.addAttribute("location", location);
        model.addAttribute("experienceLevel", experienceLevel);
        model.addAttribute("jobType", jobType);
        model.addAttribute("skills", skills);
        model.addAttribute("user", user);
        model.addAttribute("jobSeeker", user);
        
        return "hackerrank/job-listings";
    }

    @Autowired
    private in.sp.main.dao.ChatMessageDAO chatMessageDAO;

    @RequestMapping(value = "/chat", method = RequestMethod.GET)
    public String chat(Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        
        if (user == null && company == null) return "redirect:/jobSeekers/login";
        
        Long currentUserId = (user != null) ? user.getId() : company.getId();
        String currentUserRole = (user != null) ? user.getRole() : "COMPANY";
        String currentUserType = (user != null) ? user.getRole() : "user";

        model.addAttribute("user", user != null ? user : company);
        model.addAttribute("currentUserId", currentUserId);
        model.addAttribute("currentUserType", currentUserType);
        
        // Populate contacts
        java.util.List<java.util.Map<String, Object>> contacts = new java.util.ArrayList<>();
        if ("COMPANY".equals(currentUserRole) || "INTERVIEWER".equals(currentUserRole)) {
            // If I'm an interviewer, show all students
            jobSeekerRepository.findAll().stream()
                .filter(js -> "STUDENT".equalsIgnoreCase(js.getRole()) || js.getRole() == null || js.getRole().isEmpty())
                .forEach(js -> {
                    java.util.Map<String, Object> contact = new java.util.HashMap<>();
                    contact.put("id", js.getId());
                    contact.put("fullName", js.getName() != null ? js.getName() : "Student #" + js.getId());
                    contact.put("role", "STUDENT");
                    contact.put("unreadCount", chatMessageDAO.getUnreadCountFromSender(currentUserId, currentUserType, js.getId(), "STUDENT"));
                    contacts.add(contact);
                });
        } else {
            // If I'm a student, show all companies/interviewers
            jobSeekerRepository.findAll().stream()
                .filter(js -> "INTERVIEWER".equalsIgnoreCase(js.getRole()))
                .forEach(js -> {
                    java.util.Map<String, Object> contact = new java.util.HashMap<>();
                    contact.put("id", js.getId());
                    contact.put("fullName", js.getName() != null ? js.getName() : "Interviewer #" + js.getId());
                    contact.put("role", "INTERVIEWER");
                    contact.put("unreadCount", chatMessageDAO.getUnreadCountFromSender(currentUserId, currentUserType, js.getId(), "INTERVIEWER"));
                    contacts.add(contact);
                });
            
            // Also need companies
            companyRepository.findAll().forEach(c -> {
                java.util.Map<String, Object> contact = new java.util.HashMap<>();
                contact.put("id", c.getId());
                contact.put("fullName", c.getName() != null ? c.getName() : "Company #" + c.getId());
                contact.put("role", "COMPANY");
                contact.put("unreadCount", chatMessageDAO.getUnreadCountFromSender(currentUserId, currentUserType, c.getId(), "COMPANY"));
                contacts.add(contact);
            });
        }
        
        model.addAttribute("contacts", contacts);
        if ("COMPANY".equals(currentUserRole) || "INTERVIEWER".equals(currentUserRole)) {
            return "hackerrank/interviewer-chat";
        }
        return "hackerrank/chat";
    }

    @RequestMapping(value = "/chat/{partnerId}", method = RequestMethod.GET)
    public String chatWithPartner(@PathVariable Long partnerId, @RequestParam(required = false) String type, Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        
        if (user == null && company == null) return "redirect:/jobSeekers/login";
        
        Long currentUserId = (user != null) ? user.getId() : company.getId();
        String currentUserType = (user != null) ? (user.getRole() != null && user.getRole().equals("INTERVIEWER") ? "COMPANY" : "STUDENT") : "COMPANY";
        
        model.addAttribute("user", user != null ? user : company);
        model.addAttribute("currentUserId", currentUserId);
        model.addAttribute("currentUserType", currentUserType);
        
        // Populate contacts
        java.util.List<java.util.Map<String, Object>> contacts = new java.util.ArrayList<>();
        if ("COMPANY".equals(currentUserType) || "INTERVIEWER".equals(currentUserType)) {
            jobSeekerRepository.findAll().stream()
                .filter(js -> "STUDENT".equalsIgnoreCase(js.getRole()) || js.getRole() == null || js.getRole().isEmpty())
                .forEach(js -> {
                    java.util.Map<String, Object> contact = new java.util.HashMap<>();
                    contact.put("id", js.getId());
                    contact.put("fullName", js.getName() != null ? js.getName() : "Student #" + js.getId());
                    contact.put("role", "STUDENT");
                    contact.put("unreadCount", chatMessageDAO.getUnreadCountFromSender(currentUserId, currentUserType, js.getId(), "STUDENT"));
                    contacts.add(contact);
                });
        } else {
            jobSeekerRepository.findAll().stream()
                .filter(js -> "INTERVIEWER".equalsIgnoreCase(js.getRole()))
                .forEach(js -> {
                    java.util.Map<String, Object> contact = new java.util.HashMap<>();
                    contact.put("id", js.getId());
                    contact.put("fullName", js.getName() != null ? js.getName() : "Interviewer #" + js.getId());
                    contact.put("role", "INTERVIEWER");
                    contact.put("unreadCount", chatMessageDAO.getUnreadCountFromSender(currentUserId, currentUserType, js.getId(), "INTERVIEWER"));
                    contacts.add(contact);
                });
            companyRepository.findAll().forEach(c -> {
                java.util.Map<String, Object> contact = new java.util.HashMap<>();
                contact.put("id", c.getId());
                contact.put("fullName", c.getName() != null ? c.getName() : "Company #" + c.getId());
                contact.put("role", "COMPANY");
                contact.put("unreadCount", chatMessageDAO.getUnreadCountFromSender(currentUserId, currentUserType, c.getId(), "COMPANY"));
                contacts.add(contact);
            });
        }
        model.addAttribute("contacts", contacts);
        
        // Fetch partner details
        if ("STUDENT".equals(type)) {
            JobSeeker partnerJS = jobSeekerRepository.findById(partnerId).orElse(null);
            if (partnerJS != null) {
                java.util.Map<String, Object> pMap = new java.util.HashMap<>();
                pMap.put("id", partnerJS.getId());
                pMap.put("fullName", partnerJS.getName() != null ? partnerJS.getName() : "User #" + partnerId);
                pMap.put("role", "STUDENT");
                model.addAttribute("partner", pMap);
            }
        } else {
            // Try company
            in.sp.main.Entities.Company partnerComp = companyRepository.findById(partnerId).orElse(null);
            if (partnerComp != null) {
                java.util.Map<String, Object> pMap = new java.util.HashMap<>();
                pMap.put("id", partnerComp.getId());
                pMap.put("fullName", partnerComp.getName() != null ? partnerComp.getName() : "Company #" + partnerId);
                pMap.put("role", "COMPANY");
                model.addAttribute("partner", pMap);
            } else {
                // Try Interviewer (as JobSeeker)
                JobSeeker partnerIS = jobSeekerRepository.findById(partnerId).orElse(null);
                if (partnerIS != null) {
                    java.util.Map<String, Object> pMap = new java.util.HashMap<>();
                    pMap.put("id", partnerIS.getId());
                    pMap.put("fullName", partnerIS.getName() != null ? partnerIS.getName() : "Interviewer #" + partnerId);
                    pMap.put("role", "COMPANY"); // Treat as company for chat type
                    model.addAttribute("partner", pMap);
                }
            }
        }
        
        model.addAttribute("selectedPartnerId", partnerId);
        String pType = (type != null) ? type : "COMPANY";
        model.addAttribute("messages", chatMessageDAO.getConversation(currentUserId, currentUserType, partnerId, pType));
        model.addAttribute("partnerType", pType);
        
        // Mark messages as read
        chatMessageDAO.markAsRead(partnerId, pType, currentUserId, currentUserType);
        
        if ("COMPANY".equals(currentUserType) || "INTERVIEWER".equals(currentUserType)) {
            return "hackerrank/interviewer-chat";
        }
        return "hackerrank/chat";
    }

    @RequestMapping(value = "/chat/api/messages", method = RequestMethod.GET)
    @org.springframework.web.bind.annotation.ResponseBody
    public java.util.List<in.sp.main.Entities.ChatMessage> getMessagesApi(@RequestParam Long partnerId, @RequestParam String partnerType, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        
        if (user == null && company == null) return new java.util.ArrayList<>();
        
        Long currentUserId = (user != null) ? user.getId() : company.getId();
        String currentUserType = (user != null) ? (user.getRole() != null && user.getRole().equals("INTERVIEWER") ? "COMPANY" : "STUDENT") : "COMPANY";
        
        return chatMessageDAO.getConversation(currentUserId, currentUserType, partnerId, partnerType);
    }

    @RequestMapping(value = "/chat/send", method = RequestMethod.POST)
    public String sendMessage(@RequestParam Long receiverId, @RequestParam String receiverType, @RequestParam String content, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        
        if (user == null && company == null) return "redirect:/jobSeekers/login";
        
        Long currentUserId = (user != null) ? user.getId() : company.getId();
        String currentUserType = (user != null) ? (user.getRole() != null && user.getRole().equals("INTERVIEWER") ? "COMPANY" : "STUDENT") : "COMPANY";
        
        in.sp.main.Entities.ChatMessage msg = new in.sp.main.Entities.ChatMessage();
        msg.setSenderId(currentUserId);
        msg.setSenderType(currentUserType);
        msg.setReceiverId(receiverId);
        msg.setReceiverType(receiverType);
        msg.setContent(content);
        
        chatMessageDAO.save(msg);
        
        return "redirect:/hackerrank/chat/" + receiverId + "?type=" + receiverType;
    }

    @RequestMapping(value = "/student/upload-resume", method = RequestMethod.GET)
    public String uploadResume(Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if (user == null) return "redirect:/jobSeekers/login";
        model.addAttribute("user", user);
        model.addAttribute("jobSeeker", user);
        try {
            model.addAttribute("resumes", resumeDAO.findByStudentId(user.getId()));
        } catch(Exception e) {
            model.addAttribute("resumes", new java.util.ArrayList<>());
        }
        return "hackerrank/upload-resume";
    }

    @RequestMapping(value = "/student/upload-resume", method = RequestMethod.POST)
    public String submitResumeUpload(@RequestParam("file") MultipartFile file, HttpSession session, RedirectAttributes redirectAttrs) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if(user == null) return "redirect:/jobSeekers/login";

        if(file.isEmpty()) {
            redirectAttrs.addFlashAttribute("error", "Please select a file to upload.");
            return "redirect:/hackerrank/student/upload-resume";
        }

        try {
            // Ensure uploads directory exists
            String uploadDir = System.getProperty("user.dir") + "/uploads/";
            java.io.File dir = new java.io.File(uploadDir);
            if (!dir.exists()) dir.mkdirs();

            // Save the physical file
            String newFileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            java.io.File serverFile = new java.io.File(uploadDir + newFileName);
            file.transferTo(serverFile);

            Resume resume = new Resume();
            resume.setStudentId(user.getId());
            resume.setFileName(file.getOriginalFilename());
            resume.setFilePath("uploads/" + newFileName);
            resume.setFileSize(file.getSize());
            resume.setAiFeedback("Pending Review");
            resume.setAiScore(0);
            
            resumeDAO.save(resume);
            redirectAttrs.addFlashAttribute("success", "Resume uploaded successfully!");
        } catch(Exception e) {
            e.printStackTrace();
            redirectAttrs.addFlashAttribute("error", "Failed to upload resume: " + e.getMessage());
        }
        return "redirect:/hackerrank/student/upload-resume";
    }

    @RequestMapping(value = "/student/delete-resume/{id}", method = RequestMethod.GET)
    public String studentDeleteResume(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttrs) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if (user == null) return "redirect:/jobSeekers/login";
        try {
            Resume resume = resumeDAO.findById(id);
            if(resume != null && resume.getStudentId().equals(user.getId())) {
                java.io.File file = new java.io.File(System.getProperty("user.dir") + "/" + resume.getFilePath());
                if(file.exists()) file.delete();
                resumeDAO.delete(id);
                redirectAttrs.addFlashAttribute("success", "Resume deleted successfully.");
            }
        } catch(Exception e) {
            redirectAttrs.addFlashAttribute("error", "Failed to delete resume.");
        }
        return "redirect:/hackerrank/student/upload-resume";
    }

    @RequestMapping(value = "/student/analyze-resume/{id}", method = RequestMethod.POST)
    public String analyzeResume(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttrs) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if (user == null) return "redirect:/jobSeekers/login";

        try {
            Resume resume = resumeDAO.findById(id);
            if (resume == null || !resume.getStudentId().equals(user.getId())) {
                redirectAttrs.addFlashAttribute("error", "Resume not found.");
                return "redirect:/hackerrank/student/upload-resume";
            }

            java.io.File file = new java.io.File(System.getProperty("user.dir") + "/" + resume.getFilePath());
            if (!file.exists()) {
                redirectAttrs.addFlashAttribute("error", "Resume file not found on server.");
                return "redirect:/hackerrank/student/upload-resume";
            }

            String resumeText = resumeParserService.extractText(file, resume.getFileName());
            
            ResumeAnalysisResponse response = atsScoreService.analyzeResume(resumeText);
            
            if (response.isSuccess()) {
                resumeDAO.updateAiFeedback(resume.getId(), response.getFeedback(), response.getScore());
                redirectAttrs.addFlashAttribute("success", "Resume analyzed successfully!");
            } else {
                redirectAttrs.addFlashAttribute("error", response.getErrorMessage());
            }

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttrs.addFlashAttribute("error", "Failed to analyze resume: " + e.getMessage());
        }

        return "redirect:/hackerrank/student/upload-resume";
    }

    @RequestMapping(value = "/student/performance", method = RequestMethod.GET)
    public String performance(Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if (user != null) {
            model.addAttribute("totalAttempted", performanceDAO.countAnswersByStudent(user.getId()));
            model.addAttribute("totalCorrect", performanceDAO.countCorrectAnswersByStudent(user.getId()));
            model.addAttribute("performances", performanceDAO.findByStudentId(user.getId()));
            model.addAttribute("progress", performanceDAO.findProgressByStudentId(user.getId()));
        }
        model.addAttribute("user", user);
        model.addAttribute("jobSeeker", user);
        return "hackerrank/performance";
    }

    @RequestMapping(value = "/ai-evaluation/dashboard", method = RequestMethod.GET)
    public String aiEvaluationDashboard(@RequestParam(required = false) String search, Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        Admin admin = (Admin) session.getAttribute("admin");
        Admin loggedInAdmin = (Admin) session.getAttribute("loggedInAdmin");
        
        // Use loggedInAdmin if admin is null
        if (admin == null && loggedInAdmin != null) {
            admin = loggedInAdmin;
        }
        
        if (user == null && company == null && admin == null) return "redirect:/jobSeekers/login";
        
        try {
            java.util.List<in.sp.main.Entities.MockInterview> evals;
            if (admin != null) {
                // Admin sees all evaluations
                evals = interviewDAO.findAll();
                model.addAttribute("user", admin);
            } else if (company != null) {
                evals = interviewDAO.findAll().stream()
                    .filter(e -> e.getInterviewerId().equals(company.getId()))
                    .collect(java.util.stream.Collectors.toList());
                model.addAttribute("user", company);
            } else {
                evals = interviewDAO.findByStudentId(user.getId());
                model.addAttribute("user", user);
            }
            
            // Filter only completed ones
            java.util.List<in.sp.main.Entities.MockInterview> completed = evals.stream()
                .filter(e -> "COMPLETED".equalsIgnoreCase(e.getStatus()))
                .collect(java.util.stream.Collectors.toList());
            
            // Apply search filter if present
            if (search != null && !search.trim().isEmpty()) {
                String query = search.toLowerCase().trim();
                completed = completed.stream()
                    .filter(e -> e.getStudentName() != null && e.getStudentName().toLowerCase().contains(query))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            model.addAttribute("evaluations", completed);
            model.addAttribute("searchQuery", search);
            
            // Calculate averages
            double avgComm = completed.stream().mapToInt(e -> e.getCommunicationScore() != null ? e.getCommunicationScore() : 0).average().orElse(0.0) / 10.0;
            double avgTech = completed.stream().mapToInt(e -> e.getTechnicalScore() != null ? e.getTechnicalScore() : 0).average().orElse(0.0) / 10.0;
            double avgConf = completed.stream().mapToInt(e -> e.getConfidenceScore() != null ? e.getConfidenceScore() : 0).average().orElse(0.0) / 10.0;
            double avgOverall = completed.stream().mapToInt(e -> e.getScore() != null ? e.getScore() : 0).average().orElse(0.0) / 10.0;
            
            model.addAttribute("avgCommunication", String.format("%.1f", avgComm));
            model.addAttribute("avgTechnical", String.format("%.1f", avgTech));
            model.addAttribute("avgConfidence", String.format("%.1f", avgConf));
            model.addAttribute("avgOverall", String.format("%.1f", avgOverall));
            model.addAttribute("totalEvaluations", completed.size());
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "hackerrank/ai-evaluation";
    }

    @RequestMapping(value = "/interviewer/evaluations", method = RequestMethod.GET)
    public String interviewerEvaluations(@RequestParam(required = false) Long studentId, Model model, HttpSession session) {
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        if (company == null) return "redirect:/jobSeekers/login";
        
        try {
            // Get all students for the dropdown filter
            java.util.List<JobSeeker> students = jobSeekerRepository.findAll().stream()
                .filter(js -> "STUDENT".equalsIgnoreCase(js.getRole()) || js.getRole() == null || js.getRole().isEmpty())
                .collect(java.util.stream.Collectors.toList());
            model.addAttribute("interviewedStudents", students);
            
            java.util.List<in.sp.main.Entities.MockInterview> allEvals = interviewDAO.findAll().stream()
                .filter(e -> e.getInterviewerId().equals(company.getId()) && "COMPLETED".equalsIgnoreCase(e.getStatus()))
                .collect(java.util.stream.Collectors.toList());
            
            java.util.List<in.sp.main.Entities.MockInterview> filtered = new java.util.ArrayList<>();
            if (studentId != null) {
                final String currentStudentName = jobSeekerRepository.findById(studentId)
                    .map(JobSeeker::getName)
                    .orElse("Student #" + studentId);

                filtered = allEvals.stream()
                    .filter(e -> e.getStudentId().equals(studentId))
                    .peek(e -> e.setStudentName(currentStudentName))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            model.addAttribute("evaluations", filtered);
            model.addAttribute("selectedStudentId", studentId);
            
            // Calculate averages
            double avgComm = filtered.stream().mapToInt(e -> e.getCommunicationScore() != null ? e.getCommunicationScore() : 0).average().orElse(0.0) / 10.0;
            double avgTech = filtered.stream().mapToInt(e -> e.getTechnicalScore() != null ? e.getTechnicalScore() : 0).average().orElse(0.0) / 10.0;
            double avgConf = filtered.stream().mapToInt(e -> e.getConfidenceScore() != null ? e.getConfidenceScore() : 0).average().orElse(0.0) / 10.0;
            double avgOverall = filtered.stream().mapToInt(e -> e.getScore() != null ? e.getScore() : 0).average().orElse(0.0) / 10.0;
            
            model.addAttribute("avgCommunication", String.format("%.1f", avgComm));
            model.addAttribute("avgTechnical", String.format("%.1f", avgTech));
            model.addAttribute("avgConfidence", String.format("%.1f", avgConf));
            model.addAttribute("avgOverall", String.format("%.1f", avgOverall));
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "hackerrank/interviewer-evaluations";
    }

    @RequestMapping(value = "/interviewer/dashboard", method = RequestMethod.GET)
    public String companyDashboard(Model model, HttpSession session) {
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        if (company == null) {
            company = (in.sp.main.Entities.Company) session.getAttribute("company");
        }
        if (company == null) {
            return "redirect:/company/login";
        }
        model.addAttribute("company", company);
        model.addAttribute("welcomeMessage", "Welcome, " + company.getName() + "!");
        
        java.util.List<in.sp.main.Entities.MockInterview> allInterviews = new java.util.ArrayList<>();
        try {
            allInterviews = interviewDAO.findAll();
            model.addAttribute("interviews", allInterviews);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("interviews", allInterviews);
        }

        try {
            model.addAttribute("resumes", resumeDAO.findAll());
        } catch(Exception e) {
            model.addAttribute("resumes", new java.util.ArrayList<>());
        }

        long totalInterviews = allInterviews.size();
        long scheduledCount = allInterviews.stream().filter(i -> "SCHEDULED".equals(i.getStatus())).count();
        long completedCount = allInterviews.stream().filter(i -> "COMPLETED".equals(i.getStatus())).count();

        model.addAttribute("totalInterviews", totalInterviews);
        model.addAttribute("scheduledCount", scheduledCount);
        model.addAttribute("completedCount", completedCount);
        
        return "hackerrank/interviewer-dashboard";
    }

    @RequestMapping(value = "/interviewer/schedule-interview", method = RequestMethod.GET)
    public String scheduleInterview(Model model, HttpSession session) {
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        if (company == null) {
            company = (in.sp.main.Entities.Company) session.getAttribute("company");
        }
        if (company == null) {
            return "redirect:/company/login";
        }
        model.addAttribute("company", company);
        model.addAttribute("students", jobSeekerRepository.findAll());
        try {
            model.addAttribute("interviews", interviewDAO.findAll());
        } catch (Exception e) {
             e.printStackTrace();
             model.addAttribute("interviews", new java.util.ArrayList<>());
        }
        return "hackerrank/schedule-interview";
    }

    @RequestMapping(value = "/interviewer/schedule-interview", method = RequestMethod.POST)
    public String handleScheduleInterview(
            @RequestParam Long studentId,
            @RequestParam String scheduledAt,
            @RequestParam int durationMinutes,
            @RequestParam(required = false) String meetingLink,
            @RequestParam(required = false) String notes,
            HttpSession session, RedirectAttributes redirectAttrs) {
        
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        if (company == null) company = (in.sp.main.Entities.Company) session.getAttribute("company");
        if (company == null) return "redirect:/company/login";

        MockInterview mi = new MockInterview();
        mi.setStudentId(studentId);
        mi.setInterviewerId(company.getId());
        mi.setScheduledAt(scheduledAt.replace("T", " ")); 
        mi.setDurationMinutes(durationMinutes);
        mi.setStatus("SCHEDULED");
        mi.setMeetingLink(meetingLink);
        mi.setNotes(notes);
        
        try {
            interviewDAO.save(mi);
            
            // Trigger notification for student
            jobSeekerRepository.findById(studentId).ifPresent(student -> {
                String message = "A new mock interview has been scheduled for you on " + mi.getScheduledAt() + 
                                ". Please check your dashboard for details.";
                notificationService.createNotification(student, message);
            });
        } catch(Exception e) {
            e.printStackTrace();
        }
        
        redirectAttrs.addFlashAttribute("success", "Interview scheduled successfully!");
        return "redirect:/hackerrank/interviewer/schedule-interview";
    }

    @RequestMapping(value = "/interviewer/review-resumes", method = RequestMethod.GET)
    public String reviewResumes(Model model, HttpSession session) {
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        if (company == null) {
            company = (in.sp.main.Entities.Company) session.getAttribute("company");
        }
        if (company == null) {
            return "redirect:/company/login";
        }
        model.addAttribute("company", company);
        try {
            model.addAttribute("resumes", resumeDAO.findAll());
        } catch(Exception e) {
            model.addAttribute("resumes", new java.util.ArrayList<>());
        }
        return "hackerrank/review-resumes";
    }

    @RequestMapping(value = "/interviewer/download-resume/{id}", method = RequestMethod.GET)
    public ResponseEntity<Resource> downloadResume(@PathVariable Long id) {
        try {
            Resume resume = resumeDAO.findById(id);
            if (resume == null) return ResponseEntity.notFound().build();
            Path filePath = Paths.get(System.getProperty("user.dir")).resolve(resume.getFilePath()).normalize();
            Resource resource = new UrlResource(filePath.toUri());
            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.APPLICATION_OCTET_STREAM)
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resume.getFileName() + "\"")
                        .body(resource);
            }
        } catch (Exception e) {}
        return ResponseEntity.notFound().build();
    }

    @RequestMapping(value = "/interviewer/view-resume/{id}", method = RequestMethod.GET)
    public ResponseEntity<Resource> viewResume(@PathVariable Long id) {
        try {
            Resume resume = resumeDAO.findById(id);
            if (resume == null) return ResponseEntity.notFound().build();
            Path filePath = Paths.get(System.getProperty("user.dir")).resolve(resume.getFilePath()).normalize();
            Resource resource = new UrlResource(filePath.toUri());
            if (resource.exists()) {
                String contentType = "application/pdf";
                if(resume.getFileName().toLowerCase().endsWith(".docx") || resume.getFileName().toLowerCase().endsWith(".doc")) {
                    contentType = "application/msword";
                }
                return ResponseEntity.ok()
                        .contentType(MediaType.parseMediaType(contentType))
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + resume.getFileName() + "\"")
                        .body(resource);
            }
        } catch (Exception e) {}
        return ResponseEntity.notFound().build();
    }

    @RequestMapping(value = "/interviewer/delete-resume/{id}", method = RequestMethod.GET)
    public String deleteResume(@PathVariable Long id, HttpSession session) {
        try {
            Resume resume = resumeDAO.findById(id);
            if(resume != null) {
                java.io.File file = new java.io.File(System.getProperty("user.dir") + "/" + resume.getFilePath());
                if(file.exists()) file.delete();
                resumeDAO.delete(id);
            }
        } catch(Exception e) {}
        return "redirect:/hackerrank/interviewer/review-resumes";
    }

    @RequestMapping(value = "/interviewer/delete-interview/{id}", method = RequestMethod.GET)
    public String deleteInterview(@PathVariable Long id, @RequestParam(required = false) String redirect, RedirectAttributes redirectAttrs) {
        try {
            interviewDAO.delete(id);
            redirectAttrs.addFlashAttribute("success", "Interview record deleted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttrs.addFlashAttribute("error", "Failed to delete interview record");
        }
        if (redirect != null && !redirect.isEmpty()) {
            return "redirect:" + redirect;
        }
        return "redirect:/hackerrank/interviewer/dashboard";
    }

    @RequestMapping(value = "/interviewer/update-interview-status/{id}", method = RequestMethod.POST)
    public String updateInterviewStatus(@PathVariable Long id, @RequestParam String status, RedirectAttributes redirectAttrs) {
        try {
            interviewDAO.updateStatus(id, status);
            redirectAttrs.addFlashAttribute("success", "Interview status updated to " + status);
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttrs.addFlashAttribute("error", "Failed to update status");
        }
        return "redirect:/hackerrank/interviewer/dashboard";
    }

    @RequestMapping(value = "/interviewer/evaluate/{id}", method = RequestMethod.GET)
    public String evaluateInterview(@PathVariable Long id, Model model, HttpSession session) {
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        if (company == null) company = (in.sp.main.Entities.Company) session.getAttribute("company");
        if (company == null) return "redirect:/company/login";

        model.addAttribute("company", company);
        model.addAttribute("interview", interviewDAO.findById(id));
        return "hackerrank/evaluate-interview";
    }

    @RequestMapping(value = "/interviewer/submit-feedback", method = RequestMethod.POST)
    public String submitFeedback(@RequestParam Long id,
                                 @RequestParam String feedback,
                                 @RequestParam Integer score,
                                 @RequestParam(defaultValue="0") Integer tech,
                                 @RequestParam(defaultValue="0") Integer comm,
                                 @RequestParam(defaultValue="0") Integer conf,
                                 RedirectAttributes redirectAttrs) {
        try {
            interviewDAO.submitFeedback(id, feedback, score, tech, comm, conf);
            redirectAttrs.addFlashAttribute("success", "Feedback submitted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttrs.addFlashAttribute("error", "Failed to submit feedback");
        }
        return "redirect:/hackerrank/interviewer/dashboard";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @RequestMapping(value = "/my-applications", method = RequestMethod.GET)
    public String myApplications(Model model, HttpSession session) {
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if (user == null) return "redirect:/jobSeekers/login";
        
        List<JobApplication> apps = jobApplicationRepository.findByJobSeekerWithJobAndCompany(user);
        for (JobApplication app : apps) {
            if (app.getResumeScore() == null || app.getResumeScore() == 0) {
                int matchScore = matchingService.calculateMatch(app.getJob(), user);
                app.setResumeScore(matchScore);
                jobApplicationRepository.save(app);
            }
        }
        model.addAttribute("applications", apps);
        model.addAttribute("totalApplications", apps.size());
        model.addAttribute("user", user);
        model.addAttribute("jobSeeker", user);
        
        return "hackerrank/my-applications";
    }
    
    @RequestMapping(value = "/student/run-code", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> runCode(@RequestBody Map<String, String> payload, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        JobSeeker user = (JobSeeker) session.getAttribute("jobSeeker");
        if (user == null) {
            result.put("success", false);
            result.put("error", "Unauthorized");
            return result;
        }

        String code = payload.get("code");
        String stdin = payload.get("stdin");
        String language = payload.getOrDefault("language", "java");

        try {
            Map<String, Object> execResult = executeCodeWithWandbox(code, stdin, language);
            result.put("success", true);
            result.put("output", execResult.get("stdout"));
            result.put("stderr", execResult.get("stderr"));
            result.put("exitCode", execResult.get("exitCode"));
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        return result;
    }

    public Map<String, Object> executeCodeWithWandbox(String code, String stdin, String language) throws Exception {
        Map<String, Object> result = new HashMap<>();
        String compiler = WANDBOX_COMPILERS.getOrDefault(language.toLowerCase(), "openjdk-jdk-22+36");

        // Wrap Java code if needed
        if ("java".equalsIgnoreCase(language)) {
            // Remove 'public' from class definitions to avoid filename mismatch errors in Wandbox
            code = code.replaceAll("public\\s+class\\s+", "class ");
            
            if (!code.contains("class ") || !code.contains("public static void main")) {
                code = "import java.util.*;\n" +
                       "class Main {\n" +
                       "    public static void main(String[] args) {\n" +
                       "        Scanner sc = new Scanner(System.in);\n" +
                       "        try {\n" +
                       code + "\n" +
                       "        } catch (Exception e) {\n" +
                       "            System.err.println(\"Error: \" + e.getMessage());\n" +
                       "        }\n" +
                       "    }\n" +
                       "}";
            }
        }

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

        org.springframework.http.ResponseEntity<String> response = restTemplate.exchange(
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
            try { exitCode = Integer.parseInt(status); } catch (Exception e) {}

            String stderr = compilerOutput;
            if (!programError.isEmpty()) {
                stderr = stderr.isEmpty() ? programError : stderr + "\n" + programError;
            }

            result.put("stdout", programOutput);
            result.put("stderr", stderr);
            result.put("exitCode", exitCode);
        } else {
            throw new RuntimeException("Wandbox service error: " + response.getStatusCode());
        }

        return result;
    }

    // Method to execute and validate code against expected solution
    public boolean executeAndValidateCode(String userCode, String expectedOutput, String input, String language) {
        try {
            // Default to Java for validation if not specified
            String lang = (language != null && !language.isEmpty()) ? language : "java";
            Map<String, Object> result = executeCodeWithWandbox(userCode, input, lang);
            String stdout = (String) result.get("stdout");
            int exitCode = (int) result.get("exitCode");
            
            if (exitCode != 0) return false;
            if (expectedOutput == null) return true;
            
            return stdout.trim().equals(expectedOutput.trim());
        } catch (Exception e) {
            return false;
        }
    }
    @RequestMapping(value = "/interviewer/candidates", method = RequestMethod.GET)
    public String interviewerCandidates(
            @RequestParam(required = false) String search,
            @RequestParam(required = false) Integer experience,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) String sort,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            Model model, HttpSession session) {

        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        if (company == null) company = (in.sp.main.Entities.Company) session.getAttribute("company");
        if (company == null) return "redirect:/company/login";

        model.addAttribute("company", company);

        Sort.Direction direction = Sort.Direction.DESC;
        String sortBy = "id";

        if ("oldest".equalsIgnoreCase(sort)) {
            direction = Sort.Direction.ASC;
        } else if ("name".equalsIgnoreCase(sort)) {
            direction = Sort.Direction.ASC;
            sortBy = "name";
        } else if ("experienced".equalsIgnoreCase(sort)) {
            direction = Sort.Direction.DESC;
            sortBy = "experience";
        }

        Pageable pageable = PageRequest.of(page, size, Sort.by(direction, sortBy));

        Page<JobSeeker> candidatesPage = jobSeekerRepository.findCandidatesWithFilters(
                (search != null && !search.trim().isEmpty()) ? search.trim() : null,
                (search != null && !search.trim().isEmpty()) ? search.trim() : null,
                experience, location, pageable);

        model.addAttribute("candidatesPage", candidatesPage);
        model.addAttribute("search", search);
        model.addAttribute("experience", experience);
        model.addAttribute("location", location);
        model.addAttribute("sort", sort);

        // Stats
        model.addAttribute("totalCandidates", jobSeekerRepository.countTotalCandidates());
        model.addAttribute("candidatesWithResume", jobSeekerRepository.countCandidatesWithResume());
        model.addAttribute("candidatesApplied", jobSeekerRepository.countCandidatesApplied());
        model.addAttribute("candidatesInterviewScheduled", jobSeekerRepository.countCandidatesInterviewScheduled());
        model.addAttribute("candidatesHired", jobSeekerRepository.countCandidatesHired());

        return "hackerrank/interviewer-candidates";
    }

    @RequestMapping(value = "/interviewer/api/candidate-profile/{id}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> getCandidateProfile(@PathVariable Long id, HttpSession session) {
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        if (company == null) company = (in.sp.main.Entities.Company) session.getAttribute("company");
        if (company == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        JobSeeker candidate = jobSeekerRepository.findById(id).orElse(null);
        if (candidate == null) return ResponseEntity.notFound().build();

        // Build summary JSON
        Map<String, Object> data = new HashMap<>();
        data.put("id", candidate.getId());
        data.put("name", candidate.getName());
        data.put("email", candidate.getEmail());
        data.put("phone", candidate.getPhone());
        data.put("location", candidate.getLocation() != null ? candidate.getLocation().name() : null);
        data.put("dateOfBirth", candidate.getDateOfBirth());
        data.put("gender", candidate.getGender() != null ? candidate.getGender().name() : null);
        data.put("experience", candidate.getExperience());
        data.put("education", candidate.getEducation() != null ? candidate.getEducation().name() : null);
        data.put("skills", candidate.getSkills());
        data.put("profilePicture", candidate.getProfilePicture());
        data.put("resumeUploaded", candidate.getResumeUploaded());
        
        // Education details
        data.put("ugDegree", candidate.getUgDegree());
        data.put("ugUniversity", candidate.getUgUniversity());
        data.put("pgDegree", candidate.getPgDegree());
        data.put("pgUniversity", candidate.getPgUniversity());

        return ResponseEntity.ok(data);
    }

    @RequestMapping(value = "/interviewer/api/candidate-activities/{id}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> getCandidateActivities(@PathVariable Long id, HttpSession session) {
        in.sp.main.Entities.Company company = (in.sp.main.Entities.Company) session.getAttribute("loggedInCompany");
        if (company == null) company = (in.sp.main.Entities.Company) session.getAttribute("company");
        if (company == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

        JobSeeker candidate = jobSeekerRepository.findById(id).orElse(null);
        if (candidate == null) return ResponseEntity.notFound().build();

        Map<String, Object> response = new HashMap<>();

        // 1. Login History (from UserActivity)
        List<UserActivity> logins = userActivityRepository.findByUserIdAndActivityTypeInOrderByCreatedAtDesc(
            id, java.util.Arrays.asList(in.sp.main.Enums.ActivityType.LOGIN, in.sp.main.Enums.ActivityType.LOGOUT)
        );
        Map<String, Object> loginHistory = new HashMap<>();
        long loginCount = logins.stream().filter(a -> a.getActivityType() == in.sp.main.Enums.ActivityType.LOGIN).count();
        long logoutCount = logins.stream().filter(a -> a.getActivityType() == in.sp.main.Enums.ActivityType.LOGOUT).count();
        UserActivity lastLoginAct = logins.stream().filter(a -> a.getActivityType() == in.sp.main.Enums.ActivityType.LOGIN).findFirst().orElse(null);
        UserActivity firstLoginAct = logins.stream().filter(a -> a.getActivityType() == in.sp.main.Enums.ActivityType.LOGIN).reduce((first, second) -> second).orElse(null);
        UserActivity lastActivity = logins.isEmpty() ? null : logins.get(0);
        String status = "Offline";
        if (lastActivity != null && lastActivity.getActivityType() == in.sp.main.Enums.ActivityType.LOGIN) {
            status = "Online";
        }
        loginHistory.put("totalLogins", loginCount);
        loginHistory.put("totalLogouts", logoutCount);
        loginHistory.put("lastLogin", lastLoginAct != null ? lastLoginAct.getCreatedAt() : null);
        loginHistory.put("firstLogin", firstLoginAct != null ? firstLoginAct.getCreatedAt() : null);
        loginHistory.put("status", status);
        loginHistory.put("browser", lastLoginAct != null ? lastLoginAct.getBrowser() : "Unknown");
        loginHistory.put("deviceType", lastLoginAct != null ? lastLoginAct.getDeviceType() : "Unknown");
        loginHistory.put("os", lastLoginAct != null ? lastLoginAct.getOperatingSystem() : "Unknown");
        loginHistory.put("ipAddress", lastLoginAct != null ? lastLoginAct.getIpAddress() : "Unknown");
        response.put("loginHistory", loginHistory);

        // 2 & 3. Coding Performance & Question History
        List<in.sp.main.Entities.StudentAnswer> answers = performanceDAO.findAnswersByStudentId(id);
        Map<String, Object> codingStats = new HashMap<>();
        int totalAttempted = performanceDAO.countAnswersByStudent(id);
        int totalCorrect = performanceDAO.countCorrectAnswersByStudent(id);
        int totalSolved = performanceDAO.countSolvedCodingQuestionsByStudent(id);
        codingStats.put("attempted", totalAttempted);
        codingStats.put("correct", totalCorrect);
        codingStats.put("solved", totalSolved);
        codingStats.put("unsolved", totalAttempted - totalSolved);
        double accuracy = totalAttempted > 0 ? (double) totalCorrect / totalAttempted * 100 : 0;
        codingStats.put("accuracy", Math.round(accuracy * 100.0) / 100.0);
        
        long totalTime = 0;
        for (in.sp.main.Entities.StudentAnswer a : answers) totalTime += a.getTimeTaken();
        codingStats.put("totalTime", totalTime);
        codingStats.put("avgTime", answers.isEmpty() ? 0 : totalTime / answers.size());
        response.put("codingPerformance", codingStats);

        List<Map<String, Object>> qHistory = new ArrayList<>();
        List<in.sp.main.Entities.StudentAnswer> allAnswersWithQuestions = performanceDAO.findAllStudentAnswers().stream()
                .filter(a -> a.getStudentId().equals(id)).collect(Collectors.toList());
        for (in.sp.main.Entities.StudentAnswer a : allAnswersWithQuestions) {
            Map<String, Object> am = new HashMap<>();
            am.put("questionName", a.getQuestionText() != null ? a.getQuestionText() : "Question #" + a.getQuestionId());
            am.put("type", a.getQuestionType());
            am.put("status", a.getIsCorrect() ? "Solved" : "Attempted");
            am.put("executionTime", a.getTimeTaken() + " ms");
            am.put("score", a.getScore());
            am.put("submittedAt", a.getSubmittedAt());
            am.put("verdict", a.getIsCorrect() ? "Accepted" : "Wrong Answer");
            qHistory.add(am);
        }
        response.put("questionHistory", qHistory);

        // 4. Platform Activity (Full Timeline)
        Pageable allActs = PageRequest.of(0, 100, Sort.by(Sort.Direction.DESC, "createdAt"));
        List<UserActivity> platformActivity = userActivityRepository.findByUserIdOrderByCreatedAtDesc(id, allActs).getContent();
        List<Map<String, Object>> timeline = platformActivity.stream().map(act -> {
            Map<String, Object> m = new HashMap<>();
            m.put("activityType", act.getActivityType().name());
            m.put("description", act.getDescription());
            m.put("createdAt", act.getCreatedAt());
            return m;
        }).collect(Collectors.toList());
        response.put("timeline", timeline);

        // 5. Interview History
        List<in.sp.main.Entities.MockInterview> interviews = interviewDAO.findByStudentId(id);
        List<Map<String, Object>> iHistory = new ArrayList<>();
        for (in.sp.main.Entities.MockInterview mi : interviews) {
            Map<String, Object> m = new HashMap<>();
            m.put("name", "Interview #" + mi.getId());
            m.put("interviewer", mi.getInterviewerName());
            m.put("scheduledAt", mi.getScheduledAt());
            m.put("status", mi.getStatus());
            m.put("duration", mi.getDurationMinutes());
            m.put("overallScore", mi.getScore());
            m.put("techScore", mi.getTechnicalScore());
            m.put("commScore", mi.getCommunicationScore());
            iHistory.add(m);
        }
        response.put("interviewHistory", iHistory);

        // 6. Resume History
        List<in.sp.main.Entities.Resume> resumes = resumeDAO.findByStudentId(id);
        List<Map<String, Object>> rHistory = new ArrayList<>();
        for (in.sp.main.Entities.Resume r : resumes) {
            Map<String, Object> m = new HashMap<>();
            m.put("fileName", r.getFileName());
            m.put("uploadedAt", r.getUploadedAt());
            m.put("status", "Uploaded");
            m.put("score", r.getAiScore());
            rHistory.add(m);
        }
        response.put("resumeHistory", rHistory);

        // 7. Job History
        List<in.sp.main.Entities.JobApplication> apps = jobApplicationRepository.findByJobSeekerWithJobAndCompany(candidate);
        List<Map<String, Object>> jHistory = new ArrayList<>();
        int appliedCount = 0, shortlisted = 0, selected = 0, rejected = 0;
        for (in.sp.main.Entities.JobApplication app : apps) {
            Map<String, Object> m = new HashMap<>();
            m.put("jobTitle", app.getJob().getTitle());
            m.put("company", app.getJob().getCompany().getName());
            m.put("status", app.getStatus().name());
            m.put("appliedAt", app.getAppliedDate());
            jHistory.add(m);
            appliedCount++;
            if (app.getStatus().name().equals("SHORTLISTED")) shortlisted++;
            if (app.getStatus().name().equals("SELECTED")) selected++;
            if (app.getStatus().name().equals("REJECTED")) rejected++;
        }
        List<in.sp.main.Entities.SavedJob> saved = savedJobRepository.findByJobSeekerWithCompany(candidate);
        
        Map<String, Object> jobStats = new HashMap<>();
        jobStats.put("applied", appliedCount);
        jobStats.put("saved", saved.size());
        jobStats.put("shortlisted", shortlisted);
        jobStats.put("selected", selected);
        jobStats.put("rejected", rejected);
        jobStats.put("history", jHistory);
        response.put("jobHistory", jobStats);

        // 8. Profile Activity & Overview
        Map<String, Object> profile = new HashMap<>();
        int completion = 20; // Base
        if (candidate.getSkills() != null && !candidate.getSkills().isEmpty()) completion += 20;
        if (candidate.getEducation() != null) completion += 20;
        if (candidate.getExperience() != null) completion += 20;
        if (candidate.getResumeUploaded() != null) completion += 20;
        profile.put("completion", completion);
        profile.put("skills", candidate.getSkills());
        profile.put("education", candidate.getEducation());
        profile.put("experience", candidate.getExperience());
        response.put("profileActivity", profile);

        // 9. Performance Summary
        Map<String, Object> summary = new HashMap<>();
        summary.put("totalLogins", loginCount);
        summary.put("questionsSolved", totalSolved);
        summary.put("applications", appliedCount);
        summary.put("interviews", interviews.size());
        summary.put("codingAccuracy", codingStats.get("accuracy"));
        response.put("performanceSummary", summary);

        return ResponseEntity.ok(response);
    }
}
