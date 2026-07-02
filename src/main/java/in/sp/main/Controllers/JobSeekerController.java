package in.sp.main.Controllers;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import in.sp.main.Configuration.SessionConstants;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Enums.AccountStatus;
import in.sp.main.Enums.Education;
import in.sp.main.Enums.Gender;
import in.sp.main.Enums.Location;
import in.sp.main.Enums.WorkAvailability;
import in.sp.main.Services.AuditLogService;
import in.sp.main.Services.FileUploadServices;
import in.sp.main.Services.JobSeekerService;
import in.sp.main.Services.LoginAttemptService;
import in.sp.main.Services.PasswordResetService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/jobSeekers")
public class JobSeekerController {

    @Autowired
    private JobSeekerService jobSeekerService;

    @Autowired
    private FileUploadServices fileUploadService; // Inject the file upload service
    
    @Autowired
    private PasswordResetService passwordResetService;
    
    @Autowired
    private AuditLogService auditLogService;
    
    @Autowired
    private LoginAttemptService loginAttemptService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage() {
        return "jobSeekers/login";  // This should be the name of your JSP file: jobSeekerLogin.jsp
    }
    @RequestMapping(value = "/login1", method = RequestMethod.POST)
    public String handleLogin(@RequestParam("email") String email,
                              @RequestParam("password") String password,
                              HttpSession session,
                              Model model,
                              HttpServletRequest request) {

        // Check if account is locked
        if (loginAttemptService.isLocked(email)) {
            long remainingMinutes = loginAttemptService.getLockoutRemainingMinutes(email);
            model.addAttribute("error", "Account locked due to too many failed attempts. Try again in " + remainingMinutes + " minutes.");
            return "jobSeekers/login";
        }

        JobSeeker jobSeeker = jobSeekerService.findByEmail(email);

        boolean matches = false;
        if (jobSeeker != null) {
            try {
                matches = BCrypt.checkpw(password, jobSeeker.getPassword());
            } catch (Exception e) {}

            if (!matches) {
                if (jobSeeker.getPassword().equals(password)) {
                    // Migration
                    jobSeeker.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
                    jobSeekerService.updateJobSeeker(jobSeeker.getId(), jobSeeker);
                    matches = true;
                }
            }
        }

        if (matches) {
            // Clear failed attempts
            loginAttemptService.loginSucceeded(email);
            
            // Invalidate old session to prevent session fixation
            session.invalidate();
            session = request.getSession(true);
            
            session.setAttribute(SessionConstants.ATTR_JOB_SEEKER, jobSeeker);
            session.setAttribute(SessionConstants.ATTR_USER_TYPE, SessionConstants.TYPE_JOBSEEKER);
            session.setAttribute(SessionConstants.ATTR_JOB_SEEKER_ID, jobSeeker.getId());
     
            // Log successful login
            auditLogService.logLogin(email, SessionConstants.TYPE_JOBSEEKER, request.getRemoteAddr(), true);
            
            return "redirect:dashboard"; // redirect to dashboard
        } else {
            // Record failed attempt
            if (jobSeeker != null) {
                loginAttemptService.loginFailed(email);
                int remainingAttempts = loginAttemptService.getRemainingAttempts(email);
                model.addAttribute("error", "Invalid email or password. " + remainingAttempts + " attempts remaining.");
            } else {
                model.addAttribute("error", "Invalid email or password");
            }
            
            // Log failed login
            auditLogService.logLogin(email, SessionConstants.TYPE_JOBSEEKER, request.getRemoteAddr(), false);
            
            return "jobSeekers/login"; // show login form again with error
        }
    }
    // Get the job seeker by ID
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String getJobSeeker(@PathVariable Long id, Model model) {
        JobSeeker jobSeeker = jobSeekerService.getJobSeekerById(id);
        model.addAttribute("jobSeeker", jobSeeker);
        return "jobSeekers/jobSeeker"; // returns jobSeeker.jsp
    }

    // Show the registration page for Job Seeker
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(Model model) {
        model.addAttribute("jobSeeker", new JobSeeker());
        model.addAttribute("locations", Location.values());
        return "jobSeekers/jobSeeker";  // Returns register page for Job Seeker
    }

