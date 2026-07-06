<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="in.sp.main.Entities.Company" %>
<%
    Company company = (Company) session.getAttribute("company");
    String userName = (company != null) ? company.getName() : "Company";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Company Dashboard | JobU - Manage Your Business</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">

    <!-- Favicon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/assets/images/favicon.svg" type="image/x-icon" />

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

    <!-- External CSS (preserved for backend compatibility) -->
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
            --primary-light: #3BC49A;
            --primary-glow: rgba(25,167,123,0.15);
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-light: #f4fbf9;
            --text-dark: #1a2c2f;
            --text-muted: #5a6e66;
            --white: #ffffff;
            --border: #e2e8f0;
            --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
            --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
            --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
            --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
            --radius: 24px;
            --radius-sm: 16px;
            --transition: all 0.4s cubic-bezier(0.2, 0.95, 0.4, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            color: var(--text-dark);
            min-height: 100vh;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #e6f4ef; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--primary-dark); }

        /* ========== WELCOME MESSAGE ========== */
        .welcome-overlay {
            position: fixed;
            top: 90px;
            right: 24px;
            z-index: 9999;
            animation: slideInRight 0.5s ease-out;
        }
        .welcome-message {
            background: var(--gradient);
            color: white;
            padding: 16px 24px;
            border-radius: 20px;
            box-shadow: var(--shadow-lg);
            max-width: 340px;
            border: 1px solid rgba(255,255,255,0.2);
        }
        .welcome-message-content {
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .welcome-icon {
            font-size: 2rem;
            animation: bounce 2s infinite;
        }
        .welcome-text h3 {
            font-size: 1rem;
            margin: 0 0 4px 0;
            font-weight: 600;
        }
        .welcome-text p {
            font-size: 0.85rem;
            margin: 0;
            opacity: 0.9;
        }
        .user-name {
            color: #ffd700;
            font-weight: 700;
        }
        .countdown {
            font-size: 0.7rem;
            opacity: 0.7;
            margin-top: 8px;
            text-align: center;
        }
        @keyframes slideInRight {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }
        @keyframes bounce {
            0%,20%,50%,80%,100% { transform: translateY(0); }
            40% { transform: translateY(-3px); }
            60% { transform: translateY(-1px); }
        }
        @keyframes fadeOut {
            from { opacity: 1; transform: translateX(0); }
            to { opacity: 0; transform: translateX(100%); }
        }

        /* ========== HEADER NAVBAR ========== */
        .navbar-area {
            background: rgba(255,255,255,0.98);
            backdrop-filter: blur(12px);
            box-shadow: var(--shadow-sm);
            padding: 0;
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(25,167,123,0.1);
        }
        .navbar { padding: 10px 0; }
        .navbar-brand img.logo1 { height: 65px; width: auto; transition: transform 0.3s ease; }
        .navbar-brand:hover img.logo1 { transform: scale(1.02); }
        .nav-item a {
            font-weight: 600;
            font-size: 0.9rem;
            color: var(--bg-dark) !important;
            padding: 10px 18px !important;
            border-radius: 40px;
            transition: var(--transition);
        }
        .nav-item a:hover { color: var(--primary) !important; background: rgba(25,167,123,0.08); }
        .sub-menu {
            position: absolute;
            top: 100%;
            left: 0;
            min-width: 220px;
            background: white;
            border-radius: 16px;
            padding: 10px 0;
            box-shadow: var(--shadow-lg);
            opacity: 0;
            visibility: hidden;
            transform: translateY(10px);
            transition: all 0.3s ease;
            border: 1px solid rgba(25,167,123,0.1);
            list-style: none;
        }
        .nav-item:hover .sub-menu { opacity: 1; visibility: visible; transform: translateY(0); }
        .sub-menu li a {
            padding: 10px 22px !important;
            display: block;
            font-size: 0.85rem;
        }
        .button { display: flex; gap: 12px; align-items: center; }
        .button .btn {
            background: var(--gradient);
            border: none;
            padding: 8px 24px;
            border-radius: 40px;
            font-weight: 700;
            font-size: 0.9rem;
            color: white;
            transition: var(--transition);
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
            text-decoration: none;
        }
        .button .btn:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(25,167,123,0.4); }
        .notif-btn {
            position: relative;
            background: rgba(25,167,123,0.1);
            width: 42px;
            height: 42px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            transition: var(--transition);
        }
        .notif-btn:hover { background: var(--primary); color: white; transform: translateY(-2px); }
        .notif-count {
            position: absolute;
            top: -5px;
            right: -5px;
            background: #ef4444;
            color: white;
            font-size: 0.65rem;
            font-weight: 700;
            padding: 2px 6px;
            border-radius: 50px;
        }

        /* ========== BREADCRUMB ========== */
        .breadcrumbs {
			
            background:#2BB38E ;
            color:#fff;
            padding: 50px 0 40px;
            position: relative;
            overflow: hidden;
        }
        .breadcrumbs::before {
           display: none;
        }
        @keyframes floatGlow {
			from { }
			    to { }
        }
        .breadcrumbs h1 {
            font-size: 2.2rem;
            font-weight: 800;
			color: #fff; /* Dark Green Text */
		    margin-bottom: 12px;
        }
        .breadcrumb-nav {
            display: flex;
            gap: 10px;
            list-style: none;
            padding: 0;
            margin-top: 15px;
        }
        .breadcrumb-nav li a { color: #fff; text-decoration: none; font-weight: 600 }
        .breadcrumb-nav li:not(:last-child):after { content: '/'; margin-left: 10px; color: rgba(255, 255, 255, 0.8) }

        /* ========== DASHBOARD CARDS ========== */
        .company-control { padding: 60px 0; }
        .section-title { text-align: center; margin-bottom: 50px; }
        .section-title h2 {
            font-size: 2.2rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--text-dark), var(--primary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }
        .company-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 24px;
        }
        .single-company-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 40px 120px;
            padding-right: 150px;
            text-align: center;
            transition: var(--transition);
            display: block;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25,167,123,0.1);
            text-decoration: none;
        }
        .single-company-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-lg);
            border-color: var(--primary-light);
        }
        .single-company-card .icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, rgba(25,167,123,0.1), rgba(59,196,154,0.05));
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            transition: var(--transition);
        }
        .single-company-card:hover .icon {
            background: var(--gradient);
            transform: scale(1.05);
        }
        .single-company-card .icon i {
            font-size: 32px;
            color: var(--primary);
            transition: var(--transition);
        }
        .single-company-card:hover .icon i { color: white; }
        .single-company-card h3 {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--text-dark);
            transition: var(--transition);
        }
        .single-company-card:hover h3 { color: var(--primary); }

        /* Footer */
        footer {
            background: var(--gradient-dark);
            text-align: center;
            padding: 20px;
            color: #cbd5e1;
            font-size: 0.85rem;
            margin-top: 40px;
        }
        footer a { color: var(--primary-light); text-decoration: none; }
        footer a:hover { text-decoration: underline; }

        /* Responsive */
        @media (max-width: 768px) {
            .breadcrumbs h1 { font-size: 1.6rem; }
            .section-title h2 { font-size: 1.6rem; }
            .company-grid { grid-template-columns: 1fr; gap: 16px; }
            .single-company-card { padding: 25px 15px; }
            .navbar-nav { margin-top: 15px; }
            .sub-menu { position: static; opacity: 1; visibility: visible; transform: none; display: none; background: transparent; box-shadow: none; }
            .nav-item:hover .sub-menu { display: block; }
        }
    </style>
