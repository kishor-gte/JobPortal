<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>${company.name} | Jobs | JobU - Find Your Dream Career</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Explore jobs at ${company.name} on JobU. Find your next career opportunity.">

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<!-- AOS Animation -->
<link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

<style>
:root {
    --primary: #19A77B;
    --primary-dark: #148F69;
    --primary-light: #3BC49A;
    --primary-glow: rgba(25,167,123,0.2);
    --accent: #3BC49A;
    --bg-dark: #2E3E41;
    --bg-light: #f4fbf9;
    --text-dark: #1a2c2f;
    --text-muted: #5a6e66;
    --white: #ffffff;
    --border: #e2e8f0;
    --star: #f59e0b;
    --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
    --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
    --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
    --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
    --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
    --shadow-xl: 0 40px 60px -20px rgba(25,167,123,0.25);
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
    line-height: 1.5;
    min-height: 100vh;
}

/* Custom Scrollbar */
::-webkit-scrollbar { width: 8px; }
::-webkit-scrollbar-track { background: #e6f4ef; border-radius: 10px; }
::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
::-webkit-scrollbar-thumb:hover { background: var(--primary-dark); }

/* Page Layout */
.page {
    max-width: 1280px;
    margin: 0 auto;
    padding: 32px 24px 60px;
}

/* ========== PREMIUM HERO SECTION ========== */
.hero {
    background: var(--white);
    border-radius: var(--radius);
    overflow: hidden;
    box-shadow: var(--shadow-sm);
    transition: var(--transition);
    margin-bottom: 32px;
    border: 1px solid rgba(25,167,123,0.1);
}
.hero:hover {
    box-shadow: var(--shadow-md);
}

.hero-banner {
    height: 160px;
    background: var(--gradient-dark);
    position: relative;
    overflow: hidden;
}
.hero-banner::before {
    content: '';
    position: absolute;
    top: -30%;
    right: -10%;
    width: 400px;
    height: 400px;
    background: radial-gradient(circle, rgba(59,196,154,0.15) 0%, transparent 70%);
    border-radius: 50%;
    animation: floatGlow 20s infinite alternate;
}
.hero-banner::after {
    content: '';
    position: absolute;
    bottom: -20%;
    left: -5%;
    width: 300px;
    height: 300px;
    background: radial-gradient(circle, rgba(25,167,123,0.1) 0%, transparent 70%);
    border-radius: 50%;
    animation: floatGlow2 18s infinite alternate;
}
@keyframes floatGlow {
    0% { transform: translate(0,0) scale(1); opacity: 0.3; }
    100% { transform: translate(-60px, 50px) scale(1.3); opacity: 0.6; }
}
@keyframes floatGlow2 {
    0% { transform: translate(0,0) scale(1); opacity: 0.2; }
    100% { transform: translate(60px, -40px) scale(1.2); opacity: 0.5; }
}

.hero-content {
    padding: 28px 32px 32px;
    position: relative;
}

/* Logo */
.hero-logo {
    position: absolute;
    top: -55px;
    left: 32px;
    z-index: 10;
}
.logo-box {
    width: 110px;
    height: 110px;
    background: var(--white);
    border-radius: 20px;
    border: 1px solid rgba(25,167,123,0.2);
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    box-shadow: var(--shadow-md);
    transition: var(--transition);
}
.logo-box:hover {
    transform: scale(1.02);
    box-shadow: var(--shadow-lg);
}
.logo-box img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    padding: 12px;
}

/* Company Info */
.hero-info {
    margin-left: 140px;
}
.hero-info h1 {
    margin: 0;
    font-size: 2rem;
    font-weight: 800;
    background: linear-gradient(135deg, var(--text-dark), var(--primary));
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    letter-spacing: -0.5px;
}
.meta {
    margin-top: 8px;
    font-size: 0.85rem;
    color: var(--text-muted);
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
}
.meta span i {
    color: var(--primary);
    margin-right: 6px;
}

/* Rating */
.rating {
    margin-top: 12px;
    font-size: 0.9rem;
}
.rating i {
    color: var(--star);
    margin-right: 2px;
}
.rating span {
    margin-left: 8px;
    color: var(--text-muted);
    font-weight: 500;
}

/* Company Links */
.company-links {
    margin-top: 16px;
    display: flex;
    flex-wrap: wrap;
    gap: 20px;
}
.company-links a {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    color: var(--primary);
    font-weight: 600;
    font-size: 0.85rem;
    text-decoration: none;
    padding: 6px 0;
    transition: var(--transition);
    border-bottom: 2px solid transparent;
}
.company-links a:hover {
    border-bottom-color: var(--primary);
    transform: translateY(-2px);
}

/* About */
.about {
    margin-top: 20px;
    padding-top: 16px;
    border-top: 1px solid var(--border);
    font-size: 0.9rem;
    color: var(--text-muted);
    line-height: 1.7;
}

/* ========== SECTION CARDS ========== */
.section {
    background: var(--white);
    border-radius: var(--radius);
    border: 1px solid rgba(25,167,123,0.1);
    box-shadow: var(--shadow-sm);
    transition: var(--transition);
    margin-top: 28px;
    overflow: hidden;
}
.section:hover {
    box-shadow: var(--shadow-md);
}

.section-header {
    padding: 20px 28px;
    border-bottom: 1px solid var(--border);
    font-size: 1.1rem;
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: 10px;
}
.section-header i {
    color: var(--primary);
    font-size: 1.2rem;
}

