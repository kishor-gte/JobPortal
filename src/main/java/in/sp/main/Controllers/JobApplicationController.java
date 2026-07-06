package in.sp.main.Controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobApplication;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Repositories.JobApplicationRepository;
import in.sp.main.Services.JobApplicationService;
import in.sp.main.Services.JobServices;
import in.sp.main.utils.ActivityLogger;
import in.sp.main.Enums.ActivityType;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/applications")
public class JobApplicationController {

    @Autowired
    private JobServices jobService;

    @Autowired
    private JobApplicationService applicationService;

    @Autowired
    private JobApplicationRepository jobApplicationRepository;

    @Autowired
    private in.sp.main.dao.PerformanceDAO performanceDAO;

    @Autowired
    private ActivityLogger activityLogger;

    // Apply to a job
    @RequestMapping(value = "/apply", method = RequestMethod.POST)
    public String applyToJob(@RequestParam Long jobId, HttpSession session, RedirectAttributes redirectAttributes) {
        JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");
        Job job = jobService.getJobById(jobId);

        if (seeker == null || job == null) {
            redirectAttributes.addFlashAttribute("error", "Couldn't apply for this job");
            return "redirect:/jobs/all";
        }


        try {
            applicationService.apply(job, seeker);
            activityLogger.log(seeker.getId(), seeker.getName(), seeker.getEmail(), "JOBSEEKER", ActivityType.APPLIED_TO_JOB, "Applied for job: " + job.getTitle());
            redirectAttributes.addFlashAttribute("message", "Successfully applied for the job.");
        } catch (IllegalStateException e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }

        return "redirect:/jobs/all";
    }


