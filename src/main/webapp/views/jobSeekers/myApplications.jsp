<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="in.sp.main.Entities.JobSeeker" %>
<%@ page import="in.sp.main.Entities.JobApplication" %>
<%
    JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
    pageContext.setAttribute("jobSeeker", jobSeeker);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>My Job Applications | SmartInterview</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/<c:url value='/css/bootstrap.min.css'/>">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
/* ======================================================
  NEW COLOR THEME
  ====================================================== */
:root {
   /* Brand Colors - Updated */
   --primary: #19A77B;
   --primary-dark: #148F69;
   --accent: #3BC49A;
   --bg-dark: #2E3E41;
   --bg-darker: #1a2a2c;
   --bg-lighter: #3a4e51;
   
   /* Backgrounds */
   --bg-light: #f6f9fc;
   --bg-white: #ffffff;
   
   /* Text Colors */
   --heading-text: #1e293b;
   --body-text: #475569;
   
   /* Shadows & Borders */
   --box-shadow-color: rgba(25, 167, 123, 0.15);
   --border-dashed: #cbd5e1;
   --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
   --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
   --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
   
   /* Buttons */
   --btn-primary-bg: var(--primary);
   --btn-primary-text: #ffffff;
   --btn-primary-hover-bg: var(--primary-dark);
   
   /* Icons */
   --icon-color: var(--primary);
   --icon-bg-light: rgba(25, 167, 123, 0.1);
   
   /* Typography */
   --font-family-base: 'Inter', sans-serif;
   --font-heading-weight: 600;
   --font-body-size: 14px;
   
   /* Gradients */
   --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
   --gradient-dark: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-darker) 100%);
   
   /* Legacy mappings */
   --primary-blue: var(--primary);
   --text-primary: var(--heading-text);
   --text-secondary: var(--body-text);
   --white: var(--bg-white);
}