</head>
<body>

<!-- Header Area -->
<header class="header other-page">
    <div class="navbar-area">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-12">
                    <nav class="navbar navbar-expand-lg">
                        <a class="navbar-brand logo" href="${pageContext.request.contextPath}/index">
                            <img class="logo1" src="${pageContext.request.contextPath}/assets/images/logo/logo.png" alt="Logo" />
                        </a>
                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="toggler-icon"></span>
                            <span class="toggler-icon"></span>
                            <span class="toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
                            <ul id="nav" class="navbar-nav ms-auto">
                                <li class="nav-item"><a class="active" href="${pageContext.request.contextPath}/index">Home</a></li>
                                <li class="nav-item"><a href="${pageContext.request.contextPath}/recruiter/login">Recruiters Login</a></li>
                                <li class="nav-item">
                                    <a href="#">Corporate Sports</a>
                                    <ul class="sub-menu">
                                        <li><a href="${pageContext.request.contextPath}/company/sports/explore">Explore Corporate Sports</a></li>
                                        <li><a href="${pageContext.request.contextPath}/company/sports/bookings">My Bookings</a></li>
                                    </ul>
                                </li>
                                <li class="nav-item"><a href="${pageContext.request.contextPath}/services.html">Services</a></li>
                                <li class="nav-item"><a href="${pageContext.request.contextPath}/faq.html">FAQ</a></li>
                                <li class="nav-item"><a href="${pageContext.request.contextPath}/contact.html">Contact</a></li>
                                <li class="nav-item"><a href="${pageContext.request.contextPath}/terms-conditions.html">Terms & Conditions</a></li>
                            </ul>
                        </div>
                        <div class="button">
                            <a href="${pageContext.request.contextPath}/company/notifications" class="notif-btn position-relative">
                                <i class="fa fa-bell"></i>
                                <c:if test="${unseenCount > 0}">
                                    <span class="notif-count">${unseenCount}</span>
                                </c:if>
                            </a>
                            <a href="${pageContext.request.contextPath}/company/logout" class="btn"><i class="lni lni-lock-alt"></i> Logout</a>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Breadcrumb -->
