package in.sp.main.Repositories;



import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.VideoResume;

public interface VideoResumeRepository extends JpaRepository<VideoResume, Long> {
	
    // Get resume by JobSeeker
    VideoResume findByUploadedBy(JobSeeker jobSeeker);

    // Get resume by ID and JobSeeker (exact match)
    Optional<VideoResume> findByIdAndUploadedBy(Long id, JobSeeker uploadedBy);
}