body {
  background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
  font-family: 'Inter', sans-serif;
  padding: 0;
  margin: 0;
  min-height: 100vh;
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

/* Blue Sidebar with Curved Design - Updated Colors */
.career-sidebar {
   background: var(--gradient-primary);
   width: 280px;
   min-height: 100vh;
   position: fixed;
   left: 0;
   top: 0;
   z-index: 1000;
   padding: 0;
   box-shadow: var(--shadow-md);
   transition: transform 0.3s ease;
   border-radius: 0 20px 20px 0;
   backdrop-filter: blur(10px);
}

.sidebar-header {
   padding: 24px 20px;
   border-bottom: 1px solid rgba(255, 255, 255, 0.15);
   display: flex;
   align-items: center;
   justify-content: center;
   gap: 15px;
   min-height: 80px;
}  

.sidebar-logo {
   width: 48px;
   height: 48px;
   background-image: url('${pageContext.request.contextPath}/assets/images/logo/logo.png');
   background-repeat: no-repeat;
   background-position: center;
   background-size: contain;
   flex-shrink: 0;
}

.sidebar-company-name {
   color: white;
   font-weight: 700;
   font-size: 1.1rem;
   line-height: 1.2;
}

.sidebar-dashboard-btn {
   display: flex;
   align-items: center;
   gap: 14px;
   padding: 14px 24px;
   text-decoration: none;
   color: #ffffff;
   border: none;
   background: transparent;
   justify-content: flex-start;
   width: 100%;
   margin: 8px 0;
}

.sidebar-dashboard-btn i {
   font-size: 1.2rem;
   min-width: 20px;
}

.sidebar-dashboard-btn:hover {
   background: rgba(255, 255, 255, 0.1);
   color: #ffffff;
}

.sidebar-nav {
   list-style: none;
   padding: 0;
   margin: 0;
}

.sidebar-nav li {
   margin: 0;
}

.sidebar-nav a {
   display: flex;
   align-items: center;
   gap: 14px;
   padding: 14px 24px;
   color: #ffffff;
   text-decoration: none;
   font-weight: 500;
   font-size: 0.95rem;
   transition: all 0.3s ease;
   border-left: 3px solid transparent;
   margin: 2px 8px;
   border-radius: 0 12px 12px 0;
}

.sidebar-nav a i {
   width: 20px;
   text-align: center;
   font-size: 1.1rem;
   color: #ffffff;
}

.sidebar-nav a:hover {
   background: rgba(255, 255, 255, 0.15);
   border-left-color: #ffffff;
   transform: translateX(4px);
}

.sidebar-nav a.active {
   background: rgba(255, 255, 255, 0.2);
   color: #ffffff;
   border-left-color: #ffffff;
   font-weight: 600;
   border-radius: 0 12px 12px 0;
   box-shadow: inset 0 0 20px rgba(255, 255, 255, 0.1);
}

.sidebar-nav a.active i {
   color: #ffffff;
}

.sidebar-nav .submenu {
   list-style: none;
   padding: 0;
   margin: 0;
   background: rgba(0, 0, 0, 0.1);
   max-height: 0;
   overflow: hidden;
   transition: max-height 0.3s ease;
}

.sidebar-nav .submenu.show {
   max-height: 500px;
}

.sidebar-nav .submenu li {
   margin: 0;
}

.sidebar-nav .submenu a {
   padding-left: 58px;
   font-size: 0.9rem;
}

.sidebar-nav .has-submenu > a::after {
   content: '\f107';
   font-family: 'Font Awesome 6 Free';
   font-weight: 900;
   margin-left: auto;
   transition: transform 0.3s ease;
}

.sidebar-nav .has-submenu > a.open::after {
   transform: rotate(180deg);
}

/* Main Content Wrapper */
.main-content-wrapper {
   margin-left: 280px;
   padding: 40px 24px;
   transition: margin-left 0.3s ease;
   position: relative;
   z-index: 1;
   animation: fadeInUp 0.6s ease-out;
}

@keyframes fadeInUp {
   from {
       opacity: 0;
       transform: translateY(20px);
   }
   to {
       opacity: 1;
       transform: translateY(0);
   }
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

/* Page Title */
.page-title {
   text-align: center;
   font-size: 32px;
   font-weight: 800;
   background: var(--gradient-primary);
   -webkit-background-clip: text;
   -webkit-text-fill-color: transparent;
   background-clip: text;
   margin-bottom: 36px;
   display: flex;
   align-items: center;
   justify-content: center;
   gap: 12px;
}

.page-title i {
   background: var(--gradient-primary);
   -webkit-background-clip: text;
   -webkit-text-fill-color: transparent;
   background-clip: text;
   font-size: 32px;
}

/* Stats Bar */
.stats-bar {
   display: flex;
   justify-content: center;
   gap: 24px;
   margin-bottom: 32px;
}

.stat-pill {
   background: var(--bg-white);
   border: 1px solid rgba(25, 167, 123, 0.15);
   border-radius: 40px;
   padding: 12px 24px;
   display: flex;
   align-items: center;
   gap: 12px;
   box-shadow: var(--shadow-sm);
   backdrop-filter: blur(10px);
}

.stat-pill i {
   color: var(--primary);
   font-size: 20px;
}

.stat-pill span {
   font-size: 15px;
   font-weight: 600;
   color: var(--heading-text);
}

.stat-pill .count {
   background: var(--gradient-primary);
   color: white;
   padding: 4px 12px;
   border-radius: 20px;
   font-size: 14px;
   margin-left: 8px;
}

/* ---------- JOB ITEM (Enhanced LinkedIn style) ----------- */
.job-item {
   width: 100%;
   padding: 24px;
   margin-bottom: 16px;
   background: var(--bg-white);
   border: 1px solid rgba(25, 167, 123, 0.1);
   border-radius: 20px;
   display: flex;
   justify-content: space-between;
   align-items: flex-start;
   gap: 20px;
   box-shadow: var(--shadow-sm);
   transition: all 0.3s ease;
   position: relative;
   overflow: hidden;
   animation: itemAppear 0.4s ease-out;
}

@keyframes itemAppear {
   from {
       opacity: 0;
       transform: translateX(-10px);
   }
   to {
       opacity: 1;
       transform: translateX(0);
   }
}

.job-item::before {
   content: '';
   position: absolute;
   top: 0;
   left: 0;
   width: 4px;
   height: 100%;
   background: var(--gradient-primary);
   opacity: 0;
   transition: opacity 0.3s ease;
}

.job-item:hover {
   transform: translateX(6px);
   border-color: var(--primary);
   box-shadow: var(--shadow-md), var(--glow-primary);
}

.job-item:hover::before {
   opacity: 1;
}

.left-section {
   display: flex;
   gap: 20px;
}

.job-logo img {
   width: 60px;
   height: 60px;
   border-radius: 14px;
   object-fit: cover;
   background: #f4f4f4;
   border: 1px solid rgba(25, 167, 123, 0.15);
}

.job-logo .company-logo-fallback {
   width: 60px;
   height: 60px;
   border-radius: 14px;
   background: var(--gradient-primary);
   color: #fff;
   font-weight: 700;
   font-size: 24px;
   display: flex;
   align-items: center;
   justify-content: center;
   border: 1px solid rgba(25, 167, 123, 0.15);
   box-shadow: var(--glow-primary);
}

.job-details .job-title {
   font-size: 18px;
   font-weight: 700;
   color: var(--heading-text);
   margin-bottom: 6px;
}

.company-line {
   font-size: 14px;
   color: var(--text-secondary);
   margin-bottom: 12px;
   display: flex;
   align-items: center;
   gap: 6px;
}

.company-line i {
   color: var(--primary);
   font-size: 12px;
}

/* Status chip */
.status-chip {
   display: inline-flex;
   align-items: center;
   gap: 6px;
   padding: 6px 16px;
   border-radius: 30px;
   background: rgba(25, 167, 123, 0.1);
   color: var(--primary);
   font-size: 13px;
   font-weight: 600;
   border: 1px solid rgba(25, 167, 123, 0.2);
}

.status-chip i {
   font-size: 12px;
}

/* -------- RIGHT SECTION -------- */
.right-section {
   text-align: right;
   min-width: 220px;
}

.applied-date,
.interview-date {
   font-size: 14px;
   color: var(--text-secondary);
   margin-bottom: 8px;
   display: flex;
   align-items: center;
   justify-content: flex-end;
   gap: 6px;
}

.applied-date i,
.interview-date i {
   color: var(--primary);
}

.report-btn {
   margin-top: 12px;
   display: inline-flex;
   align-items: center;
   gap: 6px;
   font-size: 13px;
   font-weight: 600;
   padding: 8px 16px;
   color: var(--danger, #ef4444);
   border: 1px solid rgba(239, 68, 68, 0.3);
   border-radius: 30px;
   transition: all 0.3s ease;
   text-decoration: none;
   background: rgba(239, 68, 68, 0.05);
}

.report-btn:hover {
   background: #ef4444;
   color: white;
   border-color: #ef4444;
   transform: translateY(-2px);
   box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
}

/* Empty State */
.alert-info {
   background: var(--bg-white);
   border: 1px solid rgba(25, 167, 123, 0.15);
   border-radius: 20px;
   padding: 48px 24px;
   text-align: center;
   font-size: 16px;
   color: var(--text-secondary);
   box-shadow: var(--shadow-sm);
}

.alert-info > i {
   font-size: 48px;
   color: var(--primary);
   opacity: 0.3;
   margin-bottom: 16px;
   display: block;
}

.btn-primary-custom {
   display: inline-flex;
   align-items: center;
   gap: 10px;
   font-size: 15px;
   font-weight: 600;
   padding: 12px 30px;
   color: #ffffff !important;
   background: var(--gradient-primary);
   border: none;
   border-radius: 30px;
   transition: all 0.3s ease;
   text-decoration: none;
   box-shadow: 0 4px 12px rgba(25, 167, 123, 0.2);
}

.btn-primary-custom:hover {
   transform: translateY(-2px);
   box-shadow: 0 6px 20px rgba(25, 167, 123, 0.35);
   color: #ffffff !important;
}

.btn-primary-custom i {
   font-size: 14px;
   color: #ffffff !important;
   opacity: 1 !important;
   display: inline-block !important;
   margin-bottom: 0 !important;
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

@media (max-width: 768px) {
   .job-item {
       flex-direction: column;
       padding: 20px;
   }

   .right-section {
       text-align: left;
       min-width: 100%;
       margin-top: 16px;
       padding-top: 16px;
       border-top: 1px solid #e2e8f0;
   }

   .applied-date,
   .interview-date {
       justify-content: flex-start;
   }

   .stats-bar {
       flex-direction: column;
       align-items: center;
   }

   .page-title {
       font-size: 26px;
   }
}

@media (max-width: 576px) {
   .main-content-wrapper {
       padding: 20px 15px;
   }

   .left-section {
       flex-direction: column;
       align-items: flex-start;
   }
}
</style>
</head>
<body>
<jsp:include page="/views/commons/student_sidebar.jsp" />

<!-- Main Content -->
<div class="main-content-wrapper">
<div class="container">
  <h2 class="page-title">
    <i class="fas fa-tasks"></i>
    My Job Applications
  </h2>
  
  <c:if test="${not empty applications}">
    <div class="stats-bar">
      <div class="stat-pill">
        <i class="fas fa-paper-plane"></i>
        <span>Total Applications <span class="count">${fn:length(applications)}</span></span>
      </div>
    </div>
  </c:if>

  <c:choose>
      <c:when test="${empty applications}">
          <div class="alert alert-info">
              <i class="fas fa-briefcase"></i>
              <strong style="color: var(--heading-text);">You haven't applied for any jobs yet.</strong><br>
              <span style="font-size: 14px;">Browse available jobs and start applying today!</span>
              <br><br>
              <a href="${pageContext.request.contextPath}/jobs/all" class="btn-primary-custom">
                <i class="fas fa-search"></i> Browse Jobs
              </a>
          </div>
      </c:when>
      <c:otherwise>
          <c:forEach var="app" items="${applications}" varStatus="status">
              <div class="job-item" style="animation-delay: ${status.index * 0.05}s;">
                  <!-- LEFT BLOCK -->
                  <div class="left-section">
                      <div class="job-logo">
                          <c:choose>
                              <c:when test='${not empty app.job.company.logo}'>
                                  <img src="${pageContext.request.contextPath}${app.job.company.logo}" 
                                       alt="${app.job.company.name}"
                                       onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';" />
                                  <div class="company-logo-fallback" style="display:none;">
                                      ${fn:substring(app.job.company.name, 0, 1)}
                                  </div>
                              </c:when>
                              <c:otherwise>
                                  <div class="company-logo-fallback">
                                      ${fn:substring(app.job.company.name, 0, 1)}
                                  </div>
                              </c:otherwise>
                          </c:choose>
                      </div>
                      <div class="job-details">
                          <div class="job-title">${app.job.title}</div>
                          <div class="company-line">
                              <i class="fas fa-building"></i> ${app.job.company.name}
                          </div>
                          <span class="status-chip">
                              <i class="fas fa-circle"></i>
                              <c:choose>
                                  <c:when test="${app.status == 'VIEWED_BY_RECRUITER'}">Viewed by Recruiter</c:when>
                                  <c:when test="${app.status == 'INTERVIEW_SCHEDULED'}">Interview Scheduled</c:when>
                                  <c:otherwise>${fn:replace(app.status, '_', ' ')}</c:otherwise>
                              </c:choose>
                          </span>
                      </div>
                  </div>
                  <!-- RIGHT BLOCK -->
                  <div class="right-section">
                      <div class="applied-date">
                          <i class="far fa-calendar-alt"></i>
                          Applied on: <strong>${app.appliedDate}</strong>
                      </div>
                     
<%
   JobApplication appObj = (JobApplication) pageContext.getAttribute("app");
   java.time.LocalDateTime interviewDate = appObj != null ? appObj.getInterviewDate() : null;
   String formattedInterview = null;
   if (interviewDate != null) {
       DateTimeFormatter fmt = DateTimeFormatter.ofPattern("MMMM dd, yyyy 'at' hh:mm a");
       formattedInterview = interviewDate.format(fmt);
   }
%>
<c:if test="${formattedInterview != null}">
   <div class="interview-date">
       <i class="fas fa-video"></i>
       Interview: <strong><%= formattedInterview %></strong>
   </div>
</c:if>

                      <a href="${pageContext.request.contextPath}/report/${app.job.id}" class="report-btn">
                          <i class="fa fa-flag"></i> Report Job
                      </a>
                  </div>
              </div>
          </c:forEach>
      </c:otherwise>
    </c:choose>
</div>
</div>

<script>


  // Keyboard shortcuts
  document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
      const sidebar = document.getElementById('careerSidebar');
      const overlay = document.querySelector('.sidebar-overlay');
      sidebar.classList.remove('show');
      overlay.classList.remove('show');
    }
  });
</script>
</body>
</html>