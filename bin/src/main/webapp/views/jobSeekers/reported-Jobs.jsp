<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page import="java.time.format.DateTimeFormatter, java.time.LocalDateTime" %>
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
    <title>My Reported Jobs | SmartInterview</title>
    
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
            --success: #10b981;
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

        /* Report Card - Enhanced Style */
        .report-card {
            background: var(--white);
            border-radius: 16px;
            padding: 1.25rem 1.5rem;
            margin-bottom: 1rem;
            box-shadow: var(--shadow-sm);
            border-left: 4px solid transparent;
            transition: all 0.3s ease;
            animation: fadeIn 0.4s ease-out;
            border: 1px solid var(--border-color);
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

        .report-card:hover {
            box-shadow: var(--shadow-md), var(--glow-primary);
            border-color: var(--primary);
        }

        .report-card.resolved {
            border-left-color: var(--success);
        }

        .report-card.pending {
            border-left-color: var(--warning);
        }

        /* Card Header */
        .report-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .report-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--text-primary);
            margin: 0;
            line-height: 1.4;
        }

        /* Status badge */
        .status-badge {
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
        }

        .status-resolved {
            background: rgba(16, 185, 129, 0.12);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .status-pending {
            background: rgba(245, 158, 11, 0.12);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        /* Card Content */
        .report-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1rem;
            padding-bottom: 1rem;
            margin-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .report-info-item {
            display: flex;
            flex-direction: column;
            gap: 4px;
        }

        .report-info-label {
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .report-info-value {
            font-size: 0.9rem;
            font-weight: 500;
            color: var(--text-primary);
        }

        /* Company Info */
        .report-company {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .company-logo {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(25, 167, 123, 0.08);
            flex-shrink: 0;
            border: 1px solid rgba(25, 167, 123, 0.15);
        }

        .company-logo-img {
            width: 100%;
            height: 100%;
            object-fit: contain;
        }

        .company-logo-fallback {
            width: 100%;
            height: 100%;
            border-radius: 10px;
            background: var(--gradient-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 700;
            font-size: 1.1rem;
        }

        .company-name {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--primary);
        }

        /* Report Reason Box */
        .report-reason-box {
            background: rgba(25, 167, 123, 0.04);
            border: 1px solid rgba(25, 167, 123, 0.1);
            border-radius: 10px;
            padding: 0.875rem 1rem;
            margin-bottom: 0.75rem;
        }

        .report-reason-box strong {
            font-size: 0.85rem;
            margin-bottom: 0.375rem;
            display: flex;
            align-items: center;
            gap: 6px;
            color: var(--primary);
        }

        .report-reason-box p {
            font-size: 0.9rem;
            line-height: 1.5;
            margin: 0;
            color: var(--text-primary);
        }

        /* Additional Info */
        .report-additional-info {
            background: #f8fafc;
            border-radius: 10px;
            padding: 0.875rem 1rem;
            margin-bottom: 0.75rem;
            border: 1px solid var(--border-color);
        }

        .report-additional-info strong {
            font-size: 0.85rem;
            margin-bottom: 0.375rem;
            display: flex;
            align-items: center;
            gap: 6px;
            color: var(--primary);
        }

        .report-additional-info p {
            font-size: 0.9rem;
            margin: 0;
        }

        /* Footer */
        .report-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 0.5rem;
            gap: 0.75rem;
        }

        .report-date {
            font-size: 0.8rem;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .report-date i {
            color: var(--primary);
        }

        .badge-resolved {
            background: var(--success);
            color: white;
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 0.8rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
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

        /* Empty State */
        .empty-state {
            background: var(--white);
            border-radius: 20px;
            padding: 4rem 2rem;
            text-align: center;
            box-shadow: var(--shadow-sm);
            border: 1px solid var(--border-color);
        }

        .empty-state i {
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
            font-size: 1.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            color: var(--text-primary);
        }

        .empty-state p {
            font-size: 1rem;
            color: var(--text-secondary);
        }

        /* Alert Messages */
        .alert-custom {
            border-radius: 16px;
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 10px;
            border: 1px solid transparent;
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            border-color: rgba(16, 185, 129, 0.3);
            color: var(--success);
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.08);
            border-color: rgba(239, 68, 68, 0.2);
            color: var(--danger);
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
            padding: 0;
            background: transparent;
            min-height: 100vh;
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

        /* Responsive */
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
            .page-header h1 {
                font-size: 1.5rem;
            }

            .report-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .report-title {
                font-size: 1rem;
            }

            .container {
                padding: 0 16px;
            }
        }

        @media (max-width: 576px) {
            .report-card {
                padding: 1rem;
            }

            .report-content {
                grid-template-columns: 1fr;
            }

            .report-footer {
                flex-direction: column;
                align-items: flex-start;
            }

            .stats-bar {
                flex-direction: column;
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
            <h1><i class="fas fa-flag me-2"></i>My Reported Jobs</h1>
            <p>Track the status of jobs you've reported</p>
        </div>
    </div>

    <div class="container">
        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="alert-custom alert-success">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert-custom alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <!-- Stats Bar -->
        <c:if test="${not empty reportedJobs}">
            <div class="stats-bar">
                <div class="stat-pill">
                    <i class="fas fa-flag"></i>
                    <span>Total Reports <span class="count">${fn:length(reportedJobs)}</span></span>
                </div>
                <c:set var="resolvedCount" value="0"/>
                <c:set var="pendingCount" value="0"/>
                <c:forEach var="report" items="${reportedJobs}">
                    <c:if test="${report.resolved}">
                        <c:set var="resolvedCount" value="${resolvedCount + 1}"/>
                    </c:if>
                    <c:if test="${!report.resolved}">
                        <c:set var="pendingCount" value="${pendingCount + 1}"/>
                    </c:if>
                </c:forEach>
                <div class="stat-pill">
                    <i class="fas fa-check-circle" style="color: var(--success);"></i>
                    <span>Resolved <span class="count" style="background: var(--success);">${resolvedCount}</span></span>
                </div>
                <div class="stat-pill">
                    <i class="fas fa-clock" style="color: var(--warning);"></i>
                    <span>Pending <span class="count" style="background: var(--warning);">${pendingCount}</span></span>
                </div>
            </div>
        </c:if>

        <!-- Report Listings -->
        <c:choose>
            <c:when test="${empty reportedJobs}">
                <div class="empty-state">
                    <i class="fas fa-flag"></i>
                    <h3>No Reported Jobs</h3>
                    <p>You haven't reported any jobs yet. If you find a suspicious job posting, use the report button.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="report" items="${reportedJobs}" varStatus="status">
                    <div class="report-card ${report.resolved ? 'resolved' : 'pending'}" style="animation-delay: ${status.index * 0.05}s;">
                        <div class="report-header">
                            <h3 class="report-title">${report.job.title}</h3>
                            <span class="status-badge status-${report.resolved ? 'resolved' : 'pending'}">
                                <i class="fas fa-${report.resolved ? 'check-circle' : 'clock'}"></i>
                                ${report.resolved ? 'Resolved' : 'Pending Review'}
                            </span>
                        </div>

                        <div class="report-content">
                            <div class="report-info-item">
                                <span class="report-info-label">Company</span>
                                <div class="report-company">
                                   <div class="company-logo">
    <c:choose>
        <c:when test="${not empty report.job.company.logo}">
            <img 
                src="${pageContext.request.contextPath}${report.job.company.logo}"
                alt="${report.job.company.name}"
                class="company-logo-img"
            />
        </c:when>
        <c:otherwise>
            <div class="company-logo-fallback">
                ${fn:substring(report.job.company.name, 0, 1)}
            </div>
        </c:otherwise>
    </c:choose>
</div>

                                    <span class="company-name">${report.job.company.name}</span>
                                </div>
                            </div>

                            <div class="report-info-item">
                                <span class="report-info-label">Reported Date</span>
                                <span class="report-info-value">
                                    <%
                                        in.sp.main.Entities.ReportedJob reportObj = (in.sp.main.Entities.ReportedJob) pageContext.getAttribute("report");
                                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy 'at' HH:mm");
                                        String formattedDate = "";
                                        if (reportObj != null && reportObj.getReportedAt() != null) {
                                            formattedDate = reportObj.getReportedAt().format(formatter);
                                        }
                                    %>
                                    <%= formattedDate %>
                                </span>
                            </div>

                            <c:if test="${not empty report.job.location}">
                                <div class="report-info-item">
                                    <span class="report-info-label">Location</span>
                                    <span class="report-info-value">
                                        <i class="fas fa-map-marker-alt me-2" style="color: var(--primary);"></i>${report.job.location}
                                    </span>
                                </div>
                            </c:if>
                        </div>

                        <div class="report-reason-box">
                            <strong><i class="fas fa-exclamation-triangle me-2"></i>Reason for Report</strong>
                            <p>${report.reason}</p>
                        </div>

                        <c:if test="${not empty report.additionalInfo}">
                            <div class="report-additional-info">
                                <strong><i class="fas fa-info-circle me-2"></i>Additional Information</strong>
                                <p>${report.additionalInfo}</p>
                            </div>
                        </c:if>

                        <div class="report-footer">
                            <div class="report-date">
                                <i class="fas fa-calendar-alt"></i>
                                <span>Reported on: 
                                    <%
                                        if (reportObj != null && reportObj.getReportedAt() != null) {
                                            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
                                            out.print(reportObj.getReportedAt().format(dateFormatter));
                                        }
                                    %>
                                </span>
                            </div>
                            <c:if test="${report.resolved}">
                                <span class="badge-resolved">
                                    <i class="fas fa-check-circle"></i> Issue Resolved
                                </span>
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