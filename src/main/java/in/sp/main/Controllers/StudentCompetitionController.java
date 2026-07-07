package in.sp.main.Controllers;

import in.sp.main.Entities.Competition;
import in.sp.main.Entities.CompetitionRegistration;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.CodingQuestion;
import in.sp.main.Entities.CompetitionResult;
import in.sp.main.Entities.CompetitionSubmission;
import in.sp.main.Repositories.CompetitionRegistrationRepository;
import in.sp.main.Repositories.CompetitionRepository;
import in.sp.main.dao.QuestionDAO;
import in.sp.main.Repositories.CompetitionResultRepository;
import in.sp.main.Repositories.CompetitionSubmissionRepository;
import in.sp.main.Repositories.JobSeekerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.servlet.http.HttpSession;

import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ArrayList;
import java.util.Optional;

@Controller
@RequestMapping("/student/coding-competitions")
public class StudentCompetitionController {

    @Autowired
    private CompetitionRepository competitionRepository;

    @Autowired
    private CompetitionRegistrationRepository registrationRepository;
    
    @Autowired
    private CompetitionResultRepository resultRepository;

    @Autowired
    private CompetitionSubmissionRepository submissionRepository;

    @Autowired
    private JobSeekerRepository jobSeekerRepository;

    @Autowired
    private QuestionDAO questionDAO;

    @Autowired
    private HackerrankController hackerrankController;

    @GetMapping
    public String codingCompetitionsDashboard(HttpSession session, Model model) {
        JobSeeker student = (JobSeeker) session.getAttribute("jobSeeker");
        if (student == null) {
            return "redirect:/jobSeekers/login";
        }

        List<Competition> publishedCompetitions = competitionRepository.findByStatusOrderByCreatedAtDesc("PUBLISHED");
        List<CompetitionRegistration> studentRegistrations = registrationRepository.findByStudentId(student.getId());
        List<CompetitionResult> results = resultRepository.findByStudentId(student.getId());
        
        List<Long> completedCompetitionIds = new ArrayList<>();
        if (results != null) {
            for (CompetitionResult res : results) {
                completedCompetitionIds.add(res.getCompetitionId());
            }
        }
        
        model.addAttribute("student", student);
        model.addAttribute("allCompetitions", publishedCompetitions);
        model.addAttribute("studentRegistrations", studentRegistrations);
        model.addAttribute("completedCompetitionIds", completedCompetitionIds);

        return "jobSeekers/coding-competitions";
    }

