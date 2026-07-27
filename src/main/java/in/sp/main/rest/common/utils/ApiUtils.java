package in.sp.main.rest.common.utils;

import in.sp.main.rest.common.response.ApiResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

public class ApiUtils {

    public static <T> ResponseEntity<ApiResponse<T>> success(T data) {
        ApiResponse<T> response = new ApiResponse<>(HttpStatus.OK.value(), true, RestConstants.MSG_SUCCESS, data);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    public static <T> ResponseEntity<ApiResponse<T>> success(T data, String message) {
        ApiResponse<T> response = new ApiResponse<>(HttpStatus.OK.value(), true, message, data);
        return new ResponseEntity<>(response, HttpStatus.OK);
    }

    public static <T> ResponseEntity<ApiResponse<T>> created(T data, String message) {
        ApiResponse<T> response = new ApiResponse<>(HttpStatus.CREATED.value(), true, message, data);
        return new ResponseEntity<>(response, HttpStatus.CREATED);
    }
}
