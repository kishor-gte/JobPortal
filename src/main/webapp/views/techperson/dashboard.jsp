<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Tech Person Dashboard | JobU - SmartInterview</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    
    
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
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.85);
            --text-tertiary: rgba(255, 255, 255, 0.5);
            --border-color: rgba(255, 255, 255, 0.08);
            --card-bg: rgba(46, 62, 65, 0.6);
            --hover-bg: rgba(25, 167, 123, 0.15);
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --gradient-dark: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-darker) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.15);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.2);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.3);
            --glow-primary: 0 0 30px rgba(25, 167, 123, 0.2);
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --purple: #8b5cf6;
            --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 16px;
            --radius-lg: 24px;
            --radius-xl: 32px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--gradient-dark);
            color: var(--text-primary);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
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
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(25, 167, 123, 0.05) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: backgroundPulse 15s ease-in-out infinite;
        }

        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        /* Enhanced Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            padding: 24px 16px;
            z-index: 100;
            overflow-y: auto;
            box-shadow: var(--shadow-lg);
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
            0%, 100% { box-shadow: 0 0 20px rgba(25, 167, 123, 0.3); }
            50% { box-shadow: 0 0 30px rgba(25, 167, 123, 0.5); }
        }

        .sidebar-logo .icon i {
            color: #fff;
            font-size: 24px;
        }

        .sidebar-logo h2 {
            font-size: 20px;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
        }

        .nav-section {
            margin-bottom: 28px;
        }

                .nav-section h4 {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding: 0 12px;
            margin-bottom: 14px;
            font-weight: 700;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 14px;
            border-radius: 12px;
            color: #475569;
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
            background: rgba(25,167,123,0.08);
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
            background: rgba(25,167,123,0.08);
            color: var(--primary);
        }

        .nav-link.active::before {
            transform: translateX(0);
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
            0%, 100% { box-shadow: 0 0 20px rgba(25, 167, 123, 0.3); }
            50% { box-shadow: 0 0 30px rgba(25, 167, 123, 0.5); }
        }

        .sidebar-logo .icon i {
            color: #fff;
            font-size: 24px;
        }

        .sidebar-logo h2 {
            font-size: 20px;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
        }

        .nav-section {
            margin-bottom: 28px;
        }

                .nav-section h4 {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding: 0 12px;
            margin-bottom: 14px;
            font-weight: 700;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 14px;
            border-radius: 12px;
            color: #475569;
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
            background: rgba(25,167,123,0.08);
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
            background: rgba(25,167,123,0.08);
            color: var(--primary);
        }

        .nav-link.active::before {
            transform: translateX(0);
        }
        

        

        

        

        /* ---------------------------------
           MAIN CONTENT & LAYOUT
           --------------------------------- */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .top-bar h1 {
            font-size: 24px;
            font-weight: 700;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        
        

        .theme-toggle {
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            color: #e2e8f0;
            width: 40px;
            height: 40px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: var(--transition);
        }

        .theme-toggle:hover {
            background: rgba(255,255,255,0.1);
            color: #fff;
        }

        .admin-badge {
            background: rgba(25, 167, 123, 0.15);
            color: var(--primary);
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            border: 1px solid rgba(25, 167, 123, 0.3);
        }

        .btn-logout {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            padding: 8px 16px;
            border-radius: 12px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .btn-logout:hover {
            background: #ef4444;
            color: white;
        }

        /* ---------------------------------
           STATS GRID
           --------------------------------- */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            border: 1px solid var(--border-color);
            padding: 24px;
            border-radius: var(--radius-md);
            backdrop-filter: blur(20px);
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            border-color: var(--primary);
            box-shadow: var(--shadow-lg);
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            margin-bottom: 8px;
        }

        .stat-icon.orange { background: rgba(245, 158, 11, 0.1); color: #f59e0b; }
        .stat-icon.blue { background: rgba(59, 130, 246, 0.1); color: #3b82f6; }
        .stat-icon.green { background: rgba(16, 185, 129, 0.1); color: #10b981; }
        .stat-icon.purple { background: rgba(139, 92, 246, 0.1); color: #8b5cf6; }
        .stat-icon.cyan { background: rgba(6, 182, 212, 0.1); color: #06b6d4; }
        .stat-icon.pink { background: rgba(236, 72, 153, 0.1); color: #ec4899; }
        .stat-icon.yellow { background: rgba(234, 179, 8, 0.1); color: #eab308; }

        .stat-value {
            font-size: 32px;
            font-weight: 700;
            color: #fff;
            line-height: 1.2;
        }

        .stat-label {
            font-size: 14px;
            color: #94a3b8;
            font-weight: 500;
        }

        /* ---------------------------------
           CONTENT GRID & CARDS
           --------------------------------- */
        .content-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            margin-bottom: 24px;
        }

        .card {
            background: rgba(255, 255, 255, 0.95);
            border: 1px solid var(--border-color);
            border-radius: var(--radius-lg);
            padding: 24px;
            backdrop-filter: blur(20px);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-header a {
            color: var(--primary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: var(--transition);
        }

        .card-header a:hover {
            color: var(--primary-dark);
            gap: 10px;
        }

        .user-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 16px;
            border-radius: 12px;
            background: rgba(255,255,255,0.02);
            border: 1px solid rgba(255,255,255,0.05);
            margin-bottom: 12px;
            transition: var(--transition);
        }

        .user-item:last-child {
            margin-bottom: 0;
        }

        .user-item:hover {
            background: rgba(255,255,255,0.05);
            transform: translateX(4px);
        }

        .info {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .user-avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 16px;
            font-weight: 600;
            color: white;
        }

        .user-avatar.admin { background: linear-gradient(135deg, #ef4444, #b91c1c); }
        .user-avatar.student { background: linear-gradient(135deg, #3b82f6, #1d4ed8); }
        .user-avatar.interviewer { background: linear-gradient(135deg, #10b981, #047857); }
        .user-avatar.company { background: linear-gradient(135deg, #f59e0b, #b45309); }

        .user-name {
            font-size: 15px;
            font-weight: 600;
            color: #fff;
        }

        .user-role {
            font-size: 12px;
            font-weight: 600;
            padding: 4px 12px;
            border-radius: 20px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .role-admin { background: rgba(239, 68, 68, 0.15); color: #ef4444; border: 1px solid rgba(239, 68, 68, 0.3); }
        .role-student { background: rgba(59, 130, 246, 0.15); color: #3b82f6; border: 1px solid rgba(59, 130, 246, 0.3); }
        .role-interviewer { background: rgba(16, 185, 129, 0.15); color: #10b981; border: 1px solid rgba(16, 185, 129, 0.3); }
        .role-company { background: rgba(245, 158, 11, 0.15); color: #f59e0b; border: 1px solid rgba(245, 158, 11, 0.3); }

        .main-content {
            margin-left: 280px;
            padding: 30px;
            min-height: 100vh;
            transition: margin-left 0.3s ease;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 1000;
            }

            .sidebar.active {
                transform: translateX(0);
                box-shadow: var(--shadow-lg);
            }
            .main-content {
                margin-left: 0;
                padding: 20px;
            }
            .stats-grid {
                grid-template-columns: 1fr;
            }
            .content-grid {
                grid-template-columns: 1fr;
            }
            .top-bar {
                flex-direction: column;
                align-items: flex-start;
            }
            .top-bar h1 {
                font-size: 22px;
            }
        }

        @media (max-width: 480px) {
            .stat-card { padding: 16px; }
            .stat-value { font-size: 24px; }
            .card { padding: 16px; }
        }

        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #1e293b; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection {
            background: var(--primary);
            color: white;
        }
        /* Light Mode */
        body.light-mode {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%) !important;
            color: #1e293b !important;
        }
        body.light-mode::before {
            background: 
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.05) 0%, transparent 50%);
        }
        body.light-mode .sidebar {
            background: rgba(255, 255, 255, 0.95) !important;
            border-right-color: #e2e8f0 !important;
        }
        body.light-mode .sidebar-logo h2 {
            color: var(--primary) !important;
            -webkit-text-fill-color: var(--primary) !important;
        }
        body.light-mode .nav-section h4 {
            color: var(--primary) !important;
            -webkit-text-fill-color: var(--primary) !important;
        }
        body.light-mode .nav-link {
            color: #475569 !important;
        }
        body.light-mode .nav-link:hover, body.light-mode .nav-link.active {
            background: var(--hover-bg) !important;
            color: var(--primary) !important;
        }
        body.light-mode .top-bar h1 {
            color: var(--primary) !important;
            -webkit-text-fill-color: var(--primary) !important;
        }
        body.light-mode .stat-card, body.light-mode .card {
            background: #ffffff !important;
            border-color: #e2e8f0 !important;
        }
        body.light-mode .stat-value {
            color: var(--primary) !important;
        }
        body.light-mode .stat-label {
            color: #64748b !important;
        }
        body.light-mode .card-header h3 {
            color: #0f172a !important;
        }
        body.light-mode .user-item {
            background: #f8fafc !important;
            border-color: #f1f5f9 !important;
        }
        body.light-mode .user-name {
            color: #1e293b !important;
        }
        body.light-mode .theme-toggle {
            background: white !important;
            border-color: #e2e8f0 !important;
            color: #475569 !important;
        }
        body.light-mode .btn-logout {
            background: rgba(239, 68, 68, 0.05) !important;
            border-color: rgba(239, 68, 68, 0.2) !important;
            color: #ef4444 !important;
        }
    </style>
</head>

<body>
    <script>
        if (localStorage.getItem('theme') !== 'dark') {
            document.body.classList.add('light-mode');
        }
    </script>
            <div class="sidebar" id="mainSidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-laptop-code"></i></div>
            <h2>Tech Person</h2>
        </div>
        <div class="nav-section">
            <h4>Overview</h4>
            <a href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link active">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
        </div>
        <div class="nav-section">
            <h4>Management</h4>
            <a href="${pageContext.request.contextPath}/tech/manage-users" class="nav-link ">
                <i class="fas fa-users-cog"></i> Manage Users
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-questions" class="nav-link ">
                <i class="fas fa-question-circle"></i> Manage Questions
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-categories" class="nav-link ">
                <i class="fas fa-tags"></i> Manage Categories
            </a>
        </div>
        <div class="nav-section">
            <h4>Evaluation</h4>
            <a href="${pageContext.request.contextPath}/tech/results" class="nav-link ">
                <i class="fas fa-poll"></i> Results
            </a>
            <a href="${pageContext.request.contextPath}/tech/ai-evaluation" class="nav-link ">
                <i class="fas fa-robot"></i> AI Evaluation
            </a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/tech/logout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <h1><i class="fas fa-shield-halved"></i> Tech Person Dashboard</h1>
            <div style="display: flex; align-items: center; gap: 12px;">
                
                <span class="admin-badge"><i class="fas fa-laptop-code"></i> Tech Person</span>
                <a href="${pageContext.request.contextPath}/tech/logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>

        <!-- Stats Row 1 -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon orange"><i class="fas fa-users"></i></div>
                <div class="stat-value">${totalUsers}</div>
                <div class="stat-label">Total Users</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fas fa-user-graduate"></i></div>
                <div class="stat-value">${totalStudents}</div>
                <div class="stat-label">Students</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-chalkboard-teacher"></i></div>
                <div class="stat-value">${totalInterviewers}</div>
                <div class="stat-label">Interviewers</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon purple"><i class="fas fa-code"></i></div>
                <div class="stat-value">${totalCodingQuestions}</div>
                <div class="stat-label">Coding Questions</div>
            </div>
        </div>

        <!-- Stats Row 2 -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon cyan"><i class="fas fa-comments"></i></div>
                <div class="stat-value">${totalInterviewQuestions}</div>
                <div class="stat-label">Interview Questions</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon pink"><i class="fas fa-tags"></i></div>
                <div class="stat-value">${totalCategories}</div>
                <div class="stat-label">Categories</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon yellow"><i class="fas fa-video"></i></div>
                <div class="stat-value">${totalInterviews}</div>
                <div class="stat-label">Total Interviews</div>
            </div>
			<div class="stat-card">
			               <div class="stat-icon blue"><i class="fas fa-briefcase"></i></div>
			               <div class="stat-value">${totalJobs}</div>
			               <div class="stat-label">Total Jobs</div>
			           </div>
        </div>

        <!-- Stats Row 3 -->
        <div class="stats-grid">
           
           
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-file-alt"></i></div>
                <div class="stat-value">${totalApplications}</div>
                <div class="stat-label">Job Applications</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon purple"><i class="fas fa-handshake"></i></div>
                <div class="stat-value">${activeJobs.size()}</div>
                <div class="stat-label">Active Jobs</div>
            </div>
        </div>

        <!-- Recent Users -->
        <div class="content-grid">
            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-user-clock" style="color: var(--accent);"></i> Recent Users</h3>
                    <a href="${pageContext.request.contextPath}/tech/manage-users">Manage All <i class="fas fa-arrow-right"></i></a>
                </div>
                <c:forEach var="u" items="${recentUsers}" end="7">
                    <div class="user-item">
                        <div class="info">
                            <div class="user-avatar ${u.role == 'ADMIN' ? 'admin' : u.role == 'STUDENT' ? 'student' : u.role == 'COMPANY' ? 'company' : 'interviewer'}">
                                ${u.name.substring(0,1)}
                            </div>
                            <span class="user-name">${u.name}</span>
                        </div>
                        <span class="user-role role-${u.role == 'ADMIN' ? 'admin' : u.role == 'STUDENT' ? 'student' : u.role == 'COMPANY' ? 'company' : 'interviewer'}">${u.role}</span>
                    </div>
                </c:forEach>
                <c:if test="${empty recentUsers}">
                    <p style="color: rgba(255,255,255,0.3); text-align: center; padding: 30px;">No recent users</p>
                </c:if>
            </div>
        </div>

        <!-- Job Portal Overview -->
       
    </div>

    <script>
        // Sidebar Toggle for Mobile
        function toggleSidebar() {
            document.getElementById('mainSidebar').classList.toggle('active');
        }

        // Theme Toggle Logic
        function updateThemeIcon() {
            const icon = document.querySelector('#theme-toggle i');
            if (document.documentElement.classList.contains('light-mode')) {
                icon.classList.remove('fa-moon');
                icon.classList.add('fa-sun');
            } else {
                icon.classList.remove('fa-sun');
                icon.classList.add('fa-moon');
            }
        }

        updateThemeIcon();

        function toggleTheme() {
            document.documentElement.classList.toggle('light-mode');
            if (document.documentElement.classList.contains('light-mode')) {
                localStorage.setItem('theme', 'light');
            } else {
                localStorage.setItem('theme', 'dark');
            }
            updateThemeIcon();
        }

        // Mobile Menu Button
        document.addEventListener('DOMContentLoaded', function() {
            const topBar = document.querySelector('.top-bar');
            if (topBar && !document.querySelector('.mobile-menu-btn')) {
                const toggleBtn = document.createElement('button');
                toggleBtn.className = 'mobile-menu-btn';
                toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
                toggleBtn.style.cssText = `
                    display: none;
                    background: var(--primary);
                    border: none;
                    color: white;
                    padding: 10px 14px;
                    border-radius: 12px;
                    font-size: 16px;
                    cursor: pointer;
                    margin-right: 12px;
                `;
                
                if (window.innerWidth <= 768) {
                    toggleBtn.style.display = 'block';
                    const headerDiv = document.querySelector('.top-bar h1')?.parentElement;
                    if (headerDiv && headerDiv.firstChild) {
                        headerDiv.insertBefore(toggleBtn, headerDiv.firstChild);
                    }
                    toggleBtn.addEventListener('click', toggleSidebar);
                }
            }

            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(e) {
                const sidebar = document.getElementById('mainSidebar');
                const toggleBtn = document.querySelector('.mobile-menu-btn');
                if (window.innerWidth <= 768 && sidebar && sidebar.classList.contains('active')) {
                    if (!sidebar.contains(e.target) && (!toggleBtn || !toggleBtn.contains(e.target))) {
                        sidebar.classList.remove('active');
                    }
                }
            });
        });
    </script>

    <style>
        .mobile-menu-btn {
            display: none;
        }
        @media (max-width: 768px) {
            .mobile-menu-btn {
                display: block !important;
            }
        }
    </style>
    <script>
        // Theme Toggle Logic
        function updateThemeIcon() {
            const icon = document.querySelector('#theme-toggle i');
            if (icon) {
                if (document.body.classList.contains('light-mode')) {
                    icon.classList.remove('fa-moon');
                    icon.classList.add('fa-sun');
                } else {
                    icon.classList.remove('fa-sun');
                    icon.classList.add('fa-moon');
                }
            }
        }

        updateThemeIcon();

        function toggleTheme() {
            document.body.classList.toggle('light-mode');
            if (document.body.classList.contains('light-mode')) {
                localStorage.setItem('theme', 'light');
            } else {
                localStorage.setItem('theme', 'dark');
            }
            updateThemeIcon();
        }
    </script>
</body>

</html>











