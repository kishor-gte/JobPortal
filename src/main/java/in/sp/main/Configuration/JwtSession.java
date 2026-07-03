package in.sp.main.Configuration;

import in.sp.main.Entities.Admin;
import in.sp.main.Entities.Company;
import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.Recruiter;
import in.sp.main.Repositories.AdminRepository;
import in.sp.main.Repositories.CompanyRepository;
import in.sp.main.Repositories.JobSeekerRepository;
import in.sp.main.Repositories.RecruiterRepository;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;


import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

@SuppressWarnings("deprecation")
public class JwtSession implements HttpSession {

    private final String userId;
    private final String role;
    private final Map<String, Object> attributes = new HashMap<>();

    private final AdminRepository adminRepo;
    private final CompanyRepository companyRepo;
    private final JobSeekerRepository jobSeekerRepo;
    private final RecruiterRepository recruiterRepo;
    private final ServletContext servletContext;

    public JwtSession(String userId, String role, ServletContext servletContext,
                      AdminRepository adminRepo, CompanyRepository companyRepo,
                      JobSeekerRepository jobSeekerRepo, RecruiterRepository recruiterRepo) {
        this.userId = userId;
        this.role = role;
        this.servletContext = servletContext;
        this.adminRepo = adminRepo;
        this.companyRepo = companyRepo;
        this.jobSeekerRepo = jobSeekerRepo;
        this.recruiterRepo = recruiterRepo;
        
        prepopulateAttributes();
    }

    private void prepopulateAttributes() {
        try {
            Long id = Long.parseLong(userId);
            if ("ADMIN".equals(role)) {
                attributes.put("adminId", id);
                Admin admin = adminRepo.findById(id).orElse(null);
                if (admin != null) attributes.put("loggedInAdmin", admin);
            } else if ("COMPANY".equals(role)) {
                attributes.put("companyId", id);
                Company company = companyRepo.findById(id).orElse(null);
                if (company != null) {
                    attributes.put("loggedInCompany", company);
                    attributes.put("company", company);
                }
            } else if ("JOBSEEKER".equals(role)) {
                attributes.put("jobSeekerId", id);
                JobSeeker js = jobSeekerRepo.findById(id).orElse(null);
                if (js != null) {
                    attributes.put("jobSeeker", js);
                    attributes.put("jobseeker", js);
                }
            } else if ("RECRUITER".equals(role)) {
                attributes.put("recruiterId", id);
                Recruiter recruiter = recruiterRepo.findById(id).orElse(null);
                if (recruiter != null) {
                    attributes.put("loggedInRecruiter", recruiter);
                    attributes.put("recruiter", recruiter);
                }
            }
        } catch (NumberFormatException ignored) {}
    }

    @Override
    public long getCreationTime() {
        return System.currentTimeMillis();
    }

    @Override
    public String getId() {
        return userId;
    }

    @Override
    public long getLastAccessedTime() {
        return System.currentTimeMillis();
    }

    @Override
    public ServletContext getServletContext() {
        return servletContext;
    }

    @Override
    public void setMaxInactiveInterval(int interval) { }

    @Override
    public int getMaxInactiveInterval() {
        return 36000;
    }

    @Override
    public Object getAttribute(String name) {
        return attributes.get(name);
    }

    @Override
    public Enumeration<String> getAttributeNames() {
        return new Vector<>(attributes.keySet()).elements();
    }

    public Object getValue(String name) {
        return getAttribute(name);
    }

    public String[] getValueNames() {
        return attributes.keySet().toArray(new String[0]);
    }

    @Override
    public void setAttribute(String name, Object value) {
        attributes.put(name, value);
    }

    public void putValue(String name, Object value) {
        setAttribute(name, value);
    }

    @Override
    public void removeAttribute(String name) {
        attributes.remove(name);
    }

    public void removeValue(String name) {
        removeAttribute(name);
    }

    @Override
    public void invalidate() {
        attributes.clear();
    }

    @Override
    public boolean isNew() {
        return false;
    }
}
