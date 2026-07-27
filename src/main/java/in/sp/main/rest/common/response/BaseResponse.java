package in.sp.main.rest.common.response;

import java.time.LocalDateTime;

public abstract class BaseResponse {
    private LocalDateTime timestamp;
    private int status;
    private boolean success;
    private String message;

    public BaseResponse(int status, boolean success, String message) {
        this.timestamp = LocalDateTime.now();
        this.status = status;
        this.success = success;
        this.message = message;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