    // View job applications for a job seeker
    @RequestMapping(value = "/track", method = RequestMethod.GET)
    public String viewApplications(HttpSession session, Model model) {
        JobSeeker seeker = (JobSeeker) session.getAttribute("jobSeeker");
        if (seeker != null) {
            List<JobApplication> applications = applicationService.getApplicationsBySeeker(seeker);
            model.addAttribute("applications", applications);
            return "jobSeekers/myApplications"; // Create this JSP file
        }
        return "redirect:/jobSeekers/login";
    }
    @RequestMapping(value = "/recruiter/download-applicants/{jobId}", method = RequestMethod.GET)
    public void downloadApplicantsExcel(@PathVariable Long jobId, HttpServletResponse response) throws IOException {
        List<JobApplication> applications = jobApplicationRepository.findByJob_Id(jobId);

        // Set Excel response
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=applicants_job_" + jobId + ".xlsx");

        XSSFWorkbook workbook = new XSSFWorkbook();
        XSSFSheet sheet = workbook.createSheet("Applicants");

        // Header row
        Row header = sheet.createRow(0);
        String[] columns = {"Name", "Email", "Phone", "DOB","Age","Languages Known","Gender",
        		"Marital Status","Location","Pincode","Permanent Address","Education",
        		"UG Degree","UG Specialization","UG University","UG Graduation Year",
        		"PG Degree","PG Specialization","PG University","PG Graduation Year",
        		"Doctrate Degree","Doctrate Specialization","Doctrate University","Doctrate Graduation Year",
        		"Resume Headline","Work Availability","Annual Salary","Notice Period","Account Status",
        		"Profile Updated At",
        		
        		"Experience", "Skills",  "Status", "Interview Date","Comment 1","Comment 2"};
        for (int i = 0; i < columns.length; i++) {
            header.createCell(i).setCellValue(columns[i]);
        }
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm");

        // Fill rows
        int rowNum = 1;
        for (JobApplication application : applications) {
            JobSeeker seeker = application.getJobSeeker();
            Row row = sheet.createRow(rowNum++);

            // Personal Details
            row.createCell(0).setCellValue(seeker.getName());
            row.createCell(1).setCellValue(seeker.getEmail());
            row.createCell(2).setCellValue(seeker.getPhone());
            row.createCell(3).setCellValue(seeker.getDateOfBirth() != null ? seeker.getDateOfBirth().toString() : "-");
            row.createCell(4).setCellValue(seeker.getAge() != null ? seeker.getAge() : 0);
           
            row.createCell(5).setCellValue(seeker.getLanguagesKnown() != null ? seeker.getLanguagesKnown() : "-");
            row.createCell(6).setCellValue(seeker.getGender() != null ? seeker.getGender().toString() : "-");
            row.createCell(7).setCellValue(seeker.getMaritalStatus() != null ? seeker.getMaritalStatus() : "-");
            row.createCell(8).setCellValue(seeker.getLocation().toString());
            row.createCell(9).setCellValue(seeker.getPinCode() != null ? seeker.getPinCode() : "-");
           
            row.createCell(10).setCellValue(seeker.getPermanentAddress() != null ? seeker.getPermanentAddress() : "-");

            // Educational Details
            row.createCell(11).setCellValue(seeker.getEducation()!=null?seeker.getEducation().toString():"-");
            row.createCell(12).setCellValue(seeker.getUgDegree() != null ? seeker.getUgDegree() : "-");
            row.createCell(13).setCellValue(seeker.getUgSpecialization() != null ? seeker.getUgSpecialization() : "-");
            row.createCell(14).setCellValue(seeker.getUgUniversity() != null ? seeker.getUgUniversity() : "-");
            row.createCell(15).setCellValue(seeker.getUgGraduationYear() != null ? seeker.getUgGraduationYear() : 0);

            row.createCell(16).setCellValue(seeker.getPgDegree() != null ? seeker.getPgDegree() : "-");
            row.createCell(17).setCellValue(seeker.getPgSpecialization() != null ? seeker.getPgSpecialization() : "-");
            row.createCell(18).setCellValue(seeker.getPgUniversity() != null ? seeker.getPgUniversity() : "-");
            row.createCell(19).setCellValue(seeker.getPgGraduationYear() != null ? seeker.getPgGraduationYear() : 0);

            row.createCell(20).setCellValue(seeker.getDoctorateDegree() != null ? seeker.getDoctorateDegree() : "-");
            row.createCell(21).setCellValue(seeker.getDoctorateSpecialization() != null ? seeker.getDoctorateSpecialization() : "-");
            row.createCell(22).setCellValue(seeker.getDoctorateUniversity() != null ? seeker.getDoctorateUniversity() : "-");
            row.createCell(23).setCellValue(seeker.getDoctorateGraduationYear() != null ? seeker.getDoctorateGraduationYear() : 0);

            // Job Application Specific Details
            row.createCell(24).setCellValue(seeker.getResumeHeadline() != null ? seeker.getResumeHeadline() : "-");
           
            row.createCell(25).setCellValue(seeker.getWorkAvailability() != null ? seeker.getWorkAvailability().toString() : "-");
            row.createCell(26).setCellValue(seeker.getAnnualSalary() != null ? seeker.getAnnualSalary() : 0.0);
            row.createCell(27).setCellValue(seeker.getNoticePeriod() != null ? seeker.getNoticePeriod() : "-");
            
            // Account and Other Details
            row.createCell(28).setCellValue(seeker.getAccountStatus() != null ? seeker.getAccountStatus().toString() : "-");
          
            row.createCell(29).setCellValue(seeker.getUpdatedAt() != null ? seeker.getUpdatedAt() : "-");
            row.createCell(30).setCellValue(seeker.getExperience() != null ? seeker.getExperience().toString() : "-");

            // Skills Details
            row.createCell(31).setCellValue(String.join(", ", seeker.getSkills()));

            // Job Application Status
            row.createCell(32).setCellValue(application.getStatus().toString());

            // Interview Date (if applicable)
            if (application.getInterviewDate() != null) {
                LocalDateTime localDateTime = application.getInterviewDate();
                Date interviewDate = (Date) Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
                row.createCell(33).setCellValue(dateFormat.format(interviewDate));
            } else {
                row.createCell(33).setCellValue("N/A");
            }
            row.createCell(34).setCellValue("N/A");
            row.createCell(35).setCellValue("N/A");
        }

        workbook.write(response.getOutputStream());
        workbook.close();
    }

}
