<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Assessment Result | JobU - Skill Mastery Report</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
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
            --success: #19A77B;
            --success-dark: #148F69;
            --danger: #ef4444;
            --danger-dark: #dc2626;
            --warning: #f59e0b;
            --info: #3b82f6;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
            --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 20px;
            --radius-lg: 32px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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

        /* floating decorative shapes */
        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        .result-container {
            max-width: 900px;
            margin: 3rem auto;
            padding: 1.5rem;
            position: relative;
            z-index: 2;
        }

        /* Premium Card */
        .result-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.1);
            padding: 3rem 2.5rem;
            text-align: center;
            transition: var(--transition);
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .result-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Card Accent Border */
        .result-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--accent), var(--primary));
            border-radius: var(--radius-lg) var(--radius-lg) 0 0;
        }

        .result-header {
            margin-bottom: 2rem;
        }

        .result-header h1 {
            font-size: 2.2rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.75rem;
            letter-spacing: -0.5px;
        }

        .skill-name {
            font-size: 1rem;
            font-weight: 700;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 2px;
            background: rgba(25,167,123,0.1);
            display: inline-block;
            padding: 0.4rem 1.2rem;
            border-radius: 40px;
        }

        /* Score Circle Premium */
        .score-circle {
            width: 200px;
            height: 200px;
            margin: 2rem auto;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            animation: glowPulse 2s ease-in-out infinite;
        }

        @keyframes glowPulse {
            0%, 100% { box-shadow: 0 0 0 0 rgba(25,167,123,0.3); }
            50% { box-shadow: 0 0 0 15px rgba(25,167,123,0); }
        }

        .score-circle.excellent {
            background: linear-gradient(135deg, #19A77B, #148F69);
            box-shadow: 0 15px 35px rgba(25, 167, 123, 0.3);
        }
        .score-circle.good {
            background: linear-gradient(135deg, #3b82f6, #2563eb);
            box-shadow: 0 15px 35px rgba(59, 130, 246, 0.3);
        }
        .score-circle.average {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            box-shadow: 0 15px 35px rgba(245, 158, 11, 0.3);
        }
        .score-circle.poor {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            box-shadow: 0 15px 35px rgba(239, 68, 68, 0.3);
        }

        .score-percentage {
            font-size: 3rem;
            font-weight: 800;
            line-height: 1;
            color: white;
        }

        .score-label {
            font-size: 0.8rem;
            opacity: 0.9;
            color: white;
            margin-top: 0.25rem;
        }

        /* Result Message Premium */
        .result-message {
            font-size: 1.1rem;
            font-weight: 700;
            margin: 1.5rem 0;
            padding: 1rem 1.5rem;
            border-radius: 60px;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .result-message.excellent {
            background: rgba(25, 167, 123, 0.12);
            color: #19A77B;
            border: 1px solid rgba(25, 167, 123, 0.3);
        }
        .result-message.good {
            background: rgba(59, 130, 246, 0.12);
            color: #3b82f6;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }
        .result-message.average {
            background: rgba(245, 158, 11, 0.12);
            color: #f59e0b;
            border: 1px solid rgba(245, 158, 11, 0.3);
        }
        .result-message.poor {
            background: rgba(239, 68, 68, 0.12);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        /* Stats Grid Premium */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1.5rem;
            margin: 2rem 0;
        }

        .stat-card {
            background: rgba(25,167,123,0.04);
            padding: 1.5rem 1rem;
            border-radius: var(--radius-md);
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.08);
        }

        .stat-card:hover {
            transform: translateY(-5px);
            background: rgba(25,167,123,0.08);
            border-color: rgba(25,167,123,0.2);
        }

        .stat-icon {
            font-size: 2rem;
            margin-bottom: 0.75rem;
        }

        .stat-card.total .stat-icon { color: var(--primary); }
        .stat-card.correct .stat-icon { color: var(--success); }
        .stat-card.wrong .stat-icon { color: var(--danger); }

        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            color: var(--text-dark);
            margin: 0.5rem 0;
        }

        .stat-label {
            font-size: 0.75rem;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Timestamp */
        .timestamp {
            margin: 1.5rem 0;
            font-size: 0.85rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .timestamp i {
            color: var(--primary);
        }

        /* Button Premium */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            text-decoration: none;
            padding: 0.9rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            transition: var(--transition);
            margin-top: 1rem;
            border: none;
            cursor: pointer;
            box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
        }

        .btn-back:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
            color: white;
        }

        .btn-back i {
            transition: transform 0.2s;
        }

        .btn-back:hover i {
            transform: translateX(-4px);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .result-container { margin: 1rem auto; padding: 0.5rem; }
            .result-card { padding: 2rem 1.5rem; }
            .result-header h1 { font-size: 1.6rem; }
            .score-circle { width: 160px; height: 160px; }
            .score-percentage { font-size: 2.5rem; }
            .stats-grid { gap: 1rem; }
            .stat-value { font-size: 1.5rem; }
            .stat-icon { font-size: 1.5rem; }
            .result-message { font-size: 0.9rem; }
        }

        @media (max-width: 480px) {
            .stats-grid { grid-template-columns: 1fr; gap: 0.75rem; }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection { background: var(--primary); color: white; }
    </style>
</head>
<body>

<!-- decorative floating elements -->
<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<div class="result-container">
    <div class="result-card">
        <div class="result-header">
            <h1><i class="fas fa-clipboard-check" style="color: var(--accent); margin-right: 0.5rem;"></i> Assessment Complete!</h1>
            <div class="skill-name">
                <i class="fas fa-code"></i> ${result.skill} Assessment
            </div>
        </div>

        <!-- Score Circle -->
        <c:choose>
            <c:when test="${percentage >= 80}">
                <div class="score-circle excellent">
                    <div class="score-percentage"><fmt:formatNumber value="${percentage}" type="number" maxFractionDigits="1"/>%</div>
                    <div class="score-label">Mastery Level</div>
                </div>
            </c:when>
            <c:when test="${percentage >= 60}">
                <div class="score-circle good">
                    <div class="score-percentage"><fmt:formatNumber value="${percentage}" type="number" maxFractionDigits="1"/>%</div>
                    <div class="score-label">Proficiency Level</div>
                </div>
            </c:when>
            <c:when test="${percentage >= 40}">
                <div class="score-circle average">
                    <div class="score-percentage"><fmt:formatNumber value="${percentage}" type="number" maxFractionDigits="1"/>%</div>
                    <div class="score-label">Intermediate Level</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="score-circle poor">
                    <div class="score-percentage"><fmt:formatNumber value="${percentage}" type="number" maxFractionDigits="1"/>%</div>
                    <div class="score-label">Learning Level</div>
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Result Message -->
        <c:choose>
            <c:when test="${percentage >= 80}">
                <div class="result-message excellent">
                    <i class="fas fa-trophy"></i> Outstanding Performance! You've mastered this skill!
                </div>
            </c:when>
            <c:when test="${percentage >= 60}">
                <div class="result-message good">
                    <i class="fas fa-thumbs-up"></i> Great Work! You have a good understanding of this skill!
                </div>
            </c:when>
            <c:when test="${percentage >= 40}">
                <div class="result-message average">
                    <i class="fas fa-book-reader"></i> Good Effort! Keep practicing to improve your skills!
                </div>
            </c:when>
            <c:otherwise>
                <div class="result-message poor">
                    <i class="fas fa-redo"></i> Don't Give Up! Review the material and try again!
                </div>
            </c:otherwise>
        </c:choose>

        <!-- Statistics Grid -->
        <div class="stats-grid">
            <div class="stat-card total">
                <div class="stat-icon"><i class="fas fa-list-ol"></i></div>
                <div class="stat-value">${totalQuestions}</div>
                <div class="stat-label">Total Questions</div>
            </div>
            <div class="stat-card correct">
                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                <div class="stat-value">${correct}</div>
                <div class="stat-label">Correct Answers</div>
            </div>
            <div class="stat-card wrong">
                <div class="stat-icon"><i class="fas fa-times-circle"></i></div>
                <div class="stat-value">${wrong}</div>
                <div class="stat-label">Incorrect Answers</div>
            </div>
        </div>

        <!-- Timestamp -->
        <div class="timestamp">
            <i class="fas fa-calendar-check"></i> 
            Submitted on: 
            <c:set var="formatter" value="<%= DateTimeFormatter.ofPattern(\"dd MMM yyyy, hh:mm a\") %>" />
            ${result.submittedAt.format(formatter)}
        </div>

        <!-- Back Button -->
        <a href="${pageContext.request.contextPath}/assessment/my-invites" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Assessments
        </a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Preserved original mobile responsive script
document.addEventListener('DOMContentLoaded', function() {
    if (!document.getElementById('mobile-responsive-style')) {
        const style = document.createElement('style');
        style.id = 'mobile-responsive-style';
        style.innerHTML = `
            @media (max-width: 768px) {
                .sidebar, .nav-sidebar {
                    transform: translateX(-100%);
                    transition: transform 0.3s ease;
                    position: fixed !important;
                    z-index: 1001 !important;
                    height: 100vh;
                }
                .sidebar.active, .nav-sidebar.active {
                    transform: translateX(0);
                    box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important;
                }
                .main-content {
                    margin-left: 0 !important;
                    padding: 16px !important;
                    width: 100% !important;
                    max-width: 100% !important;
                }
                .stats-grid, .content-grid, .grid, .hr-stats-grid, .hr-content-grid, .profile-grid, .dashboard-grid {
                    grid-template-columns: 1fr !important;
                    display: grid !important; 
                }
                .top-bar {
                    flex-direction: column !important;
                    align-items: flex-start !important;
                    gap: 16px;
                }
                .chat-header {
                    flex-wrap: wrap;
                    gap: 12px;
                }
                .top-bar h1, .chat-header h3 {
                    font-size: 22px !important;
                    display: flex;
                    align-items: center;
                }
                .mobile-menu-btn {
                    display: inline-block !important;
                    background: none;
                    border: none;
                    font-size: 24px;
                    color: inherit;
                    cursor: pointer;
                    margin-right: 12px;
                }
                .mobile-overlay {
                    display: none;
                    position: fixed;
                    top: 0; left: 0; right: 0; bottom: 0;
                    background: rgba(0,0,0,0.5);
                    z-index: 1000;
                }
                .mobile-overlay.active {
                    display: block;
                }
                .chat-sidebar {
                    position: fixed !important;
                    transform: translateX(-100%);
                    transition: transform 0.3s;
                    z-index: 1000;
                }
                .chat-sidebar.active {
                    transform: translateX(0);
                }
                table:not(.table-responsive), table:not(.table-responsive) thead, table:not(.table-responsive) tbody, table:not(.table-responsive) th, table:not(.table-responsive) td, table:not(.table-responsive) tr { 
                    display: block; 
                }
                table:not(.table-responsive) thead tr { 
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
                }
                table:not(.table-responsive) tr { border: 1px solid #e2e8f0; margin-bottom: 12px; border-radius: 8px; overflow:hidden; }
                table:not(.table-responsive) td { 
                    border: none;
                    border-bottom: 1px solid #f1f5f9; 
                    position: relative;
                    padding-left: 50% !important; 
                    text-align: right;
                    font-size: 14px;
                }
                table:not(.table-responsive) td:last-child {
                    border-bottom: none;
                }
                table:not(.table-responsive) td:before { 
                    position: absolute;
                    top: 50%;
                    transform: translateY(-50%);
                    left: 12px;
                    width: 45%; 
                    padding-right: 10px; 
                    white-space: nowrap;
                    content: attr(data-label);
                    font-weight: 600;
                    text-align: left;
                    color: #64748b;
                }
            }
            .mobile-menu-btn { display: none; }
        `;
        document.head.appendChild(style);
    }
    
    const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
    if (sidebar) {
        const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
        let heading = null;
        if (topBar && topBar !== document.body) {
            heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
            if (!heading) heading = topBar;
        } else if (!document.querySelector('.mobile-menu-btn')) {
            heading = document.createElement('div');
            heading.style.padding = '10px';
            document.body.insertBefore(heading, document.body.firstChild);
        }
        if (heading && !document.querySelector('.mobile-menu-btn')) {
            heading.style.display = 'flex';
            heading.style.alignItems = 'center';
            const toggleBtn = document.createElement('button');
            toggleBtn.className = 'mobile-menu-btn';
            toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
            heading.insertBefore(toggleBtn, heading.firstChild);
            const overlay = document.createElement('div');
            overlay.className = 'mobile-overlay';
            document.body.appendChild(overlay);
            let touchstartX = 0, touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { 
                touchendX = e.changedTouches[0].screenX; 
                if (touchendX < touchstartX - 50) closeSidebar(); 
                if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); 
            }, {passive: true});
            function openSidebar() { sidebar.classList.add('active'); overlay.classList.add('active'); document.body.style.overflow = 'hidden'; }
            function closeSidebar() { sidebar.classList.remove('active'); overlay.classList.remove('active'); document.body.style.overflow = ''; }
            toggleBtn.addEventListener('click', openSidebar);
            overlay.addEventListener('click', closeSidebar);
        }
    }
    
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        rows.forEach(row => {
            Array.from(row.querySelectorAll('td')).forEach((td, index) => {
                if(headers[index]) td.setAttribute('data-label', headers[index]);
            });
        });
    });
});
</script>
</body>
</html>