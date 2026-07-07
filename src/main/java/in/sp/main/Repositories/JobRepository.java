package in.sp.main.Repositories;


import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import in.sp.main.Entities.Job;
import in.sp.main.Enums.JobCategory;
import in.sp.main.Enums.JobStatus;
@Repository
public interface JobRepository extends JpaRepository<Job, Long>{

    List<Job> findByCompany_Id(Long companyId);

    List<Job> findByStatus(JobStatus status);

	List<Job> findByCreatedBy_Id(Long recruiterId);

	List<Job> findByTitleContainingAndLocation(String keyword, String location);

	List<Job> findByTitleContaining(String keyword);

	List<Job> findByLocation(String location);

	List<Job> findByJobCategory(String jobCategory);

	@Query("SELECT j FROM Job j WHERE " +
		       "(:keyword IS NULL OR LOWER(j.title) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
		       "OR LOWER(j.description) LIKE LOWER(CONCAT('%', :keyword, '%'))) " +
		       "AND (:location IS NULL OR LOWER(j.location) LIKE LOWER(CONCAT('%', :location, '%')))")
		List<Job> searchJobs(@Param("keyword") String keyword, @Param("location") String location);

	@Query("SELECT COUNT(DISTINCT j.location) FROM Job j")
    long countDistinctLocations();
}
