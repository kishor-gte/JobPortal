 package in.sp.main.Controllers;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import in.sp.main.Entities.Company;
import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.Recruiter;
import in.sp.main.Enums.Education;
import in.sp.main.Enums.EmploymentType;
import in.sp.main.Enums.JobCategory;
import in.sp.main.Enums.JobSector;
import in.sp.main.Enums.JobStatus;
import in.sp.main.Enums.Location;
import in.sp.main.Enums.WorkMode;
import in.sp.main.Services.CompanyServices;
import in.sp.main.Services.JobApplicationService;
import in.sp.main.Services.JobServices;
import in.sp.main.Services.MatchingService;
import in.sp.main.Services.SavedJobService;
import in.sp.main.Services.SubscriberServices;
import in.sp.main.Services.TagService;
import in.sp.main.utils.ActivityLogger;
import in.sp.main.Enums.ActivityType;
import jakarta.servlet.http.HttpSession;



@Controller
@RequestMapping("/jobs")
public class JobController {

    @Autowired
    private JobServices jobService;

    @Autowired
    private CompanyServices companyService;
    @Autowired
    private TagService tagService;
    @Autowired
    private JobApplicationService applicationService;
    @Autowired
    private SavedJobService savedJobService;
    @Autowired
    private SubscriberServices subscriberServices;
    @Autowired
    private MatchingService matchingService;
    
    @Autowired
    private ActivityLogger activityLogger;
    
