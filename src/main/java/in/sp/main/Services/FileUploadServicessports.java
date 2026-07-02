package in.sp.main.Services;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletContext;

@Service
public class FileUploadServicessports {

    private final ServletContext servletContext;

    public FileUploadServicessports(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    // EXISTING METHOD (UNCHANGED)
    public String saveFile(MultipartFile file) throws IOException {
        return saveFileToSubFolder(file, "uploads");
    }

    // ✅ NEW METHOD: SAVE TO SUBFOLDER UNDER /uploads
    public String saveFileToSubFolder(MultipartFile file, String subFolder)
            throws IOException {

        if (file == null || file.isEmpty()) {
            throw new IllegalArgumentException("File is empty");
        }

        // Base uploads directory
        String baseUploadDir = servletContext.getRealPath("/uploads/");
        File baseFolder = new File(baseUploadDir);
        if (!baseFolder.exists()) {
            baseFolder.mkdirs();
        }

        // Subfolder (organizer-documents / organizer-photos)
        File targetFolder = new File(baseFolder, subFolder);
        if (!targetFolder.exists()) {
            targetFolder.mkdirs();
        }

        // Unique filename
        String fileName =
                UUID.randomUUID() + "_" + file.getOriginalFilename();

        File destination = new File(targetFolder, fileName);
        file.transferTo(destination);

        // 🔥 Return relative path (USED IN JSP)
        return "/uploads/" + subFolder + "/" + fileName;
    }
}
