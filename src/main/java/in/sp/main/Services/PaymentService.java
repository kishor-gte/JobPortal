package in.sp.main.Services;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.Payment;
import in.sp.main.Entities.SportsBooking;
import in.sp.main.Repositories.PaymentRepository;
import in.sp.main.Repositories.SportsBookingRepository;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepository paymentRepo;

    @Autowired
    private SportsBookingRepository bookingRepo;

    public void makePayment(Long bookingId, Payment payment) {

        SportsBooking booking = bookingRepo.findById(bookingId)
                .orElseThrow(() -> new RuntimeException("Booking not found"));

        // Set payment details
        payment.setPaymentStatus("SUCCESS");
        payment.setPaymentTime(LocalDateTime.now());

        // Attach payment to booking (OWNING SIDE)
        booking.setPayment(payment);

        // Update booking status
        booking.setStatus("CONFIRMED");

        // 🔥 SAVE ONLY BOOKING
        bookingRepo.save(booking);
    }

}
