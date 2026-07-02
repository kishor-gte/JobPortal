package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import in.sp.main.Entities.OrganizerDocument;

@Repository
public interface OrganizerDocumentRepository
        extends JpaRepository<OrganizerDocument, Long> {

    List<OrganizerDocument> findByOrganizer_Id(Long organizerId);
}
