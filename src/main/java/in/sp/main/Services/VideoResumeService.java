package in.sp.main.Services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.VideoResume;
import in.sp.main.Repositories.VideoResumeRepository;

@Service
public class VideoResumeService {

    @Autowired
    private VideoResumeRepository videoResumeRepository;

   
    public void save(VideoResume video) {
        videoResumeRepository.save(video);
    }

  
    public VideoResume findByJobSeeker(JobSeeker jobSeeker) {
        return videoResumeRepository.findByUploadedBy(jobSeeker);
    }

  
    public VideoResume findByIdAndJobSeeker(Long id, JobSeeker jobSeeker) {
        return videoResumeRepository.findByIdAndUploadedBy(id, jobSeeker).orElse(null);
    }

    public void deleteByIdAndJobSeeker(Long id, JobSeeker jobSeeker) {
        VideoResume video = findByIdAndJobSeeker(id, jobSeeker);
        if (video != null) {
            videoResumeRepository.delete(video);
        }
    }
}
