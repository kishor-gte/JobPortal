package in.sp.main.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import in.sp.main.Entities.SportsOrganizer;
import in.sp.main.Services.SportsOrganizerService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/organizer")
public class SportsOrganizerController {

    @Autowired
    private SportsOrganizerService organizerService;

    /* ===================== REGISTER ===================== */

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String registerPage(Model model) {
        model.addAttribute("organizer", new SportsOrganizer());
        return "sports/organizer-register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(
            @ModelAttribute SportsOrganizer organizer,
            @RequestParam(value = "documentFiles", required = false) MultipartFile[] documentFiles,
            @RequestParam(value = "eventPhotoFiles", required = false) MultipartFile[] eventPhotoFiles
    ) throws Exception {

    	 organizerService.saveOrganizerWithProofs(
    		        organizer, documentFiles, eventPhotoFiles
    		    );
        return "redirect:/organizer/login";
    }

    /* ===================== LOGIN ===================== */

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginPage() {
        return "sports/organizer-login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam String email,
                        @RequestParam String password,
                        HttpSession session,
                        Model model) {

        SportsOrganizer organizer = organizerService.login(email, password);

        if (organizer == null) {
            model.addAttribute("error", "Invalid email or password");
            return "sports/organizer-login";
        }

        session.setAttribute("loggedOrganizer", organizer);

        // 🔐 Redirect based on verification status
        if (!organizer.isVerified()) {
            return "redirect:/organizer/pending-verification";
        }

        return "redirect:/organizer/dashboard";
    }

    /* ===================== PENDING VERIFICATION ===================== */

    @RequestMapping(value = "/pending-verification", method = RequestMethod.GET)
    public String pendingVerification(HttpSession session) {

        SportsOrganizer organizer =
            (SportsOrganizer) session.getAttribute("loggedOrganizer");

        if (organizer == null) {
            return "redirect:/organizer/login";
        }

        if (organizer.isVerified()) {
            return "redirect:/organizer/dashboard";
        }

        return "sports/organizer-pending";
    }

    /* ===================== DASHBOARD ===================== */

    @RequestMapping(value = "/dashboard", method = RequestMethod.GET)
    public String dashboard(HttpSession session, Model model) {

        SportsOrganizer organizer =
            (SportsOrganizer) session.getAttribute("loggedOrganizer");

        if (organizer == null) {
            return "redirect:/organizer/login";
        }

        if (!organizer.isVerified()) {
            return "redirect:/organizer/pending-verification";
        }

		/*
		 * model.addAttribute( "services",
		 * organizerService.getServices(organizer.getId()) );
		 */

        return "sports/organizer-dashboard";
    }

    /* ===================== MANAGE SERVICES ===================== */

    @RequestMapping(value = "/services", method = RequestMethod.GET)
    public String manageServices(HttpSession session, Model model) {

        SportsOrganizer organizer =
            (SportsOrganizer) session.getAttribute("loggedOrganizer");

        if (organizer == null) {
            return "redirect:/organizer/login";
        }

        if (!organizer.isVerified()) {
            return "redirect:/organizer/pending-verification";
        }

		/*
		 * model.addAttribute( "services",
		 * organizerService.getServices(organizer.getId()) );
		 */

        return "sports/manage-services";
    }

    /* ===================== LOGOUT ===================== */

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/organizer/login";
    }
}
