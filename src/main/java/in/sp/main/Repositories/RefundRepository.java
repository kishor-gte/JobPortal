package in.sp.main.Repositories;

import in.sp.main.Entities.Refund;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RefundRepository extends JpaRepository<Refund, Long> {
    Optional<Refund> findByRazorpayRefundId(String razorpayRefundId);
    Optional<Refund> findByBooking_Id(Long bookingId);
}
