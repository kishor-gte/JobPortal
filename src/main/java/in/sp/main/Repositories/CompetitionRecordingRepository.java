package in.sp.main.Repositories;

import in.sp.main.Entities.CompetitionRecording;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CompetitionRecordingRepository extends JpaRepository<CompetitionRecording, Long> {
    List<CompetitionRecording> findByCompetitionId(Long competitionId);
    List<CompetitionRecording> findByStudentId(Long studentId);
    CompetitionRecording findByCompetitionIdAndStudentId(Long competitionId, Long studentId);
}
