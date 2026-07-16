package in.sp.main.Controllers; // Trigger rebuild


import in.sp.main.Entities.TechPerson;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.StudentAnswer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import jakarta.servlet.http.HttpSession;

import in.sp.main.Services.JobSeekerService;
import in.sp.main.Services.CompanyServices;
import in.sp.main.Services.JobServices;
import in.sp.main.dao.QuestionDAO;
import in.sp.main.dao.InterviewDAO;
import in.sp.main.dao.PerformanceDAO;
import in.sp.main.dao.CategoryDAO;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import java.util.Collections;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.ResponseEntity;
import in.sp.main.Entities.CodingQuestion;
import in.sp.main.Entities.InterviewQuestion;
import in.sp.main.Entities.Category;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/tech")
public class TechDashboardController {
        @RequestMapping(value = "/add-coding-question", method = RequestMethod.GET)
    public String addCodingQuestionPage(HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        model.addAttribute("techPerson", techPerson);
        model.addAttribute("categories", categoryDAO.findAll());
        return "techperson/add-coding-question";
    }

    @RequestMapping(value = "/add-interview-question", method = RequestMethod.GET)
    public String addInterviewQuestionPage(HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        model.addAttribute("techPerson", techPerson);
        model.addAttribute("categories", categoryDAO.findAll());
        return "techperson/add-interview-question";
    }
@RequestMapping(value = "/add-coding-question", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addCodingQuestion(
            @RequestParam String title,
            @RequestParam String difficulty,
            @RequestParam Long categoryId,
            @RequestParam String sampleInput,
            @RequestParam String description,
            @RequestParam String sampleOutput,
            @RequestParam String solution,
            HttpSession session) {
            
        Map<String, Object> response = new HashMap<>();
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) {
            response.put("success", false);
            response.put("message", "Not logged in");
            return ResponseEntity.status(401).body(response);
        }

        try {
            CodingQuestion q = new CodingQuestion();
            q.setTitle(title);
            q.setDescription(description);
            q.setDifficulty(difficulty);
            q.setCategoryId(categoryId);
            q.setSampleInput(sampleInput);
            q.setSampleOutput(sampleOutput);
            q.setSolution(solution);
            q.setCreatedBy(techPerson.getId()); // Using tech person ID

            questionDAO.saveCodingQuestion(q);

            response.put("success", true);
            response.put("message", "Coding question added successfully!");
            
            // Return the question data so it can be appended to the UI
            Map<String, Object> questionData = new HashMap<>();
            questionData.put("id", q.getId());
            questionData.put("title", q.getTitle());
            questionData.put("difficulty", q.getDifficulty());
            questionData.put("categoryId", q.getCategoryId());
            
            // Try to find category name (optional, UI can handle ID)
            try {
                // Not strictly necessary if the UI just needs to display it somehow, 
                // but let's pass back basic data
            } catch(Exception e){}
            
            response.put("question", questionData);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to add question: " + e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }

    @RequestMapping(value = "/add-interview-question", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<Map<String, Object>> addInterviewQuestion(
            @RequestParam String question,
            @RequestParam String questionType,
            @RequestParam String difficulty,
            @RequestParam(required = false) Long categoryId,
            @RequestParam String expectedAnswer,
            HttpSession session) {
            
        Map<String, Object> response = new HashMap<>();
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) {
            response.put("success", false);
            response.put("message", "Not logged in");
            return ResponseEntity.status(401).body(response);
        }

        try {
            InterviewQuestion q = new InterviewQuestion();
            q.setQuestion(question);
            q.setQuestionType(questionType);
            q.setDifficulty(difficulty);
            q.setCategoryId(categoryId);
            q.setExpectedAnswer(expectedAnswer);
            q.setCreatedBy(techPerson.getId());

            questionDAO.saveInterviewQuestion(q);

            response.put("success", true);
            
            Map<String, Object> questionData = new HashMap<>();
            questionData.put("id", q.getId());
            questionData.put("question", q.getQuestion());
            questionData.put("questionType", q.getQuestionType());
            questionData.put("difficulty", q.getDifficulty());
            questionData.put("categoryId", q.getCategoryId());
            
            response.put("question", questionData);
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(500).body(response);
        }
    }

    @Autowired
    private JobSeekerService jobSeekerService;

    @Autowired
    private CompanyServices companyService;

    @Autowired
    private JobServices jobService;

    @Autowired
    private QuestionDAO questionDAO;

    @Autowired
    private InterviewDAO interviewDAO;

    @Autowired
    private PerformanceDAO performanceDAO;

    @Autowired
    private CategoryDAO categoryDAO;

    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String dashboard(HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        model.addAttribute("techPerson", techPerson);
        
        long totalUsers = 0;
        long totalCompanies = 0;
        long totalJobs = 0;
        
        try {
            if (jobSeekerService != null && jobSeekerService.getAllJobSeekers() != null) {
                totalUsers = jobSeekerService.getAllJobSeekers().size();
            }
        } catch (Exception e) {}
        
        try {
            if (companyService != null && companyService.getAllCompanies() != null) {
                totalCompanies = companyService.getAllCompanies().size();
            }
        } catch (Exception e) {}
        
        try {
            if (jobService != null && jobService.getAllJobs() != null) {
                totalJobs = jobService.getAllJobs().size();
            }
        } catch (Exception e) {}
        
        long totalCodingQuestions = 0;
        long totalInterviewQuestions = 0;
        long totalInterviews = 0;
        long completedInterviews = 0;
        
        try {
            if (questionDAO != null) {
                List<in.sp.main.Entities.CodingQuestion> codingQs = questionDAO.findAllCodingQuestions();
                totalCodingQuestions = codingQs != null ? codingQs.size() : 0;
                
                List<in.sp.main.Entities.InterviewQuestion> interviewQs = questionDAO.findAllInterviewQuestions();
                totalInterviewQuestions = interviewQs != null ? interviewQs.size() : 0;
            }
        } catch (Exception e) {}
        
        try {
            if (interviewDAO != null) {
                List<in.sp.main.Entities.MockInterview> allInterviews = interviewDAO.findAll();
                totalInterviews = allInterviews != null ? allInterviews.size() : 0;
                
                if (allInterviews != null) {
                    completedInterviews = allInterviews.stream()
                        .filter(i -> "COMPLETED".equalsIgnoreCase(i.getStatus()))
                        .count();
                }
            }
        } catch (Exception e) {}
        
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalStudents", totalUsers); // Approximated
        model.addAttribute("totalInterviewers", 0); // Need count if necessary
        model.addAttribute("totalCompanies", totalCompanies);
        model.addAttribute("totalJobs", totalJobs);
        model.addAttribute("totalCodingQuestions", totalCodingQuestions);
        model.addAttribute("totalInterviewQuestions", totalInterviewQuestions);
        model.addAttribute("totalCategories", categoryDAO != null ? categoryDAO.countAll() : 0); 
        model.addAttribute("totalInterviews", totalInterviews);
        model.addAttribute("completedInterviews", completedInterviews);
        model.addAttribute("totalApplications", 0); 
        
        try {
            if (jobService != null) {
                model.addAttribute("activeJobs", jobService.getAllActiveJobs());
            } else {
                model.addAttribute("activeJobs", Collections.emptyList());
            }
        } catch (Exception e) {
            model.addAttribute("activeJobs", Collections.emptyList());
        }
        
        try {
            if (jobSeekerService != null) {
                model.addAttribute("recentUsers", jobSeekerService.getAllJobSeekers());
            } else {
                model.addAttribute("recentUsers", Collections.emptyList());
            }
        } catch (Exception e) {
            model.addAttribute("recentUsers", Collections.emptyList());
        }
        
        model.addAttribute("recentApplications", Collections.emptyList());
        
        return "techperson/dashboard";
    }

        @RequestMapping(value = "/manage-users", method = RequestMethod.GET)
    public String manageUsers(@RequestParam(required = false) String search, HttpSession session, Model model) {
        return populateUsersModel(session, model, null, search, "techperson/manage-users");
    }

    @RequestMapping(value = "/manage-users/all", method = RequestMethod.GET)
    public String manageUsersAll(@RequestParam(required = false) String search, HttpSession session, Model model) {
        return populateUsersModel(session, model, null, search, "techperson/manage-users-all");
    }

    @RequestMapping(value = "/manage-users/students", method = RequestMethod.GET)
    public String manageUsersStudents(@RequestParam(required = false) String search, HttpSession session, Model model) {
        return populateUsersModel(session, model, "STUDENT", search, "techperson/manage-users-students");
    }

    @RequestMapping(value = "/manage-users/interviewers", method = RequestMethod.GET)
    public String manageUsersInterviewers(@RequestParam(required = false) String search, HttpSession session, Model model) {
        return populateUsersModel(session, model, "INTERVIEWER", search, "techperson/manage-users-interviewers");
    }

    @RequestMapping(value = "/manage-users/admins", method = RequestMethod.GET)
    public String manageUsersAdmins(@RequestParam(required = false) String search, HttpSession session, Model model) {
        return populateUsersModel(session, model, "ADMIN", search, "techperson/manage-users-admins");
    }

    private String populateUsersModel(HttpSession session, Model model, String role, String search, String viewName) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        model.addAttribute("techPerson", techPerson);
        
        List<JobSeeker> allJobSeekers = jobSeekerService.getAllJobSeekers();
        if (allJobSeekers == null) allJobSeekers = new ArrayList<>();
        
        long studentCount = allJobSeekers.stream().filter(u -> "STUDENT".equals(u.getRole())).count();
        long interviewerCount = allJobSeekers.stream().filter(u -> "INTERVIEWER".equals(u.getRole())).count();
        long adminCount = allJobSeekers.stream().filter(u -> "ADMIN".equals(u.getRole())).count();
        long totalCount = allJobSeekers.size();
        
        model.addAttribute("studentCount", studentCount);
        model.addAttribute("interviewerCount", interviewerCount);
        model.addAttribute("adminCount", adminCount);
        model.addAttribute("totalCount", totalCount);
        
        List<JobSeeker> filteredJobSeekers;
        if (role != null && !role.isEmpty()) {
            filteredJobSeekers = allJobSeekers.stream()
                .filter(u -> role.equals(u.getRole()))
                .collect(java.util.stream.Collectors.toList());
        } else {
            filteredJobSeekers = allJobSeekers;
        }
        
        if (search != null && !search.trim().isEmpty()) {
            String q = search.toLowerCase().trim();
            filteredJobSeekers = filteredJobSeekers.stream()
                .filter(u -> (u.getName() != null && u.getName().toLowerCase().contains(q)) || 
                             (u.getEmail() != null && u.getEmail().toLowerCase().contains(q)))
                .sorted((u1, u2) -> {
                    String n1 = u1.getName() != null ? u1.getName().toLowerCase() : "";
                    String n2 = u2.getName() != null ? u2.getName().toLowerCase() : "";
                    String e1 = u1.getEmail() != null ? u1.getEmail().toLowerCase() : "";
                    String e2 = u2.getEmail() != null ? u2.getEmail().toLowerCase() : "";
                    
                    boolean exact1 = n1.equals(q) || e1.equals(q);
                    boolean exact2 = n2.equals(q) || e2.equals(q);
                    if (exact1 && !exact2) return -1;
                    if (!exact1 && exact2) return 1;
                    
                    boolean starts1 = n1.startsWith(q) || e1.startsWith(q);
                    boolean starts2 = n2.startsWith(q) || e2.startsWith(q);
                    if (starts1 && !starts2) return -1;
                    if (!starts1 && starts2) return 1;
                    
                    return n1.compareTo(n2);
                })
                .collect(java.util.stream.Collectors.toList());
        }
        
        model.addAttribute("jobSeekers", filteredJobSeekers);
        model.addAttribute("selectedRole", role);
        model.addAttribute("searchQuery", search);

        return viewName;
    }

    @RequestMapping(value = "/manage-questions", method = RequestMethod.GET)
    public String manageQuestions(HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        model.addAttribute("techPerson", techPerson);
        
        model.addAttribute("categories", categoryDAO.findAll());
        model.addAttribute("codingQuestions", questionDAO.findAllCodingQuestions());
        model.addAttribute("interviewQuestions", questionDAO.findAllInterviewQuestions());
        
        try {
            List<StudentAnswer> studentAnswers = performanceDAO.findAllStudentAnswers();
            model.addAttribute("studentAnswers", studentAnswers);
            
            Map<String, List<StudentAnswer>> byUser = new HashMap<>();
            Map<String, List<StudentAnswer>> byTopic = new HashMap<>();
            
            for (StudentAnswer a : studentAnswers) {
                String uName = a.getStudentName() != null ? a.getStudentName() : "User " + a.getStudentId();
                byUser.computeIfAbsent(uName, k -> new ArrayList<>()).add(a);
                
                String topic = a.getQuestionType() != null ? a.getQuestionType() + " Questions" : "Unknown Topic";
                byTopic.computeIfAbsent(topic, k -> new ArrayList<>()).add(a);
            }
            
            model.addAttribute("answersByUser", byUser);
            model.addAttribute("answersByTopic", byTopic);
        } catch(Exception e) {
            model.addAttribute("studentAnswers", new ArrayList<>());
            model.addAttribute("answersByUser", new HashMap<>());
            model.addAttribute("answersByTopic", new HashMap<>());
        }

        return "techperson/manage-questions";
    }

    @RequestMapping(value = "/manage-categories", method = RequestMethod.GET)
    public String manageCategories(HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        model.addAttribute("techPerson", techPerson);
        model.addAttribute("categories", categoryDAO.findAll());
        return "techperson/manage-categories";
    }

    @RequestMapping(value = "/add-category", method = RequestMethod.POST)
    public String addCategory(@RequestParam String name, @RequestParam(required = false) String description, 
                              @RequestParam(required = false, defaultValue = "fas fa-folder") String icon, 
                              @RequestParam(required = false, defaultValue = "#19A77B") String color, 
                              HttpSession session, RedirectAttributes redirectAttributes) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        
        Category category = new Category();
        category.setName(name);
        category.setDescription(description);
        category.setIcon(icon);
        category.setColor(color);
        
        int res = categoryDAO.save(category);
        if (res > 0) {
            redirectAttributes.addFlashAttribute("success", "Category added successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to add category");
        }
        return "redirect:/tech/manage-categories";
    }

