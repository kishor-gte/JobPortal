package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.AssessmentInvitation;

public interface AssessmentInvitationRepository extends JpaRepository<AssessmentInvitation, Long> {

    List<AssessmentInvitation> findByJobSeekerIdAndStatus(Long jobSeekerId, String status);
    
    boolean existsByJobSeekerIdAndJobIdAndSkill(Long jobSeekerId, Long jobId, String skill);
    
    List<AssessmentInvitation> findByJobIdAndSkill(Long jobId, String skill);
}
