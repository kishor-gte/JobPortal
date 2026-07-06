package in.sp.main.utils;

import in.sp.main.Enums.ActivityType;
import in.sp.main.Services.UserActivityService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;



@Component
public class ActivityLogger {

    @Autowired
    private UserActivityService userActivityService;

    /**
     * Logs an activity by extracting request information automatically.
     */
    public void log(Long userId, String userName, String userEmail, String role, ActivityType type, String description) {
        logFull(userId, userName, userEmail, role, type, description, null, null, null);
    }

    /**
     * Logs an activity with optional Job, Company, and Recruiter IDs.
     */
    public void log(Long userId, String userName, String userEmail, String role, ActivityType type, String description, Long jobId, Long companyId, Long recruiterId) {
        logFull(userId, userName, userEmail, role, type, description, jobId, companyId, recruiterId);
    }

    private void logFull(Long userId, String userName, String userEmail, String role, ActivityType type, String description, Long jobId, Long companyId, Long recruiterId) {
        try {
            ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
            if (attributes != null) {
                HttpServletRequest request = attributes.getRequest();
                
                String requestUrl = request.getRequestURI();
                String httpMethod = request.getMethod();
                String ipAddress = getClientIp(request);
                
                String userAgentString = request.getHeader("User-Agent");
                String browser = "Unknown";
                String os = "Unknown";
                String device = "Unknown";
                
                if (userAgentString != null) {
                    try {
                        // Very simple fallback if eu.bitwalker is not present, otherwise use it
                        browser = parseBrowser(userAgentString);
                        os = parseOS(userAgentString);
                        device = parseDevice(userAgentString);
                    } catch(Exception e) {
                        browser = userAgentString.length() > 50 ? userAgentString.substring(0, 50) : userAgentString;
                    }
                }
                
                HttpSession session = request.getSession(false);
                String sessionId = session != null ? session.getId() : null;

                userActivityService.saveLogAsync(userId, userName, userEmail, role, type, description, jobId, companyId, recruiterId, 
                                                 requestUrl, httpMethod, ipAddress, browser, os, device, sessionId);
            } else {
                // Background task or non-HTTP context
                userActivityService.saveLogAsync(userId, userName, userEmail, role, type, description, jobId, companyId, recruiterId, 
                                                 null, null, null, null, null, null, null);
            }
        } catch (Exception e) {
            System.err.println("Error in ActivityLogger: " + e.getMessage());
        }
    }

    private String getClientIp(HttpServletRequest request) {
        String remoteAddr = "";
        if (request != null) {
            remoteAddr = request.getHeader("X-FORWARDED-FOR");
            if (remoteAddr == null || "".equals(remoteAddr)) {
                remoteAddr = request.getRemoteAddr();
            }
        }
        return remoteAddr;
    }

    private String parseBrowser(String userAgent) {
        if (userAgent.contains("Chrome")) return "Chrome";
        if (userAgent.contains("Firefox")) return "Firefox";
        if (userAgent.contains("Safari")) return "Safari";
        if (userAgent.contains("Edge")) return "Edge";
        return "Other";
    }

    private String parseOS(String userAgent) {
        if (userAgent.contains("Windows")) return "Windows";
        if (userAgent.contains("Mac OS X")) return "Mac OS";
        if (userAgent.contains("Linux")) return "Linux";
        if (userAgent.contains("Android")) return "Android";
        if (userAgent.contains("iPhone")) return "iOS";
        return "Other";
    }

    private String parseDevice(String userAgent) {
        if (userAgent.contains("Mobi")) return "Mobile";
        if (userAgent.contains("Tablet") || userAgent.contains("iPad")) return "Tablet";
        return "Desktop";
    }
}
