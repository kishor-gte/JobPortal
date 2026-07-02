package in.sp.main.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import in.sp.main.Entities.CompanyAlert;
import in.sp.main.Repositories.CompanyAlertRepository;
import jakarta.transaction.Transactional;

@Service
public class CompanyAlertService {

    private final CompanyAlertRepository repository;

    public CompanyAlertService(CompanyAlertRepository repository) {
        this.repository = repository;
    }

    // Save new alert
    public void saveAlert(CompanyAlert alert) {
        repository.save(alert);
    }

    // Public listing (only non-hidden)
    public List<CompanyAlert> getVisibleAlerts() {
        return repository.findByHiddenFalseOrderByReportedAtDesc();
    }

    // Admin listing (all)
    public List<CompanyAlert> getAllAlertsForAdmin() {
        return repository.findAllByOrderByReportedAtDesc();
    }

    // Hide alert (admin/moderation)
    public void hideAlert(Long id) {
        CompanyAlert alert = repository.findById(id).orElseThrow();
        alert.setHidden(true);
        repository.save(alert);
    }

    // Verify alert (admin)
    public void verifyAlert(Long id) {
        CompanyAlert alert = repository.findById(id).orElseThrow();
        alert.setVerified(true);
        repository.save(alert);
    }

    // Company warning count
    public long getReportCount(String companyName) {
        return repository.countByCompanyNameIgnoreCase(companyName);
    }
    
    public Optional<CompanyAlert> getVisibleAlertById(Long id) {
        return repository.findByIdAndHiddenFalse(id);
    }
    
    @Transactional
    public void agreeWithReport(Long id) {
        repository.incrementAgreeCount(id);
    }
    public Optional<CompanyAlert> getAlertById(Long id) {
        return repository.findById(id);
    }

    public void deleteAlert(Long id) {
        repository.deleteById(id);
    }

}
