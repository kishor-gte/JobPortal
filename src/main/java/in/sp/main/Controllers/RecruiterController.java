package in.sp.main.Controllers;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import in.sp.main.Entities.AssessmentInvitation;
import in.sp.main.Entities.AssessmentResult;
import in.sp.main.Entities.Company;
import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobApplication;
import in.sp.main.Entities.Payment;
import in.sp.main.Entities.Recruiter;
import in.sp.main.Entities.SportsBooking;
import in.sp.main.Entities.VideoResume;
import in.sp.main.Enums.ApplicationStatus;
import in.sp.main.Enums.Location;
import in.sp.main.Repositories.AssessmentInvitationRepository;
import in.sp.main.Repositories.AssessmentQuestionRepository;
import in.sp.main.Repositories.AssessmentResultRepository;
import in.sp.main.Services.CompanyServices;
import in.sp.main.Services.JobApplicationService;
import in.sp.main.Services.JobServices;
import in.sp.main.Services.NotificationService;
import in.sp.main.Services.RecruiterServices;
import in.sp.main.Services.VideoResumeService;
import in.sp.main.dto.JobApplicationWithResult;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/recruiter")
public class RecruiterController {

    @Autowired
    private RecruiterServices recruiterService;

    @Autowired
    private CompanyServices companyService;
    @Autowired
    private JobServices jobService;
    @Autowired
    private JobApplicationService applicationService;
    @Autowired
    private NotificationService notificationService;
    @Autowired
    private VideoResumeService videoResumeService;

    @Autowired
    private AssessmentResultRepository resultRepo;
    @Autowired
    private AssessmentQuestionRepository questionRepo;
    @Autowired
    private AssessmentInvitationRepository invitationRepo;
    @Autowired
    private in.sp.main.Services.SportsServiceService sportsServiceService;
    @Autowired
    private in.sp.main.Services.SportsBookingService sportsBookingService;

