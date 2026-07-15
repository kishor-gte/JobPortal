package in.sp.main.Services;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobApplication;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Enums.ApplicationStatus;
import in.sp.main.Enums.Location;
import in.sp.main.Exceptions.ResourceNotFoundException;
import in.sp.main.Repositories.JobApplicationRepository;


@Service
public class JobApplicationService {

	@Autowired
	private JobApplicationRepository applicationRepository;
	
	
	public void updateApplicationStatus(Long applicationId, ApplicationStatus newStatus, String remarks, LocalDateTime interviewDate) {
	    JobApplication application = applicationRepository.findById(applicationId)
	            .orElseThrow(() -> new ResourceNotFoundException("Application not found"));

	    application.setStatus(newStatus);
	    application.setLastUpdated(LocalDateTime.now());

	    if (newStatus == ApplicationStatus.INTERVIEW_SCHEDULED && interviewDate != null) {
	        application.setInterviewDate(interviewDate);
	    }

	    application.setRecruiterRemarks(remarks);
	    applicationRepository.save(application);
	}
	  @Autowired
	  private JobApplicationRepository repo;
	  
	  @Autowired
	  private MatchingService matchingService;
	  
	  public void apply(Job job, JobSeeker seeker) {
		    boolean alreadyApplied = hasApplied(job, seeker);
		    if (alreadyApplied) {
		        throw new IllegalStateException("Already applied to this job.");
		    }

		    JobApplication application = new JobApplication();
		    application.setJob(job);
		    application.setJobSeeker(seeker);
		    application.setAppliedDate(LocalDate.now());
		    application.setStatus(ApplicationStatus.APPLIED);
		    application.setResumeScore(matchingService.calculateMatch(job, seeker));
		    applicationRepository.save(application);
		}

	  public boolean hasApplied(Job job, JobSeeker seeker) {
		  return applicationRepository.existsByJobAndJobSeeker(job, seeker);
	  }

	    public List<JobApplication> getApplicationsBySeeker(JobSeeker seeker) {
	        return repo.findByJobSeekerWithJobAndCompany(seeker);
	    }

	    public void updateStatus(Long appId, ApplicationStatus status) {
	        JobApplication app = repo.findById(appId).orElse(null);
	        if (app != null) {
	            app.setStatus(status);
	            repo.save(app);
	        }
	    }
	    public List<Long> getAppliedJobIdsBySeeker(JobSeeker seeker) {
	        if (seeker == null) {
	            return Collections.emptyList();
	        }
	        return applicationRepository.findJobIdsBySeeker(seeker);
	    }
	    public List<JobApplication> findByJobIdAndStatus(Long jobId, String status) {
	        if (status != null && !status.isEmpty()) {
	            return applicationRepository.findByJob_IdAndStatus(jobId, ApplicationStatus.valueOf(status));
	        }
	        return applicationRepository.findByJob_Id(jobId);
	    }
	    
	    public List<JobApplication> findByJobId(Long jobId) {
	        return applicationRepository.findByJob_Id(jobId);
	    }
	    
	    public long countByJobId(Long jobId) {
	        return applicationRepository.countByJob_Id(jobId);
	    }
	    
	    public void save(JobApplication application) {
	        applicationRepository.save(application);
	    }
	    public JobApplication findById(Long applicationId) {
	        return applicationRepository.findById(applicationId).orElse(null);
	    }
				    public List<JobApplication> findByJobIdAndFilters(Long jobId, ApplicationStatus status,
			                Location location, Integer experience,
			                String skills, String matchAllSkills) {
			List<String> skillList = null;
			Integer skillSize = null;
			
			if (skills != null && !skills.trim().isEmpty()) {
			skillList = Arrays.stream(skills.split(","))
			.map(String::trim)
			.map(String::toLowerCase)
			.collect(Collectors.toList());
			skillSize = skillList.size();
			}
			
			if ("on".equals(matchAllSkills) && skillList != null) {
			return applicationRepository.findByJobIdAndFiltersForAllSkills(jobId, status, location, experience, skillList, skillSize);
			} else {
			return applicationRepository.findByJobIdAndFiltersForAnySkills(jobId, status, location, experience, skillList);
			}
			}

				    public long getHiredCountThisMonth() {
				        LocalDate startOfMonth = LocalDate.now().withDayOfMonth(1);
				        LocalDate endOfMonth = LocalDate.now().withDayOfMonth(
				                LocalDate.now().lengthOfMonth()
				        );

				        return applicationRepository.countHiredThisMonth(
				                startOfMonth, endOfMonth
				        );
				    }


}
