<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Manage Questions | Admin Dashboard - SmartInterview</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
            --success: #19A77B;
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

        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: #fff;
            min-height: 100vh;
        }
        
        .container { display: flex; min-height: 100vh; }
        
        /* ========== ENHANCED SIDEBAR ========== */
        .sidebar {
            width: 280px;
            background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
            border-right: 1px solid rgba(25,167,123,0.15);
            padding: 24px 16px;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: var(--transition);
        }
        
        .sidebar::-webkit-scrollbar { width: 5px; }
        .sidebar::-webkit-scrollbar-track { background: rgba(255,255,255,0.05); border-radius: 10px; }
        .sidebar::-webkit-scrollbar-thumb { background: linear-gradient(135deg, var(--primary), var(--accent)); border-radius: 10px; }
        
        .sidebar-logo { display: flex; align-items: center; gap: 12px; margin-bottom: 32px; padding: 0 8px; }
        .sidebar-logo .icon {
            width: 45px; height: 45px;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            box-shadow: var(--shadow-md);
        }
        .sidebar-logo .icon i { font-size: 20px; color: #fff; }
        .sidebar-logo h2 { font-size: 20px; font-weight: 800; background: linear-gradient(135deg, #fff, var(--accent)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        
        .nav-section { margin-bottom: 28px; }
        .nav-section h4 {
            font-size: 11px; text-transform: uppercase;
            color: rgba(255,255,255,0.35);
            margin-bottom: 12px; padding-left: 12px;
            letter-spacing: 1.5px;
        }
        .nav-link {
            display: flex; align-items: center; gap: 12px;
            padding: 10px 12px; border-radius: 12px;
            color: rgba(255,255,255,0.65);
            text-decoration: none; font-size: 14px; font-weight: 500;
            transition: var(--transition); margin-bottom: 4px;
        }
        .nav-link:hover {
            background: rgba(25,167,123,0.12);
            color: var(--accent);
            transform: translateX(4px);
        }
        .nav-link.active {
            background: linear-gradient(135deg, rgba(25,167,123,0.2), rgba(59,196,154,0.1));
            color: var(--accent);
            border-right: 3px solid var(--accent);
        }
        
        /* Main Content */
        .main-content { flex: 1; margin-left: 280px; padding: 32px; }
        
        /* Top Bar */
        .top-bar {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 32px; flex-wrap: wrap; gap: 16px;
        }
        .top-bar h1 {
            font-size: 28px; font-weight: 800;
            background: linear-gradient(135deg, var(--accent), var(--primary));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            display: flex; align-items: center; gap: 12px;
        }
        
        /* Enhanced Card */
        .card {
            background: rgba(255,255,255,0.03);
            border: 1px solid rgba(25,167,123,0.15);
            border-radius: 24px;
            padding: 28px;
            backdrop-filter: blur(10px);
            transition: var(--transition);
        }
        .card:hover {
            border-color: rgba(25,167,123,0.3);
            box-shadow: var(--shadow-lg);
        }
        
        .card-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 24px; flex-wrap: wrap; gap: 16px;
        }
        .card-header h3 { font-size: 20px; font-weight: 700; display: flex; align-items: center; gap: 8px; }
        .card-header h3 i { color: var(--accent); }
        
        /* Tab Buttons Enhanced */
        .tab-buttons {
            display: flex; gap: 8px; border-bottom: 1px solid rgba(25,167,123,0.2);
            width: 100%; padding-bottom: 8px; flex-wrap: wrap;
        }
        .tab-btn {
            background: none; border: none; color: rgba(255,255,255,0.55);
            font-size: 14px; font-weight: 600; padding: 10px 24px;
            cursor: pointer; border-radius: 40px;
            transition: var(--transition);
        }
        .tab-btn:hover { color: var(--accent); background: rgba(25,167,123,0.08); }
        .tab-btn.active {
            color: var(--accent);
            background: rgba(25,167,123,0.12);
            box-shadow: 0 0 10px rgba(25,167,123,0.2);
        }
        
        .tab-content { display: none; animation: fadeIn 0.3s ease; }
        .tab-content.active { display: block; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
        
        /* Answer Grid */
        .answer-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            margin-top: 20px;
        }
        
        /* Enhanced Answer Card */
        .answer-card {
            padding: 24px;
            background: rgba(255,255,255,0.03);
            border: 1px solid rgba(25,167,123,0.1);
            border-radius: 20px;
            transition: var(--transition);
        }
        .answer-card:hover {
            border-color: rgba(25,167,123,0.3);
            transform: translateX(6px);
            background: rgba(25,167,123,0.03);
        }
        .answer-card h4 {
            color: var(--accent);
            margin-bottom: 10px;
            font-size: 16px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        .answer-card .question-badge {
            font-size: 11px; padding: 3px 10px;
            background: rgba(59,196,154,0.15);
            border-radius: 20px;
            font-weight: 500;
        }
        .answer-card .meta {
            display: flex; gap: 16px; font-size: 12px;
            color: rgba(255,255,255,0.4);
            margin-bottom: 14px;
            flex-wrap: wrap;
        }
        .answer-card .meta i { color: var(--accent); width: 16px; margin-right: 4px; }
        .answer-card p.ans-text {
            color: #e2e8f0; font-size: 14px; line-height: 1.6;
            background: rgba(0,0,0,0.2); padding: 16px;
            border-radius: 14px; border-left: 4px solid var(--accent);
            white-space: pre-wrap;
        }
        
        /* Group Header */
        .group-header {
            margin: 32px 0 20px 0;
            font-size: 18px; font-weight: 700;
            color: var(--accent);
            padding-bottom: 10px;
            border-bottom: 2px solid rgba(25,167,123,0.2);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .group-header i { color: var(--primary); font-size: 20px; }
        .group-header span {
            font-size: 13px;
            background: rgba(25,167,123,0.15);
            padding: 3px 12px;
            border-radius: 20px;
            font-weight: 500;
        }
        
        /* Empty State */
        .empty-state {
            text-align: center; padding: 60px 20px;
            color: rgba(255,255,255,0.5);
        }
        .empty-state i {
            font-size: 56px; margin-bottom: 20px; display: block;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
        }
        .empty-state p { font-size: 15px; }
        
        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                z-index: 1001;
            }
            .sidebar.active { transform: translateX(0); }
            .main-content { margin-left: 0; padding: 20px; }
            .card { padding: 20px; }
            .tab-btn { padding: 8px 16px; font-size: 13px; }
            .answer-card { padding: 16px; }
            .top-bar h1 { font-size: 22px; }
        }
        
        @media (max-width: 480px) {
            .answer-card .meta { gap: 12px; }
            .answer-card h4 { font-size: 14px; }
            .group-header { font-size: 16px; }
        }
        
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: #1e293b; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::selection { background: var(--primary); color: white; }
        
        .mobile-menu-btn {
            display: none;
            background: var(--primary);
            border: none;
            color: white;
            padding: 12px 16px;
            border-radius: 14px;
            font-size: 18px;
            cursor: pointer;
        }
        @media (max-width: 768px) {
            .mobile-menu-btn { display: block; }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Sidebar -->
        <div class="sidebar" id="mainSidebar">
            <div class="sidebar-logo">
                <div class="icon"><i class="fas fa-shield-halved"></i></div>
                <h2>Admin Panel</h2>
            </div>
            <div class="nav-section">
                <h4>Overview</h4>
                <a href="${pageContext.request.contextPath}/hackerrank/admin/dashboard" class="nav-link"><i class="fas fa-th-large"></i> Dashboard</a>
                <a href="${pageContext.request.contextPath}/hackerrank/admin/analytics" class="nav-link"><i class="fas fa-chart-bar"></i> Analytics</a>
            </div>
            <div class="nav-section">
                <h4>Management</h4>
                <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-users" class="nav-link"><i class="fas fa-users-cog"></i> Manage Users</a>
                <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-questions" class="nav-link active"><i class="fas fa-question-circle"></i> Manage Questions</a>
                <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-categories" class="nav-link"><i class="fas fa-tags"></i> Manage Categories</a>
            </div>
            <div class="nav-section">
                <h4>Evaluation</h4>
                <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="nav-link"><i class="fas fa-robot"></i> AI Evaluations</a>
            </div>
            <div class="nav-section">
                <h4>Account</h4>
                <a href="${pageContext.request.contextPath}/hackerrank/logout" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </div>
        </div>
        
        <!-- Main Content -->
        <div class="main-content">
            <div class="top-bar">
                <button class="mobile-menu-btn" onclick="toggleSidebar()"><i class="fas fa-bars"></i></button>
                <h1><i class="fas fa-question-circle"></i>Manage Questions</h1>
            </div>
            
            <div class="card">
                <div class="card-header">
                    <h3><i class="fas fa-clipboard-list"></i> Student Answers</h3>
                    <div class="tab-buttons">
                        <button onclick="switchTab(this, 'tab-all')" class="tab-btn active">Latest Submissions</button>
                        <button onclick="switchTab(this, 'tab-user')" class="tab-btn">Group by User</button>
                        <button onclick="switchTab(this, 'tab-topic')" class="tab-btn">Group by Topic</button>
                    </div>
                </div>
                
                <c:if test="${empty studentAnswers}">
                    <div class="empty-state">
                        <i class="fas fa-comment-slash"></i>
                        <p>No answers submitted by students yet.</p>
                    </div>
                </c:if>

                <c:if test="${not empty studentAnswers}">
                    <!-- ALL SUBMISSIONS TAB -->
                    <div id="tab-all" class="tab-content active">
                        <div class="answer-grid">
                            <c:forEach var="ans" items="${studentAnswers}">
                                <div class="answer-card">
                                    <h4>
                                        <i class="fas fa-question-circle"></i>
                                        ${ans.questionText != null ? ans.questionText : 'Question ID: ' .concat(ans.questionId)}
                                        <span class="question-badge">${ans.questionType}</span>
                                    </h4>
                                    <div class="meta">
                                        <span><i class="fas fa-user-graduate"></i> ${ans.studentName != null ? ans.studentName : 'User #'.concat(ans.studentId)}</span>
                                        <span><i class="fas fa-hourglass-half"></i> ${ans.timeTaken}s</span>
                                        <span><i class="fas fa-calendar-alt"></i> ${ans.submittedAt}</span>
                                    </div>
                                    <p class="ans-text"><i class="fas fa-comment-dots" style="margin-right: 8px; color: var(--accent);"></i> ${ans.answer}</p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                    <!-- BY USER TAB -->
                    <div id="tab-user" class="tab-content">
                        <c:forEach var="entry" items="${answersByUser}">
                            <div class="group-header">
                                <i class="fas fa-user-circle"></i> ${entry.key}
                                <span>${entry.value.size()} submission${entry.value.size() != 1 ? 's' : ''}</span>
                            </div>
                            <div class="answer-grid">
                                <c:forEach var="ans" items="${entry.value}">
                                    <div class="answer-card">
                                        <h4>
                                            <i class="fas fa-question-circle"></i>
                                            ${ans.questionText != null ? ans.questionText : 'Question ID: ' .concat(ans.questionId)}
                                            <span class="question-badge">${ans.questionType}</span>
                                        </h4>
                                        <div class="meta">
                                            <span><i class="fas fa-hourglass-half"></i> ${ans.timeTaken}s</span>
                                            <span><i class="fas fa-calendar-alt"></i> ${ans.submittedAt}</span>
                                        </div>
                                        <p class="ans-text"><i class="fas fa-comment-dots" style="margin-right: 8px; color: var(--accent);"></i> ${ans.answer}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- BY TOPIC TAB -->
                    <div id="tab-topic" class="tab-content">
                        <c:forEach var="entry" items="${answersByTopic}">
                            <div class="group-header">
                                <i class="fas fa-bookmark"></i> ${entry.key}
                                <span>${entry.value.size()} submission${entry.value.size() != 1 ? 's' : ''}</span>
                            </div>
                            <div class="answer-grid">
                                <c:forEach var="ans" items="${entry.value}">
                                    <div class="answer-card">
                                        <h4>
                                            <i class="fas fa-question-circle"></i>
                                            ${ans.questionText != null ? ans.questionText : 'Question ID: ' .concat(ans.questionId)}
                                        </h4>
                                        <div class="meta">
                                            <span><i class="fas fa-user-graduate"></i> ${ans.studentName != null ? ans.studentName : 'User #'.concat(ans.studentId)}</span>
                                            <span><i class="fas fa-hourglass-half"></i> ${ans.timeTaken}s</span>
                                            <span><i class="fas fa-calendar-alt"></i> ${ans.submittedAt}</span>
                                        </div>
                                        <p class="ans-text"><i class="fas fa-comment-dots" style="margin-right: 8px; color: var(--accent);"></i> ${ans.answer}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script>
        function switchTab(btnElement, tabId) {
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
            document.querySelectorAll('.tab-content').forEach(tab => tab.classList.remove('active'));
            btnElement.classList.add('active');
            document.getElementById(tabId).classList.add('active');
        }
        
        function toggleSidebar() {
            document.getElementById('mainSidebar').classList.toggle('active');
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
    </script>
    
    <style>
        /* Mobile Responsive Additions */
        @media (max-width: 768px) {
            .tab-buttons { flex-wrap: wrap; }
            .tab-btn { flex: 1; text-align: center; padding: 8px 12px; }
            .answer-card .meta { font-size: 11px; gap: 10px; }
            .group-header { flex-wrap: wrap; }
        }
    </style>
</body>
</html>