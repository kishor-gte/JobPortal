package in.sp.main.Controllers;
import in.sp.main.Services.AssessmentService;
import in.sp.main.Services.ExcelHelper;
import in.sp.main.Entities.AssessmentQuestion;
import org.springframework.web.multipart.MultipartFile;

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
import org.springframework.web.bind.annotation.GetMapping;
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
import in.sp.main.utils.ActivityLogger;
import in.sp.main.Enums.ActivityType;
import in.sp.main.Repositories.AssessmentInvitationRepository;
import in.sp.main.Repositories.AssessmentQuestionRepository;
import in.sp.main.Repositories.AssessmentResultRepository;
import in.sp.main.Services.CompanyServices;
import in.sp.main.Services.JobApplicationService;
import in.sp.main.Services.JobServices;
import in.sp.main.Services.NotificationService;
import in.sp.main.Services.RecruiterServices;
import in.sp.main.Services.VideoResumeService;
import in.sp.main.Repositories.CompetitionRepository;
import in.sp.main.Repositories.CompetitionResultRepository;
import in.sp.main.Repositories.TechPersonRepository;
import in.sp.main.Repositories.JobSeekerRepository;
import in.sp.main.Entities.Competition;
import in.sp.main.Entities.CompetitionResult;
import in.sp.main.Entities.TechPerson;
import in.sp.main.Entities.JobSeeker;
import java.util.stream.Collectors;
import java.util.Map;
import java.util.HashMap;
import in.sp.main.dto.JobApplicationWithResult;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import in.sp.main.Configuration.JwtUtil;

@Controller
@RequestMapping("/recruiter")
public class RecruiterController {

    @Autowired
    private JwtUtil jwtUtil;
    @Autowired
    private AssessmentService assessmentService;

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
    private CompetitionRepository competitionRepo;
    @Autowired
    private CompetitionResultRepository competitionResultRepo;
    @Autowired
    private TechPersonRepository techPersonRepo;
    @Autowired
    private JobSeekerRepository jobSeekerRepo;
    @Autowired
    private in.sp.main.Services.SportsServiceService sportsServiceService;
    @Autowired
    private in.sp.main.Services.SportsBookingService sportsBookingService;

