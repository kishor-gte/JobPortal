package in.sp.main.Controllers;

import java.time.LocalDateTime;
import java.util.List;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.RazorpayException;
import com.razorpay.Utils;

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

    @Value("${razorpay.key.id}")
    private String KEY_ID;
    
    @Value("${razorpay.key.secret}")
    private String KEY_SECRET;

    @PostMapping("/api/subscription/createOrder")
    @ResponseBody
    public ResponseEntity<?> createSubscriptionOrder(@RequestParam("email") String email, @RequestParam("amount") String amount) {
        try {
            if (KEY_ID == null || KEY_ID.isEmpty() || KEY_SECRET == null || KEY_SECRET.isEmpty()) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Razorpay credentials not configured.");
            }

            // Check if user already has an active subscription
            if (subscriberRepository.existsByEmailAndStatus(email, "ACTIVE")) {
                return ResponseEntity.status(HttpStatus.CONFLICT).body("You already have an active subscription.");
            }

            String orderId;
            String jsonResponse;

            // Mock flow for local testing if dummy keys are detected
            if (KEY_ID.equals("rzp_test_YourKeyID")) {
                orderId = "order_mock_" + System.currentTimeMillis();
                JSONObject mockOrder = new JSONObject();
                mockOrder.put("id", orderId);
                mockOrder.put("amount", Integer.parseInt(amount) * 100);
                jsonResponse = mockOrder.toString();
            } else {
                RazorpayClient razorpay = new RazorpayClient(KEY_ID, KEY_SECRET);
                JSONObject orderRequest = new JSONObject();
                int amountInPaise = Integer.parseInt(amount) * 100;
                orderRequest.put("amount", amountInPaise);
                orderRequest.put("currency", "INR");
                orderRequest.put("receipt", "txn_" + System.currentTimeMillis());
                orderRequest.put("payment_capture", 1);
                Order order = razorpay.orders.create(orderRequest);
                orderId = order.get("id");
                jsonResponse = order.toString();
            }

            Subscriber subscriber = subscriberRepository.findByEmail(email);
            if (subscriber == null) {
                subscriber = new Subscriber();
                subscriber.setEmail(email);
            }
            subscriber.setOrderId(orderId);
            subscriber.setAmount(Double.parseDouble(amount));
            subscriber.setPlanName("Premium Job Alerts");
            subscriber.setStatus("PENDING");
            subscriberRepository.save(subscriber);

            return ResponseEntity.ok(jsonResponse);
        } catch (RazorpayException e) {
            logger.error("Razorpay Error: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error creating order");
        }
    }

    @PostMapping("/api/subscription/verify")
    @ResponseBody
    public ResponseEntity<?> verifySubscriptionPayment(
            @RequestParam("razorpay_payment_id") String paymentId,
            @RequestParam("razorpay_order_id") String orderId,
            @RequestParam("razorpay_signature") String signature,
            @RequestParam("email") String email) {
        try {
            JSONObject options = new JSONObject();
            options.put("razorpay_order_id", orderId);
            options.put("razorpay_payment_id", paymentId);
            options.put("razorpay_signature", signature);

            boolean isValid = false;
            if (orderId.startsWith("order_mock_")) {
                isValid = true; // Bypass validation for mock testing orders
            } else {
                isValid = Utils.verifyPaymentSignature(options, KEY_SECRET);
            }

            Subscriber subscriber = subscriberRepository.findByEmail(email);
            if (subscriber == null || !subscriber.getOrderId().equals(orderId)) {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid order");
            }

            if (isValid) {
                subscriber.setPaymentId(paymentId);
                subscriber.setSignature(signature);
                subscriber.setStatus("ACTIVE");
                subscriber.setPaymentDate(LocalDateTime.now());
                subscriberRepository.save(subscriber);

                // Send confirmation emails
                sendSubscriptionEmails(email);

                return ResponseEntity.ok("Payment verified successfully");
            } else {
                subscriber.setStatus("FAILED");
                subscriberRepository.save(subscriber);
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid signature");
            }
        } catch (Exception e) {
            logger.error("Error verifying payment: ", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error verifying payment");
        }
    }

    private void sendSubscriptionEmails(String email) {
        // 1. Send confirmation email to subscriber
        String subject = "Thank you for subscribing!";
        String content = "Hi there,\n\nThank you for subscribing to our premium job portal services. " +
                "You'll now receive notifications for the latest job postings and access to premium features.\n\n" +
                "Happy job hunting!\nThe Team";
        emailService.sendEmail(email, subject, content);
        
        // 2. Send notification email to admin
        if (adminEmail != null && !adminEmail.isEmpty()) {
            String adminSubject = "New Premium Newsletter Subscription";
            String adminContent = "Hello Admin,\n\nA new user has subscribed to the premium newsletter via Razorpay.\n\n" +
                    "Subscriber Email: " + email + "\n\n" +
                    "Total Subscribers: " + subscriberRepository.count() + "\n\n" +
                    "Regards,\nJob Portal System";
            emailService.sendEmail(adminEmail, adminSubject, adminContent);
        }
        
        // 3. Send notification email to all recruiters
        List<Recruiter> recruiters = recruiterRepository.findAll();
        String recruiterSubject = "New Premium Job Seeker Subscription";
        String recruiterContent = "Hello,\n\nA new job seeker has subscribed to our job portal premium newsletter.\n\n" +
                "Subscriber Email: " + email + "\n\n" +
                "This user is highly interested and looking for premium opportunities.\n\n" +
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
    }

    // Keep the old endpoint just in case it's used elsewhere, but maybe redirect to payment flow
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
