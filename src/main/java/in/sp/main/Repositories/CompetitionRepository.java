package in.sp.main.Repositories;

import in.sp.main.Entities.Competition;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompetitionRepository extends JpaRepository<Competition, Long> {
    List<Competition> findByCreatedByOrderByCreatedAtDesc(Long createdBy);
    List<Competition> findByCreatedByInOrderByCreatedAtDesc(List<Long> createdByList);
    List<Competition> findAllByOrderByCreatedAtDesc();
    List<Competition> findByStatusOrderByCreatedAtDesc(String status);
}
