package in.sp.main.Controllers;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.AssessmentQuestion;
import in.sp.main.Services.AssessmentService;
import in.sp.main.Services.ExcelHelper;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/assessments")
public class AssessmentController {

    @Autowired
    private AssessmentService service;

    
    @RequestMapping(value = "/uploadpage", method = RequestMethod.GET)
    public String showAdminUploadPage(HttpSession session, Model model) {
        Long adminId = (Long) session.getAttribute("adminId");
        if (adminId == null) {
            return "redirect:/admin/loginAdmin";
        }
        model.addAttribute("sourceType", "ADMIN");
        return "assessments/upload-page"; // same JSP, just without jobId
    }

    @RequestMapping(value = "/uploadpage/recruiter", method = RequestMethod.GET)
    public String showRecruiterUploadPage(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
        Long recruiterId = (Long) session.getAttribute("recruiterId");
        Long adminId = (Long) session.getAttribute("adminId");
        Object loggedInCompany = session.getAttribute("loggedInCompany");
        
        if (recruiterId != null) {
            model.addAttribute("recruiterId", recruiterId);
            model.addAttribute("sourceType", "RECRUITER");
        } else if (adminId != null) {
            model.addAttribute("sourceType", "ADMIN");
        } else if (loggedInCompany != null) {
            model.addAttribute("sourceType", "RECRUITER");
        } else {
            return "redirect:/company/login";
        }
        
        model.addAttribute("jobId", jobId);
        return "assessments/upload-page";
    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public String uploadExcel(@RequestParam("file") MultipartFile file,
                              @RequestParam("skill") String skill,
                              @RequestParam(value = "replace", required = false) boolean replace,
                              @RequestParam(value = "jobId", required = false) Long jobId,
                              HttpSession session,
                              Model model) {
        try {
            // Validate file
            if (file == null || file.isEmpty()) {
                model.addAttribute("message", "Error: Please select a file to upload");
                return "assessments/upload-result";
            }
            
            // Check file type
            String contentType = file.getContentType();
            String fileName = file.getOriginalFilename();
            if (fileName == null || !fileName.endsWith(".xlsx")) {
                model.addAttribute("message", "Error: Only .xlsx files are supported");
                return "assessments/upload-result";
            }
            
            // Decide sourceType based on session
            String sourceType;
            Long recruiterId = (Long) session.getAttribute("recruiterId");
            Long adminId = (Long) session.getAttribute("adminId");
            Object loggedInCompany = session.getAttribute("loggedInCompany");
            
            if (recruiterId != null) {
                sourceType = "RECRUITER";
            } else if (adminId != null) {
                sourceType = "ADMIN";
            } else if (loggedInCompany != null) {
                sourceType = "RECRUITER";
            } else {
                model.addAttribute("message", "Error: Unauthorized upload attempt. Please login.");
                return "assessments/upload-result";
            }

            // Delete existing questions if replace is checked
            if (replace) {
                service.deleteBySkill(skill);
            }

            // Parse Excel and save questions
            List<AssessmentQuestion> questions = ExcelHelper.convertExcelToList(file.getInputStream(), skill);
            
            if (questions.isEmpty()) {
                model.addAttribute("message", "Error: No valid questions found in the file. Please check the format.");
                return "assessments/upload-result";
            }
            
            for (AssessmentQuestion q : questions) {
                q.setSourceType(sourceType);
                q.setRecruiterId(recruiterId);
                q.setJobId(jobId);
            }

            service.saveAll(questions);
            model.addAttribute("message", "Successfully uploaded " + questions.size() + " questions for " + skill);

        } catch (IOException e) {
            System.err.println("IO Error uploading file: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("message", "Error reading file: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Error uploading file: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("message", "Error uploading file: " + e.getMessage());
        }

        return "assessments/upload-result";
    }


}
