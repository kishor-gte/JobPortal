package in.sp.main.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public class AnswerSubmissionDTO {
    
    @NotNull(message = "Question ID is required")
    private Long questionId;
    
    @NotBlank(message = "Answer content is required")
    @Size(min = 10, max = 2000, message = "Answer must be between 10 and 2000 characters")
    private String content;

    public Long getQuestionId() {
        return questionId;
    }

    public void setQuestionId(Long questionId) {
        this.questionId = questionId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}