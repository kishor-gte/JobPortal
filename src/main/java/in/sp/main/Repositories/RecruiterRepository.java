package in.sp.main.Repositories;


import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.sp.main.Entities.Recruiter;

@Repository
public interface RecruiterRepository extends JpaRepository<Recruiter, Long> {

	Optional<Recruiter> findByEmail(String email);

	List<Recruiter> findByCompany_Id(Long companyId);
}
