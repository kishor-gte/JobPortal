package in.sp.main.Services;

import java.util.List;
import java.util.Optional;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import in.sp.main.Entities.Admin;
import in.sp.main.Repositories.AdminRepository;

@Service
public class AdminService {

    @Autowired
    private AdminRepository adminRepository;
 
    public boolean registerAdmin(Admin admin) {
    	 Optional<Admin> existing = adminRepository.findByEmail(admin.getEmail());
    	    if (existing.isEmpty()) {
    	        admin.setPassword(BCrypt.hashpw(admin.getPassword(), BCrypt.gensalt()));
    	        adminRepository.save(admin);
    	        return true;
    	    }
        return false;
    }
    
    public Admin loginAdmin(String email, String password) {
        Optional<Admin> adminOpt = adminRepository.findByEmail(email);
        if (adminOpt.isEmpty()) return null;

        Admin admin = adminOpt.get();
        boolean matches = false;
        try {
            matches = BCrypt.checkpw(password, admin.getPassword());
        } catch (Exception e) {}

        if (!matches) {
            if (admin.getPassword().equals(password)) {
                // Migration
                admin.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
                adminRepository.save(admin);
                matches = true;
            }
        }

        return matches ? admin : null;
    }
    
 // Update Admin
    public Admin updateAdmin(int id, Admin updatedAdmin) {
        return adminRepository.findById((long) id).map(admin -> {
            admin.setName(updatedAdmin.getName());
            admin.setEmail(updatedAdmin.getEmail());
            admin.setPassword(updatedAdmin.getPassword());
            return adminRepository.save(admin);
        }).orElseThrow(() -> new RuntimeException("Admin not found with id: " + id));
    }

 // Delete Admin
    public void deleteAdmin(int id) {
        if (adminRepository.existsById((long) id)) {
            adminRepository.deleteById((long) id);
        } else {
            throw new RuntimeException("Admin not found with id: " + id);
        }
    }

	public List<Admin> findAllAdmins() {
		return adminRepository.findAll();
	}

	public Optional<Admin> findById(int id) {	
		return adminRepository.findById((long) id);
	}
}
