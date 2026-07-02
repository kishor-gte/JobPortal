package in.sp.main.Services;

import java.util.List;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.CompanyAlert;
import in.sp.main.Entities.CompanyAlertComment;
import in.sp.main.Repositories.CompanyAlertCommentRepository;

@Service
public class CompanyAlertCommentService {

    private final CompanyAlertCommentRepository repository;

    public CompanyAlertCommentService(CompanyAlertCommentRepository repository) {
        this.repository = repository;
    }

    public void save(CompanyAlertComment comment) {
        repository.save(comment);
    }

    public List<CompanyAlertComment> getComments(Long alertId) {
        List<CompanyAlertComment> comments = repository.findByAlertIdAndHiddenFalseOrderByCommentedAtAsc(alertId);
        
        // Find the LATEST admin comment (the one we want to pin)
        CompanyAlertComment latestAdminComment = null;
        for (int i = comments.size() - 1; i >= 0; i--) {
            if (comments.get(i).isAdminComment()) {
                latestAdminComment = comments.get(i);
                break; // Found the newest one
            }
        }

        if (latestAdminComment != null) {
            // Remove it from its current position
            comments.remove(latestAdminComment);
            // Add it to the very top
            comments.add(0, latestAdminComment);
        }
        
        return comments;
    }
    
    public void saveAdminComment(CompanyAlert alert, String commentText) {
        CompanyAlertComment comment = new CompanyAlertComment();
        comment.setAlert(alert);
        comment.setCommentText(commentText);
        comment.setCommenterName("Jobu Admin");
        comment.setAdminComment(true);
        // DO NOT SET ID
        repository.save(comment);
    }
    public List<CompanyAlertComment> getAdminComments(Long alertId) {
        return repository.findByAlertIdAndAdminCommentTrueAndHiddenFalse(alertId);
    }

    public List<CompanyAlertComment> getUserComments(Long alertId) {
        return repository.findByAlertIdAndHiddenFalseOrderByCommentedAtAsc(alertId);
    }

}