    // Register a new Job Seeker (POST mapping)
    @RequestMapping(value = "/register1", method = RequestMethod.POST)
    public String createJobSeeker(@ModelAttribute JobSeeker jobSeeker,
                                  @RequestParam("image") MultipartFile image,
                                  @RequestParam("resume") MultipartFile resume,
                                  @RequestParam("identityDoc") MultipartFile identityDoc,
                                  Model model) throws IOException {

        try {
            // Handle profile photo upload
            if (!image.isEmpty()) {
                String profilePictureUrl = fileUploadService.saveFile(image);
                jobSeeker.setProfilePicture(profilePictureUrl);
            }
            // Handle resume upload and set the file path
            if (!resume.isEmpty()) {
                String resumePath = fileUploadService.saveFile(resume);
                jobSeeker.setResumeUploaded(resumePath);  // This stores the file path (String)
            }
            
         // Handle identity document upload
            if (!identityDoc.isEmpty()) {
                String identityDocUrl = fileUploadService.saveFile(identityDoc);
                jobSeeker.setIdentityDocument(identityDocUrl);  // Store the file path as a String
            } else {
                model.addAttribute("error", "Please upload your identity document.");
                return "jobSeekers/jobSeekerRegistration"; // Stay on the same page if no document is uploaded
            }

            // Set default account status
            jobSeeker.setAccountStatus(AccountStatus.ACTIVE);

            // Save the job seeker to the database
            jobSeekerService.createJobSeeker(jobSeeker);

            // Redirect to login page after successful registration
            return "redirect:login";
            
        } catch (IOException e) {
            System.err.println("File upload error: " + e.getMessage());
            model.addAttribute("error", "File upload failed. Please try again.");
            return "jobSeekers/jobSeekerRegistration"; // Stay on the registration page if upload fails
        }
    }
    
    private int calculateCompletionPercentage(JobSeeker jobSeeker) {
        int totalFields = 38;
        int filledFields = 0;

        if (jobSeeker.getName() != null && !jobSeeker.getName().isEmpty()) filledFields++;
        if (jobSeeker.getEmail() != null && !jobSeeker.getEmail().isEmpty()) filledFields++;
        if (jobSeeker.getPassword() != null && !jobSeeker.getPassword().isEmpty()) filledFields++;
        if (jobSeeker.getPhone() != null && !jobSeeker.getPhone().isEmpty()) filledFields++;
        if (jobSeeker.getLocation() != null) filledFields++;
        if (jobSeeker.getAge() != null) filledFields++;
        if (jobSeeker.getProfilePicture() != null && !jobSeeker.getProfilePicture().isEmpty()) filledFields++;
        if (jobSeeker.getLanguagesKnown() != null && !jobSeeker.getLanguagesKnown().isEmpty()) filledFields++;
        if (jobSeeker.getResumeUploaded() != null && !jobSeeker.getResumeUploaded().isEmpty()) filledFields++;
        if (jobSeeker.getVideoResumeUrl() != null && !jobSeeker.getVideoResumeUrl().isEmpty()) filledFields++;
        if (jobSeeker.getIdentityDocument() != null && !jobSeeker.getIdentityDocument().isEmpty()) filledFields++;
        if (jobSeeker.getExperience() != null) filledFields++;
        if (jobSeeker.getGender() != null) filledFields++;
        if (jobSeeker.getEducation() != null) filledFields++;
        if (jobSeeker.getSkills() != null && !jobSeeker.getSkills().isEmpty()) filledFields++;
        if (jobSeeker.getWorkAvailability() != null) filledFields++;
        if (jobSeeker.getAccountStatus() != null) filledFields++;
        if (jobSeeker.getCreatedAt() != null && !jobSeeker.getCreatedAt().isEmpty()) filledFields++;
        if (jobSeeker.getUpdatedAt() != null && !jobSeeker.getUpdatedAt().isEmpty()) filledFields++;
        if (jobSeeker.getAnnualSalary() != null) filledFields++;
        if (jobSeeker.getNoticePeriod() != null && !jobSeeker.getNoticePeriod().isEmpty()) filledFields++;
        if (jobSeeker.getResumeHeadline() != null && !jobSeeker.getResumeHeadline().isEmpty()) filledFields++;

        // UG
        if (jobSeeker.getUgDegree() != null && !jobSeeker.getUgDegree().isEmpty()) filledFields++;
        if (jobSeeker.getUgSpecialization() != null && !jobSeeker.getUgSpecialization().isEmpty()) filledFields++;
        if (jobSeeker.getUgUniversity() != null && !jobSeeker.getUgUniversity().isEmpty()) filledFields++;
        if (jobSeeker.getUgGraduationYear() != null) filledFields++;

        // PG
        if (jobSeeker.getPgDegree() != null && !jobSeeker.getPgDegree().isEmpty()) filledFields++;
        if (jobSeeker.getPgSpecialization() != null && !jobSeeker.getPgSpecialization().isEmpty()) filledFields++;
        if (jobSeeker.getPgUniversity() != null && !jobSeeker.getPgUniversity().isEmpty()) filledFields++;
        if (jobSeeker.getPgGraduationYear() != null) filledFields++;

        // Doctorate
        if (jobSeeker.getDoctorateDegree() != null && !jobSeeker.getDoctorateDegree().isEmpty()) filledFields++;
        if (jobSeeker.getDoctorateSpecialization() != null && !jobSeeker.getDoctorateSpecialization().isEmpty()) filledFields++;
        if (jobSeeker.getDoctorateUniversity() != null && !jobSeeker.getDoctorateUniversity().isEmpty()) filledFields++;
        if (jobSeeker.getDoctorateGraduationYear() != null) filledFields++;

        // Others
        if (jobSeeker.getMaritalStatus() != null && !jobSeeker.getMaritalStatus().isEmpty()) filledFields++;
        if (jobSeeker.getPinCode() != null && !jobSeeker.getPinCode().isEmpty()) filledFields++;
        if (jobSeeker.getDateOfBirth() != null) filledFields++;
        if (jobSeeker.getPermanentAddress() != null && !jobSeeker.getPermanentAddress().isEmpty()) filledFields++;

        return (filledFields * 100) / totalFields;
    }


