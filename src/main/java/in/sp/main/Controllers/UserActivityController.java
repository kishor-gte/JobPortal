package in.sp.main.Controllers;

import in.sp.main.Entities.Admin;
import in.sp.main.Entities.Company;
import in.sp.main.Entities.Recruiter;
import in.sp.main.Entities.UserActivity;
import in.sp.main.Enums.ActivityType;
import in.sp.main.Services.UserActivityService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import in.sp.main.dto.CandidateActivityDTO;
import in.sp.main.dto.CompanyActivityStatsDTO;
import in.sp.main.Enums.ApplicationStatus;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Repositories.JobSeekerRepository;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.LocalDate;

@Controller
public class UserActivityController {

    @Autowired
    private UserActivityService userActivityService;

    @Autowired
    private JobSeekerRepository jobSeekerRepository;

    @GetMapping({"/admin/activities", "/admin/activity-logs"})
    public String viewAdminActivities(
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) String userEmail,
            @RequestParam(required = false) ActivityType activityType,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            Model model, HttpSession session) {

        Admin loggedInAdmin = (Admin) session.getAttribute("loggedInAdmin");
        if (loggedInAdmin == null) {
            return "redirect:/loginAdmin";
        }

        LocalDateTime start = startDate != null ? startDate.atStartOfDay() : null;
        LocalDateTime end = endDate != null ? endDate.atTime(LocalTime.MAX) : null;

        Pageable pageable = PageRequest.of(page, size);
        Page<UserActivity> activities = userActivityService.getAdminActivities(userName, userEmail, activityType, start, end, pageable);

        model.addAttribute("activities", activities);
        model.addAttribute("activityTypes", ActivityType.values());
        model.addAttribute("userName", userName);
        model.addAttribute("userEmail", userEmail);
        model.addAttribute("activityType", activityType);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "admin/adminActivities";
    }

    @GetMapping("/recruiter/candidate-activities")
    public String viewRecruiterActivities(
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) ActivityType activityType,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            Model model, HttpSession session) {

        Recruiter loggedInRecruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (loggedInRecruiter == null) {
            return "redirect:/recruiter/login";
        }

        LocalDateTime start = startDate != null ? startDate.atStartOfDay() : null;
        LocalDateTime end = endDate != null ? endDate.atTime(LocalTime.MAX) : null;

        Pageable pageable = PageRequest.of(page, size);
        Page<UserActivity> activities = userActivityService.getRecruiterActivities(loggedInRecruiter.getId(), userName, activityType, start, end, pageable);

        model.addAttribute("activities", activities);
        model.addAttribute("activityTypes", ActivityType.values());
        model.addAttribute("userName", userName);
        model.addAttribute("activityType", activityType);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "recruiter/recruiterCandidateActivities";
    }

    @GetMapping("/company/candidate-activities")
    public String viewCompanyActivities(
            @RequestParam(required = false) String userName,
            @RequestParam(required = false) String userEmail,
            @RequestParam(required = false) String jobTitle,
            @RequestParam(required = false) ActivityType activityType,
            @RequestParam(required = false) ApplicationStatus applicationStatus,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
            @RequestParam(required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size,
            Model model, HttpSession session) {

        Company loggedInCompany = (Company) session.getAttribute("loggedInCompany");
        if (loggedInCompany == null) {
            return "redirect:/company/login";
        }

        LocalDateTime start = startDate != null ? startDate.atStartOfDay() : null;
        LocalDateTime end = endDate != null ? endDate.atTime(LocalTime.MAX) : null;

        Pageable pageable = PageRequest.of(page, size);
        Page<CandidateActivityDTO> activities = userActivityService.getCompanyCandidateActivities(
                loggedInCompany.getId(), userName, userEmail, jobTitle, activityType, applicationStatus, start, end, pageable);

        CompanyActivityStatsDTO stats = userActivityService.getCompanyActivityStats(loggedInCompany.getId());

        model.addAttribute("activities", activities);
        model.addAttribute("stats", stats);
        model.addAttribute("activityTypes", ActivityType.values());
        model.addAttribute("applicationStatuses", ApplicationStatus.values());
        model.addAttribute("userName", userName);
        model.addAttribute("userEmail", userEmail);
        model.addAttribute("jobTitle", jobTitle);
        model.addAttribute("activityType", activityType);
        model.addAttribute("applicationStatus", applicationStatus);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);

        return "company/companyCandidateActivities";
    }

    @GetMapping("/company/api/candidate-details/{userId}")
    @ResponseBody
    public ResponseEntity<?> getCandidateDetails(@PathVariable Long userId, HttpSession session) {
        Company loggedInCompany = (Company) session.getAttribute("loggedInCompany");
        if (loggedInCompany == null) {
            return ResponseEntity.status(401).body("Unauthorized");
        }

        JobSeeker candidate = jobSeekerRepository.findById(userId).orElse(null);
        if (candidate == null) {
            return ResponseEntity.notFound().build();
        }

        Map<String, Object> response = new HashMap<>();
        response.put("name", candidate.getName());
        response.put("email", candidate.getEmail());
        response.put("phone", candidate.getPhone());
        response.put("profilePicture", candidate.getProfilePicture());
        response.put("experience", candidate.getExperience());
        response.put("education", candidate.getEducation());
        response.put("skills", candidate.getSkills());
        response.put("resumeUploaded", candidate.getResumeUploaded());
        
        return ResponseEntity.ok(response);
    }
}
