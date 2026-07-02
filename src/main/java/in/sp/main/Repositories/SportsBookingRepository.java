package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.SportsBooking;

public interface SportsBookingRepository
        extends JpaRepository<SportsBooking, Long> {

    List<SportsBooking> findByRecruiter_Id(Long recruiterId);

    List<SportsBooking> findByService_Id(Long serviceId);

    List<SportsBooking> findByStatus(String status);

    List<SportsBooking> findByRecruiter_IdAndService_IdAndStatusIn(Long recruiterId, Long serviceId, List<String> statuses);
}
