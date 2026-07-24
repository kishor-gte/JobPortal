package in.sp.main.Controllers;


import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import in.sp.main.Entities.Admin;
import in.sp.main.Entities.Company;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.ReportedJob;
import in.sp.main.Entities.Review;
import in.sp.main.Entities.SportsOrganizer;
import in.sp.main.Entities.StudentAnswer;
import in.sp.main.Entities.CodingQuestion;
import in.sp.main.Entities.InterviewQuestion;
import in.sp.main.Repositories.OrganizerDocumentRepository;
import in.sp.main.Repositories.OrganizerEventPhotoRepository;
import in.sp.main.Repositories.ReportedJobRepository;
import in.sp.main.Repositories.ReviewRepository;
import in.sp.main.Repositories.SportsOrganizerRepository;
import in.sp.main.Entities.Recruiter;
import in.sp.main.Entities.TechPerson;
import in.sp.main.Repositories.RecruiterRepository;
import in.sp.main.Repositories.TechPersonRepository;
import in.sp.main.Repositories.JobApplicationRepository;
import in.sp.main.Services.AdminService;
import in.sp.main.Services.CompanyServices;
import in.sp.main.Services.JobSeekerService;
import in.sp.main.Services.JobServices;
import in.sp.main.dao.QuestionDAO;
import in.sp.main.dao.InterviewDAO;
import in.sp.main.dao.PerformanceDAO;
import in.sp.main.dao.CategoryDAO;
import in.sp.main.dao.AIEvaluationDAO;
import in.sp.main.Services.SportsBookingService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;
import in.sp.main.Configuration.JwtUtil;
import in.sp.main.utils.ActivityLogger;
import in.sp.main.Enums.ActivityType;

@Controller
public class AdminController {

    @Autowired
    private JwtUtil jwtUtil;

	
    @Autowired
    private CompanyServices companyService;
    @Autowired
    private JobServices jobService;
    @Autowired
    private AdminService adminService;
    @Autowired
    private ReportedJobRepository reportedJobRepository;
    @Autowired
    private RecruiterRepository recruiterRepository;
    @Autowired
    private TechPersonRepository techPersonRepository;
    @Autowired
    private JobSeekerService jobSeekerService;
    
    @Autowired
    private in.sp.main.Services.TechPersonServices techPersonServices;

    @Autowired
    private in.sp.main.Services.RecruiterServices recruiterServices;

    @Autowired
    private ReviewRepository reviewService;
    
    @Autowired
    private SportsOrganizerRepository organizerRepo;

    @Autowired
    private OrganizerDocumentRepository documentRepo;

    @Autowired
    private OrganizerEventPhotoRepository photoRepo;

    @Autowired
    private SportsBookingService sportsBookingService;

    @Autowired
    private QuestionDAO questionDAO;

    @Autowired
    private InterviewDAO interviewDAO;

    @Autowired
    private PerformanceDAO performanceDAO;

    @Autowired
    private CategoryDAO categoryDAO;

    @Autowired
    private ActivityLogger activityLogger;
   
    @Autowired
    private JobApplicationRepository jobApplicationRepository;

    @Autowired
    private AIEvaluationDAO aiEvaluationDAO;
	/*
	 * @Autowired private JobSeekerService userService;
	 */
	/*
	 * @Autowired private AdminService adminService;
	 */
	
	 // Admin view of unverified companies
    @RequestMapping(value = "/admin/pending", method = RequestMethod.GET)
  public String pendingCompanies(Model model, HttpSession session) {
        // Check if admin is logged in
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        
        try {
            List<Company> unverifiedCompanies = companyService.getUnverifiedCompanies();
            System.out.println("DEBUG: Found " + unverifiedCompanies.size() + " unverified companies");
            for (Company company : unverifiedCompanies) {
                System.out.println("DEBUG: Company - ID: " + company.getId() + ", Name: " + company.getName() + ", Verified: " + company.isVerified());
            }
            model.addAttribute("companies", unverifiedCompanies);      
        } catch (Exception e) {
            System.err.println("ERROR: Failed to retrieve unverified companies: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("companies", new ArrayList<>());
        }
        return "admin/pendingCompanies";
    }

    // Admin verification
    @RequestMapping(value = "/admin/verify/{id}", method = RequestMethod.POST)
    public String verifyCompany(@PathVariable Long id, HttpSession session, RedirectAttributes redirectAttributes) {
        // Check if admin is logged in
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        
        try {
            companyService.verifyCompany(id);
            redirectAttributes.addFlashAttribute("success", "Company approved successfully.");
            return "redirect:/admin/pending";
        } catch (Throwable t) {
            t.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Unable to approve company.");
            return "redirect:/admin/pending";
        }
    }

    @RequestMapping(value = "/admin/profile", method = RequestMethod.GET)
    public String adminProfile(Model model, HttpSession session) {
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        model.addAttribute("admin", admin);
        return "admin/adminProfile";
    }

    @RequestMapping(value = "/admin/edit/{id}", method = RequestMethod.GET)
    public String editAdminProfile(@PathVariable Long id, Model model, HttpSession session) {
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null || !admin.getId().equals(id)) {
            return "redirect:/loginAdmin";
        }
        model.addAttribute("admin", admin);
        return "admin/editAdminProfile";
    }

    @RequestMapping(value = "/admin/updateProfile", method = RequestMethod.POST)
    public String updateAdminProfile(@RequestParam("id") Long id, 
                                     @RequestParam("name") String name, 
                                     @RequestParam(value = "password", required = false) String password,
                                     HttpSession session) {
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null || !admin.getId().equals(id)) {
            return "redirect:/loginAdmin";
        }
        
