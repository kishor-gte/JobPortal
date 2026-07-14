package in.sp.main.Services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.mindrot.jbcrypt.BCrypt;

import in.sp.main.Entities.Company;
import in.sp.main.Entities.Media;
import in.sp.main.Exceptions.ResourceNotFoundException;
import in.sp.main.Repositories.CompanyRepository;

@Service
public class CompanyServices
{
	
	@Autowired
	private CompanyRepository companyRepository;
	@Autowired
	private EmailService mailService;
			
	public Company registerCompany(Company company) {
		company.setVerified(false); // Needs admin approval
		company.setPassword(BCrypt.hashpw(company.getPassword(), BCrypt.gensalt()));
		Company savedCompany = companyRepository.save(company);
		
		String subject = "Congratulations on Registering with Job Portal!";
		String body = "Dear " + company.getName() + ",\n\n"
				+ "Congratulations! Your company registration has been successfully submitted.\n\n"
				+ "Your profile is currently under review by our administration team. You will receive another email once your account has been approved.\n\n"
				+ "Best regards,\n"
				+ "The Job Portal Team";
		try {
			mailService.sendEmail(company.getEmail(), subject, body);
		} catch (Throwable t) {
			System.err.println("Failed to send registration email to " + company.getEmail() + ": " + t.getMessage());
		}
		
		return savedCompany;
	}
	public Optional<Company> getCompany(Long id) {
	    return companyRepository.findById(id);
	}
	public List<Company> getUnverifiedCompanies() {
	    return companyRepository.findByIsVerifiedFalse();
	}
		
	public Company verifyCompany(Long id) {
	    Company company = companyRepository.findById(id)
	            .orElseThrow(() -> new ResourceNotFoundException("Company not found with id: " + id));
	    company.setVerified(true);
	   Company company1=companyRepository.save(company);
	   String subject = "Your Company Has Been Verified!";
        String body = "Dear " + company.getName() + ",\n\n"
                    + "We’re excited to inform you that your company profile has been successfully verified by our team.\n\n"
                    + "You can now start posting job listings and explore our platform to connect with top talent.\n\n"
                    + "If you need assistance, feel free to reach out to our support team.\n\n"
                    + "Best regards,\n"
                    + "The Job Portal Team";
        try {
            mailService.sendEmail(company.getEmail(), subject, body);
        } catch (Throwable t) {
            System.err.println("Failed to send verification email to " + company.getEmail() + ": " + t.getMessage());
        }
	   return company1;
	}
		
	public List<Company> getAllVerifiedCompanies() {
		    return companyRepository.findByIsVerifiedTrue();
		}
		// Get all companies
	public List<Company> getAllCompanies() {
		    return companyRepository.findAll();
		}

	public void updateCompany(Company company) {
	    companyRepository.save(company); // Same method can handle update
	}
	public void deleteCompany(Long id) {
	    companyRepository.findById(id).ifPresent(company -> {
	        String subject;
	        String body;
	        if (!company.isVerified()) {
	            subject = "Update on Your Company Registration Status";
	            body = "Dear " + company.getName() + ",\n\n"
	                 + "Thank you for registering with our platform. Unfortunately, after reviewing your application, we are unable to approve your company registration at this time.\n\n"
	                 + "If you have any questions or believe this was a mistake, please reach out to our support team.\n\n"
	                 + "Best regards,\n"
	                 + "The Job Portal Team";
	        } else {
	            subject = "Notice of Account Removal";
	            body = "Dear " + company.getName() + ",\n\n"
	                 + "We regret to inform you that your company profile has been removed from our platform.\n\n"
	                 + "If you have any questions, please contact our support team.\n\n"
	                 + "Best regards,\n"
	                 + "The Job Portal Team";
	        }
	        try {
	            mailService.sendEmail(company.getEmail(), subject, body);
	        } catch (Throwable t) {
	            System.err.println("Failed to send rejection/removal email to " + company.getEmail() + ": " + t.getMessage());
	        }
	        companyRepository.deleteById(id);
	    });
	}
	public String authenticateCompany(String email, String password) {
	    Optional<Company> companyOpt = companyRepository.findFirstByEmail(email);

	    if (companyOpt.isEmpty()) {
	        return "NOT_FOUND";
	    }

	    Company company = companyOpt.get();
	    
	    boolean matches = false;
	    try {
	        matches = BCrypt.checkpw(password, company.getPassword());
	    } catch (Exception e) {
	        // password might be plain text
	    }

	    if (!matches) {
	        // Fallback for legacy plain text passwords
	        if (company.getPassword().equals(password)) {
	            // Migration: encode and save
	            company.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
	            companyRepository.save(company);
	            matches = true;
	        }
	    }

	    if (!matches) {
	        return "NOT_FOUND";
	    }

	    if (!company.isVerified()) {
	        return "NOT_VERIFIED";
	    }

	    return "SUCCESS";
	}


	  public void addCulturalVideo(Long companyId, String videoPath) {
		    Company company = companyRepository.findById(companyId)
		            .orElseThrow(() -> new ResourceNotFoundException("Company not found with id: " + companyId));

		    if (company.getCultureVideos() == null) {
		        company.setCultureVideos(new ArrayList<>());
		    }

		    Media media = new Media();
		    media.setTitle("Company Culture Video");
		    media.setUrl(videoPath);  // This is your file path or video URL
		    media.setCompany(company);

		    company.getCultureVideos().add(media); // ✅ This works

		    companyRepository.save(company);
		}
	  public long getCompanyCount() {
	        return companyRepository.count();
	    }
}