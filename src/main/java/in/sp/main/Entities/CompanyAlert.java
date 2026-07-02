package in.sp.main.Entities;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "company_alerts")
public class CompanyAlert {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // === Mandatory ===
    @Column(nullable = false)
    private String companyName;

    @Column(nullable = false, length = 2500)
    private String reportReason;

    // === Optional Company Info ===
    private String industry;
    private String location;
    private String website;
    private String linkedinUrl;

    // === Optional Context ===
    private String howDidYouKnow; 
    // e.g. Interview, HR Call, Friend, Online Review, Offer Letter, Consultancy

    private String issueType;
    // Scam / Fake Hiring / Toxic / Money Asked / Ghosting / MLM / Other

    private String roleMentioned; // if any
    private boolean interviewAttended; // true / false / not sure

    // === Reporter Info (Optional) ===
    private String reporterName;
    private String reporterEmail;

    // === System ===
    private LocalDateTime reportedAt = LocalDateTime.now();
    private boolean verified = false;
    private boolean hidden = false;
    
 // Community validation
    private int agreeCount;

    // Optional: track unique endorsers later
    // private Set<Long> agreedUserIds;

    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getReportReason() {
		return reportReason;
	}
	public void setReportReason(String reportReason) {
		this.reportReason = reportReason;
	}
	public String getIndustry() {
		return industry;
	}
	public void setIndustry(String industry) {
		this.industry = industry;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getWebsite() {
		return website;
	}
	public void setWebsite(String website) {
		this.website = website;
	}
	public String getLinkedinUrl() {
		return linkedinUrl;
	}
	public void setLinkedinUrl(String linkedinUrl) {
		this.linkedinUrl = linkedinUrl;
	}
	public String getHowDidYouKnow() {
		return howDidYouKnow;
	}
	public void setHowDidYouKnow(String howDidYouKnow) {
		this.howDidYouKnow = howDidYouKnow;
	}
	public String getIssueType() {
		return issueType;
	}
	public void setIssueType(String issueType) {
		this.issueType = issueType;
	}
	public String getRoleMentioned() {
		return roleMentioned;
	}
	public void setRoleMentioned(String roleMentioned) {
		this.roleMentioned = roleMentioned;
	}
	public boolean isInterviewAttended() {
		return interviewAttended;
	}
	public void setInterviewAttended(boolean interviewAttended) {
		this.interviewAttended = interviewAttended;
	}
	public String getReporterName() {
		return reporterName;
	}
	public void setReporterName(String reporterName) {
		this.reporterName = reporterName;
	}
	public String getReporterEmail() {
		return reporterEmail;
	}
	public void setReporterEmail(String reporterEmail) {
		this.reporterEmail = reporterEmail;
	}
	public LocalDateTime getReportedAt() {
		return reportedAt;
	}
	public void setReportedAt(LocalDateTime reportedAt) {
		this.reportedAt = reportedAt;
	}
	public boolean isVerified() {
		return verified;
	}
	public void setVerified(boolean verified) {
		this.verified = verified;
	}
	public boolean isHidden() {
		return hidden;
	}
	public void setHidden(boolean hidden) {
		this.hidden = hidden;
	}
	public int getAgreeCount() {
		return agreeCount;
	}
	public void setAgreeCount(int agreeCount) {
		this.agreeCount = agreeCount;
	}

    // Getters & Setters
    
    
}
