package in.sp.main.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import jakarta.servlet.http.HttpSession;

@Controller
public class SessionController {

    @RequestMapping(value = "/session-expired", method = RequestMethod.GET)
    public String handleSessionExpired(HttpSession session) {
        String userType = (String) session.getAttribute("userType");

        if ("ADMIN".equals(userType)) return "redirect:/loginAdmin";
        else if ("RECRUITER".equals(userType)) return "redirect:/recruiter/login";
        else if ("COMPANY".equals(userType)) return "redirect:/company/login";
        else if ("JOBSEEKER".equals(userType)) return "redirect:/jobSeekers/login";
        else return "redirect:/"; // fallback default
    }
}