    @RequestMapping(value = "/delete-category/{id}", method = RequestMethod.POST)
    public String deleteCategory(@PathVariable("id") Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        
        int res = categoryDAO.delete(id);
        if (res > 0) {
            redirectAttributes.addFlashAttribute("success", "Category deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to delete category");
        }
        return "redirect:/tech/manage-categories";
    }

    @RequestMapping(value = "/delete-coding-question/{id}", method = RequestMethod.POST)
    public String deleteCodingQuestion(@PathVariable("id") Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        
        int res = questionDAO.deleteCodingQuestion(id);
        if (res > 0) {
            redirectAttributes.addFlashAttribute("success", "Coding question deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to delete coding question");
        }
        return "redirect:/tech/manage-questions";
    }

    @RequestMapping(value = "/delete-interview-question/{id}", method = RequestMethod.POST)
    public String deleteInterviewQuestion(@PathVariable("id") Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        
        int res = questionDAO.deleteInterviewQuestion(id);
        if (res > 0) {
            redirectAttributes.addFlashAttribute("success", "Interview question deleted successfully");
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to delete interview question");
        }
        return "redirect:/tech/manage-questions";
    }

    @RequestMapping(value = "/results", method = RequestMethod.GET)
    public String results(HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        model.addAttribute("techPerson", techPerson);
        
        try {
            List<StudentAnswer> studentAnswers = performanceDAO.findAllStudentAnswers();
            model.addAttribute("studentAnswers", studentAnswers);
            
            Map<String, List<StudentAnswer>> byUser = new HashMap<>();
            Map<String, List<StudentAnswer>> byTopic = new HashMap<>();
            
            for (StudentAnswer a : studentAnswers) {
                String uName = a.getStudentName() != null ? a.getStudentName() : "User " + a.getStudentId();
                byUser.computeIfAbsent(uName, k -> new ArrayList<>()).add(a);
                
                String topic = a.getQuestionType() != null ? a.getQuestionType() + " Questions" : "Unknown Topic";
                byTopic.computeIfAbsent(topic, k -> new ArrayList<>()).add(a);
            }
            
            model.addAttribute("answersByUser", byUser);
            model.addAttribute("answersByTopic", byTopic);
        } catch(Exception e) {
            model.addAttribute("studentAnswers", new ArrayList<>());
            model.addAttribute("answersByUser", new HashMap<>());
            model.addAttribute("answersByTopic", new HashMap<>());
        }

        return "techperson/results";
    }
    
    @RequestMapping(value = "/ai-evaluation", method = RequestMethod.GET)
    public String aiEvaluationDashboard(@RequestParam(required = false) String search, Model model, HttpSession session) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) return "redirect:/tech/login";
        model.addAttribute("techPerson", techPerson);
        
        try {
            List<in.sp.main.Entities.MockInterview> evals = interviewDAO.findAll();
            
            List<in.sp.main.Entities.MockInterview> completed = evals.stream()
                .filter(e -> "COMPLETED".equalsIgnoreCase(e.getStatus()))
                .collect(java.util.stream.Collectors.toList());
            
            if (search != null && !search.trim().isEmpty()) {
                String query = search.toLowerCase().trim();
                completed = completed.stream()
                    .filter(e -> e.getStudentName() != null && e.getStudentName().toLowerCase().contains(query))
                    .collect(java.util.stream.Collectors.toList());
            }
            
            model.addAttribute("evaluations", completed);
            model.addAttribute("searchQuery", search);
            
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

        return "techperson/ai-evaluation";
    }
}

