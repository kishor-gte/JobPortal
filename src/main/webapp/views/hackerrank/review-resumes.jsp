<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Resumes - SmartInterview</title>
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

        .stats-mini {
            display: flex;
            gap: 16px;
            margin-right: 16px;
        }

        .stat-mini-item {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 30px;
            backdrop-filter: blur(10px);
        }

        .stat-mini-item i {
            color: var(--primary);
            font-size: 14px;
        }

        .stat-mini-item span {
            font-size: 13px;
            font-weight: 600;
            color: var(--text-primary);
        }

        .resumes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(420px, 1fr));
            gap: 24px;
        }

        .resume-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 28px;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
            position: relative;
            overflow: hidden;
        }

        @keyframes cardAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .resume-card::before {
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

        .resume-card:hover {
            border-color: var(--primary);
            transform: translateY(-6px);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }

        .resume-card:hover::before {
            transform: translateX(0);
        }

        .resume-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 20px;
        }

        .resume-avatar {
            width: 56px;
            height: 56px;
            background: var(--gradient-primary);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 700;
            font-size: 22px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .resume-student h4 {
            font-size: 18px;
            color: var(--text-primary);
            margin-bottom: 4px;
            font-weight: 600;
        }

        .resume-student p {
            font-size: 13px;
            color: var(--text-tertiary);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .resume-student p i {
            color: var(--primary);
            font-size: 12px;
        }

        .resume-file {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 16px;
            background: var(--hover-bg);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            margin-bottom: 18px;
            transition: all 0.3s ease;
        }

        .resume-file:hover {
            border-color: var(--primary);
            background: rgba(25, 167, 123, 0.12);
        }

        .file-icon {
            color: var(--danger);
            font-size: 28px;
        }

        .file-info {
            flex: 1;
        }

        .file-info h5 {
            font-size: 15px;
            color: var(--text-primary);
            margin-bottom: 4px;
            font-weight: 600;
        }

        .file-info p {
            font-size: 12px;
            color: var(--text-tertiary);
        }

        .btn-download-icon {
            width: 40px;
            height: 40px;
            background: var(--primary);
            border: none;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            text-decoration: none;
            transition: all 0.3s ease;
            flex-shrink: 0;
        }

        .btn-download-icon:hover {
            background: var(--primary-dark);
            transform: scale(1.1);
        }

        .ai-section {
            padding: 18px;
            background: linear-gradient(135deg, rgba(25, 167, 123, 0.05), rgba(59, 196, 154, 0.05));
            border: 1px solid rgba(25, 167, 123, 0.15);
            border-radius: 14px;
            margin-top: 16px;
        }

        .ai-section h5 {
            font-size: 13px;
            color: var(--primary);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .ai-section p {
            font-size: 13px;
            color: var(--text-secondary);
            line-height: 1.7;
            white-space: pre-line;
        }

        .ai-score-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 16px;
            background: var(--primary);
            border-radius: 30px;
            color: #fff;
            font-size: 13px;
            font-weight: 700;
            margin-top: 12px;
            box-shadow: 0 2px 8px rgba(25, 167, 123, 0.3);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            margin-top: 16px;
        }

        .btn-primary {
            padding: 12px 20px;
            background: var(--gradient-primary);
            color: #fff;
            border: none;
            border-radius: 14px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            flex: 1;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .btn-secondary {
            padding: 12px 20px;
            background: transparent;
            border: 1px solid var(--border-color);
            color: var(--text-secondary);
            border-radius: 14px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            flex: 1;
        }

        .btn-secondary:hover {
            background: var(--hover-bg);
            border-color: var(--primary);
            color: var(--primary);
        }

        .btn-danger {
            padding: 12px 20px;
            background: rgba(239, 68, 68, 0.08);
            border: 1px solid rgba(239, 68, 68, 0.2);
            color: var(--danger);
            border-radius: 14px;
            font-size: 13px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            flex: 1;
        }

        .btn-danger:hover {
            background: var(--danger);
            color: #fff;
            border-color: var(--danger);
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: var(--text-tertiary);
            grid-column: 1 / -1;
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            color: var(--primary);
            opacity: 0.3;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .empty-state h3 {
            font-size: 20px;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .theme-toggle {
            display: none;
        }

        /* Mobile Responsive */
        @media (max-width: 1024px) {
            .resumes-grid {
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

            .stats-mini {
                flex-wrap: wrap;
            }

            .action-buttons {
                flex-wrap: wrap;
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
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/dashboard" class="nav-link">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/evaluations" class="nav-link">
                <i class="fas fa-chart-pie"></i> Student Analytics
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
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/review-resumes" class="nav-link active">
                <i class="fas fa-file-alt"></i> Review Resumes
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="nav-link">
                <i class="fas fa-robot"></i> AI Evaluations
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/candidates" class="nav-link">
                <i class="fas fa-users"></i> Candidates
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
                <i class="fas fa-file-alt"></i>
                Review Resumes
            </h1>
            <div class="top-bar-actions">
                <div class="stats-mini">
                    <div class="stat-mini-item">
                        <i class="fas fa-file-pdf"></i>
                        <span>${resumes.size()} Resumes</span>
                    </div>
                </div>
                <button id="theme-toggle" class="theme-toggle" title="Toggle Theme" onclick="toggleTheme()">
                    <i class="fas fa-moon"></i>
                </button>
                <a href="${pageContext.request.contextPath}/hackerrank/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <div class="resumes-grid">
            <c:forEach var="resume" items="${resumes}" varStatus="status">
                <div class="resume-card" style="animation-delay: ${status.index * 0.05}s;">
                    <div class="resume-header">
                        <div class="resume-avatar">${resume.studentName.substring(0,1)}</div>
                        <div class="resume-student">
                            <h4>${resume.studentName}</h4>
                            <p>
                                <i class="far fa-calendar-alt"></i>
                                Uploaded: ${resume.uploadedAt}
                            </p>
                        </div>
                    </div>
                    
                    <div class="resume-file">
                        <i class="fas fa-file-pdf file-icon"></i>
                        <div class="file-info">
                            <h5>${resume.fileName}</h5>
                            <p>
                                <i class="fas fa-database"></i>
                                Size: ${resume.fileSize / 1024} KB
                            </p>
                        </div>
                        <a href="${pageContext.request.contextPath}/hackerrank/interviewer/download-resume/${resume.id}" 
                           class="btn-download-icon" title="Quick Download">
                            <i class="fas fa-download"></i>
                        </a>
                    </div>

                    <div class="action-buttons">
                        <a href="${pageContext.request.contextPath}/hackerrank/interviewer/download-resume/${resume.id}" class="btn-primary">
                            <i class="fas fa-download"></i> Download
                        </a>
                        <a href="${pageContext.request.contextPath}/hackerrank/interviewer/view-resume/${resume.id}" target="_blank" class="btn-secondary">
                            <i class="fas fa-eye"></i> View
                        </a>
                        <a href="${pageContext.request.contextPath}/hackerrank/interviewer/delete-resume/${resume.id}" 
                           onclick="return confirm('Are you sure you want to delete this resume?');" class="btn-danger">
                            <i class="fas fa-trash-alt"></i> Delete
                        </a>
                    </div>

                    <c:if test="${not empty resume.aiFeedback}">
                        <div class="ai-section">
                            <h5>
                                <i class="fas fa-robot"></i> 
                                AI Analysis
                            </h5>
                            <p>${resume.aiFeedback}</p>
                            <span class="ai-score-badge">
                                <i class="fas fa-star"></i> 
                                Score: ${resume.aiScore}/100
                            </span>
                        </div>
                    </c:if>
                </div>
            </c:forEach>

            <c:if test="${empty resumes}">
                <div class="empty-state">
                    <i class="fas fa-file-circle-xmark"></i>
                    <h3>No Resumes Yet</h3>
                    <p>Resumes uploaded by students will appear here for review.</p>
                </div>
            </c:if>
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