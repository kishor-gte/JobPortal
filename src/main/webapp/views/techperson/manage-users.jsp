<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - SmartInterview</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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
            --success: #19A77B;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --purple: #8b5cf6;
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
            box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.05);
        }

        .nav-link.active::before {
            transform: translateX(0);
        }

        .nav-link.active i {
            color: var(--primary);
        }

        .main-content {
            margin-left: 280px;
            padding: 28px 36px;
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

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .top-bar h1 {
            font-size: 32px;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .top-bar h1 i {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 32px;
        }

        .top-bar-actions {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .theme-toggle {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            color: #475569;
            width: 44px;
            height: 44px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .theme-toggle:hover {
            background: rgba(25,167,123,0.08);
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        .btn-logout {
            padding: 10px 20px;
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.2);
            color: #fca5a5;
            border-radius: 30px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-logout:hover {
            background: rgba(239, 68, 68, 0.2);
            border-color: var(--danger);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
        }

        .filters {
            display: flex;
            gap: 12px;
            margin-bottom: 28px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 10px 22px;
            border-radius: 30px;
            border: 1px solid var(--border-color);
            background: var(--card-bg);
            color: #475569;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .filter-btn i {
            font-size: 13px;
            color: var(--text-tertiary);
        }

        .filter-btn:hover {
            background: rgba(25,167,123,0.08);
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .filter-btn:hover i {
            color: var(--primary);
        }

        .filter-btn.active {
            background: var(--gradient-primary);
            color: #fff;
            border-color: transparent;
            box-shadow: var(--glow-primary);
        }

        .filter-btn.active i {
            color: #fff;
        }

        .table-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            padding: 18px 20px;
            text-align: left;
            font-size: 12px;
            color: var(--text-tertiary);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            border-bottom: 1px solid var(--border-color);
            background: rgba(26, 42, 44, 0.5);
            font-weight: 600;
        }

        td {
            padding: 16px 20px;
            font-size: 14px;
            border-bottom: 1px solid var(--border-color);
        }

        tr:hover td {
            background: rgba(25,167,123,0.08);
        }

        .user-cell {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .user-avatar {
            width: 44px;
            height: 44px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: #fff;
            font-size: 18px;
            background: var(--gradient-primary);
            box-shadow: var(--glow-primary);
        }

        .role-badge {
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .role-ADMIN {
            background: rgba(245, 158, 11, 0.15);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .role-STUDENT {
            background: rgba(25, 167, 123, 0.15);
            color: var(--primary);
            border: 1px solid rgba(25, 167, 123, 0.3);
        }

        .role-INTERVIEWER {
            background: rgba(59, 196, 154, 0.15);
            color: var(--accent);
            border: 1px solid rgba(59, 196, 154, 0.3);
        }

        .status-active {
            color: var(--success);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .status-inactive {
            color: var(--danger);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .action-btns {
            display: flex;
            gap: 8px;
        }

        .btn-sm {
            padding: 8px 14px;
            border-radius: 30px;
            border: none;
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-toggle {
            background: rgba(59, 130, 246, 0.15);
            color: var(--info);
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .btn-toggle:hover {
            background: var(--info);
            color: #fff;
            border-color: var(--info);
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .btn-delete:hover {
            background: var(--danger);
            color: #fff;
            border-color: var(--danger);
        }

        .btn-sm:hover {
            transform: translateY(-2px);
        }

        .role-select {
            padding: 8px 14px;
            background: rgba(26, 42, 44, 0.5);
            border: 1px solid var(--border-color);
            border-radius: 30px;
            color: var(--text-primary);
            font-size: 12px;
            font-family: 'Inter', sans-serif;
            cursor: pointer;
            outline: none;
            transition: all 0.3s ease;
        }

        .role-select:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        .role-select option {
            background: var(--bg-darker);
            color: var(--text-primary);
        }

        .alert {
            padding: 16px 20px;
            border-radius: 16px;
            margin-bottom: 24px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 12px;
            backdrop-filter: blur(10px);
            animation: slideDown 0.4s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background: rgba(25, 167, 123, 0.1);
            border: 1px solid rgba(25, 167, 123, 0.3);
            color: #3BC49A;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-tertiary);
        }

        .empty-state i {
            font-size: 56px;
            margin-bottom: 20px;
            color: var(--primary);
            opacity: 0.3;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
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

        body.light-mode .nav-link:hover {
            background: var(--hover-bg) !important;
            color: var(--primary) !important;
        }

        body.light-mode .nav-link.active {
            background: var(--hover-bg) !important;
            color: var(--primary) !important;
        }

        body.light-mode .top-bar h1 {
            color: var(--primary) !important;
            -webkit-text-fill-color: var(--primary) !important;
        }

        body.light-mode .table-card {
            background: rgba(255, 255, 255, 0.9) !important;
            border-color: #e2e8f0 !important;
        }

        body.light-mode th {
            background: #f8fafc !important;
            color: #64748b !important;
            border-bottom-color: #e2e8f0 !important;
        }

        body.light-mode td {
            border-bottom-color: #f1f5f9 !important;
            color: #1e293b !important;
        }

        body.light-mode tr:hover td {
            background: var(--hover-bg) !important;
        }

        body.light-mode .filter-btn {
            background: #ffffff !important;
            border-color: #e2e8f0 !important;
            color: #475569 !important;
        }

        body.light-mode .filter-btn:hover {
            background: var(--hover-bg) !important;
            border-color: var(--primary) !important;
            color: var(--primary) !important;
        }

        body.light-mode .filter-btn.active {
            background: var(--gradient-primary) !important;
            color: #fff !important;
        }

        body.light-mode .role-select {
            background: #ffffff !important;
            border-color: #cbd5e1 !important;
            color: #1e293b !important;
        }

        body.light-mode .role-select option {
            background: #ffffff !important;
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

        body.light-mode td div[style*="color:"],
        body.light-mode td[style*="color:"] {
            color: #64748b !important;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .table-card {
                overflow-x: auto;
            }
            
            table {
                min-width: 900px;
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
                margin-left: 0 !important;
                padding: 20px !important;
            }

            .filters {
                overflow-x: auto;
                padding-bottom: 8px;
            }

            .filter-btn {
                white-space: nowrap;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }

            .top-bar h1 {
                font-size: 26px;
            }

            .mobile-menu-btn {
                display: inline-block !important;
                background: none;
                border: none;
                font-size: 24px;
                color: var(--text-primary);
                cursor: pointer;
                margin-right: 12px;
            }

            .mobile-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.7);
                backdrop-filter: blur(4px);
                z-index: 999;
            }

            .mobile-overlay.active {
                display: block;
            }
        }

        .mobile-menu-btn {
            display: none;
        }
    </style>
</head>

<body>
    <script>
        if (localStorage.getItem('theme') !== 'dark') {
            document.body.classList.add('light-mode');
        }
    </script>

    <div class="mobile-overlay" id="mobileOverlay"></div>

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
            <a href="${pageContext.request.contextPath}/tech/manage-users" class="nav-link active">
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
            <a href="${pageContext.request.contextPath}/tech/manage-competitions" class="nav-link">
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
            <h1>
                <button class="mobile-menu-btn" id="mobileMenuBtn">
                    <i class="fas fa-bars"></i>
                </button>
                <i class="fas fa-users-cog"></i>
                Manage Users
            </h1>
            <div class="top-bar-actions">
                <button id="theme-toggle" class="theme-toggle" title="Toggle Theme" onclick="toggleTheme()">
                    <i class="fas fa-moon"></i>
                </button>
                <a href="${pageContext.request.contextPath}/hackerrank/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>

                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 28px; flex-wrap: wrap; gap: 16px;">
            <div class="filters" style="margin-bottom: 0;">
                <a href="${pageContext.request.contextPath}/tech/manage-users" class="filter-btn active">
                    <i class="fas fa-users"></i> All Users (${totalCount})
                </a>
            </div>
            
            <form action="${pageContext.request.contextPath}/tech/manage-users" method="get" class="search-form" style="display: flex; gap: 10px; flex-wrap: wrap;">
                <input type="text" name="search" placeholder="Search by name..." value="${searchQuery}" 
                       style="background: var(--card-bg); border: 1px solid var(--border-color); border-radius: 14px; padding: 10px 18px; color: var(--text-primary); outline: none; width: 280px; font-size: 14px;">
                <button type="submit" style="background: var(--primary); color: white; border: none; border-radius: 14px; width: 44px; height: 44px; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: all 0.3s ease;">
                    <i class="fas fa-search"></i>
                </button>
                <c:if test="${not empty searchQuery}">
                    <a href="${pageContext.request.contextPath}/tech/manage-users" style="background: rgba(239, 68, 68, 0.1); color: var(--danger); border: 1px solid rgba(239, 68, 68, 0.2); border-radius: 14px; width: 44px; height: 44px; cursor: pointer; display: flex; align-items: center; justify-content: center; text-decoration: none; transition: all 0.3s ease;">
                        <i class="fas fa-times"></i>
                    </a>
                </c:if>
            </form>
        </div>

        <div class="table-card">
            <table>
                <thead>
                    <tr>
                        <th>User</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Joined</th>
                       
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${jobSeekers}">
                        <tr>
                            <td>
                                <div class="user-cell">
                                    <div class="user-avatar">
                                        ${u.name.substring(0,1)}
                                    </div>
                                    <div>
                                        <div style="font-weight: 600; color: var(--text-primary);">${u.name}</div>
                                        <div style="font-size: 12px; color: var(--text-tertiary);">
                                            <i class="fas fa-at"></i> ${u.email}
                                        </div>
                                    </div>
                                </div>
                            </td>
                            <td>${u.email}</td>
                            <td>
                                <span class="role-badge role-${u.role != null ? u.role : 'STUDENT'}">
                                    ${u.role != null ? u.role : 'STUDENT'}
                                </span>
                            </td>
                            <td>
                                <span class="status-active">
                                    <i class="fas fa-circle" style="font-size: 8px;"></i> Active
                                </span>
                            </td>
                            <td style="color: var(--text-tertiary); font-size: 13px;">
                                <i class="far fa-calendar-alt"></i> ${not empty u.createdAt ? u.createdAt : '-'}
                            </td>
                           
                        </tr>
                    </c:forEach>
                    <c:if test="${empty jobSeekers}">
                        <tr>
                            <td colspan="6">
                                <div class="empty-state">
                                    <i class="fas fa-users-slash"></i>
                                    <p>No users found for this filter.</p>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        // Theme Toggle Logic
        function updateThemeIcon() {
            const icon = document.querySelector('#theme-toggle i');
            if (document.body.classList.contains('light-mode')) {
                icon.classList.remove('fa-moon');
                icon.classList.add('fa-sun');
            } else {
                icon.classList.remove('fa-sun');
                icon.classList.add('fa-moon');
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

        // Mobile Menu Functionality
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

            // Touch swipe support
            let touchStartX = 0;
            let touchEndX = 0;

            document.body.addEventListener('touchstart', e => {
                touchStartX = e.changedTouches[0].screenX;
            }, { passive: true });

            document.body.addEventListener('touchend', e => {
                touchEndX = e.changedTouches[0].screenX;
                if (touchEndX < touchStartX - 50) {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
                if (touchEndX > touchStartX + 50 && touchStartX < 30) {
                    sidebar.classList.add('active');
                    overlay.classList.add('active');
                    document.body.style.overflow = 'hidden';
                }
            }, { passive: true });

            // Window resize handler
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
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
            });
        });
    </script>
</body>
</html>







