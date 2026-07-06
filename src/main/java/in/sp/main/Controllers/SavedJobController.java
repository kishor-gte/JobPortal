package in.sp.main.Controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Services.JobServices;
import in.sp.main.Services.SavedJobService;
import in.sp.main.utils.ActivityLogger;
import in.sp.main.Enums.ActivityType;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/seeker")
public class SavedJobController {

    @Autowired
    private SavedJobService savedJobService;

    @Autowired
    private JobServices jobService;

    @Autowired
    private ActivityLogger activityLogger;

    @RequestMapping(value = "/saved-jobs", method = RequestMethod.GET)
    public String viewSavedJobs(HttpSession session, Model model) {
        JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");
        if (seeker == null) {
            return "redirect:/jobSeekers/login";
        }

        List<Job> savedJobs = savedJobService.getSavedJobsBySeeker(seeker);
        model.addAttribute("savedJobs", savedJobs);
        return "jobSeekers/savedJobs"; // JSP page
    }

    // Unsave Job
    @RequestMapping(value = "/remove-saved-job", method = RequestMethod.POST)
    public String removeSavedJob(@RequestParam Long jobId, HttpSession session, RedirectAttributes redirectAttributes) {
        JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");
        Job job = jobService.getJobById(jobId);

        if (seeker == null || job == null) {
            redirectAttributes.addFlashAttribute("error", "Invalid operation.");
            return "redirect:/seeker/saved-jobs";
        }

        savedJobService.removeSavedJob(job, seeker);
        activityLogger.log(seeker.getId(), seeker.getName(), seeker.getEmail(), "JOBSEEKER", ActivityType.REMOVED_SAVED_JOB, "Removed saved job: " + job.getTitle());
        redirectAttributes.addFlashAttribute("message", "Job removed from saved list.");
        return "redirect:/seeker/saved-jobs";
    }
    
}
