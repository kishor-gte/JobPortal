package in.sp.main.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import in.sp.main.Entities.JobSeeker;

public interface JobSeekerRepository extends JpaRepository<JobSeeker, Long>{

    Optional<JobSeeker> findByEmail(String email);

    @Query("SELECT j FROM JobSeeker j WHERE " +
           "(j.role IS NULL OR j.role = '' OR j.role = 'STUDENT' OR j.role = 'USER') " +
           "AND (:name IS NULL OR LOWER(j.name) LIKE LOWER(CONCAT('%', :name, '%'))) " +
           "AND (:email IS NULL OR LOWER(j.email) LIKE LOWER(CONCAT('%', :email, '%'))) " +
           "AND (:experience IS NULL OR j.experience >= :experience) " +
           "AND (:location IS NULL OR CAST(j.location AS string) = :location)")
    Page<JobSeeker> findCandidatesWithFilters(
            @Param("name") String name,
            @Param("email") String email,
            @Param("experience") Integer experience,
            @Param("location") String location,
            Pageable pageable);

    @Query("SELECT COUNT(j) FROM JobSeeker j WHERE j.role IS NULL OR j.role = '' OR j.role = 'STUDENT' OR j.role = 'USER'")
    long countTotalCandidates();

    @Query("SELECT COUNT(j) FROM JobSeeker j WHERE (j.role IS NULL OR j.role = '' OR j.role = 'STUDENT' OR j.role = 'USER') AND j.resumeUploaded IS NOT NULL AND j.resumeUploaded != ''")
    long countCandidatesWithResume();

    @Query("SELECT COUNT(DISTINCT j) FROM JobSeeker j INNER JOIN JobApplication a ON a.jobSeeker = j WHERE j.role IS NULL OR j.role = '' OR j.role = 'STUDENT' OR j.role = 'USER'")
    long countCandidatesApplied();

    @Query("SELECT COUNT(DISTINCT j) FROM JobSeeker j INNER JOIN MockInterview m ON m.studentId = j.id WHERE (j.role IS NULL OR j.role = '' OR j.role = 'STUDENT' OR j.role = 'USER') AND m.status = 'SCHEDULED'")
    long countCandidatesInterviewScheduled();

    @Query("SELECT COUNT(DISTINCT j) FROM JobSeeker j INNER JOIN JobApplication a ON a.jobSeeker = j WHERE (j.role IS NULL OR j.role = '' OR j.role = 'STUDENT' OR j.role = 'USER') AND a.status = 'SELECTED'")
    long countCandidatesHired();
}