        admin.setName(name);
        if (password != null && !password.trim().isEmpty()) {
            String actualPassword = password;
            if (actualPassword.contains(",")) {
                actualPassword = actualPassword.split(",")[0];
            }
            admin.setPassword(org.mindrot.jbcrypt.BCrypt.hashpw(actualPassword.trim(), org.mindrot.jbcrypt.BCrypt.gensalt()));
        }
        
        try {
            if (adminService != null) {
                adminService.updateAdmin(id.intValue(), admin);
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        session.setAttribute("loggedInAdmin", admin);
        return "redirect:/admin/profile";
    }

    @RequestMapping(value = {"/dashboard", "/admin/dashboard"}, method = RequestMethod.GET)
    public String dashboard(Model model, HttpSession session) {
        try {
            // Check if admin is logged in
            in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
            if (admin == null) {
                return "redirect:/loginAdmin";
            }
            
            // Add statistics for dashboard with null checks
            long totalUsers = 0;
            long totalCompanies = 0;
            long pendingCompanies = 0;
            long pendingReports = 0;
            
            try {
                if (jobSeekerService != null && jobSeekerService.getAllJobSeekers() != null) {
                    totalUsers = jobSeekerService.getAllJobSeekers().size();
                }
            } catch (Exception e) {
                System.err.println("Error fetching total users: " + e.getMessage());
            }
            
            try {
                if (companyService != null && companyService.getAllCompanies() != null) {
                    totalCompanies = companyService.getAllCompanies().size();
                }
            } catch (Exception e) {
                System.err.println("Error fetching total companies: " + e.getMessage());
            }
            
            try {
                if (companyService != null && companyService.getUnverifiedCompanies() != null) {
                    pendingCompanies = companyService.getUnverifiedCompanies().size();
                }
            } catch (Exception e) {
                System.err.println("Error fetching pending companies: " + e.getMessage());
            }
            
            try {
                if (reportedJobRepository != null && reportedJobRepository.findAllByIsResolvedFalse() != null) {
                    pendingReports = reportedJobRepository.findAllByIsResolvedFalse().size();
                }
            } catch (Exception e) {
                System.err.println("Error fetching pending reports: " + e.getMessage());
            }
            
            // Additional statistics
            long totalJobs = 0;
            long activeJobsCount = 0;
            long resolvedReports = 0;
            java.util.List<in.sp.main.Entities.Job> activeJobsList = new java.util.ArrayList<>();
            
            try {
                if (jobService != null && jobService.getAllJobs() != null) {
                    totalJobs = jobService.getAllJobs().size();
                }
            } catch (Exception e) {
                System.err.println("Error fetching total jobs: " + e.getMessage());
            }
            
            try {
                if (jobService != null && jobService.getAllActiveJobs() != null) {
                    activeJobsList = jobService.getAllActiveJobs();
                    activeJobsCount = activeJobsList.size();
                    for (in.sp.main.Entities.Job activeJob : activeJobsList) {
                        try {
                            activeJob.setApplicantCount((int) jobApplicationRepository.findByJob_Id(activeJob.getId()).size());
                        } catch (Exception e) {
                            activeJob.setApplicantCount(0);
                        }
                    }
                }
            } catch (Exception e) {
                System.err.println("Error fetching active jobs: " + e.getMessage());
            }
            
            try {
                if (reportedJobRepository != null) {
                    resolvedReports = reportedJobRepository.findAllByIsResolvedTrue().size();
                }
            } catch (Exception e) {
                System.err.println("Error fetching resolved reports: " + e.getMessage());
            }

            // Fetch actual counts from DAOs for Platform Statistics
            long totalCodingQuestions = 0;
            long totalInterviewQuestions = 0;
            long totalInterviews = 0;
            long completedInterviews = 0;
            long totalApplications = 0;
            
            try {
                if (questionDAO != null) {
                    List<in.sp.main.Entities.CodingQuestion> codingQs = questionDAO.findAllCodingQuestions();
                    totalCodingQuestions = codingQs != null ? codingQs.size() : 0;
                    
                    List<in.sp.main.Entities.InterviewQuestion> interviewQs = questionDAO.findAllInterviewQuestions();
                    totalInterviewQuestions = interviewQs != null ? interviewQs.size() : 0;
                }
            } catch (Exception e) {
                System.err.println("Error fetching questions: " + e.getMessage());
            }
            
            try {
                if (interviewDAO != null) {
                    List<in.sp.main.Entities.MockInterview> allInterviews = interviewDAO.findAll();
                    totalInterviews = allInterviews != null ? allInterviews.size() : 0;
                    
                    if (allInterviews != null) {
                        completedInterviews = allInterviews.stream()
                            .filter(i -> "COMPLETED".equalsIgnoreCase(i.getStatus()))
                            .count();
                    }
                }
            } catch (Exception e) {
                System.err.println("Error fetching interviews: " + e.getMessage());
            }

            try {
                if (jobApplicationRepository != null) {
                    totalApplications = jobApplicationRepository.count();
                }
            } catch (Exception e) {
                System.err.println("Error fetching job applications: " + e.getMessage());
            }
            
            List<in.sp.main.Entities.PerformanceScore> performancesList = new java.util.ArrayList<>();
            try {
                if (performanceDAO != null) {
                    performancesList = performanceDAO.findAllPerformances();
                }
            } catch (Exception e) {
                System.err.println("Error fetching performances: " + e.getMessage());
            }

            List<JobSeeker> recentUsers = new java.util.ArrayList<>();
            try {
                if (jobSeekerService != null && jobSeekerService.getAllJobSeekers() != null) {
                    recentUsers = jobSeekerService.getAllJobSeekers();
                    recentUsers.sort((u1, u2) -> Long.compare(u2.getId(), u1.getId()));
                    if (recentUsers.size() > 8) {
                        recentUsers = recentUsers.subList(0, 8);
                    }
                }
            } catch (Exception e) {
                System.err.println("Error fetching recent users: " + e.getMessage());
            }

            List<in.sp.main.Entities.JobApplication> recentApplications = new java.util.ArrayList<>();
            try {
                if (jobApplicationRepository != null) {
                    recentApplications = jobApplicationRepository.findAll();
                    recentApplications.sort((a1, a2) -> Long.compare(a2.getId(), a1.getId()));
                    if (recentApplications.size() > 8) {
                        recentApplications = recentApplications.subList(0, 8);
                    }
                }
            } catch (Exception e) {
                System.err.println("Error fetching recent applications: " + e.getMessage());
            }

            model.addAttribute("totalUsers", totalUsers);
            model.addAttribute("totalCompanies", totalCompanies);
            model.addAttribute("pendingCompanies", pendingCompanies);
            model.addAttribute("pendingReports", pendingReports);
            model.addAttribute("totalJobs", totalJobs);
            model.addAttribute("activeJobs", activeJobsList);
            model.addAttribute("activeJobsCount", activeJobsCount);
            model.addAttribute("resolvedReports", resolvedReports);

            model.addAttribute("totalCodingQuestions", totalCodingQuestions);
            model.addAttribute("totalInterviewQuestions", totalInterviewQuestions);
            model.addAttribute("totalInterviews", totalInterviews);
            model.addAttribute("completedInterviews", completedInterviews);
            model.addAttribute("totalApplications", totalApplications);
            model.addAttribute("performances", performancesList);
            model.addAttribute("recentUsers", recentUsers);
            model.addAttribute("recentApplications", recentApplications);

            // Add admin name to display on dashboard
            model.addAttribute("adminName", admin.getName() != null ? admin.getName() : admin.getEmail());
            model.addAttribute("admin", admin);
            
            return "admin/adminDashboard";
        } catch (Exception e) {
            System.err.println("Error in dashboard: " + e.getMessage());
            model.addAttribute("error", "Dashboard loading failed: " + e.getMessage());
            return "admin/adminDashboard";
        }
    }
    @RequestMapping(value = "/admin/bookings", method = RequestMethod.GET)
    public String listAllBookings(Model model) {
        model.addAttribute("bookings", sportsBookingService.getAllBookings());
        return "admin/all-bookings";
    }

	/*
	 * @RequestMapping("/reportedJobs") public String viewReportedJobs(Model model) {
	 * model.addAttribute("jobs", jobService.getReportedJobs()); return
	 * "admin-reported-jobs"; }
	 */

    @RequestMapping(value = "/deleteJob/{jobId}", method = RequestMethod.GET)
    public String deleteJob(@PathVariable Long jobId) {
        jobService.deleteJob(jobId);
        return "redirect:/admin/reportedJobs";
    }
    
    @RequestMapping(value = "/company_dashboard", method = RequestMethod.GET)
    public String companyDashboard(HttpSession session) {
        // Check if admin is logged in
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        return "admin/company_dashboard";
    }
 
    // Delete Job
   

    // Delete Company
    @RequestMapping(value = "/delete-company/{id}", method = RequestMethod.POST)
    public String deleteCompany(@PathVariable Long id, HttpSession session) {
        // Check if admin is logged in
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        
        companyService.deleteCompany(id);
        return "redirect:/admin/pending";
    }
    // ð¼ Show Register Page - PROTECTED: Only existing admins can register new admins (admin panel)
    @RequestMapping(value = "/admin/getregisterAdmin", method = RequestMethod.GET)
    public String showAdminRegisterPage(HttpSession session) {
        // Verify admin is logged in
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        return "admin/adminRegister";
    }

    // ð¼ Register Admin - PROTECTED: Requires existing admin authentication (admin panel)
    @RequestMapping(value = "/admin/registerAdmin", method = RequestMethod.POST)
    public String adminRegisterAdmin(@RequestParam String name, @RequestParam String email, 
                                @RequestParam String password, Model model, HttpSession session) {
        // Verify existing admin is logged in
        in.sp.main.Entities.Admin loggedInAdmin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (loggedInAdmin == null) {
            model.addAttribute("error", "Unauthorized access. Only existing administrators can create new admin accounts.");
            return "redirect:/loginAdmin";
        }
        
        try {
            Admin admin = new Admin(name, email, password);
            
            if (adminService.registerAdmin(admin)) {
                System.out.println("admin registered");
                model.addAttribute("msg", "Admin registered successfully!");
                return "admin/adminRegister";
            } else {
                model.addAttribute("error", "Email already exists!");
                return "admin/adminRegister";
            }
        } catch (Exception e) {
            System.err.println("Error during admin registration: " + e.getMessage());
            model.addAttribute("error", "Registration failed: " + e.getMessage());
            return "admin/adminRegister";
        }
    }

    // ð¼ Show Login Page
    @RequestMapping(value = {"/loginAdmin", "/admin/login"}, method = RequestMethod.GET)
    public String showLoginPage() {
        return "admin/adminLogin";
    }

    // ð¼ Admin Login
    @RequestMapping(value = "/PostloginAdmin", method = RequestMethod.POST)
    public String loginAdmin(@RequestParam String email, 
                             @RequestParam String password, 
                             HttpSession session, 
                             Model model, 
                             HttpServletRequest request,
                             HttpServletResponse response) {
        try {
            Admin admin = adminService.loginAdmin(email, password);
            if (admin != null) {
                String token = jwtUtil.generateToken(String.valueOf(admin.getId()), "ADMIN");
                Cookie cookie = jwtUtil.createJwtCookie(token);
                response.addCookie(cookie);

                session.setAttribute("loggedInAdmin", admin);
                session.setAttribute("adminId", admin.getId());
                session.setAttribute("userType", "ADMIN");
                session.setAttribute("userRole", "ADMIN");
                activityLogger.log(admin.getId(), admin.getName(), admin.getEmail(), "ADMIN", ActivityType.LOGIN, "Admin logged in successfully");

                // Redirect to dashboard with context path (WAR name)
                return "redirect:/dashboard";
            } else {
                activityLogger.log(null, "Unknown", email, "ADMIN", ActivityType.FAILED_LOGIN_ATTEMPT, "Failed admin login attempt");
                model.addAttribute("error", "Invalid credentials!");
                return "admin/adminLogin";
            }
        } catch (Exception e) {
            System.err.println("Error during admin login: " + e.getMessage());
            model.addAttribute("error", "Login failed: " + e.getMessage());
            return "admin/adminLogin";
        }
    }
    
    @RequestMapping(value = "/reported-jobs", method = RequestMethod.GET)
    public String viewReportedJobs(Model model) {
        List<ReportedJob> reports = reportedJobRepository.findAllByIsResolvedFalse();
        model.addAttribute("reports", reports);
        List<Company> companies = companyService.getAllCompanies(); 
        model.addAttribute("companies", companies);
        return "admin/ReportedJobs";
    }

    @RequestMapping(value = "/resolve-report/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public String resolveReport(@PathVariable Long id, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttrs) {
        try {
            ReportedJob report = reportedJobRepository.findById(id).orElse(null);
            if (report != null) {
                if (!report.isResolved()) {
                    report.setResolved(true);
                    reportedJobRepository.save(report);
                    redirectAttrs.addFlashAttribute("message", "Report marked as resolved successfully.");
                } else {
                    redirectAttrs.addFlashAttribute("message", "Report is already resolved.");
                }
            } else {
                redirectAttrs.addFlashAttribute("error", "Invalid report ID.");
            }
        } catch (Exception e) {
            System.err.println("Error resolving report: " + e.getMessage());
            e.printStackTrace();
            redirectAttrs.addFlashAttribute("error", "An error occurred while resolving the report.");
        }
        return "redirect:/reported-jobs";
    }
    
    @RequestMapping(value = "/delete-report/{id}", method = {RequestMethod.GET, RequestMethod.POST})
    public String deleteReportedJob(@PathVariable Long id, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttrs) {
        try {
            if (reportedJobRepository.existsById(id)) {
                reportedJobRepository.deleteById(id);
                redirectAttrs.addFlashAttribute("message", "Report deleted successfully.");
            } else {
                redirectAttrs.addFlashAttribute("error", "Invalid report ID.");
            }
        } catch (Exception e) {
            System.err.println("Error deleting report: " + e.getMessage());
            e.printStackTrace();
            redirectAttrs.addFlashAttribute("error", "An error occurred while deleting the report.");
        }
        return "redirect:/reported-jobs";
    }

    
    
    // 1. Show all job seekers
    @RequestMapping(value = "/allJobSeekers", method = RequestMethod.GET)
    public String viewAllJobSeekers(Model model) {
        List<JobSeeker> jobSeekers = jobSeekerService.getAllJobSeekers();
        model.addAttribute("jobSeekers", jobSeekers);
        return "admin/jobseeker-list";
    }

    // 2. View individual job seeker profile
    @RequestMapping(value = "/profile/{id}", method = RequestMethod.GET)
    public String viewJobSeekerProfile(@PathVariable Long id, Model model) {
        JobSeeker jobSeeker = jobSeekerService.getJobSeekerById(id);
        List<String>skills=jobSeeker.getSkills();
        model.addAttribute("jobSeeker", jobSeeker);
        model.addAttribute("skills", skills);     
        model.addAttribute("createdAt", jobSeeker.getCreatedAt());

        return "admin/jobseeker-profile";
    }

    // 3. View reviews/ratings posted by the job seeker
    @RequestMapping(value = "/reviews/{id}", method = RequestMethod.GET)
    public String viewJobSeekerReviews(@PathVariable Long id, Model model) {
        JobSeeker jobSeeker = jobSeekerService.getJobSeekerById(id);
        List<Review> reviews = reviewService.getReviewsByJobSeekerId(id);
        model.addAttribute("jobSeeker", jobSeeker);
        model.addAttribute("reviews", reviews);
        return "admin/jobseeker-reviews";
    }
    @RequestMapping(value = "/adminLogout", method = {RequestMethod.GET, RequestMethod.POST})
    public String logout(HttpSession session, HttpServletResponse response) {
        try {
            Admin admin = (Admin) session.getAttribute("loggedInAdmin");
            if (admin != null) {
                activityLogger.log(admin.getId(), admin.getName(), admin.getEmail(), "ADMIN", ActivityType.LOGOUT, "Admin logged out");
            }
            session.invalidate(); // removes all session attributes
            Cookie cookie = jwtUtil.createClearJwtCookie();
            response.addCookie(cookie);
            return "redirect:/loginAdmin"; // change if your login URL is different
        } catch (Exception e) {
            System.err.println("Error during logout: " + e.getMessage());
            return "redirect:/loginAdmin?error=logout_failed";
        }
    }
  // ==================ORGANIZERS=================
    
    // LIST UNVERIFIED ORGANIZERS
    @RequestMapping(value = "/admin/organizers", method = RequestMethod.GET)
    public String listOrganizers(Model model) {
        model.addAttribute(
            "organizers",
            organizerRepo.findByVerifiedFalse()
        );
        return "admin/organizer-list";
    }

    // VIEW ORGANIZER DETAILS
    @RequestMapping(value = "/admin/organizers/view/{id}", method = RequestMethod.GET)
    public String viewOrganizer(@PathVariable Long id, Model model) {

        model.addAttribute("organizer",
            organizerRepo.findById(id).orElse(null));

        model.addAttribute("documents",
            documentRepo.findByOrganizer_Id(id));

        model.addAttribute("photos",
            photoRepo.findByOrganizer_Id(id));

        return "admin/organizer-view";
    }

    // APPROVE ORGANIZER
    @RequestMapping(value = "/admin/organizers/approve/{id}", method = RequestMethod.POST)
    public String approveOrganizer(@PathVariable Long id) {

        SportsOrganizer org =
            organizerRepo.findById(id).orElse(null);

        if (org != null) {
            org.setVerified(true);
            organizerRepo.save(org);
        }

        return "redirect:/admin/organizers";
    }
    
    // ================== HACKERRANK ADMIN DASHBOARD ==================
    
    @RequestMapping(value = "/hackerrank/admin/dashboard", method = RequestMethod.GET)
    public String hackerrankAdminDashboard(Model model) {
        // Add statistics for dashboard
        long totalUsers = jobSeekerService.getAllJobSeekers().size();
        long totalCompanies = companyService.getAllCompanies().size();
        long totalJobs = jobService.getAllJobs().size();
        
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalCompanies", totalCompanies);
        model.addAttribute("totalJobs", totalJobs);
        model.addAttribute("totalStudents", totalUsers);
        model.addAttribute("totalCodingQuestions", 0);
        model.addAttribute("totalInterviewQuestions", 0);
        model.addAttribute("totalCategories", 0);
        model.addAttribute("totalInterviews", 0);
        model.addAttribute("completedInterviews", 0);
        model.addAttribute("totalApplications", 0);
        model.addAttribute("activeJobs", jobService.getAllActiveJobs());
        model.addAttribute("recentUsers", jobSeekerService.getAllJobSeekers());
        model.addAttribute("recentApplications", java.util.Collections.emptyList());
        
        return "hackerrank/admin-dashboard";
    }

    @RequestMapping(value = {"/hackerrank/admin/analytics", "/admin/analytics"}, method = RequestMethod.GET)
    public String hackerrankAdminAnalytics(Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        
        long totalUsers = 0;
        long totalStudents = 0;
        long totalInterviewers = 0;
        long totalCodingQuestions = 0;
        long totalInterviewQuestions = 0;
        long totalInterviews = 0;
        long completedInterviews = 0;
        long scheduledInterviews = 0;
        
        try {
            if (jobSeekerService != null && jobSeekerService.getAllJobSeekers() != null) {
                List<JobSeeker> allJobSeekers = jobSeekerService.getAllJobSeekers();
                totalUsers = allJobSeekers.size();
                totalStudents = allJobSeekers.stream().filter(u -> "STUDENT".equalsIgnoreCase(u.getRole())).count();
                totalInterviewers = allJobSeekers.stream().filter(u -> "INTERVIEWER".equalsIgnoreCase(u.getRole())).count();
            }
        } catch (Exception e) {
            System.err.println("Error fetching user stats: " + e.getMessage());
        }
        
        try {
            if (questionDAO != null) {
                List<in.sp.main.Entities.CodingQuestion> codingQs = questionDAO.findAllCodingQuestions();
                totalCodingQuestions = codingQs != null ? codingQs.size() : 0;
                
                List<in.sp.main.Entities.InterviewQuestion> interviewQs = questionDAO.findAllInterviewQuestions();
                totalInterviewQuestions = interviewQs != null ? interviewQs.size() : 0;
            }
        } catch (Exception e) {
            System.err.println("Error fetching questions: " + e.getMessage());
        }
        
        try {
            if (interviewDAO != null) {
                List<in.sp.main.Entities.MockInterview> allInterviews = interviewDAO.findAll();
                totalInterviews = allInterviews != null ? allInterviews.size() : 0;
                
                if (allInterviews != null) {
                    completedInterviews = allInterviews.stream()
                        .filter(i -> "COMPLETED".equalsIgnoreCase(i.getStatus()))
                        .count();
                        
                    scheduledInterviews = allInterviews.stream()
                        .filter(i -> "SCHEDULED".equalsIgnoreCase(i.getStatus()) || "PENDING".equalsIgnoreCase(i.getStatus()))
                        .count();
                }
            }
        } catch (Exception e) {
            System.err.println("Error fetching interviews: " + e.getMessage());
        }
        
        List<in.sp.main.Entities.AIEvaluation> evaluations = new java.util.ArrayList<>();
        try {
            if (aiEvaluationDAO != null) {
                evaluations = aiEvaluationDAO.findAll();
            }
        } catch (Exception e) {
            System.err.println("Error fetching evaluations: " + e.getMessage());
        }
        
        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalStudents", totalStudents);
        model.addAttribute("totalInterviewers", totalInterviewers);
        model.addAttribute("totalCodingQuestions", totalCodingQuestions);
        model.addAttribute("totalInterviewQuestions", totalInterviewQuestions);
        model.addAttribute("totalInterviews", totalInterviews);
        model.addAttribute("completedInterviews", completedInterviews);
        model.addAttribute("scheduledInterviews", scheduledInterviews);
        model.addAttribute("evaluations", evaluations);
        
        return "hackerrank/analytics";
    }

    @RequestMapping(value = {"/hackerrank/admin/manage-users", "/admin/manage-users"}, method = RequestMethod.GET)
    public String hackerrankAdminManageUsers(@RequestParam(required = false) String role, Model model, HttpSession session) {
        Admin admin = (Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        List<JobSeeker> allJobSeekers = jobSeekerService.getAllJobSeekers();
        
        // Calculate role counts
        long studentCount = allJobSeekers.stream().filter(u -> "STUDENT".equals(u.getRole())).count();
        long interviewerCount = allJobSeekers.stream().filter(u -> "INTERVIEWER".equals(u.getRole())).count();
        long adminCount = allJobSeekers.stream().filter(u -> "ADMIN".equals(u.getRole())).count();
        long totalCount = allJobSeekers.size();
        
        model.addAttribute("studentCount", studentCount);
        model.addAttribute("interviewerCount", interviewerCount);
        model.addAttribute("adminCount", adminCount);
        model.addAttribute("totalCount", totalCount);
        
        // Filter by role if specified
        List<JobSeeker> filteredJobSeekers;
        if (role != null && !role.isEmpty()) {
            filteredJobSeekers = allJobSeekers.stream()
                .filter(u -> role.equals(u.getRole()))
                .collect(java.util.stream.Collectors.toList());
        } else {
            filteredJobSeekers = allJobSeekers;
        }
        
        model.addAttribute("jobSeekers", filteredJobSeekers);
        model.addAttribute("selectedRole", role);
        return "hackerrank/manage-users";
    }

    @RequestMapping(value = "/hackerrank/admin/manage-questions", method = RequestMethod.GET)
    public String hackerrankAdminManageQuestions(Model model) {
        // Fetch categories from database
        model.addAttribute("categories", categoryDAO.findAll());
        model.addAttribute("codingQuestions", questionDAO.findAllCodingQuestions());
        model.addAttribute("interviewQuestions", questionDAO.findAllInterviewQuestions());
        
        try {
            List<StudentAnswer> studentAnswers = performanceDAO.findAllStudentAnswers();
            model.addAttribute("studentAnswers", studentAnswers);
            
            Map<String, List<StudentAnswer>> byUser = new HashMap<>();
            Map<String, List<StudentAnswer>> byTopic = new HashMap<>();
            
            for (StudentAnswer a : studentAnswers) {
                String uName = a.getStudentName() != null ? a.getStudentName() : "User " + a.getStudentId();
                byUser.computeIfAbsent(uName, k -> new ArrayList<>()).add(a);
                
                String topic = a.getQuestionType() != null ? a.getQuestionType() + " Questions" : "Unknown Topic";
                byTopic.computeIfAbsent(topic, k -> new ArrayList<>()).add(a);
            }
            
            model.addAttribute("answersByUser", byUser);
            model.addAttribute("answersByTopic", byTopic);
        } catch(Exception e) {
            model.addAttribute("studentAnswers", new ArrayList<>());
            model.addAttribute("answersByUser", new HashMap<>());
            model.addAttribute("answersByTopic", new HashMap<>());
        }
        
        return "hackerrank/manage-questions";
    }

    @RequestMapping(value = "/hackerrank/admin/results", method = RequestMethod.GET)
    public String viewHackerrankResults(Model model) {
        try {
            List<StudentAnswer> studentAnswers = performanceDAO.findAllStudentAnswers();
            model.addAttribute("studentAnswers", studentAnswers);
            
            Map<String, List<StudentAnswer>> byUser = new HashMap<>();
            Map<String, List<StudentAnswer>> byTopic = new HashMap<>();
            
            for (StudentAnswer a : studentAnswers) {
                String uName = a.getStudentName() != null ? a.getStudentName() : "User " + a.getStudentId();
                byUser.computeIfAbsent(uName, k -> new ArrayList<>()).add(a);
                
                String topic = a.getQuestionType() != null ? a.getQuestionType() + " Questions" : "Unknown Topic";
                byTopic.computeIfAbsent(topic, k -> new ArrayList<>()).add(a);
            }
            
            model.addAttribute("answersByUser", byUser);
            model.addAttribute("answersByTopic", byTopic);
        } catch(Exception e) {
            model.addAttribute("studentAnswers", new ArrayList<>());
            model.addAttribute("answersByUser", new HashMap<>());
            model.addAttribute("answersByTopic", new HashMap<>());
        }
        
        return "hackerrank/admin-results";
    }

    @RequestMapping(value = "/hackerrank/admin/add-coding-question", method = RequestMethod.POST)
    public String addCodingQuestion(@RequestParam String title,
                                     @RequestParam String difficulty,
                                     @RequestParam Long categoryId,
                                     @RequestParam String sampleInput,
                                     @RequestParam String description,
                                     @RequestParam String sampleOutput,
                                     @RequestParam String solution,
                                     RedirectAttributes redirectAttrs) {
        CodingQuestion q = new CodingQuestion();
        q.setTitle(title);
        q.setDescription(description);
        q.setDifficulty(difficulty);
        q.setCategoryId(categoryId);
        q.setSampleInput(sampleInput);
        q.setSampleOutput(sampleOutput);
        q.setSolution(solution);
        q.setCreatedBy(1L); // Admin user
        questionDAO.saveCodingQuestion(q);
        redirectAttrs.addFlashAttribute("success", "Coding question added successfully!");
        return "redirect:/hackerrank/admin/manage-questions";
    }

    @RequestMapping(value = "/hackerrank/admin/add-interview-question", method = RequestMethod.POST)
    public String addInterviewQuestion(@RequestParam String question,
                                      @RequestParam String questionType,
                                      @RequestParam String difficulty,
                                      @RequestParam(required = false) Long categoryId,
                                      @RequestParam String expectedAnswer,
                                      RedirectAttributes redirectAttrs) {
        InterviewQuestion q = new InterviewQuestion();
        q.setQuestion(question);
        q.setQuestionType(questionType);
        q.setDifficulty(difficulty);
        q.setCategoryId(categoryId);
        q.setExpectedAnswer(expectedAnswer);
        q.setCreatedBy(1L); // Admin user
        questionDAO.saveInterviewQuestion(q);
        redirectAttrs.addFlashAttribute("success", "Interview question added successfully!");
        return "redirect:/hackerrank/admin/manage-questions";
    }

    @RequestMapping(value = "/hackerrank/admin/manage-categories", method = RequestMethod.GET)
    public String hackerrankAdminManageCategories(Model model) {
        model.addAttribute("categories", categoryDAO.findAll());
        return "hackerrank/manage-categories";
    }

    @RequestMapping(value = "/hackerrank/admin/add-category", method = RequestMethod.POST)
    public String addCategory(@RequestParam String name,
                             @RequestParam String description,
                             @RequestParam String color,
                             @RequestParam(required = false) String icon,
                             RedirectAttributes redirectAttrs) {
        in.sp.main.Entities.Category category = new in.sp.main.Entities.Category();
        category.setName(name);
        category.setDescription(description);
        category.setColor(color);
        category.setIcon(icon);
        categoryDAO.save(category);
        redirectAttrs.addFlashAttribute("success", "Category added successfully!");
        return "redirect:/hackerrank/admin/manage-categories";
    }

    @RequestMapping(value = "/hackerrank/admin/delete-category/{id}", method = RequestMethod.POST)
    public String deleteCategory(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        categoryDAO.delete(id);
        redirectAttrs.addFlashAttribute("success", "Category deleted successfully!");
        return "redirect:/hackerrank/admin/manage-categories";
    }

    @RequestMapping(value = "/hackerrank/admin/delete-coding-question/{id}", method = RequestMethod.POST)
    public String deleteCodingQuestion(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        questionDAO.deleteCodingQuestion(id);
        redirectAttrs.addFlashAttribute("success", "Question deleted successfully!");
        return "redirect:/hackerrank/admin/manage-questions";
    }

    @RequestMapping(value = "/hackerrank/admin/account", method = RequestMethod.GET)
    public String hackerrankAdminAccount(Model model, HttpSession session) {
        in.sp.main.Entities.Admin user = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (user != null) {
            model.addAttribute("user", user);
        }
        return "hackerrank/admin-account";
    }

    @RequestMapping(value = "/hackerrank/admin/delete-interview-question/{id}", method = RequestMethod.POST)
    public String deleteInterviewQuestion(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        redirectAttrs.addFlashAttribute("success", "Interview question deleted successfully!");
        return "redirect:/hackerrank/admin/manage-questions";
    }

    @RequestMapping(value = "/hackerrank/admin/update-role/{id}", method = RequestMethod.POST)
    public String updateUserRole(@PathVariable Long id, @RequestParam String role, RedirectAttributes redirectAttrs) {
        redirectAttrs.addFlashAttribute("success", "User role updated successfully!");
        return "redirect:/hackerrank/admin/manage-users";
    }

    @RequestMapping(value = "/hackerrank/admin/toggle-user/{id}", method = RequestMethod.POST)
    public String toggleUserStatus(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        redirectAttrs.addFlashAttribute("success", "User status toggled successfully!");
        return "redirect:/hackerrank/admin/manage-users";
    }

    @RequestMapping(value = "/hackerrank/admin/delete-user/{id}", method = RequestMethod.POST)
    public String deleteUser(@PathVariable Long id, RedirectAttributes redirectAttrs) {
        redirectAttrs.addFlashAttribute("success", "User deleted successfully!");
        return "redirect:/hackerrank/admin/manage-users";
    }
    
    @RequestMapping(value = "/had", method = RequestMethod.GET)
    public String had(Model model) {
        try {
            // Add statistics for dashboard
            long totalUsers = 0;
            long totalCompanies = 0;
            long totalJobs = 0;
            long totalInterviewers = 0;
            
            try {
                if (jobSeekerService != null && jobSeekerService.getAllJobSeekers() != null) {
                    totalUsers = jobSeekerService.getAllJobSeekers().size();
                }
            } catch (Exception e) {
                System.err.println("Error fetching total users: " + e.getMessage());
            }
            
            try {
                if (companyService != null && companyService.getAllCompanies() != null) {
                    totalCompanies = companyService.getAllCompanies().size();
                }
            } catch (Exception e) {
                System.err.println("Error fetching total companies: " + e.getMessage());
            }
            
            try {
                if (jobService != null && jobService.getAllJobs() != null) {
                    totalJobs = jobService.getAllJobs().size();
                }
            } catch (Exception e) {
                System.err.println("Error fetching total jobs: " + e.getMessage());
            }
            
            // Fetch actual counts from DAOs
            long totalCodingQuestions = 0;
            long totalInterviewQuestions = 0;
            long totalInterviews = 0;
            long completedInterviews = 0;
            
            try {
                if (questionDAO != null) {
                    List<in.sp.main.Entities.CodingQuestion> codingQs = questionDAO.findAllCodingQuestions();
                    totalCodingQuestions = codingQs != null ? codingQs.size() : 0;
                    
                    List<in.sp.main.Entities.InterviewQuestion> interviewQs = questionDAO.findAllInterviewQuestions();
                    totalInterviewQuestions = interviewQs != null ? interviewQs.size() : 0;
                }
            } catch (Exception e) {
                System.err.println("Error fetching questions: " + e.getMessage());
            }
            
            try {
                if (interviewDAO != null) {
                    List<in.sp.main.Entities.MockInterview> allInterviews = interviewDAO.findAll();
                    totalInterviews = allInterviews != null ? allInterviews.size() : 0;
                    
                    if (allInterviews != null) {
                        completedInterviews = allInterviews.stream()
                            .filter(i -> "COMPLETED".equalsIgnoreCase(i.getStatus()))
                            .count();
                    }
                }
            } catch (Exception e) {
                System.err.println("Error fetching interviews: " + e.getMessage());
            }
            
            model.addAttribute("totalUsers", totalUsers);
            model.addAttribute("totalCompanies", totalCompanies);
            model.addAttribute("totalJobs", totalJobs);
            model.addAttribute("totalStudents", totalUsers);
            model.addAttribute("totalInterviewers", totalInterviewers);
            model.addAttribute("totalCodingQuestions", totalCodingQuestions);
            model.addAttribute("totalInterviewQuestions", totalInterviewQuestions);
            model.addAttribute("totalCategories", 0); // Categories not yet implemented
            model.addAttribute("totalInterviews", totalInterviews);
            model.addAttribute("completedInterviews", completedInterviews);
            model.addAttribute("totalApplications", 0); // Applications count needs separate service
            
            try {
                if (jobService != null) {
                    model.addAttribute("activeJobs", jobService.getAllActiveJobs());
                } else {
                    model.addAttribute("activeJobs", java.util.Collections.emptyList());
                }
            } catch (Exception e) {
                System.err.println("Error fetching active jobs: " + e.getMessage());
                model.addAttribute("activeJobs", java.util.Collections.emptyList());
            }
            
            try {
                if (jobSeekerService != null) {
                    model.addAttribute("recentUsers", jobSeekerService.getAllJobSeekers());
                } else {
                    model.addAttribute("recentUsers", java.util.Collections.emptyList());
                }
            } catch (Exception e) {
                System.err.println("Error fetching recent users: " + e.getMessage());
                model.addAttribute("recentUsers", java.util.Collections.emptyList());
            }
            
            model.addAttribute("recentApplications", java.util.Collections.emptyList());
            
            return "hackerrank/admin-dashboard";
        } catch (Exception e) {
            System.err.println("Error in had() method: " + e.getMessage());
            // Add default values to prevent JSP errors
            model.addAttribute("totalUsers", 0);
            model.addAttribute("totalCompanies", 0);
            model.addAttribute("totalJobs", 0);
            model.addAttribute("totalStudents", 0);
            model.addAttribute("totalInterviewers", 0);
            model.addAttribute("totalCodingQuestions", 0);
            model.addAttribute("totalInterviewQuestions", 0);
            model.addAttribute("totalCategories", 0);
            model.addAttribute("totalInterviews", 0);
            model.addAttribute("completedInterviews", 0);
            model.addAttribute("totalApplications", 0);
            model.addAttribute("activeJobs", java.util.Collections.emptyList());
            model.addAttribute("recentUsers", java.util.Collections.emptyList());
            model.addAttribute("recentApplications", java.util.Collections.emptyList());
            return "hackerrank/admin-dashboard";
        }
    }

    @RequestMapping(value = "/admin/recruiters", method = RequestMethod.GET)
    public String viewRecruitersCompanyWise(Model model, HttpSession session) {
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        
        List<Company> companies = companyService.getAllCompanies();
        Map<Long, List<Recruiter>> companyRecruitersMap = new HashMap<>();
        for (Company c : companies) {
            List<Recruiter> recruiters = recruiterRepository.findByCompany_Id(c.getId());
            companyRecruitersMap.put(c.getId(), recruiters);
        }
        model.addAttribute("companies", companies);
        model.addAttribute("companyRecruitersMap", companyRecruitersMap);
        return "admin/recruiters-company-wise";
    }

    @RequestMapping(value = "/admin/technicians", method = RequestMethod.GET)
    public String viewTechniciansCompanyWise(Model model, HttpSession session) {
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        
        List<Company> companies = companyService.getAllCompanies();
        Map<Long, List<TechPerson>> companyTechniciansMap = new HashMap<>();
        for (Company c : companies) {
            List<TechPerson> technicians = techPersonRepository.findByCompanyId(c.getId());
            companyTechniciansMap.put(c.getId(), technicians);
        }
        model.addAttribute("companies", companies);
        model.addAttribute("companyTechniciansMap", companyTechniciansMap);
        return "admin/technicians-company-wise";
    }

    @RequestMapping(value = "/admin/delete-company-with-reason/{id}", method = RequestMethod.POST)
    public String deleteCompanyByAdminWithReason(@PathVariable Long id, @RequestParam("reason") String reason, HttpSession session, RedirectAttributes redirectAttributes) {
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        
        System.out.println("Admin deleted company " + id + " for reason: " + reason);
        companyService.deleteCompany(id);
        redirectAttributes.addFlashAttribute("success", "Company deleted successfully.");
        return "redirect:/admin/technicians";
    }

    @RequestMapping(value = "/admin/delete-techperson/{id}", method = RequestMethod.POST)
    public String deleteTechPersonByAdmin(@PathVariable Long id, @RequestParam("reason") String reason, HttpSession session, RedirectAttributes redirectAttributes) {
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        
        System.out.println("Admin deleted techperson " + id + " for reason: " + reason);
        techPersonServices.deleteTechPerson(id);
        redirectAttributes.addFlashAttribute("success", "Technician deleted successfully.");
        return "redirect:/admin/technicians";
    }

    @RequestMapping(value = "/admin/delete-company-recruiter-with-reason/{id}", method = RequestMethod.POST)
    public String deleteCompanyRecruiterByAdminWithReason(@PathVariable Long id, @RequestParam("reason") String reason, HttpSession session, RedirectAttributes redirectAttributes) {
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        
        System.out.println("Admin deleted company " + id + " for reason: " + reason);
        companyService.deleteCompany(id);
        redirectAttributes.addFlashAttribute("success", "Company deleted successfully.");
        return "redirect:/admin/recruiters";
    }

    @RequestMapping(value = "/admin/delete-recruiter/{id}", method = RequestMethod.POST)
    public String deleteRecruiterByAdmin(@PathVariable Long id, @RequestParam("reason") String reason, HttpSession session, RedirectAttributes redirectAttributes) {
        in.sp.main.Entities.Admin admin = (in.sp.main.Entities.Admin) session.getAttribute("loggedInAdmin");
        if (admin == null) {
            return "redirect:/loginAdmin";
        }
        
        System.out.println("Admin deleted recruiter " + id + " for reason: " + reason);
        recruiterServices.deleteRecruiter(id);
        redirectAttributes.addFlashAttribute("success", "Recruiter deleted successfully.");
        return "redirect:/admin/recruiters";
    }
}
