package in.sp.main.Controllers;

import in.sp.main.Entities.TechPerson;
import in.sp.main.Services.TechPersonServices;
import in.sp.main.Configuration.JwtUtil;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/tech")
public class TechAuthController {

    @Autowired
    private TechPersonServices techPersonServices;

    @Autowired
    private JwtUtil jwtUtil;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String showLoginForm() {
        return "techperson/loginTechPerson";
    }

    @RequestMapping(value = "/login1", method = RequestMethod.POST)
    public String loginTechPerson(@RequestParam String email,
            @RequestParam String password,
            Model model,
            HttpServletResponse response,
            HttpSession session) {

        TechPerson techPerson = techPersonServices.authenticateTechPerson(email, password);

        if (techPerson != null) {
            String token = jwtUtil.generateToken(String.valueOf(techPerson.getId()), "TECHPERSON");
            Cookie cookie = jwtUtil.createJwtCookie(token);
            response.addCookie(cookie);

            session.setAttribute("loggedInTechPerson", techPerson);
            session.setAttribute("userType", "TECHPERSON");
            session.setAttribute("techPersonId", techPerson.getId());
            return "redirect:/tech/dashboard";
        } else {
            model.addAttribute("error", "Invalid credentials");
            return "techperson/loginTechPerson";
        }
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutTechPerson(HttpSession session, HttpServletResponse response) {
        session.invalidate();
        Cookie cookie = jwtUtil.createClearJwtCookie();
        response.addCookie(cookie);
        return "redirect:/tech/login";
    }
}
