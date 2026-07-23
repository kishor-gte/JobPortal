<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page import="java.time.*, java.time.format.*, java.util.*" %>
<%@ page import="in.sp.main.Entities.JobSeeker" %>
<%
    JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
    pageContext.setAttribute("jobSeeker", jobSeeker);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>My Assessment Invites | JobU - Skill Certification Center</title>
    
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
            --danger: #ef4444;
            --warning: #f59e0b;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
            --transition: all 0.4s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 16px;
            --radius-lg: 24px;
            --radius-xl: 32px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

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

        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        /* ========== ENHANCED SIDEBAR - ULTRA PREMIUM ========== */
        .career-sidebar {
            background: linear-gradient(180deg, #1a2a2e 0%, #0f1a1c 50%, #0a1214 100%);
            width: 280px;
            min-height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1000;
            box-shadow: 8px 0 32px rgba(0, 0, 0, 0.15);
            transition: transform 0.4s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            border-radius: 0 32px 32px 0;
            overflow-y: auto;
            overflow-x: hidden;
            backdrop-filter: blur(2px);
            border-right: 1px solid rgba(59,196,154,0.15);
        }

        /* Glassmorphism overlay */
        .career-sidebar::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 30% 20%, rgba(59,196,154,0.1), transparent 70%);
            pointer-events: none;
        }

        /* Custom premium scrollbar */
        .career-sidebar::-webkit-scrollbar {
            width: 5px;
        }
        .career-sidebar::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.06);
            border-radius: 10px;
        }
        .career-sidebar::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 10px;
        }
        .career-sidebar::-webkit-scrollbar-thumb:hover {
            background: var(--accent);
        }

        /* Sidebar Header - Premium Card Style */
        .sidebar-header {
            padding: 2rem 1.5rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
            display: flex;
            align-items: center;
            gap: 0.85rem;
            position: relative;
            animation: fadeInDown 0.6s ease-out;
            background: linear-gradient(135deg, rgba(25,167,123,0.1), transparent);
            margin-bottom: 0.5rem;
        }

        .sidebar-header::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 15%;
            width: 70%;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--accent), transparent);
            border-radius: 2px;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-25px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .sidebar-logo {
            width: 52px;
            height: 52px;
            background-image: url('${pageContext.request.contextPath}/assets/images/logo/logo.png');
            background-repeat: no-repeat;
            background-position: center;
            background-size: contain;
            animation: gentlePulse 3s ease-in-out infinite;
            filter: drop-shadow(0 4px 12px rgba(0,0,0,0.3));
            transition: var(--transition);
        }

        .sidebar-logo:hover {
            transform: scale(1.05);
        }

        @keyframes gentlePulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .sidebar-company-name {
            color: white;
            font-weight: 800;
            font-size: 1.4rem;
            letter-spacing: -0.3px;
            background: linear-gradient(135deg, #ffffff, var(--accent), var(--primary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        /* Enhanced Sidebar Navigation - Modern & Premium */
        .sidebar-nav {
            list-style: none;
            padding: 1rem 0.5rem;
            margin: 0;
            position: relative;
            z-index: 1;
        }

        .sidebar-nav li {
            margin: 0.1rem 0;
            position: relative;
            animation: slideIn 0.5s ease-out both;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-25px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .sidebar-nav li:nth-child(1) { animation-delay: 0.05s; }
        .sidebar-nav li:nth-child(2) { animation-delay: 0.1s; }
        .sidebar-nav li:nth-child(3) { animation-delay: 0.15s; }
        .sidebar-nav li:nth-child(4) { animation-delay: 0.2s; }
        .sidebar-nav li:nth-child(5) { animation-delay: 0.25s; }
        .sidebar-nav li:nth-child(6) { animation-delay: 0.3s; }
        .sidebar-nav li:nth-child(7) { animation-delay: 0.35s; }
        .sidebar-nav li:nth-child(8) { animation-delay: 0.4s; }
        .sidebar-nav li:nth-child(9) { animation-delay: 0.45s; }
        .sidebar-nav li:nth-child(10) { animation-delay: 0.5s; }

        .sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.85rem 1.2rem;
            margin: 0.1rem 0.3rem;
            color: rgba(255, 255, 255, 0.75);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: var(--transition);
            border-radius: 16px;
            position: relative;
            z-index: 1;
        }

        /* Premium hover effect with gradient border */
        .sidebar-nav a::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(25,167,123,0.15), rgba(59,196,154,0.05));
            border-radius: 16px;
            opacity: 0;
            transition: opacity 0.4s ease;
            z-index: -1;
        }

        .sidebar-nav a::after {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 3px;
            height: 0;
            background: linear-gradient(180deg, var(--accent), var(--primary));
            border-radius: 0 3px 3px 0;
            transition: height 0.3s ease;
        }

        .sidebar-nav a:hover::after,
        .sidebar-nav a.active::after {
            height: 60%;
        }

        .sidebar-nav a:hover::before {
            opacity: 1;
        }

        .sidebar-nav a i {
            width: 26px;
            text-align: center;
            font-size: 1.15rem;
            transition: all 0.3s ease;
        }

        .sidebar-nav a span {
            transition: transform 0.2s ease;
        }

        .sidebar-nav a:hover i {
            transform: translateX(4px) scale(1.1);
            color: var(--accent);
        }

        .sidebar-nav a:hover span {
            transform: translateX(4px);
        }

        .sidebar-nav a:hover, 
        .sidebar-nav a.active {
            color: white;
            background: linear-gradient(135deg, rgba(25,167,123,0.2), rgba(59,196,154,0.08));
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }

        .sidebar-nav a.active {
            background: linear-gradient(135deg, rgba(25,167,123,0.25), rgba(59,196,154,0.12));
            font-weight: 600;
            color: white;
        }

        .sidebar-nav a.active i {
            color: var(--accent);
            text-shadow: 0 0 8px rgba(59,196,154,0.5);
        }

        /* Enhanced Submenu */
        .sidebar-nav .has-submenu {
            position: relative;
        }

        .sidebar-nav .has-submenu > a {
            position: relative;
            cursor: pointer;
        }

        .sidebar-nav .has-submenu > a .chevron-icon {
            margin-left: auto;
            transition: transform 0.4s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            opacity: 0.7;
            font-size: 0.7rem;
        }

        .sidebar-nav .has-submenu > a.open .chevron-icon {
            transform: rotate(90deg);
            color: var(--accent);
            opacity: 1;
        }

        .sidebar-nav .submenu {
            list-style: none;
            padding: 0;
            margin: 0.3rem 0 0.3rem 2.5rem;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            background: rgba(0, 0, 0, 0.15);
            border-radius: 12px;
        }

        .sidebar-nav .submenu.show {
            max-height: 400px;
        }

        .sidebar-nav .submenu a {
            padding: 0.65rem 1rem;
            font-size: 0.82rem;
            margin: 0.1rem 0.2rem;
            border-radius: 12px;
        }

        .sidebar-nav .submenu a::before {
            display: none;
        }

        .sidebar-nav .submenu a i {
            font-size: 0.85rem;
            width: 22px;
        }

        .sidebar-nav .submenu a:hover {
            background: rgba(25,167,123,0.2);
            transform: translateX(6px);
        }

        /* User Profile Section in Sidebar */
        .sidebar-user-section {
            position: relative;
            margin-top: 1rem;
            padding: 1rem 1rem 1.5rem;
            border-top: 1px solid rgba(255, 255, 255, 0.06);
            text-align: center;
        }

        .sidebar-user-avatar {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 0.75rem;
            font-size: 1.5rem;
            font-weight: 700;
            color: white;
            box-shadow: 0 4px 15px rgba(25,167,123,0.3);
        }

        .sidebar-user-name {
            color: white;
            font-size: 0.85rem;
            font-weight: 600;
            display: block;
            margin-bottom: 0.25rem;
        }

        .sidebar-user-email {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.7rem;
            display: block;
        }

        /* Enhanced Mobile Toggle Button */
        .sidebar-toggle-btn {
            display: none;
            position: fixed;
            top: 18px;
            left: 18px;
            z-index: 1001;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 12px 16px;
            border-radius: 16px;
            font-size: 1.2rem;
            cursor: pointer;
            box-shadow: var(--shadow-lg);
            transition: var(--transition);
            backdrop-filter: blur(8px);
        }

        .sidebar-toggle-btn:hover {
            transform: scale(1.08);
            box-shadow: var(--shadow-xl);
        }

        /* Sidebar Overlay */
        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.6);
            backdrop-filter: blur(6px);
            z-index: 999;
            transition: opacity 0.3s ease;
        }

        .sidebar-overlay.show {
            display: block;
            animation: fadeIn 0.3s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Main Content */
        .main-content-wrapper {
            margin-left: 280px;
            padding: 0;
            transition: margin-left 0.3s ease;
        }

        /* Page Header Premium */
        /* Page Header Slim (White Style) */
        .page-header {
            background: #fff !important;
            border-bottom: 1px solid var(--border-color, #e0e6ed) !important;
            padding: 16px 24px !important;
            margin-bottom: 2rem !important;
            position: relative !important;
            z-index: 5 !important;
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

        /* Assessment Cards Premium (unchanged) */
        .assessment-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            padding: 1.75rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.08);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            animation: cardFadeIn 0.5s ease-out both;
        }
        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .assessment-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }
        .assessment-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--warning), var(--accent));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }
        .assessment-card:hover::before { transform: scaleX(1); }
        .assessment-card.type-job::before { background: linear-gradient(90deg, var(--primary), var(--accent)); }

        .assessment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }
        .assessment-title {
            font-size: 1.3rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .assessment-icon {
            width: 48px;
            height: 48px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.3rem;
        }
        .type-badge .assessment-icon { background: rgba(245,158,11,0.12); color: var(--warning); }
        .type-job .assessment-icon { background: rgba(25,167,123,0.12); color: var(--primary); }

        .type-badge-custom {
            padding: 0.4rem 1rem;
            border-radius: 40px;
            font-size: 0.75rem;
            font-weight: 700;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        .badge-type-badge { background: rgba(245,158,11,0.12); color: var(--warning); }
        .badge-type-job { background: rgba(25,167,123,0.12); color: var(--primary); }

        .assessment-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1.25rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid rgba(25,167,123,0.08);
        }
        .assessment-detail-item {
            background: rgba(25,167,123,0.03);
            border-radius: var(--radius-sm);
            padding: 0.75rem;
        }
        .assessment-detail-label {
            font-size: 0.65rem;
            font-weight: 700;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.25rem;
            display: block;
        }
        .assessment-detail-value {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .assessment-detail-value i { color: var(--primary); width: 18px; }

        .assessment-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .assessment-date {
            font-size: 0.75rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .btn-start-test {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.85rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
        }
        .btn-start-test:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        /* Empty State */
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
        .empty-state h3 { font-size: 1.3rem; font-weight: 700; color: var(--bg-dark); }
        .empty-state p { color: var(--text-muted); }

        /* Alert Premium */
        .alert-custom {
            border-radius: var(--radius-md);
            padding: 1rem 1.5rem;
            border: none;
            backdrop-filter: blur(8px);
        }
        .alert-success-custom { background: rgba(25, 167, 123,0.1); color: #19A77B; border-left: 4px solid #19A77B; }
        .alert-danger-custom { background: rgba(239,68,68,0.1); color: #ef4444; border-left: 4px solid #ef4444; }

        /* Responsive */
        @media (max-width: 992px) {
            .career-sidebar { transform: translateX(-100%); }
            .career-sidebar.show { transform: translateX(0); }
            .main-content-wrapper { margin-left: 0; }
            .sidebar-toggle-btn { display: block; }
            .sidebar-overlay.show { display: block; }
            .assessment-header { flex-direction: column; align-items: flex-start; }
        }

        @media (max-width: 576px) {
            .assessment-card { padding: 1.2rem; }
            .assessment-title { font-size: 1.1rem; }
        }

        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::selection { background: var(--primary); color: white; }
    </style>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>

<jsp:include page="/views/commons/student_sidebar.jsp" />

<div class="main-content-wrapper">
    <div class="page-header">
        <div class="container">
            <h1><i class="fas fa-clipboard-check me-2" style="color: var(--accent);"></i>My Assessment Invites</h1>
            <p>Pending skill assessments you've been invited to take</p>
        </div>
    </div>

    <div class="container">
        <c:if test="${not empty message}">
            <div class="alert alert-success-custom alert-custom mb-3"><i class="fas fa-check-circle me-2"></i>${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger-custom alert-custom mb-3"><i class="fas fa-exclamation-circle me-2"></i>${error}</div>
        </c:if>

        <c:choose>
            <c:when test="${empty invites}">
                <div class="empty-state">
                    <i class="fas fa-clipboard-list"></i>
                    <h3>No Pending Assessments</h3>
                    <p>You don't have any pending assessment invites at the moment.</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach var="invite" items="${invites}">
                    <div class="assessment-card type-${fn:toLowerCase(invite.type)}">
                        <div class="assessment-header">
                            <div class="assessment-title">
                                <div class="assessment-icon"><i class="fas fa-${invite.type == 'BADGE' ? 'trophy' : 'briefcase'}"></i></div>
                                <span>${invite.skill} Assessment</span>
                            </div>
                            <span class="type-badge-custom badge-type-${fn:toLowerCase(invite.type)}">
                                <i class="fas fa-${invite.type == 'BADGE' ? 'award' : 'briefcase'}"></i> ${invite.type}
                            </span>
                        </div>

                        <div class="assessment-details">
                            <div class="assessment-detail-item">
                                <span class="assessment-detail-label">Skill</span>
                                <span class="assessment-detail-value"><i class="fas fa-code"></i> ${invite.skill}</span>
                            </div>
                            <div class="assessment-detail-item">
                                <span class="assessment-detail-label">Assessment Type</span>
                                <span class="assessment-detail-value"><i class="fas fa-${invite.type == 'BADGE' ? 'trophy' : 'briefcase'}"></i> ${invite.type == 'BADGE' ? 'Badge Test' : 'Job Assessment'}</span>
                            </div>
                            <c:if test="${invite.type == 'JOB' && not empty invite.jobId}">
                                <div class="assessment-detail-item">
                                    <span class="assessment-detail-label">Job ID</span>
                                    <span class="assessment-detail-value"><i class="fas fa-hashtag"></i> #${invite.jobId}</span>
                                </div>
                            </c:if>
                        </div>

                        <div class="assessment-footer">
                            <div class="assessment-date">
                                <i class="fas fa-calendar-alt"></i>
                                <span>Invited on: 
                                    <%
                                        Object obj = pageContext.findAttribute("invite");
                                        if (obj != null) {
                                            in.sp.main.Entities.AssessmentInvitation invitation = (in.sp.main.Entities.AssessmentInvitation) obj;
                                            LocalDateTime sentAt = invitation.getSentAt();
                                            if (sentAt != null) {
                                                LocalDate today = LocalDate.now();
                                                String dateLabel;
                                                if (sentAt.toLocalDate().equals(today)) dateLabel = "Today";
                                                else if (sentAt.toLocalDate().equals(today.minusDays(1))) dateLabel = "Yesterday";
                                                else dateLabel = sentAt.format(DateTimeFormatter.ofPattern("MMM dd, yyyy"));
                                                out.print(dateLabel + " at " + sentAt.format(DateTimeFormatter.ofPattern("hh:mm a")));
                                            }
                                        }
                                    %>
                                </span>
                            </div>
                            <form action="${pageContext.request.contextPath}/assessment/start-test/${invite.id}" method="get">
                                <button type="submit" class="btn-start-test"><i class="fas fa-play"></i> Start Assessment</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>

document.addEventListener('DOMContentLoaded', function() {
    const jobsSubmenu = document.querySelector('.sidebar-nav .has-submenu');
    if (jobsSubmenu) {
        const submenuLink = jobsSubmenu.querySelector('a');
        const submenu = jobsSubmenu.querySelector('.submenu');
        if (submenuLink && submenu) {
            submenu.classList.add('show');
            submenuLink.classList.add('open');
        }
    }
});
</script>
</body>
</html>