<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Recruiter Profile | SmartInterview</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
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
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
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

        /* Navbar Fixed Styles */
        .navbar {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 9999;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow-sm);
            padding: 8px 0;
        }

        .navbar .navbar-nav {
            margin-left: 10px;
        }

        .navbar .nav-item {
            margin-left: 15px;
        }

        .navbar .nav-item a {
            color: var(--text-primary) !important;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .navbar .nav-item a:hover,
        .navbar .nav-item a.active {
            color: var(--primary) !important;
        }

        .navbar .button .btn {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .navbar .button .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        /* Hero Section */
        .call-action {
            position: relative;
            background: var(--gradient-primary) url('/resources/images/hero/company2.jpg') no-repeat center center;
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
            margin-bottom: 16px;
        }

        .call-action p {
            color: rgba(255, 255, 255, 0.95);
            font-size: 18px;
        }

        .call-action p strong {
            font-weight: 600;
        }

        /* Profile Card */
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
            padding: 40px 48px;
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

        .profile-header .icon-wrapper {
            width: 64px;
            height: 64px;
            background: rgba(25, 167, 123, 0.1);
            border-radius: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            border: 1px solid rgba(25, 167, 123, 0.2);
        }

        .profile-header .icon-wrapper i {
            font-size: 32px;
            color: var(--primary);
        }

        .profile-header h2 {
            font-size: 28px;
            font-weight: 700;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 8px;
        }

        .profile-header p {
            font-size: 15px;
            color: var(--text-secondary);
        }

        .form-group label {
            font-weight: 600;
            font-size: 14px;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .form-group label i {
            color: var(--primary);
            margin-right: 8px;
        }

        .form-control {
            border-radius: 12px;
            height: 48px;
            font-size: 15px;
            border: 2px solid var(--border-color);
            padding: 10px 16px;
            transition: all 0.3s ease;
            background: #fafdfc;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
            outline: none;
            background: var(--white);
        }

        .form-control::placeholder {
            color: var(--text-secondary);
            opacity: 0.7;
        }

        .btn-group-custom {
            display: flex;
            flex-wrap: wrap;
            gap: 16px;
            justify-content: center;
            margin-top: 36px;
        }

        .btn-custom, .btn-success, .btn-secondary {
            padding: 12px 28px;
            border-radius: 30px;
            font-size: 15px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-success {
            background: var(--gradient-primary);
            color: #fff;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-success:hover {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .btn-secondary {
            background: transparent;
            color: var(--text-secondary);
            border: 2px solid var(--border-color);
        }

        .btn-secondary:hover {
            background: var(--hover-bg, rgba(25, 167, 123, 0.08));
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
            padding: 14px 18px;
            border-radius: 14px;
            margin-bottom: 24px;
            text-align: center;
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
                font-size: 24px;
            }

            .btn-group-custom {
                flex-direction: column;
            }

            .btn-custom, .btn-success, .btn-secondary {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .call-action h1 {
                font-size: 28px;
            }

            .call-action p {
                font-size: 16px;
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
                            <img class="logo1" src="${pageContext.request.contextPath}/assets/images/logo/logo.svg" alt="Logo" />
                            <span style="font-weight: 700; color: var(--primary); margin-left: 8px;">SmartInterview</span>
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
                                    <a class="active" href="${pageContext.request.contextPath}/recruiter.html">Home</a>
                                </li>

                                <li class="nav-item"><a href="#">Pages</a>
                                    <ul class="sub-menu">
                                        <li><a href="${pageContext.request.contextPath}/about-us.html">About Us</a></li>
                                        <li><a href="${pageContext.request.contextPath}/services.html">Services</a></li>
                                        <li><a href="${pageContext.request.contextPath}/contact.html">Contact</a></li>
                                    </ul>
                                </li>

                                <li class="nav-item"><a href="#">Manage Jobs</a>
                                    <ul class="sub-menu">
                                        <li class="nav-item"><a href="${pageContext.request.contextPath}/jobs/post">Post New Job</a></li>
                                        <li class="nav-item"><a href="${pageContext.request.contextPath}/jobs/by-company">Posted Jobs</a></li>
                                    </ul>
                                </li>

                                <li class="nav-item"><a href="#">Manage Candidates</a>
                                    <ul class="sub-menu">
                                      <li class="nav-item"><a href="${pageContext.request.contextPath}/recruiter/applicants">Applicants</a></li>
                                    </ul>
                                </li>

                                <li class="nav-item"><a href="${pageContext.request.contextPath}/recruiter/profile">My Profile</a></li>

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
        <h1>Update Your Profile</h1>
        <p><strong>Make changes to your profile below and save them when you're ready.</strong></p>
    </div>
</section>

<!-- Edit Profile Card -->
<div class="container container-profile">
    <div class="profile-card">
        <div class="profile-header">
            <div class="icon-wrapper">
                <i class="fas fa-user-edit"></i>
            </div>
            <h2>Update Your Information</h2>
            <p>All fields are required</p>
        </div>

        <c:if test="${not empty message}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/recruiter/profile/update" method="post" id="updateProfileForm">
            <input type="hidden" name="id" value="${recruiter.id}">

            <div class="form-group mb-4">
                <label for="name"><i class="fas fa-user"></i> Full Name</label>
                <input type="text" id="name" name="name" value="${recruiter.name}" class="form-control" placeholder="Enter your full name" required>
            </div>

            <div class="form-group mb-4">
                <label for="email"><i class="fas fa-envelope"></i> Email Address</label>
                <input type="email" id="email" name="email" value="${recruiter.email}" class="form-control" placeholder="Enter your email address" required>
            </div>

            <div class="form-group mb-4">
                <label for="password"><i class="fas fa-lock"></i> Password</label>
                <input type="password" id="password" name="password" value="${recruiter.password}" class="form-control" placeholder="Enter your password" required>
            </div>

            <div class="btn-group-custom">
                <button type="submit" class="btn btn-success" id="submitBtn">
                    <i class="fas fa-save"></i> Update Profile
                </button>
                <a href="${pageContext.request.contextPath}/recruiter/profile" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="btn btn-success">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </form>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.getElementById('updateProfileForm');
        const submitBtn = document.getElementById('submitBtn');
        
        if (form && submitBtn) {
            form.addEventListener('submit', function(e) {
                submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Updating...';
                submitBtn.disabled = true;
            });
        }

        // Keyboard shortcut for submit
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 's') {
                e.preventDefault();
                if (form) {
                    form.dispatchEvent(new Event('submit'));
                }
            }
        });
    });

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
</script>
</body>
</html>