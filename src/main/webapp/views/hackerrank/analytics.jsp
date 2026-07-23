<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics - SmartInterview</title>
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
            background: rgba(26, 42, 44, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            padding: 24px 16px;
            z-index: 100;
            box-shadow: var(--shadow-lg);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
            background: linear-gradient(135deg, #fff, var(--accent));
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
            box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.1);
        }

        .nav-link.active::before {
            transform: translateX(0);
        }

        .nav-link.active i {
            color: var(--primary);
        }

        .main-content {
            margin-left: 280px;
            padding: 32px 40px;
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
            margin-bottom: 36px;
            padding: 8px 0;
        }

        .top-bar h1 {
            font-size: 32px;
            font-weight: 800;
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: flex;
            align-items: center;
            gap: 16px;
            letter-spacing: -0.5px;
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
            color: var(--text-secondary);
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
        }

        .theme-toggle:hover {
            background: var(--hover-bg);
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        .btn-logout {
            padding: 12px 20px;
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.2);
            color: #fca5a5;
            border-radius: 12px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .btn-logout:hover {
            background: rgba(239, 68, 68, 0.2);
            border-color: var(--danger);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 36px;
        }

        .stat-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 24px;
            text-align: center;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        @keyframes cardAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
            transform: translateX(-100%);
            transition: transform 0.5s ease;
        }

        .stat-card:hover {
            transform: translateY(-6px);
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }

        .stat-card:hover::before {
            transform: translateX(0);
        }

        .stat-icon {
            width: 56px;
            height: 56px;
            margin: 0 auto 16px;
            background: var(--hover-bg);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .stat-icon i {
            font-size: 28px;
            color: var(--primary);
        }

        .stat-value {
            font-size: 36px;
            font-weight: 800;
            margin-bottom: 8px;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-label {
            color: var(--text-tertiary);
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }

        .stat-trend {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            margin-top: 12px;
            font-size: 12px;
            color: var(--success);
        }

        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        .card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            animation: slideIn 0.5s ease-out forwards;
            opacity: 0;
        }

        .card:nth-child(1) { animation-delay: 0.5s; }
        .card:nth-child(2) { animation-delay: 0.6s; }

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

        .card:hover {
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }

        .card h3 {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .card h3 i {
            color: var(--primary);
            font-size: 22px;
        }

        .chart-bar {
            display: flex;
            align-items: center;
            gap: 14px;
            margin-bottom: 18px;
        }

        .chart-label {
            width: 130px;
            font-size: 13px;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .chart-track {
            flex: 1;
            height: 32px;
            background: rgba(0, 0, 0, 0.2);
            border-radius: 8px;
            overflow: hidden;
            position: relative;
            border: 1px solid var(--border-color);
        }

        .chart-fill {
            height: 100%;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            padding-right: 12px;
            font-size: 12px;
            font-weight: 700;
            color: #fff;
            transition: width 1.5s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .chart-fill::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1));
            animation: shimmer 2s infinite;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%); }
            100% { transform: translateX(100%); }
        }

        .eval-item {
            padding: 18px;
            background: rgba(26, 42, 44, 0.4);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            margin-bottom: 12px;
            transition: all 0.3s ease;
            animation: itemAppear 0.4s ease-out;
        }

        @keyframes itemAppear {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .eval-item:hover {
            border-color: var(--primary);
            transform: translateX(4px);
            box-shadow: var(--shadow-sm);
        }

        .eval-item h4 {
            font-size: 15px;
            color: var(--text-primary);
            margin-bottom: 12px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .eval-item h4 i {
            color: var(--primary);
            font-size: 14px;
        }

        .eval-scores {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .eval-score {
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .eval-score:hover {
            transform: scale(1.05);
        }

        .empty-state {
            text-align: center;
            padding: 50px 20px;
            color: var(--text-tertiary);
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 16px;
            color: var(--primary);
            opacity: 0.3;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        /* Light Mode Styles */
        body.light-mode {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: #1e293b;
        }

        body.light-mode::before {
            background: 
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.05) 0%, transparent 50%);
        }

        body.light-mode .sidebar {
            background: rgba(255, 255, 255, 0.95);
            border-right: 1px solid #e2e8f0;
        }

        body.light-mode .sidebar-logo h2 {
            color: #0f172a;
            -webkit-text-fill-color: #0f172a;
            background: none;
        }

        body.light-mode .sidebar-logo {
            border-bottom: 1px solid #e2e8f0;
        }

        body.light-mode .nav-section h4 {
            color: #64748b;
        }

        body.light-mode .nav-link {
            color: #475569;
        }

        body.light-mode .nav-link:hover {
            background: rgba(25, 167, 123, 0.1);
            color: var(--primary);
        }

        body.light-mode .nav-link.active {
            background: rgba(25, 167, 123, 0.15);
            color: var(--primary);
        }

        body.light-mode .stat-card,
        body.light-mode .card,
        body.light-mode .eval-item {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        body.light-mode .stat-label {
            color: #64748b;
        }

        body.light-mode .stat-value {
            color: var(--primary);
            -webkit-text-fill-color: var(--primary);
            background: none;
        }

        body.light-mode .card h3 {
            color: #0f172a;
        }

        body.light-mode .eval-item h4 {
            color: #1e293b;
        }

        body.light-mode .chart-label {
            color: #475569;
        }

        body.light-mode .chart-track {
            background: #f1f5f9;
        }

        body.light-mode .theme-toggle {
            background: white;
            border-color: #e2e8f0;
            color: #475569;
        }

        body.light-mode .theme-toggle:hover {
            background: rgba(25, 167, 123, 0.1);
            color: var(--primary);
        }

        body.light-mode .btn-logout {
            background: rgba(239, 68, 68, 0.05);
            border-color: rgba(239, 68, 68, 0.2);
            color: #ef4444;
        }

        body.light-mode .top-bar h1 {
            color: var(--primary);
            -webkit-text-fill-color: var(--primary);
            background: none;
        }

        body.light-mode .empty-state {
            color: #94a3b8;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .content-grid {
                grid-template-columns: 1fr;
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
            }

            .main-content {
                margin-left: 0 !important;
                padding: 20px !important;
            }

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }

            .top-bar h1 {
                font-size: 26px;
            }

            .chart-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
            }

            .chart-label {
                width: auto;
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

        .btn-back {
            padding: 8px 18px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.65);
            border-radius: 30px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
        }

        .btn-back:hover {
            background: rgba(25,167,123,0.15);
            border-color: var(--primary);
            color: var(--accent);
            transform: translateY(-2px);
        }

        body.light-mode .btn-back {
            background: white;
            border-color: #e2e8f0;
            color: #475569;
            box-shadow: var(--shadow-sm);
        }

        body.light-mode .btn-back:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
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
            <div class="icon"><i class="fas fa-brain"></i></div>
            <h2>SmartInterview</h2>
        </div>
        <div class="nav-section">
            <h4>Overview</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/dashboard" class="nav-link">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/analytics" class="nav-link active">
                <i class="fas fa-chart-line"></i> Analytics
            </a>
        </div>
        <div class="nav-section">
            <h4>Management</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-users" class="nav-link">
                <i class="fas fa-users-cog"></i> Manage Users
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-questions" class="nav-link">
                <i class="fas fa-question-circle"></i> Manage Questions
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-categories" class="nav-link">
                <i class="fas fa-tags"></i> Manage Categories
            </a>
        </div>
        <div class="nav-section">
            <h4>Evaluation</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/results" class="nav-link">
                <i class="fas fa-poll"></i> View Results
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="nav-link">
                <i class="fas fa-robot"></i> AI Evaluations
            </a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/account" class="nav-link">
                <i class="fas fa-user-circle"></i> Account
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/logout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div style="display: flex; align-items: center; gap: 16px;">
                <a href="${pageContext.request.contextPath}/hackerrank/admin/dashboard" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
                <h1>
                    <button class="mobile-menu-btn" id="mobileMenuBtn">
                        <i class="fas fa-bars"></i>
                    </button>
                    <i class="fas fa-chart-bar"></i>
                    System Analytics
                </h1>
            </div>
            <div class="top-bar-actions">
                <button id="theme-toggle" class="theme-toggle" title="Toggle Theme" onclick="toggleTheme()">
                    <i class="fas fa-moon"></i>
                </button>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-users"></i>
                </div>
                <div class="stat-value">${totalUsers}</div>
                <div class="stat-label">Total Users</div>
                <div class="stat-trend">
                    <i class="fas fa-arrow-up"></i>
                    <span>+12% growth</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <div class="stat-value">${totalStudents}</div>
                <div class="stat-label">Students</div>
                <div class="stat-trend">
                    <i class="fas fa-arrow-up"></i>
                    <span>+8% this month</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <div class="stat-value">${totalInterviews}</div>
                <div class="stat-label">Total Interviews</div>
                <div class="stat-trend">
                    <i class="fas fa-chart-line"></i>
                    <span>Active sessions</span>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-value">${completedInterviews}</div>
                <div class="stat-label">Completed</div>
                <div class="stat-trend">
                    <i class="fas fa-trophy"></i>
                    <span>${totalInterviews > 0 ? fmt.formatNumber(completedInterviews * 100 / totalInterviews, 0) : 0}% completion</span>
                </div>
            </div>
        </div>

        <div class="content-grid">
            <!-- Platform Stats -->
            <div class="card">
                <h3>
                    <i class="fas fa-chart-pie"></i>
                    Platform Overview
                </h3>
                <div class="chart-bar">
                    <span class="chart-label">
                        <i class="fas fa-user-graduate" style="margin-right: 6px;"></i>
                        Students
                    </span>
                    <div class="chart-track">
                        <div class="chart-fill"
                            style="width: ${totalUsers > 0 ? (totalStudents * 100 / totalUsers) : 0}%; background: linear-gradient(90deg, var(--primary), var(--accent));">
                            ${totalStudents}
                        </div>
                    </div>
                </div>
                <div class="chart-bar">
                    <span class="chart-label">
                        <i class="fas fa-user-tie" style="margin-right: 6px;"></i>
                        Interviewers
                    </span>
                    <div class="chart-track">
                        <div class="chart-fill"
                            style="width: ${totalUsers > 0 ? (totalInterviewers * 100 / totalUsers) : 0}%; background: linear-gradient(90deg, #19A77B, #3BC49A);">
                            ${totalInterviewers}
                        </div>
                    </div>
                </div>
                <div class="chart-bar">
                    <span class="chart-label">
                        <i class="fas fa-code" style="margin-right: 6px;"></i>
                        Coding Questions
                    </span>
                    <div class="chart-track">
                        <div class="chart-fill"
                            style="width: ${(totalCodingQuestions + totalInterviewQuestions) > 0 ? (totalCodingQuestions * 100 / (totalCodingQuestions + totalInterviewQuestions)) : 0}%; background: linear-gradient(90deg, #f97316, #fb923c);">
                            ${totalCodingQuestions}
                        </div>
                    </div>
                </div>
                <div class="chart-bar">
                    <span class="chart-label">
                        <i class="fas fa-comments" style="margin-right: 6px;"></i>
                        Interview Questions
                    </span>
                    <div class="chart-track">
                        <div class="chart-fill"
                            style="width: ${(totalCodingQuestions + totalInterviewQuestions) > 0 ? (totalInterviewQuestions * 100 / (totalCodingQuestions + totalInterviewQuestions)) : 0}%; background: linear-gradient(90deg, #ec4899, #f472b6);">
                            ${totalInterviewQuestions}
                        </div>
                    </div>
                </div>
                <div class="chart-bar">
                    <span class="chart-label">
                        <i class="fas fa-clock" style="margin-right: 6px;"></i>
                        Scheduled
                    </span>
                    <div class="chart-track">
                        <div class="chart-fill"
                            style="width: ${totalInterviews > 0 ? (scheduledInterviews * 100 / totalInterviews) : 0}%; background: linear-gradient(90deg, #3b82f6, #60a5fa);">
                            ${scheduledInterviews}
                        </div>
                    </div>
                </div>
                <div class="chart-bar">
                    <span class="chart-label">
                        <i class="fas fa-check-circle" style="margin-right: 6px;"></i>
                        Completed
                    </span>
                    <div class="chart-track">
                        <div class="chart-fill"
                            style="width: ${totalInterviews > 0 ? (completedInterviews * 100 / totalInterviews) : 0}%; background: linear-gradient(90deg, #3BC49A, #2dd4bf);">
                            ${completedInterviews}
                        </div>
                    </div>
                </div>
            </div>

            <!-- AI Evaluations Summary -->
            <div class="card">
                <h3>
                    <i class="fas fa-robot"></i>
                    Recent AI Evaluations
                </h3>
                <c:forEach var="eval" items="${evaluations}" varStatus="status">
                    <div class="eval-item" style="animation-delay: ${status.index * 0.05}s;">
                        <h4>
                            <i class="fas fa-user-circle"></i>
                            ${eval.studentName}
                        </h4>
                        <div class="eval-scores">
                            <span class="eval-score"
                                style="background: rgba(25, 167, 123, 0.15); color: var(--primary); border: 1px solid var(--primary);">
                                <i class="fas fa-code"></i>
                                Tech: ${eval.technicalScore}
                            </span>
                            <span class="eval-score"
                                style="background: rgba(59, 196, 154, 0.15); color: var(--accent); border: 1px solid var(--accent);">
                                <i class="fas fa-comment"></i>
                                Comm: ${eval.communicationScore}
                            </span>
                            <span class="eval-score"
                                style="background: rgba(251, 191, 36, 0.15); color: #fbbf24; border: 1px solid #fbbf24;">
                                <i class="fas fa-star"></i>
                                Conf: ${eval.confidenceScore}
                            </span>
                            <span class="eval-score"
                                style="background: rgba(20, 143, 105, 0.15); color: var(--primary-dark); border: 1px solid var(--primary-dark);">
                                <i class="fas fa-trophy"></i>
                                Overall: ${eval.overallScore}
                            </span>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty evaluations}">
                    <div class="empty-state">
                        <i class="fas fa-robot"></i>
                        <p>No evaluations yet</p>
                    </div>
                </c:if>
            </div>
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

        // Mobile Menu Logic
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

            // Animate chart bars on load
            const chartFills = document.querySelectorAll('.chart-fill');
            chartFills.forEach(fill => {
                const width = fill.style.width;
                fill.style.width = '0%';
                setTimeout(() => {
                    fill.style.width = width;
                }, 100);
            });
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl/Cmd + D to toggle theme
            if ((e.ctrlKey || e.metaKey) && e.key === 'd') {
                e.preventDefault();
                toggleTheme();
            }
            
            // Escape to close sidebar
            if (e.key === 'Escape') {
                const sidebar = document.getElementById('sidebar');
                const overlay = document.getElementById('mobileOverlay');
                if (sidebar && sidebar.classList.contains('active')) {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
            }
        });
    </script>
</body>
</html>