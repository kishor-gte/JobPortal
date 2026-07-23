<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Listings - SmartInterview</title>
    <meta name="description" content="Browse and apply for top tech jobs. Find Java, React, Full Stack, and more developer positions.">
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
            --success: #19A77B;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --purple: #8b5cf6;
            --orange: #f97316;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        
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

        .sidebar { 
            position: fixed; left: 0; top: 0; width: 280px; height: 100vh; 
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color); 
            padding: 24px 16px; z-index: 100; overflow-y: auto;
            box-shadow: var(--shadow-sm);
        }
        
        .sidebar::-webkit-scrollbar { width: 6px; }
        .sidebar::-webkit-scrollbar-track { background: transparent; }
        .sidebar::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 3px; }

        .sidebar-logo {
            display: flex; align-items: center; gap: 14px;
            padding: 8px 12px 24px; border-bottom: 1px solid var(--border-color); margin-bottom: 24px;
        }
        .sidebar-logo .icon {
            width: 48px; height: 48px;
            background: var(--gradient-primary);
            border-radius: 14px; display: flex; align-items: center; justify-content: center;
            box-shadow: var(--glow-primary);
            animation: logoGlow 3s ease-in-out infinite;
        }
        
        @keyframes logoGlow {
            0%, 100% { box-shadow: 0 0 20px rgba(25, 167, 123, 0.2); }
            50% { box-shadow: 0 0 30px rgba(25, 167, 123, 0.4); }
        }
        
        .sidebar-logo .icon i { color: #fff; font-size: 24px; }
        .sidebar-logo h2 { 
            font-size: 20px; font-weight: 700; 
            background: var(--gradient-primary);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-section { margin-bottom: 28px; }
        .nav-section h4 { 
            color: var(--text-tertiary); font-size: 11px; text-transform: uppercase; 
            letter-spacing: 1.5px; padding: 0 12px; margin-bottom: 14px; font-weight: 600;
        }
        .nav-link { 
            display: flex; align-items: center; gap: 14px; padding: 12px 14px; 
            border-radius: 12px; color: var(--text-secondary); text-decoration: none; 
            font-size: 14px; font-weight: 500; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); 
            margin-bottom: 4px; position: relative; overflow: hidden;
        }
        .nav-link i { width: 20px; text-align: center; font-size: 16px; transition: transform 0.3s ease; }
        
        .nav-link::before {
            content: ''; position: absolute; left: 0; top: 0; bottom: 0; width: 3px;
            background: var(--gradient-primary); transform: translateX(-100%);
            transition: transform 0.3s ease;
        }
        .nav-link:hover { 
            background: var(--hover-bg); 
            color: var(--primary); 
            transform: translateX(4px); 
        }
        .nav-link:hover i { transform: scale(1.1); }
        .nav-link:hover::before { transform: translateX(0); }
        .nav-link.active { 
            background: var(--hover-bg); color: var(--primary);
            box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.05);
        }
        .nav-link.active::before { transform: translateX(0); }

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
            background: var(--gradient-primary);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text; display: flex; align-items: center; gap: 12px;
        }
        .top-bar h1 i {
            background: var(--gradient-primary);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text; font-size: 32px;
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
            padding: 10px 20px; background: rgba(239, 68, 68, 0.08); 
            border: 1px solid rgba(239, 68, 68, 0.2); color: var(--danger); 
            border-radius: 30px; text-decoration: none; font-size: 13px; 
            font-weight: 600; transition: all 0.3s ease;
            display: flex; align-items: center; gap: 8px;
        }
        .btn-logout:hover { 
            background: var(--danger); color: #fff; 
            transform: translateY(-2px); box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Search & Filters */
        .search-section { 
            background: var(--card-bg); border: 1px solid var(--border-color); 
            border-radius: 24px; padding: 28px; margin-bottom: 32px; 
            box-shadow: var(--shadow-sm); backdrop-filter: blur(10px);
        }
        .search-section h3 { 
            font-size: 18px; font-weight: 700; color: var(--text-primary); 
            margin-bottom: 20px; display: flex; align-items: center; gap: 10px;
        }
        .search-section h3 i { color: var(--primary); }
        
        .search-grid {
            display: grid; grid-template-columns: 2fr 1fr 1fr 1fr 1fr; gap: 14px; margin-bottom: 16px;
        }
        .search-input { 
            background: var(--card-bg); border: 1px solid var(--border-color); 
            border-radius: 14px; padding: 14px 18px; color: var(--text-primary); 
            font-size: 14px; font-family: 'Inter', sans-serif; transition: all 0.3s ease; width: 100%; 
        }
        .search-input:focus {
            outline: none; border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }
        .search-input::placeholder { color: var(--text-tertiary); }
        select.search-input { cursor: pointer; }
        select.search-input option { background: var(--card-bg); color: var(--text-primary); }
        
        .search-actions { display: flex; gap: 12px; }
        .btn-search {
            padding: 14px 32px; background: var(--gradient-primary);
            color: #fff; border: none; border-radius: 14px; font-size: 14px;
            font-weight: 600; cursor: pointer; transition: all 0.3s ease;
            display: flex; align-items: center; gap: 10px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }
        .btn-search:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4); 
        }
        .btn-clear { 
            padding: 14px 24px; background: transparent; 
            border: 1px solid var(--border-color); color: var(--text-secondary); 
            border-radius: 14px; text-decoration: none; font-size: 14px; font-weight: 500; 
            transition: all 0.3s ease; display: flex; align-items: center; gap: 8px; 
        }
        .btn-clear:hover { 
            background: var(--hover-bg); border-color: var(--primary); color: var(--primary); 
        }

        /* Stats */
        .stats-bar {
            display: flex; gap: 20px; margin-bottom: 28px;
        }
        .stat-pill { 
            background: var(--card-bg); border: 1px solid var(--border-color); 
            border-radius: 16px; padding: 16px 24px; display: flex; align-items: center; gap: 12px; 
            transition: all 0.3s ease; backdrop-filter: blur(10px);
        }
        .stat-pill:hover { 
            border-color: var(--primary); transform: translateY(-2px); 
            box-shadow: var(--glow-primary); 
        }
        .stat-pill .stat-num { font-size: 26px; font-weight: 800; color: var(--primary); }
        .stat-pill .stat-txt { font-size: 13px; color: var(--text-tertiary); font-weight: 500; }
        .stat-pill i { font-size: 24px; color: var(--primary); }

        /* Job Cards */
        .jobs-grid {
            display: grid; grid-template-columns: repeat(auto-fill, minmax(380px, 1fr)); gap: 24px;
        }
        .job-card { 
            background: var(--card-bg); border: 1px solid var(--border-color); 
            border-radius: 24px; padding: 28px; box-shadow: var(--shadow-sm); 
            transition: all 0.35s ease; position: relative; overflow: hidden;
            backdrop-filter: blur(10px);
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
        }
        
        @keyframes cardAppear {
            to { opacity: 1; transform: translateY(0); }
        }

        .job-card::before {
            content: ''; position: absolute; top: 0; left: 0;
            width: 100%; height: 4px;
            background: var(--gradient-primary);
            transform: translateX(-100%);
            transition: transform 0.5s ease;
        }
        .job-card:hover {
            transform: translateY(-6px);
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }
        .job-card:hover::before { transform: translateX(0); }

        .job-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 16px; }
        .job-title { font-size: 20px; font-weight: 700; color: var(--text-primary); margin-bottom: 6px; }
        .job-company { 
            display: flex; align-items: center; gap: 6px; 
            font-size: 14px; color: var(--primary); font-weight: 600; 
        }
        .job-type-badge {
            padding: 6px 14px; border-radius: 30px;
            font-size: 11px; font-weight: 600; text-transform: uppercase;
            letter-spacing: 0.5px; white-space: nowrap;
            backdrop-filter: blur(10px);
        }
        .badge-fulltime { background: rgba(25, 167, 123, 0.12); color: var(--success); border: 1px solid rgba(25, 167, 123, 0.3); }
        .badge-remote { background: rgba(25, 167, 123, 0.12); color: var(--primary); border: 1px solid rgba(25, 167, 123, 0.3); }
        .badge-internship { background: rgba(245, 158, 11, 0.12); color: var(--warning); border: 1px solid rgba(245, 158, 11, 0.3); }
        .badge-parttime { background: rgba(139, 92, 246, 0.12); color: var(--purple); border: 1px solid rgba(139, 92, 246, 0.3); }
        .badge-contract { background: rgba(236, 72, 153, 0.12); color: #f472b6; border: 1px solid rgba(236, 72, 153, 0.3); }

        .job-details { display: flex; flex-wrap: wrap; gap: 16px; margin-bottom: 16px; }
        .job-detail { 
            display: flex; align-items: center; gap: 8px; 
            font-size: 13px; color: var(--text-tertiary); 
        }
        .job-detail i { color: var(--primary); font-size: 14px; }

        .job-skills { display: flex; flex-wrap: wrap; gap: 8px; margin-bottom: 20px; }
        .skill-tag { 
            padding: 5px 14px; border-radius: 30px; 
            background: var(--hover-bg); border: 1px solid var(--primary); 
            color: var(--primary); font-size: 12px; font-weight: 500; 
            transition: all 0.3s ease; 
        }
        .skill-tag:hover { 
            background: var(--primary); color: #fff; 
            transform: translateY(-2px); 
        }

        .job-footer { 
            display: flex; justify-content: space-between; align-items: center; 
            padding-top: 18px; border-top: 1px solid var(--border-color); 
        }
        .job-time { 
            font-size: 12px; color: var(--text-tertiary); 
            display: flex; align-items: center; gap: 6px; 
        }
        .btn-apply {
            padding: 12px 28px; background: var(--gradient-primary);
            color: #fff; border: none; border-radius: 30px; font-size: 13px;
            font-weight: 600; cursor: pointer; text-decoration: none;
            transition: all 0.3s ease; display: inline-flex; align-items: center; gap: 8px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }
        .btn-apply:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4); 
        }
        .btn-apply:disabled {
            background: #94a3b8; cursor: not-allowed; box-shadow: none;
        }
        .btn-applied {
            padding: 12px 28px; background: rgba(25, 167, 123, 0.15);
            border: 1px solid rgba(25, 167, 123, 0.3); color: var(--success);
            border-radius: 30px; font-size: 13px; font-weight: 600;
        }
        .btn-view { 
            padding: 10px 24px; background: transparent; 
            border: 1px solid var(--border-color); color: var(--text-secondary); 
            border-radius: 30px; font-size: 13px; font-weight: 600; 
            text-decoration: none; transition: all 0.3s ease; 
        }
        .btn-view:hover { 
            background: var(--hover-bg); border-color: var(--primary); color: var(--primary); 
        }

        .alert {
            padding: 16px 20px; border-radius: 16px; margin-bottom: 20px;
            font-size: 14px; display: flex; align-items: center; gap: 12px;
            backdrop-filter: blur(10px);
            animation: slideDown 0.4s ease-out;
        }
        @keyframes slideDown { from { opacity: 0; transform: translateY(-10px); } to { opacity: 1; transform: translateY(0); } }
        .alert-success { background: rgba(25, 167, 123, 0.1); border: 1px solid rgba(25, 167, 123, 0.3); color: var(--success); }
        .alert-error { background: rgba(239, 68, 68, 0.1); border: 1px solid rgba(239, 68, 68, 0.3); color: var(--danger); }

        .empty-state { 
            text-align: center; padding: 80px 40px; color: var(--text-tertiary); 
            grid-column: 1 / -1; 
        }
        .empty-state i { 
            font-size: 64px; margin-bottom: 20px; display: block; 
            color: var(--primary); opacity: 0.3;
            animation: float 3s ease-in-out infinite;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        .empty-state h3 { font-size: 20px; color: var(--text-primary); margin-bottom: 8px; }
        .empty-state p { font-size: 14px; }

        /* Experience badge */
        .exp-badge {
            padding: 4px 12px; border-radius: 30px; font-size: 11px; font-weight: 600;
        }
        .exp-fresher { background: rgba(25, 167, 123, 0.12); color: var(--success); }
        .exp-junior { background: rgba(25, 167, 123, 0.12); color: var(--primary); }
        .exp-mid { background: rgba(245, 158, 11, 0.12); color: var(--warning); }
        .exp-senior { background: rgba(139, 92, 246, 0.12); color: var(--purple); }
        .exp-lead { background: rgba(239, 68, 68, 0.12); color: var(--danger); }

        /* Modal */
        .modal-overlay {
            display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(26, 42, 44, 0.8); backdrop-filter: blur(8px);
            z-index: 1000; align-items: center; justify-content: center;
        }
        .modal-overlay.active { display: flex; }
        .modal { 
            background: var(--bg-darker); border: 1px solid var(--border-color); 
            border-radius: 28px; padding: 36px; width: 520px; max-width: 90vw; 
            box-shadow: var(--shadow-lg); animation: modalSlideUp 0.4s ease-out; 
        }
        @keyframes modalSlideUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .modal h3 { font-size: 22px; font-weight: 700; color: var(--text-primary); margin-bottom: 8px; }
        .modal p { font-size: 14px; color: var(--text-tertiary); margin-bottom: 28px; }
        .modal label { display: block; font-size: 13px; color: var(--text-secondary); margin-bottom: 8px; font-weight: 500; }
        .modal textarea { 
            width: 100%; background: var(--card-bg); border: 1px solid var(--border-color); 
            border-radius: 14px; padding: 14px 18px; color: var(--text-primary); 
            font-size: 14px; font-family: 'Inter', sans-serif; resize: vertical; 
            min-height: 110px; margin-bottom: 20px; outline: none; transition: all 0.3s ease;
        }
        .modal textarea:focus { border-color: var(--primary); box-shadow: var(--glow-primary); }
        .modal .file-upload { 
            width: 100%; padding: 28px; border: 2px dashed rgba(25, 167, 123, 0.3); 
            border-radius: 16px; text-align: center; cursor: pointer; margin-bottom: 24px; 
            transition: all 0.3s ease; background: rgba(25, 167, 123, 0.05); 
        }
        .modal .file-upload:hover { border-color: var(--primary); background: var(--hover-bg); }
        .modal .file-upload i { font-size: 36px; color: var(--primary); margin-bottom: 10px; display: block; }
        .modal .file-upload span { color: var(--text-tertiary); font-size: 13px; }
        .modal-actions { display: flex; gap: 14px; justify-content: flex-end; }
        .btn-cancel { 
            padding: 12px 24px; background: transparent; border: 1px solid var(--border-color); 
            color: var(--text-tertiary); border-radius: 30px; font-size: 14px; 
            cursor: pointer; transition: all 0.3s ease; 
        }
        .btn-cancel:hover { background: var(--hover-bg); border-color: var(--primary); color: var(--primary); }
        .btn-submit-apply {
            padding: 12px 32px; background: var(--gradient-primary);
            color: #fff; border: none; border-radius: 30px; font-size: 14px;
            font-weight: 600; cursor: pointer; transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }
        .btn-submit-apply:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4); 
        }

        /* Theme Toggle - Hidden */
        .theme-toggle-wrapper { display: none; }

        /* Mobile Responsive */
        @media (max-width: 1024px) {
            .search-grid { grid-template-columns: 1fr 1fr 1fr; }
            .jobs-grid { grid-template-columns: 1fr; }
        }
        @media (max-width: 768px) {
            .sidebar { transform: translateX(-100%); transition: transform 0.3s ease; }
            .sidebar.active { transform: translateX(0); }
            .main-content { margin-left: 0 !important; padding: 20px !important; }
            .search-grid { grid-template-columns: 1fr; }
            .top-bar { flex-direction: column; align-items: flex-start; gap: 16px; }
            .top-bar h1 { font-size: 26px; }
        }

        .mobile-menu-btn { display: none; }
        .loading-spinner {
            display: inline-block; width: 18px; height: 18px;
            border: 2px solid rgba(255,255,255,0.3); border-top-color: #fff;
            border-radius: 50%; animation: spin 0.6s linear infinite;
        }
        @keyframes spin { to { transform: rotate(360deg); } }
    </style>
	<jsp:include page="/views/commons/hackerrank_sidebar_styles.jsp" />
