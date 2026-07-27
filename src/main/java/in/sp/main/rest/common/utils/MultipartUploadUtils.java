package in.sp.main.rest.common.utils;

import org.springframework.web.multipart.MultipartFile;
import java.util.Arrays;
import java.util.List;

public class MultipartUploadUtils {
    
    private static final List<String> ALLOWED_IMAGE_TYPES = Arrays.asList("image/jpeg", "image/png", "image/jpg");
    private static final List<String> ALLOWED_DOCUMENT_TYPES = Arrays.asList("application/pdf");

    public static boolean isValidImage(MultipartFile file) {
        return file != null && !file.isEmpty() && ALLOWED_IMAGE_TYPES.contains(file.getContentType());
    }

    public static boolean isValidDocument(MultipartFile file) {
        return file != null && !file.isEmpty() && ALLOWED_DOCUMENT_TYPES.contains(file.getContentType());
    }
}
