package in.sp.main.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import in.sp.main.Services.PasswordResetService;

@Controller
public class ForgotPasswordController {

    @Autowired private PasswordResetService passwordResetService;

    @RequestMapping(value = "/admin/forgot-password", method = RequestMethod.GET)
    public String showAdminForgotPassword(Model model) {
        model.addAttribute("role", "admin");
        model.addAttribute("actionUrl", "/admin/forgot-password");
        return "admin/forgotPassword";
    }

    @RequestMapping(value = "/admin/forgot-password", method = RequestMethod.POST)
    public String adminForgotPassword(@RequestParam String email, Model model) {
        return processForgotPassword(email, "admin", "/admin/forgot-password", model, "admin/forgotPassword");
    }

    @RequestMapping(value = "/recruiter/forgot-password", method = RequestMethod.GET)
    public String showRecruiterForgotPassword(Model model) {
        model.addAttribute("role", "recruiter");
        model.addAttribute("actionUrl", "/recruiter/forgot-password");
        return "recruiter/forgotPassword";
    }

    @RequestMapping(value = "/recruiter/forgot-password", method = RequestMethod.POST)
    public String recruiterForgotPassword(@RequestParam String email, Model model) {
        return processForgotPassword(email, "recruiter", "/recruiter/forgot-password", model, "recruiter/forgotPassword");
    }

    @RequestMapping(value = "/techperson/forgot-password", method = RequestMethod.GET)
    public String showTechpersonForgotPassword(Model model) {
        model.addAttribute("role", "techperson");
        model.addAttribute("actionUrl", "/techperson/forgot-password");
        return "techperson/forgotPassword";
    }

    @RequestMapping(value = "/techperson/forgot-password", method = RequestMethod.POST)
    public String techpersonForgotPassword(@RequestParam String email, Model model) {
        return processForgotPassword(email, "techperson", "/techperson/forgot-password", model, "techperson/forgotPassword");
    }

    @RequestMapping(value = "/company/forgot-password", method = RequestMethod.GET)
    public String showCompanyForgotPassword(Model model) {
        model.addAttribute("role", "company");
        model.addAttribute("actionUrl", "/company/forgot-password");
        return "company/forgotPassword";
    }

    @RequestMapping(value = "/company/forgot-password", method = RequestMethod.POST)
    public String companyForgotPassword(@RequestParam String email, Model model) {
        return processForgotPassword(email, "company", "/company/forgot-password", model, "company/forgotPassword");
    }

    @RequestMapping(value = "/user/forgot-password", method = RequestMethod.GET)
    public String showUserForgotPassword(Model model) {
        model.addAttribute("role", "jobseeker");
        model.addAttribute("actionUrl", "/user/forgot-password");
        return "jobSeekers/forgotPassword";
    }

    @RequestMapping(value = "/user/forgot-password", method = RequestMethod.POST)
    public String userForgotPassword(@RequestParam String email, Model model) {
        return processForgotPassword(email, "jobseeker", "/user/forgot-password", model, "jobSeekers/forgotPassword");
    }

    private String processForgotPassword(String email, String role, String actionUrl, Model model, String viewName) {
        String response = passwordResetService.createPasswordResetToken(email, role);
        if (response.startsWith("Failed") || response.equals("Email not found")) {
            model.addAttribute("error", response);
        } else {
            model.addAttribute("message", response);
        }
        model.addAttribute("role", role);
        model.addAttribute("actionUrl", actionUrl);
        return viewName;
    }
}
