<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ page import="in.sp.main.Entities.JobSeeker" %>
<%
    JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
    pageContext.setAttribute("jobSeeker", jobSeeker);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Browse Jobs | JobU - Find Your Dream Career</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    
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
            --success: #19A77B;
            --danger: #ef4444;
            --warning: #f59e0b;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
            --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 16px;
            --radius-lg: 24px;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

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

        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        /* Sidebar Premium */
        .career-sidebar {
            background: linear-gradient(145deg, var(--bg-dark) 0%, #1f2e30 100%);
            width: 280px;
            min-height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1000;
            box-shadow: var(--shadow-lg);
            transition: transform 0.3s ease;
            border-radius: 0 24px 24px 0;
        }

        .sidebar-header {
            padding: 1.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .sidebar-logo {
            width: 45px;
            height: 45px;
            background-image: url('${pageContext.request.contextPath}/assets/images/logo/logo.png');
            background-repeat: no-repeat;
            background-position: center;
            background-size: contain;
        }

        .sidebar-company-name {
            color: white;
            font-weight: 800;
            font-size: 1.2rem;
            letter-spacing: -0.3px;
        }

        .sidebar-nav {
            list-style: none;
            padding: 1rem 0;
            margin: 0;
        }
        .sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1.5rem;
            color: rgba(255,255,255,0.85);
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: var(--transition);
            border-left: 3px solid transparent;
        }
        .sidebar-nav a i { width: 20px; }
        .sidebar-nav a:hover, .sidebar-nav a.active {
            background: rgba(25,167,123,0.15);
            border-left-color: var(--primary);
            color: white;
        }
        .sidebar-nav .has-submenu > a::after {
            content: '\f107';
            font-family: 'Font Awesome 6 Free';
            font-weight: 900;
            margin-left: auto;
            transition: transform 0.3s;
        }
        .sidebar-nav .has-submenu > a.open::after { transform: rotate(180deg); }
        .sidebar-nav .submenu {
            list-style: none;
            padding-left: 2.5rem;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease;
        }
        .sidebar-nav .submenu.show { max-height: 300px; }
        .sidebar-nav .submenu a { padding: 0.5rem 1rem; font-size: 0.85rem; }

        /* Main Content */
        .main-content-wrapper {
            margin-left: 280px;
            padding: 1.5rem;
            transition: margin-left 0.3s ease;
        }

        /* Page Header Slim (White Style) */
        .page-header {
            background: #fff !important;
            border-bottom: 1px solid var(--border-color, #e0e6ed) !important;
            padding: 16px 24px !important;
            margin-bottom: 2rem !important;
            position: relative !important;
            z-index: 5 !important;
        }
        .page-header h1 {
            font-size: 20px !important;
            font-weight: 700 !important;
            margin: 0 !important;
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
            color: var(--primary, #19A77B) !important;
        }
        .page-header h1 i {
            color: var(--primary, #19A77B) !important;
        }
        .page-header p {
            display: none !important;
        }
        .page-header::before {
            display: none !important;
        }
            z-index: 1;
        }

        /* Search Section */
        .search-section {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            padding: 1rem;
            margin-bottom: 1.5rem;
            box-shadow: var(--shadow-sm);
        }
        .search-wrapper input {
            border-radius: 50px;
            border: 2px solid #e2ede7;
            padding: 0.75rem 5rem 0.75rem 1.25rem;
        }
        .search-wrapper input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.12);
        }
        .search-btn {
            right: 5px;
            background: var(--primary);
            border-radius: 50px;
            padding: 0.6rem 1.5rem;
        }

        /* Filter Sidebar */
        .filter-sidebar {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            padding: 1.25rem;
            box-shadow: var(--shadow-sm);
        }
        .filter-sidebar h3 {
            font-size: 1rem;
            font-weight: 700;
            color: var(--bg-dark);
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid var(--primary);
        }
        .form-label { font-size: 0.7rem; font-weight: 700; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; }
        .form-select, .form-control {
            border-radius: 50px;
            border: 2px solid #e2ede7;
            padding: 0.5rem 1rem;
            font-size: 0.85rem;
			margin-bottom: 5px;
        }
        .btn-filter {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            border-radius: 50px;
            padding: 0.6rem;
            font-weight: 700;
            margin-top: 1rem;
        }
        .btn-clear {
            border-radius: 50px;
            padding: 0.4rem 1rem;
            font-size: 0.8rem;
            margin-top: 0.75rem;
            width: 100%;
        }

        /* Job Card Premium */
        .job-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            padding: 1.25rem;
            margin-bottom: 1rem;
            box-shadow: var(--shadow-sm), 0 0 0 1px rgba(25,167,123,0.06);
            transition: var(--transition);
            animation: cardFadeIn 0.4s ease-out both;
        }
        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .job-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.12);
        }
        .job-title { font-size: 1.1rem; font-weight: 800; color: var(--bg-dark); }
        .badge-custom { font-size: 0.7rem; padding: 0.25rem 0.75rem; border-radius: 50px; }
        .badge-primary-custom { background: rgba(25,167,123,0.12); color: var(--primary); }
        .badge-success-custom { background: rgba(25, 167, 123,0.12); color: #19A77B; }
        .company-logo {
            width: 45px; height: 45px; border-radius: 12px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
        }
        .btn-job-action { border-radius: 50px; padding: 0.5rem 1rem; font-size: 0.8rem; font-weight: 600; }
        .btn-view { background: var(--primary); color: white; }
        .btn-apply { background: var(--success); color: white; }
        .btn-save { border: 2px solid var(--primary); color: var(--primary); background: transparent; }
        .btn-disabled { background: #e2ede7; color: var(--text-muted); }

        /* Responsive */
        @media (max-width: 992px) {
            .career-sidebar { transform: translateX(-100%); }
            .career-sidebar.show { transform: translateX(0); }
            .main-content-wrapper { margin-left: 0; }
            .sidebar-toggle-btn {
                display: block; position: fixed; top: 15px; left: 15px; z-index: 1001;
                background: var(--primary); color: white; border: none; padding: 10px 15px;
                border-radius: 12px; cursor: pointer;
            }
            .sidebar-overlay {
                display: none; position: fixed; top: 0; left: 0;
                width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 999;
            }
            .sidebar-overlay.show { display: block; }
        }

        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::selection { background: var(--primary); color: white; }
    </style>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>

<jsp:include page="/views/commons/student_sidebar.jsp" />

<div class="main-content-wrapper">
    <div class="page-header">
        <h1><i class="fas fa-briefcase me-2" style="color: var(--accent);"></i>Browse Jobs</h1>
        <p>Find your dream job from thousands of opportunities</p>
    </div>

    <div class="container-fluid px-0">
        <div class="row g-3">
            <!-- Filter Sidebar -->
            <div class="col-lg-3">
                <div class="filter-sidebar">
                    <h3><i class="fas fa-filter me-2"></i> Filter Jobs</h3>
                    <form method="get" action="${pageContext.request.contextPath}/jobs/all">
                        <input type="hidden" name="searchQuery" value="${param.searchQuery}">
                        <label class="form-label">Category</label>
                        <select name="category" class="form-select mb-2">
                            <option value="">All Categories</option>
                            <c:forEach var="cat" items="${jobCategory}">
                                <option value="${cat}" ${param.category == cat ? 'selected' : ''}>${cat}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label">Work Mode</label>
                        <select name="workMode" class="form-select mb-2">
                            <option value="">All Modes</option>
                            <c:forEach var="mode" items="${workMode}">
                                <option value="${mode}" ${param.workMode == mode ? 'selected' : ''}>${mode}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label">Employment Type</label>
                        <select name="employmentType" class="form-select mb-2">
                            <option value="">All Types</option>
                            <c:forEach var="type" items="${employmentType}">
                                <option value="${type}" ${param.employmentType == type ? 'selected' : ''}>${type}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label">Location</label>
                        <select name="location" class="form-select mb-2">
                            <option value="">All Locations</option>
                            <c:forEach var="loc" items="${location}">
                                <option value="${loc}" ${param.location == loc ? 'selected' : ''}>${loc}</option>
                            </c:forEach>
                        </select>
                        <label class="form-label">Min Salary</label>
                        <input type="number" name="salaryMin" class="form-control mb-2" placeholder="Min Salary" value="${param.salaryMin}">
                        <label class="form-label">Max Salary</label>
                        <input type="number" name="salaryMax" class="form-control mb-2" placeholder="Max Salary" value="${param.salaryMax}">
                        <button type="submit" class="btn-filter w-100"><i class="fas fa-check me-2"></i>Apply Filters</button>
                    </form>
                    <form method="get" action="${pageContext.request.contextPath}/jobs/all">
                        <button type="submit" class="btn-clear"><i class="fas fa-times me-2"></i>Clear All Filters</button>
                    </form>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-lg-9">
                <div class="search-section">
                    <form method="get" action="${pageContext.request.contextPath}/jobs/all">
                        <input type="hidden" name="category" value="${param.category}">
                        <input type="hidden" name="workMode" value="${param.workMode}">
                        <input type="hidden" name="employmentType" value="${param.employmentType}">
                        <input type="hidden" name="location" value="${param.location}">
                        <input type="hidden" name="salaryMin" value="${param.salaryMin}">
                        <input type="hidden" name="salaryMax" value="${param.salaryMax}">
                        <div class="search-wrapper position-relative">
                            <input type="text" class="form-control" name="searchQuery" placeholder="Search jobs by title, location, or company..." value="${param.searchQuery}">
                            <button type="submit" class="search-btn position-absolute top-50 translate-middle-y"><i class="fas fa-search"></i></button>
                        </div>
                    </form>
                </div>

                <c:if test="${not empty message}"><div class="alert alert-success-custom">${message}</div></c:if>
                <c:if test="${not empty error}"><div class="alert alert-danger-custom">${error}</div></c:if>

                <c:choose>
                    <c:when test="${empty jobs}">
                        <div class="empty-state text-center py-5 bg-white rounded-4 shadow-sm">
                            <i class="fas fa-briefcase fa-4x mb-3 opacity-50"></i>
                            <h3>No Jobs Found</h3>
                            <p>Try adjusting your filters or search criteria</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="job" items="${jobs}">
                            <div class="job-card">
                                <div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-2">
                                    <h3 class="job-title mb-0">${job.title}</h3>
                                    <div class="job-badges d-flex gap-1">
                                        <c:if test="${not empty job.employmentType}"><span class="badge-custom badge-primary-custom">${job.employmentType}</span></c:if>
                                        <c:if test="${not empty job.workMode}"><span class="badge-custom badge-success-custom">${job.workMode}</span></c:if>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center gap-2 mb-2">
                                    <div class="company-logo d-flex align-items-center justify-content-center rounded-3 bg-light">
                                        <span class="fw-bold text-primary">${fn:substring(job.company.name, 0, 1)}</span>
                                    </div>
                                    <div class="company-name fw-semibold">${job.company.name}</div>
                                </div>
                                <div class="d-flex flex-wrap gap-3 mb-2">
                                    <c:if test="${not empty job.location}"><span><i class="fas fa-map-marker-alt text-primary me-1"></i> ${job.location}</span></c:if>
                                    <c:if test="${not empty job.experienceRequired}"><span><i class="fas fa-user-tie text-primary me-1"></i> ${job.experienceRequired} years</span></c:if>
                                    <c:if test="${not empty job.salaryMin}"><span><i class="fas fa-rupee-sign text-primary me-1"></i> ₹<fmt:formatNumber value="${job.salaryMin}" maxFractionDigits="0"/> - ₹<fmt:formatNumber value="${job.salaryMax}" maxFractionDigits="0"/></span></c:if>
                                </div>
                                <div class="d-flex flex-wrap gap-2 mt-2">
                                    <form action="${pageContext.request.contextPath}/jobs/details/${job.id}" method="get" class="d-inline">
                                        <button type="submit" class="btn-job-action btn-view"><i class="fas fa-eye me-1"></i> View</button>
                                    </form>
                                    <c:choose>
                                        <c:when test="${appliedJobIds.contains(job.id)}">
                                            <button type="button" class="btn-job-action btn-disabled" disabled><i class="fas fa-check-circle me-1"></i> Applied</button>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/applications/apply" method="post" class="d-inline">
                                                <input type="hidden" name="jobId" value="${job.id}">
                                                <button type="submit" class="btn-job-action btn-apply"><i class="fas fa-paper-plane me-1"></i> Apply</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${savedJobIds.contains(job.id)}">
                                            <form action="${pageContext.request.contextPath}/jobs/seeker/unsave-job" method="post" class="d-inline">
                                                <input type="hidden" name="jobId" value="${job.id}">
                                                <button type="submit" class="btn-job-action btn-save" style="background-color: var(--primary); color: white;"><i class="fas fa-bookmark me-1"></i> Saved</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <form action="${pageContext.request.contextPath}/jobs/seeker/save-job" method="post" class="d-inline">
                                                <input type="hidden" name="jobId" value="${job.id}">
                                                <button type="submit" class="btn-job-action btn-save"><i class="far fa-bookmark me-1"></i> Save</button>
                                            </form>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="mt-2 pt-2 border-top">
                                    <small class="text-muted"><i class="fas fa-clock me-1"></i> Posted: ${job.postedDate}</small>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<script>

document.addEventListener('DOMContentLoaded', function() {
    const jobsSubmenu = document.querySelector('.sidebar-nav .has-submenu');
    if (jobsSubmenu) {
        const submenuLink = jobsSubmenu.querySelector('a');
        const submenu = jobsSubmenu.querySelector('.submenu');
        if (submenuLink && submenu) {
            submenu.classList.add('show');
            submenuLink.classList.add('open');
        }
    }
    if (!document.getElementById('mobile-responsive-style')) {
        const style = document.createElement('style');
        style.id = 'mobile-responsive-style';
        style.innerHTML = `@media (max-width: 768px) { .sidebar, .nav-sidebar { transform: translateX(-100%); transition: transform 0.3s ease; position: fixed !important; z-index: 1001 !important; height: 100vh; } .sidebar.active, .nav-sidebar.active { transform: translateX(0); box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important; } .main-content { margin-left: 0 !important; padding: 16px !important; width: 100% !important; max-width: 100% !important; } } .mobile-menu-btn { display: none; }`;
        document.head.appendChild(style);
    }
    const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
    if (sidebar) {
        const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
        let heading = null;
        if (topBar && topBar !== document.body) heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
        if (!heading && !document.querySelector('.mobile-menu-btn')) { heading = document.createElement('div'); heading.style.padding = '10px'; document.body.insertBefore(heading, document.body.firstChild); }
        if (heading && !document.querySelector('.mobile-menu-btn')) {
            heading.style.display = 'flex'; heading.style.alignItems = 'center';
            const toggleBtn = document.createElement('button'); toggleBtn.className = 'mobile-menu-btn'; toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
            heading.insertBefore(toggleBtn, heading.firstChild);
            const overlay = document.createElement('div'); overlay.className = 'mobile-overlay'; document.body.appendChild(overlay);
            let touchstartX = 0, touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { touchendX = e.changedTouches[0].screenX; if (touchendX < touchstartX - 50) closeSidebar(); if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); }, {passive: true});
            function openSidebar() { sidebar.classList.add('active'); overlay.classList.add('active'); document.body.style.overflow = 'hidden'; }
            function closeSidebar() { sidebar.classList.remove('active'); overlay.classList.remove('active'); document.body.style.overflow = ''; }
            toggleBtn.addEventListener('click', openSidebar); overlay.addEventListener('click', closeSidebar);
        }
    }
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        rows.forEach(row => { Array.from(row.querySelectorAll('td')).forEach((td, index) => { if(headers[index]) td.setAttribute('data-label', headers[index]); }); });
    });
});
</script>
</body>
</html>