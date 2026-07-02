package in.sp.main.Services;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

/**
 * Audit logging service for tracking critical operations
 * Logs all security-sensitive actions for compliance and monitoring
 */
@Service
public class AuditLogService {
    
    private static final Logger auditLogger = LoggerFactory.getLogger("AUDIT");
    
    /**
     * Log login attempts
     */
    public void logLogin(String username, String userType, String ipAddress, boolean success) {
        String status = success ? "SUCCESS" : "FAILED";
        auditLogger.info("LOGIN_ATTEMPT | User: {} | Type: {} | IP: {} | Status: {}", 
                        username, userType, ipAddress, status);
    }
    
    /**
     * Log logout events
     */
    public void logLogout(String username, String userType) {
        auditLogger.info("LOGOUT | User: {} | Type: {}", username, userType);
    }
    
    /**
     * Log password changes
     */
    public void logPasswordChange(String username, String userType) {
        auditLogger.info("PASSWORD_CHANGE | User: {} | Type: {}", username, userType);
    }
    
    /**
     * Log password reset requests
     */
    public void logPasswordReset(String email, String ipAddress) {
        auditLogger.info("PASSWORD_RESET | Email: {} | IP: {}", email, ipAddress);
    }
    
    /**
     * Log admin actions
     */
    public void logAdminAction(String adminEmail, String action, String target) {
        auditLogger.info("ADMIN_ACTION | Admin: {} | Action: {} | Target: {}", 
                        adminEmail, action, target);
    }
    
    /**
     * Log file uploads
     */
    public void logFileUpload(String username, String filename, long fileSize, String fileType) {
        auditLogger.info("FILE_UPLOAD | User: {} | File: {} | Size: {} bytes | Type: {}", 
                        username, filename, fileSize, fileType);
    }
    
    /**
     * Log job applications
     */
    public void logJobApplication(String jobSeekerEmail, Long jobId, String companyName) {
        auditLogger.info("JOB_APPLICATION | Seeker: {} | Job ID: {} | Company: {}", 
                        jobSeekerEmail, jobId, companyName);
    }
    
    /**
     * Log user registration
     */
    public void logRegistration(String email, String userType, String ipAddress) {
        auditLogger.info("REGISTRATION | Email: {} | Type: {} | IP: {}", 
                        email, userType, ipAddress);
    }
    
    /**
     * Log authorization failures
     */
    public void logAuthorizationFailure(String username, String userType, String resource, String action) {
        auditLogger.warn("AUTHORIZATION_FAILURE | User: {} | Type: {} | Resource: {} | Action: {}", 
                        username, userType, resource, action);
    }
    
    /**
     * Log suspicious activities
     */
    public void logSuspiciousActivity(String description, String ipAddress, String username) {
        auditLogger.warn("SUSPICIOUS_ACTIVITY | Description: {} | IP: {} | User: {}", 
                        description, ipAddress, username);
    }
    
    /**
     * Log data exports
     */
    public void logDataExport(String username, String dataType, int recordCount) {
        auditLogger.info("DATA_EXPORT | User: {} | Type: {} | Records: {}", 
                        username, dataType, recordCount);
    }
}
