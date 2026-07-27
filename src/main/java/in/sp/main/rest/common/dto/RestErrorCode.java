package in.sp.main.rest.common.dto;

public enum RestErrorCode {
    VALIDATION_FAILED("ERR_001", "Validation Failed"),
    UNAUTHORIZED("ERR_002", "Unauthorized Access"),
    FORBIDDEN("ERR_003", "Forbidden Access"),
    NOT_FOUND("ERR_004", "Resource Not Found"),
    INTERNAL_SERVER_ERROR("ERR_500", "Internal Server Error"),
    INVALID_CREDENTIALS("ERR_005", "Invalid Credentials");

    private final String code;
    private final String description;

    RestErrorCode(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public String getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }
}