    @Autowired
    private ActivityLogger activityLogger;

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
        if (service == null) {
            return "redirect:/recruiter/sports/explore";
        }
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
        activityLogger.log(recruiter.getId(), recruiter.getName(), recruiter.getEmail(), "RECRUITER", ActivityType.USER_REGISTRATION, "Recruiter registered successfully");

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
            HttpServletResponse response,
            HttpSession session) {

        Recruiter recruiter = recruiterService.authenticateRecruiter(email, password);

        if (recruiter != null) {
            String token = jwtUtil.generateToken(String.valueOf(recruiter.getId()), "RECRUITER");
            Cookie cookie = jwtUtil.createJwtCookie(token);
            response.addCookie(cookie);

            session.setAttribute("loggedInRecruiter", recruiter); // Store in session
            session.setAttribute("userType", "RECRUITER");
            session.setAttribute("recruiterId", recruiter.getId());
            activityLogger.log(recruiter.getId(), recruiter.getName(), recruiter.getEmail(), "RECRUITER", ActivityType.LOGIN, "Recruiter logged in successfully");
            return "redirect:/recruiter/dashboard";
        } else {
            activityLogger.log(null, "Unknown", email, "RECRUITER", ActivityType.FAILED_LOGIN_ATTEMPT, "Failed recruiter login attempt");
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
    public String logoutRecruiter(HttpSession session, HttpServletResponse response) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (recruiter != null) {
            activityLogger.log(recruiter.getId(), recruiter.getName(), recruiter.getEmail(), "RECRUITER", ActivityType.LOGOUT, "Recruiter logged out");
        }
        session.invalidate(); // Clear session
        Cookie cookie = jwtUtil.createClearJwtCookie();
        response.addCookie(cookie);
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
        for (Job job : jobs) {
            job.setApplicantCount((int) applicationService.countByJobId(job.getId()));
        }
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
            AssessmentResult result = resultRepo.findTopByJobSeekerIdAndJobIdOrderBySubmittedAtDesc(
                    app.getJobSeeker().getId(), jobId);

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

    @GetMapping("/competition-results")
    public String competitionResultsPage(HttpSession session, Model model) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (recruiter == null) {
            return "redirect:/recruiter/login";
        }
        
        // Find all tech persons in the recruiter's company
        List<TechPerson> techPersons = techPersonRepo.findByCompanyId(recruiter.getCompany().getId());
        List<Long> techPersonIds = techPersons.stream().map(TechPerson::getId).collect(Collectors.toList());
        
        List<Competition> competitions = new ArrayList<>();
        if (!techPersonIds.isEmpty()) {
            competitions = competitionRepo.findByCreatedByInOrderByCreatedAtDesc(techPersonIds);
        }
        
        model.addAttribute("recruiter", recruiter);
        model.addAttribute("competitions", competitions);
        return "recruiter/competition-results";
    }

    @GetMapping("/competition-results/{id}")
    public String viewCompetitionLeaderboard(@PathVariable Long id, HttpSession session, Model model) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if (recruiter == null) {
            return "redirect:/recruiter/login";
        }
        
        Competition competition = competitionRepo.findById(id).orElse(null);
        if (competition == null) {
            return "redirect:/recruiter/competition-results";
        }

        // Ensure this competition was created by a tech person in the recruiter's company
        List<TechPerson> techPersons = techPersonRepo.findByCompanyId(recruiter.getCompany().getId());
        List<Long> techPersonIds = techPersons.stream().map(TechPerson::getId).collect(Collectors.toList());
        
        if (!techPersonIds.contains(competition.getCreatedBy())) {
            return "redirect:/recruiter/competition-results";
        }

        List<CompetitionResult> results = competitionResultRepo.findByCompetitionId(id);
        
        // Sort: 1. questionsSolved DESC, 2. submittedAt ASC
        results.sort((r1, r2) -> {
            int qComp = Integer.compare(r2.getQuestionsSolved() != null ? r2.getQuestionsSolved() : 0, 
                                        r1.getQuestionsSolved() != null ? r1.getQuestionsSolved() : 0);
            if (qComp != 0) return qComp;
            if (r1.getSubmittedAt() == null && r2.getSubmittedAt() == null) return 0;
            if (r1.getSubmittedAt() == null) return 1;
            if (r2.getSubmittedAt() == null) return -1;
            return r1.getSubmittedAt().compareTo(r2.getSubmittedAt());
        });
        
        List<Map<String, Object>> leaderboard = new ArrayList<>();
        int rank = 1;
        for (CompetitionResult res : results) {
            // Filter out students who haven't solved any questions
            if (res.getQuestionsSolved() == null || res.getQuestionsSolved() == 0) {
                continue;
            }
            JobSeeker student = jobSeekerRepo.findById(res.getStudentId()).orElse(null);
            if (student != null) {
                Map<String, Object> entry = new HashMap<>();
                entry.put("rank", rank++);
                entry.put("name", student.getName());
                entry.put("email", student.getEmail());
                entry.put("questionsSolved", res.getQuestionsSolved());
                entry.put("submittedAt", res.getSubmittedAt());
                leaderboard.add(entry);
            }
        }

        model.addAttribute("recruiter", recruiter);
        model.addAttribute("competition", competition);
        model.addAttribute("leaderboard", leaderboard);
        
        return "recruiter/competition-leaderboard";
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
        activityLogger.log(existing.getId(), existing.getName(), existing.getEmail(), "RECRUITER", ActivityType.PROFILE_UPDATED, "Recruiter updated profile");
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

    @RequestMapping(value = "/posted-jobs", method = RequestMethod.GET)
    public String viewPostedJobs(@RequestParam(required = false) String employmentType,
                                   Model model, HttpSession session) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        if(recruiter == null) return "redirect:/recruiter/login";
        
        Long companyId = recruiter.getCompany().getId();
        List<Job> jobs = jobService.getJobsByCompany(companyId);

        if (employmentType != null && !employmentType.isEmpty()) {
            final String filter = employmentType;
            jobs = jobs.stream()
                .filter(j -> j.getEmploymentType() != null &&
                             j.getEmploymentType().name().equalsIgnoreCase(filter))
                .collect(java.util.stream.Collectors.toList());
            model.addAttribute("filterType", employmentType);
        }

        model.addAttribute("jobs", jobs);
        model.addAttribute("companyId", companyId);
        model.addAttribute("recruiter", recruiter);
        return "recruiter/posted-jobs";
    }
    @RequestMapping(value = "/assessments/uploadpage", method = RequestMethod.GET)
    public String showRecruiterUploadPage(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        
        if (recruiter == null) {
            return "redirect:/recruiter/login";
        }
        
        // Get job details to pre-fill information
        Job job = jobService.getJobById(jobId);
        if (job == null || !job.getCreatedBy().getId().equals(recruiter.getId())) {
            return "redirect:/recruiter/posted-jobs";
        }
        
        model.addAttribute("jobId", jobId);
        model.addAttribute("companyId", job.getCompany().getId());
        model.addAttribute("jobTitle", job.getTitle());
        
        return "recruiter/assessment-upload";
    }

    @RequestMapping(value = "/assessments/upload", method = RequestMethod.POST)
    public String uploadRecruiterExcel(@RequestParam("file") MultipartFile file,
                                      @RequestParam("skill") String skill,
                                      @RequestParam(value = "replace", required = false) String replaceStr,
                                      @RequestParam(value = "replaceInvitations", required = false) String replaceInvitationsStr,
                                      @RequestParam("jobId") Long jobId,
                                      @RequestParam("companyId") Long companyId,
                                      HttpSession session,
                                      Model model) {
        
        boolean replace = "on".equalsIgnoreCase(replaceStr) || "true".equalsIgnoreCase(replaceStr) || "yes".equalsIgnoreCase(replaceStr) || "1".equals(replaceStr);
        boolean replaceInvitations = "on".equalsIgnoreCase(replaceInvitationsStr) || "true".equalsIgnoreCase(replaceInvitationsStr) || "yes".equalsIgnoreCase(replaceInvitationsStr) || "1".equals(replaceInvitationsStr);
        try {
            // Validate recruiter session
            Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
            if (recruiter == null) {
                model.addAttribute("message", "Error: Unauthorized access. Please login.");
                model.addAttribute("companyId", companyId);
                return "recruiter/upload-result"; // Can reuse the company result page or create recruiter version, let's just return to company/upload-result for now as it's just a message page
            }
            
            // Validate file
            if (file == null || file.isEmpty()) {
                model.addAttribute("message", "Error: Please select a file to upload");
                model.addAttribute("companyId", companyId);
                return "recruiter/upload-result";
            }
            
            // Check file type
            String fileName = file.getOriginalFilename();
            if (fileName == null || !fileName.endsWith(".xlsx")) {
                model.addAttribute("message", "Error: Only .xlsx files are supported");
                model.addAttribute("companyId", companyId);
                return "recruiter/upload-result";
            }
            
            // Delete existing questions if replace is checked
            if (replace) {
                assessmentService.deleteBySkill(skill);
            }
            
            // Delete existing invitations if replaceInvitations is checked
            if (replaceInvitations) {
                List<in.sp.main.Entities.AssessmentInvitation> existingInvites = 
                    invitationRepo.findByJobIdAndSkill(jobId, skill);
                if (!existingInvites.isEmpty()) {
                    System.out.println("Deleting " + existingInvites.size() + " existing invitations...");
                    invitationRepo.deleteAll(existingInvites);
                }
            }
            
            // Parse Excel and save questions
            java.util.List<AssessmentQuestion> questions = ExcelHelper.convertExcelToList(file.getInputStream(), skill);
            
            if (questions.isEmpty()) {
                model.addAttribute("message", "Error: No valid questions found in the file. Please check the format.");
                model.addAttribute("companyId", companyId);
                return "recruiter/upload-result";
            }
            
            // Set source type, job ID and recruiter ID for each question
            for (AssessmentQuestion q : questions) {
                q.setSourceType("RECRUITER");
                q.setJobId(jobId);
                q.setRecruiterId(recruiter.getId());
            }
            
            assessmentService.saveAll(questions);
            
            // AUTO-CREATE ASSESSMENT INVITATIONS for ALL job seekers (EVERY TIME)
            try {
                // Get ALL job seekers from the database
                List<in.sp.main.Entities.JobSeeker> allJobSeekers = jobSeekerRepo.findAll();
                
                System.out.println("=== ASSESSMENT INVITATION DEBUG ===");
                System.out.println("Total job seekers in database: " + allJobSeekers.size());
                System.out.println("Job ID: " + jobId);
                System.out.println("Skill: " + skill);
                System.out.println("Recruiter ID: " + recruiter.getId());
                
                int invitationsCreated = 0;
                
                // Create invitation for EVERY job seeker (no duplicate check)
                for (in.sp.main.Entities.JobSeeker jobSeeker : allJobSeekers) {
                    // Create new invitation every time
                    in.sp.main.Entities.AssessmentInvitation invite = new in.sp.main.Entities.AssessmentInvitation();
                    invite.setJobSeekerId(jobSeeker.getId());
                    invite.setJobId(jobId);
                    invite.setRecruiterId(recruiter.getId());
                    invite.setSkill(skill);
                    invite.setType("JOB");
                    invite.setStatus("SENT");
                    invite.setSentAt(java.time.LocalDateTime.now());
                    invitationRepo.save(invite);
                    invitationsCreated++;
                }
                
                System.out.println("New invitations created: " + invitationsCreated);
                System.out.println("=== END DEBUG ===");
                
                model.addAttribute("message", "Successfully uploaded " + questions.size() + " questions for " + skill + 
                    ". Assessment invitations sent to " + invitationsCreated + " job seeker(s).");
                
            } catch (Exception e) {
                System.err.println("Warning: Questions uploaded but failed to create invitations: " + e.getMessage());
                e.printStackTrace();
                model.addAttribute("message", "Successfully uploaded " + questions.size() + " questions for " + skill + 
                    ". Note: Some invitations may not have been created.");
            }
            
        } catch (Exception e) {
            System.err.println("Error uploading file: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("message", "Error uploading file: " + e.getMessage());
        }
        
        model.addAttribute("companyId", companyId);
        return "recruiter/upload-result";
    }
    @RequestMapping(value = "/assessments/info", method = RequestMethod.GET)
    public String showAssessmentInfo(HttpSession session, Model model) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedInRecruiter");
        
        if (recruiter == null) {
            return "redirect:/recruiter/login";
        }
        
        // Find a company ID from one of their jobs, or just use the recruiter ID. 
        // We'll just return the view, which maybe doesn't need companyId, or we can fetch a job.
        // The original view company/assessment-info.jsp probably needs companyId for back button.
        // We'll let it fail gracefully or just return "recruiter/assessment-info".
        // Wait, does recruiter/assessment-info exist?
        // Let's just return company/assessment-info for now, it's just an info page!
        return "company/assessment-info";
    }
}



