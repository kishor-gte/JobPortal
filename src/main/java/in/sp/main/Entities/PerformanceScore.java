package in.sp.main.Entities;

import java.sql.Timestamp;
import jakarta.persistence.*;

@Entity
@Table(name = "performance_scores")
public class PerformanceScore {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(name = "student_id")
    private Long studentId;
    
    @Transient
    private String studentName;
    
    @Column(name = "category_id")
    private Long categoryId;
    
    @Transient
    private String categoryName;
    
    @Column(name = "total_questions")
    private int totalQuestions;
    
    @Column(name = "correct_answers")
    private int correctAnswers;
    
    @Column(name = "avg_score")
    private double avgScore;
    
    @Column(name = "coding_score")
    private double codingScore;
    
    @Column(name = "interview_score")
    private double interviewScore;
    
    @Column(name = "overall_score")
    private double overallScore;
    
    @Column(name = "last_updated")
    private Timestamp lastUpdated;

    public PerformanceScore() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getStudentId() {
        return studentId;
    }

    public void setStudentId(Long studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
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

    public double getAvgScore() {
        return avgScore;
    }

    public void setAvgScore(double avgScore) {
        this.avgScore = avgScore;
    }

    public double getCodingScore() {
        return codingScore;
    }

    public void setCodingScore(double codingScore) {
        this.codingScore = codingScore;
    }

    public double getInterviewScore() {
        return interviewScore;
    }

    public void setInterviewScore(double interviewScore) {
        this.interviewScore = interviewScore;
    }

    public double getOverallScore() {
        return overallScore;
    }

    public void setOverallScore(double overallScore) {
        this.overallScore = overallScore;
    }

    public Timestamp getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Timestamp lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
}
