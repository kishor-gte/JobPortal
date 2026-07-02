package in.sp.main.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.sp.main.Entities.Payment;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {
}
