<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Q&A Forum | JobU - Community Discussions</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
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
        .page-header h1 {
            font-size: 20px !important;
            font-weight: 700 !important;
            margin: 0 !important;
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
            color: var(--primary, #19A77B) !important;
        }
        .page-header h1 i {
            color: var(--primary, #19A77B) !important;
        }
        .page-header p {
            display: none !important;
        }
        .page-header::before {
            display: none !important;
        }

        /* Ask Button */
        .ask-toggle {
            text-align: center;
            margin-bottom: 2rem;
        }
        .ask-toggle button {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
            transition: var(--transition);
        }
        .ask-toggle button:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
        }

        /* Ask Form Premium */
        .ask-form {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            margin: 0 auto 2rem;
            max-width: 800px;
            box-shadow: var(--shadow-md);
            display: none;
            border: 1px solid rgba(25,167,123,0.15);
        }
        .ask-form textarea, .ask-form input {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e2ede7;
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
            transition: var(--transition);
            margin-bottom: 1rem;
        }
        .ask-form textarea:focus, .ask-form input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.12);
        }
        .ask-form button {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
        }
        .ask-form button:hover {
            transform: translateY(-2px);
        }

        /* Section Title */
        .section-title {
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--bg-dark);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        .section-title i {
            color: var(--primary);
        }

        /* Question Cards Premium */
        .question-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            margin: 0 auto 1.25rem;
            max-width: 800px;
            box-shadow: var(--shadow-sm), 0 0 0 1px rgba(25,167,123,0.06);
            transition: var(--transition);
            border-left: 3px solid var(--primary);
        }
        .question-card:hover {
            transform: translateX(6px);
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.12);
        }
        .question-card p {
            margin: 0.5rem 0;
            font-size: 0.95rem;
        }
        .question-card i {
            color: var(--primary);
            width: 20px;
        }
        .question-card a {
            text-decoration: none;
            color: var(--primary);
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 0.75rem;
            transition: var(--transition);
        }
        .question-card a:hover {
            color: var(--primary-dark);
            gap: 0.75rem;
        }
        .meta {
            font-size: 0.7rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 1rem;
            flex-wrap: wrap;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .career-sidebar { transform: translateX(-100%); }
            .career-sidebar.show { transform: translateX(0); }
            .main-content-wrapper { margin-left: 0; }
            .sidebar-toggle-btn {
                display: block; position: fixed; top: 15px; left: 15px; z-index: 1001;
                background: var(--primary); color: white; border: none; padding: 10px 15px;
                border-radius: 12px; cursor: pointer;
            }
            .sidebar-overlay {
                display: none; position: fixed; top: 0; left: 0;
                width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;
            }
            .sidebar-overlay.show { display: block; }
        }

        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::selection { background: var(--primary); color: white; }
    </style>

    <script>
        function toggleAskForm() {
            const form = document.getElementById("askForm");
            if (form.style.display === "none" || form.style.display === "") {
                form.style.display = "block";
                form.scrollIntoView({ behavior: "smooth", block: "center" });
            } else {
                form.style.display = "none";
            }
        }

    </script>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>

<jsp:include page="/views/commons/student_sidebar.jsp" />

<div class="main-content-wrapper">
    <div class="page-header">
        <h1><i class="fas fa-comments" style="color: var(--accent);"></i> Q&A Forum</h1>
        <p>Ask questions, share knowledge, and get answers from the community</p>
    </div>

    <div class="ask-toggle">
        <button onclick="toggleAskForm()">
            <i class="fas fa-circle-question"></i> Ask a Question
        </button>
    </div>

    <div class="ask-form" id="askForm">
        <form action="${pageContext.request.contextPath}/qna/ask" method="post">
            <textarea name="content" required placeholder="Type your question here..." rows="4"></textarea>
            <input type="text" name="displayName" placeholder="Your name (optional)">
            <button type="submit"><i class="fas fa-paper-plane"></i> Submit Question</button>
        </form>
    </div>

    <div class="section-title">
        <i class="fas fa-list"></i> Recent Questions
    </div>

    <c:forEach var="q" items="${threads}">
        <div class="question-card">
            <p><i class="fas fa-question-circle"></i> <strong>Q:</strong> ${q.content}</p>
            <div class="meta">
                <span><i class="fas fa-user"></i> ${q.displayName}</span>
                <span><i class="fas fa-clock"></i> ${q.postedAt}</span>
            </div>
            <a href="${pageContext.request.contextPath}/qna/thread/${q.id}">
                <i class="fas fa-eye"></i> View Full Thread
            </a>
        </div>
    </c:forEach>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    if (!document.getElementById('mobile-responsive-style')) {
        const style = document.createElement('style');
        style.id = 'mobile-responsive-style';
        style.innerHTML = `@media (max-width: 768px) { .sidebar, .nav-sidebar { transform: translateX(-100%); transition: transform 0.3s ease; position: fixed !important; z-index: 1001 !important; height: 100vh; } .sidebar.active, .nav-sidebar.active { transform: translateX(0); box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important; } .main-content { margin-left: 0 !important; padding: 16px !important; width: 100% !important; max-width: 100% !important; } } .mobile-menu-btn { display: none; }`;
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