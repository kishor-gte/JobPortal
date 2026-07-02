package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.SavedJob;

public interface SavedJobRepository extends JpaRepository<SavedJob, Long> {
    boolean existsByJobAndJobSeeker(Job job, JobSeeker seeker);
    List<SavedJob> findByJobSeeker(JobSeeker seeker);
    
    @Query("SELECT sj FROM SavedJob sj JOIN FETCH sj.job j JOIN FETCH j.company WHERE sj.jobSeeker = :seeker")
    List<SavedJob> findByJobSeekerWithCompany(@Param("seeker") JobSeeker seeker);
    
    void deleteByJobAndJobSeeker(Job job, JobSeeker seeker);
    
    List<SavedJob> findByJob(Job job);
    
    void deleteByJob(Job job);
}

