package in.sp.main.Controllers;

import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import in.sp.main.Entities.AssessmentInvitation;
import in.sp.main.Entities.AssessmentQuestion;
import in.sp.main.Entities.AssessmentResult;
import in.sp.main.Repositories.AssessmentInvitationRepository;
import in.sp.main.Repositories.AssessmentQuestionRepository;
import in.sp.main.Repositories.AssessmentResultRepository;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/assessment")
public class SkillAssessmentController {

    @Autowired
    private AssessmentQuestionRepository questionRepo;

    @Autowired
    private AssessmentInvitationRepository invitationRepo;

    @Autowired
    private AssessmentResultRepository resultRepo;

    // Admin → Assign Badge Test
    @RequestMapping(value = "/admin/assign-badge", method = RequestMethod.POST)
    public String assignBadge(@RequestParam Long jobSeekerId, @RequestParam String skill) {
        AssessmentInvitation invite = new AssessmentInvitation();
        invite.setJobSeekerId(jobSeekerId);
        invite.setSkill(skill);
        invite.setType("BADGE");
        invite.setStatus("SENT");
        invite.setSentAt(LocalDateTime.now());
        invitationRepo.save(invite);
        return "redirect:/admin/skill-invites";
    }

    // Recruiter → Send Job Assessment
    @RequestMapping(value = "/recruiter/send-job-invite", method = RequestMethod.POST)
    public String sendJobInvite(@RequestParam Long jobSeekerId,
                                @RequestParam Long jobId,
                                @RequestParam String skill,
                                HttpSession session) {
        Long recruiterId = (Long) session.getAttribute("recruiterId");

        AssessmentInvitation invite = new AssessmentInvitation();
        invite.setJobSeekerId(jobSeekerId);
        invite.setSkill(skill);
        invite.setRecruiterId(recruiterId);
        invite.setJobId(jobId);
        invite.setType("JOB");
        invite.setStatus("SENT");
        invite.setSentAt(LocalDateTime.now());
        invitationRepo.save(invite);
        return "redirect:/recruiter/dashboard";
    }

    // Jobseeker → View Pending Tests
	/*
	 * @RequestMapping("/my-invites") public String viewMyInvites(Model model,
	 * HttpSession session) { Long jobSeekerId = (Long)
	 * session.getAttribute("jobSeekerId"); List<AssessmentInvitation> invites =
	 * invitationRepo.findByJobSeekerIdAndStatus(jobSeekerId, "SENT");
	 * model.addAttribute("invites", invites); return
	 * "/assessments/jobseeker-assessments"; // JSP view }
	 */