    // Method to retrieve the list of Job Seekers
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String getJobSeekerList(Model model) {
        List<JobSeeker> jobSeekers = jobSeekerService.getAllJobSeekers();
        model.addAttribute("jobSeekers", jobSeekers);
        return "jobSeekers/jobSeekerList"; // Returns the list view
    }

    // Update Job Seeker details
    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public String showUpdateForm(HttpSession session, Model model) {
    	
    	 JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
       // JobSeeker jobSeeker = jobSeekerService.getJobSeekerById(id);
        if (jobSeeker == null) {
            return "redirect:login"; // Job Seeker not found
        }
        // Convert Hibernate PersistentBag to ArrayList for JSP compatibility
        if (jobSeeker.getSkills() != null) {
            jobSeeker.setSkills(new java.util.ArrayList<>(jobSeeker.getSkills()));
        }
        model.addAttribute("jobSeeker", jobSeeker);
        model.addAttribute("locations", Location.values());
       model.addAttribute("education", Education.values());
        return "jobSeekers/jobSeekerUpdateForm"; // returns jobSeekerUpdateForm.jsp
    }

    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    public String updateJobSeeker(@PathVariable Long id,
                                  @RequestParam(value = "name", required = false) String name,
                                  @RequestParam(value = "email", required = false) String email,
                                  @RequestParam(value = "phone", required = false) String phone,
                                  @RequestParam(value = "age", required = false) Integer age,
                                  @RequestParam(value = "experience", required = false) Integer experience,
                                  @RequestParam(value = "location", required = false) Location location,
                                  @RequestParam(value = "languagesKnown", required = false) String languagesKnown,
                                  @RequestParam(value = "skills", required = false) String skillsString,
                                  @RequestParam(value = "gender", required = false) Gender gender,
                                  @RequestParam(value = "workAvailability", required = false) WorkAvailability workAvailability,
                                  @RequestParam(value = "accountStatus", required = false, defaultValue = "ACTIVE") AccountStatus accountStatus,
                                  @RequestParam(value = "resume", required = false) MultipartFile resume,
                                  @RequestParam(value = "image", required = false) MultipartFile image,
                                  @RequestParam(value = "identityDoc", required = false) MultipartFile identityDoc,
                                  @RequestParam(value = "education", required = false) Education education,
                                  @RequestParam(value = "ugDegree", required = false) String ugDegree,
                                  @RequestParam(value = "ugSpecialization", required = false) String ugSpecialization,
                                  @RequestParam(value = "ugUniversity", required = false) String ugUniversity,
                                  @RequestParam(value = "ugGraduationYear", required = false) Integer ugGraduationYear,
                                  @RequestParam(value = "pgDegree", required = false) String pgDegree,
                                  @RequestParam(value = "pgSpecialization", required = false) String pgSpecialization,
                                  @RequestParam(value = "pgUniversity", required = false) String pgUniversity,
                                  @RequestParam(value = "pgGraduationYear", required = false) Integer pgGraduationYear,
                                  @RequestParam(value = "doctorateDegree", required = false) String doctorateDegree,
                                  @RequestParam(value = "doctorateSpecialization", required = false) String doctorateSpecialization,
                                  @RequestParam(value = "doctorateUniversity", required = false) String doctorateUniversity,
                                  @RequestParam(value = "doctorateGraduationYear", required = false) Integer doctorateGraduationYear,
                                  @RequestParam(value = "annualSalary", required = false) Double annualSalary,
                                  @RequestParam(value = "noticePeriod", required = false) String noticePeriod,
                                  @RequestParam(value = "resumeHeadline", required = false) String resumeHeadline,
                                  @RequestParam(value = "maritalStatus", required = false) String maritalStatus,
                                  @RequestParam(value = "pinCode", required = false) String pinCode,
                                  @RequestParam(value = "dateOfBirth", required = false) String dateOfBirthString,
                                  @RequestParam(value = "permanentAddress", required = false) String permanentAddress,
                                  Model model) throws IOException {

        JobSeeker existingJobSeeker = jobSeekerService.getJobSeekerById(id);
        if (existingJobSeeker == null) {
            return "error"; // Job Seeker not found
        }

        try {
            // Convert the comma-separated skills string into a List
            List<String> skills = (skillsString != null && !skillsString.trim().isEmpty())
                ? Arrays.asList(skillsString.split("\\s*,\\s*"))
                : existingJobSeeker.getSkills();

            // Parse date of birth
            LocalDate dateOfBirth = (dateOfBirthString != null && !dateOfBirthString.trim().isEmpty())
                ? LocalDate.parse(dateOfBirthString)
                : existingJobSeeker.getDateOfBirth();

            // Update Job Seeker details
        existingJobSeeker.setName(name);
        existingJobSeeker.setEmail(email);
        existingJobSeeker.setPhone(phone);
        existingJobSeeker.setAge(age);
        existingJobSeeker.setLocation(location);
        existingJobSeeker.setLanguagesKnown(languagesKnown);
        existingJobSeeker.setGender(gender);
        existingJobSeeker.setWorkAvailability(workAvailability);
        existingJobSeeker.setAccountStatus(accountStatus);
        existingJobSeeker.setExperience(experience);
        existingJobSeeker.setSkills(skills);
        
        existingJobSeeker.setEducation(education);
        // Education Details
        existingJobSeeker.setUgDegree(ugDegree);
        existingJobSeeker.setUgSpecialization(ugSpecialization);
        existingJobSeeker.setUgUniversity(ugUniversity);
        existingJobSeeker.setUgGraduationYear(ugGraduationYear);

        existingJobSeeker.setPgDegree(pgDegree);
        existingJobSeeker.setPgSpecialization(pgSpecialization);
        existingJobSeeker.setPgUniversity(pgUniversity);
        existingJobSeeker.setPgGraduationYear(pgGraduationYear);

        existingJobSeeker.setDoctorateDegree(doctorateDegree);
        existingJobSeeker.setDoctorateSpecialization(doctorateSpecialization);
        existingJobSeeker.setDoctorateUniversity(doctorateUniversity);
        existingJobSeeker.setDoctorateGraduationYear(doctorateGraduationYear);

        existingJobSeeker.setAnnualSalary(annualSalary);
        existingJobSeeker.setNoticePeriod(noticePeriod);
        existingJobSeeker.setResumeHeadline(resumeHeadline);
        existingJobSeeker.setMaritalStatus(maritalStatus);
 
        existingJobSeeker.setPinCode(pinCode);
        existingJobSeeker.setDateOfBirth(dateOfBirth);
        existingJobSeeker.setPermanentAddress(permanentAddress);
        
        // Update profile photo if a new image is provided
        if (image != null && !image.isEmpty()) {
            String profilePictureUrl = fileUploadService.saveImage(image);
            existingJobSeeker.setProfilePicture(profilePictureUrl);
        }

        // Update resume if a new file is provided
        if (resume != null && !resume.isEmpty()) {
            String resumePath = fileUploadService.saveDocument(resume);
            existingJobSeeker.setResumeUploaded(resumePath);
        }

        // Update identity document if a new file is provided
        if (identityDoc != null && !identityDoc.isEmpty()) {
            String contentType = identityDoc.getContentType();
            String identityPath;
            if (contentType != null && contentType.startsWith("image/")) {
                identityPath = fileUploadService.saveImage(identityDoc);
            } else {
                identityPath = fileUploadService.saveDocument(identityDoc);
            }
            existingJobSeeker.setIdentityDocument(identityPath);
        }

        // Update the Job Seeker in the database
        jobSeekerService.updateJobSeeker(id, existingJobSeeker);

        // Redirect to the Job Seeker profile page after updating
        return "redirect:/jobSeekers/profile";
        } catch (Exception e) {
            model.addAttribute("error", "Error updating profile: " + e.getMessage());
            model.addAttribute("jobSeeker", existingJobSeeker);
            model.addAttribute("locations", Location.values());
            model.addAttribute("education", Education.values());
            return "jobSeekers/jobSeekerUpdateForm";
        }
    }

