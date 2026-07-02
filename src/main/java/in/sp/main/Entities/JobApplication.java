package in.sp.main.Entities;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;

import in.sp.main.Enums.ApplicationStatus;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Transient;

@Entity
public class JobApplication {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Job job;

    @ManyToOne
    private JobSeeker jobSeeker;

    @Enumerated(EnumType.STRING)
    private ApplicationStatus status;

    private LocalDate appliedDate;
    private LocalDateTime lastUpdated;

    private LocalDateTime interviewDate; // only for INTERVIEW_SCHEDULED

    private String recruiterRemarks;

    // Additional fields for DAO compatibility
    @Transient
    private Long jobId;
    
    @Transient
    private Long applicantId;
    
    private String resumePath;
    private String resumeFileName;
    private Integer resumeScore;
    private String scoreSuggestions;
    private String coverLetter;
    private String aptitudeLink;
    private String codingLink;
    private String hrLink;
    
    @Transient
    private Timestamp appliedAt;
    
    @Transient
    private Timestamp updatedAt;
    
    @Transient
    private String applicantName;
    
    @Transient
    private String applicantEmail;
    
    @Transient
    private String jobTitle;
    
    @Transient
    private String companyName;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Job getJob() {
		return job;
	}

	public void setJob(Job job) {
		this.job = job;
	}

	public JobSeeker getJobSeeker() {
		return jobSeeker;
	}

	public void setJobSeeker(JobSeeker jobSeeker) {
		this.jobSeeker = jobSeeker;
	}

	public ApplicationStatus getStatus() {
		return status;
	}

	public void setStatus(ApplicationStatus status) {
		this.status = status;
	}

	public LocalDate getAppliedDate() {
		return appliedDate;
	}

	public void setAppliedDate(LocalDate appliedDate) {
		this.appliedDate = appliedDate;
	}

	public LocalDateTime getLastUpdated() {
		return lastUpdated;
	}

	public void setLastUpdated(LocalDateTime lastUpdated) {
		this.lastUpdated = lastUpdated;
	}

	

	public LocalDateTime getInterviewDate() {
		return interviewDate;
	}

	public void setInterviewDate(LocalDateTime interviewDate) {
		this.interviewDate = interviewDate;
	}

	public String getRecruiterRemarks() {
		return recruiterRemarks;
	}

	public void setRecruiterRemarks(String recruiterRemarks) {
		this.recruiterRemarks = recruiterRemarks;
	}

    // DAO-compatible getters/setters
    public Long getJobId() {
        if (job != null) {
            return job.getId();
        }
        return jobId;
    }

    public void setJobId(Long jobId) {
        this.jobId = jobId;
    }

    public Long getApplicantId() {
        if (jobSeeker != null) {
            return jobSeeker.getId();
        }
        return applicantId;
    }

    public void setApplicantId(Long applicantId) {
        this.applicantId = applicantId;
    }

    public String getResumePath() {
        return resumePath;
    }

    public void setResumePath(String resumePath) {
        this.resumePath = resumePath;
    }

    public String getResumeFileName() {
        return resumeFileName;
    }

    public void setResumeFileName(String resumeFileName) {
        this.resumeFileName = resumeFileName;
    }

    public Integer getResumeScore() {
        return resumeScore;
    }

    public void setResumeScore(Integer resumeScore) {
        this.resumeScore = resumeScore;
    }

    public String getScoreSuggestions() {
        return scoreSuggestions;
    }

    public void setScoreSuggestions(String scoreSuggestions) {
        this.scoreSuggestions = scoreSuggestions;
    }

    public String getCoverLetter() {
        return coverLetter;
    }

    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }

    public String getAptitudeLink() {
        return aptitudeLink;
    }

    public void setAptitudeLink(String aptitudeLink) {
        this.aptitudeLink = aptitudeLink;
    }

    public String getCodingLink() {
        return codingLink;
    }

    public void setCodingLink(String codingLink) {
        this.codingLink = codingLink;
    }

    public String getHrLink() {
        return hrLink;
    }

    public void setHrLink(String hrLink) {
        this.hrLink = hrLink;
    }

    public Timestamp getAppliedAt() {
        if (appliedAt != null) {
            return appliedAt;
        }
        if (appliedDate != null) {
            return Timestamp.valueOf(appliedDate.atStartOfDay());
        }
        return null;
    }

    public void setAppliedAt(Timestamp appliedAt) {
        this.appliedAt = appliedAt;
        if (appliedAt != null) {
            this.appliedDate = appliedAt.toLocalDateTime().toLocalDate();
        }
    }

    public Timestamp getUpdatedAt() {
        if (updatedAt != null) {
            return updatedAt;
        }
        if (lastUpdated != null) {
            return Timestamp.valueOf(lastUpdated);
        }
        return null;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getApplicantName() {
        if (jobSeeker != null) {
            return jobSeeker.getName();
        }
        return applicantName;
    }

    public void setApplicantName(String applicantName) {
        this.applicantName = applicantName;
    }

    public String getApplicantEmail() {
        if (jobSeeker != null) {
            return jobSeeker.getEmail();
        }
        return applicantEmail;
    }

    public void setApplicantEmail(String applicantEmail) {
        this.applicantEmail = applicantEmail;
    }

    public String getJobTitle() {
        if (job != null) {
            return job.getTitle();
        }
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getCompanyName() {
        if (job != null) {
            return job.getCompanyName();
        }
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    // String status getter/setter for DAO compatibility
    public void setStatus(String status) {
        try {
            this.status = ApplicationStatus.valueOf(status);
        } catch (IllegalArgumentException e) {
        }
    }
}

