<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Questions - SmartInterview</title>
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
            background: rgba(26, 42, 44, 0.95);
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
            margin-bottom: 28px;
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
            color: var(--text-secondary);
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
            background: var(--hover-bg);
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

        .tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 28px;
            background: var(--card-bg);
            padding: 6px;
            border-radius: 16px;
            border: 1px solid var(--border-color);
            backdrop-filter: blur(10px);
        }

        .tab {
            padding: 12px 28px;
            background: transparent;
            border: none;
            color: var(--text-tertiary);
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            border-radius: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .tab i {
            font-size: 14px;
        }

        .tab:hover {
            color: var(--text-primary);
            background: var(--hover-bg);
        }

        .tab.active {
            background: var(--gradient-primary);
            color: #fff;
            box-shadow: var(--glow-primary);
        }

        .tab-content {
            display: none;
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .tab-content.active {
            display: block;
        }

        .add-form {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px;
            margin-bottom: 28px;
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

        .add-form h3 {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .add-form h3 i {
            color: var(--primary);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .form-group {
            margin-bottom: 8px;
        }

        .form-group.full {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            color: var(--text-secondary);
            font-size: 13px;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 16px;
            background: rgba(26, 42, 44, 0.5);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            color: var(--text-primary);
            font-size: 14px;
            font-family: 'Inter', sans-serif;
            outline: none;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        .form-group input::placeholder,
        .form-group textarea::placeholder {
            color: var(--text-tertiary);
        }

        .form-group select option {
            background: var(--bg-darker);
            color: var(--text-primary);
        }

        .form-group textarea {
            min-height: 100px;
            resize: vertical;
        }

        .btn-add {
            padding: 14px 32px;
            background: var(--gradient-primary);
            color: #fff;
            border: none;
            border-radius: 14px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
            margin-top: 20px;
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .question-list {
            display: grid;
            gap: 12px;
        }

        .q-item {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 20px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s ease;
        }

        .q-item:hover {
            border-color: var(--primary);
            transform: translateX(4px);
            box-shadow: var(--shadow-md);
        }

        .q-item h4 {
            font-size: 15px;
            color: var(--text-primary);
            margin-bottom: 8px;
            font-weight: 600;
        }

        .q-item .tags {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .q-item .tag {
            padding: 4px 12px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .tag-easy {
            background: rgba(25, 167, 123, 0.15);
            color: var(--success);
            border: 1px solid rgba(25, 167, 123, 0.3);
        }

        .tag-medium {
            background: rgba(245, 158, 11, 0.15);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .tag-hard {
            background: rgba(239, 68, 68, 0.15);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .tag-cat {
            background: rgba(25, 167, 123, 0.15);
            color: var(--primary);
            border: 1px solid rgba(25, 167, 123, 0.3);
        }

        .tag-type {
            background: rgba(139, 92, 246, 0.15);
            color: var(--purple);
            border: 1px solid rgba(139, 92, 246, 0.3);
        }

        .btn-del {
            padding: 8px 16px;
            background: rgba(239, 68, 68, 0.1);
            color: #f87171;
            border: 1px solid rgba(239, 68, 68, 0.2);
            border-radius: 30px;
            font-size: 12px;
            font-weight: 500;
            cursor: pointer;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .btn-del:hover {
            background: var(--danger);
            color: #fff;
            border-color: var(--danger);
            transform: scale(1.05);
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

        body.light-mode .tabs {
            background: #ffffff !important;
            border-color: #e2e8f0 !important;
        }

        body.light-mode .tab {
            color: #64748b !important;
        }

        body.light-mode .tab:hover {
            background: var(--hover-bg) !important;
            color: var(--primary) !important;
        }

        body.light-mode .tab.active {
            background: var(--gradient-primary) !important;
            color: #fff !important;
        }

        body.light-mode .add-form,
        body.light-mode .q-item {
            background: rgba(255, 255, 255, 0.9) !important;
            border-color: #e2e8f0 !important;
        }

        body.light-mode .add-form h3,
        body.light-mode .q-item h4 {
            color: #1e293b !important;
        }

        body.light-mode .form-group label {
            color: #475569 !important;
        }

        body.light-mode .form-group input,
        body.light-mode .form-group select,
        body.light-mode .form-group textarea {
            background: #ffffff !important;
            border-color: #cbd5e1 !important;
            color: #1e293b !important;
        }

        body.light-mode .form-group select option {
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

        /* Responsive */
        @media (max-width: 1024px) {
            .form-grid {
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
                box-shadow: var(--shadow-lg);
            }

            .main-content {
                margin-left: 0 !important;
                padding: 20px !important;
            }

            .tabs {
                flex-direction: column;
                gap: 4px;
            }

            .tab {
                justify-content: center;
            }

            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }

            .top-bar h1 {
                font-size: 26px;
            }

            .q-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
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
            <div class="icon"><i class="fas fa-shield-halved"></i></div>
            <h2>Admin Panel</h2>
        </div>
        <div class="nav-section">
            <h4>Overview</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/dashboard" class="nav-link">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/analytics" class="nav-link">
                <i class="fas fa-chart-line"></i> Analytics
            </a>
        </div>
        <div class="nav-section">
            <h4>Management</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-users" class="nav-link">
                <i class="fas fa-users-cog"></i> Manage Users
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-questions" class="nav-link active">
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
                    <i class="fas fa-question-circle"></i>
                    Manage Questions
                </h1>
            </div>
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

        <div class="tabs">
            <div class="tab active" onclick="switchTab('coding')">
                <i class="fas fa-code"></i> Coding Questions
            </div>
            <div class="tab" onclick="switchTab('interview')">
                <i class="fas fa-comments"></i> Interview Questions
            </div>
        </div>

        <!-- Coding Questions Tab -->
        <div class="tab-content active" id="coding-tab">
            <div class="add-form">
                <h3>
                    <i class="fas fa-plus-circle"></i>
                    Add Coding Question
                </h3>
                <form action="${pageContext.request.contextPath}/hackerrank/admin/add-coding-question" method="post">
                    <div class="form-grid">
                        <div class="form-group">
                            <label><i class="fas fa-heading"></i> Title</label>
                            <input type="text" name="title" required placeholder="Question title">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-signal"></i> Difficulty</label>
                            <select name="difficulty" required>
                                <option value="EASY">Easy</option>
                                <option value="MEDIUM">Medium</option>
                                <option value="HARD">Hard</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-folder"></i> Category</label>
                            <select name="categoryId" required>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-sign-in-alt"></i> Sample Input</label>
                            <input type="text" name="sampleInput" placeholder="Sample input">
                        </div>
                        <div class="form-group full">
                            <label><i class="fas fa-align-left"></i> Description</label>
                            <textarea name="description" required placeholder="Question description"></textarea>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-sign-out-alt"></i> Sample Output</label>
                            <input type="text" name="sampleOutput" placeholder="Expected output">
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-lightbulb"></i> Solution Hint</label>
                            <input type="text" name="solution" placeholder="Solution approach">
                        </div>
                    </div>
                    <button type="submit" class="btn-add">
                        <i class="fas fa-plus"></i> Add Question
                    </button>
                </form>
            </div>

            <div class="question-list">
                <c:forEach var="q" items="${codingQuestions}">
                    <div class="q-item">
                        <div>
                            <h4>${q.title}</h4>
                            <div class="tags">
                                <span class="tag tag-${q.difficulty == 'EASY' ? 'easy' : q.difficulty == 'MEDIUM' ? 'medium' : 'hard'}">
                                    ${q.difficulty}
                                </span>
                                <c:if test="${not empty q.categoryName}">
                                    <span class="tag tag-cat">${q.categoryName}</span>
                                </c:if>
                            </div>
                        </div>
                        <form action="${pageContext.request.contextPath}/hackerrank/admin/delete-coding-question/${q.id}" method="post"
                            onsubmit="return confirm('Delete this coding question?');">
                            <button class="btn-del" type="submit">
                                <i class="fas fa-trash-alt"></i> Delete
                            </button>
                        </form>
                    </div>
                </c:forEach>
                <c:if test="${empty codingQuestions}">
                    <div class="empty-state">
                        <i class="fas fa-code"></i>
                        <p>No coding questions yet. Add your first question above.</p>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Interview Questions Tab -->
        <div class="tab-content" id="interview-tab">
            <div class="add-form">
                <h3>
                    <i class="fas fa-plus-circle"></i>
                    Add Interview Question
                </h3>
                <form action="${pageContext.request.contextPath}/hackerrank/admin/add-interview-question" method="post">
                    <div class="form-grid">
                        <div class="form-group full">
                            <label><i class="fas fa-question"></i> Question</label>
                            <textarea name="question" required placeholder="Interview question"></textarea>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-tag"></i> Type</label>
                            <select name="questionType" required>
                                <option value="TECHNICAL">Technical</option>
                                <option value="BEHAVIORAL">Behavioral</option>
                                <option value="HR">HR</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-signal"></i> Difficulty</label>
                            <select name="difficulty" required>
                                <option value="EASY">Easy</option>
                                <option value="MEDIUM" selected>Medium</option>
                                <option value="HARD">Hard</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label><i class="fas fa-folder"></i> Category</label>
                            <select name="categoryId">
                                <option value="">None</option>
                                <c:forEach var="cat" items="${categories}">
                                    <option value="${cat.id}">${cat.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group full">
                            <label><i class="fas fa-check-circle"></i> Expected Answer</label>
                            <textarea name="expectedAnswer" placeholder="Expected answer or evaluation criteria"></textarea>
                        </div>
                    </div>
                    <button type="submit" class="btn-add">
                        <i class="fas fa-plus"></i> Add Question
                    </button>
                </form>
            </div>

            <div class="question-list">
                <c:forEach var="q" items="${interviewQuestions}">
                    <div class="q-item">
                        <div>
                            <h4>${q.question}</h4>
                            <div class="tags">
                                <span class="tag tag-type">${q.questionType}</span>
                                <span class="tag tag-${q.difficulty == 'EASY' ? 'easy' : q.difficulty == 'MEDIUM' ? 'medium' : 'hard'}">
                                    ${q.difficulty}
                                </span>
                                <c:if test="${not empty q.categoryName}">
                                    <span class="tag tag-cat">${q.categoryName}</span>
                                </c:if>
                            </div>
                        </div>
                        <form action="${pageContext.request.contextPath}/hackerrank/admin/delete-interview-question/${q.id}" method="post"
                            onsubmit="return confirm('Delete this interview question?');">
                            <button class="btn-del" type="submit">
                                <i class="fas fa-trash-alt"></i> Delete
                            </button>
                        </form>
                    </div>
                </c:forEach>
                <c:if test="${empty interviewQuestions}">
                    <div class="empty-state">
                        <i class="fas fa-comments"></i>
                        <p>No interview questions yet. Add your first question above.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        function switchTab(type) {
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            if (type === 'coding') {
                document.querySelectorAll('.tab')[0].classList.add('active');
                document.getElementById('coding-tab').classList.add('active');
            } else {
                document.querySelectorAll('.tab')[1].classList.add('active');
                document.getElementById('interview-tab').classList.add('active');
            }
        }

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
