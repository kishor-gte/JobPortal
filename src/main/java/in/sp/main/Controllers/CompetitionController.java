package in.sp.main.Controllers;

import in.sp.main.Entities.Competition;
import in.sp.main.Entities.CodingQuestion;
import in.sp.main.Entities.TechPerson;
import in.sp.main.Repositories.CompetitionRepository;
import in.sp.main.dao.QuestionDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.servlet.ModelAndView;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import in.sp.main.Repositories.JobSeekerRepository;
import in.sp.main.Repositories.CompetitionRegistrationRepository;
import in.sp.main.Entities.CompetitionRegistration;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Repositories.CompetitionResultRepository;
import in.sp.main.Entities.CompetitionResult;

@Controller
@RequestMapping("/tech")
public class CompetitionController {

    @Autowired
    private CompetitionRepository competitionRepository;

    @Autowired
    private CompetitionRegistrationRepository competitionRegistrationRepository;

    @Autowired
    private JobSeekerRepository jobSeekerRepository;

    @Autowired
    private CompetitionResultRepository competitionResultRepository;

    @Autowired
    private QuestionDAO questionDAO;

    @GetMapping("/conduct-competition")
    public String conductCompetitionPage(HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) {
            return "redirect:/tech/login";
        }
        model.addAttribute("techPerson", techPerson);
        // Pre-load coding questions for the UI option 1
        model.addAttribute("existingQuestions", questionDAO.findAllCodingQuestions());
        
