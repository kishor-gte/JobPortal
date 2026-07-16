package in.sp.main.Controllers;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import in.sp.main.Entities.Company;
import in.sp.main.Entities.Job;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.Media;
import in.sp.main.Entities.Recruiter;
import in.sp.main.Entities.Review;
import in.sp.main.Entities.AssessmentQuestion;
import in.sp.main.Entities.AssessmentInvitation;
import in.sp.main.Enums.JobStatus;
import in.sp.main.Enums.Location;
import in.sp.main.utils.ActivityLogger;
import in.sp.main.Enums.ActivityType;
import in.sp.main.Repositories.CompanyRepository;
import in.sp.main.Repositories.JobSeekerRepository;
import in.sp.main.Repositories.ReviewRepository;
import in.sp.main.Repositories.AssessmentInvitationRepository;
import in.sp.main.Services.CompanyServices;
import in.sp.main.Services.FileUploadServices;
import in.sp.main.Services.JobServices;
import in.sp.main.Services.MediaService;
import in.sp.main.Services.RecruiterServices;
import in.sp.main.Services.RefundService;
import in.sp.main.Services.SportsBookingService;
import in.sp.main.Services.SportsServiceService;
import in.sp.main.Services.AssessmentService;
import in.sp.main.Services.ExcelHelper;
import in.sp.main.Services.JobApplicationService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpSession;
import in.sp.main.Configuration.JwtUtil;

@Controller
@RequestMapping("/company")
public class CompanyController {

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private CompanyServices companyService;
    @Autowired
    private FileUploadServices fileUploadService;
    @Autowired
    private CompanyRepository companyRepository;

    @Autowired
    private ReviewRepository reviewRepository;

    @Autowired
    private JobSeekerRepository jobSeekerRepository;

    @Autowired
    private MediaService mediaService;
    
    @Autowired
    private RecruiterServices recruiterService;
    
    @Autowired
    private JobServices jobService;
    
    @Autowired
    private SportsServiceService sportsServiceService;
    
    @Autowired
    private SportsBookingService sportsBookingService;

    @Autowired
    private RefundService refundService;
    
    @Autowired
    private AssessmentService assessmentService;
    
    @Autowired
    private AssessmentInvitationRepository assessmentInvitationRepo;
    
    @Autowired
    private JobApplicationService jobApplicationService;
    
    @Autowired
    private ActivityLogger activityLogger;
    
    @Value("${razorpay.key.id}")
    private String razorpayKeyId;

    @Value("${razorpay.key.secret}")
    private String razorpayKeySecret;

    // Show company registration form
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String showRegistrationForm(Model model) {
        model.addAttribute("company", new Company());
        return "company/registerCompany";
    }

    // Handle registration submission
    @RequestMapping(value = "/register1", method = RequestMethod.POST)
    public String registerCompany(@ModelAttribute Company company,
                                  @RequestParam("logofile") MultipartFile logoFile, Model model) {
        try {
            System.out.println("DEBUG: Registering company - Name: " + company.getName() + ", Email: " + company.getEmail());
            if (!logoFile.isEmpty()) {
                String logoPath = fileUploadService.saveLogo(logoFile);
                company.setLogo(logoPath);
                System.out.println("DEBUG: Logo saved at: " + logoPath);
            }
            Company savedCompany = companyService.registerCompany(company);
            System.out.println("DEBUG: Company saved - ID: " + savedCompany.getId() + ", Verified: " + savedCompany.isVerified());
            activityLogger.log(savedCompany.getId(), savedCompany.getName(), savedCompany.getEmail(), "COMPANY", ActivityType.USER_REGISTRATION, "Company registered successfully");
            model.addAttribute("message", "Registration successful. Your account is under verification. You will receive an email notification once the process is complete.");
            return "company/success";
        } catch (Exception e) {
            System.err.println("ERROR: Failed to register company: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Failed to upload logo: " + e.getMessage());
        }
		return razorpayKeyId;
    }
    // Show company profile
    @RequestMapping(value = "/profile/{id}", method = RequestMethod.GET)
    public String viewProfile(@PathVariable Long id, Model model) {
        Optional<Company> companyOpt = companyService.getCompany(id);
        Company company = companyOpt.orElseThrow(() -> new RuntimeException("Company not found with id: " + id));
        model.addAttribute("company", company);
        return "company/companyProfile";
    }

   
    // View all verified companies
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String viewAllVerified(Model model) {
        model.addAttribute("companies", companyService.getAllVerifiedCompanies());
        return "company/companyList";
    }
    
    
 // Show update form
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String showEditForm(@PathVariable Long id, Model model) {
        Optional<Company> companyOpt = companyService.getCompany(id);
        Company company = companyOpt.orElseThrow(() -> new RuntimeException("Company not found with id: " + id));
        model.addAttribute("company", company);
        return "company/editCompany"; // Create this JSP page
    }

