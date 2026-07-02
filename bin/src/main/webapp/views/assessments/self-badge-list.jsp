<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page import="in.sp.main.Entities.JobSeeker" %>
<%
    JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
    pageContext.setAttribute("jobSeeker", jobSeeker);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Skill Badge Tests | JobU - Certification Center</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    
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
            --bg-light: #eef3f0;
            --card-bg: rgba(255, 255, 255, 0.98);
            --text-dark: #1e2a2e;
            --text-muted: #5b7c6e;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
            --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 16px;
            --radius-lg: 24px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #e0ece6 100%);
            color: var(--text-dark);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* animated background mesh */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 15% 30%, rgba(25,167,123,0.05) 0%, transparent 40%),
                radial-gradient(circle at 85% 70%, rgba(59,196,154,0.04) 0%, transparent 45%),
                radial-gradient(circle at 50% 90%, rgba(25,167,123,0.03) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: meshFloat 18s ease-in-out infinite alternate;
        }

        @keyframes meshFloat {
            0% { opacity: 0.5; transform: scale(1); }
            100% { opacity: 1; transform: scale(1.03); }
        }

        /* floating particles */
        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 20% 40%, rgba(25,167,123,0.06) 1px, transparent 1px);
            background-size: 32px 32px;
            pointer-events: none;
            animation: particleDrift 25s linear infinite;
        }

        @keyframes particleDrift {
            0% { background-position: 0 0; }
            100% { background-position: 65px 65px; }
        }

        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        /* Sidebar Premium */
        .career-sidebar {
            background: linear-gradient(145deg, var(--bg-dark) 0%, #1f2e30 100%);
            width: 280px;
            min-height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1000;
            box-shadow: var(--shadow-lg);
            transition: transform 0.3s ease;
            border-radius: 0 24px 24px 0;
        }

        .sidebar-header {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .sidebar-logo {
            width: 45px;
            height: 45px;
            background-image: url('${pageContext.request.contextPath}/assets/images/logo/logo.png');
            background-repeat: no-repeat;
            background-position: center;
            background-size: contain;
        }

        .sidebar-company-name {
            color: white;
            font-weight: 800;
            font-size: 1.2rem;
            letter-spacing: -0.3px;
        }

        .sidebar-dashboard-btn {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1.5rem;
            margin: 0.5rem 1rem;
            background: rgba(255,255,255,0.1);
            border-radius: 50px;
            text-decoration: none;
            color: white;
            font-weight: 600;
            transition: var(--transition);
        }
        .sidebar-dashboard-btn:hover {
            background: var(--primary);
            transform: translateX(4px);
        }

        .sidebar-nav {
            list-style: none;
            padding: 1rem 0;
            margin: 0;
        }
        .sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1.5rem;
            color: rgba(255,255,255,0.85);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: var(--transition);
            border-left: 3px solid transparent;
        }
        .sidebar-nav a i { width: 20px; }
        .sidebar-nav a:hover, .sidebar-nav a.active {
            background: rgba(25,167,123,0.15);
            border-left-color: var(--primary);
            color: white;
        }
        .sidebar-nav .has-submenu > a::after {
            content: '\f107';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-left: auto;
            transition: transform 0.3s;
        }
        .sidebar-nav .has-submenu > a.open::after { transform: rotate(180deg); }
        .sidebar-nav .submenu {
            list-style: none;
            padding-left: 2.5rem;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }
        .sidebar-nav .submenu.show { max-height: 300px; }
        .sidebar-nav .submenu a { padding: 0.5rem 1rem; font-size: 0.85rem; }

        /* Main Content */
        .main-content-wrapper {
            margin-left: 280px;
            padding: 2rem;
            transition: margin-left 0.3s ease;
        }

        /* Page Header Slim (White Style) */
        .page-header {
            background: #fff !important;
            border-bottom: 1px solid var(--border-color, #e0e6ed) !important;
            padding: 16px 24px !important;
            margin-bottom: 2rem !important;
            position: relative !important;
            z-index: 5 !important;
        }
        .page-header h2 {
            font-size: 20px !important;
            font-weight: 700 !important;
            margin: 0 !important;
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
            color: var(--primary, #19A77B) !important;
        }
        .page-header h2 i {
            color: var(--primary, #19A77B) !important;
        }
        .page-header p {
            display: none !important;
        }
        .page-header::before {
            display: none !important;
        }

        /* Skills Grid */
        .skills-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .skill-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            padding: 2rem 1.5rem;
            text-align: center;
            text-decoration: none;
            transition: var(--transition);
            box-shadow: var(--shadow-md), 0 0 0 1px rgba(25,167,123,0.08);
            position: relative;
            overflow: hidden;
            animation: cardFadeIn 0.5s ease-out both;
        }
        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .skill-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }
        .skill-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }
        .skill-card:hover::before { transform: scaleX(1); }

        .skill-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            transition: var(--transition);
        }
        .skill-card:hover .skill-icon { transform: scale(1.1); }
        .skill-icon i { font-size: 2rem; color: var(--primary); }
        .skill-name { font-size: 1.1rem; font-weight: 700; color: var(--text-dark); }

        /* Results Section */
        .results-section {
            margin-top: 3rem;
        }
        .section-title {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--bg-dark);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .section-title i { color: var(--primary); }

        .result-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: var(--shadow-md), 0 0 0 1px rgba(25,167,123,0.08);
            transition: var(--transition);
            border-left: 4px solid var(--primary);
        }
        .result-card:hover {
            transform: translateX(6px);
            box-shadow: var(--shadow-lg);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
        }
        .empty-state i {
            font-size: 4rem;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 1rem;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .career-sidebar { transform: translateX(-100%); }
            .career-sidebar.show { transform: translateX(0); }
            .main-content-wrapper { margin-left: 0; }
            .sidebar-toggle-btn {
                display: block;
                position: fixed;
                top: 15px;
                left: 15px;
                z-index: 1001;
                background: var(--primary);
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 12px;
                cursor: pointer;
            }
            .sidebar-overlay {
                display: none;
                position: fixed;
                top: 0; left: 0;
                width: 100%; height: 100%;
                background: rgba(0,0,0,0.5);
                z-index: 999;
            }
            .sidebar-overlay.show { display: block; }
        }

        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::selection { background: var(--primary); color: white; }
    </style>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>