 // Show job posting form
    @RequestMapping(value = "/post/{companyId}", method = RequestMethod.GET)
    public String showJobPostForm(@PathVariable Long companyId, Model model) {
        Company company = companyService.getCompany(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));
        if (!company.isVerified()) {
            model.addAttribute("error", "Your company is not verified to post jobs.");
            return "company/error";
        }
        model.addAttribute("job", new Job());
        model.addAttribute("companyId", companyId);
        model.addAttribute("employmentTypes", EmploymentType.values());
        model.addAttribute("workModes", WorkMode.values());
        model.addAttribute("jobStatuses", JobStatus.values());
        model.addAttribute("jobCategories", JobCategory.values());
        model.addAttribute("jobSectors", JobSector.values());
        model.addAttribute("educationLevels", Education.values());
        model.addAttribute("allTags", tagService.getAllTags());
        model.addAttribute("locations", Location.values());
        return "job/postJob";
    }

    // Handle job post submission
    @RequestMapping(value = "/post", method = RequestMethod.POST)
    public String createJob(@ModelAttribute Job job,
                            @RequestParam Long companyId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {

        Optional<Company> companyOpt = companyService.getCompany(companyId);
        Company company = companyOpt.orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));
        job.setCompany(company);

        job.setCreatedBy((Recruiter) session.getAttribute("loggedInRecruiter"));
        job.setPostedDate(LocalDate.now());
        job.setStatus(JobStatus.OPEN);
        job.setVerified(false); // Default to not verified

        jobService.createJob(job);
        subscriberServices.notifyMatchingSubscribers(job);

        redirectAttributes.addFlashAttribute("message", "Job created successfully!");
        return "redirect:/jobs/by-company/" + companyId;
    }

    // View jobs of a company — optionally filtered by employmentType
    @RequestMapping(value = "/by-company/{companyId}", method = RequestMethod.GET)
    public String viewCompanyJobs(@PathVariable Long companyId,
                                   @RequestParam(required = false) String employmentType,
                                   Model model) {
        List<Job> jobs = jobService.getJobsByCompany(companyId);

        // Filter by employmentType if provided (e.g. INTERNSHIP)
        if (employmentType != null && !employmentType.isEmpty()) {
            final String filter = employmentType;
            jobs = jobs.stream()
                .filter(j -> j.getEmploymentType() != null &&
                             j.getEmploymentType().name().equalsIgnoreCase(filter))
                .collect(java.util.stream.Collectors.toList());
            model.addAttribute("filterType", employmentType);
        }

        model.addAttribute("jobs", jobs);
        model.addAttribute("companyId", companyId);
        return "job/companyJobs";
    }

    // Show job posting form pre-filled for Internship
    @RequestMapping(value = "/post-internship/{companyId}", method = RequestMethod.GET)
    public String showInternshipPostForm(@PathVariable Long companyId, Model model) {
        Company company = companyService.getCompany(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));
        if (!company.isVerified()) {
            model.addAttribute("error", "Your company is not verified to post jobs.");
            return "company/error";
        }
        Job job = new Job();
        job.setEmploymentType(EmploymentType.INTERNSHIP);
        model.addAttribute("job", job);
        model.addAttribute("companyId", companyId);
        model.addAttribute("employmentTypes", EmploymentType.values());
        model.addAttribute("workModes", WorkMode.values());
        model.addAttribute("jobStatuses", JobStatus.values());
        model.addAttribute("jobCategories", JobCategory.values());
        model.addAttribute("jobSectors", JobSector.values());
        model.addAttribute("educationLevels", Education.values());
        model.addAttribute("allTags", tagService.getAllTags());
        model.addAttribute("locations", Location.values());
        model.addAttribute("isInternship", true);
        return "job/postJob";
    }

    // View all active jobs
    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public String showAllJobs(
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String employmentType,
            @RequestParam(required = false) String location,
            @RequestParam(required = false) String workMode,
            @RequestParam(required = false) String jobSector,
            @RequestParam(required = false) String education,
            @RequestParam(required = false) String equity,
            @RequestParam(required = false) String salaryMin,
            @RequestParam(required = false) String salaryMax,
            @RequestParam(required = false) String experience,
            @RequestParam(required = false) String searchQuery,
            Model model,
            HttpSession session) {

        JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");
        if(seeker==null)
        {
        	return "redirect:/jobSeekers/login";
        }

        try {
            // Parse numeric parameters safely
            Double salaryMinVal = null;
            Double salaryMaxVal = null;
            Integer experienceVal = null;
            
            try {
                if (salaryMin != null && !salaryMin.trim().isEmpty()) {
                    salaryMinVal = Double.parseDouble(salaryMin.trim());
                }
                if (salaryMax != null && !salaryMax.trim().isEmpty()) {
                    salaryMaxVal = Double.parseDouble(salaryMax.trim());
                }
                if (experience != null && !experience.trim().isEmpty()) {
                    experienceVal = Integer.parseInt(experience.trim());
                }
            } catch (NumberFormatException e) {
                System.err.println("Error parsing numeric filters: " + e.getMessage());
            }
            
            List<Job> jobs = jobService.getFilteredJobs(category, employmentType, location, workMode,
                    jobSector, education, equity, salaryMinVal, salaryMaxVal, experienceVal, searchQuery);

            List<Long> appliedJobIds = applicationService.getAppliedJobIdsBySeeker(seeker);
            List<Long> savedJobIds = savedJobService.getSavedJobIdsBySeeker(seeker);

            model.addAttribute("jobs", jobs);
            model.addAttribute("appliedJobIds", appliedJobIds);
            model.addAttribute("savedJobIds", savedJobIds);
        } catch (Exception e) {
            // Log error and show empty job list with error message
            System.err.println("Error filtering jobs: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "An error occurred while filtering jobs. Please try again.");
            model.addAttribute("jobs", new java.util.ArrayList<Job>());
            model.addAttribute("appliedJobIds", new java.util.ArrayList<Long>());
            model.addAttribute("savedJobIds", new java.util.ArrayList<Long>());
        }

        // Pass enum options to JSP
        model.addAttribute("jobCategory", JobCategory.values());
        model.addAttribute("workMode", WorkMode.values());
        model.addAttribute("employmentType", EmploymentType.values());
        model.addAttribute("education", Education.values());
        model.addAttribute("jobSector", JobSector.values());
        model.addAttribute("location", Location.values()); // Add Location enum
        model.addAttribute("companiesCount", companyService.getCompanyCount());
        model.addAttribute("hiredCount", applicationService.getHiredCountThisMonth());
        model.addAttribute("locationsCount", jobService.getLocationCount());
        return "job/allJobs";
    }

 // Show Edit Form
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String showEditJobForm(@PathVariable("id") Long jobId, Model model) {
        Job job = jobService.getJobById(jobId);
        if (job != null) {
            model.addAttribute("job", job);
            model.addAttribute("companyId", job.getCompany().getId());
            model.addAttribute("statuses", JobStatus.values());
            model.addAttribute("employmentTypes", EmploymentType.values());
            model.addAttribute("workModes", WorkMode.values());
            model.addAttribute("jobCategories", JobCategory.values());
            model.addAttribute("jobSectors", JobSector.values());
            model.addAttribute("educationLevels", Education.values());
            model.addAttribute("location", Location.values());
            model.addAttribute("allTags", tagService.getAllTags());
            return "job/editJob";
        }
        return "redirect:/jobs/all";
    }

    // Handle Update Job
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateJob(@ModelAttribute Job job,
                            @RequestParam Long companyId,
                            RedirectAttributes redirectAttributes) {

        Job existingJob = jobService.getJobById(job.getId());

        if (existingJob == null) {
            redirectAttributes.addFlashAttribute("error", "Job not found.");
            return "redirect:/jobs/all";
        }

        // Update fields
        existingJob.setTitle(job.getTitle());
        existingJob.setDescription(job.getDescription());
        existingJob.setLocation(job.getLocation());
        existingJob.setEmploymentType(job.getEmploymentType());
        existingJob.setJobSector(job.getJobSector());
        existingJob.setSalaryMin(job.getSalaryMin());
        existingJob.setSalaryMax(job.getSalaryMax());
        existingJob.setExperienceRequired(job.getExperienceRequired());
        existingJob.setEquityOffered(job.isEquityOffered());
        existingJob.setSkillRequirement(job.getSkillRequirement());
        existingJob.setJobCategory(job.getJobCategory());
        existingJob.setWorkMode(job.getWorkMode());
        existingJob.setEducation(job.getEducation());
        existingJob.setExpiryDate(job.getExpiryDate());
        existingJob.setStatus(job.getStatus());

        Company company = companyService.getCompany(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));
        existingJob.setCompany(company);

        jobService.updateJob(existingJob);

        redirectAttributes.addFlashAttribute("message", "Job updated successfully!");
        return "redirect:/jobs/by-company/" + companyId;
    }

    // Handle Delete Job
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String deleteJob(@PathVariable("id") Long jobId, RedirectAttributes redirectAttributes) {
       Job job= jobService.getJobById(jobId);
       if (job == null) {
           redirectAttributes.addFlashAttribute("error", "Job not found.");
           return "redirect:/jobs/all";
       }
       Long companyId = job.getCompany().getId();
    	jobService.deleteJob(jobId);  // Delete the job by ID
        redirectAttributes.addFlashAttribute("message", "Job deleted successfully!");
        return "redirect:/jobs/by-company/"+companyId;  // Redirect back to job list after successful deletion
    }
    //seekers save job  before applying
    @RequestMapping(value = "/seeker/save-job", method = RequestMethod.POST)
    public String saveJob(@RequestParam Long jobId, HttpSession session, RedirectAttributes redirectAttributes) {
        JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");
        Job job = jobService.getJobById(jobId);

        if (seeker == null || job == null) {
            redirectAttributes.addFlashAttribute("error", "Invalid operation.");
            return "redirect:/jobs/all";
        }

        savedJobService.saveJob(job, seeker);
        activityLogger.log(seeker.getId(), seeker.getName(), seeker.getEmail(), "JOBSEEKER", ActivityType.SAVED_JOB, "Saved job: " + job.getTitle());
        redirectAttributes.addFlashAttribute("message", "Job saved for later.");
        return "redirect:/jobs/all";
    }

    //seekers unsave job
    @RequestMapping(value = "/seeker/unsave-job", method = RequestMethod.POST)
    public String unsaveJob(@RequestParam Long jobId, HttpSession session, RedirectAttributes redirectAttributes) {
        JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");
        Job job = jobService.getJobById(jobId);

        if (seeker == null || job == null) {
            redirectAttributes.addFlashAttribute("error", "Invalid operation.");
            return "redirect:/jobs/all";
        }

        savedJobService.removeSavedJob(job, seeker);
        activityLogger.log(seeker.getId(), seeker.getName(), seeker.getEmail(), "JOBSEEKER", ActivityType.REMOVED_SAVED_JOB, "Removed saved job: " + job.getTitle());
        redirectAttributes.addFlashAttribute("message", "Job removed from saved list.");
        return "redirect:/jobs/all";
    }
