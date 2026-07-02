package in.sp.main.Entities;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;

@Entity
public class OrganizerEventPhoto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String photoTitle; // optional

    // 🔥 Path to file in external upload directory
    private String filePath; // e.g. organizer-photos/uuid.jpg

    @ManyToOne
    @JoinColumn(name = "organizer_id")
    private SportsOrganizer organizer;

    // getters & setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getPhotoTitle() {
        return photoTitle;
    }

    public void setPhotoTitle(String photoTitle) {
        this.photoTitle = photoTitle;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public SportsOrganizer getOrganizer() {
        return organizer;
    }

    public void setOrganizer(SportsOrganizer organizer) {
        this.organizer = organizer;
    }
}
