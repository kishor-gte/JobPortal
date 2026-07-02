package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.sp.main.Entities.SportsService;

@Repository
public interface SportsServiceRepository extends JpaRepository<SportsService, Long> {

	/* List<SportsService> findByOrganizerId(Long organizerId); */
}
