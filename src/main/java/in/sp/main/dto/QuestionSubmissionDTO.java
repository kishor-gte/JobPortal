package in.sp.main.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class QuestionSubmissionDTO {
    
    @NotBlank(message = "Question content is required")
    @Size(min = 10, max = 1000, message = "Question must be between 10 and 1000 characters")
    private String content;
    
    @Size(max = 50, message = "Display name must be less than 50 characters")
    private String displayName;

    public String getDisplayName() {
		return displayName;
	}

	public void setDisplayName(String displayName) {
		this.displayName = displayName;
	}

	public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}