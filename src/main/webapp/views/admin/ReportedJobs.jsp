<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page import="java.time.*, java.time.format.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Reported Jobs | JobU Admin - Moderation Center</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    
    <style>
        /* ============================================
           PREMIUM COLOR SCHEME
           --primary: #19A77B
           --primary-dark: #148F69
           --accent: #3BC49A
           --bg-dark: #2E3E41
        ============================================ */
        
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --accent-light: #6ed4b2;
            --bg-dark: #2E3E41;
            --bg-dark-light: #3d5256;
            --bg-light: #eef3f0;
            --card-bg: rgba(255, 255, 255, 0.98);
            --text-dark: #1e2a2e;
            --text-muted: #5b7c6e;
            --success: #19A77B;
            --success-dark: #148F69;
            --danger: #ef4444;
            --danger-dark: #dc2626;
            --warning: #f59e0b;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
            --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 20px;
            --radius-lg: 28px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #e0ece6 100%);
            color: var(--text-dark);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* animated background mesh */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 15% 30%, rgba(25,167,123,0.05) 0%, transparent 40%),
                radial-gradient(circle at 85% 70%, rgba(59,196,154,0.04) 0%, transparent 45%),
                radial-gradient(circle at 50% 90%, rgba(25,167,123,0.03) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: meshFloat 18s ease-in-out infinite alternate;
        }

        @keyframes meshFloat {
            0% { opacity: 0.5; transform: scale(1); }
            100% { opacity: 1; transform: scale(1.03); }
        }

        /* floating particles */
        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 20% 40%, rgba(25,167,123,0.06) 1px, transparent 1px);
            background-size: 32px 32px;
            pointer-events: none;
            animation: particleDrift 25s linear infinite;
        }

        @keyframes particleDrift {
            0% { background-position: 0 0; }
            100% { background-position: 65px 65px; }
        }

        /* floating decorative shapes */
        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        /* Page Header Premium */
        .page-header {
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2.5rem 0;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(59,196,154,0.15), transparent);
            border-radius: 50%;
            animation: floatGlow 15s ease-in-out infinite;
        }

        @keyframes floatGlow {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(-30px, 20px) scale(1.1); }
        }

        .page-header h1 {
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .page-header p {
            font-size: 1rem;
            opacity: 0.85;
            position: relative;
            z-index: 1;
        }

        .report-count {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(8px);
            padding: 0.5rem 1.2rem;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 500;
            margin-top: 0.75rem;
            position: relative;
            z-index: 1;
        }

        /* Filter Section Premium */
        .filter-section {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            padding: 1.8rem;
            box-shadow: var(--shadow-md), 0 0 0 1px rgba(25,167,123,0.08);
            margin-bottom: 2rem;
            transition: var(--transition);
        }

        .filter-section:hover {
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.15);
        }

        .filter-section label {
            font-weight: 700;
            color: var(--bg-dark);
            margin-bottom: 0.5rem;
            display: block;
            font-size: 0.8rem;
            letter-spacing: 0.5px;
        }

        .filter-section input,
        .filter-section select {
            border-radius: 50px;
            border: 2px solid #e2ede7;
            padding: 0.7rem 1.2rem;
            font-size: 0.9rem;
            transition: var(--transition);
            background: white;
        }

        .filter-section input:focus,
        .filter-section select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25, 167, 123, 0.12);
            outline: none;
        }

        .btn-primary {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            border: none;
            border-radius: 50px;
            padding: 0.7rem 1.5rem;
            font-weight: 700;
            transition: var(--transition);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        .btn-outline-secondary {
            border-radius: 50px;
            padding: 0.7rem 1.5rem;
            font-weight: 600;
            border: 2px solid #e2ede7;
            color: var(--text-muted);
        }

        .btn-outline-secondary:hover {
            border-color: var(--primary);
            color: var(--primary);
        }

        /* Report Cards Premium */
        .report-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            padding: 2rem;
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.08);
            transition: var(--transition);
            margin-bottom: 1.8rem;
            position: relative;
            overflow: hidden;
            animation: cardFadeIn 0.5s ease-out both;
        }

        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .report-card:nth-child(1) { animation-delay: 0.05s; }
        .report-card:nth-child(2) { animation-delay: 0.1s; }
        .report-card:nth-child(3) { animation-delay: 0.15s; }
        .report-card:nth-child(4) { animation-delay: 0.2s; }

        .report-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Card accent border */
        .report-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--danger), var(--accent));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }

        .report-card:hover::before {
            transform: scaleX(1);
        }

        .report-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .report-title {
            font-size: 1.4rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .report-title i {
            color: var(--danger);
            background: none;
            -webkit-background-clip: unset;
        }

        .report-details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid rgba(25,167,123,0.1);
        }

        .detail-item {
            background: rgba(25,167,123,0.03);
            border-radius: var(--radius-sm);
            padding: 0.75rem 1rem;
            transition: var(--transition);
        }

        .detail-item:hover {
            background: rgba(25,167,123,0.06);
            transform: translateX(4px);
        }

        .detail-label {
            font-size: 0.7rem;
            font-weight: 700;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
            display: block;
        }

        .detail-value {
            font-size: 0.9rem;
            color: var(--text-dark);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            word-break: break-word;
        }

        .detail-value i {
            color: var(--primary);
            width: 18px;
            flex-shrink: 0;
        }

        /* Reason Box Premium */
        .reason-box {
            background: rgba(239, 68, 68, 0.05);
            border-left: 4px solid var(--danger);
            border-radius: var(--radius-sm);
            padding: 1rem 1.25rem;
            margin-bottom: 1.5rem;
            transition: var(--transition);
        }

        .reason-box:hover {
            background: rgba(239, 68, 68, 0.08);
        }

        .reason-box strong {
            color: var(--danger);
            display: block;
            margin-bottom: 0.5rem;
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .reason-box p {
            color: var(--text-dark);
            margin: 0;
            font-weight: 500;
        }

        /* Action Buttons Premium */
        .report-actions {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.85rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.6rem;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }

        .btn-resolve {
            background: linear-gradient(105deg, var(--success), var(--success-dark));
            color: white;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-resolve:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25, 167, 123, 0.4);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(105deg, var(--danger), var(--danger-dark));
            color: white;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .btn-delete:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
            color: white;
        }

        .btn-action i {
            font-size: 0.85rem;
            transition: transform 0.2s;
        }

        .btn-action:hover i {
            transform: scale(1.1);
        }

        /* Empty State Premium */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
        }

        .empty-state i {
            font-size: 4rem;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--bg-dark);
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: var(--text-muted);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header h1 { font-size: 1.5rem; }
            .report-title { font-size: 1.2rem; }
            .report-details-grid { grid-template-columns: 1fr; }
            .report-actions { flex-direction: column; }
            .btn-action { width: 100%; }
            .filter-section .d-flex { flex-direction: column; }
            .filter-section .btn { width: 100%; }
        }

        @media (max-width: 576px) {
            .page-header { padding: 1.5rem 0; }
            .report-card { padding: 1.5rem; }
            .filter-section { padding: 1.2rem; }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection { background: var(--primary); color: white; }
    </style>
<jsp:include page="/views/commons/admin_shell_head.jsp" />
</head>
<body>

<jsp:include page="/views/commons/admin_shell_start.jsp">
  <jsp:param name="pageTitle" value="Reported Jobs"/>
  <jsp:param name="pageSubtitle" value="Review and resolve job reports"/>
  <jsp:param name="activeNav" value="reported"/>
</jsp:include>

<!-- decorative floating elements -->
<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <a href="${pageContext.request.contextPath}/company_dashboard" style="display: inline-flex; align-items: center; gap: 0.5rem; color: white; text-decoration: none; font-size: 0.85rem; font-weight: 600; background: rgba(255,255,255,0.15); backdrop-filter: blur(8px); padding: 0.4rem 1rem; border-radius: 40px; margin-bottom: 0.75rem; transition: all 0.3s ease; border: 1px solid rgba(255,255,255,0.2);" onmouseover="this.style.background='rgba(255,255,255,0.25)'" onmouseout="this.style.background='rgba(255,255,255,0.15)'">
            <i class="fas fa-arrow-left"></i> Back to Company Dashboard
        </a>
        <h1><i class="fas fa-flag me-2" style="color: var(--accent);"></i>Reported Jobs</h1>
        <p>Review and manage job reports submitted by users</p>
        <div class="report-count">
            <i class="fas fa-exclamation-triangle"></i>
            <span id="reportCount">
                <c:set var="reportCount" value="0" />
                <c:forEach var="report" items="${reports}">
                    <c:set var="dt" value="${report.reportedAt}" />
                    <c:set var="companyName" value="${report.job.company.name}" />
                    <c:set var="reportedDate" value="${fn:substring(dt, 0, 10)}" />
                    <c:if test="${empty param.filterDate || reportedDate == param.filterDate}">
                        <c:if test="${empty param.filterCompany || companyName == param.filterCompany}">
                            <c:set var="reportCount" value="${reportCount + 1}" />
                        </c:if>
                    </c:if>
                </c:forEach>
                ${reportCount} Report${reportCount != 1 ? 's' : ''}
            </span>
        </div>
    </div>
</div>

<div class="container">
    <!-- Filter Section -->
    <div class="filter-section">
        <form method="get" action="${pageContext.request.contextPath}/reported-jobs" class="row g-3">
            <div class="col-md-4">
                <label for="filterDate"><i class="fas fa-calendar-alt me-1"></i> Filter by Date</label>
                <input type="date" id="filterDate" name="filterDate" class="form-control" value="${param.filterDate}">
            </div>
            
            <div class="col-md-4">
                <label for="filterCompany"><i class="fas fa-building me-1"></i> Filter by Company</label>
                <select id="filterCompany" name="filterCompany" class="form-select">
                    <option value="">All Companies</option>
                    <c:forEach var="company" items="${companies}">
                        <option value="${company.name}" ${company.name == param.filterCompany ? 'selected' : ''}>
                            ${company.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="col-md-4 d-flex align-items-end">
                <div class="w-100 d-flex gap-2">
                    <button type="submit" class="btn btn-primary flex-grow-1">
                        <i class="fas fa-filter me-1"></i>Apply Filter
                    </button>
                    <c:if test="${not empty param.filterDate or not empty param.filterCompany}">
                        <a href="${pageContext.request.contextPath}/reported-jobs" class="btn btn-outline-secondary">
                            <i class="fas fa-times me-1"></i>Clear
                        </a>
                    </c:if>
                </div>
            </div>
        </form>
    </div>

    <!-- Reported Jobs Listings -->
    <c:set var="hasReports" value="false" />
    <c:forEach var="report" items="${reports}">
        <c:set var="dt" value="${report.reportedAt}" />
        <c:set var="companyName" value="${report.job.company.name}" />
        <c:set var="reportedDate" value="${fn:substring(dt, 0, 10)}" />
        <c:if test="${empty param.filterDate || reportedDate == param.filterDate}">
            <c:if test="${empty param.filterCompany || companyName == param.filterCompany}">
                <c:set var="hasReports" value="true" />
            </c:if>
        </c:if>
    </c:forEach>

    <c:choose>
        <c:when test="${not hasReports}">
            <div class="empty-state">
                <i class="fas fa-check-circle"></i>
                <h3>No Reported Jobs</h3>
                <p>There are no reported jobs matching your filters at the moment.</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="report" items="${reports}">
                <c:set var="dt" value="${report.reportedAt}" />
                <c:set var="companyName" value="${report.job.company.name}" />
                <c:set var="reportedDate" value="${fn:substring(dt, 0, 10)}" />
                
                <c:if test="${empty param.filterDate || reportedDate == param.filterDate}">
                    <c:if test="${empty param.filterCompany || companyName == param.filterCompany}">
                        <div class="report-card">
                            <div class="report-header">
                                <h3 class="report-title">
                                    <i class="fas fa-briefcase"></i>
                                    ${report.job.title}
                                </h3>
                            </div>

                            <div class="report-details-grid">
                                <div class="detail-item">
                                    <span class="detail-label">Reported By</span>
                                    <span class="detail-value">
                                        <i class="fas fa-user"></i>
                                        ${report.reporter.name}
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">Company</span>
                                    <span class="detail-value">
                                        <i class="fas fa-building"></i>
                                        ${report.job.company.name}
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-label">Reported Date</span>
                                    <span class="detail-value">
                                        <i class="fas fa-calendar"></i>
                                        <%
                                            Object reportObj = pageContext.getAttribute("report");
                                            if (reportObj != null) {
                                                in.sp.main.Entities.ReportedJob r = (in.sp.main.Entities.ReportedJob) reportObj;
                                                LocalDateTime reportedAt = r.getReportedAt();
                                                if (reportedAt != null) {
                                                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy 'at' HH:mm");
                                                    out.print(reportedAt.format(formatter));
                                                }
                                            }
                                        %>
                                    </span>
                                </div>
                            </div>

                            <div class="reason-box">
                                <strong><i class="fas fa-exclamation-circle me-1"></i> Reason for Reporting</strong>
                                <p>${report.reason}</p>
                                <c:if test="${not empty report.additionalInfo}">
                                    <p style="margin-top: 0.75rem; font-size: 0.85rem; color: var(--text-muted); padding-top: 0.5rem; border-top: 1px solid rgba(239,68,68,0.2);">
                                        <strong>Additional Info:</strong> ${report.additionalInfo}
                                    </p>
                                </c:if>
                            </div>

                            <div class="report-actions">
                                <a href="${pageContext.request.contextPath}/resolve-report/${report.id}" 
                                   class="btn-action btn-resolve" 
                                   onclick="return confirm('Mark this report as resolved?');"
                                   style="text-decoration: none;">
                                    <i class="fas fa-check-circle"></i>
                                    Mark as Resolved
                                </a>
                                
                                <a href="${pageContext.request.contextPath}/delete-report/${report.id}" 
                                   class="btn-action btn-delete" 
                                   onclick="return confirm('Are you sure you want to delete this report? This action cannot be undone.');"
                                   style="text-decoration: none;">
                                    <i class="fas fa-trash-alt"></i>
                                    Delete Report
                                </a>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Preserved original mobile responsive script
document.addEventListener('DOMContentLoaded', function() {
    // Restrict future dates in filter
    const dateInput = document.getElementById('filterDate');
    if(dateInput) {
        dateInput.max = new Date().toISOString().split("T")[0];
    }
    
    if (!document.getElementById('mobile-responsive-style')) {
        const style = document.createElement('style');
        style.id = 'mobile-responsive-style';
        style.innerHTML = `
            @media (max-width: 768px) {
                .sidebar, .nav-sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                    position: fixed !important;
                    z-index: 1001 !important;
                    height: 100vh;
                }
                .sidebar.active, .nav-sidebar.active {
                    transform: translateX(0);
                    box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important;
                }
                .main-content {
                    margin-left: 0 !important;
                    padding: 16px !important;
                    width: 100% !important;
                    max-width: 100% !important;
                }
                .stats-grid, .content-grid, .grid, .hr-stats-grid, .hr-content-grid, .profile-grid, .dashboard-grid {
                    grid-template-columns: 1fr !important;
                    display: grid !important; 
                }
                .top-bar {
                    flex-direction: column !important;
                    align-items: flex-start !important;
                    gap: 16px;
                }
                .chat-header {
                    flex-wrap: wrap;
                    gap: 12px;
                }
                .top-bar h1, .chat-header h3 {
                    font-size: 22px !important;
                    display: flex;
                    align-items: center;
                }
                .mobile-menu-btn {
                    display: inline-block !important;
                    background: none;
                    border: none;
                    font-size: 24px;
                    color: inherit;
                    cursor: pointer;
                    margin-right: 12px;
                }
                .mobile-overlay {
                    display: none;
                    position: fixed;
                    top: 0; left: 0; right: 0; bottom: 0;
                    background: rgba(0,0,0,0.5);
                    z-index: 1000;
                }
                .mobile-overlay.active {
                    display: block;
                }
                .chat-sidebar {
                    position: fixed !important;
                    transform: translateX(-100%);
                    transition: transform 0.3s;
                    z-index: 1000;
                }
                .chat-sidebar.active {
                    transform: translateX(0);
                }
                table:not(.table-responsive), table:not(.table-responsive) thead, table:not(.table-responsive) tbody, table:not(.table-responsive) th, table:not(.table-responsive) td, table:not(.table-responsive) tr { 
                    display: block; 
                }
                table:not(.table-responsive) thead tr { 
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
                }
                table:not(.table-responsive) tr { border: 1px solid #e2e8f0; margin-bottom: 12px; border-radius: 8px; overflow:hidden; }
                table:not(.table-responsive) td { 
                    border: none;
                    border-bottom: 1px solid #f1f5f9; 
                    position: relative;
                    padding-left: 50% !important; 
                    text-align: right;
                    font-size: 14px;
                }
                table:not(.table-responsive) td:last-child {
                    border-bottom: none;
                }
                table:not(.table-responsive) td:before { 
                    position: absolute;
                    top: 50%;
                    transform: translateY(-50%);
                    left: 12px;
                    width: 45%; 
                    padding-right: 10px; 
                    white-space: nowrap;
                    content: attr(data-label);
                    font-weight: 600;
                    text-align: left;
                    color: #64748b;
                }
            }
            .mobile-menu-btn { display: none; }
        `;
        document.head.appendChild(style);
    }
    
    const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
    if (sidebar) {
        const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
        let heading = null;
        if (topBar && topBar !== document.body) {
            heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
            if (!heading) heading = topBar;
        } else if (!document.querySelector('.mobile-menu-btn')) {
            heading = document.createElement('div');
            heading.style.padding = '10px';
            document.body.insertBefore(heading, document.body.firstChild);
        }
        if (heading && !document.querySelector('.mobile-menu-btn')) {
            heading.style.display = 'flex';
            heading.style.alignItems = 'center';
            const toggleBtn = document.createElement('button');
            toggleBtn.className = 'mobile-menu-btn';
            toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
            heading.insertBefore(toggleBtn, heading.firstChild);
            const overlay = document.createElement('div');
            overlay.className = 'mobile-overlay';
            document.body.appendChild(overlay);
            let touchstartX = 0, touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { 
                touchendX = e.changedTouches[0].screenX; 
                if (touchendX < touchstartX - 50) closeSidebar(); 
                if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); 
            }, {passive: true});
            function openSidebar() { sidebar.classList.add('active'); overlay.classList.add('active'); document.body.style.overflow = 'hidden'; }
            function closeSidebar() { sidebar.classList.remove('active'); overlay.classList.remove('active'); document.body.style.overflow = ''; }
            toggleBtn.addEventListener('click', openSidebar);
            overlay.addEventListener('click', closeSidebar);
        }
    }
    
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        rows.forEach(row => {
            Array.from(row.querySelectorAll('td')).forEach((td, index) => {
                if(headers[index]) td.setAttribute('data-label', headers[index]);
            });
        });
    });
});
</script>
<jsp:include page="/views/commons/admin_shell_end.jsp" />
</body>
</html>