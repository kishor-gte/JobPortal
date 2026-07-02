package in.sp.main.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.sp.main.Entities.Company;
@Repository
public interface CompanyRepository extends JpaRepository<Company, Long>{

	List<Company> findByIsVerifiedTrue();

	List<Company> findByIsVerifiedFalse();

	List<Company> findByNameContainingIgnoreCase(String keyword);

	Optional<Company> findByEmailAndPassword(String email, String password);
	Optional<Company> findByEmail(String email);


}

