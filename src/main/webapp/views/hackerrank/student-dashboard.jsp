<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - SmartInterview</title>
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

        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.2; }
            50% { opacity: 0.4; }
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
            padding: 14px 16px;
            border-radius: 12px;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 8px;
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

        .user-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .user-avatar {
            width: 44px;
            height: 44px;
            background: var(--gradient-primary);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 700;
            font-size: 18px;
            box-shadow: var(--glow-primary);
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
            transition: all 0.3s ease;
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 32px;
        }

        .stat-card, .card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 24px;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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

        .stat-card:hover, .card:hover {
            transform: translateY(-6px);
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }

        .stat-icon {
            width: 52px;
            height: 52px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 18px;
            font-size: 24px;
        }

        .stat-icon.purple {
            background: var(--hover-bg);
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .stat-icon.green {
            background: rgba(16, 185, 129, 0.12);
            color: var(--success);
            border: 1px solid var(--success);
        }

        .stat-icon.blue {
            background: rgba(59, 130, 246, 0.12);
            color: var(--info);
            border: 1px solid var(--info);
        }

        .stat-icon.orange {
            background: rgba(245, 158, 11, 0.12);
            color: var(--warning);
            border: 1px solid var(--warning);
        }

        .stat-value {
            font-size: 36px;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 6px;
        }

        .stat-label {
            color: var(--text-tertiary);
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
        }

        .content-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 24px;
            margin-bottom: 32px;
			
        }
		.card {
		    width: 100%;
		    max-width: 900px;   /* Increase this value as needed */
		    margin: 0 auto;
		}
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-header h3 {
            font-size: 18px;
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
        }

        .card-header a:hover {
            color: var(--primary-dark);
            transform: translateX(4px);
        }

        .question-item {
            padding: 16px 18px;
            background: var(--hover-bg);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .question-item:hover {
            border-color: var(--primary);
            background: rgba(25, 167, 123, 0.12);
            transform: translateX(4px);
        }

        .q-info h4 {
            font-size: 15px;
            color: var(--text-primary);
            margin-bottom: 6px;
            font-weight: 600;
        }

        .q-meta {
            display: flex;
            gap: 10px;
        }

        .q-meta span {
            font-size: 11px;
            padding: 4px 10px;
            border-radius: 30px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .badge-easy {
            background: rgba(16, 185, 129, 0.12);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .badge-medium {
            background: rgba(245, 158, 11, 0.12);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .badge-hard {
            background: rgba(239, 68, 68, 0.12);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .badge-cat {
            background: rgba(25, 167, 123, 0.12);
            color: var(--primary);
            border: 1px solid rgba(25, 167, 123, 0.3);
        }

        .btn-attempt {
            padding: 8px 18px;
            background: var(--gradient-primary);
            color: #fff;
            border: none;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-attempt:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .interview-item {
            padding: 16px;
            background: var(--hover-bg);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            margin-bottom: 10px;
            transition: all 0.3s ease;
        }

        .interview-item:hover {
            border-color: var(--primary);
            transform: translateX(4px);
        }

        .interview-item h4 {
            font-size: 15px;
            color: var(--text-primary);
            margin-bottom: 8px;
            font-weight: 600;
        }

        .interview-item p {
            font-size: 13px;
            color: var(--text-tertiary);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .interview-item p i {
            color: var(--primary);
        }

        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .status-scheduled {
            background: rgba(59, 130, 246, 0.12);
            color: var(--info);
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .status-completed {
            background: rgba(16, 185, 129, 0.12);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .status-cancelled {
            background: rgba(239, 68, 68, 0.12);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .progress-chart {
            margin-top: 16px;
        }

        .progress-bar-container {
            margin-bottom: 14px;
        }

        .progress-label {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .progress-label span:first-child {
            color: var(--text-secondary);
            font-weight: 500;
        }

        .progress-label span:last-child {
            color: var(--primary);
            font-weight: 700;
        }

        .progress-bar {
            height: 10px;
            background: var(--border-color);
            border-radius: 10px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            border-radius: 10px;
            transition: width 1.5s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .fill-purple {
            background: var(--gradient-primary);
        }

        .fill-green {
            background: linear-gradient(90deg, var(--success), #4ade80);
        }

        .fill-blue {
            background: linear-gradient(90deg, var(--info), #60a5fa);
        }

        .fill-orange {
            background: linear-gradient(90deg, var(--warning), #fb923c);
        }

        .feedback-item {
            padding: 16px;
            background: var(--hover-bg);
            border-left: 3px solid var(--primary);
            border-radius: 0 14px 14px 0;
            margin-bottom: 10px;
            transition: all 0.3s ease;
        }

        .feedback-item:hover {
            border-left-color: var(--accent);
            transform: translateX(4px);
        }

        .feedback-item h4 {
            font-size: 14px;
            color: var(--text-primary);
            margin-bottom: 6px;
            font-weight: 600;
        }

        .feedback-item p {
            font-size: 13px;
            color: var(--text-tertiary);
            line-height: 1.6;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: var(--text-tertiary);
        }

        .empty-state i {
            font-size: 48px;
            margin-bottom: 16px;
            display: block;
            color: var(--primary);
            opacity: 0.3;
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

        .qualification-card {
            margin-bottom: 32px;
            border-left: 4px solid var(--success);
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-left-width: 4px;
            border-left-color: ${isQualified ? 'var(--success)' : 'var(--warning)'};
            border-radius: 20px;
            padding: 24px 28px;
            box-shadow: var(--shadow-sm);
        }

        .qualification-progress {
            width: 100%;
            height: 8px;
            background: var(--border-color);
            border-radius: 10px;
            margin-top: 14px;
            overflow: hidden;
        }

        .qualification-fill {
            height: 100%;
            background: var(--warning);
            border-radius: 10px;
            transition: width 1s ease;
        }

        .theme-toggle-wrapper {
            display: none;
        }

        /* Mobile Responsive */
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
                <i class="fas fa-hand-wave"></i>
                Welcome, ${jobSeeker.name}!
            </h1>
            <div class="user-info">
                <div class="theme-toggle-wrapper">
                    <span class="theme-toggle-label">Theme</span>
                    <div class="theme-toggle" id="themeToggle" onclick="toggleTheme()" title="Toggle light/dark mode">
                        <div class="toggle-thumb"><i class="fas fa-moon"></i></div>
                    </div>
                </div>
                <div class="user-avatar">${jobSeeker.name.substring(0,1)}</div>
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
                <div class="stat-icon purple"><i class="fas fa-pen-to-square"></i></div>
                <div class="stat-value">${totalAttempted}</div>
                <div class="stat-label">Questions Attempted</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-check-circle"></i></div>
                <div class="stat-value">${totalCorrect}</div>
                <div class="stat-label">Correct Answers</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fas fa-video"></i></div>
                <div class="stat-value">${interviews.size()}</div>
                <div class="stat-label">Mock Interviews</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange"><i class="fas fa-file-alt"></i></div>
                <div class="stat-value">${resumes.size()}</div>
                <div class="stat-label">Resumes Uploaded</div>
            </div>
        </div>

        <div class="content-grid">
            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-star"></i>
                        Recommended Questions
                    </h3>
                    <a href="${pageContext.request.contextPath}/hackerrank/student/coding-practice">
                        View All <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                <c:forEach var="q" items="${recommendedQuestions}">
                    <div class="question-item" onclick="window.location.href='${pageContext.request.contextPath}/hackerrank/student/coding-question/${q.id}'">
                        <div class="q-info">
                            <h4>${q.title}</h4>
                            <div class="q-meta">
                                <span class="badge-${q.difficulty == 'EASY' ? 'easy' : q.difficulty == 'MEDIUM' ? 'medium' : 'hard'}">
                                    ${q.difficulty}
                                </span>
                                <c:if test="${not empty q.categoryName}">
                                    <span class="badge-cat">${q.categoryName}</span>
                                </c:if>
                            </div>
                        </div>
                        <a href="${pageContext.request.contextPath}/hackerrank/student/coding-question/${q.id}" class="btn-attempt">
                            <i class="fas fa-play"></i> Attempt
                        </a>
                    </div>
                </c:forEach>
                <c:if test="${empty recommendedQuestions}">
                    <div class="empty-state">
                        <i class="fas fa-check-double"></i>
                        <p>All questions attempted!</p>
                    </div>
                </c:if>
            </div>

            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-chart-pie"></i>
                        Performance
                    </h3>
                    <a href="${pageContext.request.contextPath}/hackerrank/student/performance">
                        Details <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                <div class="progress-chart">
                    <c:forEach var="perf" items="${performances}">
                        <div class="progress-bar-container">
                            <div class="progress-label">
                                <span>${not empty perf.categoryName ? perf.categoryName : 'Overall'}</span>
                                <span>${perf.overallScore}%</span>
                            </div>
                            <div class="progress-bar">
                                <div class="progress-fill fill-purple" style="width: 0%" data-width="${perf.overallScore}"></div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty performances}">
                        <div class="empty-state">
                            <i class="fas fa-chart-bar"></i>
                            <p>No performance data yet</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <div class="content-grid">
            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-calendar-alt"></i>
                         Interviews
                    </h3>
                    <a href="${pageContext.request.contextPath}/hackerrank/student/mock-interview">
                        View All <i class="fas fa-arrow-right"></i>
                    </a>
                </div>
                <c:forEach var="interview" items="${interviews}">
                    <div class="interview-item">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <div>
                                <h4>Interview with ${interview.interviewerName}</h4>
                                <p>
                                    <i class="fas fa-clock"></i> ${interview.scheduledAt} | 
                                    <i class="fas fa-hourglass-half"></i> ${interview.durationMinutes} min
                                </p>
                            </div>
                            <span class="status-badge status-${interview.status == 'SCHEDULED' ? 'scheduled' : interview.status == 'COMPLETED' ? 'completed' : 'cancelled'}">
                                ${interview.status}
                            </span>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty interviews}">
                    <div class="empty-state">
                        <i class="fas fa-calendar-xmark"></i>
                        <p>No interviews scheduled</p>
                    </div>
                </c:if>
            </div>
			 </div>
    </div>

    <script>
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

        // Animate progress bars on load
        document.addEventListener('DOMContentLoaded', function() {
            const progressFills = document.querySelectorAll('.progress-fill');
            progressFills.forEach(fill => {
                const targetWidth = fill.getAttribute('data-width');
                if (targetWidth) {
                    setTimeout(() => {
                        fill.style.width = targetWidth + '%';
                    }, 200);
                }
            });

            // Mobile Menu Functionality
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