/* Job List */
.job-list {
    padding: 0;
}
.job-item {
    padding: 18px 28px;
    border-bottom: 1px solid var(--border);
    transition: var(--transition);
}
.job-item:last-child {
    border-bottom: none;
}
.job-item:hover {
    background: var(--bg-light);
    transform: translateX(5px);
}
.job-item a {
    font-size: 1rem;
    font-weight: 700;
    color: var(--text-dark);
    text-decoration: none;
    transition: var(--transition);
    display: inline-block;
}
.job-item a:hover {
    color: var(--primary);
    transform: translateX(3px);
}
.job-meta {
    margin-top: 8px;
    font-size: 0.75rem;
    color: var(--text-muted);
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
}
.job-meta i {
    margin-right: 4px;
}

/* Reviews */
.review {
    padding: 20px 28px;
    border-bottom: 1px solid var(--border);
    transition: var(--transition);
}
.review:last-child {
    border-bottom: none;
}
.review:hover {
    background: var(--bg-light);
}
.review .rating {
    margin-bottom: 8px;
}
.review p {
    margin: 8px 0;
    font-size: 0.85rem;
    color: var(--text-muted);
    line-height: 1.6;
}
.review small {
    color: var(--primary);
    font-weight: 600;
    font-size: 0.75rem;
}

/* Empty States */
.empty-state {
    padding: 40px;
    text-align: center;
    color: var(--text-muted);
}
.empty-state i {
    font-size: 3rem;
    color: var(--primary-light);
    margin-bottom: 16px;
    opacity: 0.5;
}

/* Responsive */
@media (max-width: 768px) {
    .page { padding: 20px 16px; }
    .hero-content { padding: 20px; }
    .hero-logo { position: relative; top: 0; left: 0; margin-bottom: 20px; }
    .hero-info { margin-left: 0; }
    .logo-box { width: 80px; height: 80px; }
    .hero-info h1 { font-size: 1.5rem; }
    .section-header { padding: 16px 20px; }
    .job-item { padding: 14px 20px; }
    .review { padding: 16px 20px; }
}
</style>
</head>
<body>

<div class="page">

    <!-- Hero Section -->
    <div class="hero" data-aos="fade-down">
        <div class="hero-banner"></div>
        <div class="hero-content">
            <div class="hero-logo">
                <div class="logo-box">
                    <img 
                        src="${pageContext.request.contextPath}${company.logo}"
                        alt="${company.name}"
                        loading="lazy"
                        onerror="this.style.display='none'"
                    />
                </div>
            </div>
            <div class="hero-info">
                <h1>${company.name}</h1>
                <div class="meta">
                    <span><i class="fas fa-industry"></i> ${company.industry}</span>
                    <span><i class="fas fa-location-dot"></i> ${company.location}</span>
                </div>
                <div class="rating">
                    <c:forEach begin="1" end="5" var="i">
                        <i class="${i <= avgRating ? 'fas' : 'far'} fa-star"></i>
                    </c:forEach>
                    <span>(${avgRating} out of 5)</span>
                </div>
                <div class="company-links">
                    <a href="${company.website}" target="_blank"><i class="fas fa-globe"></i> Website</a>
                    <a href="${pageContext.request.contextPath}/company/jobseeker/company/${company.id}/videos">
                        <i class="fas fa-video"></i> Culture Videos
                    </a>
                </div>
                <div class="about">
                    <i class="fas fa-quote-left" style="color: var(--primary-light); margin-right: 8px; opacity: 0.6;"></i>
                    ${company.about}
                </div>
            </div>
        </div>
    </div>

    <!-- Jobs Section -->
    <div class="section" data-aos="fade-up" data-aos-delay="100">
        <div class="section-header">
            <i class="fas fa-briefcase"></i>
            Open Positions at ${company.name}
        </div>
        <div class="job-list">
            <c:choose>
                <c:when test="${not empty company.jobPosts}">
                    <c:forEach items="${company.jobPosts}" var="job">
                        <div class="job-item">
                            <a href="${pageContext.request.contextPath}/jobs/details/${job.id}">
                                ${job.title}
                            </a>
                            <div class="job-meta">
                                <span><i class="fas fa-map-marker-alt"></i> ${job.location}</span>
                                <span><i class="fas fa-clock"></i> ${job.employmentType}</span>
                                <c:if test="${not empty job.salary}">
                                    <span><i class="fas fa-money-bill-wave"></i> ${job.salary}</span>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-briefcase"></i>
                        <p>No open positions at the moment. Check back later!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Reviews Section -->
    <div class="section" data-aos="fade-up" data-aos-delay="200">
        <div class="section-header">
            <i class="fas fa-star"></i>
            Employee Reviews
        </div>
        <div>
            <c:choose>
                <c:when test="${not empty company.reviews}">
                    <c:forEach items="${company.reviews}" var="review">
                        <div class="review">
                            <div class="rating">
                                <c:forEach begin="1" end="5" var="i">
                                    <i class="${i <= review.rating ? 'fas' : 'far'} fa-star"></i>
                                </c:forEach>
                            </div>
                            <p>"${review.comment}"</p>
                            <small>— ${review.jobSeeker.name}</small>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-comment-dots"></i>
                        <p>No reviews yet. Be the first to share your experience!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</div>

<!-- Scripts -->
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    // Initialize AOS for scroll animations
    AOS.init({
        duration: 800,
        once: true,
        offset: 50
    });

    // Mobile Responsive Sidebar Handler (Preserved)
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