<div class="breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="breadcrumbs-content" data-aos="fade-down">
                    <h1 class="page-title">Company Dashboard</h1>
                    <p>Manage your company's profile, job posts, recruiters, and more from this dashboard.</p>
                </div>
                <ul class="breadcrumb-nav" data-aos="fade-up">
                    <li><a href="${pageContext.request.contextPath}/index">Home</a></li>
                    <li>Company Dashboard</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!-- Company Dashboard Section -->
<section class="company-control section" id="dashboard">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="section-title" data-aos="fade-up">
                    <h2>Manage Your Company Functions</h2>
                    <p class="text-muted">Access and explore every section of your company profile here.</p>
                </div>
            </div>
        </div>

        <div class="company-grid">
            <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-delay="100">
                <a href="${pageContext.request.contextPath}/company/profile/${company.id}" class="single-company-card">
                    <div class="icon"><i class="fas fa-building"></i></div>
                    <h3>View Profile</h3>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-delay="150">
                <a href="${pageContext.request.contextPath}/company/edit/${company.id}" class="single-company-card">
                    <div class="icon"><i class="fas fa-edit"></i></div>
                    <h3>Edit Details</h3>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-delay="200">
                <a href="${pageContext.request.contextPath}/jobs/by-company/${company.id}" class="single-company-card">
                    <div class="icon"><i class="fas fa-briefcase"></i></div>
                    <h3>Job Posts</h3>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-delay="250">
                <a href="${pageContext.request.contextPath}/recruiter/register/${company.id}" class="single-company-card">
                    <div class="icon"><i class="fas fa-plus-circle"></i></div>
                    <h3>Add Recruiter</h3>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-delay="300">
                <a href="${pageContext.request.contextPath}/recruiter/list" class="single-company-card">
                    <div class="icon"><i class="fas fa-users"></i></div>
                    <h3>Manage Recruiters</h3>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-delay="350">
                <a href="${pageContext.request.contextPath}/company/media/${company.id}" class="single-company-card">
                    <div class="icon"><i class="fas fa-video"></i></div>
                    <h3>Culture Videos</h3>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-delay="400">
                <a href="${pageContext.request.contextPath}/company/reviews/${company.id}" class="single-company-card">
                    <div class="icon"><i class="fas fa-star"></i></div>
                    <h3>Company Reviews</h3>
                </a>
            </div>
            <div class="col-lg-3 col-md-6 col-12" data-aos="fade-up" data-aos-delay="450">
                <a href="${pageContext.request.contextPath}/hackerrank/interviewer/dashboard" class="single-company-card">
                    <div class="icon"><i class="fas fa-code"></i></div>
                    <h3>Interviewer Dashboard</h3>
                </a>
            </div>

        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="footer-content">
        &copy; 2025 JobU | 
        <a href="${pageContext.request.contextPath}/policy.html">Privacy Policy</a> | 
        <a href="${pageContext.request.contextPath}/terms-conditions.html">Terms of Service</a>
    </div>
</footer>

<!-- Scripts -->
<script src="${pageContext.request.contextPath}/assets/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/animate.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true, offset: 50 });
    new WOW().init();

    // Welcome message countdown
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
                setTimeout(() => { welcomeOverlay.style.display = 'none'; }, 500);
            }
        }, 1000);
    }
</script>
</body>
</html>