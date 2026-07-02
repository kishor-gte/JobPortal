package in.sp.main.Services;

import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    private static final Logger logger = LoggerFactory.getLogger(EmailService.class);

    @Autowired
    private JavaMailSender emailSender;
    
    @Value("${spring.mail.username:fightthefireapp123@gmail.com}")
    private String fromEmail;

    public void sendEmail(String to, String subject, String text) {
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(fromEmail);
            message.setTo(to);
            message.setSubject(subject);
            message.setText(text);
            emailSender.send(message);
            logger.info("Email sent successfully to: {}", to);
        } catch (Exception e) {
            logger.error("Failed to send email to: {}", to, e);
            throw e;
        }
    }
    
    @Autowired
    private JavaMailSender mailSender;

    @Value("${admin.email}")
    private String adminEmail;

    // Store OTPs temporarily in memory (email -> OTP)
    private final Map<String, String> otpStore = new ConcurrentHashMap<>();
    // Store OTP generation timestamps (email -> timestamp)
    private final Map<String, Long> otpTimestamps = new ConcurrentHashMap<>();

    // OTP validity duration: 5 minutes
    private static final long OTP_VALIDITY_MS = 5 * 60 * 1000;

    /**
     * Generate a 6-digit OTP
     */
    public String generateOTP() {
        return String.format("%06d", new Random().nextInt(999999));
    }

    /**
     * Send OTP email to the given email address
     */
    public boolean sendOTP(String toEmail, String fullName) {
        try {
            String otp = generateOTP();
            otpStore.put(toEmail, otp);
            otpTimestamps.put(toEmail, System.currentTimeMillis());

            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom(adminEmail);
            message.setTo(toEmail);
            message.setSubject("SmartInterview - Email Verification OTP");
            message.setText(
                "Hello " + fullName + ",\n\n" +
                "Your OTP for SmartInterview registration is: " + otp + "\n\n" +
                "This OTP is valid for 5 minutes.\n\n" +
                "If you did not request this, please ignore this email.\n\n" +
                "Regards,\nSmartInterview Team"
            );

            mailSender.send(message);
            logger.info("OTP email sent successfully to: {}", toEmail);
            return true;
        } catch (Exception e) {
            logger.error("Failed to send OTP email to: {}", toEmail, e);
            return false;
        }
    }

    /**
     * Verify the OTP entered by the user
     */
    public boolean verifyOTP(String email, String otp) {
        String storedOtp = otpStore.get(email);
        Long timestamp = otpTimestamps.get(email);

        if (storedOtp == null || timestamp == null) {
            return false;
        }

        // Check if OTP has expired
        if (System.currentTimeMillis() - timestamp > OTP_VALIDITY_MS) {
            otpStore.remove(email);
            otpTimestamps.remove(email);
            return false;
        }

        if (storedOtp.equals(otp)) {
            // OTP verified, remove it
            otpStore.remove(email);
            otpTimestamps.remove(email);
            return true;
        }

        return false;
    }

    /**
     * Remove stored OTP for an email
     */
    public void clearOTP(String email) {
        otpStore.remove(email);
        otpTimestamps.remove(email);
    }
}



