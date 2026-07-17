<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>${company.name} - Company Profile | JobU</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
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

        /* ========== PAGE HEADER ========== */
		.page-header {
		    background: #2CB58D;   /* Solid Green */
		    color: #fff;
		    padding: 50px 0 40px;
		    position: relative;
		    overflow: hidden;
		    margin-bottom: 40px;
		    border-radius: 10px;   /* Optional: remove if you don't want rounded corners */
		}

		/* Remove glow effects */
		.page-header::before,
		.page-header::after {
		    display: none;
		}

		/* Remove unused animations */
		@keyframes floatGlow {
		    from {}
		    to {}
		}

		@keyframes floatGlow2 {
		    from {}
		    to {}
		}

		.page-header h1 {
		    font-size: 2rem;
		    font-weight: 800;
		    margin: 0;
		    color: #fff;              /* Solid white text */
		    background: none;         /* Remove gradient */
		    -webkit-background-clip: initial;
		    background-clip: initial;
		    animation: none;          /* Remove shine animation */
		}

		@keyframes textShine {
		    from {}
		    to {}
		}

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--white);
            color: var(--primary);
            border: 1px solid rgba(25,167,123,0.2);
            border-radius: 50px;
            padding: 10px 24px;
            font-weight: 600;
            font-size: 0.85rem;
            text-decoration: none;
            transition: var(--transition);
            margin-bottom: 24px;
        }
        .back-btn:hover {
            background: var(--primary);
            color: white;
            transform: translateX(-4px);
            border-color: transparent;
        }

        /* ========== PROFILE CARD ========== */
        .profile-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 32px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 32px;
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
        }
        .profile-card:hover {
            box-shadow: var(--shadow-md);
        }
        .company-header {
            display: flex;
            align-items: center;
            gap: 32px;
            padding-bottom: 28px;
            border-bottom: 1px solid var(--border);
            margin-bottom: 28px;
            flex-wrap: wrap;
        }
        .company-logo-wrapper {
            flex-shrink: 0;
        }
        .company-logo {
            width: 120px;
            height: 120px;
            object-fit: contain;
            border-radius: 24px;
            background: var(--bg-light);
            padding: 12px;
            border: 1px solid rgba(25,167,123,0.2);
            transition: var(--transition);
        }
        .company-card:hover .company-logo {
            transform: scale(1.02);
            border-color: var(--primary-light);
        }
        .company-basic-info {
            flex: 1;
        }
        .company-name {
            font-size: 2rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--text-dark), var(--primary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 16px;
        }
        .company-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }
        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--text-muted);
            font-size: 0.85rem;
        }
        .meta-item i {
            color: var(--primary);
            width: 18px;
        }
        .meta-item a {
            color: var(--primary);
            text-decoration: none;
            transition: var(--transition);
        }
        .meta-item a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        .culture-video-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: var(--gradient);
            color: white;
            padding: 10px 24px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.85rem;
            text-decoration: none;
            transition: var(--transition);
            box-shadow: 0 4px 12px rgba(25,167,123,0.25);
        }
        .culture-video-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.35);
            color: white;
        }

        /* Section Titles */
        .section-title {
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .section-title i {
            color: var(--primary);
            font-size: 1.2rem;
        }
        .section-title .badge {
            background: var(--gradient);
            color: white;
            padding: 4px 12px;
            border-radius: 50px;
            font-size: 0.7rem;
        }

        /* About Section */
        .about-content {
            font-size: 0.95rem;
            line-height: 1.7;
            color: var(--text-muted);
        }
        .read-more-btn {
            color: var(--primary);
            cursor: pointer;
            font-weight: 600;
            font-size: 0.85rem;
            text-decoration: none;
            transition: var(--transition);
        }
        .read-more-btn:hover {
            color: var(--primary-dark);
            text-decoration: underline;
        }
        .full-text {
            display: none;
        }
        .full-text.show {
            display: block;
        }

        /* Job Listings Card */
        .job-listings-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 28px;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
        }
        .job-listings-card:hover {
            box-shadow: var(--shadow-md);
        }
        .job-item {
            background: var(--bg-light);
            border-radius: var(--radius-sm);
            padding: 16px 20px;
            margin-bottom: 12px;
            transition: var(--transition);
            border-left: 3px solid var(--primary);
        }
        .job-item:last-child {
            margin-bottom: 0;
        }
        .job-item:hover {
            transform: translateX(8px);
            background: #eef6f3;
        }
        .job-link {
            display: flex;
            align-items: center;
            gap: 12px;
            color: var(--text-dark);
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
            transition: var(--transition);
        }
        .job-link i {
            color: var(--primary);
            font-size: 0.8rem;
        }
        .job-link:hover {
            color: var(--primary);
        }
        .empty-jobs {
            text-align: center;
            padding: 40px 20px;
            color: var(--text-muted);
        }
        .empty-jobs i {
            font-size: 3rem;
            color: var(--primary-light);
            margin-bottom: 15px;
            opacity: 0.5;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 35px 0 25px; }
            .page-header h1 { font-size: 1.5rem; }
            .profile-card { padding: 20px; }
            .company-header { flex-direction: column; text-align: center; gap: 20px; }
            .company-logo { width: 100px; height: 100px; }
            .company-name { font-size: 1.5rem; }
            .company-meta { justify-content: center; }
            .section-title { font-size: 1.1rem; }
            .job-listings-card { padding: 20px; }
            .job-item { padding: 12px 16px; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container">
            <h1><i class="fas fa-building me-2"></i>Company Profile</h1>
        </div>
    </div>

    <div class="container">
        <!-- Back Button -->
        <a href="#" onclick="history.back(); return false;" class="back-btn" data-aos="fade-right">
            <i class="fas fa-arrow-left"></i> Back
        </a>
        
        <!-- Company Profile Card -->
        <div class="profile-card" data-aos="fade-up" data-aos-delay="100">
            <div class="company-header">
                <div class="company-logo-wrapper">
                    <img src="${pageContext.request.contextPath}${company.logo}" 
                         alt="${company.name} Logo" 
                         class="company-logo"
                         onerror="this.src='${pageContext.request.contextPath}/images/default-company.png'; this.onerror=null;">
                </div>

                <div class="company-basic-info">
                    <h1 class="company-name">${company.name}</h1>
                    
                    <div class="company-meta">
                        <c:if test="${not empty company.industry}">
                            <div class="meta-item">
                                <i class="fas fa-industry"></i>
                                <span>${company.industry}</span>
                            </div>
                        </c:if>

                        <c:if test="${not empty company.location}">
                            <div class="meta-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>${company.location}</span>
                            </div>
                        </c:if>

                        <c:if test="${not empty company.website}">
                            <div class="meta-item">
                                <i class="fas fa-globe"></i>
                                <a href="${company.website}" target="_blank" rel="noopener noreferrer">
                                    ${company.website}
                                </a>
                            </div>
                        </c:if>
                    </div>

                    <c:if test="${not empty company.id}">
                        <a href="${pageContext.request.contextPath}/company/jobseeker/company/${company.id}/videos" 
                           class="culture-video-link">
                            <i class="fas fa-video"></i> View Culture Videos
                        </a>
                    </c:if>
                </div>
            </div>

            <!-- About Section -->
            <c:if test="${not empty company.about}">
                <div class="section-title">
                    <i class="fas fa-info-circle"></i> About Us
                </div>
                <div class="about-content">
                    <c:choose>
                        <c:when test="${fn:length(company.about) > 200}">
                            <span id="aboutPreview">${fn:substring(company.about, 0, 200)}...</span>
                            <a href="#" class="read-more-btn" id="readMoreBtn" onclick="toggleFullText(event);">Read More</a>
                            <div class="full-text" id="fullAboutText">${company.about}</div>
                        </c:when>
                        <c:otherwise>
                            ${company.about}
                        </c:otherwise>
                    </c:choose>
                </div>
            </c:if>
        </div>


    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });

        function toggleFullText(event) {
            event.preventDefault();
            const fullText = document.getElementById('fullAboutText');
            const preview = document.getElementById('aboutPreview');
            const readMoreBtn = document.getElementById('readMoreBtn');
            
            if (fullText.classList.contains('show')) {
                fullText.classList.remove('show');
                readMoreBtn.textContent = 'Read More';
                if (preview) preview.style.display = 'inline';
            } else {
                fullText.classList.add('show');
                readMoreBtn.textContent = 'Read Less';
                if (preview) preview.style.display = 'none';
            }
        }

        // Mobile responsive sidebar handler
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
                        table:not(.table-responsive) td:before {
                            content: attr(data-label);
                            font-weight: 600;
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
        });
    </script>
</body>
</html>