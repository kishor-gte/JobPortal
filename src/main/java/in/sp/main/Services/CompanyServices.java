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
		return companyRepository.save(company);
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
        mailService.sendEmail(company.getEmail(), subject, body);
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
	    companyRepository.deleteById(id);
	}
	public String authenticateCompany(String email, String password) {
	    Optional<Company> companyOpt = companyRepository.findByEmail(email);

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