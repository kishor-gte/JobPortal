<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page import="in.sp.main.Entities.JobSeeker" %>
<%
    JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
    pageContext.setAttribute("jobSeeker", jobSeeker);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Saved Jobs | SmartInterview</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
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
            --text-secondary: #64748b;
            --border-color: #e0e6ed;
            --white: #ffffff;
            --success: #19A77B;
            --danger: #ef4444;
            --warning: #f59e0b;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
            --background-light: #f6f9fc;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: var(--text-primary);
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

        /* Page Header Slim (White Style) */
        .page-header {
            background: #fff !important;
            border-bottom: 1px solid var(--border-color, #e0e6ed) !important;
            padding: 16px 24px !important;
            margin-bottom: 2rem !important;
            position: relative !important;
            z-index: 5 !important;
            box-shadow: none !important;
        }
        .page-header h1 {
            font-size: 20px !important;
            font-weight: 700 !important;
            margin: 0 !important;
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
            color: var(--primary, #19A77B) !important;
        }
        .page-header h1 i {
            color: var(--primary, #19A77B) !important;
        }
        .page-header p {
            display: none !important;
        }
        .page-header::before {
            display: none !important;
        }

        /* Stats Bar */
        .stats-bar {
            display: flex;
            gap: 16px;
            margin-bottom: 24px;
        }

        .stat-pill {
            background: var(--white);
            border: 1px solid var(--border-color);
            border-radius: 40px;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: var(--shadow-sm);
        }

        .stat-pill i {
            color: var(--primary);
        }

        .stat-pill span {
            font-size: 14px;
            font-weight: 500;
            color: var(--text-primary);
        }

        .stat-pill .count {
            background: var(--gradient-primary);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            margin-left: 8px;
        }

        /* Job Cards */
        .job-card {
            background: var(--white);
            border-radius: 16px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            border-left: 4px solid transparent;
            border: 1px solid var(--border-color);
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateX(-10px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .job-card:hover {
            transform: translateX(6px);
            box-shadow: var(--shadow-md), var(--glow-primary);
            border-color: var(--primary);
            background: #fafdfc;
        }

        .job-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            gap: 0.75rem;
            flex-wrap: wrap;
        }

        .job-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin: 0;
            line-height: 1.4;
        }

        .job-badges {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .badge-custom {
            padding: 5px 12px;
            border-radius: 30px;
            font-size: 0.75rem;
            font-weight: 600;
            border: 1px solid transparent;
        }

        .badge-primary-custom {
            background: rgba(25, 167, 123, 0.12);
            color: var(--primary);
            border-color: rgba(25, 167, 123, 0.3);
        }

        .badge-success-custom {
            background: rgba(25, 167, 123, 0.12);
            color: var(--success);
            border-color: rgba(25, 167, 123, 0.3);
        }

        .badge-warning-custom {
            background: rgba(245, 158, 11, 0.12);
            color: var(--warning);
            border-color: rgba(245, 158, 11, 0.3);
        }

        .job-company {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
        }

        .company-logo {
            width: 48px;
            height: 48px;
            border-radius: 10px;
            background: rgba(25, 167, 123, 0.08);
            border: 1px solid rgba(25, 167, 123, 0.15);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            flex-shrink: 0;
        }

        .company-logo img {
            width: 100%;
            height: 100%;
            object-fit: contain;
            padding: 6px;
        }

        .company-logo-fallback {
            width: 100%;
            height: 100%;
            background: var(--gradient-primary);
            color: #fff;
            font-weight: 700;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            text-transform: uppercase;
        }

        .company-name {
            font-size: 1rem;
            font-weight: 600;
            color: var(--primary);
        }

        .job-description {
            color: var(--text-secondary);
            font-size: 0.9rem;
            line-height: 1.6;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .job-details {
            display: flex;
            flex-wrap: wrap;
            gap: 1.25rem;
            margin-bottom: 1.25rem;
        }

        .job-detail-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        .job-detail-item i {
            color: var(--primary);
            width: 18px;
        }

        .job-detail-item strong {
            color: var(--text-primary);
            margin-right: 0.25rem;
        }

        .job-actions {
            display: flex;
            gap: 10px;
        }

        .icon-btn {
            width: 42px;
            height: 42px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
            background: #f9fbff;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .icon-btn i {
            font-size: 1.1rem;
        }

        .icon-btn.view:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        .icon-btn.apply:hover {
            background: var(--success);
            color: white;
            border-color: var(--success);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .icon-btn.remove:hover {
            background: var(--danger);
            color: white;
            border-color: var(--danger);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .job-footer {
            margin-top: 1.25rem;
            padding-top: 1.25rem;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .saved-date {
            color: var(--text-secondary);
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .saved-date i {
            color: var(--primary);
        }

        /* Alerts */
        .alert-custom {
            border-radius: 16px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid transparent;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success-custom {
            background: rgba(25, 167, 123, 0.1);
            border-color: rgba(25, 167, 123, 0.3);
            color: var(--success);
        }

        .alert-danger-custom {
            background: rgba(239, 68, 68, 0.08);
            border-color: rgba(239, 68, 68, 0.2);
            color: var(--danger);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
        }

        .empty-state > i {
            font-size: 4rem;
            color: var(--primary);
            opacity: 0.3;
            margin-bottom: 1.5rem;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .empty-state h3 {
            color: var(--text-primary);
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: var(--text-secondary);
            margin-bottom: 1.5rem;
        }

        .empty-state .btn {
            background: var(--gradient-primary);
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.95rem;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
            width: auto;
        }

        .empty-state .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        /* Blue Sidebar with Curved Design */
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
            min-height: 90px;
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
            padding: 0;
            transition: margin-left 0.3s ease;
            position: relative;
            z-index: 5;
        }

        .container {
            padding: 0 24px;
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

            .page-header h1 {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 576px) {
            .page-header {
                padding: 1.5rem 0;
            }

            .job-card {
                padding: 1.25rem;
            }

            .job-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .job-details {
                flex-direction: column;
                gap: 0.75rem;
            }

            .stats-bar {
                flex-direction: column;
            }

            .container {
                padding: 0 16px;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/views/commons/student_sidebar.jsp" />

<!-- Main Content -->
<div class="main-content-wrapper">

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-bookmark me-2"></i>Your Saved Jobs</h1>
            <p>Jobs you've saved for later review</p>
        </div>
    </div>

    <div class="container">
        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="alert-custom alert-success-custom">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert-custom alert-danger-custom">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <!-- Stats Bar -->
        <c:if test="${not empty savedJobs}">
            <div class="stats-bar">
                <div class="stat-pill">
                    <i class="fas fa-bookmark"></i>
                    <span>Saved Jobs <span class="count">${fn:length(savedJobs)}</span></span>
                </div>
            </div>
        </c:if>

        <!-- Job Listings -->
        <c:choose>
            <c:when test="${empty savedJobs}">
                <div class="empty-state">
                    <i class="fas fa-bookmark"></i>
                    <h3>No Saved Jobs</h3>
                    <p>You haven't saved any jobs yet. Start browsing and save jobs you're interested in!</p>
                    <a href="${pageContext.request.contextPath}/jobs/all" class="btn">
                        <i class="fas fa-search me-2"></i>Browse Jobs
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="job" items="${savedJobs}" varStatus="status">
                    <div class="job-card" style="animation-delay: ${status.index * 0.05}s;">
                        <div class="job-header">
                            <h3 class="job-title">${job.title}</h3>
                            <div class="job-badges">
                                <c:if test="${not empty job.employmentType}">
                                    <span class="badge-custom badge-primary-custom">
                                        <i class="fas fa-briefcase me-1"></i>${job.employmentType}
                                    </span>
                                </c:if>
                                <c:if test="${not empty job.workMode}">
                                    <span class="badge-custom badge-success-custom">
                                        <i class="fas fa-building me-1"></i>${job.workMode}
                                    </span>
                                </c:if>
                                <span class="badge-custom badge-warning-custom">
                                    <i class="fas fa-bookmark me-1"></i> Saved
                                </span>
                            </div>
                        </div>

                        <div class="job-company">
                            <div class="company-logo">
                                <c:choose>
                                    <c:when test="${not empty job.company.logo}">
                                        <img 
                                            src="${pageContext.request.contextPath}${job.company.logo}"
                                            alt="${job.company.name}"
                                            onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';"
                                        />
                                    </c:when>
                                    <c:otherwise>
                                        <div class="company-logo-fallback">
                                            ${fn:substring(job.company.name, 0, 1)}
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="company-name">${job.company.name}</div>
                        </div>

                        <c:if test="${not empty job.description}">
                            <div class="job-description">
                                ${fn:substring(job.description, 0, 200)}${fn:length(job.description) > 200 ? '...' : ''}
                            </div>
                        </c:if>

                        <div class="job-details">
                            <c:if test="${not empty job.location}">
                                <div class="job-detail-item">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <strong>Location:</strong> ${job.location}
                                </div>
                            </c:if>
                            <c:if test="${not empty job.education}">
                                <div class="job-detail-item">
                                    <i class="fas fa-graduation-cap"></i>
                                    <strong>Education:</strong> ${job.education}
                                </div>
                            </c:if>
                            <c:if test="${not empty job.experienceRequired}">
                                <div class="job-detail-item">
                                    <i class="fas fa-user-tie"></i>
                                    <strong>Experience:</strong> ${job.experienceRequired} years
                                </div>
                            </c:if>
                            <c:if test="${not empty job.salaryMin || not empty job.salaryMax}">
                                <div class="job-detail-item">
                                    <i class="fas fa-wallet"></i>
                                    <strong>Salary:</strong>
                                    <c:if test="${not empty job.salaryMin}">${job.salaryMin}</c:if>
                                    <c:if test="${not empty job.salaryMin && not empty job.salaryMax}"> - </c:if>
                                    <c:if test="${not empty job.salaryMax}">${job.salaryMax}</c:if>
                                </div>
                            </c:if>
                        </div>

                        <div class="job-actions">
                            <form action="${pageContext.request.contextPath}/jobs/details/${job.id}" method="get">
                                <button type="submit" class="icon-btn view" title="View Details">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </form>

                            <form action="${pageContext.request.contextPath}/applications/apply" method="post">
                                <input type="hidden" name="jobId" value="${job.id}" />
                                <button type="submit" class="icon-btn apply" title="Apply Now">
                                    <i class="fas fa-paper-plane"></i>
                                </button>
                            </form>

                            <form method="post" action="${pageContext.request.contextPath}/seeker/remove-saved-job">
                                <c:if test="${not empty _csrf}">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                </c:if>
                                <input type="hidden" name="jobId" value="${job.id}">
                                <button type="submit" class="icon-btn remove" title="Remove Saved Job" onclick="return confirm('Remove this job from saved jobs?');">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </form>
                        </div>

                        <div class="job-footer">
                            <div class="saved-date">
                                <i class="fas fa-bookmark"></i>
                                <span>Saved Job</span>
                            </div>
                            <c:if test="${not empty job.postedDate}">
                                <div class="saved-date">
                                    <i class="fas fa-clock"></i>
                                    <span class="relative-date" data-date="${job.postedDate}">Posted: ${job.postedDate}</span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Relative Date Function
        function getRelativeDate(dateStr) {
            if (!dateStr) return '';
            const postedDate = new Date(dateStr);
            const now = new Date();
            const diffTime = now - postedDate;
            const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));

            if (diffDays === 0) {
                return "Today";
            } else if (diffDays === 1) {
                return "1 day ago";
            } else if (diffDays < 7) {
                return diffDays + " days ago";
            } else if (diffDays < 30) {
                const weeks = Math.floor(diffDays / 7);
                return weeks + (weeks === 1 ? " week ago" : " weeks ago");
            } else if (diffDays < 365) {
                const months = Math.floor(diffDays / 30);
                return months + (months === 1 ? " month ago" : " months ago");
            } else {
                const years = Math.floor(diffDays / 365);
                return years + (years === 1 ? " year ago" : " years ago");
            }
        }

        // Update relative dates on page load
        document.addEventListener("DOMContentLoaded", () => {
            const dateElements = document.querySelectorAll(".relative-date");
            dateElements.forEach(el => {
                const rawDate = el.getAttribute("data-date");
                if (rawDate) {
                    const relativeDate = getRelativeDate(rawDate);
                    if (relativeDate) {
                        el.textContent = "Posted: " + relativeDate;
                    }
                }
            });
        });



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