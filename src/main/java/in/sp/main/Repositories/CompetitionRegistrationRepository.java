package in.sp.main.Repositories;

import in.sp.main.Entities.CompetitionRegistration;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompetitionRegistrationRepository extends JpaRepository<CompetitionRegistration, Long> {
    List<CompetitionRegistration> findByStudentId(Long studentId);
    boolean existsByStudentIdAndCompetitionId(Long studentId, Long competitionId);
    int countByCompetitionIdAndStatus(Long competitionId, String status);
    List<CompetitionRegistration> findByCompetitionId(Long competitionId);
}