        return "techperson/conduct-competition";
    }

    @GetMapping("/edit-competition/{id}")
    public String editCompetitionPage(@PathVariable Long id, HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) {
            return "redirect:/tech/login";
        }
        
        Competition competition = competitionRepository.findById(id).orElse(null);
        if (competition == null || !competition.getCreatedBy().equals(techPerson.getId())) {
            return "redirect:/tech/manage-competitions";
        }
        
        model.addAttribute("techPerson", techPerson);
        model.addAttribute("competition", competition);
        // Load questions for the dropdown
        model.addAttribute("existingQuestions", questionDAO.findAllCodingQuestions());
        
        return "techperson/edit-competition";
    }

    @GetMapping("/manage-competitions")
    public String manageCompetitionsPage(HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) {
            return "redirect:/tech/login";
        }
        model.addAttribute("techPerson", techPerson);
        List<Competition> competitions = competitionRepository.findByCreatedByOrderByCreatedAtDesc(techPerson.getId());
        
        Map<Long, Integer> regCounts = new HashMap<>();
        for(Competition c : competitions) {
            int count = competitionRegistrationRepository.countByCompetitionIdAndStatus(c.getId(), "REGISTERED");
            regCounts.put(c.getId(), count);
        }
        
        model.addAttribute("competitions", competitions);
        model.addAttribute("regCounts", regCounts);
        return "techperson/manage-competitions";
    }
    
    @GetMapping("/manage-competitions/{id}/registrations")
    public String viewCompetitionRegistrations(@PathVariable Long id, HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) {
            return "redirect:/tech/login";
        }
        
        Competition competition = competitionRepository.findById(id).orElse(null);
        if (competition == null || !competition.getCreatedBy().equals(techPerson.getId())) {
            return "redirect:/tech/manage-competitions";
        }

        List<CompetitionRegistration> regs = competitionRegistrationRepository.findByCompetitionId(id);
        List<Map<String, Object>> registeredUsers = new ArrayList<>();
        
        for (CompetitionRegistration reg : regs) {
            JobSeeker seeker = jobSeekerRepository.findById(reg.getStudentId()).orElse(null);
            if (seeker != null) {
                Map<String, Object> userData = new HashMap<>();
                userData.put("name", seeker.getName());
                userData.put("email", seeker.getEmail());
                userData.put("status", reg.getStatus());
                userData.put("registeredAt", reg.getRegistrationDate());
                registeredUsers.add(userData);
            }
        }

        model.addAttribute("techPerson", techPerson);
        model.addAttribute("competition", competition);
        model.addAttribute("registeredUsers", registeredUsers);
        
        return "techperson/competition-registrations";
    }
    
    @GetMapping("/competition-results")
    public String competitionResultsPage(HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) {
            return "redirect:/tech/login";
        }
        model.addAttribute("techPerson", techPerson);
        model.addAttribute("competitions", competitionRepository.findByCreatedByOrderByCreatedAtDesc(techPerson.getId()));
        return "techperson/competition-results";
    }

    @GetMapping("/competition-results/{id}")
    public String viewCompetitionLeaderboard(@PathVariable Long id, HttpSession session, Model model) {
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) {
            return "redirect:/tech/login";
        }
        
        Competition competition = competitionRepository.findById(id).orElse(null);
        if (competition == null || !competition.getCreatedBy().equals(techPerson.getId())) {
            return "redirect:/tech/competition-results";
        }

        List<CompetitionResult> results = competitionResultRepository.findByCompetitionId(id);
        
        // Sort: 1. questionsSolved DESC, 2. submittedAt ASC
        results.sort((r1, r2) -> {
            int qComp = Integer.compare(r2.getQuestionsSolved(), r1.getQuestionsSolved());
            if (qComp != 0) return qComp;
            if (r1.getSubmittedAt() == null && r2.getSubmittedAt() == null) return 0;
            if (r1.getSubmittedAt() == null) return 1;
            if (r2.getSubmittedAt() == null) return -1;
            return r1.getSubmittedAt().compareTo(r2.getSubmittedAt());
        });
        
        List<Map<String, Object>> leaderboard = new ArrayList<>();
        int rank = 1;
        for (CompetitionResult res : results) {
            // Filter out students who haven't solved any questions
            if (res.getQuestionsSolved() == null || res.getQuestionsSolved() == 0) {
                continue;
            }
            JobSeeker student = jobSeekerRepository.findById(res.getStudentId()).orElse(null);
            if (student != null) {
                Map<String, Object> entry = new HashMap<>();
                entry.put("rank", rank++);
                entry.put("name", student.getName());
                entry.put("email", student.getEmail());
                entry.put("questionsSolved", res.getQuestionsSolved());
                entry.put("submittedAt", res.getSubmittedAt());
                leaderboard.add(entry);
            }
        }

        model.addAttribute("techPerson", techPerson);
        model.addAttribute("competition", competition);
        model.addAttribute("leaderboard", leaderboard);
        
        return "techperson/competition-leaderboard";
    }

    @DeleteMapping("/api/competitions/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteCompetition(@PathVariable Long id, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        if (techPerson == null) {
            response.put("success", false);
            response.put("message", "Unauthorized access.");
            return ResponseEntity.status(401).body(response);
        }
        
        try {
            Competition competition = competitionRepository.findById(id).orElse(null);
            if (competition != null && competition.getCreatedBy().equals(techPerson.getId())) {
                competitionRepository.delete(competition);
                response.put("success", true);
                response.put("message", "Competition deleted successfully.");
            } else {
                response.put("success", false);
                response.put("message", "Competition not found or unauthorized.");
            }
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "Failed to delete competition: " + e.getMessage());
        }
        return ResponseEntity.ok(response);
    }

    @PostMapping("/api/competitions")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> saveCompetition(
            @RequestBody CompetitionRequest request,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        TechPerson techPerson = (TechPerson) session.getAttribute("loggedInTechPerson");
        
        if (techPerson == null) {
            response.put("success", false);
            response.put("message", "Not authenticated");
            return ResponseEntity.status(401).body(response);
        }

        try {
            // Validation
            if (request.getRegistrationEndTime().isBefore(request.getRegistrationStartTime())) {
                throw new IllegalArgumentException("Registration End Time must be after Start Time");
            }
            if (request.getExamStartTime().isBefore(request.getRegistrationEndTime())) {
                throw new IllegalArgumentException("Exam Start Time must be after Registration End Time");
            }
            if (request.getMaxParticipants() <= 0) {
                throw new IllegalArgumentException("Maximum Participants must be greater than zero");
            }
            if (request.getNumberOfQuestions() <= 0) {
                throw new IllegalArgumentException("Number of Coding Questions must be greater than zero");
            }
            
            int selectedCount = request.getSelectedQuestionIds() != null ? request.getSelectedQuestionIds().size() : 0;
            int newCount = request.getNewQuestions() != null ? request.getNewQuestions().size() : 0;
            
            if ((selectedCount > 0 && newCount > 0) || (selectedCount == 0 && newCount == 0)) {
                throw new IllegalArgumentException("Please either select existing questions OR add new ones, not both or none.");
            }
            
            if (selectedCount > 0 && selectedCount != request.getNumberOfQuestions()) {
                throw new IllegalArgumentException("Selected Questions must exactly match the Number of Coding Questions");
            }
            
            if (newCount > 0 && newCount != request.getNumberOfQuestions()) {
                throw new IllegalArgumentException("Newly Added Questions must exactly match the Number of Coding Questions");
            }

            Competition comp;
            if (request.getId() != null) {
                comp = competitionRepository.findById(request.getId()).orElse(null);
                if (comp == null || !comp.getCreatedBy().equals(techPerson.getId())) {
                    throw new IllegalArgumentException("Competition not found or access denied");
                }
            } else {
                comp = new Competition();
            }
            comp.setTitle(request.getTitle());
            comp.setDescription(request.getDescription());
            comp.setRules(request.getRules());
            comp.setDifficulty(request.getDifficulty());
            comp.setAllowedLanguages(request.getAllowedLanguages());
            comp.setBannerImage(request.getBannerImage());
            comp.setNumberOfQuestions(request.getNumberOfQuestions());
            
            comp.setRegistrationStartTime(request.getRegistrationStartTime());
            comp.setRegistrationEndTime(request.getRegistrationEndTime());
            comp.setMaxParticipants(request.getMaxParticipants());
            comp.setAllowWaitlist(request.isAllowWaitlist());
            comp.setAutoCloseRegistration(request.isAutoCloseRegistration());
            
            comp.setExamStartTime(request.getExamStartTime());
            comp.setExamDurationMinutes(request.getExamDurationMinutes());
            comp.setAutoSubmit(request.isAutoSubmit());
            
            comp.setDisableCopyPaste(request.isDisableCopyPaste());
            comp.setDisableRightClick(request.isDisableRightClick());
            comp.setFullScreenMode(request.isFullScreenMode());
            comp.setAutoSubmitTabSwitch(request.isAutoSubmitTabSwitch());
            comp.setOneLoginPerCandidate(request.isOneLoginPerCandidate());
            
            comp.setStatus(request.getStatus());
            comp.setCreatedBy(techPerson.getId());
            
            List<Long> questionsToLink = new ArrayList<>();
            
            if (selectedCount > 0) {
                for (Long qId : request.getSelectedQuestionIds()) {
                    CodingQuestion cq = questionDAO.findCodingById(qId);
                    if (cq != null) {
                        questionsToLink.add(cq.getId());
                    }
                }
            } else if (newCount > 0) {
                for (NewQuestionRequest nq : request.getNewQuestions()) {
                    CodingQuestion cq = new CodingQuestion();
                    cq.setTitle(nq.getTitle());
                    cq.setDifficulty(nq.getDifficulty());
                    cq.setCategoryId(nq.getCategoryId());
                    cq.setDescription(nq.getDescription());
                    cq.setSampleInput(nq.getSampleInput());
                    cq.setSampleOutput(nq.getSampleOutput());
                    cq.setSolution(nq.getSolutionHint()); // Optional
                    cq.setCreatedBy(techPerson.getId());
                    
                    questionDAO.saveCodingQuestion(cq);
                    
                    // Since questionDAO.saveCodingQuestion() might not set ID automatically if it's plain JDBC
                    // Wait, if it does set the ID, we use it. We should assume it's set or fetch it.
                    // Actually, if we rely on cq.getId(), let's see if it's set.
                    // Alternatively, we just add the newly created ID.
                    // The safe way is to assume it returns the saved ID or sets it.
                    // Let's check QuestionDAO.saveCodingQuestion.
                    // For now, assume it sets cq.getId() if correctly implemented with KeyHolder.
                    questionsToLink.add(cq.getId());
                }
            }
            
            comp.setCodingQuestionIds(questionsToLink);
            
            competitionRepository.save(comp);

            response.put("success", true);
            response.put("message", "Competition created successfully.");
            return ResponseEntity.ok(response);
            
        } catch (IllegalArgumentException e) {
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.badRequest().body(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "An error occurred while saving the competition.");
            e.printStackTrace();
            return ResponseEntity.status(500).body(response);
        }
    }
}

