package in.sp.main.Repositories;

import in.sp.main.Entities.CompetitionSubmission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CompetitionSubmissionRepository extends JpaRepository<CompetitionSubmission, Long> {
    
    List<CompetitionSubmission> findByCompetitionIdAndStudentId(Long competitionId, Long studentId);
    
    Optional<CompetitionSubmission> findByCompetitionIdAndStudentIdAndQuestionId(Long competitionId, Long studentId, Long questionId);
}
