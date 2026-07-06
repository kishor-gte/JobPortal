package in.sp.main.Services;

import in.sp.main.Entities.UserActivity;
import in.sp.main.Enums.ActivityType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import java.time.LocalDateTime;

import in.sp.main.dto.CandidateActivityDTO;
import in.sp.main.dto.CompanyActivityStatsDTO;
import in.sp.main.Enums.ApplicationStatus;

public interface UserActivityService {

    void saveLogAsync(Long userId, String userName, String userEmail, String role, 
                      ActivityType type, String description, Long jobId, Long companyId, Long recruiterId,
                      String requestUrl, String httpMethod, String ipAddress, String browser, 
                      String operatingSystem, String deviceType, String sessionId);

    Page<UserActivity> getAdminActivities(String userName, String userEmail, ActivityType activityType, 
                                          LocalDateTime startDate, LocalDateTime endDate, Pageable pageable);

    Page<UserActivity> getRecruiterActivities(Long recruiterId, String userName, ActivityType activityType, 
                                              LocalDateTime startDate, LocalDateTime endDate, Pageable pageable);

    Page<CandidateActivityDTO> getCompanyCandidateActivities(Long companyId, String userName, String userEmail, String jobTitle, ActivityType activityType, ApplicationStatus applicationStatus, LocalDateTime startDate, LocalDateTime endDate, Pageable pageable);

    CompanyActivityStatsDTO getCompanyActivityStats(Long companyId);
}
