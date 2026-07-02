package in.sp.main.Services;

import in.sp.main.Entities.Refund;
import in.sp.main.Repositories.RefundRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class RefundService {

    @Autowired
    private RefundRepository refundRepository;

    public Refund saveRefund(Refund refund) {
        return refundRepository.save(refund);
    }

    public Optional<Refund> findByBookingId(Long bookingId) {
        return refundRepository.findByBooking_Id(bookingId);
    }

    public Optional<Refund> findByRazorpayRefundId(String razorpayRefundId) {
        return refundRepository.findByRazorpayRefundId(razorpayRefundId);
    }
}
