package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.Review;

public interface ReviewRepository extends JpaRepository<Review, Long> {
    List<Review> findByCompany_Id(Long companyId);

	List<Review> getReviewsByJobSeekerId(Long id);
}
