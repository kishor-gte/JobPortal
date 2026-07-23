<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Jobs in ${category} | JobU - Find Your Dream Career</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"/>

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

        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        /* Header Premium */
        .category-header {
            text-align: center;
            margin-bottom: 2.5rem;
            animation: fadeInDown 0.6s ease-out;
        }

        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .category-header h1 {
            font-size: 2rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            letter-spacing: -0.5px;
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
        }

        .category-header h1 i {
            color: var(--accent);
            font-size: 2rem;
        }

        .category-header p {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-top: 0.5rem;
        }

        /* Stats Badge */
        .stats-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(25,167,123,0.1);
            padding: 0.4rem 1rem;
            border-radius: 40px;
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 1.5rem;
        }

        /* Job Cards Grid */
        .jobs-grid {
            display: flex;
            flex-direction: column;
            gap: 1.25rem;
        }

        /* Premium Job Card */
        .job-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.08);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
            animation: cardFadeIn 0.5s ease-out both;
        }

        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .job-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        .job-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.4s ease;
        }

        .job-card:hover::before {
            transform: scaleX(1);
        }

        /* Job Title */
        .job-title {
            font-size: 1.3rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.75rem;
        }

        /* Job Meta Grid */
        .job-meta {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 0.75rem;
            margin: 1rem 0;
            padding: 0.75rem 0;
            border-top: 1px solid rgba(25,167,123,0.1);
            border-bottom: 1px solid rgba(25,167,123,0.1);
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .meta-item i {
            color: var(--primary);
            width: 20px;
            font-size: 0.9rem;
        }

        .meta-item strong {
            color: var(--text-dark);
            font-weight: 600;
        }

        /* Posted Date */
        .posted-on {
            font-size: 0.7rem;
            color: var(--text-muted);
            display: inline-flex;
            align-items: center;
            gap: 0.4rem;
            background: rgba(25,167,123,0.06);
            padding: 0.25rem 0.75rem;
            border-radius: 40px;
            width: fit-content;
        }

        /* Action Buttons */
        .job-actions {
            display: flex;
            gap: 0.75rem;
            margin-top: 1rem;
            flex-wrap: wrap;
        }

        .btn-action {
            padding: 0.6rem 1.2rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.8rem;
            transition: var(--transition);
            border: none;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary-custom {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        .btn-outline-custom {
            background: transparent;
            color: var(--primary);
            border: 2px solid rgba(25,167,123,0.3);
        }

        .btn-outline-custom:hover {
            background: rgba(25,167,123,0.1);
            transform: translateY(-2px);
            border-color: var(--primary);
        }

        .btn-disabled {
            background: #e2ede7;
            color: var(--text-muted);
            cursor: not-allowed;
            opacity: 0.7;
        }

        /* Back Button */
        .back-btn {
            text-align: center;
            margin-top: 2.5rem;
        }

        .back-btn a {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: var(--bg-dark);
            color: white;
            text-decoration: none;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: var(--transition);
        }

        .back-btn a:hover {
            background: var(--bg-dark-light);
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
        }

        .empty-state i {
            font-size: 4rem;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--bg-dark);
            margin-bottom: 0.5rem;
        }

        .empty-state p {
            color: var(--text-muted);
        }

        /* Responsive */
        @media (max-width: 768px) {
            body { padding: 1rem; }
            .category-header h1 { font-size: 1.5rem; }
            .job-title { font-size: 1.1rem; }
            .job-meta { grid-template-columns: 1fr; gap: 0.5rem; }
            .job-actions { flex-direction: column; }
            .btn-action { width: 100%; justify-content: center; }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection { background: var(--primary); color: white; }
    </style>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<div class="container">
    <div class="category-header">
        <h1><i class="fas fa-briefcase"></i> Jobs in ${category}</h1>
        <p>Explore the best career opportunities in ${category}</p>
    </div>

    <div class="stats-badge">
        <i class="fas fa-chart-line"></i>
        <span>${fn:length(jobs)} Job${fn:length(jobs) != 1 ? 's' : ''} Found</span>
    </div>

    <c:if test="${not empty jobs}">
        <div class="jobs-grid">
            <c:forEach var="job" items="${jobs}">
                <div class="job-card">
                    <div class="job-title">${job.title}</div>
                    
                    <div class="job-meta">
                        <div class="meta-item"><i class="fas fa-building"></i> <strong>Company:</strong> ${job.company.name}</div>
                        <div class="meta-item"><i class="fas fa-map-marker-alt"></i> <strong>Location:</strong> ${job.location}</div>
                        <div class="meta-item"><i class="fas fa-rupee-sign"></i> <strong>Salary:</strong> ₹${job.salaryMin} - ₹${job.salaryMax}</div>
                        <div class="meta-item"><i class="fas fa-user-clock"></i> <strong>Experience:</strong> ${job.experienceRequired} years</div>
                    </div>

                    <div class="posted-on">
                        <i class="fas fa-calendar-alt"></i>
                        <span class="relative-date" data-date="${job.postedDate}">${job.postedDate}</span>
                    </div>

                    <div class="job-actions">
                        <form action="${pageContext.request.contextPath}/jobs/details/${job.id}" method="get" style="display: inline;">
                            <button type="submit" class="btn-action btn-primary-custom">
                                <i class="fas fa-eye"></i> View Details
                            </button>
                        </form>

                        <c:choose>
                            <c:when test="${appliedJobIds.contains(job.id)}">
                                <button type="button" class="btn-action btn-disabled" disabled>
                                    <i class="fas fa-check-circle"></i> Already Applied
                                </button>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/applications/apply" method="post" style="display: inline;">
                                    <input type="hidden" name="jobId" value="${job.id}"/>
                                    <button type="submit" class="btn-action btn-primary-custom">
                                        <i class="fas fa-paper-plane"></i> Apply Now
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="${savedJobIds.contains(job.id)}">
                                <button type="button" class="btn-action btn-disabled" disabled>
                                    <i class="fas fa-bookmark"></i> Saved
                                </button>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/jobs/seeker/save-job" method="post" style="display: inline;">
                                    <input type="hidden" name="jobId" value="${job.id}"/>
                                    <button type="submit" class="btn-action btn-outline-custom">
                                        <i class="far fa-bookmark"></i> Save for Later
                                    </button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty jobs}">
        <div class="empty-state">
            <i class="fas fa-briefcase"></i>
            <h3>No Jobs Available</h3>
            <p>No jobs available for this category at the moment.</p>
        </div>
    </c:if>

    <div class="back-btn">
        <a href="${pageContext.request.contextPath}/jobs/all">
            <i class="fas fa-arrow-left"></i> Back to all jobs
        </a>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
<script>
function getRelativeDate(dateStr) {
    if (!dateStr) return '';
    const postedDate = new Date(dateStr);
    const now = new Date();
    const diffTime = now - postedDate;
    const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24));

    if (diffDays === 0) return "Today";
    if (diffDays === 1) return "1 day ago";
    if (diffDays < 7) return diffDays + " days ago";
    if (diffDays < 30) {
        const weeks = Math.floor(diffDays / 7);
        return weeks + (weeks === 1 ? " week ago" : " weeks ago");
    }
    if (diffDays < 365) {
        const months = Math.floor(diffDays / 30);
        return months + (months === 1 ? " month ago" : " months ago");
    }
    const years = Math.floor(diffDays / 365);
    return years + (years === 1 ? " year ago" : " years ago");
}

document.addEventListener("DOMContentLoaded", () => {
    const dateElements = document.querySelectorAll(".relative-date");
    dateElements.forEach(el => {
        const rawDate = el.getAttribute("data-date");
        if (rawDate) el.textContent = getRelativeDate(rawDate);
    });
});

// Preserved original mobile responsive script
document.addEventListener('DOMContentLoaded', function() {
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