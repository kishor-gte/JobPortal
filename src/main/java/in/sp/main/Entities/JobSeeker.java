package in.sp.main.Entities;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import in.sp.main.Enums.AccountStatus;
import in.sp.main.Enums.Education;
import in.sp.main.Enums.Gender;
import in.sp.main.Enums.Location;
import in.sp.main.Enums.WorkAvailability;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;

@Entity
public class JobSeeker {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;
    private String password;
    private String role;  // Can be "STUDENT", "INTERVIEWER", "ADMIN"
    private String phone;
    @Enumerated(EnumType.STRING)
    private Location location;
    private Integer age; 
    private String profilePicture;
    private String languagesKnown;
    private String resumeUploaded;  // file path
    private String videoResumeUrl;
    private String identityDocument; 
    private Integer experience; 
    @Enumerated(EnumType.STRING) // Ensures the gender is stored as a string in DB
    private Gender gender; 
    
    @Enumerated(EnumType.STRING)
    private Education education;
    
    @ElementCollection(fetch = FetchType.EAGER)
    private List<String> skills=new ArrayList<>();  // List of skills

    @Enumerated(EnumType.STRING)
    private WorkAvailability workAvailability;  // Enum: FULL_TIME, PART_TIME, FREELANCE, INTERNSHIP
    
    @Enumerated(EnumType.STRING)
    @Column(length = 255)  
    private AccountStatus accountStatus;  // Enum: ACTIVE, DEACTIVATED, BANNED

    private String createdAt;
    private String updatedAt;
    
    private Double annualSalary;
    private String noticePeriod;
    private String resumeHeadline;

    // UG
    private String ugDegree;
    private String ugSpecialization;
    private String ugUniversity;
    private Integer ugGraduationYear;

    // PG
    private String pgDegree;
    private String pgSpecialization;
    private String pgUniversity;
    private Integer pgGraduationYear;

    // Doctorate
    private String doctorateDegree;
    private String doctorateSpecialization;
    private String doctorateUniversity;
    private Integer doctorateGraduationYear;

    private String maritalStatus;
    private String pinCode;
    private LocalDate dateOfBirth;
    private String permanentAddress;


    public JobSeeker() {
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() { return role; }
    
    public void setRole(String role) { this.role = role; }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Location getLocation() {
		return location;
	}

	public void setLocation(Location location) {
		this.location = location;
	}

	public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }


    public String getLanguagesKnown() {
        return languagesKnown;
    }

    public void setLanguagesKnown(String languagesKnown) {
        this.languagesKnown = languagesKnown;
    }

    public String getResumeUploaded() {
        return resumeUploaded;
    }

    public void setResumeUploaded(String resumeUploaded) {
        this.resumeUploaded = resumeUploaded;
    }

    public String getVideoResumeUrl() {
        return videoResumeUrl;
    }

    public void setVideoResumeUrl(String videoResumeUrl) {
        this.videoResumeUrl = videoResumeUrl;
    }
    public List<String> getSkills() {
		return skills;
	}

	public void setSkills(List<String> skills) {
		this.skills = skills;
	}

	public WorkAvailability getWorkAvailability() {
        return workAvailability;
    }

    public void setWorkAvailability(WorkAvailability workAvailability) {
        this.workAvailability = workAvailability;
    }

    public AccountStatus getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(AccountStatus accountStatus) {
        this.accountStatus = accountStatus;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(String updatedAt) {
        this.updatedAt = updatedAt;
    }

	public Integer getAge() {
		return age;
	}

	public void setAge(Integer age) {
		this.age = age;
	}

	public String getIdentityDocument() {
		return identityDocument;
	}

	public void setIdentityDocument(String identityDocument) {
		this.identityDocument = identityDocument;
	}

	public Gender getGender() {
		return gender;
	}

	public void setGender(Gender gender) {
		this.gender = gender;
	}

	public Integer getExperience() {
		return experience;
	}

	public void setExperience(Integer experience) {
		this.experience = experience;
	}

	public Double getAnnualSalary() {
		return annualSalary;
	}

	public void setAnnualSalary(Double annualSalary) {
		this.annualSalary = annualSalary;
	}

	public String getNoticePeriod() {
		return noticePeriod;
	}

	public void setNoticePeriod(String noticePeriod) {
		this.noticePeriod = noticePeriod;
	}

	public String getResumeHeadline() {
		return resumeHeadline;
	}

	public void setResumeHeadline(String resumeHeadline) {
		this.resumeHeadline = resumeHeadline;
	}

	public String getUgDegree() {
		return ugDegree;
	}

	public void setUgDegree(String ugDegree) {
		this.ugDegree = ugDegree;
	}

	public String getUgSpecialization() {
		return ugSpecialization;
	}

	public void setUgSpecialization(String ugSpecialization) {
		this.ugSpecialization = ugSpecialization;
	}

	public String getUgUniversity() {
		return ugUniversity;
	}

	public void setUgUniversity(String ugUniversity) {
		this.ugUniversity = ugUniversity;
	}

	public Integer getUgGraduationYear() {
		return ugGraduationYear;
	}

	public void setUgGraduationYear(Integer ugGraduationYear) {
		this.ugGraduationYear = ugGraduationYear;
	}

	public String getPgDegree() {
		return pgDegree;
	}

	public void setPgDegree(String pgDegree) {
		this.pgDegree = pgDegree;
	}

	public String getPgSpecialization() {
		return pgSpecialization;
	}

	public void setPgSpecialization(String pgSpecialization) {
		this.pgSpecialization = pgSpecialization;
	}

	public String getPgUniversity() {
		return pgUniversity;
	}

	public void setPgUniversity(String pgUniversity) {
		this.pgUniversity = pgUniversity;
	}

	public Integer getPgGraduationYear() {
		return pgGraduationYear;
	}

	public void setPgGraduationYear(Integer pgGraduationYear) {
		this.pgGraduationYear = pgGraduationYear;
	}

	public String getDoctorateDegree() {
		return doctorateDegree;
	}

	public void setDoctorateDegree(String doctorateDegree) {
		this.doctorateDegree = doctorateDegree;
	}

	public String getDoctorateSpecialization() {
		return doctorateSpecialization;
	}

	public void setDoctorateSpecialization(String doctorateSpecialization) {
		this.doctorateSpecialization = doctorateSpecialization;
	}

	public String getDoctorateUniversity() {
		return doctorateUniversity;
	}

	public void setDoctorateUniversity(String doctorateUniversity) {
		this.doctorateUniversity = doctorateUniversity;
	}

	public Integer getDoctorateGraduationYear() {
		return doctorateGraduationYear;
	}

	public void setDoctorateGraduationYear(Integer doctorateGraduationYear) {
		this.doctorateGraduationYear = doctorateGraduationYear;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getPinCode() {
		return pinCode;
	}

	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}

	public LocalDate getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(LocalDate dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getPermanentAddress() {
		return permanentAddress;
	}

	public void setPermanentAddress(String permanentAddress) {
		this.permanentAddress = permanentAddress;
	}

	public Education getEducation() {
		return education;
	}

	public void setEducation(Education education) {
		this.education = education;
	}



}
