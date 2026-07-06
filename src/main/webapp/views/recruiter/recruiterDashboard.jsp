<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="in.sp.main.Entities.Recruiter" %>
<%
    Recruiter recruiter = (Recruiter) session.getAttribute("recruiter");
    String userName = (recruiter != null) ? recruiter.getName() : "Recruiter";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Recruiter Dashboard |</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">

    <!-- Google Fonts (Inter) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
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

        .container {
            position: relative;
            z-index: 1;
        }

        .dashboard-header {
            background: var(--gradient-primary);
            color: #fff;
            padding: 50px 0 30px;
            text-align: center;
            border-radius: 0 0 30px 30px;
            position: relative;
            box-shadow: var(--shadow-md);
            margin-bottom: 40px;
            overflow: hidden;
        }

        .dashboard-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none"><path d="M0,0 L1000,0 L1000,100 L0,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
            opacity: 0.1;
        }

        .dashboard-header h2 {
            font-weight: 800;
            font-size: 2.5rem;
            position: relative;
            z-index: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .dashboard-header h2 i {
            font-size: 2.2rem;
        }

        .logout-btn {
            position: absolute;
            top: 24px;
            right: 30px;
            z-index: 2;
        }

        .logout-btn .btn {
            background: rgba(255, 255, 255, 0.15);
            border: 2px solid rgba(255, 255, 255, 0.4);
            color: white;
            font-weight: 600;
            padding: 8px 20px;
            border-radius: 30px;
            transition: all 0.3s ease;
        }

        .logout-btn .btn:hover {
            background: white;
            color: var(--primary);
            border-color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Stats Bar */
        .stats-bar {
            display: flex;
            gap: 16px;
            margin-bottom: 32px;
            justify-content: center;
        }

        .stat-pill {
            background: #ffffff;
            border: 1px solid rgba(25, 167, 123, 0.15);
            border-radius: 40px;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: var(--shadow-sm);
        }

        .stat-pill i {
            color: var(--primary);
        }

        .stat-pill span {
            font-size: 14px;
            font-weight: 500;
            color: var(--text-primary);
        }

        .stat-pill .count {
            background: var(--gradient-primary);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            margin-left: 8px;
        }

        .dashboard-card {
            background-color: #ffffff;
            border: 1px solid rgba(25, 167, 123, 0.1);
            border-radius: 20px;
            padding: 36px 24px;
            text-align: center;
            transition: all 0.3s ease-in-out;
            box-shadow: var(--shadow-sm);
            position: relative;
            overflow: hidden;
            height: 100%;
        }

        .dashboard-card::before {
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

        .dashboard-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg), var(--glow-primary);
            border-color: var(--primary);
        }

        .dashboard-card:hover::before {
            transform: translateX(0);
        }

        .dashboard-icon {
            width: 72px;
            height: 72px;
            background: rgba(25, 167, 123, 0.1);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px auto;
            color: var(--primary);
            font-size: 2rem;
            transition: all 0.3s ease;
            border: 1px solid rgba(25, 167, 123, 0.15);
        }

        .dashboard-card:hover .dashboard-icon {
            background: var(--primary);
            color: white;
            transform: scale(1.05);
            box-shadow: var(--glow-primary);
        }

        .dashboard-card h5 {
            font-weight: 700;
            font-size: 1.1rem;
            color: var(--text-primary);
            margin-top: 14px;
            margin-bottom: 8px;
        }

        .dashboard-card p {
            font-size: 13px;
            color: var(--text-secondary);
            margin: 0;
        }

        .text-decoration-none:hover h5 {
            color: var(--primary);
        }

        .row.g-4 {
            margin-bottom: 40px;
        }

        /* Welcome Message Styles */
        .welcome-overlay {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            animation: slideInRight 0.5s ease-out;
        }

        .welcome-message {
            background: var(--gradient-primary);
            color: white;
            padding: 18px 24px;
            border-radius: 18px;
            box-shadow: var(--shadow-lg), var(--glow-primary);
            max-width: 340px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .welcome-message-content {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .welcome-icon {
            font-size: 2rem;
            animation: bounce 2s infinite;
            flex-shrink: 0;
        }

        .welcome-text {
            flex: 1;
        }

        .welcome-message h3 {
            font-size: 1.2em;
            margin: 0 0 6px 0;
            font-weight: 700;
        }

        .welcome-message p {
            font-size: 0.95em;
            margin: 0;
            opacity: 0.95;
            line-height: 1.4;
        }

        .welcome-message .user-name {
            color: #ffd700;
            font-weight: 700;
        }

        .welcome-message .countdown {
            font-size: 0.75em;
            opacity: 0.8;
            margin-top: 10px;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        @keyframes slideInRight {
            from { 
                transform: translateX(100%);
                opacity: 0;
            }
            to { 
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-4px); }
            60% { transform: translateY(-2px); }
        }

        @keyframes fadeOut {
            from { 
                opacity: 1;
                transform: translateX(0);
            }
            to { 
                opacity: 0;
                transform: translateX(100%);
            }
        }

        @media (max-width: 768px) {
            .dashboard-header h2 {
                font-size: 1.8rem;
            }

            .dashboard-header {
                padding: 35px 0 25px;
            }

            .dashboard-card {
                padding: 24px 16px;
            }

            .dashboard-icon {
                width: 60px;
                height: 60px;
                font-size: 1.6rem;
            }

            .logout-btn {
                top: 16px;
                right: 16px;
            }

            .logout-btn .btn {
                padding: 6px 14px;
                font-size: 13px;
            }

            .welcome-overlay {
                top: 10px;
                right: 10px;
                max-width: calc(100% - 20px);
            }

            .stats-bar {
                flex-wrap: wrap;
            }
        }

        @media (max-width: 480px) {
            .dashboard-header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>

<!-- Welcome Message -->
<div class="welcome-overlay" id="welcomeOverlay">
    <div class="welcome-message">
        <div class="welcome-message-content">
            <div class="welcome-icon">
                <i class="fas fa-user-tie"></i>
            </div>
            <div class="welcome-text">
                <h3>Welcome Back!</h3>
                <p>Hello <span class="user-name"><%= userName %></span></p>
            </div>
        </div>
        <div class="countdown" id="countdown"></div>
    </div>
</div>

<div class="dashboard-header">
    <h2><i class="fas fa-tachometer-alt"></i> Recruiter Dashboard</h2>
    <div class="logout-btn">
        <form action="${pageContext.request.contextPath}/recruiter/logout" method="get">
            <button class="btn"><i class="fas fa-sign-out-alt"></i> Logout</button>
        </form>
    </div>
</div>

<div class="container mt-5">
    <!-- Stats Bar -->
    <div class="stats-bar">
        <div class="stat-pill">
            <i class="fas fa-chart-line"></i>
            <span>Recruitment Platform</span>
        </div>
    </div>

    <div class="row g-4">

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/jobs/post/${companyId}" class="text-decoration-none">
                <div class="dashboard-card">
                    <div class="dashboard-icon"><i class="fas fa-plus-circle"></i></div>
                    <h5>Post New Job</h5>
                    <p>Create and publish new job listings</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/jobs/by-company/${companyId}" class="text-decoration-none">
                <div class="dashboard-card">
                    <div class="dashboard-icon"><i class="fas fa-briefcase"></i></div>
                    <h5>Posted Jobs</h5>
                    <p>View and manage your active listings</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/recruiter/explore" class="text-decoration-none">
                <div class="dashboard-card">
                    <div class="dashboard-icon"><i class="fas fa-search-location"></i></div>
                    <h5>Explore Services</h5>
                    <p>Discover corporate sports events</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/recruiter/applicants" class="text-decoration-none">
                <div class="dashboard-card">
                    <div class="dashboard-icon"><i class="fas fa-users"></i></div>
                    <h5>Applicants</h5>
                    <p>Review and manage candidate applications</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/recruiter/profile" class="text-decoration-none">
                <div class="dashboard-card">
                    <div class="dashboard-icon"><i class="fas fa-user-cog"></i></div>
                    <h5>Profile Settings</h5>
                    <p>Update your account information</p>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="${pageContext.request.contextPath}/recruiter/candidate-activities" class="text-decoration-none">
                <div class="dashboard-card">
                    <div class="dashboard-icon"><i class="fas fa-chart-bar"></i></div>
                    <h5>Candidate Activity</h5>
                    <p>Monitor candidate interactions and engagement</p>
                </div>
            </a>
        </div>

    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Welcome message countdown timer
    const welcomeOverlay = document.getElementById('welcomeOverlay');
    const countdown = document.getElementById('countdown');
    
    if (welcomeOverlay && countdown) {
        let seconds = 5;
        
        const timer = setInterval(function() {
            seconds--;
            if (seconds > 0) {
                countdown.textContent = `Auto-hide in ${seconds}s`;
            } else {
                clearInterval(timer);
                welcomeOverlay.style.animation = 'fadeOut 0.5s ease-out';
                setTimeout(function() {
                    welcomeOverlay.style.display = 'none';
                }, 500);
            }
        }, 1000);
    }

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

            let touchstartX = 0;
            let touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { 
                touchendX = e.changedTouches[0].screenX; 
                if (touchendX < touchstartX - 50) closeSidebar(); 
                if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); 
            }, {passive: true});
            
            function openSidebar() {
                sidebar.classList.add('active');
                overlay.classList.add('active');
                document.body.style.overflow = 'hidden';
            }
            
            function closeSidebar() {
                sidebar.classList.remove('active');
                overlay.classList.remove('active');
                document.body.style.overflow = '';
            }
            
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
                if(headers[index]) {
                    td.setAttribute('data-label', headers[index]);
                }
            });
        });
    });
});
</script>
</body>
</html>