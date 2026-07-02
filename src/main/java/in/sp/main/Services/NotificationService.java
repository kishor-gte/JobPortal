package in.sp.main.Services;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.Notification;
import in.sp.main.Repositories.NotificationRepository;

@Service
public class NotificationService {

    @Autowired
    private NotificationRepository notificationRepository;

    public List<Notification> getNotificationsForUser(Long userId) {
        return notificationRepository.findByUserIdOrderByCreatedAtDesc(userId);
    }

    public void markAsSeen(Long id) {
        Notification n = notificationRepository.findById(id).orElse(null);
        if (n != null) {
            n.setSeen(true);
            notificationRepository.save(n);
        }
    }
    public void sendStatusUpdate(Long jobSeekerId, String message) {
        Notification n = new Notification();
        n.setUserId(jobSeekerId);
        n.setMessage(message);
        n.setCreatedAt(LocalDateTime.now());
        n.setSeen(false);
        notificationRepository.save(n);
    }
    // Method to automatically mark all notifications as "seen" for a user
    public void markAllAsSeen(Long userId) {
        List<Notification> notifications = notificationRepository.findByUserIdOrderByCreatedAtDesc(userId);
        
        // Update each notification to be marked as seen
        for (Notification notification : notifications) {
            if (!notification.isSeen()) { // Avoid unnecessary updates
                notification.setSeen(true);
            }
        }

        // Save all updated notifications back to the database
        notificationRepository.saveAll(notifications);
    }
    public void createNotification(JobSeeker jobSeeker, String message) {
        Notification notification = new Notification();
        notification.setMessage(message);
        notification.setUserId(jobSeeker.getId());
        notification.setCreatedAt(LocalDateTime.now());
        notification.setSeen(false); // Notifications will be unseen by default
        notificationRepository.save(notification);
    }

}
