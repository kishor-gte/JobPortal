package in.sp.main.Repositories;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobApplication;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Enums.ApplicationStatus;
import in.sp.main.Enums.Location;

@Repository
public interface JobApplicationRepository extends JpaRepository<JobApplication, Long> {
	
	  List<JobApplication> findByJobSeeker(JobSeeker jobSeeker);
	  
	  @Query("SELECT a FROM JobApplication a JOIN FETCH a.job j JOIN FETCH j.company WHERE a.jobSeeker = :seeker")
	  List<JobApplication> findByJobSeekerWithJobAndCompany(@Param("seeker") JobSeeker seeker);
	  
	    boolean existsByJobAndJobSeeker(Job job, JobSeeker jobSeeker);
	    
	    @Query("SELECT a.job.id FROM JobApplication a WHERE a.jobSeeker = :seeker")
	    List<Long> findJobIdsBySeeker(@Param("seeker") JobSeeker seeker);
		List<JobApplication> findByJob_IdAndStatus(Long jobId, ApplicationStatus valueOf);
		List<JobApplication> findByJob_Id(Long jobId);
		
		@Query("SELECT ja FROM JobApplication ja " +
			       "JOIN ja.jobSeeker js " +
			       "WHERE ja.job.id = :jobId " +
			       "AND (:status IS NULL OR ja.status = :status) " +
			       "AND (:location IS NULL OR js.location = :location) " +
			       "AND (:experience IS NULL OR js.experience = :experience) " +
			       "AND (:skills IS NULL OR (" +
			       "  SELECT COUNT(s) FROM js.skills s WHERE LOWER(s) IN :skills) > 0)")
			List<JobApplication> findByJobIdAndFiltersForAnySkills(
			       @Param("jobId") Long jobId,
			       @Param("status") ApplicationStatus status,
			       @Param("location") Location location,
			       @Param("experience") Integer experience,
			       @Param("skills") List<String> skills);


			@Query("SELECT ja FROM JobApplication ja " +
			       "JOIN ja.jobSeeker js " +
			       "WHERE ja.job.id = :jobId " +
			       "AND (:status IS NULL OR ja.status = :status) " +
			       "AND (:location IS NULL OR js.location = :location) " +
			       "AND (:experience IS NULL OR js.experience = :experience) " +
			       "AND (:skills IS NULL OR (" +
			       "  SELECT COUNT(s) FROM js.skills s WHERE LOWER(s) IN :skills) = :skillsSize)")
			List<JobApplication> findByJobIdAndFiltersForAllSkills(
			       @Param("jobId") Long jobId,
			       @Param("status") ApplicationStatus status,
			       @Param("location") Location location,
			       @Param("experience") Integer experience,
			       @Param("skills") List<String> skills,
			       @Param("skillsSize") Integer skillsSize);

	
			   @Query("SELECT COUNT(a) FROM JobApplication a " +
			           "WHERE a.status = 'SELECTED' " +
			           "AND a.appliedDate BETWEEN :startDate AND :endDate")
			    long countHiredThisMonth(
			            @Param("startDate") LocalDate startDate,
			            @Param("endDate") LocalDate endDate
			    );

}