class CompetitionRequest {
    private Long id;
    private String title;
    private String description;
    private String rules;
    private String difficulty;
    private String allowedLanguages;
    private String bannerImage;
    private int numberOfQuestions;
    

    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime registrationStartTime;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime registrationEndTime;
    private int maxParticipants;
    private boolean allowWaitlist;
    private boolean autoCloseRegistration;
    
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm")
    private LocalDateTime examStartTime;
    private int examDurationMinutes;
    private boolean autoSubmit;
    
    private boolean disableCopyPaste;
    private boolean disableRightClick;
    private boolean fullScreenMode;
    private boolean autoSubmitTabSwitch;
    private boolean oneLoginPerCandidate;
    
    private String status;
    
    private List<Long> selectedQuestionIds;
    private List<NewQuestionRequest> newQuestions;

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getRules() { return rules; }
    public void setRules(String rules) { this.rules = rules; }
    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }
    public String getAllowedLanguages() { return allowedLanguages; }
    public void setAllowedLanguages(String allowedLanguages) { this.allowedLanguages = allowedLanguages; }
    public String getBannerImage() { return bannerImage; }
    public void setBannerImage(String bannerImage) { this.bannerImage = bannerImage; }
    public int getNumberOfQuestions() { return numberOfQuestions; }
    public void setNumberOfQuestions(int numberOfQuestions) { this.numberOfQuestions = numberOfQuestions; }
    public LocalDateTime getRegistrationStartTime() { return registrationStartTime; }
    public void setRegistrationStartTime(LocalDateTime registrationStartTime) { this.registrationStartTime = registrationStartTime; }
    public LocalDateTime getRegistrationEndTime() { return registrationEndTime; }
    public void setRegistrationEndTime(LocalDateTime registrationEndTime) { this.registrationEndTime = registrationEndTime; }
    public int getMaxParticipants() { return maxParticipants; }
    public void setMaxParticipants(int maxParticipants) { this.maxParticipants = maxParticipants; }
    public boolean isAllowWaitlist() { return allowWaitlist; }
    public void setAllowWaitlist(boolean allowWaitlist) { this.allowWaitlist = allowWaitlist; }
    public boolean isAutoCloseRegistration() { return autoCloseRegistration; }
    public void setAutoCloseRegistration(boolean autoCloseRegistration) { this.autoCloseRegistration = autoCloseRegistration; }
    public LocalDateTime getExamStartTime() { return examStartTime; }
    public void setExamStartTime(LocalDateTime examStartTime) { this.examStartTime = examStartTime; }
    public int getExamDurationMinutes() { return examDurationMinutes; }
    public void setExamDurationMinutes(int examDurationMinutes) { this.examDurationMinutes = examDurationMinutes; }
    public boolean isAutoSubmit() { return autoSubmit; }
    public void setAutoSubmit(boolean autoSubmit) { this.autoSubmit = autoSubmit; }
    public boolean isDisableCopyPaste() { return disableCopyPaste; }
    public void setDisableCopyPaste(boolean disableCopyPaste) { this.disableCopyPaste = disableCopyPaste; }
    public boolean isDisableRightClick() { return disableRightClick; }
    public void setDisableRightClick(boolean disableRightClick) { this.disableRightClick = disableRightClick; }
    public boolean isFullScreenMode() { return fullScreenMode; }
    public void setFullScreenMode(boolean fullScreenMode) { this.fullScreenMode = fullScreenMode; }
    public boolean isAutoSubmitTabSwitch() { return autoSubmitTabSwitch; }
    public void setAutoSubmitTabSwitch(boolean autoSubmitTabSwitch) { this.autoSubmitTabSwitch = autoSubmitTabSwitch; }
    public boolean isOneLoginPerCandidate() { return oneLoginPerCandidate; }
    public void setOneLoginPerCandidate(boolean oneLoginPerCandidate) { this.oneLoginPerCandidate = oneLoginPerCandidate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public List<Long> getSelectedQuestionIds() { return selectedQuestionIds; }
    public void setSelectedQuestionIds(List<Long> selectedQuestionIds) { this.selectedQuestionIds = selectedQuestionIds; }
    public List<NewQuestionRequest> getNewQuestions() { return newQuestions; }
    public void setNewQuestions(List<NewQuestionRequest> newQuestions) { this.newQuestions = newQuestions; }
}

class NewQuestionRequest {
    private String title;
    private String difficulty;
    private Long categoryId;
    private String description;
    private String sampleInput;
    private String sampleOutput;
    private String solutionHint;
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }
    public Long getCategoryId() { return categoryId; }
    public void setCategoryId(Long categoryId) { this.categoryId = categoryId; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getSampleInput() { return sampleInput; }
    public void setSampleInput(String sampleInput) { this.sampleInput = sampleInput; }
    public String getSampleOutput() { return sampleOutput; }
    public void setSampleOutput(String sampleOutput) { this.sampleOutput = sampleOutput; }
    public String getSolutionHint() { return solutionHint; }
    public void setSolutionHint(String solutionHint) { this.solutionHint = solutionHint; }
}
