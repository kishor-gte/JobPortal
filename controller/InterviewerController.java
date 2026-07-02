package com.example.demo.controller;

import com.example.demo.dao.*;
import com.example.demo.model.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.List;

@Controller
@RequestMapping("/interviewer")
public class InterviewerController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private InterviewDAO interviewDAO;

    @Autowired
    private FeedbackDAO feedbackDAO;

    @Autowired
    private ResumeDAO resumeDAO;

    @Autowired
    private PerformanceDAO performanceDAO;

    @Autowired
    private AIEvaluationDAO aiEvaluationDAO;

    private User getInterviewer(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user == null || !"INTERVIEWER".equals(user.getRole()))
            return null;
        return user;
    }

    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        User interviewer = getInterviewer(session);
        if (interviewer == null)
            return "redirect:/login";

        List<MockInterview> interviews = interviewDAO.findByInterviewerId(interviewer.getId());
        long scheduledCount = interviews.stream().filter(i -> "SCHEDULED".equals(i.getStatus())).count();
        long completedCount = interviews.stream().filter(i -> "COMPLETED".equals(i.getStatus())).count();

        model.addAttribute("user", interviewer);
        model.addAttribute("interviews", interviews);
        model.addAttribute("scheduledCount", scheduledCount);
        model.addAttribute("completedCount", completedCount);
        model.addAttribute("totalInterviews", interviews.size());
        model.addAttribute("resumes", resumeDAO.findAll());
        model.addAttribute("students", userDAO.findByRole("STUDENT"));
        return "interviewer-dashboard";
    }

    @GetMapping("/schedule-interview")
    public String scheduleInterviewPage(HttpSession session, Model model) {
        User interviewer = getInterviewer(session);
        if (interviewer == null)
            return "redirect:/login";

        model.addAttribute("user", interviewer);
        model.addAttribute("students", userDAO.findByRole("STUDENT"));
        model.addAttribute("interviews", interviewDAO.findByInterviewerId(interviewer.getId()));
        return "schedule-interview";
    }

    @PostMapping("/schedule-interview")
    public String scheduleInterview(@RequestParam Long studentId, @RequestParam String scheduledAt,
            @RequestParam int durationMinutes,
            @RequestParam(required = false) String meetingLink,
            @RequestParam(required = false) String notes,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User interviewer = getInterviewer(session);
        if (interviewer == null)
            return "redirect:/login";

        MockInterview mi = new MockInterview();
        mi.setStudentId(studentId);
        mi.setInterviewerId(interviewer.getId());
        mi.setScheduledAt(scheduledAt);
        mi.setDurationMinutes(durationMinutes);
        mi.setStatus("SCHEDULED");
        mi.setMeetingLink(meetingLink != null && !meetingLink.isEmpty() ? meetingLink
                : "https://meet.smartinterview.com/room-" + System.currentTimeMillis());
        mi.setNotes(notes);
        interviewDAO.save(mi);

        redirectAttributes.addFlashAttribute("success", "Interview scheduled successfully!");
        return "redirect:/interviewer/schedule-interview";
    }

    @PostMapping("/update-interview-status/{id}")
    public String updateInterviewStatus(@PathVariable Long id, @RequestParam String status,
            RedirectAttributes redirectAttributes) {
        interviewDAO.updateStatus(id, status);
        redirectAttributes.addFlashAttribute("success", "Interview status updated!");
        return "redirect:/interviewer/dashboard";
    }

    @GetMapping("/evaluate/{interviewId}")
    public String evaluatePage(@PathVariable Long interviewId, HttpSession session, Model model) {
        User interviewer = getInterviewer(session);
        if (interviewer == null)
            return "redirect:/login";

        MockInterview interview = interviewDAO.findById(interviewId);
        if (interview == null)
            return "redirect:/interviewer/dashboard";

        model.addAttribute("user", interviewer);
        model.addAttribute("interview", interview);
        model.addAttribute("existingFeedback", feedbackDAO.findByInterviewId(interviewId));
        return "evaluate-candidate";
    }

    @PostMapping("/submit-feedback")
    public String submitFeedback(@RequestParam Long interviewId, @RequestParam Long studentId,
            @RequestParam int technicalRating, @RequestParam int communicationRating,
            @RequestParam int problemSolvingRating, @RequestParam int overallRating,
            @RequestParam(required = false) String comments,
            @RequestParam String recommendation,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User interviewer = getInterviewer(session);
        if (interviewer == null)
            return "redirect:/login";

        Feedback feedback = new Feedback();
        feedback.setInterviewId(interviewId);
        feedback.setInterviewerId(interviewer.getId());
        feedback.setStudentId(studentId);
        feedback.setTechnicalRating(technicalRating);
        feedback.setCommunicationRating(communicationRating);
        feedback.setProblemSolvingRating(problemSolvingRating);
        feedback.setOverallRating(overallRating);
        feedback.setComments(comments);
        feedback.setRecommendation(recommendation);
        feedbackDAO.save(feedback);

        // Also create AI evaluation
        AIEvaluation aiEval = new AIEvaluation();
        aiEval.setStudentId(studentId);
        aiEval.setInterviewId(interviewId);
        aiEval.setAnswerAnalysis("Evaluation by " + interviewer.getFullName());
        aiEval.setCommunicationScore(communicationRating);
        aiEval.setTechnicalScore(technicalRating);
        aiEval.setConfidenceScore(problemSolvingRating);
        aiEval.setOverallScore(overallRating);
        aiEval.setStrengths(comments != null ? "Reviewed by interviewer" : "Pending review");
        aiEval.setWeaknesses("Areas noted during interview");
        aiEval.setImprovementSuggestions("Continue practicing and improving on weak areas");
        aiEvaluationDAO.save(aiEval);

        // Update interview status
        interviewDAO.updateStatus(interviewId, "COMPLETED");

        redirectAttributes.addFlashAttribute("success", "Feedback submitted successfully!");
        return "redirect:/interviewer/dashboard";
    }

    @GetMapping("/review-resumes")
    public String reviewResumes(HttpSession session, Model model) {
        User interviewer = getInterviewer(session);
        if (interviewer == null)
            return "redirect:/login";

        model.addAttribute("user", interviewer);
        model.addAttribute("resumes", resumeDAO.findAll());
        return "review-resumes";
    }

    @GetMapping("/download-resume/{id}")
    @ResponseBody
    public ResponseEntity<InputStreamResource> downloadResume(@PathVariable Long id, HttpSession session) {
        User interviewer = getInterviewer(session);
        if (interviewer == null) {
            return ResponseEntity.status(401).build();
        }

        Resume resume = resumeDAO.findById(id);
        if (resume == null) {
            return ResponseEntity.notFound().build();
        }

        File file = new File(resume.getFilePath());
        if (!file.exists()) {
            return ResponseEntity.notFound().build();
        }

        try {
            InputStreamResource resource = new InputStreamResource(new FileInputStream(file));
            return ResponseEntity.ok()
                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resume.getFileName() + "\"")
                    .contentType(MediaType.APPLICATION_PDF)
                    .contentLength(file.length())
                    .body(resource);
        } catch (FileNotFoundException e) {
            return ResponseEntity.notFound().build();
        }
    }
}
