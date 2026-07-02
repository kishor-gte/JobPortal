package in.sp.main.Controllers;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import in.sp.main.Entities.Company;
import in.sp.main.Entities.CompanyNotification;
import in.sp.main.Entities.Recruiter;
import in.sp.main.Repositories.CompanyNotificationRepository;
import jakarta.servlet.http.HttpSession;

@Controller
public class CompanyNotificationController {

    @Autowired
    private CompanyNotificationRepository notificationRepo;

    @RequestMapping(value = "/company/notifications", method = RequestMethod.GET)
    public String viewNotifications(Model model, HttpSession session) {
        Company company = (Company) session.getAttribute("loggedInCompany");
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");

        if (company == null && recruiter != null) {
            company = recruiter.getCompany();
        }

        if (company == null) {
            return "redirect:/company/login";
        }

        // Automatically mark all notifications as seen
        notificationRepo.markAllAsSeenByCompanyId(company.getId());

        // Fetch all notifications for this company
        List<CompanyNotification> notifications = notificationRepo.findByCompanyIdOrderByCreatedAtDesc(company.getId());
        model.addAttribute("notifications", notifications);
        
        return "company/notifications"; // JSP page
    }

    @RequestMapping(value = "/seen/{id}", method = RequestMethod.GET)
    public String markAsSeen(@PathVariable Long id) {
        Optional<CompanyNotification> notification = notificationRepo.findById(id);
        if (notification.isPresent()) {
            CompanyNotification n = notification.get();
            n.setSeen(true);
            notificationRepo.save(n);
        }
        return "redirect:/company/notifications";
    }

    @RequestMapping(value = "/company/notif-count", method = RequestMethod.GET)
    public String loadCount(HttpSession session, Model model) {
        Company company = (Company) session.getAttribute("loggedInCompany");
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");

        if (company == null && recruiter != null) {
            company = recruiter.getCompany();
        }

        if (company != null) {
            int unseen = notificationRepo.countByCompanyIdAndSeenFalse(company.getId());
            model.addAttribute("unseenCount", unseen);
        }
        return "company/dashboard";
    }
}
