package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.sp.main.Entities.OrganizerEventPhoto;

@Repository
public interface OrganizerEventPhotoRepository
        extends JpaRepository<OrganizerEventPhoto, Long> {

    List<OrganizerEventPhoto> findByOrganizer_Id(Long organizerId);
}
