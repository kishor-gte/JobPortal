<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interviewer Dashboard - SmartInterview</title>
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
            background: var(--gradient-primary);
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

        .btn-logout {
            padding: 10px 20px;
            background: rgba(239, 68, 68, 0.08);
            border: 1px solid rgba(239, 68, 68, 0.2);
            color: var(--danger);
            border-radius: 30px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-logout:hover {
            background: var(--danger);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .btn-back {
            padding: 10px 20px;
            background: rgba(25, 167, 123, 0.08);
            border: 1px solid rgba(25, 167, 123, 0.2);
            color: var(--primary);
            border-radius: 30px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 32px;
        }

        .stat-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 28px;
            text-align: center;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }

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
            font-size: 42px;
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

        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        .card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            animation: slideIn 0.5s ease-out forwards;
            opacity: 0;
        }

        .card:nth-child(1) { animation-delay: 0.4s; }
        .card:nth-child(2) { animation-delay: 0.5s; }

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

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }

        .card-header h3 {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .card-header h3 i {
            color: var(--primary);
        }

        .card-header a {
            color: var(--primary);
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .card-header a:hover {
            color: var(--primary-dark);
            transform: translateX(4px);
        }

        .interview-card {
            padding: 18px 20px;
            background: rgba(26, 42, 44, 0.04);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            margin-bottom: 12px;
            transition: all 0.3s ease;
        }

        .interview-card:hover {
            border-color: var(--primary);
            background: var(--hover-bg);
            transform: translateX(4px);
        }

        .interview-top {
            display: flex;
            justify-content: space-between;
            align-items: start;
            margin-bottom: 12px;
        }

        .interview-card h4 {
            font-size: 16px;
            color: var(--text-primary);
            margin-bottom: 6px;
            font-weight: 600;
        }

        .interview-card p {
            font-size: 12px;
            color: var(--text-tertiary);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .interview-card p i {
            color: var(--primary);
        }

        .status-badge {
            padding: 5px 14px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            backdrop-filter: blur(10px);
        }

        .status-SCHEDULED {
            background: rgba(59, 130, 246, 0.1);
            color: #3b82f6;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .status-COMPLETED {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .status-CANCELLED {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .status-IN_PROGRESS {
            background: rgba(245, 158, 11, 0.1);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .interview-actions {
            display: flex;
            gap: 8px;
            margin-top: 14px;
            flex-wrap: wrap;
        }

        .btn-sm {
            padding: 8px 16px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            backdrop-filter: blur(10px);
        }

        .btn-join {
            background: var(--gradient-primary);
            color: #fff;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-join:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(25, 167, 123, 0.4);
        }

        .btn-evaluate {
            background: linear-gradient(135deg, var(--purple), #6d28d9);
            color: #fff;
            box-shadow: 0 4px 12px rgba(139, 92, 246, 0.3);
        }

        .btn-evaluate:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(139, 92, 246, 0.4);
        }

        .btn-status {
            background: var(--hover-bg);
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .btn-status:hover {
            background: var(--primary);
            color: #fff;
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.08);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .btn-delete:hover {
            background: var(--danger);
            color: #fff;
        }

        .resume-item {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 14px 16px;
            background: rgba(26, 42, 44, 0.04);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            margin-bottom: 10px;
            transition: all 0.3s ease;
        }

        .resume-item:hover {
            border-color: var(--primary);
            background: var(--hover-bg);
            transform: translateX(4px);
        }

        .resume-icon {
            width: 48px;
            height: 48px;
            background: rgba(239, 68, 68, 0.1);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--danger);
            font-size: 20px;
        }

        .resume-info {
            flex: 1;
        }

        .resume-info h4 {
            font-size: 15px;
            color: var(--text-primary);
            margin-bottom: 4px;
            font-weight: 600;
        }

        .resume-info p {
            font-size: 12px;
            color: var(--text-tertiary);
        }

        .btn-download {
            width: 40px;
            height: 40px;
            background: var(--hover-bg);
            border: 1px solid var(--primary);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            text-decoration: none;
            transition: all 0.3s ease;
            flex-shrink: 0;
        }

        .btn-download:hover {
            background: var(--primary);
            color: #fff;
            transform: scale(1.1);
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
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: var(--success);
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

        .theme-toggle {
            display: none;
        }

        /* Mobile Responsive */
        @media (max-width: 1024px) {
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
                box-shadow: var(--shadow-lg);
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
                background: rgba(0, 0, 0, 0.5);
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
    <div class="mobile-overlay" id="mobileOverlay"></div>

    <div class="sidebar" id="sidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-chalkboard-teacher"></i></div>
            <h2>Mentor Panel</h2>
        </div>
        <div class="nav-section">

            <h4>Main</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/dashboard" class="nav-link active">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/evaluations" class="nav-link">
                <i class="fas fa-chart-pie"></i> Student Performance
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/schedule-interview" class="nav-link">
                <i class="fas fa-calendar-plus"></i> Schedule Interview
            </a>
        </div>
        <div class="nav-section">
            <h4>Tools</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/chat" class="nav-link">
                <i class="fas fa-comments"></i> Messages
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/review-resumes" class="nav-link">
                <i class="fas fa-file-alt"></i> Review Resumes
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="nav-link">
                <i class="fa-solid fa-robot fa-fw"></i> AI Evaluations
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/candidates" class="nav-link">
                <i class="fas fa-users fa-fw"></i> Candidates
            </a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/logout" class="nav-link">
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
                <i class="fas fa-chalkboard-teacher"></i>
                ${welcomeMessage}
            </h1>
            <div class="top-bar-actions">
                <button id="theme-toggle" class="theme-toggle" title="Toggle Theme" onclick="toggleTheme()">
                    <i class="fas fa-moon"></i>
                </button>
                <a href="${pageContext.request.contextPath}/company/dashboard" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Back to Company
                </a>
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

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="stat-value">${totalInterviews}</div>
                <div class="stat-label">Total Interviews</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-clock"></i>
                </div>
                <div class="stat-value">${scheduledCount}</div>
                <div class="stat-label">Scheduled</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">
                    <i class="fas fa-check-circle"></i>
                </div>
                <div class="stat-value">${completedCount}</div>
                <div class="stat-label">Completed</div>
            </div>
        </div>

        <div class="content-grid">
            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-calendar-check"></i>
                        My Interviews
                    </h3>
                    <a href="${pageContext.request.contextPath}/hackerrank/interviewer/schedule-interview">
                        Schedule New <i class="fas fa-plus"></i>
                    </a>
                </div>
                <c:forEach var="interview" items="${interviews}">
                    <div class="interview-card">
                        <div class="interview-top">
                            <div>
                                <h4>Interview with ${interview.studentName}</h4>
                                <p>
                                    <i class="fas fa-clock"></i> ${interview.scheduledAt} |
                                    <i class="fas fa-hourglass-half"></i> ${interview.durationMinutes} min
                                </p>
                            </div>
                            <span class="status-badge status-${interview.status}">${interview.status}</span>
                        </div>
                        <div class="interview-actions">
                            <c:if test="${interview.status == 'SCHEDULED'}">
                                <form action="${pageContext.request.contextPath}/hackerrank/interviewer/update-interview-status/${interview.id}"
                                    method="post" style="display: inline;">
                                    <input type="hidden" name="status" value="IN_PROGRESS">
                                    <button class="btn-sm btn-join" type="submit">
                                        <i class="fas fa-rocket"></i> Launch & Admit Student
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${interview.status == 'IN_PROGRESS'}">
                                <a href="${interview.formattedMeetingLink}" target="_blank" class="btn-sm btn-join">
                                    <i class="fas fa-door-open"></i> Enter Meeting Room
                                </a>
                                <a href="${pageContext.request.contextPath}/hackerrank/interviewer/evaluate/${interview.id}" class="btn-sm btn-evaluate">
                                    <i class="fas fa-star"></i> Evaluate
                                </a>
                                <form action="${pageContext.request.contextPath}/hackerrank/interviewer/update-interview-status/${interview.id}"
                                    method="post" style="display: inline;">
                                    <input type="hidden" name="status" value="COMPLETED">
                                    <button class="btn-sm btn-status" type="submit">
                                        <i class="fas fa-check"></i> Complete
                                    </button>
                                </form>
                            </c:if>
                            <c:if test="${interview.status == 'COMPLETED'}">
                                <a href="${pageContext.request.contextPath}/hackerrank/interviewer/evaluate/${interview.id}" class="btn-sm btn-evaluate">
                                    <i class="fas fa-star"></i> View/Add Feedback
                                </a>
                                <a href="${pageContext.request.contextPath}/hackerrank/interviewer/delete-interview/${interview.id}?redirect=/hackerrank/interviewer/dashboard" 
                                   class="btn-sm btn-delete" 
                                   onclick="return confirm('Are you sure you want to delete this interview record?')">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty interviews}">
                    <div class="empty-state">
                        <i class="fas fa-calendar-xmark"></i>
                        <p>No interviews yet</p>
                    </div>
                </c:if>
            </div>

            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-file-alt"></i>
                        Resumes to Review
                    </h3>
                    <a href="${pageContext.request.contextPath}/hackerrank/interviewer/review-resumes">
                        View All <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                <c:forEach var="resume" items="${resumes}" end="5">
                    <div class="resume-item">
                        <div class="resume-icon"><i class="fas fa-file-pdf"></i></div>
                        <div class="resume-info">
                            <h4>${resume.studentName}</h4>
                            <p>${resume.fileName} | ${resume.uploadedAt}</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/hackerrank/interviewer/download-resume/${resume.id}" 
                           class="btn-download" title="Download Resume">
                            <i class="fas fa-download"></i>
                        </a>
                    </div>
                </c:forEach>
                <c:if test="${empty resumes}">
                    <div class="empty-state">
                        <i class="fas fa-file-circle-xmark"></i>
                        <p>No resumes</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        function toggleTheme() {
            // Theme toggle kept for compatibility but hidden
        }

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