    @RequestMapping(value = "/my-invites", method = RequestMethod.GET)
    public String viewMyInvites(Model model, HttpSession session) {
        Long jobSeekerId = (Long) session.getAttribute("jobSeekerId");

        if (jobSeekerId == null) {
            return "redirect:/jobSeekers/login"; // or show error page
        }
        System.out.println("jobSeekerId in session = " + session.getAttribute("jobSeekerId"));

        List<AssessmentInvitation> invites = invitationRepo.findByJobSeekerIdAndStatus(jobSeekerId, "SENT");
        model.addAttribute("invites", invites);
        return "assessments/jobseeker-assessments";
    }
    // to take skill batch test
    @RequestMapping(value = "/available-badges", method = RequestMethod.GET)
    public String showAvailableBadgeTests(Model model, HttpSession session) {
        // Check if user is logged in
        Long jobSeekerId = (Long) session.getAttribute("jobSeekerId");
        if (jobSeekerId == null) {
            return "redirect:/jobSeekers/login";
        }
        
        // Get available badge skills (ADMIN type)
        List<String> skills = questionRepo.findDistinctSkillsBySourceType("ADMIN");
        model.addAttribute("skills", skills);
        
        // Get all of the job seeker's assessment results
        List<AssessmentResult> allResults = resultRepo.findByJobSeekerId(jobSeekerId);
        model.addAttribute("allResults", allResults);
        
        // Calculate stats for each result
        for (AssessmentResult result : allResults) {
            int total = result.getTotalQuestions();
            int correct = result.getCorrectAnswers();
            int wrong = total - correct;
            double percentage = total > 0 ? (correct * 100.0 / total) : 0;
            
            // Add computed attributes (will be accessible in JSP)
            result.setPercentageScore(percentage);
            result.setWrongAnswers(wrong);
        }
        
        System.out.println("Job seeker " + jobSeekerId + " has " + allResults.size() + " assessment results");
        
        return "assessments/self-badge-list";
    }
//test for skill badge
    @RequestMapping(value = "/start-badge-test", method = RequestMethod.GET)
    public String startSelfBadgeTest(@RequestParam String skill, Model model, HttpSession session) {
        Long jobSeekerId = (Long) session.getAttribute("jobSeekerId");
        if (jobSeekerId == null) return "redirect:/jobSeekers/login";

        boolean alreadyTaken = resultRepo.existsByJobSeekerIdAndSkillAndType(jobSeekerId, skill, "BADGE");
        if (alreadyTaken) {
            model.addAttribute("message", "You've already taken this badge test.");
            return "redirect:/assessment/badge-result?skill=" + skill;
        }

        List<AssessmentQuestion> questions = questionRepo.findBySkillAndSourceType(skill, "ADMIN");
        Collections.shuffle(questions);
        model.addAttribute("questions", questions);
        model.addAttribute("skill", skill);
        return "assessments/self-take-assessment";
    }
//submit badge test
    @RequestMapping(value = "/submit-badge-test", method = RequestMethod.POST)
    public String submitSelfBadgeTest(@RequestParam String skill,
                                      @RequestParam Map<String, String> allParams,
                                      HttpSession session) {
        Long jobSeekerId = (Long) session.getAttribute("jobSeekerId");
        if (jobSeekerId == null) return "redirect:/jobSeekers/login";

        List<AssessmentQuestion> questions = questionRepo.findBySkillAndSourceType(skill, "ADMIN");

        int correct = 0;
        for (AssessmentQuestion q : questions) {
            String answer = allParams.get("q_" + q.getId());
            if (answer != null && answer.equalsIgnoreCase(q.getCorrectOption())) {
                correct++;
            }
        }

        AssessmentResult result = new AssessmentResult();
        result.setJobSeekerId(jobSeekerId);
        result.setSkill(skill);
        result.setType("BADGE");
        result.setTotalQuestions(questions.size());
        result.setCorrectAnswers(correct);
        result.setSubmittedAt(LocalDateTime.now());
        resultRepo.save(result);

        return "redirect:/assessment/badge-result?skill=" + skill;

    }

    @RequestMapping(value = "/badge-result", method = RequestMethod.GET)
    public String viewBadgeResult(@RequestParam String skill, HttpSession session, Model model) {
        Long jobSeekerId = (Long) session.getAttribute("jobSeekerId");
        if (jobSeekerId == null) return "redirect:/jobSeekers/login";

        AssessmentResult result = resultRepo.findTopByJobSeekerIdAndSkillAndTypeOrderBySubmittedAtDesc(
                jobSeekerId, skill, "BADGE");

        if (result == null) {
            model.addAttribute("message", "No result found for this badge.");
            return "assessments/badge-result";
        }

        double percentage = (result.getCorrectAnswers() * 100.0) / result.getTotalQuestions();
        String badge;

        if (percentage < 60) {
            badge = "Fail";
        } else if (percentage < 70) {
            badge = "Bronze";
        } else if (percentage < 85) {
            badge = "Silver";
        } else {
            badge = "Gold";
        }

        model.addAttribute("skill", skill);
        model.addAttribute("result", result);
        model.addAttribute("percentage", String.format("%.2f", percentage));
        model.addAttribute("badge", badge);

        return "assessments/badge-result";
    }
    
    
    
    // Jobseeker → Start Test
    @RequestMapping(value = "/start-test/{inviteId}", method = RequestMethod.GET)
    public String startTest(@PathVariable Long inviteId, Model model) {
        AssessmentInvitation invite = invitationRepo.findById(inviteId).orElse(null);
        if (invite == null) return "error";

        List<AssessmentQuestion> questions;
        if ("BADGE".equals(invite.getType())) {
            questions = questionRepo.findBySkillAndSourceType(invite.getSkill(), "ADMIN");
        } else {
            // For JOB type assessments, fetch by skill, sourceType, and jobId
            // Try with recruiterId first, if empty try without it
            questions = questionRepo.findBySkillAndSourceTypeAndJobIdAndRecruiterId(
                invite.getSkill(), "RECRUITER", invite.getJobId(), invite.getRecruiterId());
            
            // If no questions found with recruiterId, try without it
            if (questions.isEmpty() && invite.getRecruiterId() != null) {
                questions = questionRepo.findBySkillAndSourceTypeAndJobId(
                    invite.getSkill(), "RECRUITER", invite.getJobId());
            }
        }

        // Add debug logging
        System.out.println("Assessment Test - Invite ID: " + inviteId);
        System.out.println("Assessment Test - Skill: " + invite.getSkill());
        System.out.println("Assessment Test - Job ID: " + invite.getJobId());
        System.out.println("Assessment Test - Recruiter ID: " + invite.getRecruiterId());
        System.out.println("Assessment Test - Questions found: " + questions.size());
        
        Collections.shuffle(questions);
        model.addAttribute("questions", questions);
        model.addAttribute("invite", invite);
        return "assessments/take-assessment"; // JSP view
    }