    // Explore Services
    @RequestMapping(value = "/explore", method = RequestMethod.GET)
    public String exploreServices(Model model, HttpSession session) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (recruiter == null) {
            return "redirect:/recruiter/login";
        }
        List<in.sp.main.Entities.SportsService> services = sportsServiceService.findAll();
        model.addAttribute("services", services);
        model.addAttribute("recruiter", recruiter);
        return "recruiter/explore-services";
    }

    // View Service Details
    @RequestMapping(value = "/service/{id}", method = RequestMethod.GET)
    public String viewServiceDetails(@PathVariable Long id, Model model, HttpSession session) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (recruiter == null)
            return "redirect:/recruiter/login";

        in.sp.main.Entities.SportsService service = sportsServiceService.getById(id);
        model.addAttribute("service", service);
        return "recruiter/service-details";
    }

    // List Recruiter Bookings
    @RequestMapping(value = "/bookings", method = RequestMethod.GET)
    public String myBookings(Model model, HttpSession session) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (recruiter == null) {
            return "redirect:/recruiter/login";
        }
        
        List<SportsBooking> bookings = sportsBookingService.getBookingsForRecruiter(recruiter.getId());
        model.addAttribute("bookings", bookings);
        return "recruiter/my-bookings";
    }

    // Confirm Booking after Payment
    @RequestMapping(value = "/booking/confirm", method = RequestMethod.POST)
    public String confirmBooking(
            @RequestParam Long serviceId,
            @RequestParam String razorpayPaymentId,
            @RequestParam String razorpayOrderId,
            @RequestParam String razorpaySignature,
            @RequestParam double amount,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (recruiter == null) {
            return "redirect:/recruiter/login";
        }

        // 1️⃣ Create Booking (DO NOT set status / bookedAt manually)
        SportsBooking booking = new SportsBooking();
        booking.setRecruiter(recruiter);
        booking.setService(sportsServiceService.getById(serviceId));
        booking.setEventDate(LocalDate.now().plusDays(7)); // TODO: take from UI later
        booking.setFinalPrice(amount);
        booking.setExpectedParticipants(0); // optional safety

        // 2️⃣ Create Payment
        Payment payment = new Payment();
        payment.setPaymentMode("ONLINE");
        payment.setTransactionId(razorpayPaymentId);
        payment.setAmount(amount);
        payment.setPaymentStatus("SUCCESS");
        payment.setPaymentTime(LocalDateTime.now());

        // 3️⃣ Attach payment to booking (OWNING SIDE)
        booking.setPayment(payment);

        // 4️⃣ Update booking status AFTER payment
        booking.setStatus("CONFIRMED");

        // 5️⃣ SAVE ONLY BOOKING (cascade saves payment)
        sportsBookingService.createBooking(booking);

        redirectAttributes.addFlashAttribute(
                "message",
                "Booking Confirmed! Booking ID: " + booking.getId()
        );

        return "redirect:/recruiter/dashboard";
    }


    // Show recruiter registration form
    @RequestMapping(value = "/register/{companyId}", method = RequestMethod.GET)
    public String showRegistrationForm(@PathVariable Long companyId, Model model) {
        // List<Company> companies = companyService.getAllCompanies(); // Assuming this
        // method fetches all companies
        Company company = companyService.getCompany(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));
        model.addAttribute("company", company);

        // model.addAttribute("companies", companies);
        return "recruiter/registerRecruiter";
    }

    // Handle recruiter registration
    @RequestMapping(value = "/register1/{companyId}", method = RequestMethod.POST)
    public String registerRecruiter(@ModelAttribute Recruiter recruiter,
            @RequestParam Long companyId,
            RedirectAttributes redirectAttributes) {

        Company company = companyService.getCompany(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));

        // Check if company is approved/accepted
        if (!company.isVerified()) {
            redirectAttributes.addFlashAttribute("error", "Company not yet approved. Cannot register recruiter.");
            return "redirect:/recruiter/register";
        }

        recruiter.setCompany(company);
        recruiterService.createRecruiter(recruiter);

        redirectAttributes.addFlashAttribute("message", "Recruiter registered successfully!");
        return "redirect:/company/recruiters/" + companyId;
    }

    @RequestMapping(value = "/register-success", method = RequestMethod.GET)
    public String showSuccessPage() {
        return "recruiter/success"; // JSP view to be shown
    }

    // Show recruiter login form
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginForm() {
        return "recruiter/loginRecruiter"; // Path to the login JSP
    }

    // Handle recruiter login
    @RequestMapping(value = "/login1", method = RequestMethod.POST)
    public String loginRecruiter(@RequestParam String email,
            @RequestParam String password,
            Model model,
            HttpSession session) {

        Recruiter recruiter = recruiterService.authenticateRecruiter(email, password);

        if (recruiter != null) {
            session.setAttribute("loggedInRecruiter", recruiter); // Store in session
            session.setAttribute("userType", "RECRUITER");
            session.setAttribute("recruiterId", recruiter.getId());
            return "redirect:/recruiter/dashboard";
        } else {
            model.addAttribute("error", "Invalid credentials");
            return "recruiter/loginRecruiter";
        }
    }

    // Recruiter dashboard
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String showDashboard(HttpSession session, Model model) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");

        if (recruiter == null) {
            return "redirect:/recruiter/login"; // Not logged in
        }
        model.addAttribute("companyId", recruiter.getCompany().getId());
        model.addAttribute("recruiter", recruiter); // Pass recruiter info to JSP
        // return "recruiter/recruiterDashboard";
        return "recruiter/recruiter";
    }

    // logout recruiter
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutRecruiter(HttpSession session) {
        session.invalidate(); // Clear session
        return "redirect:/recruiter/login";
    }

    // view the jobs and be able to click on view candidates
    @RequestMapping(value = "/applicants", method = RequestMethod.GET)
    public String viewRecruiterJobs(Model model, HttpSession session) {
        Recruiter loggedInRecruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (loggedInRecruiter == null) {
            return "redirect:/recruiter/login";
        }
        String recruiterEmail = loggedInRecruiter.getEmail();
        Recruiter recruiter = recruiterService.findByEmail(recruiterEmail);
        List<Job> jobs = jobService.findJobsByRecruiter(recruiter.getId());
        model.addAttribute("jobs", jobs);

        return "recruiter/recruiter-jobs";
    }

    // view applicants for the jobs with minimal info
    @RequestMapping(value = "/applicants/{jobId}", method = RequestMethod.GET)
    public String viewApplicantsForJob(@PathVariable Long jobId,
            @RequestParam(required = false) ApplicationStatus status,
            @RequestParam(required = false) Location location,
            @RequestParam(required = false) Integer experience,
            @RequestParam(required = false) String skills,
            @RequestParam(required = false) String badge,
            @RequestParam(required = false) Integer minScore,
            @RequestParam(required = false) Integer maxScore,
            @RequestParam(required = false, name = "matchAllSkills") String matchAllSkills,
            Model model) {

        List<JobApplication> applications = applicationService.findByJobIdAndFilters(
                jobId, status, location, experience, skills, matchAllSkills);

        Long recruiterId = jobService.getJobById(jobId).getCreatedBy().getId();

        List<JobApplicationWithResult> wrapperList = new ArrayList<>();

        for (JobApplication app : applications) {
            AssessmentResult result = resultRepo.findTopByJobSeekerIdAndJobIdAndRecruiterIdOrderBySubmittedAtDesc(
                    app.getJobSeeker().getId(), jobId, recruiterId);

            // If score or badge filter applied but no result, skip
            if ((badge != null || minScore != null || maxScore != null) && result == null) {
                continue;
            }

            boolean passes = true;

            if (result != null) {
                int score = result.getCorrectAnswers(); // ✅ Raw score
                int total = result.getTotalQuestions();

                // Badge filtering still uses percentage
                if (badge != null && !badge.isEmpty()) {
                    int percentage = (int) ((score * 100.0) / total);
                    String badgeLabel;
                    if (percentage < 60)
                        badgeLabel = "Fail";
                    else if (percentage < 70)
                        badgeLabel = "Bronze";
                    else if (percentage < 85)
                        badgeLabel = "Silver";
                    else
                        badgeLabel = "Gold";

                    if (!badge.equalsIgnoreCase(badgeLabel)) {
                        passes = false;
                    }
                }

                // ✅ Raw score filtering
                if (minScore != null && score < minScore)
                    passes = false;
                if (maxScore != null && score > maxScore)
                    passes = false;
            }

            if (passes) {
                wrapperList.add(new JobApplicationWithResult(app, result));
            }
        }

        model.addAttribute("applications", wrapperList);
        model.addAttribute("jobId", jobId);
        model.addAttribute("company", jobService.getJobById(jobId).getCompany());
        model.addAttribute("location", Location.values());

        return "recruiter/applicants-list";
    }

    @RequestMapping(value = "/applicant/{applicationId}/profile", method = RequestMethod.GET)
    public String viewFullProfile(@PathVariable Long applicationId, Model model) {
        JobApplication application = applicationService.findById(applicationId);
        VideoResume video = videoResumeService.findByJobSeeker(application.getJobSeeker());

        if (!application.getStatus().equals(ApplicationStatus.VIEWED_BY_RECRUITER)) {
            application.setStatus(ApplicationStatus.VIEWED_BY_RECRUITER);
            applicationService.save(application);
            notificationService.sendStatusUpdate(application.getJobSeeker().getId(),
                    "Your profile was viewed by recruiter.");
        }
        model.addAttribute("videoResume", video);
        model.addAttribute("application", application);
        return "recruiter/applicant-profile";
    }

    @RequestMapping(value = "/applicant/{id}/status", method = RequestMethod.POST)
    public String updateApplicantStatus(@PathVariable Long id,
            @RequestParam("status") ApplicationStatus status,
            @RequestParam(value = "interviewDate", required = false) @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime interviewDate,
            HttpSession session) {

        JobApplication application = applicationService.findById(id);
        application.setStatus(status);
        application.setLastUpdated(LocalDateTime.now());

        // INTERVIEW SCHEDULING
        if (status == ApplicationStatus.INTERVIEW_SCHEDULED && interviewDate != null) {
            application.setInterviewDate(interviewDate);
        } else {
            application.setInterviewDate(null);
        }

        // SCHEDULE ASSESSMENT → CREATE ASSESSMENT INVITE
        if (status == ApplicationStatus.SCHEDULE_ASSESSMENT) {
            Long recruiterId = (Long) session.getAttribute("recruiterId");
            Long jobSeekerId = application.getJobSeeker().getId();
            Long jobId = application.getJob().getId();
            // String skill = application.getJob().getSkill(); // Assuming your Job entity
            // has a skill field

            List<String> skills = questionRepo.findDistinctSkillsByJobIdAndRecruiterId(jobId, recruiterId);
            String skill = skills.isEmpty() ? "Java" : skills.get(0); // fallback

            AssessmentInvitation invite = new AssessmentInvitation();
            invite.setJobSeekerId(jobSeekerId);
            invite.setSkill(skill);
            invite.setRecruiterId(recruiterId);
            invite.setJobId(jobId);
            invite.setType("JOB");
            invite.setStatus("SENT");
            invite.setSentAt(LocalDateTime.now());

            invitationRepo.save(invite);
            // Optional: add notification logic here to alert the jobseeker
        }

        applicationService.save(application);
        sendStatusChangeNotification(application); // Already existing
        return "redirect:/recruiter/applicants/" + application.getJob().getId();
    }

    private void sendStatusChangeNotification(JobApplication jobApplication) {
        String message = "";
        String company = jobApplication.getJob().getCompany().getName();
        String role = jobApplication.getJob().getTitle();

        switch (jobApplication.getStatus()) {
            case INTERVIEW_SCHEDULED:
                LocalDateTime dt = jobApplication.getInterviewDate();
                String formatted = dt.format(DateTimeFormatter.ofPattern("dd MMM yyyy 'at' hh:mm a"));
                message = "Your job application has moved forward for the company " + company +
                        " for the role of " + role + ".\nYour interview is scheduled on " + formatted + ".";
                break;
            case REJECTED:
                message = "Unfortunately, your application for the role of " + role +
                        " at " + company + " has been rejected.";
                break;
            case SHORTLISTED:
                message = "You have been shortlisted for the role of " + role + " at " + company + ".";
                break;
            case SELECTED:
                message = "Congratulations! You have been selected for the role of " + role + " at " + company + ".";
                break;
            case VIEWED_BY_RECRUITER:
                message = "Your application for " + role + " at " + company + " was viewed by the recruiter.";
                break;
        }

        notificationService.createNotification(jobApplication.getJobSeeker(), message);
    }

    // View Recruiter Profile
    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String viewRecruiterProfile(HttpSession session, Model model) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (recruiter == null) {
            return "redirect:/recruiter/login";
        }
        model.addAttribute("recruiter", recruiter);
        return "recruiter/profile";
    }

    // Show Edit Profile Form
    @RequestMapping(value = "/profile/edit", method = RequestMethod.GET)
    public String editRecruiterProfile(HttpSession session, Model model) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (recruiter == null) {
            return "redirect:/recruiter/login";
        }
        model.addAttribute("recruiter", recruiter);
        return "recruiter/edit-profile";
    }

    // Handle Profile Update
    @RequestMapping(value = "/profile/update", method = RequestMethod.POST)
    public String updateRecruiterProfile(@ModelAttribute Recruiter updatedRecruiter,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        Recruiter existing = (Recruiter) session.getAttribute("loggedInRecruiter");

        if (existing == null) {
            return "redirect:/recruiter/login";
        }

        existing.setName(updatedRecruiter.getName());
        existing.setEmail(updatedRecruiter.getEmail());
        // Only update password if provided and encode it
        if (updatedRecruiter.getPassword() != null && !updatedRecruiter.getPassword().trim().isEmpty()) {
            existing.setPassword(BCrypt.hashpw(updatedRecruiter.getPassword(), BCrypt.gensalt()));
        }

        recruiterService.updateRecruiter(existing); // Save changes
        redirectAttributes.addFlashAttribute("message", "Profile updated successfully!");

        return "redirect:/recruiter/profile";
    }

    // Delete Recruiter Account
    @RequestMapping(value = "/profile/delete", method = RequestMethod.POST)
    public String deleteRecruiterAccount(HttpSession session) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");

        if (recruiter != null) {
            recruiterService.deleteRecruiter(recruiter.getId());
            session.invalidate();
        }
        return "redirect:/recruiter/register";
    }

    // List all recruiters for a given company
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listRecruiters(Model model, HttpSession session) {
        // Get all recruiters for a specific company (or all recruiters if no company is
        // specified)
        Company company = (Company) session.getAttribute("loggedInCompany");
        if (company != null) {
            List<Recruiter> recruiters = recruiterService.getRecruitersByCompany(company.getId()); // Or filter by
                                                                                                   // company ID if
                                                                                                   // needed
            model.addAttribute("recruiters", recruiters);
            model.addAttribute("company", company);
        } else {
            return "redirect:/company/login";
        }
        return "recruiter/recruiterList"; // Return the recruiterList.jsp page
    }

    /*
     * // Delete recruiter by ID
     * 
     * @RequestMapping("/delete/{id}") public String deleteRecruiter(@PathVariable
     * Long
     * id, RedirectAttributes redirectAttributes) {
     * recruiterService.deleteRecruiter(id);
     * redirectAttributes.addFlashAttribute("message",
     * "Recruiter deleted successfully."); return "redirect:/recruiter/list"; }
     */

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String deleteRecruiter(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Recruiter recruiter = recruiterService.findRecruiterById(id);

        if (recruiter == null) {
            redirectAttributes.addFlashAttribute("error", "Recruiter not found.");
            return "redirect:/recruiter/list";
        }

        if (recruiter.getJobs() != null && !recruiter.getJobs().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Cannot delete recruiter. They have associated jobs.");
            return "redirect:/recruiter/list";
        }

        recruiterService.deleteRecruiter(id);
        redirectAttributes.addFlashAttribute("message", "Recruiter deleted successfully.");
        return "redirect:/recruiter/list";
    }

    // Show Edit Form
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String showEditForm(@PathVariable Long id, Model model) {
        // Fetch the recruiter from the database by ID
        Recruiter recruiter = recruiterService.findRecruiterById(id);

        // If recruiter not found, redirect to list page
        if (recruiter == null) {
            return "redirect:/recruiter/list"; // Or any other page you prefer
        }

        // Add recruiter details to the model for form pre-fill
        model.addAttribute("recruiter", recruiter);
        return "recruiter/editRecruiter"; // Path to the JSP where the form is
    }

    // Handle Update Request
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    public String updateRecruiter(@PathVariable Long id,
            @RequestParam String name,
            @RequestParam String email,
            RedirectAttributes redirectAttributes) {

        // Fetch the recruiter by ID
        Recruiter recruiter = recruiterService.findRecruiterById(id);
        if (recruiter == null) {
            redirectAttributes.addFlashAttribute("error", "Recruiter not found.");
            return "redirect:/recruiter/list";
        }

        // Update recruiter details
        recruiter.setName(name);
        recruiter.setEmail(email);
        recruiterService.updateRecruiter(recruiter);

        // Add success message
        redirectAttributes.addFlashAttribute("message", "Recruiter updated successfully!");
        return "redirect:/recruiter/list"; // Redirect to recruiter list
    }
}
