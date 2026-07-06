package in.sp.main.Services;

import in.sp.main.Entities.UserActivity;
import in.sp.main.Enums.ActivityType;
import in.sp.main.Repositories.UserActivityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.LocalTime;

import in.sp.main.dto.CandidateActivityDTO;
import in.sp.main.dto.CompanyActivityStatsDTO;
import in.sp.main.Enums.ApplicationStatus;

@Service
public class UserActivityServiceImpl implements UserActivityService {

    @Autowired
    private UserActivityRepository userActivityRepository;

    @Async
    @Override
    public void saveLogAsync(Long userId, String userName, String userEmail, String role, 
                             ActivityType type, String description, Long jobId, Long companyId, Long recruiterId,
                             String requestUrl, String httpMethod, String ipAddress, String browser, 
                             String operatingSystem, String deviceType, String sessionId) {
        try {
            UserActivity activity = new UserActivity();
            activity.setUserId(userId);
            activity.setUserName(userName);
            activity.setUserEmail(userEmail);
            activity.setRole(role);
            activity.setActivityType(type);
            activity.setDescription(description);
            activity.setJobId(jobId);
            activity.setCompanyId(companyId);
            activity.setRecruiterId(recruiterId);
            
            activity.setRequestUrl(requestUrl);
            activity.setHttpMethod(httpMethod);
            activity.setIpAddress(ipAddress);
            activity.setBrowser(browser);
            activity.setOperatingSystem(operatingSystem);
            activity.setDeviceType(deviceType);
            activity.setSessionId(sessionId);

            userActivityRepository.save(activity);
        } catch (Exception e) {
            // Log the exception to console/logger but do not throw it to avoid failing the transaction
            System.err.println("Error saving user activity async: " + e.getMessage());
        }
    }

    @Override
    public Page<UserActivity> getAdminActivities(String userName, String userEmail, ActivityType activityType, 
                                                 LocalDateTime startDate, LocalDateTime endDate, Pageable pageable) {
        if (userName == null && userEmail == null && activityType == null && startDate == null && endDate == null) {
            return userActivityRepository.findAllByOrderByCreatedAtDesc(pageable);
        }
        return userActivityRepository.findWithFilters(userName, userEmail, activityType, startDate, endDate, pageable);
    }

    @Override
    public Page<UserActivity> getRecruiterActivities(Long recruiterId, String userName, ActivityType activityType, 
                                                     LocalDateTime startDate, LocalDateTime endDate, Pageable pageable) {
        if (userName == null && activityType == null && startDate == null && endDate == null) {
            return userActivityRepository.findByRecruiterIdOrderByCreatedAtDesc(recruiterId, pageable);
        }
        return userActivityRepository.findByRecruiterIdWithFilters(recruiterId, userName, activityType, startDate, endDate, pageable);
    }

    @Override
    public Page<CandidateActivityDTO> getCompanyCandidateActivities(Long companyId, String userName, String userEmail, String jobTitle, ActivityType activityType, ApplicationStatus applicationStatus, LocalDateTime startDate, LocalDateTime endDate, Pageable pageable) {
        return userActivityRepository.findCompanyCandidateActivities(companyId, userName, userEmail, jobTitle, activityType, applicationStatus, startDate, endDate, pageable);
    }

    @Override
    public CompanyActivityStatsDTO getCompanyActivityStats(Long companyId) {
        long totalViews = userActivityRepository.countByCompanyIdAndActivityType(companyId, ActivityType.VIEWED_JOB);
        long totalApplications = userActivityRepository.countByCompanyIdAndActivityType(companyId, ActivityType.APPLIED_TO_JOB);
        long totalSaved = userActivityRepository.countByCompanyIdAndActivityType(companyId, ActivityType.SAVED_JOB);
        long totalWithdrawn = userActivityRepository.countByCompanyIdAndActivityType(companyId, ActivityType.WITHDRAWN_APPLICATION);
        
        LocalDateTime startOfToday = LocalDateTime.now().with(LocalTime.MIN);
        long todayActivities = userActivityRepository.countByCompanyIdAndCreatedAtAfter(companyId, startOfToday);
        
        LocalDateTime startOfWeek = LocalDateTime.now().minusDays(7).with(LocalTime.MIN);
        long thisWeekActivities = userActivityRepository.countByCompanyIdAndCreatedAtAfter(companyId, startOfWeek);
        
        return new CompanyActivityStatsDTO(totalViews, totalApplications, totalSaved, totalWithdrawn, todayActivities, thisWeekActivities);
    }
}
