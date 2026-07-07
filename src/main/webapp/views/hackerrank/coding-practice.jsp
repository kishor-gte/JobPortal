<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Coding Practice - SmartInterview</title>
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
            gap: 20px;
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

        .filters {
            display: flex;
            gap: 12px;
            margin-bottom: 28px;
            flex-wrap: wrap;
            align-items: center;
        }

        .filter-btn {
            padding: 10px 20px;
            border-radius: 30px;
            border: 1px solid var(--border-color);
            background: var(--card-bg);
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .filter-btn i {
            font-size: 12px;
            color: var(--text-tertiary);
        }

        .filter-btn:hover {
            background: var(--hover-bg);
            color: var(--primary);
            border-color: var(--primary);
            transform: translateY(-2px);
        }

        .filter-btn:hover i {
            color: var(--primary);
        }

        .filter-btn.active {
            background: var(--gradient-primary);
            color: white;
            border-color: transparent;
            box-shadow: var(--glow-primary);
        }

        .filter-btn.active i {
            color: white;
        }

        .filter-divider {
            color: var(--border-color);
            font-size: 18px;
            margin: 0 4px;
        }

        .search-box {
            margin-left: auto;
            display: flex;
            align-items: center;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 30px;
            padding: 8px 16px;
            backdrop-filter: blur(10px);
        }

        .search-box i {
            color: var(--text-tertiary);
            margin-right: 8px;
        }

        .search-box input {
            background: none;
            border: none;
            color: var(--text-primary);
            font-size: 13px;
            outline: none;
            width: 200px;
        }

        .search-box input::placeholder {
            color: var(--text-tertiary);
        }

        .questions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 20px;
        }

        .question-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 28px;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        @keyframes cardAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .question-card::before {
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

        .question-card:hover {
            transform: translateY(-6px);
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }

        .question-card:hover::before {
            transform: translateX(0);
        }

        .question-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 12px;
        }

        .question-card h3 {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 4px;
            line-height: 1.4;
        }

        .question-card p {
            font-size: 13px;
            color: var(--text-tertiary);
            line-height: 1.7;
            margin-bottom: 18px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .question-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .tags {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .tag {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
            backdrop-filter: blur(10px);
        }

        .tag-easy {
            background: rgba(16, 185, 129, 0.12);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .tag-medium {
            background: rgba(245, 158, 11, 0.12);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .tag-hard {
            background: rgba(239, 68, 68, 0.12);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .tag-cat {
            background: rgba(25, 167, 123, 0.12);
            color: var(--primary);
            border: 1px solid rgba(25, 167, 123, 0.3);
        }

        .completion-badge {
            position: absolute;
            top: 16px;
            right: 16px;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background: var(--success);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
            box-shadow: 0 2px 8px rgba(16, 185, 129, 0.3);
        }

        .btn-solve {
            padding: 10px 22px;
            background: var(--gradient-primary);
            color: #fff;
            border: none;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-solve i {
            font-size: 12px;
            transition: transform 0.3s ease;
        }

        .btn-solve:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .btn-solve:hover i {
            transform: translateX(4px);
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

        .alert i {
            font-size: 18px;
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: var(--text-tertiary);
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

        .theme-toggle-wrapper {
            display: none;
        }

        /* Mobile Responsive */
        @media (max-width: 1024px) {
            .questions-grid {
                grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
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

            .questions-grid {
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

            .stats-mini {
                flex-wrap: wrap;
            }

            .filters {
                overflow-x: auto;
                padding-bottom: 8px;
            }

            .filter-btn {
                white-space: nowrap;
            }

            .search-box {
                width: 100%;
                margin-left: 0;
            }

            .search-box input {
                width: 100%;
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
                <i class="fas fa-code"></i>
                Coding Practice
            </h1>
            <div class="top-bar-actions">
                <div class="stats-mini">
                    <div class="stat-mini-item">
                        <i class="fas fa-check-circle"></i>
                        <span>${completedCount != null ? completedCount : 0} Solved</span>
                    </div>
                    <div class="stat-mini-item">
                        <i class="fas fa-trophy"></i>
                        <span>${totalQuestions != null ? totalQuestions : codingQuestions.size()} Total</span>
                    </div>
                </div>
                <div class="theme-toggle-wrapper">
                    <span class="theme-toggle-label">Theme</span>
                    <div class="theme-toggle" id="themeToggle" onclick="toggleTheme()" title="Toggle light/dark mode">
                        <div class="toggle-thumb"><i class="fas fa-moon"></i></div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>

        <div class="filters">
            <a href="${pageContext.request.contextPath}/hackerrank/student/coding-practice"
                class="filter-btn ${empty selectedCategory && empty selectedDifficulty ? 'active' : ''}">
                <i class="fas fa-grid-2"></i> All
            </a>
            <c:forEach var="cat" items="${categories}">
                <a href="${pageContext.request.contextPath}/hackerrank/student/coding-practice?categoryId=${cat.id}<c:if test='${not empty selectedDifficulty}'>&difficulty=${selectedDifficulty}</c:if>"

                    class="filter-btn ${selectedCategory == cat.id ? 'active' : ''}">
                    <i class="fas fa-folder"></i> ${cat.name}
                </a>
            </c:forEach>
            <span class="filter-divider">|</span>
            <a href="${pageContext.request.contextPath}/hackerrank/student/coding-practice?difficulty=EASY<c:if test='${not empty selectedCategory}'>&categoryId=${selectedCategory}</c:if>"
                class="filter-btn ${selectedDifficulty == 'EASY' ? 'active' : ''}">
                <i class="fas fa-circle" style="color: #10b981; font-size: 8px;"></i> Easy
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/student/coding-practice?difficulty=MEDIUM<c:if test='${not empty selectedCategory}'>&categoryId=${selectedCategory}</c:if>"
                class="filter-btn ${selectedDifficulty == 'MEDIUM' ? 'active' : ''}">
                <i class="fas fa-circle" style="color: #f59e0b; font-size: 8px;"></i> Medium
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/student/coding-practice?difficulty=HARD<c:if test='${not empty selectedCategory}'>&categoryId=${selectedCategory}</c:if>"
                class="filter-btn ${selectedDifficulty == 'HARD' ? 'active' : ''}">
                <i class="fas fa-circle" style="color: #ef4444; font-size: 8px;"></i> Hard
            </a>
            
            <div class="search-box">
                <i class="fas fa-search"></i>
                <input type="text" id="searchInput" placeholder="Search questions..." value="${searchQuery}">
            </div>
        </div>

        <div class="questions-grid" id="questionsGrid">
            <c:forEach var="q" items="${codingQuestions}" varStatus="status">
                <div class="question-card" 
                     data-title="${not empty q.title ? q.title.toLowerCase() : ''}" 
                     data-category="${not empty q.categoryName ? q.categoryName.toLowerCase() : ''}">
                    <div class="question-header">
                        <h3>${q.title}</h3>
                        <c:if test="${not empty solvedQuestionIds && solvedQuestionIds.contains(q.id)}">
                            <div class="completion-badge" title="Solved">
                                <i class="fas fa-check"></i>
                            </div>
                        </c:if>
                    </div>
                    <p>${q.description}</p>
                    <div class="question-footer">
                        <div class="tags">
                            <span class="tag tag-${q.difficulty == 'EASY' ? 'easy' : q.difficulty == 'MEDIUM' ? 'medium' : 'hard'}">
                                ${q.difficulty}
                            </span>
                            <c:if test="${not empty q.categoryName}">
                                <span class="tag tag-cat">${q.categoryName}</span>
                            </c:if>
                        </div>
                        <a href="${pageContext.request.contextPath}/hackerrank/student/coding-question/${q.id}" class="btn-solve">
                            <i class="fas fa-play"></i> Solve
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <c:if test="${empty codingQuestions}">
            <div class="empty-state">
                <i class="fas fa-search"></i>
                <h3>No questions found</h3>
                <p>Try adjusting your filters or search query.</p>
            </div>
        </c:if>
    </div>

    <script>
        function toggleTheme() {
            const body = document.body;
            const toggle = document.getElementById('themeToggle');
            const icon = toggle.querySelector('i');
            const isLight = body.classList.toggle('light-mode');
            toggle.classList.toggle('light', isLight);
            icon.className = isLight ? 'fas fa-sun' : 'fas fa-moon';
            localStorage.setItem('studentDashboardTheme', isLight ? 'light' : 'dark');
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

            // Search functionality
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('input', function() {
                    const searchTerm = this.value.toLowerCase();
                    const cards = document.querySelectorAll('.question-card');
                    
                    cards.forEach(card => {
                        const title = card.dataset.title || '';
                        const category = card.dataset.category || '';
                        const text = card.textContent.toLowerCase();
                        
                        if (title.includes(searchTerm) || category.includes(searchTerm) || text.includes(searchTerm)) {
                            card.style.display = 'block';
                        } else {
                            card.style.display = 'none';
                        }
                    });
                });

                // Focus search on Ctrl+K
                document.addEventListener('keydown', function(e) {
                    if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                        e.preventDefault();
                        searchInput.focus();
                    }
                });
            }

            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Escape to clear search and close sidebar
                if (e.key === 'Escape') {
                    if (searchInput) {
                        searchInput.value = '';
                        searchInput.dispatchEvent(new Event('input'));
                    }
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
            });
        });
    </script>
</body>
</html>
