package in.sp.main.Controllers;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import in.sp.main.Entities.Recruiter;
import in.sp.main.Entities.Subscriber;
import in.sp.main.Repositories.RecruiterRepository;
import in.sp.main.Repositories.SubscriberRepository;
import in.sp.main.Services.EmailService;
import in.sp.main.Services.RateLimitingService;

@Controller
public class SubscriptionController {

    private static final Logger logger = LoggerFactory.getLogger(SubscriptionController.class);

    @Autowired
    private SubscriberRepository subscriberRepository;

    @Autowired
    private RecruiterRepository recruiterRepository;

    @Autowired
    private EmailService emailService;
    
    @Autowired
    private RateLimitingService rateLimitingService;
    
    @Value("${admin.email}")
    private String adminEmail;

    @RequestMapping(value = "/subscribe", method = RequestMethod.POST)
    public String subscribe(@RequestParam("email") String email, jakarta.servlet.http.HttpServletRequest request) {
        String referer = request.getHeader("Referer");
        if (referer == null) referer = "/home.html";
        // Check rate limit first
        if (!rateLimitingService.isEmailAllowed(email)) {
            int remaining = rateLimitingService.getRemainingRequests(email);
            long waitMinutes = rateLimitingService.getTimeUntilReset(email) / 60000;
            String message = "Too many subscription attempts. Please try again in " + waitMinutes + " minutes.";
            String separator = referer.contains("?") ? "&" : "?";
            return "redirect:" + referer + separator + "message=" + URLEncoder.encode(message, StandardCharsets.UTF_8);
        }
        
        if (!subscriberRepository.existsByEmail(email)) {
            Subscriber subscriber = new Subscriber();
            subscriber.setEmail(email);
            subscriberRepository.save(subscriber);

            // 1. Send confirmation email to subscriber (rate limited)
            String subject = "Thank you for subscribing!";
            String content = "Hi there,\n\nThank you for subscribing to our job portal. " +
                    "You'll now receive notifications for the latest job postings that match your interests.\n\n" +
                    "Happy job hunting!\nThe Team";

            try {
                emailService.sendEmail(email, subject, content);
            } catch (Exception e) {
                logger.error("Failed to send subscription confirmation email to: {}", email, e);
            }
            
            // 2. Send notification email to admin (if configured)
            if (adminEmail != null && !adminEmail.isEmpty()) {
                String adminSubject = "New Newsletter Subscription";
                String adminContent = "Hello Admin,\n\nA new user has subscribed to the newsletter.\n\n" +
                        "Subscriber Email: " + email + "\n\n" +
                        "Total Subscribers: " + subscriberRepository.count() + "\n\n" +
                        "Regards,\nJob Portal System";
                try {
                    emailService.sendEmail(adminEmail, adminSubject, adminContent);
                } catch (Exception e) {
                    logger.error("Failed to send subscription admin notification email to: {}", adminEmail, e);
                }
            }
            
            // 3. Send notification email to all recruiters
            List<Recruiter> recruiters = recruiterRepository.findAll();
            String recruiterSubject = "New Job Seeker Subscription";
            String recruiterContent = "Hello,\n\nA new job seeker has subscribed to our job portal newsletter.\n\n" +
                    "Subscriber Email: " + email + "\n\n" +
                    "This user will receive job alerts and updates about new opportunities.\n\n" +
                    "Regards,\nJob Portal Team";
            
            for (Recruiter recruiter : recruiters) {
                if (recruiter.getEmail() != null && !recruiter.getEmail().isEmpty()) {
                    try {
                        emailService.sendEmail(recruiter.getEmail(), recruiterSubject, recruiterContent);
                    } catch (Exception e) {
                        logger.error("Failed to send email to recruiter: {}", recruiter.getEmail(), e);
                    }
                }
            }

            String message = "Subscribed successfully! Check your email for confirmation.";
            String separator = referer.contains("?") ? "&" : "?";
            return "redirect:" + referer + separator + "message=" + URLEncoder.encode(message, StandardCharsets.UTF_8);
        } else {
            String message = "You're already subscribed.";
            String separator = referer.contains("?") ? "&" : "?";
            return "redirect:" + referer + separator + "message=" + URLEncoder.encode(message, StandardCharsets.UTF_8);
        }
    }
}
