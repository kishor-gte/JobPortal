package in.sp.main.Entities;

import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class AssessmentResult {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long jobSeekerId;
    private Long recruiterId;   // null if badge
    private Long jobId;         // null if badge
    private String skill;
    private String type;        // "BADGE" or "JOB"

    private int totalQuestions;
    private int correctAnswers;
    private LocalDateTime submittedAt;
    
    // Transient fields (not persisted to database, used for display)
    private transient double percentageScore;
    private transient int wrongAnswers;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Long getJobSeekerId() {
		return jobSeekerId;
	}
	public void setJobSeekerId(Long jobSeekerId) {
		this.jobSeekerId = jobSeekerId;
	}
	public Long getRecruiterId() {
		return recruiterId;
	}
	public void setRecruiterId(Long recruiterId) {
		this.recruiterId = recruiterId;
	}
	public Long getJobId() {
		return jobId;
	}
	public void setJobId(Long jobId) {
		this.jobId = jobId;
	}
	public String getSkill() {
		return skill;
	}
	public void setSkill(String skill) {
		this.skill = skill;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getTotalQuestions() {
		return totalQuestions;
	}
	public void setTotalQuestions(int totalQuestions) {
		this.totalQuestions = totalQuestions;
	}
	public int getCorrectAnswers() {
		return correctAnswers;
	}
	public void setCorrectAnswers(int correctAnswers) {
		this.correctAnswers = correctAnswers;
	}
	public LocalDateTime getSubmittedAt() {
		return submittedAt;
	}
	public void setSubmittedAt(LocalDateTime submittedAt) {
		this.submittedAt = submittedAt;
	}
	
	public double getPercentageScore() {
		return percentageScore;
	}
	
	public void setPercentageScore(double percentageScore) {
		this.percentageScore = percentageScore;
	}
	
	public int getWrongAnswers() {
		return wrongAnswers;
	}
	
	public void setWrongAnswers(int wrongAnswers) {
		this.wrongAnswers = wrongAnswers;
	}
	
	public AssessmentResult findTopByJobSeekerIdAndJobIdAndRecruiterIdOrderBySubmittedAtDesc(Long id2, Long jobId2,
			Long recruiterId2) {
		// TODO Auto-generated method stub
		return null;
	}
    
}