    // Delete Job Seeker
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String deleteJobSeeker(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        try {
            jobSeekerService.deleteJobSeeker(id);
            redirectAttributes.addFlashAttribute("message", "Account deleted successfully.");
            return "redirect:login";  // Redirect to job seeker list after deletion
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "There was an error deleting your account. Please try again.");
            return "redirect:login";  // Redirect to the profile page if deletion fails
        }
    }

    // Show Job Seeker's profile page
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String getJobSeekerProfile( Model model,HttpSession session) {
    	JobSeeker sessionUser = (JobSeeker) session.getAttribute("jobSeeker");
        if (sessionUser == null) {
            return "redirect:login";
        }

        JobSeeker jobSeeker = jobSeekerService.getJobSeekerById(sessionUser.getId());
  
        int completionPercentage = calculateCompletionPercentage(jobSeeker);
        model.addAttribute("jobSeeker", jobSeeker);
        model.addAttribute("completionPercentage", completionPercentage);
        return "jobSeekers/jobSeekerProfile";  // Returns profile view
    }

    // Dashboard for Job Seekers
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String showJobSeekerDashboard(HttpSession session, Model model) {
        JobSeeker loggedInJobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
        
        if (loggedInJobSeeker != null) {
            model.addAttribute("jobSeeker", loggedInJobSeeker);
      //      return "jobSeekers/jobSeekerDashboard"; // Returns dashboard view
      //     return "redirect:/index.html";
       //     return "userdashboard";
            return "redirect:/userdashboard.html";
        }
        
        // Redirect to login if no Job Seeker is logged in
        return "redirect:login";
    }
    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public String signupFromIndex(@RequestParam("email") String email,
                                   @RequestParam("password") String password,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {

        if (jobSeekerService.findByEmail(email) != null) {
            redirectAttributes.addFlashAttribute("signupError", "Email already registered.");
            return "redirect:/home.html?error=email_exists";
        }

        JobSeeker jobSeeker = new JobSeeker();
        jobSeeker.setEmail(email);
        jobSeeker.setPassword(password);
        jobSeeker.setAccountStatus(AccountStatus.ACTIVE);

        jobSeekerService.createJobSeeker(jobSeeker);

        redirectAttributes.addFlashAttribute("signupSuccess", "Account created successfully! Please log in.");
        return "redirect:/jobSeekers/login";
    }


    @RequestMapping(value = "/authenticate", method = RequestMethod.POST)
    public String loginFromIndex(@RequestParam("email") String email,
                                 @RequestParam("password") String password,
                                 HttpSession session,
                                 RedirectAttributes redirectAttributes) {

        JobSeeker jobSeeker = jobSeekerService.findByEmail(email);

        boolean matches = false;
        if (jobSeeker != null) {
            try {
                matches = BCrypt.checkpw(password, jobSeeker.getPassword());
            } catch (Exception e) {}

            if (!matches) {
                if (jobSeeker.getPassword().equals(password)) {
                    // Migration
                    jobSeeker.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
                    jobSeekerService.updateJobSeeker(jobSeeker.getId(), jobSeeker);
                    matches = true;
                }
            }
        }

        if (matches) {
            session.setAttribute("jobSeeker", jobSeeker);
            session.setAttribute("jobSeekerId", jobSeeker.getId());
            return "redirect:dashboard";
        } else {
            redirectAttributes.addFlashAttribute("loginError", "Invalid email or password.");
            return "redirect:dashboard";
        }
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:login";
    }
    
    // Forgot Password functionality
    @RequestMapping(value = "/forgot-password", method = RequestMethod.GET)
    public String showForgotPasswordPage(@RequestParam(required = false) String role, Model model) {
        model.addAttribute("role", role);
        return "password/forgotPassword";
    }
    
    @RequestMapping(value = "/forgot-password", method = RequestMethod.POST)
    public String forgotPassword(@RequestParam String email, @RequestParam(required = false) String role, Model model) {
        String response = passwordResetService.createPasswordResetToken(email);
        model.addAttribute("message", response);
        model.addAttribute("role", role);
        return "password/forgotPassword";
    }
}