//show job details
    @RequestMapping(value = "/details/{id}", method = RequestMethod.GET)
    public String showJobDetails(@PathVariable("id") Long jobId, Model model,HttpSession session) {
        try {
            Job job = jobService.getJobById(jobId);
            if (job == null) {
                return "redirect:/jobs/all";
            }
            int matchScore = 0;
            boolean hasApplied = false;
            JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");
            if (seeker != null) {
                try {
                    matchScore = matchingService.calculateMatch(job, seeker);
                } catch (Exception e) {
                    System.err.println("Error calculating match score: " + e.getMessage());
                    e.printStackTrace();
                    matchScore = 0;
                }
                try {
                    hasApplied = applicationService.hasApplied(job, seeker);
                } catch (Exception e) {
                    hasApplied = false;
                }

            }
            model.addAttribute("job", job);
            model.addAttribute("matchScore", matchScore);
            model.addAttribute("hasApplied", hasApplied);
            if (seeker != null) {
                activityLogger.log(seeker.getId(), seeker.getName(), seeker.getEmail(), "JOBSEEKER", ActivityType.VIEWED_JOB, "Viewed job details: " + job.getTitle());
            }

            return "job/jobDetails"; // JSP page name
        } catch (Exception e) {
            System.err.println("Error showing job details for job ID " + jobId + ": " + e.getMessage());
            e.printStackTrace();
            return "redirect:/jobs/all";
        }
    }
    @RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
    public String showJobDetailsForCompany(@PathVariable("id") Long jobId, Model model) {
        Job job = jobService.getJobById(jobId);
        model.addAttribute("job", job);
        return "job/jobView"; // JSP page name
    }
    
 // Mapping to handle search requests
    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public String searchJobs(
        @RequestParam(required = false) String keyword, 
        @RequestParam(required = false) String location, 
        Model model,HttpSession session) {

        if ((keyword == null || keyword.trim().isEmpty()) && (location == null || location.trim().isEmpty())) {
            return "redirect:/userdashboard.html";
        }

        List<Job> jobs = jobService.searchJobs(keyword, location);
        JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");
        if(seeker==null)
        {
        	return "redirect:/jobSeekers/login";
        }
        
        
        // Add jobs to the model to display on the page
        model.addAttribute("jobs", jobs);
        
        // Return the view (the same page with job results)
        return "job/jobSearchResults";  // You will have a corresponding Thymeleaf or JSP page
    }
 // Endpoint to display jobs by category
    @RequestMapping(value = "/category/{category}", method = RequestMethod.GET)
    public String getJobsByCategory(@PathVariable("category") JobCategory jobCategory, Model model,HttpSession session) {
    	 JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");
         if(seeker==null)
         {
         	return "redirect:/jobSeekers/login";
         }
    	
    	List<Job> jobs = jobService.getJobsByCategory(jobCategory);
        model.addAttribute("jobs", jobs);
        model.addAttribute("category", jobCategory);
        return "job/jobsByCategory"; // Name of the JSP page
    }
    
    
}


