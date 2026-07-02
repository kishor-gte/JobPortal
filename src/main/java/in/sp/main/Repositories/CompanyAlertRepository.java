package in.sp.main.Repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import in.sp.main.Entities.CompanyAlert;

@Repository
public interface CompanyAlertRepository extends JpaRepository<CompanyAlert, Long> {

    // Show only visible alerts to users
    List<CompanyAlert> findByHiddenFalseOrderByReportedAtDesc();

    // Admin view – all alerts
    List<CompanyAlert> findAllByOrderByReportedAtDesc();

    // Count reports for same company (future warning badge)
    long countByCompanyNameIgnoreCase(String companyName);
    
    Optional<CompanyAlert> findByIdAndHiddenFalse(Long id);
    
    @Modifying
    @Query("update CompanyAlert c set c.agreeCount = c.agreeCount + 1 where c.id = :id")
    void incrementAgreeCount(@Param("id") Long id);
}
