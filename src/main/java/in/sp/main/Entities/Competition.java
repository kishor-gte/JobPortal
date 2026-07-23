package in.sp.main.Entities;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.util.List;
import java.util.ArrayList;

@Entity
@Table(name = "competitions")
public class Competition {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @Column(nullable = false)
    private String title;
    
    @Column(columnDefinition = "TEXT", nullable = false)
    private String description;
    
    @Column(columnDefinition = "TEXT", nullable = false)
    private String rules;
    
    @Column(nullable = false)
    private String difficulty;
    
    @Column(nullable = false)
    private String allowedLanguages;
    
    private String bannerImage;
    
    @Column(nullable = false)
    private int numberOfQuestions;
    
    // Registration Settings
    @Column(nullable = false)
    private LocalDateTime registrationStartTime;
    
    @Column(nullable = false)
    private LocalDateTime registrationEndTime;
    
    @Column(nullable = false)
    private int maxParticipants;
    
    private boolean allowWaitlist;
    private boolean autoCloseRegistration;
    
    // Exam Settings
    @Column(nullable = false)
    private LocalDateTime examStartTime;
    
    @Column(nullable = false)
    private int examDurationMinutes;
    
    private boolean autoSubmit;
    
    // Security Settings
    private boolean disableCopyPaste;
    private boolean disableRightClick;
    private boolean fullScreenMode;
    private boolean autoSubmitTabSwitch;
    private boolean oneLoginPerCandidate;
    
    // Publish Settings
    @Column(nullable = false)
    private String status; // DRAFT, PUBLISHED, CANCELLED
    
    private Long createdBy;
    
    @ElementCollection
    @CollectionTable(name = "competition_questions", joinColumns = @JoinColumn(name = "competition_id"))
    @Column(name = "question_id")
    private List<Long> codingQuestionIds = new ArrayList<>();
    
    private LocalDateTime createdAt;
    
    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getRules() { return rules; }
    public void setRules(String rules) { this.rules = rules; }
    
    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }
    
    public String getAllowedLanguages() { return allowedLanguages; }
    public void setAllowedLanguages(String allowedLanguages) { this.allowedLanguages = allowedLanguages; }
    
    public String getBannerImage() { return bannerImage; }
    public void setBannerImage(String bannerImage) { this.bannerImage = bannerImage; }
    
    public int getNumberOfQuestions() { return numberOfQuestions; }
    public void setNumberOfQuestions(int numberOfQuestions) { this.numberOfQuestions = numberOfQuestions; }
    
    public LocalDateTime getRegistrationStartTime() { return registrationStartTime; }
    public void setRegistrationStartTime(LocalDateTime registrationStartTime) { this.registrationStartTime = registrationStartTime; }
    
    public LocalDateTime getRegistrationEndTime() { return registrationEndTime; }
    public void setRegistrationEndTime(LocalDateTime registrationEndTime) { this.registrationEndTime = registrationEndTime; }
    
    public int getMaxParticipants() { return maxParticipants; }
    public void setMaxParticipants(int maxParticipants) { this.maxParticipants = maxParticipants; }
    
    public boolean isAllowWaitlist() { return allowWaitlist; }
    public void setAllowWaitlist(boolean allowWaitlist) { this.allowWaitlist = allowWaitlist; }
    
    public boolean isAutoCloseRegistration() { return autoCloseRegistration; }
    public void setAutoCloseRegistration(boolean autoCloseRegistration) { this.autoCloseRegistration = autoCloseRegistration; }
    
    public LocalDateTime getExamStartTime() { return examStartTime; }
    public void setExamStartTime(LocalDateTime examStartTime) { this.examStartTime = examStartTime; }
    
    public int getExamDurationMinutes() { return examDurationMinutes; }
    public void setExamDurationMinutes(int examDurationMinutes) { this.examDurationMinutes = examDurationMinutes; }
    
    public boolean isAutoSubmit() { return autoSubmit; }
    public void setAutoSubmit(boolean autoSubmit) { this.autoSubmit = autoSubmit; }
    
    public boolean isDisableCopyPaste() { return disableCopyPaste; }
    public void setDisableCopyPaste(boolean disableCopyPaste) { this.disableCopyPaste = disableCopyPaste; }
    
    public boolean isDisableRightClick() { return disableRightClick; }
    public void setDisableRightClick(boolean disableRightClick) { this.disableRightClick = disableRightClick; }
    
    public boolean isFullScreenMode() { return fullScreenMode; }
    public void setFullScreenMode(boolean fullScreenMode) { this.fullScreenMode = fullScreenMode; }
    
    public boolean isAutoSubmitTabSwitch() { return autoSubmitTabSwitch; }
    public void setAutoSubmitTabSwitch(boolean autoSubmitTabSwitch) { this.autoSubmitTabSwitch = autoSubmitTabSwitch; }
    
    public boolean isOneLoginPerCandidate() { return oneLoginPerCandidate; }
    public void setOneLoginPerCandidate(boolean oneLoginPerCandidate) { this.oneLoginPerCandidate = oneLoginPerCandidate; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public Long getCreatedBy() { return createdBy; }
    public void setCreatedBy(Long createdBy) { this.createdBy = createdBy; }
    
    public List<Long> getCodingQuestionIds() { return codingQuestionIds; }
    public void setCodingQuestionIds(List<Long> codingQuestionIds) { this.codingQuestionIds = codingQuestionIds; }
    
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    /** Helpers for JSP (avoids EL LocalDateTime method-call issues). */
    public LocalDateTime getExamEndTime() {
        if (examStartTime == null) return null;
        return examStartTime.plusMinutes(examDurationMinutes);
    }

    public boolean isExamUpcoming() {
        if (examStartTime == null) return false;
        return examStartTime.isAfter(LocalDateTime.now());
    }

    public boolean isExamLive() {
        if (examStartTime == null) return false;
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime end = examStartTime.plusMinutes(examDurationMinutes);
        return !examStartTime.isAfter(now) && end.isAfter(now);
    }

    public boolean isExamEnded() {
        if (examStartTime == null) return false;
        return !examStartTime.plusMinutes(examDurationMinutes).isAfter(LocalDateTime.now());
    }

    public boolean isRegistrationNotStarted() {
        return registrationStartTime != null && LocalDateTime.now().isBefore(registrationStartTime);
    }

    public boolean isRegistrationClosed() {
        return registrationEndTime != null && LocalDateTime.now().isAfter(registrationEndTime);
    }

    public String getExamStartTimeDisplay() {
        if (examStartTime == null) return "TBA";
        return examStartTime.format(java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy h:mm a"));
    }

    public String getRegistrationStartTimeShort() {
        if (registrationStartTime == null) return "";
        return registrationStartTime.format(java.time.format.DateTimeFormatter.ofPattern("MMM dd, h:mm a"));
    }
}
