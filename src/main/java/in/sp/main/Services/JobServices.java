package in.sp.main.Services;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.Company;
import in.sp.main.Entities.Job;
import in.sp.main.Enums.JobCategory;
import in.sp.main.Enums.JobStatus;
import in.sp.main.Repositories.JobApplicationRepository;
import in.sp.main.Repositories.JobRepository;
import in.sp.main.Repositories.SavedJobRepository;

@Service
public class JobServices {

    @Autowired
    private JobRepository jobRepository;
    
    @Autowired
    private JobApplicationRepository jobApplicationRepository;
    
    @Autowired
    private SavedJobRepository savedJobRepository;

    
    // Create or update a job
    public void createJob(Job job) {
        jobRepository.save(job);
    }

    // Get jobs by company id
    public List<Job> getJobsByCompany(Long companyId) {
        return jobRepository.findByCompany_Id(companyId);
    }

    // Get all active jobs
    public List<Job> getAllActiveJobs() {
        return jobRepository.findByStatus(JobStatus.OPEN);
    }

    // Get job by ID
    public Job getJobById(Long id) {
        return jobRepository.findById(id).orElse(null);
    }

    public void updateJob(Job job) {
        jobRepository.save(job);  // Spring Data JPA will detect if ID is present and perform an update
    }
    public List<Job> findJobsByRecruiter(Long recruiterId) {
        return jobRepository.findByCreatedBy_Id(recruiterId);
    }

    // Delete job
    public void deleteJob(Long id) {
        Job job = jobRepository.findById(id).orElse(null);
        if (job == null) {
            return; // Job doesn't exist
        }
        
        // First, delete all applications associated with this job
        List<in.sp.main.Entities.JobApplication> applications = jobApplicationRepository.findByJob_Id(id);
        if (!applications.isEmpty()) {
            jobApplicationRepository.deleteAll(applications);
        }
        
        // Delete all saved jobs associated with this job
        List<in.sp.main.Entities.SavedJob> savedJobs = savedJobRepository.findByJob(job);
        if (!savedJobs.isEmpty()) {
            savedJobRepository.deleteAll(savedJobs);
        }
        
        // Finally, delete the job
        jobRepository.deleteById(id);
    }
    //filtered jobs
    public List<Job> getFilteredJobs(
            String category,
            String employmentType,
            String location,
            String workMode,
            String jobSector,
            String education,
            String equity,
            Double salaryMin,
            Double salaryMax,
            Integer experience, String searchQuery) {

        List<Job> jobs = jobRepository.findByStatus(JobStatus.OPEN);

        return jobs.stream()
                .filter(job -> category == null || category.isEmpty() || (job.getJobCategory() != null && job.getJobCategory().toLowerCase().contains(category.toLowerCase())))
                .filter(job -> employmentType == null || employmentType.isEmpty() || (job.getEmploymentType() != null && job.getEmploymentType().name().equalsIgnoreCase(employmentType)))
                .filter(job -> location == null || location.isEmpty() || (job.getLocation() != null && job.getLocation().toLowerCase().contains(location.toLowerCase())))
                .filter(job -> workMode == null || workMode.isEmpty() || (job.getWorkMode() != null && job.getWorkMode().name().equalsIgnoreCase(workMode)))
                .filter(job -> jobSector == null || jobSector.isEmpty() || (job.getJobSector() != null && job.getJobSector().name().equalsIgnoreCase(jobSector)))
                .filter(job -> education == null || education.isEmpty() || (job.getEducation() != null && job.getEducation().name().equalsIgnoreCase(education)))
                .filter(job -> equity == null || equity.isEmpty() || job.isEquityOffered() == Boolean.parseBoolean(equity))
                .filter(job -> salaryMin == null || 
                               (job.getSalaryMin() != null ? job.getSalaryMin() >= salaryMin : 
                               (job.getSalaryMax() != null && job.getSalaryMax() >= salaryMin)))
                .filter(job -> salaryMax == null || 
                               (job.getSalaryMax() != null ? job.getSalaryMax() <= salaryMax : 
                               (job.getSalaryMin() != null && job.getSalaryMin() <= salaryMax)))
                .filter(job -> experience == null || experience <= 0 || job.getExperienceRequired() >= experience)
                // Add the searchQuery filter
                .filter(job -> searchQuery == null || searchQuery.isEmpty() || 
                (job.getTitle() != null && job.getTitle().toLowerCase().contains(searchQuery.toLowerCase())) || 
                (job.getLocation() != null && job.getLocation().toLowerCase().contains(searchQuery.toLowerCase())) || 
                (job.getCompany() != null && job.getCompany().getName() != null && job.getCompany().getName().toLowerCase().contains(searchQuery.toLowerCase())))
                
                .collect(Collectors.toList());
    }
    
 // Method to search jobs by title and location
    public List<Job> searchJobs(String keyword, String location) {
        if ((keyword == null || keyword.isBlank()) && (location == null || location.isBlank())) {
            return jobRepository.findAll(); // Return all jobs if no filters
        }
        return jobRepository.searchJobs(keyword, location);
    }

    // Method to get jobs by category
    public List<Job> getJobsByCategory(JobCategory jobCategory) {
        // Find jobs where the category string contains the enum name
        List<Job> allJobs = jobRepository.findAll();
        return allJobs.stream()
            .filter(j -> j.getJobCategory() != null && j.getJobCategory().contains(jobCategory.name()))
            .collect(java.util.stream.Collectors.toList());
    }
    
    public long getLocationCount() {
        return jobRepository.countDistinctLocations();
    }

	public List<Job> getAllJobs() {
		return jobRepository.findAll();
	}
 
}