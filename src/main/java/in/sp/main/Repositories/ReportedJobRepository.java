package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.ReportedJob;

public interface ReportedJobRepository extends JpaRepository<ReportedJob, Long> {
    List<ReportedJob> findAllByIsResolvedFalse();
    List<ReportedJob> findAllByIsResolvedTrue();
    List<ReportedJob> findByReporter(JobSeeker reporter);
    
    @Query("SELECT r FROM ReportedJob r JOIN FETCH r.job j JOIN FETCH j.company WHERE r.reporter = :reporter")
    List<ReportedJob> findByReporterWithJobAndCompany(@Param("reporter") JobSeeker reporter);
}

