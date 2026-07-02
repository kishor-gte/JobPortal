package in.sp.main.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.Subscriber;

public interface SubscriberRepository extends JpaRepository<Subscriber, Long> {
    boolean existsByEmail(String email);
}