<jsp:include page="/views/commons/student_sidebar.jsp" />

<div class="main-content-wrapper">
    <div class="page-header">
        <h2><i class="fas fa-certificate" style="color: var(--accent);"></i> Skill Badge Tests</h2>
        <p>Validate your expertise and earn recognized certifications</p>
    </div>

    <!-- Skills Grid -->
    <div class="skills-grid">
        <c:forEach var="skill" items="${skills}">
            <a href="${pageContext.request.contextPath}/assessment/start-badge-test?skill=${skill}" class="skill-card">
                <div class="skill-icon"><i class="fas fa-code"></i></div>
                <div class="skill-name">${skill}</div>
            </a>
        </c:forEach>
    </div>

    <!-- All Assessment Results Section -->
    <c:if test="${not empty allResults}">
        <div class="results-section">
            <div class="section-title">
                <i class="fas fa-chart-line"></i> Your Assessment Results
            </div>
            <c:forEach var="result" items="${allResults}">
                <div class="result-card">
                    <div style="display: flex; justify-content: space-between; align-items: flex-start; flex-wrap: wrap; gap: 1rem;">
                        <div>
                            <h3 style="font-size: 1.2rem; margin-bottom: 0.5rem;">
                                <i class="fas fa-code" style="color: var(--primary);"></i> ${result.skill}
                                <span style="font-size: 0.8rem; background: rgba(25,167,123,0.1); padding: 2px 8px; border-radius: 12px; margin-left: 10px; vertical-align: middle;">${result.type}</span>
                            </h3>
                            <c:if test="${not empty result.jobId}">
                                <p style="color: var(--text-muted); font-size: 0.8rem;"><i class="fas fa-briefcase"></i> Job ID: ${result.jobId}</p>
                            </c:if>
                            <p style="color: var(--text-muted); font-size: 0.8rem;"><i class="fas fa-clock"></i> Submitted: ${result.submittedAt}</p>
                        </div>
                        <div style="display: flex; gap: 0.75rem; flex-wrap: wrap;">
                            <div style="text-align: center; padding: 0.75rem 1.2rem; background: rgba(25,167,123,0.08); border-radius: 12px;">
                                <div style="font-size: 1.8rem; font-weight: 800; color: var(--primary);">${result.totalQuestions}</div>
                                <div style="font-size: 0.7rem;">Total</div>
                            </div>
                            <div style="text-align: center; padding: 0.75rem 1.2rem; background: rgba(16,185,129,0.1); border-radius: 12px;">
                                <div style="font-size: 1.8rem; font-weight: 800; color: #10b981;">${result.correctAnswers}</div>
                                <div style="font-size: 0.7rem;">Correct</div>
                            </div>
                            <div style="text-align: center; padding: 0.75rem 1.2rem; background: rgba(239,68,68,0.1); border-radius: 12px;">
                                <div style="font-size: 1.8rem; font-weight: 800; color: #ef4444;">${result.wrongAnswers}</div>
                                <div style="font-size: 0.7rem;">Wrong</div>
                            </div>
                            <div style="text-align: center; padding: 0.75rem 1.2rem; background: rgba(25,167,123,0.12); border-radius: 12px;">
                                <div style="font-size: 1.8rem; font-weight: 800; color: var(--primary);">${result.percentageScore}%</div>
                                <div style="font-size: 0.7rem;">Score</div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>
    
    <c:if test="${empty allResults}">
        <div class="empty-state">
            <i class="fas fa-clipboard-list"></i>
            <h3 style="margin-bottom: 0.5rem;">No Assessments Taken Yet</h3>
            <p style="color: var(--text-muted);">Complete assessments to see your results here</p>
        </div>
    </c:if>
