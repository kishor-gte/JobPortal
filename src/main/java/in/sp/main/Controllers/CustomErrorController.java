package in.sp.main.Controllers;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CustomErrorController implements ErrorController {

    @RequestMapping("/error")
    public String handleError(HttpServletRequest request, Model model) {
        Object status = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        
        if (status != null) {
            Integer statusCode = Integer.valueOf(status.toString());
            
            if (statusCode == HttpStatus.NOT_FOUND.value()) {
                // 404 error
                model.addAttribute("errorCode", "404");
                model.addAttribute("errorTitle", "Page Not Found");
                model.addAttribute("errorMessage", "The page you're looking for doesn't exist or has been moved.");
                model.addAttribute("errorDescription", "Please check the URL or navigate back to the homepage.");
                return "error/error-404";
            } else if (statusCode == HttpStatus.INTERNAL_SERVER_ERROR.value()) {
                // 500 error
                model.addAttribute("errorCode", "500");
                model.addAttribute("errorTitle", "Internal Server Error");
                model.addAttribute("errorMessage", "Something went wrong on our end.");
                model.addAttribute("errorDescription", "We're working to fix the issue. Please try again later.");
                return "error/error";
            } else if (statusCode == HttpStatus.FORBIDDEN.value()) {
                // 403 error
                model.addAttribute("errorCode", "403");
                model.addAttribute("errorTitle", "Access Denied");
                model.addAttribute("errorMessage", "You don't have permission to access this resource.");
                model.addAttribute("errorDescription", "Please contact your administrator if you believe this is a mistake.");
                return "error/error";
            } else if (statusCode == HttpStatus.UNAUTHORIZED.value()) {
                // 401 error
                model.addAttribute("errorCode", "401");
                model.addAttribute("errorTitle", "Unauthorized");
                model.addAttribute("errorMessage", "You need to be logged in to access this page.");
                model.addAttribute("errorDescription", "Please log in with your credentials to continue.");
                return "error/error";
            }
        }
        
        // Generic error
        model.addAttribute("errorCode", "Error");
        model.addAttribute("errorTitle", "Something Went Wrong");
        model.addAttribute("errorMessage", "An unexpected error occurred.");
        model.addAttribute("errorDescription", "Please try again or contact support if the problem persists.");
        return "error/error";
    }
}
