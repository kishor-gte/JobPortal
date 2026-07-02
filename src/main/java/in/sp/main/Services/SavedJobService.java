package in.sp.main.Services;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.SavedJob;
import in.sp.main.Repositories.SavedJobRepository;
import jakarta.transaction.Transactional;

@Service
public class SavedJobService {

    @Autowired
    private SavedJobRepository savedJobRepository;

    public void saveJob(Job job, JobSeeker seeker) {
        if (!savedJobRepository.existsByJobAndJobSeeker(job, seeker)) {
            SavedJob savedJob = new SavedJob();
            savedJob.setJob(job);
            savedJob.setJobSeeker(seeker);
            savedJob.setSavedDate(LocalDate.now());
            savedJobRepository.save(savedJob);
        }
    }

    public List<Long> getSavedJobIdsBySeeker(JobSeeker seeker) {
        return savedJobRepository.findByJobSeeker(seeker)
                                 .stream()
                                 .map(savedJob -> savedJob.getJob().getId())
                                 .collect(Collectors.toList());
    }
    public List<Job> getSavedJobsBySeeker(JobSeeker seeker) {
        return savedJobRepository.findByJobSeekerWithCompany(seeker)
                                 .stream()
                                 .map(SavedJob::getJob)
                                 .collect(Collectors.toList());
    }
    
    @Transactional
    public void removeSavedJob(Job job, JobSeeker seeker) {
        savedJobRepository.deleteByJobAndJobSeeker(job, seeker);
    }
}
