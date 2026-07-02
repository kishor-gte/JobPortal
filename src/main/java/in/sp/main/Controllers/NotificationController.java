package in.sp.main.Controllers;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.Notification;
import in.sp.main.Services.JobSeekerService;
import in.sp.main.Services.NotificationService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/notifications")
public class NotificationController {

    @Autowired
    private NotificationService notificationService;

    @Autowired
    private JobSeekerService jobSeekerService;

    @RequestMapping(method = RequestMethod.GET)
    public String viewNotifications(Model model, HttpSession session) {
    	 JobSeeker jobSeeker= (JobSeeker) session.getAttribute("jobSeeker");
    	if(jobSeeker==null)
    	{
    		return "redirect:/jobSeekers/login";
    	}
        // Automatically mark all notifications as seen
        notificationService.markAllAsSeen(jobSeeker.getId());

        // Fetch all notifications for this user
        List<Notification> notifications = notificationService.getNotificationsForUser(jobSeeker.getId());
        model.addAttribute("notifications", notifications);
        
        return "jobSeekers/notifications"; // JSP page
    }
    @RequestMapping(value = "/seen/{id}", method = RequestMethod.GET)
    public String markAsSeen(@PathVariable Long id) {
        notificationService.markAsSeen(id);
        return "redirect:/notifications";
    }
}
