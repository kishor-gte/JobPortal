package in.sp.main.rest.common.response;

public class ApiResponse<T> extends BaseResponse {
    private T data;

    public ApiResponse(int status, boolean success, String message, T data) {
        super(status, success, message);
        this.data = data;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
