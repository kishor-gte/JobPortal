package in.sp.main.Controllers;


import java.io.IOException;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.VideoResume;
import in.sp.main.Services.FileUploadServices;
import in.sp.main.Services.JobSeekerService;
import in.sp.main.Services.VideoResumeService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/jobseeker/videos")
public class VideoResumeController {

    @Autowired
    private VideoResumeService videoResumeService;

    @Autowired
    private FileUploadServices fileUploadService;
    @Autowired
    private JobSeekerService jobSeekerService;

    @RequestMapping(method = RequestMethod.GET)
    public String viewVideo(Model model, HttpSession session) {
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
        if (jobSeeker == null) return "redirect:/jobSeekers/login";

        VideoResume video = videoResumeService.findByJobSeeker(jobSeeker);
        model.addAttribute("video", video);
        return "jobSeekers/view-videoResume";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String saveOrUpdateVideo(@RequestParam("filepath") MultipartFile file,
                                    HttpSession session, Model model) throws IOException {
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
        if (jobSeeker == null) return "redirect:/jobSeekers/login";

        VideoResume existing = videoResumeService.findByJobSeeker(jobSeeker);

        if (existing != null) {
            model.addAttribute("existing", true);
            model.addAttribute("video", existing);
            return "jobSeekers/view-videoResume";
        }

        String path = fileUploadService.saveVideo(file);

        VideoResume video = new VideoResume();
        video.setFilePath(path);
        video.setUploadedAt(LocalDateTime.now());
        video.setUploadedBy(jobSeeker);
jobSeeker.setVideoResumeUrl(path);
JobSeeker seeker= jobSeekerService.updateJobSeeker(jobSeeker.getId(), jobSeeker);
System.out.println(seeker.getName()+"++++++++++++++++++++++++++++++++++");
        videoResumeService.save(video);
        return "redirect:/jobseeker/videos";
    }

    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    public String deleteVideo(@RequestParam("id") Long id, HttpSession session, Model model) {
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
        if (jobSeeker == null) return "redirect:/jobSeekers/login";
        
        try {
            VideoResume video = videoResumeService.findByIdAndJobSeeker(id, jobSeeker);
            if (video == null) {
                model.addAttribute("error", "Video resume not found or you don't have permission to delete it.");
                return "redirect:/jobseeker/videos";
            }
            
            // Delete the video file from filesystem
            String filePath = video.getFilePath();
            if (filePath != null && !filePath.isEmpty()) {
                try {
                    java.io.File file = new java.io.File(System.getProperty("user.home") + "/jobportal-uploads" + filePath.replace("/uploads", ""));
                    if (file.exists()) {
                        file.delete();
                    }
                } catch (Exception e) {
                    System.err.println("Error deleting file: " + e.getMessage());
                }
            }
            
            videoResumeService.deleteByIdAndJobSeeker(id, jobSeeker);
            
            // Clear jobSeeker's videoResumeUrl
            jobSeeker.setVideoResumeUrl(null);
            jobSeekerService.updateJobSeeker(jobSeeker.getId(), jobSeeker);
            
            return "redirect:/jobseeker/videos";
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "Error deleting video resume: " + e.getMessage());
            return "redirect:/jobseeker/videos";
        }
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateVideo(@RequestParam("id") Long id,
                              @RequestParam("filepath") MultipartFile file,
                              HttpSession session) throws IOException {
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
        if (jobSeeker == null) return "redirect:/jobSeekers/login";
        
        VideoResume video = videoResumeService.findByIdAndJobSeeker(id, jobSeeker);
        if (video == null) {
            return "redirect:/jobseeker/videos";
        }
        
        String newPath = fileUploadService.saveVideo(file);
        video.setFilePath(newPath);
        video.setUploadedAt(LocalDateTime.now());
        videoResumeService.save(video);
        
        // Update jobSeeker's videoResumeUrl
        jobSeeker.setVideoResumeUrl(newPath);
        jobSeekerService.updateJobSeeker(jobSeeker.getId(), jobSeeker);
        
        return "redirect:/jobseeker/videos";
    }
    @RequestMapping(value = "/recruiter/viewVideo/{jobSeekerId}", method = RequestMethod.GET)
    public String viewJobSeekerVideo(@PathVariable Long jobSeekerId, Model model) {
        JobSeeker jobSeeker = jobSeekerService.getJobSeekerById(jobSeekerId);
        VideoResume video = videoResumeService.findByJobSeeker(jobSeeker);
        model.addAttribute("video", video);
        return "recruiter/videoResume-view"; // Create a similar JSP for recruiter/admin
    }

}
