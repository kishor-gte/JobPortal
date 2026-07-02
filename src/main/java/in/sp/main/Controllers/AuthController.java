package in.sp.main.Controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import in.sp.main.Services.PasswordResetService;

@Controller
@RequestMapping("/auth")
public class AuthController {

    @Autowired private PasswordResetService passwordResetService;
  
    
    @RequestMapping(value = "/forgot-password", method = RequestMethod.GET)
    public String showForgotPasswordPage(@RequestParam(required = false) String role, Model model) {
        model.addAttribute("role", role);
        return "password/forgotPassword"; // Return your JSP or HTML page
    }
    @RequestMapping(value = "/forgot-password1", method = RequestMethod.POST)
    public String forgotPassword(@RequestParam String email, @RequestParam(required = false) String role, Model model) {
        String response = passwordResetService.createPasswordResetToken(email);
        model.addAttribute("message", response);
        model.addAttribute("role", role);
        return "password/forgotPassword";
    }

    @RequestMapping(value = "/reset-password", method = RequestMethod.GET)
    public String showResetPasswordPage(@RequestParam String token, @RequestParam String type, Model model) {
        model.addAttribute("token", token);
        model.addAttribute("userType", type);
        return "password/resetPassword";
    }

    @RequestMapping(value = "/reset-password1", method = RequestMethod.POST)
    public String resetPassword(@RequestParam String token, @RequestParam String newPassword, Model model) {
        String response = passwordResetService.resetPassword(token, newPassword);
        model.addAttribute("message", response);
        return "password/resetPassword";
    }
}
