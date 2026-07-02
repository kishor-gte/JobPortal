<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Take Assessment | ${invite.skill} - JobU Skill Certification</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
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
            padding: 2rem;
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

        .container {
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        /* Premium Header */
        .assessment-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .assessment-header h2 {
            font-size: 2rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.5rem;
            letter-spacing: -0.5px;
        }

        .skill-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(25,167,123,0.1);
            padding: 0.4rem 1rem;
            border-radius: 40px;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--primary);
        }

        /* Premium Form Card */
        .form-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.1);
            padding: 2rem;
            transition: var(--transition);
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .form-card:hover {
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Question Block Premium */
        .question-block {
            background: rgba(25,167,123,0.03);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.08);
            animation: slideIn 0.4s ease-out both;
        }

        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-15px); }
            to { opacity: 1; transform: translateX(0); }
        }

        .question-block:hover {
            background: rgba(25,167,123,0.06);
            border-color: rgba(25,167,123,0.2);
            transform: translateX(4px);
        }

        .question-text {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--primary);
            display: inline-block;
        }

        /* Options */
        .options-container {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .option-label {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.75rem 1rem;
            background: white;
            border-radius: var(--radius-sm);
            border: 2px solid #e2ede7;
            cursor: pointer;
            transition: var(--transition);
            font-size: 0.9rem;
        }

        .option-label:hover {
            border-color: var(--primary);
            background: rgba(25,167,123,0.05);
            transform: translateX(4px);
        }

        input[type="radio"] {
            width: 18px;
            height: 18px;
            accent-color: var(--primary);
            cursor: pointer;
        }

        .option-letter {
            font-weight: 800;
            color: var(--primary);
            background: rgba(25,167,123,0.1);
            width: 28px;
            height: 28px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }

        /* Submit Button */
        .btn-submit {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 1rem 2.5rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1rem;
            transition: var(--transition);
            cursor: pointer;
            display: block;
            margin: 2rem auto 0;
            box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
        }

        .btn-submit i {
            margin-right: 0.5rem;
        }

        /* Progress Indicator */
        .progress-indicator {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .question-counter {
            background: rgba(25,167,123,0.1);
            padding: 0.5rem 1rem;
            border-radius: 40px;
            font-size: 0.85rem;
            font-weight: 600;
            color: var(--primary);
        }

        /* Empty State */
        .empty-state {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            padding: 3rem;
            text-align: center;
            box-shadow: var(--shadow-md);
        }

        .empty-state h3 {
            color: var(--danger);
            margin-bottom: 1rem;
        }

        .empty-state a {
            display: inline-block;
            margin-top: 1rem;
            padding: 0.8rem 1.5rem;
            background: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            transition: var(--transition);
        }

        .empty-state a:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        /* Responsive */
        @media (max-width: 768px) {
            body { padding: 1rem; }
            .form-card { padding: 1.5rem; }
            .assessment-header h2 { font-size: 1.5rem; }
            .question-text { font-size: 0.95rem; }
            .option-label { padding: 0.6rem 0.8rem; font-size: 0.85rem; }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection { background: var(--primary); color: white; }
    </style>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<div class="container">
    <div class="assessment-header">
        <h2><i class="fas fa-clipboard-list" style="color: var(--accent); margin-right: 0.5rem;"></i> Take Assessment</h2>
        <div class="skill-badge">
            <i class="fas fa-code"></i> ${invite.skill}
        </div>
    </div>

    <c:if test="${empty questions}">
        <div class="empty-state">
            <i class="fas fa-exclamation-triangle" style="font-size: 3rem; color: var(--danger); margin-bottom: 1rem; display: block;"></i>
            <h3>No Questions Available</h3>
            <p>There are no questions available for this assessment yet.</p>
            <p><strong>Please contact the company to upload assessment questions.</strong></p>
            <a href="${pageContext.request.contextPath}/assessment/my-invites">
                <i class="fas fa-arrow-left"></i> Back to Assessments
            </a>
        </div>
    </c:if>

    <c:if test="${not empty questions}">
        <div class="form-card">
            <form method="post" action="${pageContext.request.contextPath}/assessment/submit-test" id="assessmentForm">
                <input type="hidden" name="inviteId" value="${invite.id}" />
                
                <div class="progress-indicator">
                    <div class="question-counter">
                        <i class="fas fa-list-ol"></i> Total Questions: ${fn:length(questions)}
                    </div>
                </div>

                <c:forEach var="q" items="${questions}" varStatus="status">
                    <div class="question-block">
                        <div class="question-text">
                            <span style="background: var(--primary); color: white; width: 28px; height: 28px; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; margin-right: 0.75rem; font-size: 0.8rem;">${status.index + 1}</span>
                            ${q.question}
                        </div>
                        <div class="options-container">
                            <label class="option-label">
                                <input type="radio" name="q_${q.id}" value="A" />
                                <span class="option-letter">A</span>
                                <span>${q.optionA}</span>
                            </label>
                            <label class="option-label">
                                <input type="radio" name="q_${q.id}" value="B" />
                                <span class="option-letter">B</span>
                                <span>${q.optionB}</span>
                            </label>
                            <label class="option-label">
                                <input type="radio" name="q_${q.id}" value="C" />
                                <span class="option-letter">C</span>
                                <span>${q.optionC}</span>
                            </label>
                            <label class="option-label">
                                <input type="radio" name="q_${q.id}" value="D" />
                                <span class="option-letter">D</span>
                                <span>${q.optionD}</span>
                            </label>
                        </div>
                    </div>
                </c:forEach>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane"></i> Submit Test
                </button>
            </form>
        </div>
    </c:if>
</div>

<script>
document.getElementById('assessmentForm')?.addEventListener('submit', function(e) {
    const confirmed = confirm('Are you sure you want to submit your answers? You cannot change them after submission.');
    if (!confirmed) e.preventDefault();
});

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