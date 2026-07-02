package in.sp.main.Services;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.mindrot.jbcrypt.BCrypt;

import in.sp.main.Entities.JobSeeker;
import in.sp.main.Repositories.JobSeekerRepository;

@Service
public class JobSeekerService {

    @Autowired
    private JobSeekerRepository jobSeekerRepository;

    private final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

    // Create a new JobSeeker with timestamp
    public JobSeeker createJobSeeker(JobSeeker jobSeeker) {
        String now = LocalDateTime.now().format(formatter);
        jobSeeker.setCreatedAt(now);
        jobSeeker.setUpdatedAt(now);
        if (jobSeeker.getPassword() != null) {
            jobSeeker.setPassword(BCrypt.hashpw(jobSeeker.getPassword(), BCrypt.gensalt()));
        }
        return jobSeekerRepository.save(jobSeeker);
    }

    // Get all JobSeekers
    public List<JobSeeker> getAllJobSeekers() {
        return jobSeekerRepository.findAll();
    }

    // Get JobSeeker by ID
    public JobSeeker getJobSeekerById(Long id) {
        return jobSeekerRepository.findById(id).orElse(null);
    }

    // Delete JobSeeker by ID
    public void deleteJobSeeker(Long id) {
        jobSeekerRepository.deleteById(id);
    }

    // Find by email
    public JobSeeker findByEmail(String email) {
    	 Optional<JobSeeker> optional = jobSeekerRepository.findByEmail(email);
    	    return optional.orElse(null);  
    }

    // Update JobSeeker details with timestamp
    public JobSeeker updateJobSeeker(Long id, JobSeeker updatedJobSeeker) {
        Optional<JobSeeker> optional = jobSeekerRepository.findById(id);
        if (optional.isEmpty()) {
            throw new RuntimeException("JobSeeker not found with ID: " + id);
        }

        JobSeeker existing = optional.get();

        if (updatedJobSeeker.getName() != null) {
            existing.setName(updatedJobSeeker.getName());
        }
        if (updatedJobSeeker.getEmail() != null) {
            existing.setEmail(updatedJobSeeker.getEmail());
        }
        if (updatedJobSeeker.getPhone() != null) {
            existing.setPhone(updatedJobSeeker.getPhone());
        }
        if (updatedJobSeeker.getAge() != null) {
            existing.setAge(updatedJobSeeker.getAge());
        }
        if(updatedJobSeeker.getExperience()!=null)
        {
        	existing.setExperience(updatedJobSeeker.getExperience());
        }
        if (updatedJobSeeker.getLocation() != null) {
            existing.setLocation(updatedJobSeeker.getLocation());
        }
        if (updatedJobSeeker.getProfilePicture() != null) {
            existing.setProfilePicture(updatedJobSeeker.getProfilePicture());
        }
        if (updatedJobSeeker.getLanguagesKnown() != null) {
            existing.setLanguagesKnown(updatedJobSeeker.getLanguagesKnown());
        }
        if (updatedJobSeeker.getResumeUploaded() != null) {
            existing.setResumeUploaded(updatedJobSeeker.getResumeUploaded());
        }
        if (updatedJobSeeker.getVideoResumeUrl() != null) {
            existing.setVideoResumeUrl(updatedJobSeeker.getVideoResumeUrl());
        }
        if (updatedJobSeeker.getWorkAvailability() != null) {
            existing.setWorkAvailability(updatedJobSeeker.getWorkAvailability());
        }
        if (updatedJobSeeker.getAccountStatus() != null) {
            existing.setAccountStatus(updatedJobSeeker.getAccountStatus());
        }
        if (updatedJobSeeker.getSkills() != null && !updatedJobSeeker.getSkills().isEmpty()) {
           
        	 existing.setSkills(new ArrayList<>(updatedJobSeeker.getSkills()));
           
        }
        existing.setUpdatedAt(LocalDateTime.now().format(formatter));
        return jobSeekerRepository.save(existing);
    }

	public List<JobSeeker> findAll() {
		return jobSeekerRepository.findAll();
	}

	public Optional<JobSeeker> findById(long id) {
		return jobSeekerRepository.findById(id);
	}

	public Object countAll() {
		return jobSeekerRepository.count();
	}
}