    // Handle update submission
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateCompany(@ModelAttribute Company company,
                                @RequestParam(value = "logofile", required = false) MultipartFile logoFile) {
        try {
            Company existing = companyService.getCompany(company.getId())
                    .orElseThrow(() -> new RuntimeException("Company not found with id: " + company.getId()));

            // If any field is blank or null, retain the old value
            if (company.getName() == null || company.getName().trim().isEmpty()) {
                company.setName(existing.getName());
            }
            if (company.getIndustry() == null || company.getIndustry().trim().isEmpty()) {
                company.setIndustry(existing.getIndustry());
            }
            if (company.getLocation() == null || company.getLocation().trim().isEmpty()) {
                company.setLocation(existing.getLocation());
            }
            if (company.getAbout() == null || company.getAbout().trim().isEmpty()) {
                company.setAbout(existing.getAbout());
            }
            if (company.getWebsite() == null || company.getWebsite().trim().isEmpty()) {
                company.setWebsite(existing.getWebsite());
            }
            if(company.getEmail()==null||company.getEmail().trim().isEmpty())
            {
            	company.setEmail(existing.getEmail());
            }
            if(company.getPassword()==null||company.getPassword().trim().isEmpty())
            {
            	company.setPassword(existing.getPassword());
            }

            // New fields update
            if (company.getPhone() != null && !company.getPhone().trim().isEmpty()) {
                company.setPhone(company.getPhone());
            } else {
                company.setPhone(existing.getPhone());
            }

            if (company.getFoundedYear() != null && !company.getFoundedYear().trim().isEmpty()) {
                company.setFoundedYear(company.getFoundedYear());
            } else {
                company.setFoundedYear(existing.getFoundedYear());
            }

            if (company.getCompanySize() != null && !company.getCompanySize().trim().isEmpty()) {
                company.setCompanySize(company.getCompanySize());
            } else {
                company.setCompanySize(existing.getCompanySize());
            }

            if (company.getLinkedInUrl() != null && !company.getLinkedInUrl().trim().isEmpty()) {
                company.setLinkedInUrl(company.getLinkedInUrl());
            } else {
                company.setLinkedInUrl(existing.getLinkedInUrl());
            }

            // For logo
            if (logoFile != null && !logoFile.isEmpty()) {
                String logoPath = fileUploadService.saveImage(logoFile);
                company.setLogo(logoPath);
            } else {
                company.setLogo(existing.getLogo());
            }

            // Preserve existing relations if needed
            company.setJobPosts(existing.getJobPosts());
            company.setCultureVideos(existing.getCultureVideos());
            company.setReviews(existing.getReviews());

            // Preserve verified status
            company.setVerified(existing.isVerified());

            companyService.updateCompany(company);
            activityLogger.log(company.getId(), company.getName(), company.getEmail(), "COMPANY", ActivityType.PROFILE_UPDATED, "Company updated profile");

        } catch (IOException e) {
            e.printStackTrace();
        }

        return "redirect:/company/profile/" + company.getId();
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String deleteCompany(@PathVariable Long id) {
        companyService.deleteCompany(id);
        return "redirect:/company/list";
    }
    // Display all companies with search bar
    @RequestMapping(value = "/Alllist", method = RequestMethod.GET)
    public String listCompanies(@RequestParam(required = false) String keyword, Model model, HttpSession session) {
        // Check if user is logged in
        JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
        if (jobSeeker == null) {
            return "redirect:/jobSeekers/login";
        }
        
        List<Company> companies = (keyword == null || keyword.isEmpty())
                ? companyRepository.findAll()
                : companyRepository.findByNameContainingIgnoreCase(keyword);
        model.addAttribute("companies", companies);
        return "company/company-list"; // JSP page
    }

    // Show review form for selected company
    @RequestMapping(value = "/review/{companyId}", method = RequestMethod.GET)
    public String showReviewForm(@PathVariable Long companyId, Model model, HttpSession session) {
        Company company = companyRepository.findById(companyId).orElse(null);
        if (company == null) return "redirect:/company/Alllist";

        model.addAttribute("company", company);
        model.addAttribute("review", new Review());
        return "company/rateCompany"; // JSP page to create review
    }

    // Handle review form submission
    @RequestMapping(value = "/review/save", method = RequestMethod.POST)
    public String saveReview(@ModelAttribute Review review, @RequestParam Long companyId, HttpSession session) {
        JobSeeker jobSeekersUser= (JobSeeker) session.getAttribute("jobSeeker");
       Long jobSeekerId=jobSeekersUser.getId();
        if (jobSeekerId == null) return "redirect:/jobSeekers/login";

        JobSeeker jobSeeker = jobSeekerRepository.findById(jobSeekerId).orElse(null);
        Company company = companyRepository.findById(companyId).orElse(null);
        if (jobSeeker == null || company == null) return "redirect:/company/Alllist";

        review.setCompany(company);
        review.setJobSeeker(jobSeeker);
        review.setCreatedAt(LocalDateTime.now().toString());
        reviewRepository.save(review);

        return "redirect:/company/Alllist";
    }
    //company details
    @RequestMapping(value = "/details/{id}", method = RequestMethod.GET)
    public String viewDeatils(@PathVariable Long id, Model model) {
        Company company = companyService.getCompany(id)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + id));

