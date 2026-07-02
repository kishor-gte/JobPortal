package in.sp.main.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.SportsService;
import in.sp.main.Repositories.SportsServiceRepository;

@Service
public class SportsServiceService {

    @Autowired
    private SportsServiceRepository serviceRepo;

    public void save(SportsService service) {
        serviceRepo.save(service);
    }

    public SportsService getById(Long id) {
        return serviceRepo.findById(id).orElse(null);
    }

	/*
	 * public List<SportsService> getByOrganizer(Long organizerId) { return
	 * serviceRepo.findByOrganizerId(organizerId); }
	 */
    public void delete(Long id) {
        serviceRepo.deleteById(id);
    }

    public List<SportsService> findAll() {
        return serviceRepo.findAll();
    }
}
