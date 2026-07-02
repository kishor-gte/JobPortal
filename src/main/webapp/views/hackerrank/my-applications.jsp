<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Applications - SmartInterview</title>
    <meta name="description" content="Track your job applications, resume match scores, and application status.">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
            --border-color: rgba(0, 0, 0, 0.08);
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
            --purple: #8b5cf6;
            --orange: #f97316;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: #ffffff;
            color: var(--text-primary);
            min-height: 100vh;
            position: relative;
        }

        /* Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            padding: 24px 16px;
            z-index: 100;
            overflow-y: auto;
        }

        .sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: transparent;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 3px;
        }

        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 8px 12px 24px;
            border-bottom: 1px solid var(--border-color);
            margin-bottom: 24px;
        }

        .sidebar-logo .icon {
            width: 48px;
            height: 48px;
            background: var(--gradient-primary);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--glow-primary);
            animation: logoGlow 3s ease-in-out infinite;
        }

        @keyframes logoGlow {
            0%, 100% { box-shadow: 0 0 20px rgba(25, 167, 123, 0.2); }
            50% { box-shadow: 0 0 30px rgba(25, 167, 123, 0.4); }
        }

        .sidebar-logo .icon i {
            color: #fff;
            font-size: 24px;
        }

        .sidebar-logo h2 {
            font-size: 20px;
            font-weight: 700;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
        }

        .nav-section {
            margin-bottom: 28px;
        }

        .nav-section h4 {
            color: var(--text-tertiary);
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding: 0 12px;
            margin-bottom: 14px;
            font-weight: 600;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 14px;
            border-radius: 12px;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 4px;
            position: relative;
            overflow: hidden;
        }

        .nav-link i {
            width: 20px;
            text-align: center;
            font-size: 16px;
            transition: transform 0.3s ease;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 3px;
            background: var(--gradient-primary);
            transform: translateX(-100%);
            transition: transform 0.3s ease;
        }

        .nav-link:hover {
            background: var(--hover-bg);
            color: var(--primary);
            transform: translateX(4px);
        }

        .nav-link:hover i {
            transform: scale(1.1);
        }

        .nav-link:hover::before {
            transform: translateX(0);
        }

        .nav-link.active {
            background: var(--hover-bg);
            color: var(--primary);
            box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.05);
        }

        .nav-link.active::before {
            transform: translateX(0);
        }

        .nav-link.active i {
            color: var(--primary);
        }

        /* Main Content */
        .main-content { 
            margin-left: 280px; padding: 28px 36px; 
            position: relative; z-index: 1;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .top-bar {
            display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px;
        }
        .top-bar h1 { 
            font-size: 32px; font-weight: 800; 
            color: var(--text-primary);
            display: flex; align-items: center; gap: 12px;
        }
        .top-bar h1 i {
            color: var(--primary); font-size: 30px;
        }
        
        .user-info { display: flex; align-items: center; gap: 16px; }
        .user-avatar {
            width: 44px; height: 44px;
            background: var(--gradient-primary);
            border-radius: 14px; display: flex; align-items: center; justify-content: center;
            color: #fff; font-weight: 700; font-size: 18px;
            box-shadow: var(--glow-primary);
        }
        .btn-logout {
            padding: 10px 20px; background: #fef2f2;
            border: 1px solid #fecaca; color: var(--danger);
            border-radius: 30px; text-decoration: none; font-size: 13px;
            font-weight: 600; transition: all 0.3s ease;
            display: flex; align-items: center; gap: 8px;
        }
        .btn-logout:hover { 
            background: #fee2e2; 
            border-color: #fca5a5; transform: translateY(-2px);
        }

        /* Alert */
        .alert {
            padding: 16px 20px; border-radius: 16px; margin-bottom: 20px;
            font-size: 14px; display: flex; align-items: center; gap: 12px;
            animation: slideDown 0.4s ease-out;
            font-weight: 500;
        }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
        .alert-success { background: #ecfdf5; border: 1px solid #a7f3d0; color: #059669; }
        .alert-error { background: #fef2f2; border: 1px solid #fecaca; color: #dc2626; }

        /* Stats Strip */
        .stats-strip {
            display: flex; gap: 20px; margin-bottom: 32px;
        }
        .stat-box {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 20px; padding: 24px 28px;
            display: flex; align-items: center; gap: 18px;
            box-shadow: var(--shadow-sm);
            transition: all 0.35s ease; flex: 1;
        }
        .stat-box:hover {
            transform: translateY(-4px);
            border-color: var(--primary);
            box-shadow: var(--shadow-md);
        }
        .stat-box-icon {
            width: 56px; height: 56px; border-radius: 16px;
            display: flex; align-items: center; justify-content: center; font-size: 24px;
        }
        .stat-box-icon.purple { background: #f3e8ff; color: var(--purple); border: 1px solid #e9d5ff; }
        .stat-box-icon.green { background: #ecfdf5; color: var(--success); border: 1px solid #d1fae5; }
        .stat-box-icon.orange { background: #fff7ed; color: var(--warning); border: 1px solid #ffedd5; }
        .stat-box-icon.blue { background: #eff6ff; color: var(--info); border: 1px solid #dbeafe; }
        .stat-box-value { font-size: 34px; font-weight: 800; color: var(--text-primary); }
        .stat-box-label { font-size: 13px; color: var(--text-tertiary); font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; }

        /* Application Cards */
        .applications-list { display: flex; flex-direction: column; gap: 18px; }

        .app-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 24px; padding: 32px;
            box-shadow: var(--shadow-sm);
            transition: all 0.35s ease;
            position: relative; overflow: hidden;
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
        }

        @keyframes cardAppear {
            to { opacity: 1; transform: translateY(0); }
        }

        .app-card::before {
            content: ''; position: absolute; left: 0; top: 0;
            width: 4px; height: 100%;
            background: var(--gradient-primary);
            opacity: 0;
            transition: opacity 0.3s ease;
        }
        .app-card:hover::before { opacity: 1; }

        .app-card.status-applied::before { background: var(--gradient-primary); }
        .app-card.status-viewed::before { background: linear-gradient(180deg, var(--purple), #c084fc); }
        .app-card.status-shortlisted::before { background: linear-gradient(180deg, var(--success), #4ade80); }
        .app-card.status-interview::before { background: linear-gradient(180deg, var(--warning), #fb923c); }
        .app-card.status-rejected::before { background: linear-gradient(180deg, var(--danger), #f87171); }
        .app-card.status-hired::before { background: linear-gradient(180deg, var(--primary), var(--accent)); }

        .app-card:hover {
            transform: translateY(-4px);
            border-color: #cbd5e1;
            box-shadow: var(--shadow-lg);
        }

        .app-card-header {
            display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 18px;
        }
        .app-card-title { font-size: 22px; font-weight: 800; color: var(--text-primary); margin-bottom: 8px; }
        .app-card-company {
            display: flex; align-items: center; gap: 10px;
            font-size: 15px; color: var(--primary); font-weight: 700;
        }

        /* Resume Score Circle */
        .score-ring {
            position: relative; width: 72px; height: 72px;
        }
        .score-ring svg { transform: rotate(-90deg); }
        .score-ring-bg { fill: none; stroke: #f1f5f9; stroke-width: 5; }
        .score-ring-fill { fill: none; stroke-width: 5; stroke-linecap: round; transition: stroke-dashoffset 1.2s ease; }
        .score-ring-fill.high { stroke: var(--success); }
        .score-ring-fill.medium { stroke: var(--warning); }
        .score-ring-fill.low { stroke: var(--danger); }
        .score-ring-text {
            position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
            font-size: 18px; font-weight: 800; color: var(--text-primary);
        }
        .score-ring-label {
            text-align: center; font-size: 11px; color: var(--text-tertiary);
            margin-top: 6px; font-weight: 700; text-transform: uppercase;
        }

        /* Meta Info */
        .app-meta {
            display: flex; flex-wrap: wrap; gap: 20px; margin-bottom: 20px;
        }
        .app-meta-item {
            display: flex; align-items: center; gap: 8px;
            font-size: 14px; font-weight: 500; color: var(--text-secondary);
        }
        .app-meta-item i { font-size: 14px; color: var(--primary); }

        /* Status Badges */
        .status-badge {
            display: inline-flex; align-items: center; gap: 8px;
            padding: 8px 18px; border-radius: 30px;
            font-size: 12px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px;
        }
        .badge-applied { background: #f0fdf4; color: var(--primary); border: 1px solid #bbf7d0; }
        .badge-viewed { background: #faf5ff; color: var(--purple); border: 1px solid #e9d5ff; }
        .badge-shortlisted { background: #ecfdf5; color: var(--success); border: 1px solid #d1fae5; }
        .badge-interview_scheduled { background: #fff7ed; color: var(--warning); border: 1px solid #ffedd5; }
        .badge-rejected { background: #fef2f2; color: var(--danger); border: 1px solid #fecaca; }
        .badge-hired { background: #f0fdf4; color: var(--primary); border: 1px solid #bbf7d0; }

        /* Suggestions Box */
        .suggestions-box {
            margin-top: 18px; padding: 20px 24px;
            background: #fffbeb;
            border: 1px solid #fde68a;
            border-radius: 16px;
        }
        .suggestions-title {
            font-size: 14px; font-weight: 700; color: #d97706;
            display: flex; align-items: center; gap: 10px; margin-bottom: 10px;
        }
        .suggestions-text {
            font-size: 14px; color: #78350f;
            line-height: 1.8; white-space: pre-line;
        }

        /* Cover Letter Box */
        .cover-letter-box {
            margin-top: 16px; padding: 18px 22px;
            background: var(--bg-light-tint);
            border: 1px solid var(--border-color);
            border-radius: 14px;
        }
        .cover-letter-title {
            font-size: 14px; font-weight: 700; color: var(--primary);
            display: flex; align-items: center; gap: 8px; margin-bottom: 8px;
        }
        .cover-letter-text {
            font-size: 14px; color: var(--text-secondary); line-height: 1.7;
        }

        /* Interview Pipeline */
        .interview-pipeline {
            margin-top: 24px; padding: 24px;
            background: #f8fafc;
            border: 1px solid var(--border-color);
            border-radius: 18px;
        }
        .pipeline-title {
            font-size: 18px; font-weight: 800; color: var(--text-primary);
            display: flex; align-items: center; gap: 10px; margin-bottom: 20px;
        }
        .pipeline-title i { color: var(--primary); }
        .pipeline-rounds {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 18px;
        }
        .pipeline-round {
            background: #ffffff;
            border-radius: 16px; padding: 20px;
            border: 1px solid var(--border-color);
            text-align: center; display: flex; flex-direction: column; justify-content: space-between;
            box-shadow: 0 2px 4px rgba(0,0,0,0.02);
        }
        .round-icon {
            width: 52px; height: 52px; margin: 0 auto 14px;
            background: #f0fdf4; border-radius: 50%;
            display: flex; align-items: center; justify-content: center; font-size: 20px; color: var(--primary);
        }
        .round-title { font-size: 15px; font-weight: 700; color: var(--text-primary); margin-bottom: 6px; }
        .round-desc { font-size: 13px; color: var(--text-tertiary); margin-bottom: 18px; }
        .round-btn {
            display: inline-block; width: 100%; padding: 12px;
            background: var(--gradient-primary); color: #fff;
            text-decoration: none; font-size: 13px; font-weight: 700; border-radius: 30px;
            transition: all 0.3s ease; box-shadow: 0 4px 12px rgba(25, 167, 123, 0.2);
        }
        .round-btn:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.35); 
        }
        .round-btn-pending {
            display: inline-block; width: 100%; padding: 12px;
            background: #f1f5f9; color: #94a3b8;
            font-size: 13px; font-weight: 700; border-radius: 30px;
            pointer-events: none;
        }

        /* Action Buttons */
        .app-actions { margin-top: 24px; display: flex; gap: 12px; }
        .btn-view-job {
            padding: 12px 28px; background: var(--gradient-primary);
            color: #fff; border: none; border-radius: 30px; font-size: 14px;
            font-weight: 600; cursor: pointer; text-decoration: none;
            transition: all 0.3s ease; display: inline-flex; align-items: center; gap: 8px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.25);
        }
        .btn-view-job:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 6px 18px rgba(25, 167, 123, 0.4); 
        }
        .btn-browse {
            padding: 12px 28px; background: transparent;
            border: 1px solid #cbd5e1; color: var(--text-secondary);
            border-radius: 30px; font-size: 14px; font-weight: 600;
            text-decoration: none; transition: all 0.3s ease;
            display: inline-flex; align-items: center; gap: 8px;
        }
        .btn-browse:hover { 
            background: var(--hover-bg); border-color: var(--primary); color: var(--primary); 
        }

        /* Empty State */
        .empty-state {
            text-align: center; padding: 80px 40px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            box-shadow: var(--shadow-sm);
        }
        .empty-icon {
            width: 80px; height: 80px; margin: 0 auto 24px;
            background: #f0fdf4; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
        }
        .empty-icon i { font-size: 36px; color: var(--primary); }
        .empty-state h3 { font-size: 24px; font-weight: 800; color: var(--text-primary); margin-bottom: 12px; }
        .empty-state p { font-size: 15px; color: var(--text-secondary); margin-bottom: 28px; max-width: 400px; margin-left: auto; margin-right: auto; line-height: 1.6;}
        .btn-browse-lg {
            padding: 14px 36px; background: var(--gradient-primary);
            color: #fff; border: none; border-radius: 30px; font-size: 15px;
            font-weight: 700; cursor: pointer; text-decoration: none;
            transition: all 0.3s ease; display: inline-flex; align-items: center; gap: 10px;
            box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
        }
        .btn-browse-lg:hover { 
            transform: translateY(-3px); 
            box-shadow: 0 8px 28px rgba(25, 167, 123, 0.4); 
        }

        /* Timeline dots */
        .timeline-dot {
            width: 8px; height: 8px; border-radius: 50%; display: inline-block;
        }
        .dot-applied { background: var(--primary); }
        .dot-viewed { background: var(--purple); }
        .dot-shortlisted { background: var(--success); }
        .dot-interview { background: var(--warning); }
        .dot-rejected { background: var(--danger); }
        .dot-hired { background: var(--accent); }

        /* Responsive */
        @media (max-width: 1024px) {
            .stats-strip { flex-wrap: wrap; }
            .stat-box { min-width: calc(50% - 10px); }
        }
        @media (max-width: 768px) {
            .sidebar { transform: translateX(-100%); transition: transform 0.3s ease; }
            .sidebar.active { transform: translateX(0); }
            .main-content { margin-left: 0 !important; padding: 20px !important; }
            .stats-strip { flex-direction: column; }
            .app-card-header { flex-direction: column; gap: 20px; }
            .top-bar { flex-direction: column; align-items: flex-start; gap: 16px; }
            .top-bar h1 { font-size: 26px; }
        }

        .mobile-menu-btn { display: none; }
        .mobile-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0,0,0,0.5); z-index: 90; display: none;
        }
        .mobile-overlay.active { display: block; }
    </style>
	<jsp:include page="/views/commons/hackerrank_sidebar_styles.jsp" />
</head>
<body>
    <div class="mobile-overlay" id="mobileOverlay"></div>

    <jsp:include page="/views/commons/student_sidebar.jsp" />

    <div class="main-content">
        <div class="top-bar">
            <h1>
                <button class="mobile-menu-btn" id="mobileMenuBtn" style="background: none; border: none; font-size: 24px; color: var(--text-primary); cursor: pointer; margin-right: 15px;">
                    <i class="fas fa-bars"></i>
                </button>
                <i class="fas fa-file-alt"></i>
                My Applications
            </h1>
            <div class="user-info">
                <div class="user-avatar">${user.name.substring(0,1)}</div>
                <a href="${pageContext.request.contextPath}/hackerrank/logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${error}</div>
        </c:if>

        <div class="stats-strip">
            <div class="stat-box">
                <div class="stat-box-icon purple"><i class="fas fa-paper-plane"></i></div>
                <div>
                    <div class="stat-box-value">${totalApplications}</div>
                    <div class="stat-box-label">Total Applications</div>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-box-icon green"><i class="fas fa-star"></i></div>
                <div>
                    <c:set var="shortlistedCount" value="0" />
                    <c:forEach var="app" items="${applications}">
                        <c:if test="${app.status == 'SHORTLISTED'}">
                            <c:set var="shortlistedCount" value="${shortlistedCount + 1}" />
                        </c:if>
                    </c:forEach>
                    <div class="stat-box-value">${shortlistedCount}</div>
                    <div class="stat-box-label">Shortlisted</div>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-box-icon orange"><i class="fas fa-calendar-check"></i></div>
                <div>
                    <c:set var="interviewCount" value="0" />
                    <c:forEach var="app" items="${applications}">
                        <c:if test="${app.status == 'INTERVIEW_SCHEDULED' or app.status == 'SCHEDULED_INTERVIEW'}">
                            <c:set var="interviewCount" value="${interviewCount + 1}" />
                        </c:if>
                    </c:forEach>
                    <div class="stat-box-value">${interviewCount}</div>
                    <div class="stat-box-label">Interviews</div>
                </div>
            </div>
            <div class="stat-box">
                <div class="stat-box-icon blue"><i class="fas fa-check-double"></i></div>
                <div>
                    <c:set var="hiredCount" value="0" />
                    <c:forEach var="app" items="${applications}">
                        <c:if test="${app.status == 'SELECTED'}">
                            <c:set var="hiredCount" value="${hiredCount + 1}" />
                        </c:if>
                    </c:forEach>
                    <div class="stat-box-value">${hiredCount}</div>
                    <div class="stat-box-label">Hired</div>
                </div>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty applications}">
                <div class="applications-list">
                    <c:forEach var="app" items="${applications}" varStatus="status">
                        <c:set var="statusClass" value="${app.status == 'INTERVIEW_SCHEDULED' or app.status == 'SCHEDULED_INTERVIEW' ? 'interview' : app.status == 'SELECTED' ? 'hired' : app.status == 'VIEWED_BY_RECRUITER' ? 'viewed' : app.status.toLowerCase()}" />
                        <div class="app-card status-${statusClass}" style="animation-delay: ${status.index * 0.05}s;">
                            <div class="app-card-header">
                                <div>
                                    <div class="app-card-title">${app.jobTitle}</div>
                                    <div class="app-card-company">
                                        <i class="fas fa-building"></i> ${app.companyName}
                                    </div>
                                </div>
                                <div style="display: flex; align-items: center; gap: 24px;">
                                    <div>
                                        <div class="score-ring">
                                            <svg width="72" height="72" viewBox="0 0 72 72">
                                                <circle class="score-ring-bg" cx="36" cy="36" r="30"></circle>
                                                <c:set var="circumference" value="188.5" />
                                                <c:set var="offset" value="${circumference - (app.resumeScore / 100.0 * circumference)}" />
                                                <circle class="score-ring-fill ${app.resumeScore >= 75 ? 'high' : app.resumeScore >= 50 ? 'medium' : 'low'}"
                                                    cx="36" cy="36" r="30"
                                                    stroke-dasharray="${circumference}"
                                                    stroke-dashoffset="${offset}">
                                                </circle>
                                            </svg>
                                            <span class="score-ring-text">${app.resumeScore}%</span>
                                        </div>
                                        <div class="score-ring-label">Resume Match</div>
                                    </div>
                                    <c:choose>
                                        <c:when test="${app.status == 'APPLIED'}">
                                            <span class="status-badge badge-applied"><span class="timeline-dot dot-applied"></span> Applied</span>
                                        </c:when>
                                        <c:when test="${app.status == 'VIEWED_BY_RECRUITER'}">
                                            <span class="status-badge badge-viewed"><span class="timeline-dot dot-viewed"></span> Viewed</span>
                                        </c:when>
                                        <c:when test="${app.status == 'SHORTLISTED'}">
                                            <span class="status-badge badge-shortlisted"><span class="timeline-dot dot-shortlisted"></span> Shortlisted</span>
                                        </c:when>
                                        <c:when test="${app.status == 'INTERVIEW_SCHEDULED' or app.status == 'SCHEDULED_INTERVIEW'}">
                                            <span class="status-badge badge-interview_scheduled"><span class="timeline-dot dot-interview"></span> Interview</span>
                                        </c:when>
                                        <c:when test="${app.status == 'REJECTED'}">
                                            <span class="status-badge badge-rejected"><span class="timeline-dot dot-rejected"></span> Rejected</span>
                                        </c:when>
                                        <c:when test="${app.status == 'SELECTED'}">
                                            <span class="status-badge badge-hired"><span class="timeline-dot dot-hired"></span> Selected</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge badge-applied"><span class="timeline-dot dot-applied"></span> ${app.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="app-meta">
                                <div class="app-meta-item">
                                    <i class="fas fa-calendar-alt"></i>
                                    Applied: ${app.appliedAt}
                                </div>
                                <c:if test="${not empty app.resumeFileName}">
                                    <div class="app-meta-item">
                                        <i class="fas fa-file-pdf"></i>
                                        Resume: ${app.resumeFileName}
                                    </div>
                                </c:if>
                            </div>

                            <c:if test="${not empty app.coverLetter}">
                                <div class="cover-letter-box">
                                    <div class="cover-letter-title">
                                        <i class="fas fa-envelope-open"></i> Your Cover Letter
                                    </div>
                                    <div class="cover-letter-text">${app.coverLetter}</div>
                                </div>
                            </c:if>

                            <c:if test="${not empty app.scoreSuggestions}">
                                <div class="suggestions-box">
                                    <div class="suggestions-title">
                                        <i class="fas fa-lightbulb"></i> AI Improvement Suggestions
                                    </div>
                                    <div class="suggestions-text">${app.scoreSuggestions}</div>
                                </div>
                            </c:if>

                            <c:if test="${app.status == 'INTERVIEW_SCHEDULED'}">
                                <div class="interview-pipeline">
                                    <div class="pipeline-title">
                                        <i class="fas fa-stream"></i> Your Interview Journey
                                    </div>
                                    <div class="pipeline-rounds">
                                        <div class="pipeline-round">
                                            <div class="round-icon"><i class="fas fa-brain"></i></div>
                                            <div class="round-title">Round 1: Aptitude</div>
                                            <div class="round-desc">Initial screening test</div>
                                            <c:choose>
                                                <c:when test="${not empty app.aptitudeLink and app.aptitudeLink != 'null'}">
                                                    <a href="${app.aptitudeLink}" target="_blank" class="round-btn">Start Test</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="round-btn-pending">Pending</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="pipeline-round">
                                            <div class="round-icon"><i class="fas fa-code"></i></div>
                                            <div class="round-title">Round 2: Coding</div>
                                            <div class="round-desc">Technical assessment</div>
                                            <c:choose>
                                                <c:when test="${not empty app.codingLink and app.codingLink != 'null'}">
                                                    <a href="${app.codingLink}" target="_blank" class="round-btn">Join Assessment</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="round-btn-pending">Pending</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="pipeline-round">
                                            <div class="round-icon"><i class="fas fa-video"></i></div>
                                            <div class="round-title">Round 3: HR / Tech</div>
                                            <div class="round-desc">Face-to-face interview</div>
                                            <c:choose>
                                                <c:when test="${not empty app.hrLink and app.hrLink != 'null'}">
                                                    <a href="${app.hrLink}" target="_blank" class="round-btn">Join Meeting</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="round-btn-pending">Pending</div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:if>

                            <div class="app-actions">
                                <a href="${pageContext.request.contextPath}/jobs/${app.jobId}" class="btn-view-job">
                                    <i class="fas fa-eye"></i> View Job Details
                                </a>
                                <a href="${pageContext.request.contextPath}/jobs" class="btn-browse">
                                    <i class="fas fa-search"></i> Browse More Jobs
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">
                        <i class="fas fa-briefcase"></i>
                    </div>
                    <h3>No Applications Yet</h3>
                    <p>You haven't applied to any jobs yet. Browse available positions and start applying to kickstart your career!</p>
                    <a href="${pageContext.request.contextPath}/jobs" class="btn-browse-lg">
                        <i class="fas fa-search"></i> Browse Job Listings
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate SVG rings
            document.querySelectorAll('.score-ring-fill').forEach(function(circle) {
                const offset = circle.getAttribute('stroke-dashoffset');
                circle.style.strokeDashoffset = circle.getAttribute('stroke-dasharray');
                setTimeout(function() {
                    circle.style.strokeDashoffset = offset;
                }, 200);
            });

            // Mobile Menu Logic
            const mobileMenuBtn = document.getElementById('mobileMenuBtn');
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('mobileOverlay');

            if (mobileMenuBtn) {
                mobileMenuBtn.style.display = window.innerWidth <= 768 ? 'inline-block' : 'none';
                mobileMenuBtn.addEventListener('click', function() {
                    sidebar.classList.add('active');
                    overlay.classList.add('active');
                    document.body.style.overflow = 'hidden';
                });
                overlay.addEventListener('click', function() {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                });
            }

            window.addEventListener('resize', function() {
                if (mobileMenuBtn) {
                    mobileMenuBtn.style.display = window.innerWidth <= 768 ? 'inline-block' : 'none';
                }
                if (window.innerWidth > 768) {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
            });
        });
    </script>
</body>
</html>