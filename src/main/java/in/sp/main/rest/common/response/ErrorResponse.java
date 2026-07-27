package in.sp.main.rest.common.response;

public class ErrorResponse extends BaseResponse {
    private String errorCode;

    public ErrorResponse(int status, boolean success, String message, String errorCode) {
        super(status, success, message);
        this.errorCode = errorCode;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }
}