</div>

<script>

document.addEventListener('DOMContentLoaded', function() {
    if (!document.getElementById('mobile-responsive-style')) {
        const style = document.createElement('style');
        style.id = 'mobile-responsive-style';
        style.innerHTML = `@media (max-width: 768px) { .sidebar, .nav-sidebar { transform: translateX(-100%); transition: transform 0.3s ease; position: fixed !important; z-index: 1001 !important; height: 100vh; } .sidebar.active, .nav-sidebar.active { transform: translateX(0); box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important; } .main-content { margin-left: 0 !important; padding: 16px !important; width: 100% !important; max-width: 100% !important; } .stats-grid, .content-grid, .grid, .hr-stats-grid, .hr-content-grid, .profile-grid, .dashboard-grid { grid-template-columns: 1fr !important; display: grid !important; } .top-bar { flex-direction: column !important; align-items: flex-start !important; gap: 16px; } .chat-header { flex-wrap: wrap; gap: 12px; } .top-bar h1, .chat-header h3 { font-size: 22px !important; display: flex; align-items: center; } .mobile-menu-btn { display: inline-block !important; background: none; border: none; font-size: 24px; color: inherit; cursor: pointer; margin-right: 12px; } .mobile-overlay { display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); z-index: 1000; } .mobile-overlay.active { display: block; } .chat-sidebar { position: fixed !important; transform: translateX(-100%); transition: transform 0.3s; z-index: 1000; } .chat-sidebar.active { transform: translateX(0); } table:not(.table-responsive), table:not(.table-responsive) thead, table:not(.table-responsive) tbody, table:not(.table-responsive) th, table:not(.table-responsive) td, table:not(.table-responsive) tr { display: block; } table:not(.table-responsive) thead tr { position: absolute; top: -9999px; left: -9999px; } table:not(.table-responsive) tr { border: 1px solid #e2e8f0; margin-bottom: 12px; border-radius: 8px; overflow:hidden; } table:not(.table-responsive) td { border: none; border-bottom: 1px solid #f1f5f9; position: relative; padding-left: 50% !important; text-align: right; font-size: 14px; } table:not(.table-responsive) td:last-child { border-bottom: none; } table:not(.table-responsive) td:before { position: absolute; top: 50%; transform: translateY(-50%); left: 12px; width: 45%; padding-right: 10px; white-space: nowrap; content: attr(data-label); font-weight: 600; text-align: left; color: #64748b; } } .mobile-menu-btn { display: none; }`;
        document.head.appendChild(style);
    }
    const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
    if (sidebar) {
        const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
        let heading = null;
        if (topBar && topBar !== document.body) heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
        if (!heading && !document.querySelector('.mobile-menu-btn')) { heading = document.createElement('div'); heading.style.padding = '10px'; document.body.insertBefore(heading, document.body.firstChild); }
        if (heading && !document.querySelector('.mobile-menu-btn')) {
            heading.style.display = 'flex'; heading.style.alignItems = 'center';
            const toggleBtn = document.createElement('button'); toggleBtn.className = 'mobile-menu-btn'; toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
            heading.insertBefore(toggleBtn, heading.firstChild);
            const overlay = document.createElement('div'); overlay.className = 'mobile-overlay'; document.body.appendChild(overlay);
            let touchstartX = 0, touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { touchendX = e.changedTouches[0].screenX; if (touchendX < touchstartX - 50) closeSidebar(); if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); }, {passive: true});
            function openSidebar() { sidebar.classList.add('active'); overlay.classList.add('active'); document.body.style.overflow = 'hidden'; }
            function closeSidebar() { sidebar.classList.remove('active'); overlay.classList.remove('active'); document.body.style.overflow = ''; }
            toggleBtn.addEventListener('click', openSidebar); overlay.addEventListener('click', closeSidebar);
        }
    }
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        rows.forEach(row => { Array.from(row.querySelectorAll('td')).forEach((td, index) => { if(headers[index]) td.setAttribute('data-label', headers[index]); }); });
    });
});
</script>
</body>
</html>