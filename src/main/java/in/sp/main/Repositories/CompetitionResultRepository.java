package in.sp.main.Repositories;

import in.sp.main.Entities.CompetitionResult;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CompetitionResultRepository extends JpaRepository<CompetitionResult, Long> {
    Optional<CompetitionResult> findByCompetitionIdAndStudentId(Long competitionId, Long studentId);
    
    List<CompetitionResult> findByCompetitionId(Long competitionId);
    
    List<CompetitionResult> findByCompetitionIdOrderByQuestionsSolvedDescSubmittedAtAsc(Long competitionId);
    
    boolean existsByCompetitionIdAndStudentId(Long competitionId, Long studentId);
    
    int countByCompetitionId(Long competitionId);
    
    List<CompetitionResult> findByStudentId(Long studentId);
}
