package in.sp.main.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import in.sp.main.Entities.Recruiter;
import in.sp.main.Entities.SportsBooking;
import in.sp.main.Services.SportsBookingService;
import in.sp.main.Services.SportsOrganizerService;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/recruiter/sports")
public class RecruiterSportsController {

    @Autowired
    private SportsOrganizerService organizerService;

    @Autowired
    private SportsBookingService bookingService;

    @RequestMapping(value = "/organizers", method = RequestMethod.GET)
    public String viewOrganizers(Model model) {
        model.addAttribute("organizers", organizerService.getVerifiedOrganizers());
        return "recruiter-organizers";
    }

    @RequestMapping(value = "/book/{serviceId}", method = RequestMethod.GET)
    public String bookService(@PathVariable Long serviceId, Model model) {
        model.addAttribute("booking", new SportsBooking());
        model.addAttribute("serviceId", serviceId);
        return "book-sports-service";
    }

    @RequestMapping(value = "/book", method = RequestMethod.POST)
    public String confirmBooking(@ModelAttribute SportsBooking booking,
                                 HttpSession session) {
        Recruiter recruiter = (Recruiter) session.getAttribute("loggedRecruiter");
        booking.setRecruiter(recruiter);
        bookingService.createBooking(booking);
        return "redirect:/recruiter/dashboard";
    }
}
