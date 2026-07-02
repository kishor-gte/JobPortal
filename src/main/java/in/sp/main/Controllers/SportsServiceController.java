package in.sp.main.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import in.sp.main.Entities.SportsOrganizer;
import in.sp.main.Entities.SportsService;
import in.sp.main.Services.SportsServiceService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/organizer/service")
public class SportsServiceController {

    @Autowired
    private SportsServiceService serviceService;

    @Autowired
    private in.sp.main.Services.UploadService uploadService;

    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String addService(Model model) {
        model.addAttribute("service", new SportsService());
        return "sports/add-sports-service";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String saveService(@ModelAttribute SportsService service,
            @RequestParam("coverImage") org.springframework.web.multipart.MultipartFile coverImage,
            @RequestParam("galleryImages") org.springframework.web.multipart.MultipartFile[] galleryImages,
            HttpSession session) throws java.io.IOException {
        SportsOrganizer organizer = (SportsOrganizer) session.getAttribute("loggedOrganizer");
       // service.setOrganizer(organizer);

        // Handle Cover Image
        if (!coverImage.isEmpty()) {
            String coverPath = uploadService.uploadFile(coverImage);
            service.setCoverImageUrl(coverPath);
        }

        // Handle Gallery Images
        java.util.List<String> galleryPaths = new java.util.ArrayList<>();
        if (galleryImages != null && galleryImages.length > 0) {
            for (org.springframework.web.multipart.MultipartFile file : galleryImages) {
                String path = uploadService.uploadFile(file);
                if (path != null) {
                    galleryPaths.add(path);
                }
            }
        }
        service.setGalleryImageUrls(galleryPaths);

        serviceService.save(service);
        return "redirect:/organizer/dashboard";
    }

    // VIEW SERVICE DETAILS
    @RequestMapping(value = "/view/{id}", method = RequestMethod.GET)
    public String viewService(@PathVariable Long id, Model model) {
        model.addAttribute("service", serviceService.getById(id));
        return "sports/view-sports-service";
    }

    // EDIT PAGE
    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String editService(@PathVariable Long id, Model model) {
        model.addAttribute("service", serviceService.getById(id));
        return "sports/edit-sports-service";
    }

    // UPDATE SERVICE
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String updateService(@ModelAttribute SportsService service,
            @RequestParam(value = "coverImage", required = false) org.springframework.web.multipart.MultipartFile coverImage,
            @RequestParam(value = "galleryImages", required = false) org.springframework.web.multipart.MultipartFile[] galleryImages,
            HttpSession session) throws java.io.IOException {

        SportsOrganizer organizer = (SportsOrganizer) session.getAttribute("loggedOrganizer");

        // Fetch existing logic could be improved to not overwrite existing images if
        // null
        // But for simplicity, we rely on serviceService.save merging or we re-fetch
        SportsService existingService = serviceService.getById(service.getId());

        // Preserve Organizer
     //   service.setOrganizer(organizer);

        // Preserve Images if new ones not uploaded, or simple update logic:
        if (coverImage != null && !coverImage.isEmpty()) {
            String coverPath = uploadService.uploadFile(coverImage);
            service.setCoverImageUrl(coverPath);
        } else {
            service.setCoverImageUrl(existingService.getCoverImageUrl());
        }

        java.util.List<String> galleryPaths = new java.util.ArrayList<>();
        if (galleryImages != null && galleryImages.length > 0 && !galleryImages[0].isEmpty()) {
            for (org.springframework.web.multipart.MultipartFile file : galleryImages) {
                String path = uploadService.uploadFile(file);
                if (path != null) {
                    galleryPaths.add(path);
                }
            }
            service.setGalleryImageUrls(galleryPaths);
        } else {
            service.setGalleryImageUrls(existingService.getGalleryImageUrls());
        }

        serviceService.save(service);

        return "redirect:/organizer/dashboard";
    }

    // DELETE SERVICE
    @RequestMapping(value = "/delete/{id}", method = RequestMethod.GET)
    public String deleteService(@PathVariable Long id) {
        serviceService.delete(id);
        return "redirect:/organizer/dashboard";
    }

}
