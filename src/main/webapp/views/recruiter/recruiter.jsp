<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="x-ua-compatible" content="ie=edge" />
    <title>SmartInterview</title>
    <meta name="description" content="" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/favicon.svg" />

    <!-- Web Font -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- ========================= CSS here ========================= -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/LineIcons.2.0.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/glightbox.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>

    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
        }

        /* Header styling */
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
        .hero-area {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            position: relative;
            overflow: hidden;
        }

        .hero-area::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.05) 0%, transparent 50%);
            pointer-events: none;
        }

        .hero-text h3 {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 700;
        }

        .hero-text h1 {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 800;
        }

        .hero-video-head img {
            border-radius: 20px;
            box-shadow: var(--shadow-md);
        }

        /* Call to Action Section */
        .call-action {
            position: relative;
            background: var(--gradient-primary) url('${pageContext.request.contextPath}/resources/images/hero/cat-bg.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            overflow: hidden;
        }

        .call-action::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(25, 167, 123, 0.85);
        }

        .call-action .container {
            position: relative;
            z-index: 2;
        }

        .call-action .section-title span {
            color: rgba(255, 255, 255, 0.9) !important;
        }

        .call-action .section-title h2 {
            color: #fff !important;
        }

        .call-action .section-title p {
            color: rgba(255, 255, 255, 0.9) !important;
        }

        .call-action .btn {
            background: #fff;
            color: var(--primary) !important;
            border: none;
            padding: 12px 28px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-md);
        }

        .call-action .btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        .call-action .alt-btn {
            background: transparent !important;
            border: 2px solid rgba(255, 255, 255, 0.8) !important;
            color: #fff !important;
        }

        .call-action .alt-btn:hover {
            background: #fff;
            color: var(--primary) !important;
        }

        /* Job Category Section */
        .job-category .single-cat {
            background: #ffffff;
            border: 1px solid rgba(25, 167, 123, 0.1);
            border-radius: 16px;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .job-category .single-cat::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient-primary);
            transform: translateX(-100%);
            transition: transform 0.5s ease;
        }

        .job-category .single-cat:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-md), var(--glow-primary);
            border-color: var(--primary);
        }

        .job-category .single-cat:hover::before {
            transform: translateX(0);
        }

        .job-category .single-cat .icon {
            background: rgba(25, 167, 123, 0.1);
            border-radius: 14px;
            width: 56px;
            height: 56px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
        }

        .job-category .single-cat .icon i {
            font-size: 28px;
            color: var(--primary);
        }

        .job-category .single-cat h3 {
            color: var(--text-primary, #1e293b);
            font-weight: 600;
        }

        /* Footer */
        .footer {
            background: var(--gradient-primary) !important;
            font-family: 'Inter', sans-serif;
            color: #ffffff;
            position: relative;
        }

        .footer .footer-social a {
            background-color: rgba(255, 255, 255, 0.15) !important;
            width: 42px;
            height: 42px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            transition: 0.3s;
        }

        .footer .footer-social a:hover {
            background-color: rgba(255, 255, 255, 0.3) !important;
            transform: translateY(-2px);
        }

        .footer .newsletter input {
            background-color: transparent !important;
            border: 1px solid rgba(255, 255, 255, 0.5) !important;
            color: #ffffff !important;
        }

        .footer .newsletter input::placeholder {
            color: rgba(255, 255, 255, 0.7) !important;
        }

        .footer .newsletter .btn {
            background: #ffffff !important;
            color: var(--primary) !important;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s;
        }

        .footer .newsletter .btn:hover {
            background: var(--bg-darker) !important;
            color: #fff !important;
        }

        .footer .footer-bottom a {
            color: #ffffff !important;
            transition: 0.3s;
        }

        .footer .footer-bottom a:hover {
            color: var(--bg-darker) !important;
        }

        /* WhatsApp Button */
        .whatsapp-float {
            position: fixed;
            bottom: 80px;
            right: 20px;
            z-index: 999;
            font-size: 36px;
            text-decoration: none;
            transition: transform 0.3s ease;
        }

        .whatsapp-float:hover {
            transform: scale(1.1);
        }

        /* Scroll Top */
        .scroll-top {
            background: var(--gradient-primary) !important;
            box-shadow: var(--glow-primary);
        }

        .scroll-top:hover {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%) !important;
        }

        /* Section Title Enhancement */
        .section-title span {
            color: var(--primary) !important;
            background: transparent !important;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
    </style>
</head>

<body>
    <!--[if lte IE 9]>
    <p class="browserupgrade">
        You are using an <strong>outdated</strong> browser. Please
        <a href="https://browsehappy.com/">upgrade your browser</a> to improve
        your experience and security.
    </p>
    <![endif]-->

    <div id="loading-area"></div>

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
                                        <a class="active" href="${pageContext.request.contextPath}/recruiter/dashboard">Home</a>
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
                                            <li class="nav-item"><a href="${pageContext.request.contextPath}/jobs/post/${companyId}">Post New Job</a></li>
                                            <li class="nav-item"><a href="${pageContext.request.contextPath}/recruiter/posted-jobs">Posted Jobs</a></li>
                                            <li class="nav-item"><a href="${pageContext.request.contextPath}/jobs/post-internship/${companyId}">Post New Internship</a></li>
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

    <!-- Start Hero Area for Recruiter -->
    <section class="hero-area">
        <div class="hero-inner">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 col-12 d-flex justify-content-center align-items-center">
                        <div class="inner-content text-center">
                            <div class="hero-text">
                                <p>
                                <h3 class="wow fadeInDown" data-wow-delay=".1s" style="margin-top: -10px; margin-bottom: 100px; font-weight: 700;">
                                    Welcome to Recruiter's World
                                </h3>
                                <h1 class="wow fadeInUp" data-wow-delay=".3s">
                                    Hire Top Talent<br>Faster & Smarter
                                </h1>
                                <p class="wow fadeInUp" data-wow-delay=".5s" style="color: #64748b;">
                                    Streamline your hiring process with powerful tools. <br>
                                    Post jobs, manage applications, and connect with <br>
                                    skilled professionals in one place.
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-12">
                        <div class="hero-video-head wow fadeInRight" data-wow-delay=".5s">
                            <div class="video-inner">
                                <img src="${pageContext.request.contextPath}/assets/images/hero/job hiring.jpeg"
                                    alt="Recruiter Dashboard Illustration">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--/ End Hero Area for Recruiter -->

    <!-- Start Call to Action Area for Recruiters -->
    <section class="call-action overlay section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 offset-lg-2 col-12">
                    <div class="inner">
                        <div class="section-title text-center">
                            <span class="wow fadeInDown" data-wow-delay=".2s">Empower Your Hiring</span>
                            <h2 class="wow fadeInUp" data-wow-delay=".4s">
                                Find the Right Candidates Faster
                            </h2>
                            <p class="wow fadeInUp" data-wow-delay=".6s">
                                Unlock premium features to streamline your hiring process, <br>
                                access top talent, and manage recruitment efficiently.
                            </p>
                            <div class="button wow fadeInUp" data-wow-delay=".8s">
                                <a href="${pageContext.request.contextPath}/jobs/post/${companyId}" class="btn"><i class="lni lni-briefcase"></i> Post a Job</a>
                                <a href="${pageContext.request.contextPath}/recruiter/explore" class="btn alt-btn ml-10"><i class="lni lni-search"></i> Explore Services</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- /End Call to Action Area for Recruiters -->

    <section class="job-category section">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="section-title">
                        <span class="wow fadeInDown" data-wow-delay=".2s">Why Recruit with SmartInterview?</span>
                        <h2 class="wow fadeInUp" data-wow-delay=".4s">Powerful Tools for Recruiters</h2>
                        <p class="wow fadeInUp" data-wow-delay=".6s" style="color: #64748b;">
                            Build trust, attract top talent, and simplify your hiring process with SmartInterview's
                            verified ecosystem and intelligent recruitment tools.
                        </p>
                    </div>
                </div>
            </div>

            <div class="cat-head">
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="single-cat wow fadeInUp" data-wow-delay=".4s">
                            <div class="icon">
                                <i class="fas fa-users"></i>
                            </div>
                            <h3>Smart Candidate Matching</h3>
                            <p>Our engine recommends top candidates who best match your job criteria — saving time and improving hiring accuracy.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="single-cat wow fadeInUp" data-wow-delay=".6s">
                            <div class="icon">
                                <i class="fas fa-tasks"></i>
                            </div>
                            <h3>Application Tracking Board</h3>
                            <p>Monitor every stage of recruitment — from applications to interviews — using a clean, intuitive tracking interface.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="single-cat wow fadeInUp" data-wow-delay="1s">
                            <div class="icon">
                                <i class="fas fa-brain"></i>
                            </div>
                            <h3>AI-Driven Job Optimization</h3>
                            <p>Receive instant suggestions to improve your job postings — from title clarity to keyword relevance — to attract the best candidates.</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-12">
                        <div class="single-cat wow fadeInUp" data-wow-delay="1.2s">
                            <div class="icon">
                                <i class="fas fa-headset"></i>
                            </div>
                            <h3>24/7 Recruiter Support</h3>
                            <p>Our expert support team is available anytime to assist with job postings, candidate queries, or technical issues.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer" style="font-family: 'Inter', sans-serif; color: #ffffff;">
        <div class="container">
            <div class="row py-5">
                <div class="col-lg-6 col-md-6 col-12 mb-4">
                    <div class="single-footer">
                        <div class="logo mb-3">
                            <a href="${pageContext.request.contextPath}/index">
                                <img src="${pageContext.request.contextPath}/assets/images/logo/logo.svg" alt="Logo" style="max-height: 45px;">
                            </a>
                        </div>
                        <p style="color: #ffffff; line-height: 1.6;">
                            Turn your ambitions into achievements — explore jobs that fit your future.
                        </p>
                        <ul class="contact-address mt-3" style="list-style: none; padding-left: 0; color: #ffffff;">
                            <li><strong>Email:</strong> fightthefireapp123@gmail.com</li>
                        </ul>
                        <div class="footer-social mt-3">
                            <ul style="padding-left: 0; list-style: none; display: flex; gap: 15px; flex-wrap: wrap;">
                                <li><a href="#"><i class="lni lni-facebook-original" style="font-size: 18px; color: #ffffff;"></i></a></li>
                                <li><a href="#"><i class="lni lni-twitter-original" style="font-size: 18px; color: #ffffff;"></i></a></li>
                                <li><a href="#"><i class="lni lni-linkedin-original" style="font-size: 18px; color: #ffffff;"></i></a></li>
                                <li><a href="#"><i class="lni lni-pinterest" style="font-size: 18px; color: #ffffff;"></i></a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-12">
                    <div class="single-footer newsletter">
                        <h3 style="color: #ffffff; font-weight: 600;">Join Our Newsletter</h3>
                        <p style="color: #ffffff; margin-bottom: 15px;">Get the latest job alerts and updates straight to your inbox.</p>
                        <form action="${pageContext.request.contextPath}/subscribe" method="post" class="newsletter-inner mt-3" style="display: flex; flex-wrap: wrap; gap: 10px;">
                            <input name="email" type="email" required placeholder="Your email address">
                            <button class="btn" type="submit">Subscribe Now</button>
                        </form>
                    </div>
                </div>
            </div>
            <div class="footer-bottom pt-4 pb-3 border-top" style="border-color: rgba(255,255,255,0.3); color: #ffffff;">
                <div class="row align-items-center">
                    <div class="col-md-6 col-12 text-start">
                        <p style="margin: 0;">&copy; 2026 <strong>SmartInterview</strong>. All rights reserved.</p>
                    </div>
                    <div class="col-md-6 col-12 text-end">
                        <ul style="list-style: none; display: flex; gap: 15px; justify-content: end; padding-left: 0; margin: 0;">
                            <li><a href="${pageContext.request.contextPath}/terms-conditions.html">Terms</a></li>
                            <li><a href="${pageContext.request.contextPath}/policy.html">Privacy</a></li>
                            <li><a href="${pageContext.request.contextPath}/faq.html">FAQ</a></li>
                            <li><a href="${pageContext.request.contextPath}/contact.html">Contact</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <a href="https://api.whatsapp.com/send?phone=918978300448&text=Hi%20there!" target="_blank" class="whatsapp-float">
            <i class="fa-brands fa-whatsapp"></i>
        </a>
    </footer>

    <a href="#" class="scroll-top btn-hover">
        <i class="lni lni-chevron-up"></i>
    </a>

    <!-- ========================= JS here ========================= -->
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/wow.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/tiny-slider.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/glightbox.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
    <script type="text/javascript">
        tns({
            container: '.client-logo-carousel',
            slideBy: 'page',
            autoplay: true,
            autoplayButtonOutput: false,
            mouseDrag: true,
            gutter: 15,
            nav: false,
            controls: false,
            responsive: {
                0: { items: 1 },
                540: { items: 2 },
                768: { items: 3 },
                992: { items: 4 },
                1170: { items: 6 }
            }
        });
        GLightbox({
            'href': 'https://www.youtube.com/watch?v=cz4z8CyvDas',
            'type': 'video',
            'source': 'youtube',
            'width': 900,
            'autoplayVideos': true,
        });

        // Subscription Razorpay Integration
        var newsletterForm = document.querySelector('.newsletter-inner');
        if (newsletterForm) {
            newsletterForm.addEventListener('submit', function (e) {
                e.preventDefault();
                var btn = this.querySelector('button[type="submit"]');
                var originalHtml = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-spinner fa-pulse"></i> Processing...';
                btn.disabled = true;

                var email = this.querySelector('input[name="email"]').value;

                fetch("${pageContext.request.contextPath}/api/subscription/createOrder", {
                    method: "POST",
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: "amount=99&email=" + encodeURIComponent(email) // Subscription amount
                })
                .then(response => {
                    if (response.status === 409) throw new Error("You already have an active subscription.");
                    if (!response.ok) throw new Error("Order creation failed");
                    return response.json();
                })
                .then(order => {
                    btn.innerHTML = originalHtml;
                    btn.disabled = false;
                    
                    if (order.id && order.id.startsWith("order_mock_")) {
                        // Mock flow bypass: submit dummy details to backend
                        fetch("${pageContext.request.contextPath}/api/subscription/verify", {
                            method: "POST",
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: "razorpay_payment_id=mock_payment_id" +
                                  "&razorpay_order_id=" + encodeURIComponent(order.id) +
                                  "&razorpay_signature=mock_signature" +
                                  "&email=" + encodeURIComponent(email)
                        })
                        .then(res => {
                            if(res.ok) {
                                alert("You have claimed the subscription.");
                                window.location.reload();
                            } else {
                                alert("Payment verification failed.");
                            }
                        });
                        return;
                    }
                    
                    var options = {
                        "key": "rzp_test_YourKeyID", 
                        "amount": order.amount,
                        "currency": "INR",
                        "name": "JobU Subscription",
                        "description": "Premium Job Alerts",
                        "order_id": order.id,
                        "handler": function (response) {
                            // Payment successful, submit to backend for verification
                            fetch("${pageContext.request.contextPath}/api/subscription/verify", {
                                method: "POST",
                                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                body: "razorpay_payment_id=" + encodeURIComponent(response.razorpay_payment_id) +
                                      "&razorpay_order_id=" + encodeURIComponent(response.razorpay_order_id) +
                                      "&razorpay_signature=" + encodeURIComponent(response.razorpay_signature) +
                                      "&email=" + encodeURIComponent(email)
                            })
                            .then(res => {
                                if(res.ok) {
                                    alert("You have claimed the subscription.");
                                    window.location.reload();
                                } else {
                                    alert("Payment verification failed.");
                                }
                            }).catch(err => {
                                alert("Error verifying payment.");
                            });
                        },
                        "prefill": {
                            "email": email
                        },
                        "theme": {
                            "color": "#19A77B"
                        },
                        "modal": {
                            "ondismiss": function() {
                                btn.innerHTML = originalHtml;
                                btn.disabled = false;
                            }
                        }
                    };
                    var rzp = new Razorpay(options);
                    rzp.open();
                })
                .catch(error => {
                    console.error("Error:", error);
                    btn.innerHTML = originalHtml;
                    btn.disabled = false;
                    alert(error.message || "Something went wrong with the payment system.");
                });
            });
        }
    </script>
</body>
</html>
