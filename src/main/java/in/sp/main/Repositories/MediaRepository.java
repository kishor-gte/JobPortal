package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.Media;

public interface MediaRepository extends JpaRepository<Media, Long> {

	List<Media> findByCompany_Id(Long companyId);

	void deleteById(Long id);

}