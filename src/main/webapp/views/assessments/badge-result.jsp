<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>${skill} Badge Result | JobU Skill Certification</title>
    
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
            display: flex;
            align-items: center;
            justify-content: center;
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

        /* Premium Result Box */
        .result-box {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            max-width: 650px;
            width: 100%;
            margin: auto;
            padding: 3rem 2.5rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.1);
            text-align: center;
            position: relative;
            z-index: 2;
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        /* Premium Header */
        .result-box::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--primary), var(--accent), var(--primary));
            border-radius: var(--radius-lg) var(--radius-lg) 0 0;
        }

        /* Icon Animation */
        .icon-wrapper {
            width: 90px;
            height: 90px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(25,167,123,0.2); }
            50% { transform: scale(1.05); box-shadow: 0 0 0 15px rgba(25,167,123,0); }
        }

        .icon-wrapper i {
            font-size: 3rem;
            color: var(--primary);
        }

        h2 {
            font-size: 2rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.5rem;
            letter-spacing: -0.5px;
        }

        .skill-name {
            font-size: 1rem;
            color: var(--primary);
            font-weight: 600;
            margin-bottom: 2rem;
            display: inline-block;
            background: rgba(25,167,123,0.1);
            padding: 0.3rem 1rem;
            border-radius: 40px;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin: 2rem 0;
        }

        .stat-card {
            background: rgba(25,167,123,0.04);
            border-radius: var(--radius-md);
            padding: 1.25rem;
            transition: var(--transition);
        }

        .stat-card:hover {
            background: rgba(25,167,123,0.08);
            transform: translateY(-3px);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary);
            line-height: 1;
        }

        .stat-label {
            font-size: 0.7rem;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 0.5rem;
        }

        /* Score Circle */
        .score-circle-container {
            margin: 1.5rem 0;
        }

        .score-circle {
            width: 140px;
            height: 140px;
            margin: 0 auto;
            position: relative;
        }

        .score-circle svg {
            width: 100%;
            height: 100%;
            transform: rotate(-90deg);
        }

        .score-circle circle {
            fill: none;
            stroke-width: 10;
            stroke-linecap: round;
        }

        .score-circle circle.bg {
            stroke: #e2ede7;
        }

        .score-circle circle.progress {
            stroke: var(--primary);
            stroke-dasharray: 377;
            stroke-dashoffset: 377;
            transition: stroke-dashoffset 1.2s ease-out;
        }

        .score-text {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
        }

        .score-number {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary);
            line-height: 1;
        }

        .score-percent {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        /* Badge Premium */
        .badge-container {
            margin: 1.5rem 0;
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1.2rem;
            padding: 0.75rem 2rem;
            border-radius: 60px;
            font-weight: 700;
            animation: badgeGlow 1.5s ease-in-out;
        }

        @keyframes badgeGlow {
            0% { opacity: 0; transform: scale(0.8); }
            50% { transform: scale(1.05); }
            100% { opacity: 1; transform: scale(1); }
        }

        .badge i {
            font-size: 1.3rem;
        }

        .badge.Fail {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
            box-shadow: 0 8px 20px rgba(239, 68, 68, 0.3);
        }

        .badge.Bronze {
            background: linear-gradient(135deg, #cd7f32, #b8702a);
            color: white;
            box-shadow: 0 8px 20px rgba(205, 127, 50, 0.3);
        }

        .badge.Silver {
            background: linear-gradient(135deg, #b0b0b0, #9a9a9a);
            color: white;
            box-shadow: 0 8px 20px rgba(176, 176, 176, 0.3);
        }

        .badge.Gold {
            background: linear-gradient(135deg, #ffc107, #e6a800);
            color: #1e2a2e;
            box-shadow: 0 8px 20px rgba(255, 193, 7, 0.4);
        }

        /* Certificate Note */
        .certificate-note {
            background: rgba(25,167,123,0.05);
            border-radius: var(--radius-sm);
            padding: 1rem;
            margin: 1.5rem 0;
            font-size: 0.85rem;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            border: 1px solid rgba(25,167,123,0.1);
        }

        .certificate-note i {
            color: var(--primary);
            font-size: 1.2rem;
        }

        /* Button */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            text-decoration: none;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            transition: var(--transition);
            margin-top: 1rem;
            border: none;
            cursor: pointer;
            box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
        }

        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
        }

        .btn i {
            transition: transform 0.2s;
        }

        .btn:hover i {
            transform: translateX(4px);
        }

        /* Confetti Canvas */
        #confetti-canvas {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 999;
        }

        /* Responsive */
        @media (max-width: 576px) {
            body { padding: 1rem; }
            .result-box { padding: 2rem 1.5rem; }
            h2 { font-size: 1.5rem; }
            .stats-grid { grid-template-columns: 1fr; }
            .stat-value { font-size: 1.5rem; }
            .badge { font-size: 1rem; padding: 0.5rem 1.2rem; }
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

<canvas id="confetti-canvas"></canvas>

<div class="result-box">
    <div class="icon-wrapper">
        <i class="fas fa-certificate"></i>
    </div>
    
    <h2>Skill Badge Result</h2>
    <div class="skill-name">
        <i class="fas fa-code"></i> ${skill}
    </div>

    <!-- Stats Grid -->
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value">${result.totalQuestions}</div>
            <div class="stat-label">Total Questions</div>
        </div>
        <div class="stat-card">
            <div class="stat-value">${result.correctAnswers}</div>
            <div class="stat-label">Correct Answers</div>
        </div>
    </div>

    <!-- Score Circle -->
    <div class="score-circle-container">
        <div class="score-circle" id="scoreCircle">
            <svg viewBox="0 0 140 140">
                <circle class="bg" cx="70" cy="70" r="60"></circle>
                <circle class="progress" cx="70" cy="70" r="60"></circle>
            </svg>
            <div class="score-text">
                <div class="score-number">${percentage}</div>
                <div class="score-percent">Score %</div>
            </div>
        </div>
    </div>

    <!-- Badge Section -->
    <div class="badge-container">
        <div class="badge ${badge}">
            <i class="fas ${badge == 'Gold' ? 'fa-crown' : badge == 'Silver' ? 'fa-medal' : badge == 'Bronze' ? 'fa-award' : 'fa-times-circle'}"></i>
            ${badge} Badge
        </div>
    </div>

    <!-- Certificate Note -->
    <div class="certificate-note">
        <i class="fas fa-download"></i>
        <span>Certificate will be available in your profile</span>
    </div>

    <!-- Back Button -->
    <a href="${pageContext.request.contextPath}/jobSeekers/dashboard" class="btn">
        Back to Dashboard <i class="fas fa-arrow-right"></i>
    </a>
</div>

<script>
// Animate score circle on load
document.addEventListener('DOMContentLoaded', function() {
    const percentage = ${percentage};
    const circumference = 2 * Math.PI * 60;
    const offset = circumference - (percentage / 100) * circumference;
    
    const progressCircle = document.querySelector('.score-circle circle.progress');
    if (progressCircle) {
        progressCircle.style.strokeDasharray = circumference;
        progressCircle.style.strokeDashoffset = offset;
    }
    
    // Confetti for Gold, Silver, Bronze badges
    const badge = '${badge}';
    if (badge === 'Gold' || badge === 'Silver' || badge === 'Bronze') {
        startConfetti();
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

// Confetti effect for badge achievements
function startConfetti() {
    const canvas = document.getElementById('confetti-canvas');
    const ctx = canvas.getContext('2d');
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
    
    const particles = [];
    const colors = ['#19A77B', '#3BC49A', '#fbbf24', '#f59e0b', '#10b981'];
    
    for (let i = 0; i < 150; i++) {
        particles.push({
            x: Math.random() * canvas.width,
            y: Math.random() * canvas.height - canvas.height,
            size: Math.random() * 8 + 4,
            speedY: Math.random() * 5 + 3,
            speedX: (Math.random() - 0.5) * 3,
            color: colors[Math.floor(Math.random() * colors.length)],
            rotation: Math.random() * 360,
            rotationSpeed: (Math.random() - 0.5) * 10
        });
    }
    
    function animateConfetti() {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
        let active = false;
        
        for (let i = 0; i < particles.length; i++) {
            const p = particles[i];
            p.y += p.speedY;
            p.x += p.speedX;
            p.rotation += p.rotationSpeed;
            
            if (p.y < canvas.height + 50) {
                active = true;
                ctx.save();
                ctx.translate(p.x, p.y);
                ctx.rotate(p.rotation * Math.PI / 180);
                ctx.fillStyle = p.color;
                ctx.fillRect(-p.size/2, -p.size/2, p.size, p.size);
                ctx.restore();
            }
        }
        
        if (active) {
            requestAnimationFrame(animateConfetti);
        } else {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
        }
    }
    
    animateConfetti();
    
    // Stop after 4 seconds
    setTimeout(() => {
        ctx.clearRect(0, 0, canvas.width, canvas.height);
    }, 4000);
}

window.addEventListener('resize', function() {
    const canvas = document.getElementById('confetti-canvas');
    if (canvas) {
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;
    }
});
</script>
</body>
</html>