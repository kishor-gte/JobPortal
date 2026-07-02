package in.sp.main.Services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.Job;
import in.sp.main.Entities.Recruiter;
import in.sp.main.Repositories.JobRepository;
import in.sp.main.Repositories.RecruiterRepository;
import jakarta.transaction.Transactional;

@Service
public class RecruiterServices {

    @Autowired
    private RecruiterRepository recruiterRepository;
    @Autowired
    private JobRepository jobRepository;

    // Create a new recruiter
    public void createRecruiter(Recruiter recruiter) {
        if (recruiter.getPassword() != null) {
            recruiter.setPassword(BCrypt.hashpw(recruiter.getPassword(), BCrypt.gensalt()));
        }
        recruiterRepository.save(recruiter);
    }
    public Recruiter findByEmail(String email) {
        Optional<Recruiter> optionalRecruiter = recruiterRepository.findByEmail(email);

        return optionalRecruiter.isPresent() ? optionalRecruiter.get() : null;
    }

    public Recruiter authenticateRecruiter(String email, String password) {
        Optional<Recruiter> recruiteroptional = recruiterRepository.findByEmail(email);
        if (recruiteroptional.isEmpty()) return null;
        
        Recruiter recruiter = recruiteroptional.get();
        boolean matches = false;
        try {
            matches = BCrypt.checkpw(password, recruiter.getPassword());
        } catch (Exception e) {}

        if (!matches) {
            // Fallback for legacy plain text passwords
            if (recruiter.getPassword().equals(password)) {
                // Migration: encode and save
                recruiter.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
                recruiterRepository.save(recruiter);
                matches = true;
            }
        }

        return matches ? recruiter : null;
    }
    public List<Recruiter> findRecruitersByCompany(Long companyId) {
        return recruiterRepository.findByCompany_Id(companyId);
    }
    
    
 // Update recruiter profile
    public Recruiter updateRecruiter(Recruiter recruiter) {
        return recruiterRepository.save(recruiter);
    }

    @Transactional
    public void deleteRecruiter(Long id) {
        Recruiter recruiter = recruiterRepository.findById(id).orElseThrow();
        
        // Unlink jobs first
        List<Job> jobs = recruiter.getJobs();
        for (Job job : jobs) {
            job.setCreatedBy(null);
        }
        jobRepository.saveAll(jobs);  // persist the changes

        recruiterRepository.deleteById(id);
    }

    // Fetch all recruiters
    public List<Recruiter> getAllRecruiters() {
        return recruiterRepository.findAll();
    }

    // Fetch recruiters for a specific company (if necessary)
    public List<Recruiter> getRecruitersByCompany(Long companyId) {
        return recruiterRepository.findByCompany_Id(companyId);
    }

    public Recruiter findRecruiterById(Long id) {
        return recruiterRepository.findById(id).orElse(null);  // Return null if not found
    }
    
}
