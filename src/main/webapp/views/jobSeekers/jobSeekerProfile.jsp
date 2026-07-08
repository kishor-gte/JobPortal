<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="UTF-8">
 <title>Job Seeker Profile | SmartInterview</title>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
 <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
 <style>
     :root {
         --primary: #19A77B;
         --primary-dark: #148F69;
         --accent: #3BC49A;
         --bg-dark: #2E3E41;
         --bg-darker: #1a2a2c;
         --bg-lighter: #3a4e51;
         --text-primary: #1e293b;
         --text-secondary: #475569;
         --text-tertiary: #64748b;
         --border-color: #e0e6ed;
         --card-bg: #ffffff;
         --hover-bg: rgba(25, 167, 123, 0.08);
         --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
         --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
         --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
         --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
         --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
         --success: #10b981;
         --warning: #f59e0b;
         --danger: #ef4444;
         --info: #3b82f6;
     }
   
     body {
         background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
         font-family: var(--font-main);
         min-height: 100vh;
         padding-bottom: 20px;
         margin: 0;
         position: relative;
     }

     /* Animated background pattern */
     body::before {
         content: '';
         position: fixed;
         top: 0;
         left: 0;
         right: 0;
         bottom: 0;
         background: 
             radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.03) 0%, transparent 50%),
             radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.03) 0%, transparent 50%);
         pointer-events: none;
         z-index: 0;
         animation: backgroundPulse 15s ease-in-out infinite;
     }

     @keyframes backgroundPulse {
         0%, 100% { opacity: 0.5; }
         50% { opacity: 1; }
     }

     /* Main Content Wrapper */
     .main-content-wrapper {
         margin-left: 280px;
         padding: 20px;
         transition: margin-left 0.3s ease;
         position: relative;
         z-index: 1;
     }

     /* Mobile Toggle Button */
     .sidebar-toggle-btn {
         display: none;
         position: fixed;
         top: 15px;
         left: 15px;
         z-index: 1001;
         background: var(--primary);
         color: white;
         border: none;
         padding: 12px 18px;
         border-radius: 12px;
         font-size: 1.2rem;
         cursor: pointer;
         box-shadow: var(--shadow-md);
     }

     .sidebar-overlay {
         display: none;
         position: fixed;
         top: 0;
         left: 0;
         width: 100%;
         height: 100%;
         background: rgba(0, 0, 0, 0.5);
         backdrop-filter: blur(4px);
         z-index: 999;
     }

     /* Responsive Design */
     @media (max-width: 991.98px) {
         .sidebar-toggle-btn {
             display: block;
         }

         .career-sidebar {
             transform: translateX(-100%);
             border-radius: 0;
         }

         .career-sidebar.show {
             transform: translateX(0);
             border-radius: 0 20px 20px 0;
         }

         .main-content-wrapper {
             margin-left: 0;
         }

         .sidebar-overlay.show {
             display: block;
         }
     }

     @media (max-width: 576px) {
         .main-content-wrapper {
             padding: 15px 10px;
         }
     }
   
     .container {
         position: relative;
         z-index: 1;
     }
   
     .profile-header {
         background: var(--gradient-primary);
         padding: 40px 0;
         border-radius: 20px 20px 0 0;
         margin-top: 30px;
         position: relative;
         overflow: hidden;
         box-shadow: var(--glow-primary);
     }
   
     .profile-header::before {
         content: '';
         position: absolute;
         top: 0;
         left: 0;
         right: 0;
         bottom: 0;
         background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none"><path d="M0,0 L1000,0 L1000,100 L0,100 Z" fill="rgba(255,255,255,0.1)"/></svg>');
         opacity: 0.1;
     }
   
     .profile-img {
         width: 160px;
         height: 160px;
         object-fit: cover;
         border-radius: 50%;
         border: 5px solid rgba(255, 255, 255, 0.3);
         box-shadow: var(--shadow-lg);
         transition: transform 0.3s ease, box-shadow 0.3s ease;
     }
   
     .profile-img:hover {
         transform: scale(1.05);
         box-shadow: var(--shadow-lg), var(--glow-primary);
     }
   
     .profile-name {
         color: white;
         font-weight: 700;
         font-size: 2.5rem;
         text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
         margin-bottom: 5px;
     }
   
     .profile-email {
         color: rgba(255, 255, 255, 0.9);
         font-size: 1.1rem;
         font-weight: 400;
     }
   
     .profile-card {
         background: var(--card-bg);
         border-radius: 0 0 20px 20px;
         padding: 24px; 
         box-shadow: var(--shadow-md);
         border: 1px solid var(--border-color);
         position: relative;
         overflow: hidden;
         animation: fadeInUp 0.8s ease-out;
     }
   
     .profile-card::before {
         content: '';
         position: absolute;
         top: 0;
         left: 0;
         width: 100%;
         height: 4px;
         background: var(--gradient-primary);
     }
   
     .info-label {
         font-weight: 600;
         color: var(--primary);
         font-size: 0.9rem;
         text-transform: uppercase;
         letter-spacing: 0.5px;
         margin-bottom: 5px;
         display: block;
     }
   
     .section-title {
         font-size: 1.4rem;
         font-weight: 700;
         margin-bottom: 16px;
         color: var(--text-primary);
         position: relative;
         padding-bottom: 10px;
     }
   
     .section-title::after {
         content: '';
         position: absolute;
         bottom: 0;
         left: 0;
         width: 60px;
         height: 3px;
         background: var(--gradient-primary);
         border-radius: 2px;
     }
   
     .section-title i {
         background: var(--gradient-primary);
         color: white;
         width: 40px;
         height: 40px;
         display: inline-flex;
         align-items: center;
         justify-content: center;
         border-radius: 10px;
         margin-right: 12px;
         box-shadow: 0 4px 15px rgba(25, 167, 123, 0.3);
     }
   
     .info-block {
         border: 1px solid var(--border-color);
         border-radius: 12px;
         padding: 14px 16px;
         margin-bottom: 14px;
         background: white;
         transition: all 0.3s ease;
         position: relative;
         overflow: hidden;
     }
   
     .info-block::before {
         content: '';
         position: absolute;
         left: 0;
         top: 0;
         width: 4px;
         height: 100%;
         background: var(--gradient-primary);
         opacity: 0;
         transition: opacity 0.3s ease;
     }
   
     .info-block:hover {
         transform: translateY(-3px);
         box-shadow: var(--shadow-md);
         border-color: var(--primary);
     }
   
     .info-block:hover::before {
         opacity: 1;
     }
   
     .info-block div {
         color: var(--text-primary);
         font-weight: 500;
         font-size: 0.95rem;
         margin-top: 5px;
     }
   
     .action-buttons {
         display: flex;
         gap: 15px;
         flex-wrap: wrap;
         justify-content: center;
         padding-top: 30px;
         border-top: 1px solid var(--border-color);
         margin-top: 30px;
     }
   
     .action-buttons a,
     .action-buttons button {
         min-width: 160px;
         padding: 12px 24px;
         font-weight: 600;
         border-radius: 10px;
         transition: all 0.3s ease;
         text-transform: uppercase;
         letter-spacing: 0.5px;
         font-size: 0.9rem;
         border: none;
         position: relative;
         overflow: hidden;
     }
   
     .btn-primary {
         background: var(--gradient-primary);
         border: none;
         box-shadow: 0 5px 20px rgba(25, 167, 123, 0.3);
         color: white;
     }
   
     .btn-primary:hover {
         transform: translateY(-2px);
         box-shadow: 0 8px 25px rgba(25, 167, 123, 0.4);
         background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
     }
   
     .btn-outline-secondary {
         border: 2px solid var(--primary);
         color: var(--primary);
         background: transparent;
     }
   
     .btn-outline-secondary:hover {
         background: var(--gradient-primary);
         color: white;
         transform: translateY(-2px);
         box-shadow: 0 5px 20px rgba(25, 167, 123, 0.3);
         border-color: transparent;
     }
   
     .btn-danger {
         background: linear-gradient(45deg, #ff416c, #ff4b2b);
         border: none;
         box-shadow: 0 5px 20px rgba(255, 65, 108, 0.3);
         color: white;
     }
   
     .btn-danger:hover {
         transform: translateY(-2px);
         box-shadow: 0 8px 25px rgba(255, 65, 108, 0.4);
         background: linear-gradient(45deg, #ff4b2b, #ff416c);
     }
   
     .progress {
         height: 20px;
         border-radius: 10px;
         background: #eef1f5;
         overflow: hidden;
         box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
     }
   
     .progress-bar {
         background: linear-gradient(45deg, var(--success), var(--accent));
         border-radius: 10px;
         font-size: 0.85rem;
         font-weight: 600;
         box-shadow: 0 2px 10px rgba(16, 185, 129, 0.3);
         position: relative;
         overflow: hidden;
     }
   
     .progress-bar::after {
         content: '';
         position: absolute;
         top: 0;
         left: 0;
         right: 0;
         bottom: 0;
         background: linear-gradient(90deg,
             transparent 25%,
             rgba(255, 255, 255, 0.3) 50%,
             transparent 75%);
         animation: shimmer 2s infinite;
     }
   
     @keyframes shimmer {
         0% { transform: translateX(-100%); }
         100% { transform: translateX(100%); }
     }
   
     .card-container {
         max-width: 1000px;
         margin: auto;
         animation: fadeInUp 0.8s ease-out;
     }
   
     @keyframes fadeInUp {
         from {
             opacity: 0;
             transform: translateY(30px);
         }
         to {
             opacity: 1;
             transform: translateY(0);
         }
     }
   
     .education-level {
         font-size: 1.1rem;
         font-weight: 700;
         color: var(--primary);
         margin: 15px 0 10px 0;
         padding-left: 10px;
         border-left: 4px solid var(--primary);
     }
   
     a[target="_blank"] {
         color: var(--primary);
         text-decoration: none;
         font-weight: 600;
         transition: all 0.3s ease;
         display: inline-flex;
         align-items: center;
         gap: 8px;
     }
   
     a[target="_blank"]:hover {
         color: var(--primary-dark);
         transform: translateX(5px);
     }
   
     a[target="_blank"]::after {
         content: '↗';
         font-size: 0.9em;
     }
   
     .status-badge {
         display: inline-block;
         padding: 4px 12px;
         border-radius: 20px;
         font-size: 0.8rem;
         font-weight: 600;
         text-transform: uppercase;
         letter-spacing: 0.5px;
     }
   
     .status-active {
         background: linear-gradient(45deg, var(--success), var(--accent));
         color: white;
     }
   
     .status-inactive {
         background: linear-gradient(45deg, #ff416c, #ff4b2b);
         color: white;
     }
   
     .badge-primary {
         background: var(--gradient-primary);
         padding: 6px 12px;
         color: white;
     }
   
     @media (max-width: 768px) {
         .profile-img {
             width: 120px;
             height: 120px;
         }
       
         .profile-name {
             font-size: 1.8rem;
         }
       
         .profile-card {
             padding: 20px;
         }
       
         .action-buttons a,
         .action-buttons button {
             min-width: 140px;
             padding: 10px 20px;
         }
       
         .section-title {
             font-size: 1.2rem;
         }
       
         .info-block {
             padding: 15px;
         }
     }
 </style>
</head>
<body>
<jsp:include page="/views/commons/student_sidebar.jsp" />

<!-- Main Content -->
<div class="main-content-wrapper">
<div class="container mt-4 mb-5">
    <!-- Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success">
            <i class="fas fa-check-circle"></i> ${message}
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger">
            <i class="fas fa-exclamation-circle"></i> ${error}
        </div>
    </c:if>
 <div class="card-container">
     <!-- Profile Header -->
     <div class="profile-header text-center">
         <div style="position: absolute; top: 20px; right: 20px; display: flex; gap: 10px; z-index: 2;">
             <a href="${pageContext.request.contextPath}/jobSeekers/dashboard" class="btn btn-sm" style="background: rgba(255,255,255,0.2); color: white; border: 1px solid rgba(255,255,255,0.4); border-radius: 8px; backdrop-filter: blur(4px);">
                 <i class="fas fa-arrow-left mr-1"></i> Dashboard
             </a>
             <a href="${pageContext.request.contextPath}/jobSeekers/update" class="btn btn-sm bg-white" style="color: var(--primary); font-weight: 600; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                 <i class="fas fa-edit mr-1"></i> Edit Profile
             </a>
         </div>
         <div style="position: absolute; top: 20px; left: 20px; display: flex; gap: 10px; z-index: 2;">
             <label for="bgColorPicker" class="btn btn-sm" style="background: rgba(255,255,255,0.2); color: white; border: 1px solid rgba(255,255,255,0.4); border-radius: 8px; backdrop-filter: blur(4px); cursor: pointer; margin: 0;" title="Change Background Color">
                 <i class="fas fa-palette mr-1"></i> Color
             </label>
             <input type="color" id="bgColorPicker" style="opacity: 0; position: absolute; left: 0; top: 0; width: 0; height: 0;" oninput="updateHeaderColor(this.value)">
             
             <label for="bgImagePicker" class="btn btn-sm" style="background: rgba(255,255,255,0.2); color: white; border: 1px solid rgba(255,255,255,0.4); border-radius: 8px; backdrop-filter: blur(4px); cursor: pointer; margin: 0;" title="Upload Background Image">
                 <i class="fas fa-image mr-1"></i> Image
             </label>
             <input type="file" id="bgImagePicker" accept="image/*" style="display: none;" onchange="updateHeaderImage(this)">
         </div>
         <form id="profilePicForm" action="${pageContext.request.contextPath}/jobSeekers/updateProfilePicture/${jobSeeker.id}" method="post" enctype="multipart/form-data">
             <div style="position: relative; display: inline-block; cursor: pointer;" onclick="document.getElementById('profilePicInput').click();" title="Change Profile Picture">
                 <img src="${pageContext.request.contextPath}${jobSeeker.profilePicture}"
                      onerror="this.onerror=null;this.src='${pageContext.request.contextPath}/images/default-profile.png';"
                      alt="Profile Picture"
                      class="profile-img mb-3" style="cursor: pointer;">
                 <div style="position: absolute; bottom: 25px; right: 10px; background: var(--primary); color: white; border-radius: 50%; width: 36px; height: 36px; display: flex; align-items: center; justify-content: center; box-shadow: 0 2px 5px rgba(0,0,0,0.2);">
                     <i class="fas fa-camera"></i>
                 </div>
             </div>
             <input type="file" id="profilePicInput" name="image" style="display: none;" accept="image/*" onchange="document.getElementById('profilePicForm').submit();">
         </form>
         <h1 class="profile-name">${jobSeeker.name}</h1>
         <p class="profile-email">${jobSeeker.email}</p>
     </div>
   
     <!-- Profile Card -->
     <div class="profile-card">
         <!-- Personal Details -->
         <div class="section-title"><i class="fas fa-user"></i> Personal Details</div>
         <div class="row">
             <div class="col-md-6 info-block"><span class="info-label">Phone:</span> <div>${jobSeeker.phone}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Gender:</span> <div>${jobSeeker.gender}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Age:</span> <div>${jobSeeker.age}</div></div>        
             <div class="col-md-6 info-block"><span class="info-label">Date of Birth:</span> <div>${jobSeeker.dateOfBirth}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Marital Status:</span> <div>${jobSeeker.maritalStatus}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Location:</span> <div>${jobSeeker.location}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Pin Code:</span> <div>${jobSeeker.pinCode}</div></div>
             <div class="col-md-12 info-block"><span class="info-label">Permanent Address:</span> <div>${jobSeeker.permanentAddress}</div></div>
             <div class="col-md-12 info-block"><span class="info-label">Languages Known:</span> <div>${jobSeeker.languagesKnown}</div></div>
         </div>
       
         <!-- Education Details -->
         <div class="section-title mt-5"><i class="fas fa-graduation-cap"></i> Education Details</div>
         <div class="row">
             <div class="col-md-6 info-block"><span class="info-label">Highest Education:</span> <div>${jobSeeker.education}</div></div>
           
             <div class="col-12">
                 <div class="education-level">Undergraduate</div>
             </div>
             <div class="col-md-6 info-block"><span class="info-label">Degree:</span> <div>${jobSeeker.ugDegree}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Specialization:</span> <div>${jobSeeker.ugSpecialization}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">University:</span> <div>${jobSeeker.ugUniversity}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Graduation Year:</span> <div>${jobSeeker.ugGraduationYear}</div></div>
           
             <c:if test="${not empty jobSeeker.pgDegree}">
             <div class="col-12">
                 <div class="education-level">Postgraduate</div>
             </div>
             <div class="col-md-6 info-block"><span class="info-label">Degree:</span> <div>${jobSeeker.pgDegree}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Specialization:</span> <div>${jobSeeker.pgSpecialization}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">University:</span> <div>${jobSeeker.pgUniversity}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Graduation Year:</span> <div>${jobSeeker.pgGraduationYear}</div></div>
             </c:if>
           
             <c:if test="${not empty jobSeeker.doctorateDegree}">
             <div class="col-12">
                 <div class="education-level">Doctorate</div>
             </div>
             <div class="col-md-6 info-block"><span class="info-label">Degree:</span> <div>${jobSeeker.doctorateDegree}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Specialization:</span> <div>${jobSeeker.doctorateSpecialization}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">University:</span> <div>${jobSeeker.doctorateUniversity}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Graduation Year:</span> <div>${jobSeeker.doctorateGraduationYear}</div></div>
             </c:if>
         </div>
       
         <!-- Professional Info -->
         <div class="section-title mt-5"><i class="fas fa-briefcase"></i> Professional Info</div>
         <div class="row">
             <div class="col-md-6 info-block"><span class="info-label">Skills:</span>
                 <div>
                     <c:choose>
                         <c:when test="${not empty jobSeeker.skills and fn:length(jobSeeker.skills) > 0}">
                             <c:forEach var="skill" items="${jobSeeker.skills}" varStatus="loop">
                                 <span class="badge badge-primary mr-1 mb-1"><c:out value="${skill}" /></span>
                             </c:forEach>
                         </c:when>
                         <c:otherwise>
                             <span class="text-muted">No skills added</span>
                         </c:otherwise>
                     </c:choose>
                 </div>
             </div>
             <div class="col-md-6 info-block"><span class="info-label">Experience:</span> <div>${jobSeeker.experience}</div></div>
             <div class="col-md-6 info-block">
                 <span class="info-label">Account Status:</span>
                 <div>
                     <c:choose>
                         <c:when test="${not empty jobSeeker.accountStatus && jobSeeker.accountStatus == 'ACTIVE'}">
                             <span class="status-badge status-active">
                                 <i class="fas fa-check-circle"></i> Active
                             </span>
                         </c:when>
                         <c:otherwise>
                             <span class="status-badge status-inactive">
                                 <i class="fas fa-times-circle"></i> Inactive
                             </span>
                         </c:otherwise>
                     </c:choose>
                 </div>
             </div>
             <div class="col-md-6 info-block"><span class="info-label">Work Availability:</span> <div>${jobSeeker.workAvailability}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Resume Headline:</span> <div>${jobSeeker.resumeHeadline}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Annual Salary:</span> <div>${jobSeeker.annualSalary}</div></div>
             <div class="col-md-6 info-block"><span class="info-label">Notice Period:</span> <div>${jobSeeker.noticePeriod}</div></div>
         </div>
       
         <!-- Documents -->
         <div class="section-title mt-5"><i class="fas fa-folder-open"></i> Documents</div>
         <div class="row">
             <div class="col-md-6 info-block">
                 <span class="info-label">Identity Document:</span>
                 <div>
                      <c:choose>
                          <c:when test="${empty jobSeeker.identityDocument}">
                              <span class="text-muted">Not Uploaded</span>
                          </c:when>
                          <c:otherwise>
                              <a href="${pageContext.request.contextPath}${jobSeeker.identityDocument}" target="_blank">
                                  <i class="fas fa-file-pdf mr-2"></i>View Document
                              </a>
                          </c:otherwise>
                      </c:choose>
                 </div>
             </div>
             <div class="col-md-6 info-block">
                 <span class="info-label">Resume:</span>
                 <div>
                     <c:choose>
                         <c:when test="${empty jobSeeker.resumeUploaded}">
                             <span class="text-muted">Not Uploaded</span>
                         </c:when>
                         <c:otherwise>
                             <a href="${pageContext.request.contextPath}${jobSeeker.resumeUploaded}" target="_blank">
                                 <i class="fas fa-file-alt mr-2"></i>View Resume
                             </a>
                         </c:otherwise>
                     </c:choose>
                 </div>
             </div>
         </div>
       
         <!-- Video Resume -->
         <div class="section-title mt-5"><i class="fas fa-video"></i> Video Resume</div>
          <div class="info-block" style="padding: 0; overflow: hidden; border-radius: 12px;">
              <c:choose>
                  <c:when test="${empty jobSeeker.videoResumeUrl}">
                      <div class="p-3 text-muted">Not Provided</div>
                  </c:when>
                  <c:otherwise>
                      <c:set var="videoType" value="video/mp4" />
                      <c:if test="${fn:endsWith(fn:toLowerCase(jobSeeker.videoResumeUrl), '.webm')}">
                          <c:set var="videoType" value="video/webm" />
                      </c:if>
                      <c:if test="${fn:endsWith(fn:toLowerCase(jobSeeker.videoResumeUrl), '.ogg')}">
                          <c:set var="videoType" value="video/ogg" />
                      </c:if>
                      <c:if test="${fn:endsWith(fn:toLowerCase(jobSeeker.videoResumeUrl), '.mov') or fn:endsWith(fn:toLowerCase(jobSeeker.videoResumeUrl), '.qt')}">
                          <c:set var="videoType" value="video/quicktime" />
                      </c:if>
                      <video controls preload="auto" playsinline style="width: 100%; max-height: 360px; background: #000; display: block;">
                          <source src="${pageContext.request.contextPath}${jobSeeker.videoResumeUrl}" type="${videoType}">
                          Your browser does not support HTML5 video.
                      </video>
                  </c:otherwise>
              </c:choose>
          </div>
       
         <!-- Profile Completion -->
         <div class="section-title mt-5"><i class="fas fa-percent"></i> Profile Completion</div>
         <div class="info-block">
             <div class="info-label">Completed:</div>
             <div class="progress mt-2">
                 <div class="progress-bar" role="progressbar" style="width: ${completionPercentage}%;" aria-valuenow="${completionPercentage}" aria-valuemin="0" aria-valuemax="100">${completionPercentage}%</div>
             </div>
         </div>
       
     </div>
 </div>
</div>
<script>
 // Add some interactive animations
 document.addEventListener('DOMContentLoaded', function() {
     // Animate info blocks on scroll
     const observerOptions = {
         threshold: 0.1,
         rootMargin: '0px 0px -50px 0px'
     };
   
     const observer = new IntersectionObserver((entries) => {
         entries.forEach(entry => {
             if (entry.isIntersecting) {
                 entry.target.style.opacity = '1';
                 entry.target.style.transform = 'translateY(0)';
             }
         });
     }, observerOptions);
   
     // Observe all info blocks
     document.querySelectorAll('.info-block').forEach((block, index) => {
         block.style.opacity = '0';
         block.style.transform = 'translateY(20px)';
         block.style.transitionDelay = (index * 0.05) + 's';
         observer.observe(block);
     });
   
     // Add hover effect to profile image
     const profileImg = document.querySelector('.profile-img');
     if (profileImg) {
         profileImg.addEventListener('mouseenter', function() {
             this.style.transform = 'scale(1.05) rotate(5deg)';
         });
       
         profileImg.addEventListener('mouseleave', function() {
             this.style.transform = 'scale(1) rotate(0deg)';
         });
     }

     // Background color and image editing
     function applyBackground() {
         const header = document.querySelector('.profile-header');
         if (!header) return;
         
         const savedImage = localStorage.getItem('jobSeekerHeaderImage');
         const savedBgColor = localStorage.getItem('jobSeekerHeaderColor');
         
         if (savedImage) {
             header.style.setProperty('background-color', 'transparent', 'important');
             header.style.setProperty('background-image', `url("${savedImage}")`, 'important');
             header.style.setProperty('background-position', 'center center', 'important');
             header.style.setProperty('background-size', 'cover', 'important');
             header.style.setProperty('background-repeat', 'no-repeat', 'important');
         } else if (savedBgColor) {
             header.style.setProperty('background-image', 'none', 'important');
             header.style.setProperty('background-color', savedBgColor, 'important');
             const picker = document.getElementById('bgColorPicker');
             if (picker) picker.value = savedBgColor;
         } else {
             header.style.removeProperty('background-color');
             header.style.removeProperty('background-image');
             header.style.removeProperty('background-position');
             header.style.removeProperty('background-size');
             header.style.removeProperty('background-repeat');
         }
     }

     window.updateHeaderColor = function(color) {
         localStorage.setItem('jobSeekerHeaderColor', color);
         localStorage.removeItem('jobSeekerHeaderImage'); // Reset image if color is chosen
         applyBackground();
     };

     window.updateHeaderImage = function(input) {
         if (input.files && input.files[0]) {
             const file = input.files[0];
             const objectUrl = URL.createObjectURL(file);
             
             const img = new Image();
             img.onload = function() {
                 URL.revokeObjectURL(objectUrl); // Clean up memory
                 
                 const canvas = document.createElement('canvas');
                 const MAX_WIDTH = 1200; // Small width for guaranteed fast base64 string
                 let width = img.width;
                 let height = img.height;
                 
                 if (width > MAX_WIDTH) {
                     height = Math.round((height * MAX_WIDTH) / width);
                     width = MAX_WIDTH;
                 }
                 
                 canvas.width = width;
                 canvas.height = height;
                 const ctx = canvas.getContext('2d');
                 ctx.drawImage(img, 0, 0, width, height);
                 
                 // High compression JPEG ensures base64 string is tiny and safe
                 const dataUrl = canvas.toDataURL('image/jpeg', 0.8);
                 
                 try {
                     localStorage.setItem('jobSeekerHeaderImage', dataUrl);
                     localStorage.removeItem('jobSeekerHeaderColor');
                     applyBackground();
                 } catch (err) {
                     alert("Error saving image. Try a smaller file.");
                 }
                 input.value = ''; // Reset input to allow selecting same file again
             };
             
             img.onerror = function() {
                 alert("Failed to read the image file.");
                 input.value = '';
             };
             
             img.src = objectUrl;
         }
     };

     // Initial apply on load
     applyBackground();

     // Keyboard shortcuts
     document.addEventListener('keydown', function(e) {
         if (e.key === 'Escape') {
             const sidebar = document.getElementById('careerSidebar');
             const overlay = document.querySelector('.sidebar-overlay');
             sidebar.classList.remove('show');
             overlay.classList.remove('show');
         }
     });
 });
</script>
</div>
</body>
</html>