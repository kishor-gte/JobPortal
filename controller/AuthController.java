package com.example.demo.controller;

import com.example.demo.dao.UserDAO;
import com.example.demo.model.User;
import com.example.demo.service.EmailService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private EmailService emailService;

    @GetMapping("/")
    public String home(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user != null) {
            return redirectToDashboard(user.getRole());
        }
        return "index";
    }

    @GetMapping("/login")
    public String loginPage(HttpSession session) {
        User user = (User) session.getAttribute("loggedInUser");
        if (user != null) {
            return redirectToDashboard(user.getRole());
        }
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String email, @RequestParam String password,
            HttpSession session, RedirectAttributes redirectAttributes) {
        User user = userDAO.authenticateByEmail(email, password);
        if (user != null) {
            session.setAttribute("loggedInUser", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("userRole", user.getRole());
            return redirectToDashboard(user.getRole());
        }
        redirectAttributes.addFlashAttribute("error", "Invalid email or password!");
        return "redirect:/login";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String password,
            @RequestParam String email, @RequestParam String fullName,
            @RequestParam String role, @RequestParam(required = false) String phone,
            HttpSession session, RedirectAttributes redirectAttributes) {
        // Check if email exists
        if (userDAO.findByEmail(email) != null) {
            redirectAttributes.addFlashAttribute("error", "Email already registered!");
            return "redirect:/register";
        }

        // Store registration data in session for OTP verification
        session.setAttribute("regEmail", email);
        session.setAttribute("regPassword", password);
        session.setAttribute("regFullName", fullName);
        session.setAttribute("regRole", role);
        session.setAttribute("regPhone", phone);

        // Send OTP to email
        boolean sent = emailService.sendOTP(email, fullName);
        if (!sent) {
            redirectAttributes.addFlashAttribute("error", "Failed to send OTP. Please try again.");
            return "redirect:/register";
        }

        redirectAttributes.addFlashAttribute("success", "OTP sent to " + email + ". Please verify.");
        return "redirect:/verify-otp";
    }

    @GetMapping("/verify-otp")
    public String verifyOtpPage(HttpSession session, Model model) {
        String email = (String) session.getAttribute("regEmail");
        if (email == null) {
            return "redirect:/register";
        }
        model.addAttribute("email", email);
        return "verify-otp";
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam String otp,
            HttpSession session, RedirectAttributes redirectAttributes) {
        String email = (String) session.getAttribute("regEmail");
        String password = (String) session.getAttribute("regPassword");
        String fullName = (String) session.getAttribute("regFullName");
        String role = (String) session.getAttribute("regRole");
        String phone = (String) session.getAttribute("regPhone");

        if (email == null) {
            redirectAttributes.addFlashAttribute("error", "Session expired. Please register again.");
            return "redirect:/register";
        }

        if (!emailService.verifyOTP(email, otp)) {
            redirectAttributes.addFlashAttribute("error", "Invalid or expired OTP. Please try again.");
            redirectAttributes.addFlashAttribute("email", email);
            return "redirect:/verify-otp";
        }

        // OTP verified — create the user (use email as username)
        User user = new User(email, password, email, fullName, role);
        user.setPhone(phone);
        userDAO.save(user);

        // Clear registration data from session
        session.removeAttribute("regEmail");
        session.removeAttribute("regPassword");
        session.removeAttribute("regFullName");
        session.removeAttribute("regRole");
        session.removeAttribute("regPhone");

        redirectAttributes.addFlashAttribute("success", "Registration successful! Please login.");
        return "redirect:/login";
    }

    @PostMapping("/resend-otp")
    public String resendOtp(HttpSession session, RedirectAttributes redirectAttributes) {
        String email = (String) session.getAttribute("regEmail");
        String fullName = (String) session.getAttribute("regFullName");

        if (email == null) {
            redirectAttributes.addFlashAttribute("error", "Session expired. Please register again.");
            return "redirect:/register";
        }

        boolean sent = emailService.sendOTP(email, fullName);
        if (sent) {
            redirectAttributes.addFlashAttribute("success", "OTP resent to " + email);
        } else {
            redirectAttributes.addFlashAttribute("error", "Failed to resend OTP. Please try again.");
        }
        return "redirect:/verify-otp";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    private String redirectToDashboard(String role) {
        switch (role) {
            case "ADMIN":
                return "redirect:/admin/dashboard";
            case "INTERVIEWER":
                return "redirect:/interviewer/dashboard";
            case "STUDENT":
                return "redirect:/student/dashboard";
            case "COMPANY":
                return "redirect:/company/dashboard";
            default:
                return "redirect:/login";
        }
    }
}
