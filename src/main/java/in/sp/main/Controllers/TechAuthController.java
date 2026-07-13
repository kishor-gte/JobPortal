package in.sp.main.Controllers;

import in.sp.main.Entities.TechPerson;
import in.sp.main.Services.TechPersonServices;
import in.sp.main.Configuration.JwtUtil;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import in.sp.main.Entities.CompetitionRecording;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.Competition;
import in.sp.main.Repositories.CompetitionRecordingRepository;
import in.sp.main.Repositories.JobSeekerRepository;
import in.sp.main.Repositories.CompetitionRepository;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.Files;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

@Controller
@RequestMapping("/tech")
public class TechAuthController {

    @Autowired
    private TechPersonServices techPersonServices;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private CompetitionRecordingRepository recordingRepository;

    @Autowired
    private JobSeekerRepository jobSeekerRepository;

    @Autowired
    private CompetitionRepository competitionRepository;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginForm() {
        return "techperson/loginTechPerson";
    }

    @RequestMapping(value = "/login1", method = RequestMethod.POST)
    public String loginTechPerson(@RequestParam String email,
            @RequestParam String password,
            Model model,
            HttpServletResponse response,
            HttpSession session) {

        TechPerson techPerson = techPersonServices.authenticateTechPerson(email, password);

        if (techPerson != null) {
            String token = jwtUtil.generateToken(String.valueOf(techPerson.getId()), "TECHPERSON");
            Cookie cookie = jwtUtil.createJwtCookie(token);
            response.addCookie(cookie);

            session.setAttribute("loggedInTechPerson", techPerson);
            session.setAttribute("userType", "TECHPERSON");
            session.setAttribute("techPersonId", techPerson.getId());
            return "redirect:/tech/dashboard";
        } else {
            model.addAttribute("error", "Invalid credentials");
            return "techperson/loginTechPerson";
        }
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutTechPerson(HttpSession session, HttpServletResponse response) {
        session.invalidate();
        Cookie cookie = jwtUtil.createClearJwtCookie();
        response.addCookie(cookie);
        return "redirect:/tech/login";
    }

    @GetMapping("/competition-recordings")
    public String viewRecordings(HttpSession session, Model model) {
        if (session.getAttribute("loggedInTechPerson") == null) {
            return "redirect:/tech/login";
        }
        
        List<CompetitionRecording> recordings = recordingRepository.findAll();
        List<Map<String, Object>> recordingDetails = new ArrayList<>();
        
        for (CompetitionRecording rec : recordings) {
            Map<String, Object> details = new HashMap<>();
            details.put("recording", rec);
            
            JobSeeker student = jobSeekerRepository.findById(rec.getStudentId()).orElse(null);
            details.put("studentName", student != null ? student.getName() : "Unknown");
            
            Competition comp = competitionRepository.findById(rec.getCompetitionId()).orElse(null);
            details.put("competitionTitle", comp != null ? comp.getTitle() : "Unknown");
            
            recordingDetails.add(details);
        }
        
        model.addAttribute("recordings", recordingDetails);
        return "techperson/competition-recordings";
    }

    @GetMapping("/stream-recording/{id}")
    public ResponseEntity<Resource> streamRecording(@PathVariable Long id, HttpSession session) {
        if (session.getAttribute("loggedInTechPerson") == null) {
            return ResponseEntity.status(401).build();
        }
        
        try {
            CompetitionRecording rec = recordingRepository.findById(id).orElse(null);
            if (rec == null) return ResponseEntity.notFound().build();
            
            // Reconstruct absolute path
            String filename = rec.getVideoPath().substring(rec.getVideoPath().lastIndexOf("/") + 1);
            String uploadDir = System.getProperty("user.home") + "/jobportal-uploads/competition-recordings/";
            Path filePath = Paths.get(uploadDir).resolve(filename).normalize();
            
            Resource resource = new UrlResource(filePath.toUri());
            if (resource.exists()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.parseMediaType("video/webm"))
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + filename + "\"")
                        .body(resource);
            } else {
                return ResponseEntity.notFound().build();
            }
        } catch (Exception e) {
            return ResponseEntity.internalServerError().build();
        }
    }

    @GetMapping("/delete-recording/{id}")
    public String deleteRecording(@PathVariable Long id, HttpSession session) {
        if (session.getAttribute("loggedInTechPerson") == null) {
            return "redirect:/tech/login";
        }
        
        try {
            CompetitionRecording rec = recordingRepository.findById(id).orElse(null);
            if (rec != null) {
                String filename = rec.getVideoPath().substring(rec.getVideoPath().lastIndexOf("/") + 1);
                String uploadDir = System.getProperty("user.home") + "/jobportal-uploads/competition-recordings/";
                Path filePath = Paths.get(uploadDir).resolve(filename).normalize();
                
                if (Files.exists(filePath)) {
                    Files.delete(filePath);
                }
                recordingRepository.delete(rec);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "redirect:/tech/competition-recordings";
    }
}
