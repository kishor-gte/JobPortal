package in.sp.main.Controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.Recruiter;
import in.sp.main.Entities.SportsService;
import in.sp.main.Enums.ServiceStatus;
import in.sp.main.Repositories.RecruiterRepository;
import in.sp.main.Repositories.SportsOrganizerRepository;
import in.sp.main.Repositories.SportsServiceRepository;
import in.sp.main.Services.EmailService;
import in.sp.main.Services.FileUploadServicessports;
import in.sp.main.Services.SportsServiceService;

@Controller
@RequestMapping("/admin/sports/service")
public class AdminSportsServiceController {

    @Autowired
    private SportsServiceService serviceService;

    @Autowired
    private SportsServiceRepository sportsServiceRepo;
    
    @Autowired
    private SportsOrganizerRepository organizerRepo;

    @Autowired
    private FileUploadServicessports uploadService;
    
    @Autowired
    private RecruiterRepository recruiterRepo;
    
    @Autowired
    private EmailService emailService;
    
    @Value("${app.base-url:http://localhost:8081}")
    private String baseUrl;
    
    @Autowired
    private in.sp.main.Services.SportsBookingService sportsBookingService;

    // SHOW ADD SERVICE PAGE
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addServicePage(org.springframework.ui.Model model) {
        model.addAttribute("service", new SportsService());
        model.addAttribute("organizers", organizerRepo.findByVerifiedTrue());
        return "admin/sports-service-add";
    }

    // SAVE SERVICE (ADMIN ONLY)
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addService(
            @ModelAttribute("service") SportsService service,
            BindingResult result,
            Model model,
            @RequestParam(required = false) String customSportType,
            @RequestParam(required = false) String customPricingUnit,
            @RequestParam("coverImage") MultipartFile coverImage,
            @RequestParam(value = "galleryImages", required = false) MultipartFile[] galleryImages
    ) throws IOException {

        /* ========= REQUIRED FIELD VALIDATION ========= */
        if (service.getServiceTitle() == null || service.getServiceTitle().trim().isEmpty()) {
            result.rejectValue("serviceTitle", "error.serviceTitle", "Service title is required");
        }

        if (service.getSportType() == null || service.getSportType().trim().isEmpty()) {
            result.rejectValue("sportType", "error.sportType", "Sport type is required");
        }
        
        if (coverImage == null || coverImage.isEmpty()) {
             // Cover image is required
             // We can't easily add error to a MultipartFile field in BindingResult unless we map it, 
             // but we can add a global error or check before.
             // However, HTML has 'required' attribute. 
        }

        /* ========= VALIDATION ERRORS ========= */
        if (result.hasErrors()) {
            model.addAttribute("organizers", organizerRepo.findByVerifiedTrue());
            return "admin/sports-service-add";
        }

        /* ========= SPORT TYPE ========= */
        if ("OTHER".equalsIgnoreCase(service.getSportType())) {
            service.setSportType(customSportType);
        }

        /* ========= PRICING UNIT ========= */
        if ("OTHER".equalsIgnoreCase(service.getPricingUnit())) {
            service.setPricingUnit(customPricingUnit);
        }

        if (service.getPricingUnit() == null || service.getPricingUnit().isBlank()) {
            service.setPricingUnit("PER_MATCH");
        }

        /* ========= STATUS ========= */
        service.setStatus(ServiceStatus.ACTIVE);

        /* ========= COVER IMAGE ========= */
        if (coverImage != null && !coverImage.isEmpty()) {
            service.setCoverImageUrl(uploadService.saveFile(coverImage));
        }

        /* ========= GALLERY IMAGES ========= */
        List<String> gallery = new ArrayList<>();
        if (galleryImages != null) {
            for (MultipartFile img : galleryImages) {
                if (img != null && !img.isEmpty()) {
                    gallery.add(uploadService.saveFile(img));
                }
            }
        }
        service.setGalleryImageUrls(gallery);

        /* ========= SAVE ========= */
        sportsServiceRepo.save(service);
        
        // Notify all recruiters asynchronously using @Async
        notifyRecruitersAboutNewService(service);

        return "redirect:/admin/sports/service/list";
    }
    