</head>
<body>
    <div class="mobile-overlay" id="mobileOverlay"></div>

    <jsp:include page="/views/commons/student_sidebar.jsp" />

    <div class="main-content">
        <div class="top-bar">
            <h1>
                <button class="mobile-menu-btn" id="mobileMenuBtn">
                    <i class="fas fa-bars"></i>
                </button>
                <i class="fas fa-briefcase"></i>
                Job Listings
            </h1>
            <div class="user-info">
                <div class="theme-toggle-wrapper">
                    <span class="theme-toggle-label">Theme</span>
                    <div class="theme-toggle" id="themeToggle" onclick="toggleTheme()" title="Toggle light/dark mode">
                        <div class="toggle-thumb"><i class="fas fa-moon"></i></div>
                    </div>
                </div>
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

        <!-- Search & Filters -->
        <div class="search-section">
            <h3><i class="fas fa-search"></i> Search & Filter Jobs</h3>
            <form action="${pageContext.request.contextPath}/hackerrank/jobs" method="get">
                <div class="search-grid">
                    <input type="text" name="keyword" class="search-input" placeholder="Search by job title, company, or keyword..." value="${keyword}">
                    <input type="text" name="location" class="search-input" placeholder="Location..." value="${location}">
                    <select name="experienceLevel" class="search-input">
                        <option value="">All Experience Levels</option>
                        <option value="FRESHER" ${experienceLevel == 'FRESHER' ? 'selected' : ''}>Fresher</option>
                        <option value="JUNIOR" ${experienceLevel == 'JUNIOR' ? 'selected' : ''}>Junior</option>
                        <option value="MID" ${experienceLevel == 'MID' ? 'selected' : ''}>Mid Level</option>
                        <option value="SENIOR" ${experienceLevel == 'SENIOR' ? 'selected' : ''}>Senior</option>
                        <option value="LEAD" ${experienceLevel == 'LEAD' ? 'selected' : ''}>Lead</option>
                    </select>
                    <select name="jobType" class="search-input">
                        <option value="">All Job Types</option>
                        <option value="FULL_TIME" ${jobType == 'FULL_TIME' ? 'selected' : ''}>Full Time</option>
                        <option value="PART_TIME" ${jobType == 'PART_TIME' ? 'selected' : ''}>Part Time</option>
                        <option value="INTERNSHIP" ${jobType == 'INTERNSHIP' ? 'selected' : ''}>Internship</option>
                        <option value="CONTRACT" ${jobType == 'CONTRACT' ? 'selected' : ''}>Contract</option>
                        <option value="REMOTE" ${jobType == 'REMOTE' ? 'selected' : ''}>Remote</option>
                    </select>
                    <input type="text" name="skills" class="search-input" placeholder="Skills (e.g. Java, React)..." value="${skills}">
                </div>
                <div class="search-actions">
                    <button type="submit" class="btn-search"><i class="fas fa-search"></i> Search Jobs</button>
                    <a href="${pageContext.request.contextPath}/hackerrank/jobs" class="btn-clear"><i class="fas fa-times"></i> Clear</a>
                </div>
            </form>
        </div>

        <!-- Stats Bar -->
        <div class="stats-bar">
            <div class="stat-pill">
                <i class="fas fa-briefcase"></i>
                <div>
                    <div class="stat-num">${jobs.size()}</div>
                    <div class="stat-txt">Jobs Found</div>
                </div>
            </div>
        </div>

        <!-- Job Cards -->
        <div class="jobs-grid">
            <c:forEach var="job" items="${jobs}" varStatus="status">
                <div class="job-card" id="job-${job.id}" style="animation-delay: ${status.index * 0.05}s;">
                    <div class="job-header">
                        <div>
                            <div class="job-title">${job.title}</div>
                            <div class="job-company"><i class="fas fa-building"></i> ${job.companyName}</div>
                        </div>
                        <c:choose>
                            <c:when test="${job.jobType == 'FULL_TIME'}"><span class="job-type-badge badge-fulltime"><i class="fas fa-briefcase"></i> Full Time</span></c:when>
                            <c:when test="${job.jobType == 'REMOTE'}"><span class="job-type-badge badge-remote"><i class="fas fa-globe"></i> Remote</span></c:when>
                            <c:when test="${job.jobType == 'INTERNSHIP'}"><span class="job-type-badge badge-internship"><i class="fas fa-graduation-cap"></i> Internship</span></c:when>
                            <c:when test="${job.jobType == 'PART_TIME'}"><span class="job-type-badge badge-parttime"><i class="fas fa-clock"></i> Part Time</span></c:when>
                            <c:when test="${job.jobType == 'CONTRACT'}"><span class="job-type-badge badge-contract"><i class="fas fa-file-contract"></i> Contract</span></c:when>
                        </c:choose>
                    </div>
                    <div class="job-details">
                        <div class="job-detail"><i class="fas fa-map-marker-alt"></i> ${job.location}</div>
                        <div class="job-detail"><i class="fas fa-money-bill-wave"></i> ${job.salary}</div>
                        <div class="job-detail">
                            <span class="exp-badge exp-${job.experienceLevel.toLowerCase()}">${job.experienceLevel}</span>
                        </div>
                        <div class="job-detail"><i class="fas fa-users"></i> ${job.applicantCount} applicants</div>
                    </div>
                    <div class="job-skills">
                        <c:forEach var="skill" items="${job.skills.split(',')}">
                            <span class="skill-tag">${skill.trim()}</span>
                        </c:forEach>
                    </div>
                    <div class="job-footer">
                        <div class="job-time"><i class="far fa-clock"></i> Posted ${job.createdAt}</div>
                        <div style="display: flex; flex-direction: column; align-items: flex-end; gap: 8px;">
                            <c:if test="${user.role == 'STUDENT'}">
                                        <button class="btn-apply" onclick="openApplyModal(${job.id}, '${job.title}', '${job.companyName}')">
                                            <i class="fas fa-paper-plane"></i> Apply Now
                                        </button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty jobs}">
                <div class="empty-state">
                    <i class="fas fa-search"></i>
                    <h3>No jobs found</h3>
                    <p>Try adjusting your search filters or check back later for new postings.</p>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Apply Modal -->
    <div class="modal-overlay" id="applyModal">
        <div class="modal">
            <h3 id="modalJobTitle">Apply for Job</h3>
            <p id="modalCompanyName">Company Name</p>
            <form action="${pageContext.request.contextPath}/jobs/apply" method="post" enctype="multipart/form-data" id="applyForm">
                <input type="hidden" name="jobId" id="modalJobId">
                <label><i class="fas fa-cloud-upload-alt"></i> Upload Resume (PDF) — optional if already uploaded</label>
                <div class="file-upload" onclick="document.getElementById('resumeInput').click()">
                    <i class="fas fa-cloud-upload-alt"></i>
                    <span id="fileLabel">Click to upload your resume (PDF)</span>
                    <input type="file" name="resume" id="resumeInput" accept=".pdf" style="display: none;" onchange="updateFileLabel(this)">
                </div>
                <label><i class="fas fa-envelope"></i> Cover Letter (optional)</label>
                <textarea name="coverLetter" placeholder="Tell the company why you're a great fit for this role..."></textarea>
                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closeApplyModal()">Cancel</button>
                    <button type="submit" class="btn-submit-apply" id="submitApplyBtn"><i class="fas fa-paper-plane"></i> Submit Application</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openApplyModal(jobId, title, company) {
            document.getElementById('modalJobId').value = jobId;
            document.getElementById('modalJobTitle').textContent = 'Apply for ' + title;
            document.getElementById('modalCompanyName').textContent = 'at ' + company;
            document.getElementById('applyModal').classList.add('active');
        }
        
        function closeApplyModal() {
            document.getElementById('applyModal').classList.remove('active');
            document.getElementById('fileLabel').textContent = 'Click to upload your resume (PDF)';
            document.getElementById('resumeInput').value = '';
        }
        
        function updateFileLabel(input) {
            if (input.files.length > 0) {
                document.getElementById('fileLabel').textContent = input.files[0].name;
            }
        }
        
        document.getElementById('applyModal').addEventListener('click', function(e) {
            if (e.target === this) closeApplyModal();
        });

        // Form submission with loading state
        const applyForm = document.getElementById('applyForm');
        if (applyForm) {
            applyForm.addEventListener('submit', function() {
                const submitBtn = document.getElementById('submitApplyBtn');
                submitBtn.innerHTML = '<span class="loading-spinner"></span> Submitting...';
                submitBtn.disabled = true;
            });
        }

        // Theme toggle (kept for compatibility)
        function toggleTheme() {
            const body = document.body;
            const toggle = document.getElementById('themeToggle');
            if (toggle) {
                const icon = toggle.querySelector('i');
                const isLight = body.classList.toggle('light-mode');
                toggle.classList.toggle('light', isLight);
                icon.className = isLight ? 'fas fa-sun' : 'fas fa-moon';
                localStorage.setItem('studentDashboardTheme', isLight ? 'light' : 'dark');
            }
        }

        (function() {
            const saved = localStorage.getItem('studentDashboardTheme');
            if (saved !== 'dark') {
                document.body.classList.add('light-mode');
                const toggle = document.getElementById('themeToggle');
                if (toggle) {
                    toggle.classList.add('light');
                    toggle.querySelector('i').className = 'fas fa-sun';
                }
            }
        })();

        // Mobile menu
        document.addEventListener('DOMContentLoaded', function() {
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

            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape') {
                    closeApplyModal();
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
            });
        });
    </script>
</body>
</html>
