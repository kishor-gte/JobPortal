package in.sp.main.Interceptors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.Subscriber;
import in.sp.main.Repositories.SubscriberRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class PremiumFeatureInterceptor implements HandlerInterceptor {

    @Autowired
    private SubscriberRepository subscriberRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        if (session != null) {
            JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
            if (jobSeeker != null) {
                Subscriber subscriber = subscriberRepository.findByEmail(jobSeeker.getEmail());
                if (subscriber != null && "ACTIVE".equals(subscriber.getStatus())) {
                    return true; // Authorized
                }
            }
        }
        
        // Not authorized, redirect to dashboard with message
        response.sendRedirect(request.getContextPath() + "/jobSeekers/profile?message=Premium%20subscription%20required%20to%20access%20this%20feature.");
        return false;
    }
}
