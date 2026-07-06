package in.sp.main.Repositories;

import in.sp.main.Entities.UserActivity;
import in.sp.main.Enums.ActivityType;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

import in.sp.main.dto.CandidateActivityDTO;
import in.sp.main.Enums.ApplicationStatus;

public interface UserActivityRepository extends JpaRepository<UserActivity, Long> {

    // General queries for Super Admin
    Page<UserActivity> findAllByOrderByCreatedAtDesc(Pageable pageable);

    // Queries for Candidate 360 Dashboard
    Page<UserActivity> findByUserIdOrderByCreatedAtDesc(Long userId, Pageable pageable);
    
    @Query("SELECT u FROM UserActivity u WHERE u.userId = :userId AND " +
           "(:activityType IS NULL OR u.activityType = :activityType) AND " +
           "(:startDate IS NULL OR u.createdAt >= :startDate) AND " +
           "(:endDate IS NULL OR u.createdAt <= :endDate) " +
           "ORDER BY u.createdAt DESC")
    Page<UserActivity> findByUserIdWithFilters(
            @Param("userId") Long userId,
            @Param("activityType") ActivityType activityType,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate,
            Pageable pageable);

    @Query("SELECT u FROM UserActivity u WHERE u.userId = :userId AND u.activityType IN :types ORDER BY u.createdAt DESC")
    List<UserActivity> findByUserIdAndActivityTypeInOrderByCreatedAtDesc(
            @Param("userId") Long userId, 
            @Param("types") java.util.List<ActivityType> types);

    @Query("SELECT u FROM UserActivity u WHERE " +
           "(:userName IS NULL OR LOWER(u.userName) LIKE LOWER(CONCAT('%', :userName, '%'))) AND " +
           "(:userEmail IS NULL OR LOWER(u.userEmail) LIKE LOWER(CONCAT('%', :userEmail, '%'))) AND " +
           "(:activityType IS NULL OR u.activityType = :activityType) AND " +
           "(:startDate IS NULL OR u.createdAt >= :startDate) AND " +
           "(:endDate IS NULL OR u.createdAt <= :endDate) " +
           "ORDER BY u.createdAt DESC")
    Page<UserActivity> findWithFilters(
            @Param("userName") String userName,
            @Param("userEmail") String userEmail,
            @Param("activityType") ActivityType activityType,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate,
            Pageable pageable);

    // Queries for Recruiter (only activities related to recruiter jobs/interactions)
    Page<UserActivity> findByRecruiterIdOrderByCreatedAtDesc(Long recruiterId, Pageable pageable);

    @Query("SELECT u FROM UserActivity u WHERE u.recruiterId = :recruiterId AND " +
           "(:userName IS NULL OR LOWER(u.userName) LIKE LOWER(CONCAT('%', :userName, '%'))) AND " +
           "(:activityType IS NULL OR u.activityType = :activityType) AND " +
           "(:startDate IS NULL OR u.createdAt >= :startDate) AND " +
           "(:endDate IS NULL OR u.createdAt <= :endDate) " +
           "ORDER BY u.createdAt DESC")
    Page<UserActivity> findByRecruiterIdWithFilters(
            @Param("recruiterId") Long recruiterId,
            @Param("userName") String userName,
            @Param("activityType") ActivityType activityType,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate,
            Pageable pageable);

    // Queries for Company (Enriched with Job and Candidate Details)
    @Query(value = "SELECT new in.sp.main.dto.CandidateActivityDTO(" +
           "u, j.title, s.profilePicture, a.status, s.resumeUploaded) " +
           "FROM UserActivity u " +
           "LEFT JOIN Job j ON u.jobId = j.id " +
           "LEFT JOIN JobSeeker s ON u.userId = s.id " +
           "LEFT JOIN JobApplication a ON a.jobSeeker.id = u.userId AND a.job.id = u.jobId " +
           "WHERE u.companyId = :companyId " +
           "AND (:userName IS NULL OR LOWER(u.userName) LIKE LOWER(CONCAT('%', :userName, '%'))) " +
           "AND (:userEmail IS NULL OR LOWER(u.userEmail) LIKE LOWER(CONCAT('%', :userEmail, '%'))) " +
           "AND (:jobTitle IS NULL OR LOWER(j.title) LIKE LOWER(CONCAT('%', :jobTitle, '%'))) " +
           "AND (:activityType IS NULL OR u.activityType = :activityType) " +
           "AND (:applicationStatus IS NULL OR a.status = :applicationStatus) " +
           "AND (:startDate IS NULL OR u.createdAt >= :startDate) " +
           "AND (:endDate IS NULL OR u.createdAt <= :endDate)")
    Page<CandidateActivityDTO> findCompanyCandidateActivities(
            @Param("companyId") Long companyId,
            @Param("userName") String userName,
            @Param("userEmail") String userEmail,
            @Param("jobTitle") String jobTitle,
            @Param("activityType") ActivityType activityType,
            @Param("applicationStatus") ApplicationStatus applicationStatus,
            @Param("startDate") LocalDateTime startDate,
            @Param("endDate") LocalDateTime endDate,
            Pageable pageable);

    // Stats queries for Company
    @Query("SELECT COUNT(u) FROM UserActivity u WHERE u.companyId = :companyId AND u.activityType = :activityType")
    long countByCompanyIdAndActivityType(@Param("companyId") Long companyId, @Param("activityType") ActivityType activityType);

    @Query("SELECT COUNT(u) FROM UserActivity u WHERE u.companyId = :companyId AND u.createdAt >= :startDate")
    long countByCompanyIdAndCreatedAtAfter(@Param("companyId") Long companyId, @Param("startDate") LocalDateTime startDate);
}
