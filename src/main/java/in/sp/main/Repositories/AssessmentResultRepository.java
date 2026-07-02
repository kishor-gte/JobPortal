package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.AssessmentResult;

public interface AssessmentResultRepository extends JpaRepository<AssessmentResult, Long> {

    List<AssessmentResult> findByRecruiterIdAndJobId(Long recruiterId, Long jobId);

    List<AssessmentResult> findByType(String type); // "BADGE"
    
    List<AssessmentResult> findByJobSeekerId(Long jobSeekerId);
    
    List<AssessmentResult> findByJobSeekerIdAndType(Long jobSeekerId, String type);

	boolean existsByJobSeekerIdAndSkillAndType(Long jobSeekerId, String skill, String string);

	AssessmentResult findTopByJobSeekerIdAndSkillAndTypeOrderBySubmittedAtDesc(Long jobSeekerId, String skill,
			String string);

	AssessmentResult findTopByJobSeekerIdAndJobIdAndRecruiterIdOrderBySubmittedAtDesc(Long id, Long jobId,
			Long recruiterId);
}
