package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.CompanyAlertComment;

public interface CompanyAlertCommentRepository
        extends JpaRepository<CompanyAlertComment, Long> {

    List<CompanyAlertComment> findByAlertIdAndHiddenFalseOrderByCommentedAtAsc(Long alertId);

	List<CompanyAlertComment> findByAlertIdAndAdminCommentTrueAndHiddenFalse(Long alertId);
}
