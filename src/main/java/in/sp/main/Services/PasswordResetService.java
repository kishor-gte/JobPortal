package in.sp.main.Services;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.Admin;
import in.sp.main.Entities.Company;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.PasswordResetToken;
import in.sp.main.Entities.Recruiter;
import in.sp.main.Enums.UserType;
import in.sp.main.Repositories.AdminRepository;
import in.sp.main.Repositories.CompanyRepository;
import in.sp.main.Repositories.JobSeekerRepository;
import in.sp.main.Repositories.PasswordResetTokenRepository;
import in.sp.main.Repositories.RecruiterRepository;

@Service
public class PasswordResetService {

    @Autowired private AdminRepository adminRepo;
    @Autowired private CompanyRepository companyRepo;
    @Autowired private RecruiterRepository recruiterRepo;
    @Autowired private JobSeekerRepository jobSeekerRepo;
    @Autowired private PasswordResetTokenRepository tokenRepo;
    @Autowired private JavaMailSender mailSender;

    @Value("${app.base-url:http://localhost:8081}")
    private String baseUrl;

    private static final int EXPIRATION_MINUTES = 15;

    public String createPasswordResetToken(String email) {
        Optional<Admin> admin = adminRepo.findByEmail(email);
        Optional<Company> company = companyRepo.findFirstByEmail(email);
        Optional<Recruiter> recruiter = recruiterRepo.findByEmail(email);
        Optional<JobSeeker> jobSeeker = jobSeekerRepo.findByEmail(email);

        UserType userType = null;
        if (admin.isPresent()) userType = UserType.ADMIN;
        else if (company.isPresent()) userType = UserType.COMPANY;
        else if (recruiter.isPresent()) userType = UserType.RECRUITER;
        else if (jobSeeker.isPresent()) userType = UserType.JOBSEEKER;
        else return "Email not found";

        String token = UUID.randomUUID().toString();
        PasswordResetToken resetToken = new PasswordResetToken(email, token, userType, EXPIRATION_MINUTES);
        tokenRepo.save(resetToken);

        try {
            sendResetEmail(email, token, userType);
        } catch (Exception e) {
            e.printStackTrace();
            tokenRepo.delete(resetToken);
            return "Failed to send reset email due to a server error. Please try again later.";
        }
        return "Reset email sent successfully.";
    }

    private void sendResetEmail(String email, String token, UserType userType) {
        String resetUrl = baseUrl + "/auth/reset-password?token=" + token + "&type=" + userType;
        String messageBody = "Click the following link to reset your password:\n\n" + resetUrl;

        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("Password Reset Request - Job Portal");
        message.setText(messageBody);
        mailSender.send(message);
    }

    @org.springframework.transaction.annotation.Transactional
    public String resetPassword(String token, String newPassword) {
        Optional<PasswordResetToken> tokenOpt = tokenRepo.findByToken(token);
        if (tokenOpt.isEmpty() || tokenOpt.get().isExpired()) {
            return "Invalid or expired token.";
        }

        PasswordResetToken resetToken = tokenOpt.get();
        String email = resetToken.getEmail();
        UserType userType = resetToken.getUserType();
        String encodedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        boolean updated = false;
        switch (userType) {
            case ADMIN:
                Optional<Admin> admin = adminRepo.findByEmail(email);
                if (admin.isPresent()) {
                    admin.get().setPassword(encodedPassword);
                    adminRepo.save(admin.get());
                    updated = true;
                }
                break;
            case COMPANY:
                Optional<Company> company = companyRepo.findFirstByEmail(email);
                if (company.isPresent()) {
                    company.get().setPassword(encodedPassword);
                    companyRepo.save(company.get());
                    updated = true;
                }
                break;
            case RECRUITER:
                Optional<Recruiter> recruiter = recruiterRepo.findByEmail(email);
                if (recruiter.isPresent()) {
                    recruiter.get().setPassword(encodedPassword);
                    recruiterRepo.save(recruiter.get());
                    updated = true;
                }
                break;
            case JOBSEEKER:
                Optional<JobSeeker> jobSeeker = jobSeekerRepo.findByEmail(email);
                if (jobSeeker.isPresent()) {
                    jobSeeker.get().setPassword(encodedPassword);
                    jobSeekerRepo.save(jobSeeker.get());
                    updated = true;
                }
                break;
        }

        if (updated) {
            tokenRepo.delete(resetToken);
            return "Password reset successful.";
        } else {
            return "Error: User account not found.";
        }
    }
}
