package in.sp.main.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import in.sp.main.Services.EmailService;

@Controller
public class HomeController {
	
	@Autowired
	private EmailService emailService;

	@Value("${admin.email}")
	private String adminEmail;

	@RequestMapping(value = "/submit-contact", method = RequestMethod.POST)
	public String submitContact(@RequestParam("name") String name,
								@RequestParam("email") String email,
								@RequestParam("message") String message,
								RedirectAttributes redirectAttributes) {
		try {
			// Email to the site administrator
			String adminSubject = "New Contact Form Submission from " + name;
			String adminText = "Name: " + name + "\nEmail: " + email + "\n\nMessage:\n" + message;
			emailService.sendEmail(adminEmail, adminSubject, adminText);
			
			// Acknowledgment email to the user
			String userSubject = "Thank you for contacting us, " + name + "!";
			String userText = "Hi " + name + ",\n\nWe have received your message and will get back to you shortly.\n\nYour Message:\n" + message + "\n\nBest regards,\nSupport Team";
			emailService.sendEmail(email, userSubject, userText);
		} catch (Exception e) {
			e.printStackTrace();
			// Log to allow debugging if not receiving mail
		}
		return "redirect:/contact.html?message=Your%20message%20has%20been%20sent%20successfully!";
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home1() {
		return "redirect:/home.html";  // Serves static file from resources/static/index.html
	}

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String home() {
		return "redirect:/home.html";  // Serves static file from resources/static/index.html
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
