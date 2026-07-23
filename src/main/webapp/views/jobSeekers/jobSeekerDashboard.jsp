<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="in.sp.main.Entities.JobSeeker" %>
<%
    JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
    String userName = (jobSeeker != null) ? jobSeeker.getName() : "User";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Job Seeker Dashboard | SmartInterview</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.85);
            --text-tertiary: rgba(255, 255, 255, 0.5);
            --border-color: rgba(255, 255, 255, 0.08);
            --card-bg: rgba(255, 255, 255, 0.08);
            --hover-bg: rgba(25, 167, 123, 0.15);
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.15);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.2);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.3);
            --glow-primary: 0 0 30px rgba(25, 167, 123, 0.2);
            --success: #19A77B;
            --warning: #f59e0b;
            --danger: #ef4444;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-darker) 100%);
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
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.08) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: backgroundPulse 15s ease-in-out infinite;
        }

        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        header {
            background: rgba(26, 42, 44, 0.95);
            backdrop-filter: blur(20px);
            color: white;
            padding: 16px 24px;
            text-align: center;
            font-size: 24px;
            font-family: 'Playfair Display', serif;
            position: fixed;
            width: 100%;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid var(--border-color);
            box-shadow: var(--shadow-md);
        }

        .logout-btn {
            position: absolute;
            right: 24px;
            top: 14px;
            background: rgba(239, 68, 68, 0.1);
            color: #fca5a5;
            border: 1px solid rgba(239, 68, 68, 0.2);
            padding: 8px 16px;
            border-radius: 30px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            background: var(--danger);
            color: white;
            border-color: var(--danger);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .sidebar {
            position: fixed;
            top: 72px;
            left: 0;
            width: 280px;
            height: calc(100% - 72px);
            background: rgba(26, 42, 44, 0.95);
            backdrop-filter: blur(20px);
            padding-top: 24px;
            border-right: 1px solid var(--border-color);
            box-shadow: var(--shadow-lg);
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

        .sidebar a {
            display: flex;
            align-items: center;
            gap: 14px;
            color: var(--text-secondary);
            padding: 14px 20px;
            text-decoration: none;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .sidebar a i {
            width: 22px;
            text-align: center;
            font-size: 18px;
            transition: transform 0.3s ease;
        }

        .sidebar a::before {
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

        .sidebar a:hover {
            background: var(--hover-bg);
            color: var(--primary);
            transform: translateX(4px);
        }

        .sidebar a:hover i {
            transform: scale(1.1);
        }

        .sidebar a:hover::before {
            transform: translateX(0);
        }

        .sidebar .active {
            background: var(--hover-bg);
            color: var(--primary);
            box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.1);
        }

        .sidebar .active::before {
            transform: translateX(0);
        }

        .content {
            margin-left: 280px;
            padding: 100px 32px 80px 32px;
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

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
        }

        .card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            padding: 32px 24px;
            border-radius: 24px;
            border: 1px solid var(--border-color);
            box-shadow: var(--shadow-md);
            text-align: center;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
        }

        @keyframes cardAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card::before {
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

        .card:hover {
            transform: translateY(-8px);
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }

        .card:hover::before {
            transform: translateX(0);
        }

        .card i {
            font-size: 42px;
            color: var(--primary);
            margin-bottom: 18px;
            transition: transform 0.3s ease;
        }

        .card:hover i {
            transform: scale(1.1);
        }

        .card h4 {
            margin: 12px 0 20px;
            font-size: 20px;
            font-weight: 600;
            color: var(--text-primary);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 10px 24px;
            background: transparent;
            border: 1px solid var(--primary);
            color: var(--primary);
            border-radius: 30px;
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 14px;
            font-weight: 500;
        }

        .btn:hover {
            background: var(--gradient-primary);
            color: white;
            border-color: transparent;
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        footer {
            background: rgba(26, 42, 44, 0.95);
            backdrop-filter: blur(20px);
            color: var(--text-tertiary);
            text-align: center;
            padding: 14px;
            position: fixed;
            width: 100%;
            bottom: 0;
            border-top: 1px solid var(--border-color);
            font-size: 14px;
            z-index: 10;
        }

        /* Welcome Message Styles */
        .welcome-overlay {
            position: fixed;
            top: 90px;
            right: 24px;
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
            font-size: 36px;
            animation: bounce 2s infinite;
            flex-shrink: 0;
        }

        .welcome-text {
            flex: 1;
        }

        .welcome-message h3 {
            font-size: 18px;
            margin: 0 0 6px 0;
            font-weight: 700;
        }

        .welcome-message p {
            font-size: 14px;
            margin: 0;
            opacity: 0.95;
            line-height: 1.4;
        }

        .welcome-message .user-name {
            color: #ffd700;
            font-weight: 700;
        }

        .welcome-message .countdown {
            font-size: 11px;
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

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 1000;
                width: 260px;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .content {
                margin-left: 0 !important;
                padding: 90px 20px 80px 20px !important;
            }

            .dashboard-grid {
                grid-template-columns: 1fr;
            }

            header {
                padding: 14px 20px;
                font-size: 20px;
            }

            .logout-btn {
                right: 16px;
                padding: 6px 12px;
                font-size: 12px;
            }

            .welcome-overlay {
                top: 80px;
                right: 16px;
                max-width: calc(100% - 32px);
            }

            .mobile-menu-btn {
                display: inline-block !important;
                position: absolute;
                left: 20px;
                top: 14px;
                background: none;
                border: none;
                font-size: 24px;
                color: white;
                cursor: pointer;
            }

            .mobile-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.7);
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
</head>
<body>

<!-- Mobile Menu Button -->
<button class="mobile-menu-btn" id="mobileMenuBtn">
    <i class="fas fa-bars"></i>
</button>

<!-- Mobile Overlay -->
<div class="mobile-overlay" id="mobileOverlay"></div>

<!-- Welcome Message -->
<div class="welcome-overlay" id="welcomeOverlay">
    <div class="welcome-message">
        <div class="welcome-message-content">
            <div class="welcome-icon">
                <i class="fas fa-user-circle"></i>
            </div>
            <div class="welcome-text">
                <h3>Welcome Back!</h3>
                <p>Hello <span class="user-name"><%= userName %></span></p>
            </div>
        </div>
        <div class="countdown" id="countdown">Auto-hide in 5s</div>
    </div>
</div>

<header>
    <i class="fas fa-briefcase" style="margin-right: 12px;"></i> Job Seeker Dashboard
    <a href="${pageContext.request.contextPath}/jobSeekers/logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Logout</a>
</header>

<div class="sidebar" id="sidebar">
    <a href="${pageContext.request.contextPath}/jobSeekers/profile/${jobSeeker.id}"><i class="fas fa-user"></i> View Profile</a>   
    <a href="${pageContext.request.contextPath}/jobseeker/videos"><i class="fas fa-video"></i> Upload Video Resume</a>
    <a href="${pageContext.request.contextPath}/jobs/all"><i class="fas fa-briefcase"></i> Browse Jobs</a>
    <a href="${pageContext.request.contextPath}/applications/track"><i class="fas fa-tasks"></i> Track Applications</a>    
    <a href="${pageContext.request.contextPath}/seeker/saved-jobs"><i class="fas fa-bookmark"></i> Saved Jobs</a>
    <a href="${pageContext.request.contextPath}/notifications"><i class="fas fa-bell"></i> Notifications</a>
    <a href="${pageContext.request.contextPath}/company/Alllist"><i class="fas fa-building"></i> Companies</a>
    <a href="${pageContext.request.contextPath}/seeker/reported-jobs"><i class="fas fa-flag"></i> My Reported Jobs</a>
</div>

<div class="content">
    <div class="dashboard-grid">
        <div class="card" style="animation-delay: 0.05s;">
            <i class="fas fa-user-circle"></i>
            <h4>Create / Edit Profile</h4>
            <a href="${pageContext.request.contextPath}/jobSeekers/profile/${jobSeeker.id}" class="btn">
                Go <i class="fas fa-arrow-right"></i>
            </a>
        </div>
        <div class="card" style="animation-delay: 0.1s;">
            <i class="fas fa-building"></i>
            <h4>All Companies</h4>
            <a href="${pageContext.request.contextPath}/company/Alllist" class="btn">
                View <i class="fas fa-arrow-right"></i>
            </a>
        </div>
        <div class="card" style="animation-delay: 0.15s;">
            <i class="fas fa-video"></i>
            <h4>Upload Video Resume</h4>
            <a href="${pageContext.request.contextPath}/jobseeker/videos" class="btn">
                Upload <i class="fas fa-arrow-right"></i>
            </a>
        </div>
        <div class="card" style="animation-delay: 0.2s;">
            <i class="fas fa-briefcase"></i>
            <h4>Browse Jobs</h4>
            <a href="${pageContext.request.contextPath}/jobs/all" class="btn">
                View <i class="fas fa-arrow-right"></i>
            </a>
        </div>
        <div class="card" style="animation-delay: 0.25s;">
            <i class="fas fa-tasks"></i>
            <h4>Track Applications</h4>
            <a href="${pageContext.request.contextPath}/applications/track" class="btn">
                Track <i class="fas fa-arrow-right"></i>
            </a>
        </div>
        <div class="card" style="animation-delay: 0.3s;">
            <i class="fas fa-flag"></i>
            <h4>My Reported Jobs</h4>
            <a href="${pageContext.request.contextPath}/seeker/reported-jobs" class="btn">
                Explore <i class="fas fa-arrow-right"></i>
            </a>
        </div>
    </div>
</div>

<footer>
    &copy; 2025 SmartInterview. All rights reserved.
</footer>

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

    // Mobile Menu Functionality
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const sidebar = document.getElementById('sidebar');
    const overlay = document.getElementById('mobileOverlay');

    if (mobileMenuBtn) {
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

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            sidebar.classList.remove('active');
            overlay.classList.remove('active');
            document.body.style.overflow = '';
        }
    });
});
</script>
</body>
</html>