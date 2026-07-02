package in.sp.main.dto;

import in.sp.main.Entities.AssessmentResult;
import in.sp.main.Entities.JobApplication;

public class JobApplicationWithResult {
    private JobApplication application;
    private AssessmentResult latestResult;
	public JobApplication getApplication() {
		return application;
	}
	public void setApplication(JobApplication application) {
		this.application = application;
	}
	public AssessmentResult getLatestResult() {
		return latestResult;
	}
	public void setLatestResult(AssessmentResult latestResult) {
		this.latestResult = latestResult;
	}
	public JobApplicationWithResult(JobApplication application, AssessmentResult latestResult) {
		super();
		this.application = application;
		this.latestResult = latestResult;
	}
	public JobApplicationWithResult() {
		super();
	}
    
    // constructor, getters, setters
    
}
