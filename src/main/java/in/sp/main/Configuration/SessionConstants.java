package in.sp.main.Configuration;

/**
 * Standardized session attribute names across the application
 * Prevents inconsistencies and typos in session management
 */
public class SessionConstants {
    
    // User session attributes
    public static final String ATTR_JOB_SEEKER = "jobSeeker";
    public static final String ATTR_COMPANY = "loggedInCompany";
    public static final String ATTR_RECRUITER = "loggedInRecruiter";
    public static final String ATTR_ADMIN = "loggedInAdmin";
    
    // Role and type attributes
    public static final String ATTR_USER_TYPE = "userType";
    public static final String ATTR_USER_ROLE = "userRole";
    public static final String ATTR_JOB_SEEKER_ID = "jobSeekerId";
    public static final String ATTR_RECRUITER_ID = "recruiterId";
    public static final String ATTR_ADMIN_ID = "adminId";
    public static final String ATTR_COMPANY_ID = "companyId";
    
    // User type values
    public static final String TYPE_JOBSEEKER = "JOBSEEKER";
    public static final String TYPE_COMPANY = "COMPANY";
    public static final String TYPE_RECRUITER = "RECRUITER";
    public static final String TYPE_ADMIN = "ADMIN";
    
    // Role values
    public static final String ROLE_STUDENT = "STUDENT";
    public static final String ROLE_INTERVIEWER = "INTERVIEWER";
    public static final String ROLE_ADMIN = "ADMIN";
    
    /**
     * Private constructor to prevent instantiation
     */
    private SessionConstants() {
        throw new UnsupportedOperationException("Utility class - do not instantiate");
    }
}
