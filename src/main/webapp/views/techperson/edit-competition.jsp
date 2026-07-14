<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

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
                    <div class="sidebar" id="sidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-laptop-code"></i></div>
            <h2>Tech Person</h2>
        </div>
        <div class="nav-section">
            <h4>Overview</h4>
            <a href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
        </div>
        <div class="nav-section">
            <h4>Management</h4>
            <a href="${pageContext.request.contextPath}/tech/manage-users" class="nav-link">
                <i class="fas fa-users-cog"></i> Manage Users
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-questions" class="nav-link">
                <i class="fas fa-question-circle"></i> Manage Questions
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-categories" class="nav-link">
                <i class="fas fa-tags"></i> Manage Categories
            </a>
        </div>
        <div class="nav-section">
            <h4>Evaluation</h4>
            <a href="${pageContext.request.contextPath}/tech/results" class="nav-link">
                <i class="fas fa-poll"></i> Results
            </a>
            <a href="${pageContext.request.contextPath}/tech/ai-evaluation" class="nav-link">
                <i class="fas fa-robot"></i> AI Evaluation
            </a>
        </div>
        <div class="nav-section">
            <h4>Competitions</h4>
            <a href="${pageContext.request.contextPath}/tech/conduct-competition" class="nav-link">
                <i class="fas fa-trophy"></i> Conduct Competition
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-competitions" class="nav-link active">
                <i class="fas fa-tasks"></i> Manage Competitions
            </a>
            <a href="${pageContext.request.contextPath}/tech/competition-results" class="nav-link">
                <i class="fas fa-chart-bar"></i> Competition Results
            </a>
            <a href="${pageContext.request.contextPath}/tech/competition-recordings" class="nav-link">
                <i class="fas fa-video"></i> Competition Recordings
            </a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link">
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

                <style>
            .form-card {
                background: rgba(255, 255, 255, 0.95);
                border: 1px solid var(--border-color);
                border-radius: var(--radius-lg);
                padding: 24px;
                backdrop-filter: blur(20px);
                margin-bottom: 24px;
                animation: slideUp 0.5s ease-out;
            }
            .form-card-title {
                font-size: 18px;
                font-weight: 700;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 10px;
                color: var(--primary);
                border-bottom: 1px solid rgba(0,0,0,0.05);
                padding-bottom: 12px;
            }
            body.light-mode .form-card-title {
                border-bottom: 1px solid #e2e8f0;
            }
            .form-group {
                margin-bottom: 16px;
            }
            .form-label {
                font-size: 14px;
                font-weight: 600;
                color: #fff;
                margin-bottom: 8px;
                display: block;
            }
            body.light-mode .form-label {
                color: #1e293b;
            }
            .form-control, .form-select {
                width: 100%;
                padding: 12px 16px;
                background: rgba(0,0,0,0.2);
                border: 1px solid rgba(255,255,255,0.1);
                border-radius: var(--radius-md);
                color: #fff;
                font-family: inherit;
                transition: var(--transition);
            }
            body.light-mode .form-control, body.light-mode .form-select {
                background: #fff;
                border: 1px solid #cbd5e1;
                color: #1e293b;
            }
            .form-control:focus, .form-select:focus {
                outline: none;
                border-color: var(--primary);
                box-shadow: 0 0 0 3px rgba(25, 167, 123, 0.2);
            }
            .checkbox-group {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 12px;
            }
            .checkbox-group input[type="checkbox"] {
                width: 18px;
                height: 18px;
                accent-color: var(--primary);
            }
            .checkbox-group label {
                font-size: 14px;
                font-weight: 500;
                color: #fff;
            }
            body.light-mode .checkbox-group label {
                color: #1e293b;
            }
            .grid-2 {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }
            .btn-primary {
                background: var(--gradient-primary);
                color: white;
                border: none;
                padding: 14px 28px;
                border-radius: var(--radius-md);
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
                gap: 10px;
                width: 100%;
                justify-content: center;
            }
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: var(--shadow-md);
            }
            .btn-secondary {
                background: rgba(255,255,255,0.1);
                color: white;
                border: 1px solid rgba(255,255,255,0.2);
                padding: 10px 20px;
                border-radius: var(--radius-md);
                font-size: 14px;
                cursor: pointer;
                transition: var(--transition);
            }
            body.light-mode .btn-secondary {
                background: #f1f5f9;
                color: #1e293b;
                border-color: #cbd5e1;
            }
            .btn-secondary:hover {
                background: rgba(255,255,255,0.2);
            }
            @keyframes slideUp {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }
            
            .toast-container {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 9999;
            }
            .toast {
                background: #10b981;
                color: white;
                padding: 16px 24px;
                border-radius: var(--radius-md);
                box-shadow: var(--shadow-lg);
                display: flex;
                align-items: center;
                gap: 12px;
                font-weight: 600;
                transform: translateX(120%);
                transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }
            .toast.show {
                transform: translateX(0);
            }
            .toast.error {
                background: #ef4444;
            }
            
            .question-builder {
                display: none;
                margin-top: 20px;
                padding: 20px;
                border: 1px dashed rgba(255,255,255,0.3);
                border-radius: var(--radius-md);
                background: rgba(0,0,0,0.1);
            }
            body.light-mode .question-builder {
                border-color: #cbd5e1;
                background: #f8fafc;
            }
            .question-builder.active {
                display: block;
            }
            
            .new-question-item {
                background: rgba(255,255,255,0.05);
                border-radius: var(--radius-md);
                padding: 16px;
                margin-bottom: 16px;
                position: relative;
            }
            body.light-mode .new-question-item {
                background: #fff;
                border: 1px solid #e2e8f0;
            }
        </style>

        <form id="competitionForm" onsubmit="saveCompetition(event)">
            
            <!-- Basic Details -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-info-circle"></i> Basic Details</div>
                <div class="form-group">
                    <label class="form-label">Competition Title *</label>
                    <input type="text" class="form-control" name="title" required placeholder="e.g. Summer Code Sprint 2026">
                </div>
                <div class="form-group">
                    <label class="form-label">Competition Description *</label>
                    <textarea class="form-control" name="description" rows="3" required placeholder="What is this competition about?"></textarea>
                </div>
                <div class="form-group">
                    <label class="form-label">Competition Rules *</label>
                    <textarea class="form-control" name="rules" rows="3" required placeholder="List the rules separated by newlines"></textarea>
                </div>
                <div class="grid-2">
                    <div class="form-group">
                        <label class="form-label">Difficulty *</label>
                        <select class="form-select" name="difficulty" required>
                            <option value="">Select Difficulty</option>
                            <option value="Easy">Easy</option>
                            <option value="Medium">Medium</option>
                            <option value="Hard">Hard</option>
                            <option value="Mixed">Mixed</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Allowed Programming Languages *</label>
                        <select class="form-select" name="allowedLanguages" required>
                            <option value="Java, Python, C++, JavaScript">All (Java, Python, C++, JS)</option>
                            <option value="Java">Java Only</option>
                            <option value="Python">Python Only</option>
                            <option value="C++">C++ Only</option>
                        </select>
                    </div>
                </div>
                <div class="grid-2">
                    <div class="form-group">
                        <label class="form-label">Number of Coding Questions *</label>
                        <input type="number" class="form-control" id="numQuestions" name="numberOfQuestions" required min="1" max="20" placeholder="e.g. 2">
                    </div>
                    <div class="form-group">
                        <label class="form-label">Competition Banner Image URL (Optional)</label>
                        <input type="text" class="form-control" name="bannerImage" placeholder="https://...">
                    </div>
                </div>
            </div>

            <!-- Registration Settings -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-calendar-check"></i> Registration Settings</div>
                <div class="grid-2">
                    <div class="form-group">
                        <label class="form-label">Registration Start Date & Time *</label>
                        <input type="datetime-local" class="form-control" name="registrationStartTime" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Registration End Date & Time *</label>
                        <input type="datetime-local" class="form-control" name="registrationEndTime" required>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">Maximum Participants *</label>
                    <input type="number" class="form-control" name="maxParticipants" required min="1" placeholder="e.g. 100">
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" name="allowWaitlist" id="allowWaitlist" value="true">
                    <label for="allowWaitlist">Allow Waitlist when capacity is full</label>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" name="autoCloseRegistration" id="autoCloseRegistration" value="true" checked>
                    <label for="autoCloseRegistration">Auto Close Registration when Capacity is Full</label>
                </div>
            </div>

            <!-- Exam Settings -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-clock"></i> Exam Settings</div>
                <div class="grid-2">
                    <div class="form-group">
                        <label class="form-label">Exam Start Date & Time *</label>
                        <input type="datetime-local" class="form-control" name="examStartTime" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Exam Duration (Minutes) *</label>
                        <input type="number" class="form-control" name="examDurationMinutes" required min="5" placeholder="e.g. 90">
                    </div>
                </div>
                <div class="checkbox-group">
                    <input type="checkbox" name="autoSubmit" id="autoSubmit" value="true" checked>
                    <label for="autoSubmit">Auto Submit when Time Ends</label>
                </div>
            </div>

            <!-- Coding Questions -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-code"></i> Coding Questions</div>
                <p style="font-size: 13px; color: var(--text-secondary); margin-bottom: 16px;">
                    You must select or create exactly <strong id="questionCountDisplay">0</strong> questions.
                </p>
                
                <div class="form-group">
                    <label class="form-label">Question Source *</label>
                    <select class="form-select" id="questionSource" onchange="toggleQuestionSource()">
                        <option value="">Select Option</option>
                        <option value="EXISTING">Option 1: Select Existing Questions</option>
                        <option value="NEW">Option 2: Add New Questions</option>
                    </select>
                </div>

                <!-- Option 1: Existing -->
                <div class="question-builder" id="existingQuestionsDiv">
                    <div class="form-group">
                        <label class="form-label">Select from Database</label>
                        <c:choose>
                            <c:when test="${not empty existingQuestions}">
                                <div class="checkbox-list" style="max-height: 250px; overflow-y: auto; border: 1px solid var(--border); border-radius: var(--radius-sm); padding: 12px; background: var(--bg-surface);">
                                    <c:forEach var="q" items="${existingQuestions}">
                                        <div class="checkbox-group" style="margin-bottom: 8px;">
                                            <input type="checkbox" name="existingQuestionCb" id="eq_${q.id}" value="${q.id}" onchange="handleCheckboxChange(this)">
                                            <label for="eq_${q.id}" style="margin-left: 8px;">${q.title} <span class="badge ${q.difficulty eq 'Hard' ? 'bg-danger' : (q.difficulty eq 'Medium' ? 'bg-warning' : 'bg-success')}">${q.difficulty}</span></label>
                                        </div>
                                    </c:forEach>
                                </div>
                                <small style="color:var(--text-secondary); margin-top: 8px; display:block;">Check the boxes for the questions you want to include.</small>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning" style="padding: 12px; border-radius: var(--radius-sm); background-color: rgba(239, 68, 68, 0.1); color: #ef4444; border: 1px solid #ef4444;">
                                    <i class="fas fa-exclamation-triangle"></i> No existing coding questions found in the database. Please select "Add New Questions" instead.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Option 2: New -->
                <div class="question-builder" id="newQuestionsDiv">
                    <div id="newQuestionsContainer"></div>
                    <button type="button" class="btn-secondary" id="btnAddQuestion" onclick="addNewQuestionForm()">
                        <i class="fas fa-plus"></i> Add Coding Question
                    </button>
                    <p style="font-size: 12px; color: var(--warning); margin-top: 10px;" id="newQuestionsStatus">Added: 0</p>
                </div>
            </div>

            <!-- Exam Security -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-shield-alt"></i> Exam Security</div>
                <div class="grid-2">
                    <div>
                        <div class="checkbox-group">
                            <input type="checkbox" name="disableCopyPaste" id="disableCopyPaste" value="true" checked>
                            <label for="disableCopyPaste">Disable Copy & Paste</label>
                        </div>
                        <div class="checkbox-group">
                            <input type="checkbox" name="disableRightClick" id="disableRightClick" value="true" checked>
                            <label for="disableRightClick">Disable Right Click</label>
                        </div>
                        <div class="checkbox-group">
                            <input type="checkbox" name="fullScreenMode" id="fullScreenMode" value="true" checked>
                            <label for="fullScreenMode">Enforce Full Screen Mode</label>
                        </div>
                    </div>
                    <div>
                        <div class="checkbox-group">
                            <input type="checkbox" name="autoSubmitTabSwitch" id="autoSubmitTabSwitch" value="true">
                            <label for="autoSubmitTabSwitch">Auto Submit if Candidate leaves Tab > 3 times</label>
                        </div>
                        <div class="checkbox-group">
                            <input type="checkbox" name="oneLoginPerCandidate" id="oneLoginPerCandidate" value="true" checked>
                            <label for="oneLoginPerCandidate">Allow Only One Login per Candidate</label>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Publish Settings -->
            <div class="form-card">
                <div class="form-card-title"><i class="fas fa-upload"></i> Publish Settings</div>
                <div class="form-group">
                    <label class="form-label">Competition Status *</label>
                    <select class="form-select" name="status" required>
                        <option value="DRAFT">Draft (Save for later)</option>
                        <option value="PUBLISHED" selected>Published (Make available)</option>
                    </select>
                </div>
            </div>

            <button type="submit" class="btn-primary" id="btnSubmit">
                <i class="fas fa-save"></i> Save Competition
            </button>
        </form>
    </div>

    <!-- Toast Notification -->
    <div class="toast-container">
        <div class="toast" id="toastMessage">
            <i class="fas fa-check-circle"></i>
            <span id="toastText">Competition created successfully.</span>
        </div>
    </div>

    <script>
        // Track dynamically added questions
        let newQuestionCount = 0;

        document.getElementById('numQuestions').addEventListener('input', function(e) {
            document.getElementById('questionCountDisplay').innerText = e.target.value || 0;
            checkNewQuestionLimit();
        });

        function toggleQuestionSource() {
            const source = document.getElementById('questionSource').value;
            document.getElementById('existingQuestionsDiv').classList.remove('active');
            document.getElementById('newQuestionsDiv').classList.remove('active');
            
            if (source === 'EXISTING') {
                document.getElementById('existingQuestionsDiv').classList.add('active');
            } else if (source === 'NEW') {
                document.getElementById('newQuestionsDiv').classList.add('active');
            }
        }

        function checkNewQuestionLimit() {
            const required = parseInt(document.getElementById('numQuestions').value) || 0;
            const btn = document.getElementById('btnAddQuestion');
            const status = document.getElementById('newQuestionsStatus');
            
            status.innerText = 'Added: ' + newQuestionCount + ' / ' + required;
            
            if (required > 0 && newQuestionCount >= required) {
                btn.style.display = 'none';
            } else {
                btn.style.display = 'inline-flex';
            }
        }
        
        function handleCheckboxChange(cb) {
            const required = parseInt(document.getElementById('numQuestions').value) || 0;
            const checkedBoxes = document.querySelectorAll('input[name="existingQuestionCb"]:checked');
            if (checkedBoxes.length > required) {
                cb.checked = false;
                showToast('You can only select exactly ' + required + ' questions.', true);
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            const now = new Date();
            now.setMinutes(now.getMinutes() - now.getTimezoneOffset());
            const minDateTime = now.toISOString().slice(0,16);
            document.querySelector('[name="registrationStartTime"]').min = minDateTime;
            document.querySelector('[name="registrationEndTime"]').min = minDateTime;
            document.querySelector('[name="examStartTime"]').min = minDateTime;
            
            // Populate form with existing competition data
            <c:if test="${not empty competition}">
                document.querySelector('[name="title"]').value = "${fn:escapeXml(competition.title)}";
                document.querySelector('[name="description"]').value = `${fn:escapeXml(competition.description)}`;
                document.querySelector('[name="rules"]').value = `${fn:escapeXml(competition.rules)}`;
                document.querySelector('[name="difficulty"]').value = "${competition.difficulty}";
                document.querySelector('[name="allowedLanguages"]').value = "${competition.allowedLanguages}";
                document.querySelector('[name="numberOfQuestions"]').value = "${competition.numberOfQuestions}";
                document.querySelector('#questionCountDisplay').innerText = "${competition.numberOfQuestions}";
                document.querySelector('[name="bannerImage"]').value = "${competition.bannerImage}";
                document.querySelector('[name="maxParticipants"]').value = "${competition.maxParticipants}";
                document.querySelector('[name="examDurationMinutes"]').value = "${competition.examDurationMinutes}";
                document.querySelector('[name="status"]').value = "${competition.status}";
                
                <c:if test="${not empty competition.registrationStartTime}">
                    document.querySelector('[name="registrationStartTime"]').value = "${competition.registrationStartTime}";
                </c:if>
                <c:if test="${not empty competition.registrationEndTime}">
                    document.querySelector('[name="registrationEndTime"]').value = "${competition.registrationEndTime}";
                </c:if>
                <c:if test="${not empty competition.examStartTime}">
                    document.querySelector('[name="examStartTime"]').value = "${competition.examStartTime}";
                </c:if>
                
                document.querySelector('[name="allowWaitlist"]').checked = ${competition.allowWaitlist};
                document.querySelector('[name="autoCloseRegistration"]').checked = ${competition.autoCloseRegistration};
                document.querySelector('[name="autoSubmit"]').checked = ${competition.autoSubmit};
                document.querySelector('[name="disableCopyPaste"]').checked = ${competition.disableCopyPaste};
                document.querySelector('[name="disableRightClick"]').checked = ${competition.disableRightClick};
                document.querySelector('[name="fullScreenMode"]').checked = ${competition.fullScreenMode};
                document.querySelector('[name="autoSubmitTabSwitch"]').checked = ${competition.autoSubmitTabSwitch};
                document.querySelector('[name="oneLoginPerCandidate"]').checked = ${competition.oneLoginPerCandidate};
                
                // Note: To edit the competition questions, the user will still need to check the boxes if they want to update them, 
                // but the endpoint `/tech/api/competitions/save` should theoretically support updating if we pass ID.
                // Wait, does the form submit an ID?
            </c:if>
        });

        function addNewQuestionForm() {
            const required = parseInt(document.getElementById('numQuestions').value) || 0;
            if (required <= 0) {
                showToast("Please enter Number of Coding Questions first.", true);
                return;
            }
            if (newQuestionCount >= required) {
                return;
            }
            
            const container = document.getElementById('newQuestionsContainer');
            const idx = newQuestionCount;
            
            const html = 
                '<div class="new-question-item" id="nq_' + idx + '">' +
                    '<h5 style="margin-bottom: 12px; color: var(--primary);">Question ' + (idx + 1) + '</h5>' +
                    '<div class="form-group">' +
                        '<input type="text" class="form-control nq-title" placeholder="Question Title *" required>' +
                    '</div>' +
                    '<div class="grid-2">' +
                        '<div class="form-group">' +
                            '<select class="form-select nq-difficulty" required>' +
                                '<option value="">Select Difficulty *</option>' +
                                '<option value="Easy">Easy</option>' +
                                '<option value="Medium">Medium</option>' +
                                '<option value="Hard">Hard</option>' +
                            '</select>' +
                        '</div>' +
                        '<div class="form-group">' +
                            '<input type="number" class="form-control nq-category" placeholder="Category ID *" required>' +
                        '</div>' +
                    '</div>' +
                    '<div class="form-group">' +
                        '<textarea class="form-control nq-desc" placeholder="Problem Description *" required rows="2"></textarea>' +
                    '</div>' +
                    '<div class="grid-2">' +
                        '<div class="form-group">' +
                            '<textarea class="form-control nq-input" placeholder="Sample Input *" required rows="2"></textarea>' +
                        '</div>' +
                        '<div class="form-group">' +
                            '<textarea class="form-control nq-output" placeholder="Sample Output *" required rows="2"></textarea>' +
                        '</div>' +
                    '</div>' +
                    '<div class="form-group">' +
                        '<input type="text" class="form-control nq-hint" placeholder="Solution Hint (Optional)">' +
                    '</div>' +
                    '<button type="button" class="btn-secondary" style="color: #ef4444; border-color: #ef4444;" onclick="removeNewQuestionForm(\'nq_' + idx + '\')">Remove</button>' +
                '</div>';
            
            container.insertAdjacentHTML('beforeend', html);
            newQuestionCount++;
            checkNewQuestionLimit();
        }

        function removeNewQuestionForm(id) {
            document.getElementById(id).remove();
            newQuestionCount--;
            checkNewQuestionLimit();
            // Re-label questions
            const items = document.querySelectorAll('.new-question-item h5');
            items.forEach((el, index) => {
                el.innerText = 'Question ' + (index + 1);
            });
        }

        function showToast(message, isError = false) {
            const toast = document.getElementById('toastMessage');
            const text = document.getElementById('toastText');
            const icon = toast.querySelector('i');
            
            text.innerText = message;
            if (isError) {
                toast.classList.add('error');
                icon.className = 'fas fa-exclamation-circle';
            } else {
                toast.classList.remove('error');
                icon.className = 'fas fa-check-circle';
            }
            
            toast.classList.add('show');
            setTimeout(() => {
                toast.classList.remove('show');
            }, 3000);
        }

        async function saveCompetition(event) {
            event.preventDefault();
            const form = event.target;
            
            // Validate Questions Logic
            const requiredNum = parseInt(document.getElementById('numQuestions').value) || 0;
            const source = document.getElementById('questionSource').value;
            
            const payload = {
                id: ${not empty competition ? competition.id : 'null'},
                title: form.title.value,
                description: form.description.value,
                rules: form.rules.value,
                difficulty: form.difficulty.value,
                allowedLanguages: form.allowedLanguages.value,
                bannerImage: form.bannerImage.value,
                numberOfQuestions: requiredNum,
                registrationStartTime: form.registrationStartTime.value,
                registrationEndTime: form.registrationEndTime.value,
                maxParticipants: parseInt(form.maxParticipants.value) || 0,
                allowWaitlist: form.allowWaitlist.checked,
                autoCloseRegistration: form.autoCloseRegistration.checked,
                examStartTime: form.examStartTime.value,
                examDurationMinutes: parseInt(form.examDurationMinutes.value) || 0,
                autoSubmit: form.autoSubmit.checked,
                disableCopyPaste: form.disableCopyPaste.checked,
                disableRightClick: form.disableRightClick.checked,
                fullScreenMode: form.fullScreenMode.checked,
                autoSubmitTabSwitch: form.autoSubmitTabSwitch.checked,
                oneLoginPerCandidate: form.oneLoginPerCandidate.checked,
                status: form.querySelector('[name="status"]').value,
                selectedQuestionIds: [],
                newQuestions: []
            };

            if (source === 'EXISTING') {
                const checkboxes = document.querySelectorAll('input[name="existingQuestionCb"]:checked');
                if (checkboxes.length !== requiredNum) {
                    showToast('Please select exactly ' + requiredNum + ' questions.', true);
                    return;
                }
                payload.selectedQuestionIds = Array.from(checkboxes).map(cb => parseInt(cb.value));
            } else if (source === 'NEW') {
                if (newQuestionCount !== requiredNum) {
                    showToast('Please add exactly ' + requiredNum + ' questions.', true);
                    return;
                }
                
                const items = document.querySelectorAll('.new-question-item');
                items.forEach(item => {
                    payload.newQuestions.push({
                        title: item.querySelector('.nq-title').value,
                        difficulty: item.querySelector('.nq-difficulty').value,
                        categoryId: parseInt(item.querySelector('.nq-category').value) || 1,
                        description: item.querySelector('.nq-desc').value,
                        sampleInput: item.querySelector('.nq-input').value,
                        sampleOutput: item.querySelector('.nq-output').value,
                        solutionHint: item.querySelector('.nq-hint').value
                    });
                });
            } else {
                showToast('Please select a Question Source.', true);
                return;
            }

            const btn = document.getElementById('btnSubmit');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Saving...';
            btn.disabled = true;

            try {
                const response = await fetch('${pageContext.request.contextPath}/tech/api/competitions', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify(payload)
                });
                
                const result = await response.json();
                
                if (response.ok && result.success) {
                    showToast(result.message);
                    form.reset();
                    newQuestionCount = 0;
                    document.getElementById('newQuestionsContainer').innerHTML = '';
                    checkNewQuestionLimit();
                    toggleQuestionSource();
                } else {
                    showToast(result.message || 'Error saving competition.', true);
                }
            } catch (err) {
                console.error(err);
                showToast('Network error occurred.', true);
            } finally {
                btn.innerHTML = originalText;
                btn.disabled = false;
            }
        }
    </script>
    <script>
        // Sidebar Toggle for Mobilee
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