        double avgRating = 0;
        List<Review> reviews = company.getReviews();
        if (reviews != null && !reviews.isEmpty()) {
            avgRating = reviews.stream().mapToInt(Review::getRating).average().orElse(0);
        }

        // ✅ Round to 1 decimal place
        double roundedRating = Math.round(avgRating * 10.0) / 10.0;

        model.addAttribute("company", company);
        model.addAttribute("avgRating", roundedRating);
        return "company/company-detail";
    }
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginPage() {
        return "company/company_login";
    }
    @RequestMapping(value = "/login1", method = RequestMethod.POST)
    public String loginCompany(@RequestParam String email,
                               @RequestParam String password,
                               HttpSession session,
                               HttpServletResponse response,
                               Model model) {

        String result = companyService.authenticateCompany(email, password);

        switch (result) {
            case "SUCCESS":
                Company company = companyRepository.findFirstByEmail(email).get();
                
                String token = jwtUtil.generateToken(String.valueOf(company.getId()), "COMPANY");
                Cookie cookie = jwtUtil.createJwtCookie(token);
                response.addCookie(cookie);
                
                session.setAttribute("loggedInCompany", company);
                session.setAttribute("userType", "COMPANY");
                activityLogger.log(company.getId(), company.getName(), company.getEmail(), "COMPANY", ActivityType.LOGIN, "Company logged in successfully");
                return "redirect:/company/dashboard";

            case "NOT_VERIFIED":
                model.addAttribute("warning", "Your account is awaiting admin approval. You’ll be able to log in once verified.");
                break;

            case "NOT_FOUND":
                activityLogger.log(null, "Unknown", email, "COMPANY", ActivityType.FAILED_LOGIN_ATTEMPT, "Failed company login attempt");
                model.addAttribute("error", "Invalid email or password. Please try again.");
                break;
        }

        return "company/company_login";
    }


    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session, HttpServletResponse response) {
        Company company = (Company) session.getAttribute("loggedInCompany");
        if (company != null) {
            activityLogger.log(company.getId(), company.getName(), company.getEmail(), "COMPANY", ActivityType.LOGOUT, "Company logged out");
        }
        session.invalidate();
        Cookie cookie = jwtUtil.createClearJwtCookie();
        response.addCookie(cookie);
        return "redirect:/company/login";
    }
    
    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String showCompanyDashboard( Model model,HttpSession session ) {
        Company company=(Company) session.getAttribute("loggedInCompany");
        model.addAttribute("company", company);
        return "company/dashboard";
    }


 // Show Media Page for a specific company
    @RequestMapping(value = "/media/{companyId}", method = RequestMethod.GET)
    public String showMediaPage(@PathVariable Long companyId, Model model) {
        // Fetch company details
        Company company = companyService.getCompany(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));

        // Fetch media list for the company
        List<Media> mediaList = mediaService.getMediaByCompany(companyId);

        // Add the company and media list to the model for the view
        model.addAttribute("company", company);
        model.addAttribute("mediaList", mediaList);

        return "company/manageMedia";  // This corresponds to manageMedia.jsp
    }

    // Handle missing companyId
    @RequestMapping(value = "/media/upload", method = RequestMethod.GET)
    public String showUploadPageFallback(HttpSession session) {
        Company loggedInCompany = (Company) session.getAttribute("loggedInCompany");
        if (loggedInCompany != null) {
            return "redirect:/company/media/upload/" + loggedInCompany.getId();
        }
        return "redirect:/company/login";
    }
    @RequestMapping(value = "/media/upload/", method = RequestMethod.GET)
    public String showUploadPageFallbackSlash(HttpSession session) {
        return showUploadPageFallback(session);
    }

    // Show the page to upload a new media (video) for a company
    @RequestMapping(value = "/media/upload/{companyId}", method = RequestMethod.GET)
    public String showUploadPage(@PathVariable Long companyId, Model model) {
        // Fetch company details for the upload page
        Company company = companyService.getCompany(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found with id: " + companyId));
        model.addAttribute("company", company);

        return "company/uploadMedia";  // This corresponds to uploadMedia.jsp
    }

    // Handle the upload of a new video
    @RequestMapping(value = "/media/add/{companyId}", method = RequestMethod.POST)
    public String addMedia(@PathVariable Long companyId,
                           @RequestParam("title") String title,
                           @RequestParam("videoFile") MultipartFile videoFile,
                           @RequestParam(value = "description", required = false) String description) {
        try {
            // Validate file
            if (videoFile == null || videoFile.isEmpty()) {
                System.err.println("Video file is empty or null");
                return "redirect:/company/media/" + companyId + "?error=empty";
            }
            
            // Log upload attempt
            System.out.println("Uploading video for company " + companyId + ": " + videoFile.getOriginalFilename() + 
                             " (" + videoFile.getSize() + " bytes)");
            
            // Save the uploaded video file using the video-specific method
            String videoPath = fileUploadService.saveVideo(videoFile);
            System.out.println("Video saved to: " + videoPath);

            // Add the media (video) to the company
            mediaService.addMedia(companyId, title, videoPath, description);
            System.out.println("Media added successfully to company " + companyId);
            
        } catch (IOException e) {
            System.err.println("IO Error uploading video: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/company/media/" + companyId + "?error=io";
        } catch (IllegalArgumentException e) {
            System.err.println("Validation error: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/company/media/" + companyId + "?error=invalid";
        } catch (Exception e) {
            System.err.println("Unexpected error uploading video: " + e.getMessage());
            e.printStackTrace();
            return "redirect:/company/media/" + companyId + "?error=unknown";
        }

        // Redirect to the media page after successful upload
        return "redirect:/company/media/" + companyId;
    }

    // Handle the deletion of a media file
    @RequestMapping(value = "/media/delete/{mediaId}/{companyId}", method = RequestMethod.GET)
    public String deleteMedia(@PathVariable Long mediaId, @PathVariable Long companyId) {
        // Delete the media item by its ID
        mediaService.deleteMedia(mediaId);

        // Redirect to the media management page for the company
        return "redirect:/company/media/" + companyId;
    }
    @RequestMapping(value = "/recruiters/{companyId}", method = RequestMethod.GET)
    public String listCompanyRecruiters(@PathVariable Long companyId, Model model) {
        Company company = companyService.getCompany(companyId)
                .orElse(null);
        if (company == null) {
            return "redirect:/company/list"; // Or show an error page
        }

        List<Recruiter> recruiters = recruiterService.findRecruitersByCompany(companyId);
        model.addAttribute("company", company);
        model.addAttribute("recruiters", recruiters);

        return "recruiter/recruiterList"; // Create this JSP/HTML page
    }
    @RequestMapping(value = "/reviews/{companyId}", method = RequestMethod.GET)
    public String viewReviews(HttpSession session, Model model) {
        Company loggedInCompany = (Company) session.getAttribute("loggedInCompany");
        if (loggedInCompany == null) {
            return "redirect:/company/login";
        }
        List<Review> reviews = reviewRepository.findByCompany_Id(loggedInCompany.getId());
        model.addAttribute("reviews", reviews);
        return "company/view-reviews";
    }
    @RequestMapping(value = "/jobseeker/company/{companyId}/videos", method = RequestMethod.GET)
    public String viewCompanyVideos(@PathVariable Long companyId, Model model) {
        List<Media> videos = mediaService.getMediaByCompany(companyId);
        model.addAttribute("videos", videos);
        return "jobSeekers/company-videos";
    }

    @InitBinder("job")
    public void initJobBinder(org.springframework.web.bind.WebDataBinder binder) {
        binder.setFieldMarkerPrefix("_");
        binder.registerCustomEditor(Location.class, "location", new java.beans.PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                if (text == null || text.isEmpty()) {
                    setValue(Location.REMOTE);
                } else {
                    try {
                        setValue(Location.valueOf(text.toUpperCase().replace(" ", "_")));
                    } catch (Exception e) {
                        setValue(Location.REMOTE);
                    }
                }
            }
        });
    }

    @RequestMapping(value = "/post-job", method = RequestMethod.POST)
    public String postJob(@ModelAttribute Job job,
                          @RequestParam String salary,
                          @RequestParam String experienceLevel,
                          @RequestParam String jobType,
                          HttpSession session,
                          RedirectAttributes redirectAttributes) {

        Company company = (Company) session.getAttribute("loggedInCompany");
        if (company == null) {
            company = (Company) session.getAttribute("company");
        }
        if (company == null) {
            return "redirect:/company/login";
        }

        job.setCompany(company);
        // Location is auto-converted by InitBinder
        job.setSalary(salary);
        job.setExperienceLevel(experienceLevel);
        job.setJobType(jobType);
        job.setPostedDate(LocalDate.now());
        job.setStatus(JobStatus.OPEN);
        job.setVerified(false);

        jobService.createJob(job);

        redirectAttributes.addFlashAttribute("message", "Job posted successfully!");
        return "redirect:/company/dashboard";
    }
    
    // ================= SPORTS BOOKING METHODS FOR COMPANY =================
    
    // Explore Corporate Events
    @RequestMapping(value = "/sports/explore", method = RequestMethod.GET)
    public String exploreSportsServices(Model model, HttpSession session) {
        Company company = (Company) session.getAttribute("loggedInCompany");
        if (company == null) {
            company = (Company) session.getAttribute("company");
        }
        if (company == null) {
            return "redirect:/company/login";
        }
        
        List<in.sp.main.Entities.SportsService> services = sportsServiceService.findAll();
        model.addAttribute("services", services);
        model.addAttribute("company", company);
        return "company/explore-sports";
    }
    
    // View Service Details
    @RequestMapping(value = "/sports/service/{id}", method = RequestMethod.GET)
    public String viewSportsServiceDetails(@PathVariable Long id, Model model, HttpSession session) {
        Company company = (Company) session.getAttribute("loggedInCompany");
        if (company == null) {
            company = (Company) session.getAttribute("company");
        }
        if (company == null) {
            return "redirect:/company/login";
        }
        
        in.sp.main.Entities.SportsService service = sportsServiceService.getById(id);
        if (service == null) {
            return "redirect:/company/sports/explore";
        }
        model.addAttribute("service", service);
        model.addAttribute("company", company);
        return "company/sports-service-details";
    }
    
    // View Company Bookings
    @RequestMapping(value = "/sports/bookings", method = RequestMethod.GET)
    public String mySportsBookings(Model model, HttpSession session) {
        Company company = (Company) session.getAttribute("loggedInCompany");
        if (company == null) {
            company = (Company) session.getAttribute("company");
        }
        if (company == null) {
            return "redirect:/company/login";
        }
        
        // Get bookings for all recruiters of this company
        List<in.sp.main.Entities.Recruiter> recruiters = recruiterService.getRecruitersByCompany(company.getId());
        List<in.sp.main.Entities.SportsBooking> allBookings = new java.util.ArrayList<>();
        
        for (in.sp.main.Entities.Recruiter recruiter : recruiters) {
            List<in.sp.main.Entities.SportsBooking> recruiterBookings = 
                sportsBookingService.getBookingsForRecruiter(recruiter.getId());
            allBookings.addAll(recruiterBookings);
        }
        
        model.addAttribute("bookings", allBookings);
        model.addAttribute("company", company);
        return "company/my-sports-bookings";
    }
    
    // Confirm Booking after Payment
    @RequestMapping(value = "/sports/booking/confirm", method = RequestMethod.POST)
    public String confirmSportsBooking(
            @RequestParam Long serviceId,
            @RequestParam String razorpayPaymentId,
            @RequestParam String razorpayOrderId,
            @RequestParam String razorpaySignature,
            @RequestParam double amount,
            @RequestParam(required = false) Integer participants,
            @RequestParam(required = false) String eventDate,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        Company company = (Company) session.getAttribute("loggedInCompany");
        if (company == null) {
            company = (Company) session.getAttribute("company");
        }
        if (company == null) {
            return "redirect:/company/login";
        }
        
        // Get first recruiter from company to associate with booking
        List<in.sp.main.Entities.Recruiter> recruiters = recruiterService.getRecruitersByCompany(company.getId());
        if (recruiters.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "No recruiters found for this company. Please add a recruiter first.");
            return "redirect:/company/sports/explore";
        }
        
        in.sp.main.Entities.Recruiter recruiter = recruiters.get(0);

        // Check for existing pending booking
        in.sp.main.Entities.SportsBooking existingBooking = sportsBookingService.findPendingBookingForRecruiterAndService(recruiter.getId(), serviceId);
        
        in.sp.main.Entities.SportsBooking booking;
        
        if (existingBooking != null) {
            // Update existing booking with payment details
            booking = existingBooking;
            booking.setStatus("CONFIRMED");
        } else {
            // Create new booking
            booking = new in.sp.main.Entities.SportsBooking();
            booking.setRecruiter(recruiter);
            booking.setService(sportsServiceService.getById(serviceId));
            booking.setStatus("CONFIRMED");
        }
        
        // Parse event date if provided
        if (eventDate != null && !eventDate.isEmpty()) {
            booking.setEventDate(LocalDate.parse(eventDate));
        } else if (booking.getEventDate() == null) {
            booking.setEventDate(LocalDate.now().plusDays(7));
        }
        
        booking.setFinalPrice(amount);
        booking.setExpectedParticipants(participants != null ? participants : (booking.getExpectedParticipants() != null ? booking.getExpectedParticipants() : 0));

        // Create Payment
        in.sp.main.Entities.Payment payment = new in.sp.main.Entities.Payment();
        payment.setPaymentMode("ONLINE");
        payment.setTransactionId(razorpayPaymentId);
        payment.setAmount(amount);
        payment.setPaymentStatus("SUCCESS");
        payment.setPaymentTime(LocalDateTime.now());

        // Attach payment to booking
        booking.setPayment(payment);

        // Save or update booking
        if (existingBooking != null) {
            sportsBookingService.updateBooking(booking);
        } else {
            sportsBookingService.createBooking(booking);
        }

        redirectAttributes.addFlashAttribute("message", "Booking Confirmed! Booking ID: " + booking.getId());
        return "redirect:/company/sports/bookings";
    }
    
    // Cancel Booking with Refund
    @RequestMapping(value = "/sports/booking/cancel/{bookingId}", method = RequestMethod.POST)
    public String cancelBooking(
            @PathVariable Long bookingId,
            @RequestParam(required = false) String reason,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        Company company = (Company) session.getAttribute("loggedInCompany");
        if (company == null) {
            company = (Company) session.getAttribute("company");
        }
        if (company == null) {
            return "redirect:/company/login";
        }
        
        // Get the booking
        in.sp.main.Entities.SportsBooking booking = sportsBookingService.findById(bookingId);
        if (booking == null) {
            redirectAttributes.addFlashAttribute("error", "Booking not found!");
            return "redirect:/company/sports/bookings";
        }
        
        // Verify the booking belongs to a recruiter of this company
        boolean belongsToCompany = false;
        List<in.sp.main.Entities.Recruiter> recruiters = recruiterService.getRecruitersByCompany(company.getId());
        for (in.sp.main.Entities.Recruiter r : recruiters) {
            if (r.getId().equals(booking.getRecruiter().getId())) {
                belongsToCompany = true;
                break;
            }
        }
        
        if (!belongsToCompany) {
            redirectAttributes.addFlashAttribute("error", "You are not authorized to cancel this booking!");
            return "redirect:/company/sports/bookings";
        }
        
        // Check if booking can be cancelled
        if (!"CONFIRMED".equals(booking.getStatus()) && !"REQUESTED".equals(booking.getStatus())) {
            redirectAttributes.addFlashAttribute("error", "This booking cannot be cancelled. Current status: " + booking.getStatus());
            return "redirect:/company/sports/bookings";
        }
        
        // Process refund if payment exists
        if (booking.getPayment() != null && booking.getPayment().getTransactionId() != null) {
            try {
                in.sp.main.Entities.Refund refund = processRazorpayRefund(
                    booking.getPayment().getTransactionId(), 
                    booking.getFinalPrice(),
                    reason,
                    booking
                );
                
                if (refund != null && "processed".equals(refund.getStatus())) {
                    booking.setStatus("REFUNDED");
                    redirectAttributes.addFlashAttribute("message", 
                        "Booking cancelled and refund processed! Refund ID: " + refund.getRazorpayRefundId() + 
                        ". Amount ₹" + refund.getAmount() + " will be credited within 5-7 business days.");
                } else {
                    booking.setStatus("CANCELLED");
                    redirectAttributes.addFlashAttribute("warning", 
                        "Booking cancelled but refund is " + (refund != null ? refund.getStatus() : "failed") + 
                        ". Refund ID: " + (refund != null ? refund.getRazorpayRefundId() : "N/A") + 
                        ". Please contact support.");
                }
            } catch (Exception e) {
                booking.setStatus("CANCELLED");
                redirectAttributes.addFlashAttribute("warning", "Booking cancelled but refund processing failed: " + e.getMessage());
            }
        } else {
            booking.setStatus("CANCELLED");
            redirectAttributes.addFlashAttribute("message", "Booking cancelled successfully!");
        }
        
        // Set cancellation details
        booking.setCancellationReason(reason);
        booking.setCancelledAt(java.time.LocalDateTime.now());
        
        // Save updated booking
        sportsBookingService.updateBooking(booking);
        
        return "redirect:/company/sports/bookings";
    }
    
    // Helper method to process Razorpay refund and save details
    private in.sp.main.Entities.Refund processRazorpayRefund(String paymentId, double amount, String reason, in.sp.main.Entities.SportsBooking booking) throws Exception {
        String keyId = razorpayKeyId;
        String keySecret = razorpayKeySecret;
        
        if (keyId == null || keyId.isEmpty() || keySecret == null || keySecret.isEmpty()) {
            throw new IllegalStateException("Razorpay credentials not configured");
        }
        
        com.razorpay.RazorpayClient razorpay = new com.razorpay.RazorpayClient(keyId, keySecret);
        
        org.json.JSONObject refundRequest = new org.json.JSONObject();
        // Convert amount to paise
        int amountInPaise = (int) (amount * 100);
        refundRequest.put("amount", amountInPaise);
        refundRequest.put("speed", "normal"); // or "optimum" for instant refund
        
        com.razorpay.Refund razorpayRefund = razorpay.payments.refund(paymentId, refundRequest);
        
        // Save refund details to database
        in.sp.main.Entities.Refund refund = new in.sp.main.Entities.Refund();
        refund.setRazorpayRefundId(razorpayRefund.get("id"));
        refund.setRazorpayPaymentId(paymentId);
        refund.setAmount(amount);
        refund.setStatus(razorpayRefund.get("status"));
        refund.setSpeed(razorpayRefund.has("speed") ? razorpayRefund.get("speed") : "normal");
        refund.setReason(reason);
        refund.setBooking(booking);
        refund.setProcessedAt(java.time.LocalDateTime.now());
        
        return refundService.saveRefund(refund);
    }
    
    // Show upload interview questions page for company
    @RequestMapping(value = "/assessments/uploadpage", method = RequestMethod.GET)
    public String showCompanyUploadPage(@RequestParam("jobId") Long jobId, HttpSession session, Model model) {
        Company company = (Company) session.getAttribute("loggedInCompany");
        
        if (company == null) {
            return "redirect:/company/login";
        }
        
        // Get job details to pre-fill information
        Job job = jobService.getJobById(jobId);
        if (job == null || !job.getCompany().getId().equals(company.getId())) {
            return "redirect:/jobs/by-company/" + company.getId();
        }
        
        model.addAttribute("jobId", jobId);
        model.addAttribute("companyId", company.getId());
        model.addAttribute("jobTitle", job.getTitle());
        
        return "company/upload-interview-questions";
    }
    
    // Show assessment info page
    @RequestMapping(value = "/assessments/info", method = RequestMethod.GET)
    public String showAssessmentInfo(HttpSession session, Model model) {
        Company company = (Company) session.getAttribute("loggedInCompany");
        
        if (company == null) {
            return "redirect:/company/login";
        }
        
        model.addAttribute("companyId", company.getId());
        
        return "company/assessment-info";
    }
    
    // Handle upload for company
    @RequestMapping(value = "/assessments/upload", method = RequestMethod.POST)
    public String uploadCompanyExcel(@RequestParam("file") MultipartFile file,
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
            // Validate company session
            Company company = (Company) session.getAttribute("loggedInCompany");
            if (company == null || !company.getId().equals(companyId)) {
                model.addAttribute("message", "Error: Unauthorized access. Please login.");
                model.addAttribute("companyId", companyId);
                return "company/upload-result";
            }
            
            // Validate file
            if (file == null || file.isEmpty()) {
                model.addAttribute("message", "Error: Please select a file to upload");
                model.addAttribute("companyId", companyId);
                return "company/upload-result";
            }
            
            // Check file type
            String fileName = file.getOriginalFilename();
            if (fileName == null || !fileName.endsWith(".xlsx")) {
                model.addAttribute("message", "Error: Only .xlsx files are supported");
                model.addAttribute("companyId", companyId);
                return "company/upload-result";
            }
            
            // Delete existing questions if replace is checked
            if (replace) {
                assessmentService.deleteBySkill(skill);
            }
            
            // Delete existing invitations if replaceInvitations is checked
            if (replaceInvitations) {
                List<in.sp.main.Entities.AssessmentInvitation> existingInvites = 
                    assessmentInvitationRepo.findByJobIdAndSkill(jobId, skill);
                if (!existingInvites.isEmpty()) {
                    System.out.println("Deleting " + existingInvites.size() + " existing invitations...");
                    assessmentInvitationRepo.deleteAll(existingInvites);
                }
            }
            
            // Parse Excel and save questions
            java.util.List<AssessmentQuestion> questions = ExcelHelper.convertExcelToList(file.getInputStream(), skill);
            
            if (questions.isEmpty()) {
                model.addAttribute("message", "Error: No valid questions found in the file. Please check the format.");
                model.addAttribute("companyId", companyId);
                return "company/upload-result";
            }
            
            // Set source type, job ID and recruiter ID for each question
            for (AssessmentQuestion q : questions) {
                q.setSourceType("RECRUITER");
                q.setJobId(jobId);
                q.setRecruiterId(company.getId());
            }
            
            assessmentService.saveAll(questions);
            
            // AUTO-CREATE ASSESSMENT INVITATIONS for ALL job seekers (EVERY TIME)
            try {
                // Get ALL job seekers from the database
                List<in.sp.main.Entities.JobSeeker> allJobSeekers = jobSeekerRepository.findAll();
                
                System.out.println("=== ASSESSMENT INVITATION DEBUG ===");
                System.out.println("Total job seekers in database: " + allJobSeekers.size());
                System.out.println("Job ID: " + jobId);
                System.out.println("Skill: " + skill);
                System.out.println("Company ID: " + company.getId());
                
                int invitationsCreated = 0;
                
                // Create invitation for EVERY job seeker (no duplicate check)
                for (in.sp.main.Entities.JobSeeker jobSeeker : allJobSeekers) {
                    // Create new invitation every time
                    in.sp.main.Entities.AssessmentInvitation invite = new in.sp.main.Entities.AssessmentInvitation();
                    invite.setJobSeekerId(jobSeeker.getId());
                    invite.setJobId(jobId);
                    invite.setRecruiterId(company.getId());
                    invite.setSkill(skill);
                    invite.setType("JOB");
                    invite.setStatus("SENT");
                    invite.setSentAt(java.time.LocalDateTime.now());
                    assessmentInvitationRepo.save(invite);
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
        return "company/upload-result";
    }
}
