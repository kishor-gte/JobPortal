<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <meta charset="UTF-8">
    <title>Recruiter Profile | SmartInterview</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/LineIcons.2.0.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/glightbox.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css"> 
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
            --border-color: #e0e6ed;
            --white: #ffffff;
            --success: #19A77B;
            --danger: #ef4444;
            --warning: #f59e0b;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
            --context-path: '${pageContext.request.contextPath}';
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: var(--text-primary);
            margin: 0;
            padding: 0;
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

        /* Header styling */
        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 9999;
        }

        .header .navbar-area {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow-md);
        }

        .header .navbar-nav > .nav-item > a {
            color: var(--text-primary, #1e293b) !important;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .header .navbar-nav > .nav-item > a:hover,
        .header .navbar-nav > .nav-item > a.active {
            color: var(--primary) !important;
        }

        /* Dropdown Visibility & Hover Fixes */
        @media (min-width: 992px) {
            .header, .header .navbar-area, .header .navbar, .header .navbar-collapse, .header .navbar-nav, .header .navbar-nav > .nav-item {
                overflow: visible !important;
            }
        }
        .header .navbar-nav li .sub-menu {
            overflow: visible !important;
            z-index: 9999999 !important;
        }
        .header .navbar-nav li .sub-menu::before {
            height: 15px !important;
            top: -15px !important;
            content: '';
            position: absolute;
            left: 0;
            width: 100%;
            background: transparent;
        }
        .header .navbar-nav .sub-menu li a {
            color: #1e293b !important;
            background-color: transparent !important;
        }
        .header .navbar-nav .sub-menu li a:hover,
        .header .navbar-nav .sub-menu li:hover > a,
        .header .navbar-nav .sub-menu li a:focus,
        .header .navbar-nav .sub-menu li:focus-within > a,
        .header .navbar-nav .sub-menu li a:active,
        .header .navbar-nav .sub-menu li a.active {
            background-color: #19A77B !important;
            color: #ffffff !important;
        }

        .header .button .btn {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .header .button .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        /* Hero Section */
        .call-action {
            position: relative;
            background: var(--gradient-primary) url(var(--context-path) +'/resources/images/hero/company2.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            padding: 120px 20px 80px;
            border-radius: 0 0 30px 30px;
            text-align: center;
            overflow: hidden;
            margin-top: 70px;
            box-shadow: var(--shadow-md);
        }

        .call-action::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(25, 167, 123, 0.8);
            z-index: 1;
        }

        .call-action .container {
            position: relative;
            z-index: 2;
        }

        .call-action h1 {
            color: #fff;
            font-size: 42px;
            font-weight: 800;
        }

        .call-action p {
            color: rgba(255, 255, 255, 0.95);
            font-size: 18px;
        }

        .container-profile {
            padding-top: 20px;
            padding-bottom: 60px;
            display: flex;
            justify-content: center;
            position: relative;
            z-index: 5;
        }

        .profile-card {
            width: 750px;
            background-color: var(--white);
            border-radius: 24px;
            box-shadow: var(--shadow-lg);
            padding: 48px 56px;
            text-align: center;
            border: 1px solid rgba(25, 167, 123, 0.1);
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .profile-header {
            text-align: center;
            margin-bottom: 32px;
        }

        .profile-avatar {
            width: 80px;
            height: 80px;
            background: var(--gradient-primary);
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: var(--glow-primary);
        }

        .profile-avatar i {
            font-size: 36px;
            color: white;
        }

        .profile-header h2 {
            font-size: 30px;
            font-weight: 700;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
        }

        .profile-header p {
            font-size: 16px;
            color: var(--text-secondary);
        }

        .info-grid {
            display: grid;
            gap: 20px;
            margin: 32px 0;
            padding: 28px;
            background: rgba(25, 167, 123, 0.03);
            border-radius: 16px;
            border: 1px solid rgba(25, 167, 123, 0.1);
        }

        .info-block {
            display: flex;
            align-items: center;
            gap: 16px;
            padding: 16px 20px;
            background: var(--white);
            border-radius: 12px;
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .info-block:hover {
            border-color: var(--primary);
            box-shadow: var(--shadow-sm);
            transform: translateY(-2px);
        }

        .info-icon {
            width: 44px;
            height: 44px;
            background: rgba(25, 167, 123, 0.1);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }

        .info-icon i {
            font-size: 20px;
            color: var(--primary);
        }

        .info-content {
            text-align: left;
            flex: 1;
        }

        .info-label {
            font-weight: 600;
            color: var(--text-primary);
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 4px;
        }

        .info-value {
            font-size: 16px;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .btn-group-custom {
            margin-top: 36px;
            display: flex;
            gap: 16px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn-custom {
            padding: 14px 32px;
            border-radius: 30px;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-edit {
            background: var(--gradient-primary);
            color: #fff;
            border: none;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-edit:hover {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .btn-danger {
            background: transparent;
            color: var(--danger);
            border: 2px solid rgba(239, 68, 68, 0.3);
        }

        .btn-danger:hover {
            background: var(--danger);
            color: #fff;
            border-color: var(--danger);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(239, 68, 68, 0.4);
        }

        .btn-secondary {
            background: transparent;
            color: var(--text-secondary);
            border: 2px solid var(--border-color);
        }

        .btn-secondary:hover {
            background: rgba(25, 167, 123, 0.08);
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .alert-success {
            background: rgba(25, 167, 123, 0.1);
            color: var(--success);
            border: 1px solid rgba(25, 167, 123, 0.3);
            padding: 14px 18px;
            border-radius: 14px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-weight: 500;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .call-action {
                padding: 100px 20px 60px;
            }

            .call-action h1 {
                font-size: 32px;
            }

            .profile-card {
                width: 100%;
                padding: 32px 24px;
                border-radius: 20px;
            }

            .profile-header h2 {
                font-size: 26px;
            }

            .info-grid {
                padding: 20px;
            }

            .btn-group-custom {
                flex-direction: column;
            }

            .btn-custom {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .call-action h1 {
                font-size: 28px;
            }

            .info-block {
                flex-direction: column;
                text-align: center;
            }

            .info-content {
                text-align: center;
            }
        }
    </style>
</head>
<body>

<!-- Start Header Area -->
<header class="header">
    <div class="navbar-area">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-12">
                    <nav class="navbar navbar-expand-lg">
                        <a class="navbar-brand logo" href="${pageContext.request.contextPath}/index">
                            <img class="logo1" src="${pageContext.request.contextPath}/assets/images/logo/logo.png" alt="Logo" />
                        </a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse"
                            data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                            <span class="toggler-icon"></span>
                            <span class="toggler-icon"></span>
                            <span class="toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
                            <ul id="nav" class="navbar-nav ml-auto">
                                <li class="nav-item">
                                    <a href="${pageContext.request.contextPath}/recruiter/dashboard">Home</a>
                                </li>
                                <li class="nav-item"><a href="#">Resources</a>
                                    <ul class="sub-menu">
                                        <li><a href="${pageContext.request.contextPath}/about-us.html">About Us</a></li>
                                        <li><a href="${pageContext.request.contextPath}/services.html">Services</a></li>
                                        <li><a href="${pageContext.request.contextPath}/contact.html">Contact</a></li>
                                        <li><a href="${pageContext.request.contextPath}/faq.html">FAQ</a></li>
                                        <li><a href="${pageContext.request.contextPath}/policy.html">Policies</a></li>
                                        <li class="nav-item"><a href="${pageContext.request.contextPath}/terms-conditions.html">Terms & Conditions</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item"><a href="#">Manage Jobs</a>
                                    <ul class="sub-menu">
                                        <li class="nav-item"><a href="${pageContext.request.contextPath}/jobs/post/${recruiter.company.id}">Post New Job</a></li>
                                        <li class="nav-item"><a href="${pageContext.request.contextPath}/recruiter/posted-jobs">Posted Jobs</a></li>
                                        <li class="nav-item"><a href="${pageContext.request.contextPath}/jobs/post-internship/${recruiter.company.id}">Post New Internship</a></li>
                                        <li class="nav-item"><a href="${pageContext.request.contextPath}/recruiter/posted-jobs">Posted Internships</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item"><a href="#">Manage Candidates</a>
                                    <ul class="sub-menu">
                                        <li class="nav-item"><a href="${pageContext.request.contextPath}/recruiter/applicants">Applicants</a></li>
                                        <li class="nav-item"><a href="${pageContext.request.contextPath}/recruiter/competition-results">Competition Results</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a href="#">Corporate Events</a>
                                    <ul class="sub-menu">
                                        <li><a href="${pageContext.request.contextPath}/recruiter/explore">Explore Corporate Events</a></li>
                                        <li><a href="${pageContext.request.contextPath}/recruiter/bookings">My Bookings</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item"><a class="active" href="${pageContext.request.contextPath}/recruiter/profile">My Profile</a></li>
                            </ul>
                        </div>

                        <div class="button">
                            <a href="${pageContext.request.contextPath}/recruiter/logout" class="btn">
                                <i class="lni lni-exit"></i> Logout
                            </a>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</header>
<!-- End Header Area -->

<!-- Hero Section -->
<section class="call-action overlay section">
    <div class="container">
        <h1>Welcome, ${recruiter.name}!</h1>
        <p>Check your profile information below to keep things fresh and up to date.</p>
    </div>
</section>

<!-- Profile Section -->
<div class="container container-profile">
    <div class="profile-card">
        <div class="profile-header">
            <div class="profile-avatar">
                <i class="fas fa-user-tie"></i>
            </div>
            <h2>Your Profile</h2>
            <p>Review and manage your personal details</p>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <!-- Information Grid -->
        <div class="info-grid">
            <div class="info-block">
                <div class="info-icon">
                    <i class="fas fa-user"></i>
                </div>
                <div class="info-content">
                    <div class="info-label">Full Name</div>
                    <div class="info-value">${recruiter.name}</div>
                </div>
            </div>

            <div class="info-block">
                <div class="info-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="info-content">
                    <div class="info-label">Email Address</div>
                    <div class="info-value">${recruiter.email}</div>
                </div>
            </div>

            <div class="info-block">
                <div class="info-icon">
                    <i class="fas fa-building"></i>
                </div>
                <div class="info-content">
                    <div class="info-label">Company</div>
                    <div class="info-value">${recruiter.company.name}</div>
                </div>
            </div>
        </div>

        <!-- Buttons -->
        <div class="btn-group-custom">
            <a href="${pageContext.request.contextPath}/recruiter/profile/edit" class="btn btn-custom btn-edit">
                <i class="fas fa-edit"></i> Edit Profile
            </a>

            <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="btn btn-custom btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<script>
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
