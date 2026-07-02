package in.sp.main.Services;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.OrganizerDocument;
import in.sp.main.Entities.OrganizerEventPhoto;
import in.sp.main.Entities.SportsOrganizer;
import in.sp.main.Entities.SportsService;
import in.sp.main.Repositories.OrganizerDocumentRepository;
import in.sp.main.Repositories.OrganizerEventPhotoRepository;
import in.sp.main.Repositories.SportsOrganizerRepository;
import in.sp.main.Repositories.SportsServiceRepository;

@Service
public class SportsOrganizerService {

    @Autowired
    private SportsOrganizerRepository organizerRepo;

    @Autowired
    private SportsServiceRepository serviceRepo;
    
    @Autowired
    private OrganizerDocumentRepository documentRepo;

    @Autowired
    private OrganizerEventPhotoRepository photoRepo;

    @Autowired
    private FileUploadServicessports fileUploadServices;

    public void saveOrganizerWithProofs(
            SportsOrganizer organizer,
            MultipartFile[] documents,
            MultipartFile[] eventPhotos) throws IOException {

        organizer.setVerified(false);
        organizer.setCreatedAt(LocalDateTime.now());
        if (organizer.getPassword() != null) {
            organizer.setPassword(BCrypt.hashpw(organizer.getPassword(), BCrypt.gensalt()));
        }

        SportsOrganizer savedOrganizer = organizerRepo.save(organizer);

        // ================= SAVE DOCUMENTS =================
        if (documents != null) {
            for (MultipartFile file : documents) {
                if (file != null && !file.isEmpty()) {

                    String path =
                            fileUploadServices.saveFileToSubFolder(
                                    file, "organizer-documents");

                    OrganizerDocument doc = new OrganizerDocument();
                    doc.setDocumentType("GENERAL_PROOF");
                    doc.setFilePath(path);
                    doc.setVerified(false);
                    doc.setOrganizer(savedOrganizer);

                    documentRepo.save(doc);
                }
            }
        }

        // ================= SAVE EVENT PHOTOS =================
        if (eventPhotos != null) {
            for (MultipartFile photo : eventPhotos) {
                if (photo != null && !photo.isEmpty()) {

                    String path =
                            fileUploadServices.saveFileToSubFolder(
                                    photo, "organizer-photos");

                    OrganizerEventPhoto eventPhoto = new OrganizerEventPhoto();
                    eventPhoto.setFilePath(path);
                    eventPhoto.setOrganizer(savedOrganizer);

                    photoRepo.save(eventPhoto);
                }
            }
        }
    }

    public void save(SportsOrganizer organizer) {
        organizer.setCreatedAt(LocalDateTime.now());
        organizer.setVerified(false); // admin will verify later
        if (organizer.getPassword() != null) {
            organizer.setPassword(BCrypt.hashpw(organizer.getPassword(), BCrypt.gensalt()));
        }
        organizerRepo.save(organizer);
    }

    public SportsOrganizer login(String email, String password) {
        SportsOrganizer organizer = organizerRepo.findByEmail(email);
        if (organizer == null) return null;
        
        boolean matches = false;
        try {
            matches = BCrypt.checkpw(password, organizer.getPassword());
        } catch (Exception e) {}
        
        if (!matches) {
            if (organizer.getPassword().equals(password)) {
                // Migration
                organizer.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
                organizerRepo.save(organizer);
                matches = true;
            }
        }
        
        return matches ? organizer : null;
    }
   
    public List<SportsOrganizer> getVerifiedOrganizers() {
        return organizerRepo.findByVerifiedTrue();
    }

	/*
	 * public List<SportsService> getServices(Long organizerId) { return
	 * serviceRepo.findByOrganizerId(organizerId); }
	 */
    


}
