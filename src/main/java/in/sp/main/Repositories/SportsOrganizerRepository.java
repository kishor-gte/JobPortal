package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.sp.main.Entities.SportsOrganizer;

@Repository
public interface SportsOrganizerRepository extends JpaRepository<SportsOrganizer, Long> {

    SportsOrganizer findByEmailAndPassword(String email, String password);
    SportsOrganizer findByEmail(String email);

    List<SportsOrganizer> findByVerifiedTrue();

    List<SportsOrganizer>findByVerifiedFalse();
}
