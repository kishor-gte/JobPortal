package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import in.sp.main.Entities.AssessmentQuestion;

public interface AssessmentQuestionRepository extends JpaRepository<AssessmentQuestion, Long> {

    List<AssessmentQuestion> findBySkillAndSourceType(String skill, String sourceType);

    List<AssessmentQuestion> findBySkillAndSourceTypeAndJobIdAndRecruiterId(
        String skill, String sourceType, Long jobId, Long recruiterId);
    
    // New method: fetch questions by skill, sourceType, and jobId (recruiterId can be null)
    List<AssessmentQuestion> findBySkillAndSourceTypeAndJobId(
        String skill, String sourceType, Long jobId);

	void deleteBySkill(String skill);

	List<AssessmentQuestion> findBySkill(String skill);

	@Query("SELECT DISTINCT q.skill FROM AssessmentQuestion q WHERE q.sourceType = 'ADMIN'")
	List<String> findDistinctSkillsBySourceType(@Param("sourceType") String sourceType);

	@Query("SELECT DISTINCT q.skill FROM AssessmentQuestion q WHERE q.jobId = :jobId AND q.recruiterId = :recruiterId")
	List<String> findDistinctSkillsByJobIdAndRecruiterId(@Param("jobId") Long jobId, @Param("recruiterId") Long recruiterId);


}
