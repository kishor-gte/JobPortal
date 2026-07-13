<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Admin Dashboard | JobU - SmartInterview</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Early theme initialization -->
    <script>
        (function() {
            const savedTheme = localStorage.getItem('theme');
            if (savedTheme !== 'dark') {
                document.documentElement.classList.add('light-mode');
            }
        })();
    </script>
    
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
            --accent-light: #6ed4b2;
            --bg-dark: #2E3E41;
            --bg-dark-light: #3d5256;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --info: #3b82f6;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
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
            background: #0f172a;
            color: #e2e8f0;
            min-height: 100vh;
        }

        /* Enhanced Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
            border-right: 1px solid rgba(25,167,123,0.15);
            padding: 24px 16px;
            z-index: 100;
            overflow-y: auto;
            transition: var(--transition);
        }

        .sidebar::-webkit-scrollbar {
            width: 5px;
        }
        .sidebar::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
        }
        .sidebar::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 10px;
        }

        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 0 8px 24px;
            border-bottom: 1px solid rgba(25,167,123,0.2);
            margin-bottom: 24px;
        }

        .sidebar-logo .icon {
            width: 45px;
            height: 45px;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--shadow-md);
        }

        .sidebar-logo .icon i {
            color: #fff;
            font-size: 20px;
        }

        .sidebar-logo h2 {
            font-size: 20px;
            font-weight: 800;
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .nav-section {
            margin-bottom: 28px;
        }

        .nav-section h4 {
            color: rgba(255, 255, 255, 0.35);
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding: 0 12px;
            margin-bottom: 12px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 12px;
            border-radius: 12px;
            color: rgba(255, 255, 255, 0.65);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: var(--transition);
            margin-bottom: 4px;
        }

        .nav-link:hover {
            background: rgba(25,167,123,0.12);
            color: var(--accent);
            transform: translateX(4px);
        }

        .nav-link.active {
            background: linear-gradient(135deg, rgba(25,167,123,0.2), rgba(59,196,154,0.1));
            color: var(--accent);
            border-left: 3px solid var(--primary);
        }

        .nav-link i {
            width: 22px;
            text-align: center;
        }

        /* Main Content */
        .main-content {
            margin-left: 280px;
            padding: 28px 32px;
        }

        /* Top Bar */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            flex-wrap: wrap;
            gap: 16px;
        }

        .top-bar h1 {
            font-size: 28px;
            font-weight: 800;
            background: linear-gradient(135deg, var(--accent), var(--primary), var(--accent-light));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .top-bar h1 i {
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .admin-badge {
            padding: 6px 16px;
            background: rgba(25,167,123,0.15);
            border: 1px solid rgba(25,167,123,0.3);
            color: var(--accent);
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        /* Theme Toggle Button */
        .theme-toggle {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
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
            background: rgba(25,167,123,0.15);
            color: var(--accent);
            transform: translateY(-2px);
        }

        .btn-logout {
            padding: 8px 20px;
            background: rgba(239, 68, 68, 0.12);
            border: 1px solid rgba(239, 68, 68, 0.25);
            color: #f87171;
            border-radius: 30px;
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-logout:hover {
            background: rgba(239, 68, 68, 0.2);
            transform: translateY(-2px);
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 24px;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.06);
            border-radius: 20px;
            padding: 20px;
            transition: var(--transition);
        }

        .stat-card:hover {
            transform: translateY(-6px);
            border-color: rgba(25,167,123,0.3);
            box-shadow: var(--shadow-lg);
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 16px;
            font-size: 20px;
        }

        .stat-icon.orange { background: rgba(25,167,123,0.12); color: var(--accent); }
        .stat-icon.blue { background: rgba(59, 130, 246, 0.12); color: #60a5fa; }
        .stat-icon.green { background: rgba(34, 197, 94, 0.12); color: #4ade80; }
        .stat-icon.purple { background: rgba(139, 92, 246, 0.12); color: #a78bfa; }
        .stat-icon.cyan { background: rgba(6, 182, 212, 0.12); color: #22d3ee; }
        .stat-icon.pink { background: rgba(236, 72, 153, 0.12); color: #f472b6; }
        .stat-icon.yellow { background: rgba(234, 179, 8, 0.12); color: #facc15; }
        .stat-icon.red { background: rgba(239, 68, 68, 0.12); color: #f87171; }

        .stat-value {
            font-size: 32px;
            font-weight: 800;
            color: #fff;
            line-height: 1.2;
        }

        .stat-label {
            color: rgba(255, 255, 255, 0.5);
            font-size: 12px;
            margin-top: 6px;
            font-weight: 500;
        }

        /* Content Grid */
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }

        .card {
            background: rgba(255, 255, 255, 0.03);
            border: 1px solid rgba(255, 255, 255, 0.06);
            border-radius: 20px;
            padding: 24px;
            transition: var(--transition);
        }

        .card:hover {
            border-color: rgba(25,167,123,0.2);
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
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .card-header a {
            color: var(--accent);
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: var(--transition);
        }

        .card-header a:hover {
            text-decoration: underline;
        }

        .user-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px;
            background: rgba(255, 255, 255, 0.02);
            border-radius: 12px;
            margin-bottom: 8px;
            transition: var(--transition);
        }

        .user-item:hover {
            background: rgba(25,167,123,0.05);
            transform: translateX(4px);
        }

        .user-item .info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 14px;
            font-weight: 700;
            color: #fff;
        }

        .user-avatar.admin { background: linear-gradient(135deg, #f97316, #ef4444); }
        .user-avatar.student { background: linear-gradient(135deg, var(--primary), var(--accent)); }
        .user-avatar.interviewer { background: linear-gradient(135deg, #22c55e, #16a34a); }
        .user-avatar.company { background: linear-gradient(135deg, #10b981, #059669); }

        .user-name {
            font-size: 14px;
            font-weight: 600;
            color: #e2e8f0;
        }

        .user-role {
            font-size: 11px;
            padding: 4px 12px;
            border-radius: 20px;
            font-weight: 600;
        }

        .role-admin { background: rgba(249, 115, 22, 0.12); color: #fb923c; }
        .role-student { background: rgba(25,167,123, 0.12); color: var(--accent); }
        .role-interviewer { background: rgba(34, 197, 94, 0.12); color: #4ade80; }
        .role-company { background: rgba(16, 185, 129, 0.12); color: #34d399; }

        /* ============================================
           LIGHT MODE ENHANCEMENTS
        ============================================ */
        html.light-mode body {
            background: #f1f5f9;
            color: #1e293b;
        }

        html.light-mode .sidebar {
            background: #ffffff;
            border-right: 1px solid #e2e8f0;
        }

        html.light-mode .sidebar-logo h2 {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        html.light-mode .nav-link {
            color: #475569;
        }

        html.light-mode .nav-link:hover {
            background: rgba(25,167,123,0.08);
            color: var(--primary);
        }

        html.light-mode .nav-link.active {
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            color: var(--primary);
            border-left: 3px solid var(--primary);
        }

        html.light-mode .stat-card, html.light-mode .card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            box-shadow: var(--shadow-sm);
        }

        html.light-mode .stat-value {
            color: var(--primary);
        }

        html.light-mode .stat-label {
            color: #64748b;
        }

        html.light-mode .card-header h3 {
            color: #0f172a;
        }

        html.light-mode .user-item {
            background: #f8fafc;
            border: 1px solid #f1f5f9;
        }

        html.light-mode .user-name {
            color: #1e293b;
        }

        html.light-mode .theme-toggle {
            background: white;
            border-color: #e2e8f0;
            color: #475569;
            box-shadow: var(--shadow-sm);
        }

        html.light-mode .theme-toggle:hover {
            background: var(--primary);
            color: white;
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
                z-index: 1001;
            }
            .sidebar.active {
                transform: translateX(0);
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
    </style>
</head>

<body>
    <div class="sidebar" id="mainSidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-shield-halved"></i></div>
            <h2>Admin Panel</h2>
        </div>
        <div class="nav-section">
            <h4>Overview</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/dashboard" class="nav-link active"><i class="fas fa-th-large"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/analytics" class="nav-link"><i class="fas fa-chart-bar"></i> Analytics</a>
        </div>
        <div class="nav-section">
            <h4>Management</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-users" class="nav-link"><i class="fas fa-users-cog"></i> Manage Users</a>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-questions" class="nav-link"><i class="fas fa-question-circle"></i> Manage Questions</a>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-categories" class="nav-link"><i class="fas fa-tags"></i> Manage Categories</a>
        </div>
        <div class="nav-section">
            <h4>Evaluation</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/results" class="nav-link"><i class="fas fa-poll"></i> View Results</a>
            <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="nav-link"><i class="fas fa-robot"></i> AI Evaluations</a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/logout" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <div style="display: flex; align-items: center; gap: 16px;">
                <a href="${pageContext.request.contextPath}/dashboard" class="theme-toggle" title="Back to Main Dashboard" style="text-decoration: none;">
                    <i class="fas fa-arrow-left"></i>
                </a>
                <h1><i class="fas fa-shield-halved"></i> Admin Dashboard</h1>
            </div>
            <div style="display: flex; align-items: center; gap: 12px;">
                <button id="theme-toggle" class="theme-toggle" onclick="toggleTheme()">
                    <i class="fas fa-moon"></i>
                </button>
                <span class="admin-badge"><i class="fas fa-crown"></i> Administrator</span>
                <a href="${pageContext.request.contextPath}/hackerrank/logout" class="btn-logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>

        <!-- Stats Row 1 -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon orange"><i class="fas fa-users"></i></div>
                <div class="stat-value">${totalUsers}</div>
                <div class="stat-label">Total Users</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fas fa-user-graduate"></i></div>
                <div class="stat-value">${totalStudents}</div>
                <div class="stat-label">Students</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-chalkboard-teacher"></i></div>
                <div class="stat-value">${totalInterviewers}</div>
                <div class="stat-label">Interviewers</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon purple"><i class="fas fa-code"></i></div>
                <div class="stat-value">${totalCodingQuestions}</div>
                <div class="stat-label">Coding Questions</div>
            </div>
        </div>

        <!-- Stats Row 2 -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon cyan"><i class="fas fa-comments"></i></div>
                <div class="stat-value">${totalInterviewQuestions}</div>
                <div class="stat-label">Interview Questions</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon pink"><i class="fas fa-tags"></i></div>
                <div class="stat-value">${totalCategories}</div>
                <div class="stat-label">Categories</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon yellow"><i class="fas fa-video"></i></div>
                <div class="stat-value">${totalInterviews}</div>
                <div class="stat-label">Total Interviews</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-check-double"></i></div>
                <div class="stat-value">${completedInterviews}</div>
                <div class="stat-label">Completed</div>
            </div>
        </div>

        <!-- Stats Row 3 -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon orange"><i class="fas fa-building"></i></div>
                <div class="stat-value">${totalCompanies}</div>
                <div class="stat-label">Companies</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fas fa-briefcase"></i></div>
                <div class="stat-value">${totalJobs}</div>
                <div class="stat-label">Total Jobs</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-file-alt"></i></div>
                <div class="stat-value">${totalApplications}</div>
                <div class="stat-label">Job Applications</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon purple"><i class="fas fa-handshake"></i></div>
                <div class="stat-value">${activeJobs.size()}</div>
                <div class="stat-label">Active Jobs</div>
            </div>
        </div>

        <!-- Recent Users -->
        <div class="content-grid">
            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-user-clock" style="color: var(--accent);"></i> Recent Users</h3>
                    <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-users">Manage All <i class="fas fa-arrow-right"></i></a>
                </div>
                <c:forEach var="u" items="${recentUsers}" end="7">
                    <div class="user-item">
                        <div class="info">
                            <div class="user-avatar ${u.role == 'ADMIN' ? 'admin' : u.role == 'STUDENT' ? 'student' : u.role == 'COMPANY' ? 'company' : 'interviewer'}">
                                ${u.name.substring(0,1)}
                            </div>
                            <span class="user-name">${u.name}</span>
                        </div>
                        <span class="user-role role-${u.role == 'ADMIN' ? 'admin' : u.role == 'STUDENT' ? 'student' : u.role == 'COMPANY' ? 'company' : 'interviewer'}">${u.role}</span>
                    </div>
                </c:forEach>
                <c:if test="${empty recentUsers}">
                    <p style="color: rgba(255,255,255,0.3); text-align: center; padding: 30px;">No recent users</p>
                </c:if>
            </div>
        </div>

        <!-- Job Portal Overview -->
        <div class="content-grid" style="margin-top: 24px;">
            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-briefcase" style="color: #60a5fa;"></i> Companies & Jobs</h3>
                </div>
                <c:forEach var="j" items="${activeJobs}" end="7">
                    <div class="user-item">
                        <div class="info">
                            <div class="user-avatar company">${not empty j.companyName ? j.companyName.substring(0,1) : 'C'}</div>
                            <div>
                                <span class="user-name" style="font-weight: 600;">${j.title}</span>
                                <div style="font-size: 11px; color: rgba(255,255,255,0.5);">${j.companyName} &bull; ${j.location}</div>
                            </div>
                        </div>
                        <span class="user-role role-admin">${j.applicantCount} Applicants</span>
                    </div>
                </c:forEach>
                <c:if test="${empty activeJobs}">
                    <p style="color: rgba(255,255,255,0.3); text-align: center; padding: 30px;">No jobs posted yet</p>
                </c:if>
            </div>

            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-file-alt" style="color: #4ade80;"></i> Recent Job Applications</h3>
                </div>
                <c:forEach var="a" items="${recentApplications}" end="7">
                    <div class="user-item">
                        <div class="info">
                            <div class="user-avatar student">${not empty a.applicantName ? a.applicantName.substring(0,1) : 'S'}</div>
                            <div>
                                <span class="user-name" style="font-weight: 600;">${a.applicantName}</span>
                                <div style="font-size: 11px; color: rgba(255,255,255,0.5);">Applied for: ${a.jobTitle}</div>
                            </div>
                        </div>
                        <span class="user-role role-${a.status == 'APPLIED' ? 'student' : a.status == 'HIRED' ? 'interviewer' : 'admin'}">${a.status}</span>
                    </div>
                </c:forEach>
                <c:if test="${empty recentApplications}">
                    <p style="color: rgba(255,255,255,0.3); text-align: center; padding: 30px;">No applications yet</p>
                </c:if>
            </div>
        </div>
    </div>

    <script>
        // Sidebar Toggle for Mobile
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
</body>

</html>