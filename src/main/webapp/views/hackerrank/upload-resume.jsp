<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Resume - SmartInterview</title>
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

        .upload-area {
            background: var(--card-bg);
            border: 2px dashed var(--primary);
            border-radius: 24px;
            padding: 60px;
            text-align: center;
            margin-bottom: 36px;
            transition: all 0.3s ease;
            cursor: pointer;
            box-shadow: var(--shadow-sm);
            backdrop-filter: blur(10px);
        }

        .upload-area:hover {
            border-color: var(--accent);
            background: var(--hover-bg);
            box-shadow: var(--glow-primary);
        }

        .upload-area.dragover {
            border-color: var(--primary);
            background: var(--hover-bg);
            box-shadow: var(--glow-primary);
        }

        .upload-icon {
            width: 80px;
            height: 80px;
            background: var(--hover-bg);
            border-radius: 20px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 24px;
            border: 1px solid var(--primary);
        }

        .upload-icon i {
            font-size: 36px;
            color: var(--primary);
        }

        .upload-area h3 {
            font-size: 22px;
            color: var(--text-primary);
            margin-bottom: 10px;
            font-weight: 700;
        }

        .upload-area p {
            color: var(--text-tertiary);
            font-size: 14px;
            margin-bottom: 24px;
        }

        .btn-choose {
            padding: 14px 32px;
            background: var(--gradient-primary);
            color: #fff;
            border: none;
            border-radius: 30px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
        }

        .btn-choose:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(25, 167, 123, 0.4);
        }

        .file-input {
            display: none;
        }

        .section-title {
            font-size: 22px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title i {
            color: var(--primary);
        }

        .resume-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(420px, 1fr));
            gap: 20px;
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
            transform: translateY(-6px);
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }

        .resume-card:hover::before {
            transform: translateX(0);
        }

        .resume-header {
            display: flex;
            align-items: center;
            gap: 18px;
            margin-bottom: 20px;
        }

        .resume-file-icon {
            width: 56px;
            height: 56px;
            background: rgba(239, 68, 68, 0.1);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .resume-file-icon i {
            font-size: 24px;
            color: var(--danger);
        }

        .resume-info h4 {
            font-size: 16px;
            color: var(--text-primary);
            margin-bottom: 6px;
            font-weight: 600;
        }

        .resume-info p {
            font-size: 13px;
            color: var(--text-tertiary);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .resume-info p i {
            color: var(--primary);
        }

        .ai-feedback {
            margin-top: 18px;
            padding: 18px;
            background: linear-gradient(135deg, rgba(25, 167, 123, 0.05), rgba(59, 196, 154, 0.05));
            border: 1px solid rgba(25, 167, 123, 0.15);
            border-radius: 14px;
        }

        .ai-feedback h5 {
            font-size: 14px;
            color: var(--primary);
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .ai-feedback p {
            font-size: 13px;
            color: var(--text-secondary);
            line-height: 1.7;
            white-space: pre-line;
        }

        .ai-score {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 18px;
            background: var(--primary);
            border-radius: 30px;
            font-size: 14px;
            font-weight: 700;
            color: #fff;
            margin-top: 14px;
            box-shadow: 0 2px 8px rgba(25, 167, 123, 0.3);
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
            color: var(--success);
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.08);
            border: 1px solid rgba(239, 68, 68, 0.2);
            color: var(--danger);
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: var(--text-tertiary);
            grid-column: 1 / -1;
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

        .theme-toggle-wrapper {
            display: none;
        }

        /* Mobile Responsive */
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

            .resume-list {
                grid-template-columns: 1fr;
            }

            .upload-area {
                padding: 40px 20px;
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
                <i class="fas fa-file-upload"></i>
                Upload Resume
            </h1>
            <div class="top-bar-actions">
                <div class="stats-mini">
                    <div class="stat-mini-item">
                        <i class="fas fa-file-pdf"></i>
                        <span>${resumes.size()} Resumes</span>
                    </div>
                </div>
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

        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/hackerrank/student/upload-resume" method="post" enctype="multipart/form-data" id="uploadForm">
            <div class="upload-area" id="uploadArea" onclick="document.getElementById('fileInput').click();">
                <div class="upload-icon"><i class="fas fa-cloud-upload-alt"></i></div>
                <h3>Drop your resume here</h3>
                <p>Supports PDF, DOC, DOCX (Max 50MB)</p>
                <button type="button" class="btn-choose"
                    onclick="event.stopPropagation(); document.getElementById('fileInput').click();">
                    <i class="fas fa-folder-open"></i> Choose File
                </button>
                <input type="file" name="file" id="fileInput" class="file-input" accept=".pdf,.doc,.docx"
                    onchange="validateAndSubmit(this.files);">
            </div>
        </form>

        <h2 class="section-title">
            <i class="fas fa-history"></i>
            Your Resumes
        </h2>
        
        <div class="resume-list">
            <c:forEach var="resume" items="${resumes}" varStatus="status">
                <div class="resume-card" style="animation-delay: ${status.index * 0.05}s;">
                    <div class="resume-header">
                        <div class="resume-file-icon"><i class="fas fa-file-pdf"></i></div>
                        <div class="resume-info">
                            <h4>${resume.fileName}</h4>
                            <p>
                                <i class="far fa-calendar-alt"></i>
                                Uploaded: ${resume.uploadedAt}
                            </p>
                        </div>
                        <div style="margin-left: auto;">
                            <a href="${pageContext.request.contextPath}/hackerrank/student/delete-resume/${resume.id}" style="color: var(--danger); text-decoration: none; font-size: 1.2rem; padding: 8px; border-radius: 50%; transition: background 0.3s;" onmouseover="this.style.background='rgba(239, 68, 68, 0.1)'" onmouseout="this.style.background='transparent'" onclick="return confirm('Are you sure you want to delete this resume?');" title="Delete Resume">
                                <i class="fas fa-trash"></i>
                            </a>
                        </div>
                    </div>
                    <c:if test="${not empty resume.aiFeedback}">
                        <div class="ai-feedback">
                            <h5>
                                <i class="fas fa-robot"></i> 
                                AI Feedback
                            </h5>
                            <p>${resume.aiFeedback}</p>
                            <div class="ai-score">
                                <i class="fas fa-star"></i> 
                                Score: ${resume.aiScore}/100
                            </div>
                        </div>
                    </c:if>
                    
                    <form action="${pageContext.request.contextPath}/hackerrank/student/analyze-resume/${resume.id}" method="post" class="analyze-form" style="margin-top: 16px;">
                        <button type="submit" class="btn-choose analyze-btn" style="width: 100%; justify-content: center; background: var(--gradient-primary);" onclick="this.innerHTML='<i class=\'fas fa-spinner fa-spin\'></i> Analyzing... Please wait (this can take up to 20s)'; this.style.pointerEvents='none'; this.style.opacity='0.7';">
                            <i class="fas fa-magic"></i> 
                            <c:choose>
                                <c:when test="${resume.aiScore == 0}">Analyze Resume with AI</c:when>
                                <c:otherwise>Re-Analyze Resume</c:otherwise>
                            </c:choose>
                        </button>
                    </form>
                </div>
            </c:forEach>
            
            <c:if test="${empty resumes}">
                <div class="empty-state">
                    <i class="fas fa-file-pdf"></i>
                    <h3 style="color: var(--text-primary); margin-bottom: 8px;">No Resumes Yet</h3>
                    <p>Upload your first resume to get AI-powered feedback and improve your job applications.</p>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        const uploadArea = document.getElementById('uploadArea');
        uploadArea.addEventListener('dragover', function (e) { 
            e.preventDefault(); 
            this.classList.add('dragover'); 
        });
        uploadArea.addEventListener('dragleave', function () { 
            this.classList.remove('dragover'); 
        });
        function validateAndSubmit(files) {
            if (files.length === 0) return;
            const file = files[0];
            const name = file.name.toLowerCase();
            if (!(name.endsWith('.pdf') || name.endsWith('.doc') || name.endsWith('.docx'))) {
                alert('Invalid file type. Only PDF, DOC, and DOCX files are allowed.');
                return;
            }
            document.getElementById('uploadForm').submit();
        }

        uploadArea.addEventListener('drop', function (e) {
            e.preventDefault(); 
            this.classList.remove('dragover');
            const files = e.dataTransfer.files;
            document.getElementById('fileInput').files = files;
            validateAndSubmit(files);
        });

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