    @org.springframework.scheduling.annotation.Async("emailTaskExecutor")
    public void notifyRecruitersAboutNewService(SportsService service) {
        try {
            List<Recruiter> recruiters = recruiterRepo.findAll();
            for (Recruiter r : recruiters) {
                if (r.getEmail() != null && !r.getEmail().isEmpty()) {
                    String subject = "New Sports Event Available: " + service.getServiceTitle();
                    String text = "Hello " + r.getName() + ",\n\n"
                            + "A new sports service has been added: " + service.getServiceTitle() + ".\n"
                            + "Sport Type: " + service.getSportType() + "\n"
                            + "Pricing: " + service.getPricingUnit() + "\n\n"
                            + "You can view and book the service here: " + baseUrl + "/recruiter/service/" + service.getId() + "\n\n"
                            + "Best regards,\nJobu Team";
                    
                    emailService.sendEmail(r.getEmail(), subject, text);
                }
            }
        } catch (Exception e) {
            // Log error but don't fail the request
            System.err.println("Failed to send notification emails: " + e.getMessage());
        }
    }


    /* ================= LIST ALL SERVICES ================= */
    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String listServices(Model model) {
        model.addAttribute("services", serviceService.findAll());
        return "admin/manage-sports-services";
    }

    /* ================= VIEW SERVICE ================= */
    @RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
    public String viewService(@PathVariable Long id, Model model) {
        model.addAttribute("service", serviceService.getById(id));
        return "admin/view-sports-service";
    }

    /* ================= EDIT SERVICE ================= */
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String editService(@PathVariable Long id, Model model) {
        model.addAttribute("service", serviceService.getById(id));
        return "admin/edit-sports-service";
    }

    /* ================= UPDATE SERVICE ================= */
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String update(
            @ModelAttribute("service") SportsService service,
            BindingResult result,
            Model model,
            @RequestParam(required = false) MultipartFile coverImage,
            @RequestParam(required = false) MultipartFile[] galleryImages
    ) throws IOException {

        /* ========= VALIDATION ERRORS ========= */
        if (result.hasErrors()) {
            return "admin/edit-sports-service";
        }

        SportsService existing = serviceService.getById(service.getId());

        /* ================= COVER IMAGE ================= */
        if (coverImage != null && !coverImage.isEmpty()) {
            service.setCoverImageUrl(uploadService.saveFile(coverImage));
        } else {
            service.setCoverImageUrl(existing.getCoverImageUrl());
        }

        /* ================= GALLERY IMAGES (APPEND) ================= */
        List<String> finalGallery = new ArrayList<>();

        // keep existing images
        if (existing.getGalleryImageUrls() != null) {
            finalGallery.addAll(existing.getGalleryImageUrls());
        }

        // add newly uploaded images
        if (galleryImages != null) {
            for (MultipartFile f : galleryImages) {
                if (f != null && !f.isEmpty()) {
                    finalGallery.add(uploadService.saveFile(f));
                }
            }
        }

        service.setGalleryImageUrls(finalGallery);

        /* ================= SAVE ================= */
        serviceService.save(service);
        
        // Notify all recruiters asynchronously about the update
        notifyRecruitersAboutUpdate(service);

        return "redirect:/admin/sports/service/list";
    }
    
    @org.springframework.scheduling.annotation.Async("emailTaskExecutor")
    public void notifyRecruitersAboutUpdate(SportsService service) {
        try {
            List<Recruiter> recruiters = recruiterRepo.findAll();
            for (Recruiter r : recruiters) {
                if (r.getEmail() != null && !r.getEmail().isEmpty()) {
                    String subject = "Sports Event Updated: " + service.getServiceTitle();
                    String text = "Hello " + r.getName() + ",\n\n"
                            + "The sports service has been updated: " + service.getServiceTitle() + ".\n"
                            + "Sport Type: " + service.getSportType() + "\n"
                            + "Pricing: " + service.getPricingUnit() + "\n\n"
                            + "You can view the updated service here: " + baseUrl + "/recruiter/service/" + service.getId() + "\n\n"
                            + "Best regards,\nJobu Team";
                    
                    emailService.sendEmail(r.getEmail(), subject, text);
                }
            }
        } catch (Exception e) {
            System.err.println("Failed to send update notification emails: " + e.getMessage());
        }
    }

    /* ================= DELETE SERVICE ================= */
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String deleteService(@PathVariable Long id) {
        serviceService.delete(id);
        return "redirect:/admin/sports/service/list";
    }

    @RequestMapping(value = "/image/delete", method = RequestMethod.GET)
    public String deleteGalleryImage(@RequestParam Long serviceId,
                                     @RequestParam String imageUrl) {

        SportsService service = serviceService.getById(serviceId);

        if (service != null && service.getGalleryImageUrls() != null) {
            service.getGalleryImageUrls().remove(imageUrl);
            serviceService.save(service);
        }

        return "redirect:/admin/sports/service/edit/" + serviceId;
    }
    
}
