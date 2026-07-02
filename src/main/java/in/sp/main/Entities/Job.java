package in.sp.main.Entities;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;

import in.sp.main.Enums.Education;
import in.sp.main.Enums.EmploymentType;
import in.sp.main.Enums.JobCategory;
import in.sp.main.Enums.JobSector;
import in.sp.main.Enums.JobStatus;
import in.sp.main.Enums.Location;
import in.sp.main.Enums.WorkMode;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Size;


@Entity
public class Job {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    @Column(length = 5000)
    private String description;

    @ManyToOne
    @JoinColumn(name = "company_id")
    private Company company;

    @Enumerated(EnumType.STRING)
    @Column(length = 50)
    private Location location;

    @Enumerated(EnumType.STRING)
    private EmploymentType employmentType;
    private Double salaryMin;
    private Double salaryMax;

    private int experienceRequired;

    @Enumerated(EnumType.STRING)
    private WorkMode workMode;
    private boolean equityOffered;
    @Enumerated(EnumType.STRING)
    private Education education;


    private String skillRequirement;

    @Transient
    @Size(max = 500, message = "Job category cannot exceed 500 characters")
    private String jobCategoryString;

    @Enumerated(EnumType.STRING)
    @Column(name = "job_category", length = 500)
    private JobCategory jobCategory;


    @Enumerated(EnumType.STRING)
    private JobSector jobSector;


    private LocalDate postedDate;
    private LocalDate expiryDate;

    @Enumerated(EnumType.STRING)
    private JobStatus status;

    private boolean isVerified;

    @Transient
    private Long companyId;
    
    @Transient
    private String companyName;
    
    @Transient
    private int applicantCount;
    
    @Transient
    private String experienceLevel;
    
    @Transient
    private String skills;
    
    @Transient
    private String jobType;
    
    @Transient
    private String salary;
    
    @Transient
    private Timestamp createdAt;
    
    @Transient
    private Timestamp updatedAt;
    
    @ManyToMany
    @JoinTable(
        name = "job_tags",
        joinColumns = @JoinColumn(name = "job_id"),
        inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    private List<Tag> jobtags;

    @ManyToOne
    @JoinColumn(name = "created_by")
    private Recruiter createdBy;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Long getCompanyId() {
		if (company != null) {
			return company.getId();
		}
		return companyId;
	}

	public void setCompanyId(Long companyId) {
		this.companyId = companyId;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyName() {
		if (company != null) {
			return company.getName();
		}
		return companyName;
	}

	public int getApplicantCount() {
		return applicantCount;
	}

	public void setApplicantCount(int applicantCount) {
		this.applicantCount = applicantCount;
	}

	public String getExperienceLevel() {
		if (experienceLevel != null) {
			return experienceLevel;
		}
		return String.valueOf(experienceRequired);
	}

	public void setExperienceLevel(String experienceLevel) {
		this.experienceLevel = experienceLevel;
		try {
			this.experienceRequired = Integer.parseInt(experienceLevel);
		} catch (NumberFormatException e) {
		}
	}

	public String getSkills() {
		if (skills != null) {
			return skills;
		}
		return skillRequirement;
	}

	public void setSkills(String skills) {
		this.skills = skills;
		this.skillRequirement = skills;
	}

	public String getJobType() {
		if (jobType != null) {
			return jobType;
		}
		if (employmentType != null) {
			return employmentType.name();
		}
		return null;
	}

	public void setJobType(String jobType) {
		this.jobType = jobType;
		try {
			this.employmentType = EmploymentType.valueOf(jobType);
		} catch (IllegalArgumentException e) {
		}
	}

	public String getSalary() {
		if (salary != null) {
			return salary;
		}
		if (salaryMin != null && salaryMax != null) {
			return salaryMin + " - " + salaryMax;
		}
		return null;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public Timestamp getCreatedAt() {
		if (createdAt != null) {
			return createdAt;
		}
		if (postedDate != null) {
			return Timestamp.valueOf(postedDate.atStartOfDay());
		}
		return null;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
		if (createdAt != null) {
			this.postedDate = createdAt.toLocalDateTime().toLocalDate();
		}
	}

	public Timestamp getUpdatedAt() {
		if (updatedAt != null) {
			return updatedAt;
		}
		return null;
	}

	public void setUpdatedAt(Timestamp updatedAt) {
		this.updatedAt = updatedAt;
	}

	public String getStatus() {
		if (status != null) {
			return status.name();
		}
		return null;
	}

	public void setStatus(String status) {
		try {
			this.status = JobStatus.valueOf(status);
		} catch (IllegalArgumentException e) {
		}
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}



	public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	public EmploymentType getEmploymentType() {
		return employmentType;
	}

	public void setEmploymentType(EmploymentType employmentType) {
		this.employmentType = employmentType;
	}

	public Double getSalaryMin() {
		return salaryMin;
	}

	public void setSalaryMin(Double salaryMin) {
		this.salaryMin = salaryMin;
	}

	public Double getSalaryMax() {
		return salaryMax;
	}

	public void setSalaryMax(Double salaryMax) {
		this.salaryMax = salaryMax;
	}

	public int getExperienceRequired() {
		return experienceRequired;
	}

	public void setExperienceRequired(int experienceRequired) {
		this.experienceRequired = experienceRequired;
	}

	public WorkMode getWorkMode() {
		return workMode;
	}

	public void setWorkMode(WorkMode workMode) {
		this.workMode = workMode;
	}

	public boolean isEquityOffered() {
		return equityOffered;
	}

	public void setEquityOffered(boolean equityOffered) {
		this.equityOffered = equityOffered;
	}

	public Education getEducation() {
		return education;
	}

	public void setEducation(Education education) {
		this.education = education;
	}

	public String getSkillRequirement() {
		return skillRequirement;
	}

	public void setSkillRequirement(String skillRequirement) {
		this.skillRequirement = skillRequirement;
	}

	public JobCategory getJobCategory() {
		return jobCategory;
	}

	public void setJobCategory(JobCategory jobCategory) {
		this.jobCategory = jobCategory;
	}

	public JobSector getJobSector() {
		return jobSector;
	}

	public void setJobSector(JobSector jobSector) {
		this.jobSector = jobSector;
	}

	public LocalDate getPostedDate() {
		return postedDate;
	}

	public void setPostedDate(LocalDate postedDate) {
		this.postedDate = postedDate;
	}

	public LocalDate getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(LocalDate expiryDate) {
		this.expiryDate = expiryDate;
	}


	public void setStatus(JobStatus status) {
		this.status = status;
	}

	public boolean isVerified() {
		return isVerified;
	}

	public void setVerified(boolean isVerified) {
		this.isVerified = isVerified;
	}

	public List<Tag> getJobtags() {
		return jobtags;
	}

	public void setJobtags(List<Tag> jobtags) {
		this.jobtags = jobtags;
	}

	public Recruiter getCreatedBy() {
		return createdBy;
	}

	public void setCreatedBy(Recruiter createdBy) {
		this.createdBy = createdBy;
	}

	public String getJobCategoryString() {
		return jobCategoryString;
	}

	public void setJobCategoryString(String jobCategoryString) {
		this.jobCategoryString = jobCategoryString;
	}
}