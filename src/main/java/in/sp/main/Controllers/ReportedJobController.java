package in.sp.main.Controllers;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import in.sp.main.Entities.CompanyNotification;
import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.ReportedJob;
import in.sp.main.Repositories.CompanyNotificationRepository;
import in.sp.main.Repositories.JobRepository;
import in.sp.main.Repositories.JobSeekerRepository;
import in.sp.main.Repositories.ReportedJobRepository;
import in.sp.main.Services.JobSeekerService;
import in.sp.main.Services.JobServices;
import in.sp.main.Services.ReportedJobService;
import jakarta.servlet.http.HttpSession;

@Controller
public class ReportedJobController {

	  @Autowired
	    private JobRepository jobRepository;

	    @Autowired
	    private JobSeekerRepository jobSeekerRepository;

	    @Autowired
	    private ReportedJobRepository reportedJobRepository;
	    @Autowired
	    private JobServices jobService;

	    @Autowired
	    private JobSeekerService jobSeekerService;

	    @Autowired
	    private ReportedJobService reportedJobService;
	    @Autowired
	    private CompanyNotificationRepository companyNotificationRepository;


	  
	    @RequestMapping(value = "/report/{jobId}", method = RequestMethod.GET)
	    public String showReportForm(@PathVariable Long jobId, Model model, HttpSession session) {
	        // Fetch job by ID
	        Job job = jobService.getJobById(jobId);

	        // Get current JobSeeker from session
	        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("loggedInJobSeeker");

	        ReportedJob report = new ReportedJob();
	        report.setJob(job);
	        report.setReporter(jobSeeker);

	        model.addAttribute("jobReport", report);
	        return "jobSeekers/ReportJob"; // JSP page
	    }

	    
	    @RequestMapping(value = "/report-job", method = RequestMethod.POST)
	    public String reportJob(@RequestParam Long jobId,
	                            @RequestParam String reason,
	                            @RequestParam(required = false) String additionalInfo,
	                            HttpSession session) {

	        JobSeeker loggedInjobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
	        Long jobSeekerId = loggedInjobSeeker.getId();

	        Job job = jobRepository.findById(jobId).orElse(null);
	        JobSeeker jobSeeker = jobSeekerRepository.findById(jobSeekerId).orElse(null);

	        if (job != null && jobSeeker != null) {

	            // SAVE REPORT
	            ReportedJob report = new ReportedJob();
	            report.setJob(job);
	            report.setReporter(jobSeeker);
	            report.setReason(reason);
	            report.setAdditionalInfo(additionalInfo);
	            report.setReportedAt(LocalDateTime.now());
	            report.setResolved(false);
	            reportedJobRepository.save(report);

	            // ====================================
	            // 🔔 COMPANY NOTIFICATION
	            // ====================================
	            Long companyId = job.getCompany().getId();

	            CompanyNotification cn = new CompanyNotification();
	            cn.setCompanyId(companyId);
	            cn.setMessage(
	                    "Your job \"" + job.getTitle() + "\" was reported by " +
	                    jobSeeker.getName()
	            );
	            cn.setCreatedAt(LocalDateTime.now());
	            cn.setSeen(false);

	            companyNotificationRepository.save(cn);
	        }

	        return "redirect:/applications/track";
	    }


	    @RequestMapping(value = "/seeker/reported-jobs", method = RequestMethod.GET)
	    public String viewReportedJobs(HttpSession session, Model model) {
	        JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");

	        if (seeker != null) {
	            List<ReportedJob> reports = reportedJobService.getReportsBySeeker(seeker);
	            model.addAttribute("reportedJobs", reports);
	           
	        }

	        return "jobSeekers/reported-Jobs"; // JSP file name
	    }
	    
	
}
