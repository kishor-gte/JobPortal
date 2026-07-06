package in.sp.main.Services;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class FileUploadServices {

    private final ServletContext servletContext;
    
    // Allowed file types for different upload purposes
    private static final List<String> ALLOWED_IMAGE_TYPES = Arrays.asList(
        "image/jpeg", "image/png", "image/gif", "image/webp"
    );
    
    private static final List<String> ALLOWED_DOCUMENT_TYPES = Arrays.asList(
        "application/pdf",
        "application/msword",
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
        "application/vnd.ms-excel",
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    );
    
    private static final List<String> ALLOWED_VIDEO_TYPES = Arrays.asList(
        "video/mp4", "video/webm", "video/ogg", "video/quicktime"
    );
    
    // Maximum file sizes (in bytes)
    private static final long MAX_IMAGE_SIZE = 5 * 1024 * 1024; // 5MB
    private static final long MAX_DOCUMENT_SIZE = 10 * 1024 * 1024; // 10MB
    private static final long MAX_VIDEO_SIZE = 100 * 1024 * 1024; // 100MB

    public FileUploadServices(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    /**
     * Save image file with validation
     */
    public String saveImage(MultipartFile file) throws IOException {
        return saveFile(file, ALLOWED_IMAGE_TYPES, MAX_IMAGE_SIZE, "image");
    }
    
    /**
     * Save document file (resume, identity doc) with validation
     */
    public String saveDocument(MultipartFile file) throws IOException {
        return saveFile(file, ALLOWED_DOCUMENT_TYPES, MAX_DOCUMENT_SIZE, "document");
    }
    
    /**
     * Save video file with validation
     */
    public String saveVideo(MultipartFile file) throws IOException {
        return saveFile(file, ALLOWED_VIDEO_TYPES, MAX_VIDEO_SIZE, "video");
    }
    
    /**
     * Generic save file method with validation
     */
    private String saveFile(MultipartFile file, List<String> allowedTypes, long maxSize, String fileType) throws IOException {
        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("File is empty or null");
        }

        // Validate file size
        if (file.getSize() > maxSize) {
            throw new IOException("File size exceeds maximum allowed size of " + (maxSize / 1024 / 1024) + "MB");
        }

        // Validate MIME type
        String contentType = file.getContentType();
        if (contentType == null || !allowedTypes.contains(contentType.toLowerCase())) {
            throw new IOException("Invalid file type. Allowed types: " + String.join(", ", allowedTypes));
        }

        // Validate file extension
        String originalFilename = StringUtils.cleanPath(file.getOriginalFilename());
        if (originalFilename.contains("..")) {
            throw new IOException("Invalid filename: path traversal not allowed");
        }
        
        String extension = getFileExtension(originalFilename);
        if (!isAllowedExtension(extension, allowedTypes)) {
            throw new IOException("Invalid file extension: " + extension);
        }

        // Define upload directory - outside web root for security
        String uploadDir = System.getProperty("user.home") + "/jobportal-uploads/" + fileType + "/";
        File uploadFolder = new File(uploadDir);

        // Create folder if it doesn't exist
        if (!uploadFolder.exists()) {
            uploadFolder.mkdirs();
        }

        // Generate a unique filename - DO NOT use original filename
        String safeFilename = UUID.randomUUID().toString() + "." + extension;
        String filePath = uploadDir + File.separator + safeFilename;

        // Additional security: check for directory traversal in final path
        File destinationFile = new File(filePath);
        if (!destinationFile.getCanonicalPath().startsWith(uploadFolder.getCanonicalPath())) {
            throw new IOException("Invalid file path: directory traversal detected");
        }

        // Save the file
        file.transferTo(destinationFile);

        // Return the relative path for frontend access
        return "/uploads/" + fileType + "/" + safeFilename;
    }
    
    /**
     * Save company logo with validation
     */
    public String saveLogo(MultipartFile file) throws IOException {
        return saveFile(file, ALLOWED_IMAGE_TYPES, MAX_IMAGE_SIZE, "logo");
    }
    
    /**
     * Legacy method - delegates to saveDocument for backward compatibility
     * @deprecated Use saveDocument() instead
     */
    @Deprecated
    public String saveFile(MultipartFile file) throws IOException {
        return saveDocument(file);
    }
    
    private String getFileExtension(String filename) {
        if (filename == null || !filename.contains(".")) {
            return "";
        }
        return filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
    }
    
    private boolean isAllowedExtension(String extension, List<String> allowedTypes) {
        if (extension.isEmpty()) {
            return false;
        }
        
        // Map extensions to MIME types
        switch (extension) {
            case "jpg":
            case "jpeg":
            case "jfif":
                return allowedTypes.contains("image/jpeg");
            case "png":
                return allowedTypes.contains("image/png");
            case "gif":
                return allowedTypes.contains("image/gif");
            case "webp":
                return allowedTypes.contains("image/webp");
            case "pdf":
                return allowedTypes.contains("application/pdf");
            case "doc":
                return allowedTypes.contains("application/msword");
            case "docx":
                return allowedTypes.contains("application/vnd.openxmlformats-officedocument.wordprocessingml.document");
            case "xls":
                return allowedTypes.contains("application/vnd.ms-excel");
            case "xlsx":
                return allowedTypes.contains("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
            case "mp4":
                return allowedTypes.contains("video/mp4");
            case "webm":
                return allowedTypes.contains("video/webm");
            case "ogg":
                return allowedTypes.contains("video/ogg");
            case "mov":
                return allowedTypes.contains("video/quicktime");
            default:
                return false;
        }
    }

}
