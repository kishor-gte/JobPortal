<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mock Interview - SmartInterview</title>
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
            --success: #19A77B;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --purple: #8b5cf6;
            --orange: #f97316;
            --pink: #ec4899;
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

        .card:nth-child(1) { animation-delay: 0.1s; }
        .card:nth-child(2) { animation-delay: 0.2s; }

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

        .interview-card {
            padding: 20px;
            background: rgba(26, 42, 44, 0.04);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            margin-bottom: 14px;
            transition: all 0.3s ease;
        }

        .interview-card:hover {
            border-color: var(--primary);
            background: var(--hover-bg);
            transform: translateX(4px);
        }

        .interview-card h4 {
            font-size: 16px;
            color: var(--text-primary);
            margin-bottom: 10px;
            font-weight: 600;
        }

        .interview-card p {
            font-size: 13px;
            color: var(--text-tertiary);
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .interview-card p i {
            color: var(--primary);
            width: 16px;
        }

        .interview-card .actions {
            display: flex;
            gap: 10px;
            margin-top: 16px;
            flex-wrap: wrap;
        }

        .btn-join {
            padding: 10px 20px;
            background: var(--gradient-primary);
            color: #fff;
            border: none;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
            transition: all 0.3s ease;
        }

        .btn-join:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .status-badge {
            padding: 5px 14px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-scheduled {
            background: rgba(59, 130, 246, 0.1);
            color: var(--info);
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .status-completed {
            background: rgba(25, 167, 123, 0.1);
            color: var(--success);
            border: 1px solid rgba(25, 167, 123, 0.3);
        }

        .status-inprogress {
            background: rgba(25, 167, 123, 0.1);
            color: var(--primary);
            border: 1px solid rgba(25, 167, 123, 0.3);
        }

        .waiting-badge {
            margin-top: 14px;
            padding: 12px 16px;
            background: rgba(245, 158, 11, 0.08);
            border: 1px solid rgba(245, 158, 11, 0.2);
            border-radius: 12px;
            font-size: 12px;
            color: var(--warning);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .waiting-badge i {
            color: var(--warning);
            font-size: 14px;
        }

        .iq-item {
            padding: 18px 20px;
            background: rgba(26, 42, 44, 0.04);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            margin-bottom: 14px;
            transition: all 0.3s ease;
        }

        .iq-item:hover {
            border-color: var(--primary);
            background: var(--hover-bg);
        }

        .iq-item h4 {
            font-size: 15px;
            color: var(--text-primary);
            margin-bottom: 10px;
            font-weight: 600;
            line-height: 1.5;
        }

        .iq-meta {
            display: flex;
            gap: 8px;
            margin-bottom: 14px;
            flex-wrap: wrap;
        }

        .iq-meta span {
            padding: 5px 12px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .tag-technical {
            background: rgba(25, 167, 123, 0.12);
            color: var(--primary);
            border: 1px solid rgba(25, 167, 123, 0.3);
        }

        .tag-behavioral {
            background: rgba(245, 158, 11, 0.12);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .tag-hr {
            background: rgba(236, 72, 153, 0.12);
            color: var(--pink);
            border: 1px solid rgba(236, 72, 153, 0.3);
        }

        .tag-category {
            background: rgba(59, 196, 154, 0.12);
            color: var(--accent);
            border: 1px solid rgba(59, 196, 154, 0.3);
        }

        .answer-form {
            margin-top: 14px;
        }

        .answer-form textarea {
            width: 100%;
            padding: 14px 16px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            color: var(--text-primary);
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            resize: vertical;
            min-height: 90px;
            outline: none;
            transition: all 0.3s ease;
            line-height: 1.6;
        }

        .answer-form textarea::placeholder {
            color: var(--text-tertiary);
        }

        .answer-form textarea:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        .btn-submit-ans {
            margin-top: 12px;
            padding: 10px 22px;
            background: var(--gradient-primary);
            color: #fff;
            border: none;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-submit-ans:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
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

        .theme-toggle-wrapper {
            display: none;
        }

        /* Responsive Design */
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
                <i class="fas fa-video"></i>
                Mock Interviews
            </h1>
            <div class="top-bar-actions">
                <div class="theme-toggle-wrapper">
                    <span class="theme-toggle-label">Theme</span>
                    <div class="theme-toggle" id="themeToggle" onclick="toggleTheme()" title="Toggle light/dark mode">
                        <div class="toggle-thumb"><i class="fas fa-moon"></i></div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/hackerrank/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <div class="content-grid">
            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-calendar-alt"></i>
                        Your Interviews
                    </h3>
                </div>
                <c:forEach var="interview" items="${interviews}">
                    <div class="interview-card">
                        <div style="display: flex; justify-content: space-between; align-items: start;">
                            <div>
                                <h4>Interview with ${interview.interviewerName}</h4>
                                <p><i class="fas fa-clock"></i> ${interview.scheduledAt}</p>
                                <p><i class="fas fa-hourglass-half"></i> ${interview.durationMinutes} minutes</p>
                            </div>
                            <span class="status-badge status-${interview.status == 'SCHEDULED' ? 'scheduled' : interview.status == 'COMPLETED' ? 'completed' : 'inprogress'}">
                                ${interview.status}
                            </span>
                        </div>
                        <c:if test="${interview.status == 'IN_PROGRESS'}">
                            <div class="actions">
                                <a href="${interview.formattedMeetingLink}" target="_blank" class="btn-join">
                                    <i class="fas fa-video"></i> Join Scheduled Meeting
                                </a>
                            </div>
                        </c:if>
                        <c:if test="${interview.status == 'SCHEDULED'}">
                            <div class="waiting-badge">
                                <i class="fas fa-hourglass-half"></i>
                                Waiting for interviewer to start the session...
                            </div>
                        </c:if>
                    </div>
                </c:forEach>
                <c:if test="${empty interviews}">
                    <div class="empty-state">
                        <i class="fas fa-calendar-xmark"></i>
                        <p>No interviews scheduled yet</p>
                    </div>
                </c:if>
            </div>

            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-question-circle"></i>
                        Practice Questions
                    </h3>
                </div>
                <c:forEach var="q" items="${interviewQuestions}" end="5">
                    <div class="iq-item">
                        <h4>${q.question}</h4>
                        <div class="iq-meta">
                            <span class="tag-${q.questionType == 'TECHNICAL' ? 'technical' : q.questionType == 'BEHAVIORAL' ? 'behavioral' : 'hr'}">
                                ${q.questionType}
                            </span>
                            <c:if test="${not empty q.categoryName}">
                                <span class="tag-category">${q.categoryName}</span>
                            </c:if>
                        </div>
                        <div class="answer-form">
                            <form action="${pageContext.request.contextPath}/hackerrank/student/submit-answer" method="post">
                                <input type="hidden" name="questionId" value="${q.id}">
                                <input type="hidden" name="questionType" value="INTERVIEW">
                                <input type="hidden" name="timeTaken" value="0">
                                <textarea name="answer" placeholder="Type your answer here..."></textarea>
                                <button type="submit" class="btn-submit-ans">
                                    <i class="fas fa-paper-plane"></i> Submit Answer
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty interviewQuestions}">
                    <div class="empty-state">
                        <i class="fas fa-comment-dots"></i>
                        <p>No practice questions available</p>
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
