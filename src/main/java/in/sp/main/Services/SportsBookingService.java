package in.sp.main.Services;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.SportsBooking;
import in.sp.main.Entities.SportsService;
import in.sp.main.Repositories.SportsBookingRepository;
import in.sp.main.Repositories.SportsServiceRepository;

@Service
public class SportsBookingService {

    @Autowired
    private SportsBookingRepository bookingRepo;

    @Autowired
    private SportsServiceRepository serviceRepo;

    public void createBooking(SportsBooking booking) {
        booking.setStatus("REQUESTED");
        booking.setBookedAt(LocalDateTime.now());
        bookingRepo.save(booking);
    }

    public SportsBooking updateBooking(SportsBooking booking) {
        return bookingRepo.save(booking);
    }

    public SportsBooking findPendingBookingForRecruiterAndService(Long recruiterId, Long serviceId) {
        List<String> pendingStatuses = Arrays.asList("REQUESTED", "PAYMENT_PENDING");
        List<SportsBooking> pendingBookings = bookingRepo.findByRecruiter_IdAndService_IdAndStatusIn(recruiterId, serviceId, pendingStatuses);
        return pendingBookings.isEmpty() ? null : pendingBookings.get(0);
    }

    public SportsBooking findById(Long id) {
        return bookingRepo.findById(id).orElse(null);
    }

	/*
	 * public List<SportsBooking> getBookingsForOrganizer(Long organizerId) { return
	 * bookingRepo.findByServiceOrganizerId(organizerId); }
	 */

    public List<SportsBooking> getBookingsForRecruiter(Long recruiterId) {
        return bookingRepo.findByRecruiter_Id(recruiterId);
    }

    public List<SportsBooking> getAllBookings() {
        return bookingRepo.findAll();
    }
}
