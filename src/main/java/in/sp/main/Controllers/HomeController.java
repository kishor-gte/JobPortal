package in.sp.main.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.ui.Model;
import in.sp.main.Repositories.JobRepository;
import in.sp.main.Repositories.CompanyRepository;
import in.sp.main.Repositories.JobSeekerRepository;
import in.sp.main.Entities.Job;
import in.sp.main.Enums.JobStatus;
import java.util.List;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import in.sp.main.Services.EmailService;
import in.sp.main.utils.ActivityLogger;
import in.sp.main.Enums.ActivityType;

@Controller
public class HomeController {
	
	@Autowired
	private EmailService emailService;

	@Value("${admin.email}")
	private String adminEmail;

	@Autowired
	private ActivityLogger activityLogger;

	@RequestMapping(value = "/submit-contact", method = RequestMethod.POST)
	public String submitContact(@RequestParam("name") String name,
								@RequestParam("email") String email,
								@RequestParam("message") String message,
								RedirectAttributes redirectAttributes,
								jakarta.servlet.http.HttpSession session) {
		try {
			// Email to the site administrator
			String adminSubject = "New Contact Form Submission from " + name;
			String adminText = "Name: " + name + "\nEmail: " + email + "\n\nMessage:\n" + message;
			emailService.sendEmail(adminEmail, adminSubject, adminText);
			
			// Acknowledgment email to the user
			String userSubject = "Thank you for contacting us, " + name + "!";
			String userText = "Hi " + name + ",\n\nWe have received your message and will get back to you shortly.\n\nYour Message:\n" + message + "\n\nBest regards,\nSupport Team";
			emailService.sendEmail(email, userSubject, userText);
			
			Long userId = null;
			String userRole = "GUEST";
			if (session != null) {
			    if (session.getAttribute("jobSeeker") != null) {
			        userId = ((in.sp.main.Entities.JobSeeker) session.getAttribute("jobSeeker")).getId();
			        userRole = "JOBSEEKER";
			    } else if (session.getAttribute("loggedInCompany") != null) {
			        userId = ((in.sp.main.Entities.Company) session.getAttribute("loggedInCompany")).getId();
			        userRole = "COMPANY";
			    } else if (session.getAttribute("loggedInRecruiter") != null) {
			        userId = ((in.sp.main.Entities.Recruiter) session.getAttribute("loggedInRecruiter")).getId();
			        userRole = "RECRUITER";
			    }
			}
			activityLogger.log(userId, name, email, userRole, ActivityType.CONTACT_SUPPORT, "Contact support message sent");
		} catch (Exception e) {
			e.printStackTrace();
			// Log to allow debugging if not receiving mail
		}
		return "redirect:/contact.html?message=Your%20message%20has%20been%20sent%20successfully!";
	}

	@Autowired private JobRepository jobRepository;
	@Autowired private CompanyRepository companyRepository;
	@Autowired private JobSeekerRepository jobSeekerRepository;

	@RequestMapping(value = {"/", "/home.html", "/home"}, method = RequestMethod.GET)
	public String home1(Model model) {
		model.addAttribute("activeJobs", jobRepository.count());
		model.addAttribute("topCompanies", companyRepository.count());
		model.addAttribute("professionals", jobSeekerRepository.count());
		
		List<Job> featuredJobs = jobRepository.findTop8ByStatusOrderByPostedDateDesc(JobStatus.OPEN);
		model.addAttribute("featuredJobs", featuredJobs);
		
		return "home";  // Serves dynamic JSP from views/home.jsp
	}

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String home(Model model) {
		model.addAttribute("activeJobs", jobRepository.count());
		model.addAttribute("topCompanies", companyRepository.count());
		model.addAttribute("professionals", jobSeekerRepository.count());
		
		List<Job> featuredJobs = jobRepository.findTop8ByStatusOrderByPostedDateDesc(JobStatus.OPEN);
		model.addAttribute("featuredJobs", featuredJobs);
		
		return "home";  // Serves dynamic JSP from views/home.jsp
	}

	@RequestMapping(value = "/userdashboard", method = RequestMethod.GET)
	public String dashboard() {
		return "userdashboard";  // Returns the Thymeleaf template from resources/templates/userdashboard.html
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(jakarta.servlet.http.HttpSession session) {
		if (session != null) {
			session.invalidate();
		}
		return "redirect:/home.html?message=Logged%20out%20successfully";
	}


}
