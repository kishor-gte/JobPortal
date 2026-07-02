package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import in.sp.main.Entities.CompanyNotification;

public interface CompanyNotificationRepository
        extends JpaRepository<CompanyNotification, Long> {

    List<CompanyNotification> findByCompanyIdOrderByCreatedAtDesc(Long companyId);
    int countByCompanyIdAndSeenFalse(Long companyId);
    
    @Modifying
    @Transactional
    @Query("UPDATE CompanyNotification n SET n.seen = true WHERE n.companyId = :companyId")
    void markAllAsSeenByCompanyId(@Param("companyId") Long companyId);
}
