<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Job Assessment Results | JobU - Candidate Performance Analytics</title>
    
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
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
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

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem 1.5rem;
            position: relative;
            z-index: 2;
        }

        /* Premium Header */
        .premium-header {
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2rem 2rem;
            border-radius: var(--radius-lg);
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .premium-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(59,196,154,0.15), transparent);
            border-radius: 50%;
            animation: floatGlow 15s ease-in-out infinite;
        }

        @keyframes floatGlow {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(-30px, 20px) scale(1.1); }
        }

        .premium-header h2 {
            font-size: 1.8rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin: 0;
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .premium-header h2 i {
            color: var(--accent);
            font-size: 2rem;
        }

        .premium-header p {
            opacity: 0.85;
            margin-top: 0.5rem;
            position: relative;
            z-index: 1;
        }

        /* Stats Summary */
        .stats-summary {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            margin-bottom: 2rem;
            padding: 1rem 1.5rem;
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25,167,123,0.1);
        }

        .stat-badge {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 600;
        }

        .stat-badge i {
            color: var(--primary);
            font-size: 1.2rem;
        }

        .stat-badge .count {
            font-size: 1.5rem;
            font-weight: 800;
            color: var(--primary);
        }

        /* Results Grid */
        .results-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
        }

        /* Premium Result Card */
        .result-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-md), 0 0 0 1px rgba(25,167,123,0.08);
            transition: var(--transition);
            overflow: hidden;
            animation: cardFadeIn 0.5s ease-out both;
            position: relative;
        }

        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .result-card:nth-child(1) { animation-delay: 0.05s; }
        .result-card:nth-child(2) { animation-delay: 0.1s; }
        .result-card:nth-child(3) { animation-delay: 0.15s; }
        .result-card:nth-child(4) { animation-delay: 0.2s; }
        .result-card:nth-child(5) { animation-delay: 0.25s; }
        .result-card:nth-child(6) { animation-delay: 0.3s; }

        .result-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Card accent border based on score */
        .result-card::before {
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

        .result-card:hover::before {
            transform: scaleX(1);
        }

        .result-card.high-score::before {
            background: linear-gradient(90deg, #10b981, #34d399);
        }
        .result-card.medium-score::before {
            background: linear-gradient(90deg, #f59e0b, #fbbf24);
        }
        .result-card.low-score::before {
            background: linear-gradient(90deg, #ef4444, #f87171);
        }

        .card-content {
            padding: 1.5rem;
        }

        /* User Header */
        .user-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.25rem;
        }

        .user-avatar {
            width: 56px;
            height: 56px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
        }

        .user-info {
            flex: 1;
        }

        .user-id {
            font-size: 0.75rem;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }

        .user-id span {
            color: var(--primary);
            font-weight: 800;
        }

        /* Skill Badge */
        .skill-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(25,167,123,0.1);
            padding: 0.3rem 0.8rem;
            border-radius: 40px;
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 1rem;
        }

        /* Score Circle */
        .score-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .score-circle {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            background: linear-gradient(135deg, rgba(25,167,123,0.1), rgba(59,196,154,0.05));
            border: 2px solid var(--primary);
        }

        .score-number {
            font-size: 1.6rem;
            font-weight: 800;
            color: var(--primary);
            line-height: 1;
        }

        .score-total {
            font-size: 0.7rem;
            color: var(--text-muted);
        }

        .score-percent {
            font-size: 1rem;
            font-weight: 700;
            padding: 0.25rem 0.75rem;
            border-radius: 40px;
        }

        .percent-high {
            background: rgba(16, 185, 129, 0.12);
            color: #10b981;
        }
        .percent-medium {
            background: rgba(245, 158, 11, 0.12);
            color: #f59e0b;
        }
        .percent-low {
            background: rgba(239, 68, 68, 0.12);
            color: #ef4444;
        }

        /* Progress Bar */
        .progress-section {
            margin: 1rem 0;
        }

        .progress-label {
            display: flex;
            justify-content: space-between;
            font-size: 0.7rem;
            color: var(--text-muted);
            margin-bottom: 0.25rem;
        }

        .progress-bar-container {
            background: #e2ede7;
            border-radius: 10px;
            height: 8px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            border-radius: 10px;
            transition: width 0.6s ease;
        }

        .progress-fill.high {
            background: linear-gradient(90deg, #10b981, #34d399);
        }
        .progress-fill.medium {
            background: linear-gradient(90deg, #f59e0b, #fbbf24);
        }
        .progress-fill.low {
            background: linear-gradient(90deg, #ef4444, #f87171);
        }

        /* Timestamp */
        .timestamp {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.7rem;
            color: var(--text-muted);
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid rgba(25,167,123,0.1);
        }

        .timestamp i {
            color: var(--primary);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--card-bg);
            backdrop-filter: blur(8px);
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

        .empty-state h3 {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--bg-dark);
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: var(--text-muted);
        }

        /* Back Button */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            background: var(--bg-dark);
            color: white;
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: var(--transition);
            margin-top: 2rem;
        }

        .btn-back:hover {
            background: var(--bg-dark-light);
            transform: translateY(-2px);
            color: white;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container { padding: 1rem; }
            .premium-header { padding: 1.5rem; }
            .premium-header h2 { font-size: 1.4rem; }
            .results-grid { grid-template-columns: 1fr; }
            .stats-summary { flex-direction: column; text-align: center; }
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

<div class="container">
    <!-- Premium Header -->
    <div class="premium-header">
        <h2>
            <i class="fas fa-chart-line"></i>
            Job Assessment Results
        </h2>
        <p>Track and analyze candidate performance for job-specific assessments</p>
    </div>

    <!-- Stats Summary -->
    <div class="stats-summary">
        <div class="stat-badge">
            <i class="fas fa-file-alt"></i>
            <span>Total Assessments: <span class="count">${fn:length(results)}</span></span>
        </div>
        <div class="stat-badge">
            <i class="fas fa-chart-simple"></i>
            <span>Average Score: <span class="count" id="avgScore">--</span>%</span>
        </div>
    </div>

    <!-- Results Grid -->
    <c:choose>
        <c:when test="${empty results}">
            <div class="empty-state">
                <i class="fas fa-clipboard-list"></i>
                <h3>No Assessment Results</h3>
                <p>No job assessment results are available at the moment.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="results-grid" id="resultsGrid">
                <c:forEach var="result" items="${results}">
                    <c:set var="scorePercent" value="${result.correctAnswers * 100 / result.totalQuestions}" />
                    <c:set var="scoreClass" value="low" />
                    <c:set var="percentClass" value="percent-low" />
                    <c:if test="${scorePercent >= 70}">
                        <c:set var="scoreClass" value="high" />
                        <c:set var="percentClass" value="percent-high" />
                    </c:if>
                    <c:if test="${scorePercent >= 50 && scorePercent < 70}">
                        <c:set var="scoreClass" value="medium" />
                        <c:set var="percentClass" value="percent-medium" />
                    </c:if>
                    
                    <div class="result-card ${scoreClass}-score">
                        <div class="card-content">
                            <div class="user-header">
                                <div class="user-avatar">
                                    <i class="fas fa-user-graduate"></i>
                                </div>
                                <div class="user-info">
                                    <div class="user-id">Candidate ID: <span>${result.jobSeekerId}</span></div>
                                </div>
                            </div>
                            
                            <div class="skill-badge">
                                <i class="fas fa-code"></i>
                                ${result.skill}
                            </div>
                            
                            <div class="score-container">
                                <div class="score-circle">
                                    <div class="score-number">${result.correctAnswers}</div>
                                    <div class="score-total">/${result.totalQuestions}</div>
                                </div>
                                <div class="score-percent ${percentClass}">
                                    <i class="fas fa-percent"></i> ${Math.round(scorePercent)}%
                                </div>
                            </div>
                            
                            <div class="progress-section">
                                <div class="progress-label">
                                    <span>Accuracy</span>
                                    <span>${Math.round(scorePercent)}%</span>
                                </div>
                                <div class="progress-bar-container">
                                    <div class="progress-fill ${scoreClass}" style="width: ${scorePercent}%"></div>
                                </div>
                            </div>
                            
                            <div class="timestamp">
                                <i class="fas fa-calendar-check"></i>
                                <span>Submitted: ${result.submittedAt}</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Back Button -->
    <div class="text-center">
        <a href="${pageContext.request.contextPath}/dashboard" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</div>

<script>
// Calculate and display average score
document.addEventListener('DOMContentLoaded', function() {
    const avgScoreSpan = document.getElementById('avgScore');
    if (avgScoreSpan) {
        const scoreElements = document.querySelectorAll('.score-percent');
        let total = 0;
        let count = 0;
        scoreElements.forEach(el => {
            const percentText = el.innerText.replace('%', '').trim();
            const percent = parseInt(percentText);
            if (!isNaN(percent)) {
                total += percent;
                count++;
            }
        });
        if (count > 0) {
            const avg = Math.round(total / count);
            avgScoreSpan.textContent = avg;
        } else {
            avgScoreSpan.textContent = '0';
        }
    }
    
    // Preserved original mobile responsive script
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