    @PostMapping("/register")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> registerForCompetition(@RequestParam Long competitionId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();
        JobSeeker student = (JobSeeker) session.getAttribute("jobSeeker");
        
        if (student == null) {
            response.put("success", false);
            response.put("message", "User not logged in.");
            return ResponseEntity.status(401).body(response);
        }

        Competition comp = competitionRepository.findById(competitionId).orElse(null);
        if (comp == null) {
            response.put("success", false);
            response.put("message", "Competition not found.");
            return ResponseEntity.badRequest().body(response);
        }

        if (!"PUBLISHED".equals(comp.getStatus())) {
            response.put("success", false);
            response.put("message", "Competition is not available for registration.");
            return ResponseEntity.badRequest().body(response);
        }

        LocalDateTime now = LocalDateTime.now();
        if (now.isBefore(comp.getRegistrationStartTime())) {
            response.put("success", false);
            response.put("message", "Registration has not opened yet.");
            return ResponseEntity.badRequest().body(response);
        }

        if (now.isAfter(comp.getRegistrationEndTime())) {
            response.put("success", false);
            response.put("message", "Registration is closed.");
            return ResponseEntity.badRequest().body(response);
        }

        boolean alreadyRegistered = registrationRepository.existsByStudentIdAndCompetitionId(student.getId(), comp.getId());
        if (alreadyRegistered) {
            response.put("success", false);
            response.put("message", "You are already registered or waitlisted for this competition.");
            return ResponseEntity.badRequest().body(response);
        }

        int currentRegistered = registrationRepository.countByCompetitionIdAndStatus(comp.getId(), "REGISTERED");
        
        String regStatus = "REGISTERED";
        String successMessage = "Successfully registered for the competition.";

        if (currentRegistered >= comp.getMaxParticipants()) {
            if (comp.isAllowWaitlist()) {
                regStatus = "WAITLISTED";
                successMessage = "You have been added to the waitlist.";
            } else {
                response.put("success", false);
                response.put("message", "Registration Closed. Competition is Full.");
                return ResponseEntity.badRequest().body(response);
            }
        }

        CompetitionRegistration reg = new CompetitionRegistration();
        reg.setStudentId(student.getId());
        reg.setCompetitionId(comp.getId());
        reg.setRegistrationDate(now);
        reg.setStatus(regStatus);

        registrationRepository.save(reg);

        response.put("success", true);
        response.put("message", successMessage);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/rules/{id}")
    public String viewRules(@PathVariable Long id, HttpSession session, Model model) {
        JobSeeker student = (JobSeeker) session.getAttribute("jobSeeker");
        if (student == null) {
            return "redirect:/jobSeekers/login";
        }

        Competition comp = competitionRepository.findById(id).orElse(null);
        if (comp == null) {
            return "redirect:/student/coding-competitions";
        }

        boolean registered = registrationRepository.existsByStudentIdAndCompetitionId(student.getId(), id);
        if (!registered) {
            return "redirect:/student/coding-competitions";
        }

        model.addAttribute("competition", comp);
        return "jobSeekers/competition-rules";
    }

    @GetMapping("/{id}/start")
    public String startCompetitionExam(@PathVariable Long id, HttpSession session, Model model) {
        JobSeeker student = (JobSeeker) session.getAttribute("jobSeeker");
        if (student == null) {
            return "redirect:/jobSeekers/login";
        }

        Competition comp = competitionRepository.findById(id).orElse(null);
        if (comp == null || !"PUBLISHED".equals(comp.getStatus())) {
            return "redirect:/student/coding-competitions";
        }

        boolean registered = registrationRepository.existsByStudentIdAndCompetitionId(student.getId(), id);
        if (!registered) {
            return "redirect:/student/coding-competitions";
        }

        LocalDateTime now = LocalDateTime.now();
        if (now.isBefore(comp.getExamStartTime())) {
            return "redirect:/student/coding-competitions?error=ExamHasNotStarted";
        }

        LocalDateTime examEndTime = comp.getExamStartTime().plusMinutes(comp.getExamDurationMinutes());
        if (now.isAfter(examEndTime)) {
            return "redirect:/student/coding-competitions?error=ExamHasEnded";
        }

        boolean alreadySubmitted = resultRepository.existsByCompetitionIdAndStudentId(id, student.getId());
        if (alreadySubmitted) {
            return "redirect:/student/coding-competitions?error=ExamAlreadySubmitted";
        }

        long remainingSeconds = ChronoUnit.SECONDS.between(now, examEndTime);
        
        List<CodingQuestion> questions = new ArrayList<>();
        if (comp.getCodingQuestionIds() != null) {
            for (Long qId : comp.getCodingQuestionIds()) {
                CodingQuestion cq = questionDAO.findCodingById(qId);
                if (cq != null) {
                    questions.add(cq);
                }
            }
        }
        
        List<CompetitionSubmission> submissions = submissionRepository.findByCompetitionIdAndStudentId(id, student.getId());
        Map<Long, String> savedCodes = new HashMap<>();
        Map<Long, String> savedLanguages = new HashMap<>();
        for (CompetitionSubmission sub : submissions) {
            savedCodes.put(sub.getQuestionId(), sub.getSubmittedCode());
            savedLanguages.put(sub.getQuestionId(), sub.getProgrammingLanguage());
        }

        model.addAttribute("competition", comp);
        model.addAttribute("questions", questions);
        model.addAttribute("remainingSeconds", remainingSeconds);
        model.addAttribute("savedCodes", savedCodes);
        model.addAttribute("savedLanguages", savedLanguages);
        
        return "jobSeekers/competition-exam";
    }
    
    @PostMapping("/{id}/run-code")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> runCode(@PathVariable Long id, @RequestBody Map<String, String> payload, HttpSession session) {
        JobSeeker student = (JobSeeker) session.getAttribute("jobSeeker");
        if (student == null) {
            return ResponseEntity.status(401).body(Map.of("success", false, "message", "Not logged in"));
        }
        
        String code = payload.get("code");
        String language = payload.getOrDefault("language", "java");
        String stdin = payload.get("stdin");
        
        Map<String, Object> result = new HashMap<>();
        try {
            Map<String, Object> execResult = hackerrankController.executeCodeWithWandbox(code, stdin, language);
            result.put("success", true);
            result.put("output", execResult.get("stdout"));
            result.put("stderr", execResult.get("stderr"));
            result.put("exitCode", execResult.get("exitCode"));
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
        }
        return ResponseEntity.ok(result);
    }
    
    @PostMapping("/{id}/submit-question")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> submitQuestion(@PathVariable Long id, @RequestBody Map<String, String> payload, HttpSession session) {
        JobSeeker student = (JobSeeker) session.getAttribute("jobSeeker");
        if (student == null) {
            return ResponseEntity.status(401).body(Map.of("success", false, "message", "Not logged in"));
        }
        
        Long questionId = Long.parseLong(payload.get("questionId"));
        String code = payload.get("code");
        String language = payload.getOrDefault("language", "java");
        
        Competition comp = competitionRepository.findById(id).orElse(null);
        if (comp == null) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "Competition not found"));
        }
        
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime examEndTime = comp.getExamStartTime().plusMinutes(comp.getExamDurationMinutes());
        if (now.isAfter(examEndTime)) {
             return ResponseEntity.badRequest().body(Map.of("success", false, "message", "Exam has already ended"));
        }
        
        CodingQuestion cq = questionDAO.findCodingById(questionId);
        boolean isCorrect = false;
        
        if (cq != null) {
            try {
                isCorrect = hackerrankController.executeAndValidateCode(code, cq.getSampleOutput(), cq.getSampleInput(), language);
            } catch (Exception e) {
                // Keep as incorrect if execution fails
            }
        }
        
        Optional<CompetitionSubmission> existingOpt = submissionRepository.findByCompetitionIdAndStudentIdAndQuestionId(id, student.getId(), questionId);
        CompetitionSubmission sub = existingOpt.orElse(new CompetitionSubmission());
        
        sub.setCompetitionId(id);
        sub.setStudentId(student.getId());
        sub.setQuestionId(questionId);
        sub.setSubmittedCode(code);
        sub.setProgrammingLanguage(language);
        sub.setStatus(isCorrect ? "Correct" : "Incorrect");
        sub.setSubmissionTime(now);
        
        submissionRepository.save(sub);
        
        return ResponseEntity.ok(Map.of("success", true, "isCorrect", isCorrect));
    }
    
    @PostMapping("/{id}/finish-exam")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> finishExam(@PathVariable Long id, HttpSession session) {
        JobSeeker student = (JobSeeker) session.getAttribute("jobSeeker");
        if (student == null) {
            return ResponseEntity.status(401).body(Map.of("success", false, "message", "Not logged in"));
        }
        
        Competition comp = competitionRepository.findById(id).orElse(null);
        if (comp == null) {
            return ResponseEntity.badRequest().body(Map.of("success", false, "message", "Competition not found"));
        }
        
        if (resultRepository.existsByCompetitionIdAndStudentId(id, student.getId())) {
             return ResponseEntity.badRequest().body(Map.of("success", false, "message", "Exam already submitted"));
        }
        
        List<CompetitionSubmission> submissions = submissionRepository.findByCompetitionIdAndStudentId(id, student.getId());
        int correctCount = 0;
        
        // Count unique correctly solved questions
        Map<Long, Boolean> questionStatus = new HashMap<>();
        for (CompetitionSubmission sub : submissions) {
            if ("Correct".equals(sub.getStatus())) {
                questionStatus.put(sub.getQuestionId(), true);
            }
        }
        correctCount = questionStatus.size();
        
        LocalDateTime now = LocalDateTime.now();
        
        CompetitionResult result = new CompetitionResult();
        result.setCompetitionId(id);
        result.setStudentId(student.getId());
        result.setQuestionsSolved(correctCount);
        result.setSubmittedAt(now);
        
        resultRepository.save(result);
        
        return ResponseEntity.ok(Map.of("success", true));
    }
    
    @GetMapping("/history")
    public String competitionHistory(HttpSession session, Model model) {
        JobSeeker student = (JobSeeker) session.getAttribute("jobSeeker");
        if (student == null) {
            return "redirect:/jobSeekers/login";
        }

        List<CompetitionRegistration> registrations = registrationRepository.findByStudentId(student.getId());
        List<Map<String, Object>> historyList = new ArrayList<>();

        for (CompetitionRegistration reg : registrations) {
            Competition comp = competitionRepository.findById(reg.getCompetitionId()).orElse(null);
            if (comp != null) {
                Map<String, Object> historyItem = new HashMap<>();
                historyItem.put("competition", comp);
                
                Optional<CompetitionResult> resultOpt = resultRepository.findByCompetitionIdAndStudentId(comp.getId(), student.getId());
                if (resultOpt.isPresent()) {
                    historyItem.put("status", "Completed");
                    historyItem.put("result", resultOpt.get());
                } else {
                    LocalDateTime examEndTime = comp.getExamStartTime().plusMinutes(comp.getExamDurationMinutes());
                    if (LocalDateTime.now().isAfter(examEndTime)) {
                        historyItem.put("status", "Missed");
                    } else {
                        historyItem.put("status", "Registered");
                    }
                }
                historyList.add(historyItem);
            }
        }

        model.addAttribute("historyList", historyList);
        return "jobSeekers/competition-history";
    }

    @GetMapping("/{id}/result")
    public String viewResult(@PathVariable Long id, HttpSession session, Model model) {
        JobSeeker student = (JobSeeker) session.getAttribute("jobSeeker");
        if (student == null) {
            return "redirect:/jobSeekers/login";
        }

        Competition comp = competitionRepository.findById(id).orElse(null);
        if (comp == null) {
            return "redirect:/student/coding-competitions/history";
        }

        CompetitionResult myResult = resultRepository.findByCompetitionIdAndStudentId(id, student.getId()).orElse(null);
        if (myResult == null) {
            return "redirect:/student/coding-competitions/history";
        }

        List<CompetitionResult> leaderboard = resultRepository.findByCompetitionIdOrderByQuestionsSolvedDescSubmittedAtAsc(id);
        
        List<Map<String, Object>> leaderboardDetails = new ArrayList<>();
        for (CompetitionResult res : leaderboard) {
            JobSeeker js = jobSeekerRepository.findById(res.getStudentId()).orElse(null);
            Map<String, Object> item = new HashMap<>();
            item.put("result", res);
            item.put("studentName", js != null ? js.getName() : "Unknown");
            leaderboardDetails.add(item);
        }

        long timeTakenSeconds = ChronoUnit.SECONDS.between(comp.getExamStartTime(), myResult.getSubmittedAt());
        if(timeTakenSeconds < 0) timeTakenSeconds = 0;
        long hours = timeTakenSeconds / 3600;
        long minutes = (timeTakenSeconds % 3600) / 60;
        long seconds = timeTakenSeconds % 60;
        String timeTakenStr = String.format("%02d:%02d:%02d", hours, minutes, seconds);

        model.addAttribute("competition", comp);
        model.addAttribute("myResult", myResult);
        model.addAttribute("timeTaken", timeTakenStr);
        model.addAttribute("leaderboard", leaderboardDetails);

        return "jobSeekers/competition-result";
    }
}