    // Jobseeker → Submit Answers
    @RequestMapping(value = "/submit-test", method = RequestMethod.POST)
    public String submitTest(@RequestParam Long inviteId,
                             @RequestParam Map<String, String> allParams,
                             HttpSession session,
                             Model model) {

        AssessmentInvitation invite = invitationRepo.findById(inviteId).orElse(null);
        if (invite == null) return "error";

        List<AssessmentQuestion> questions;
        if ("BADGE".equals(invite.getType())) {
            questions = questionRepo.findBySkillAndSourceType(invite.getSkill(), "ADMIN");
        } else {
            // Try with recruiterId first, then without it
            questions = questionRepo.findBySkillAndSourceTypeAndJobIdAndRecruiterId(
                invite.getSkill(), "RECRUITER", invite.getJobId(), invite.getRecruiterId());
            
            if (questions.isEmpty() && invite.getRecruiterId() != null) {
                questions = questionRepo.findBySkillAndSourceTypeAndJobId(
                    invite.getSkill(), "RECRUITER", invite.getJobId());
            }
        }

        int correct = 0;
        int attempted = 0;
        for (AssessmentQuestion q : questions) {
            String answer = allParams.get("q_" + q.getId());
            if (answer != null && !answer.isEmpty()) {
                attempted++;
                if (answer.equalsIgnoreCase(q.getCorrectOption())) {
                    correct++;
                }
            }
        }
        
        int wrong = attempted - correct;
        int totalQuestions = questions.size();
        double percentage = totalQuestions > 0 ? (correct * 100.0 / totalQuestions) : 0;

        AssessmentResult result = new AssessmentResult();
        result.setJobSeekerId(invite.getJobSeekerId());
        result.setRecruiterId(invite.getRecruiterId());
        result.setJobId(invite.getJobId());
        result.setSkill(invite.getSkill());
        result.setType(invite.getType());
        result.setTotalQuestions(totalQuestions);
        result.setCorrectAnswers(correct);
        result.setSubmittedAt(LocalDateTime.now());
        resultRepo.save(result);

        invite.setStatus("COMPLETED");
        invitationRepo.save(invite);
        
        System.out.println("=== ASSESSMENT SUBMITTED ===");
        System.out.println("Invite ID: " + inviteId);
        System.out.println("Total Questions: " + totalQuestions);
        System.out.println("Attempted: " + attempted);
        System.out.println("Correct: " + correct);
        System.out.println("Wrong: " + wrong);
        System.out.println("Percentage: " + String.format("%.1f", percentage) + "%");
        System.out.println("=== END ===");

        // Redirect to result page
        return "redirect:/assessment/result/" + result.getId();
    }
    
    // View assessment result
    @RequestMapping(value = "/result/{resultId}", method = RequestMethod.GET)
    public String viewAssessmentResult(@PathVariable Long resultId, Model model) {
        AssessmentResult result = resultRepo.findById(resultId).orElse(null);
        if (result == null) return "error";
        
        int totalQuestions = result.getTotalQuestions();
        int correct = result.getCorrectAnswers();
        int wrong = totalQuestions - correct;
        double percentage = totalQuestions > 0 ? (correct * 100.0 / totalQuestions) : 0;
        
        model.addAttribute("result", result);
        model.addAttribute("totalQuestions", totalQuestions);
        model.addAttribute("correct", correct);
        model.addAttribute("wrong", wrong);
        model.addAttribute("percentage", percentage); // Pass as double, not String
        
        return "assessments/job-assessment-result";
    }

    // Recruiter → View Results
    @RequestMapping(value = "/results/{jobId}", method = RequestMethod.GET)
    public String viewJobResults(@PathVariable Long jobId, Model model, HttpSession session) {
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        List<AssessmentResult> results = resultRepo.findByRecruiterIdAndJobId(recruiterId, jobId);
        model.addAttribute("results", results);
        return "/assessments/recruiter-results";
    }

    // Admin → View Badge Results
    @RequestMapping(value = "/badge-results", method = RequestMethod.GET)
    public String viewBadgeResults(Model model) {
        List<AssessmentResult> results = resultRepo.findByType("BADGE");
        model.addAttribute("results", results);
        return "/assessments/admin-skill-results";
    }
}
