package in.sp.main.Repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.JobSeeker;

public interface JobSeekerRepository extends JpaRepository<JobSeeker, Long>{

    Optional<JobSeeker> findByEmail(String email);
}
