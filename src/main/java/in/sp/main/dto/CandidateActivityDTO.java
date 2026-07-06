package in.sp.main.dto;

import in.sp.main.Entities.UserActivity;
import in.sp.main.Enums.ApplicationStatus;

public class CandidateActivityDTO {
    
    private UserActivity activity;
    private String jobTitle;
    private String candidateProfilePicture;
    private ApplicationStatus applicationStatus;
    private String resumePath;

    public CandidateActivityDTO() {
    }

    public CandidateActivityDTO(UserActivity activity, String jobTitle, String candidateProfilePicture, ApplicationStatus applicationStatus, String resumePath) {
        this.activity = activity;
        this.jobTitle = jobTitle;
        this.candidateProfilePicture = candidateProfilePicture;
        this.applicationStatus = applicationStatus;
        this.resumePath = resumePath;
    }

    public UserActivity getActivity() {
        return activity;
    }

    public void setActivity(UserActivity activity) {
        this.activity = activity;
    }

    public String getJobTitle() {
        return jobTitle;
    }

    public void setJobTitle(String jobTitle) {
        this.jobTitle = jobTitle;
    }

    public String getCandidateProfilePicture() {
        return candidateProfilePicture;
    }

    public void setCandidateProfilePicture(String candidateProfilePicture) {
        this.candidateProfilePicture = candidateProfilePicture;
    }

    public ApplicationStatus getApplicationStatus() {
        return applicationStatus;
    }

    public void setApplicationStatus(ApplicationStatus applicationStatus) {
        this.applicationStatus = applicationStatus;
    }

    public String getResumePath() {
        return resumePath;
    }

    public void setResumePath(String resumePath) {
        this.resumePath = resumePath;
    }
}
