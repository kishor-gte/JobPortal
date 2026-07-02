<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
   <title>Job Search Results | JobU - Find Your Dream Job</title>
   
   <!-- Google Fonts -->
   <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
   <!-- Font Awesome -->
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
   <!-- Bootstrap CSS -->
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
   
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
           display: flex;
           flex-direction: column;
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

       /* Header Section Premium */
       .header-section {
           background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
           color: white;
           padding: 2rem 1.5rem;
           text-align: center;
           position: relative;
           overflow: hidden;
       }

       .header-section::before {
           content: '';
           position: absolute;
           top: -50%;
           right: -20%;
           width: 400px;
           height: 400px;
           background: radial-gradient(circle, rgba(59,196,154,0.15), transparent);
           border-radius: 50%;
           animation: floatGlow 15s ease-in-out infinite;
       }

       @keyframes floatGlow {
           0%, 100% { transform: translate(0, 0) scale(1); }
           50% { transform: translate(-30px, 20px) scale(1.1); }
       }

       .header-section h3 {
           color: white;
           margin: 0;
           font-size: 1.8rem;
           font-weight: 800;
           letter-spacing: -0.5px;
           position: relative;
           z-index: 1;
           display: flex;
           align-items: center;
           justify-content: center;
           gap: 0.75rem;
       }

       .header-section h3 i {
           color: var(--accent);
       }

       /* Main Content */
       .main-content {
           flex: 1;
           padding: 2rem 1rem;
       }

       .container {
           max-width: 1200px;
           margin: 0 auto;
       }

       /* Stats Bar */
       .stats-bar {
           display: flex;
           justify-content: space-between;
           align-items: center;
           flex-wrap: wrap;
           gap: 1rem;
           margin-bottom: 2rem;
           padding: 0.75rem 1.5rem;
           background: var(--card-bg);
           backdrop-filter: blur(8px);
           border-radius: var(--radius-md);
           box-shadow: var(--shadow-sm);
           border: 1px solid rgba(25,167,123,0.1);
       }

       .stats-badge {
           display: flex;
           align-items: center;
           gap: 0.5rem;
           font-weight: 600;
           font-size: 0.85rem;
           color: var(--text-muted);
       }

       .stats-badge i {
           color: var(--primary);
       }

       .stats-badge .count {
           font-size: 1.2rem;
           font-weight: 800;
           color: var(--primary);
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

       .job-card h4 {
           font-size: 1.3rem;
           font-weight: 800;
           background: linear-gradient(135deg, var(--bg-dark), #4a6569);
           -webkit-background-clip: text;
           background-clip: text;
           color: transparent;
           margin-bottom: 1rem;
           display: flex;
           align-items: center;
           gap: 0.75rem;
       }

       .job-card h4 i {
           color: var(--primary);
           font-size: 1.2rem;
       }

       /* Job Details Grid */
       .job-card-details {
           display: grid;
           grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
           gap: 0.75rem;
           margin-bottom: 1rem;
           padding: 0.75rem 0;
           border-top: 1px solid rgba(25,167,123,0.1);
           border-bottom: 1px solid rgba(25,167,123,0.1);
       }

       .job-card-details div {
           display: flex;
           align-items: center;
           gap: 0.5rem;
           font-size: 0.85rem;
           color: var(--text-muted);
       }

       .job-card-details i {
           color: var(--primary);
           width: 20px;
           font-size: 0.85rem;
       }

       .job-card-details strong {
           color: var(--text-dark);
           font-weight: 600;
       }

       /* Posted Date */
       .posted-date {
           font-size: 0.75rem;
           color: var(--text-muted);
           margin: 0.75rem 0;
           display: inline-flex;
           align-items: center;
           gap: 0.5rem;
           background: rgba(25,167,123,0.06);
           padding: 0.25rem 0.75rem;
           border-radius: 40px;
           width: fit-content;
       }

       .posted-date i {
           color: var(--primary);
       }

       /* Button */
       .btn-primary {
           background: linear-gradient(105deg, var(--primary), var(--primary-dark));
           border: none;
           color: white;
           padding: 0.6rem 1.5rem;
           font-size: 0.85rem;
           border-radius: 50px;
           transition: var(--transition);
           display: inline-flex;
           align-items: center;
           gap: 0.5rem;
           text-decoration: none;
           font-weight: 600;
           box-shadow: 0 4px 12px rgba(25,167,123,0.3);
       }

       .btn-primary:hover {
           transform: translateY(-2px);
           box-shadow: 0 8px 20px rgba(25,167,123,0.4);
           color: white;
       }

       /* Pagination Premium */
       .pagination {
           justify-content: center;
           margin-top: 2rem;
           gap: 0.5rem;
       }

       .pagination .page-link {
           color: var(--primary);
           background: var(--card-bg);
           border: 1px solid rgba(25,167,123,0.2);
           border-radius: 50px;
           padding: 0.5rem 1rem;
           transition: var(--transition);
       }

       .pagination .page-link:hover {
           background: var(--primary);
           color: white;
           border-color: var(--primary);
           transform: translateY(-2px);
       }

       .pagination .page-item.active .page-link {
           background: linear-gradient(105deg, var(--primary), var(--primary-dark));
           border-color: var(--primary);
           color: white;
       }

       /* Footer Premium */
       .footer {
           background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
           color: white;
           padding: 1rem;
           text-align: center;
           font-size: 0.8rem;
           margin-top: auto;
       }

       /* Empty State */
       .no-jobs {
           text-align: center;
           padding: 4rem 2rem;
           background: var(--card-bg);
           backdrop-filter: blur(8px);
           border-radius: var(--radius-lg);
           box-shadow: var(--shadow-md);
       }

       .no-jobs i {
           font-size: 4rem;
           background: linear-gradient(135deg, var(--primary), var(--accent));
           -webkit-background-clip: text;
           background-clip: text;
           color: transparent;
           margin-bottom: 1rem;
       }

       .no-jobs h4 {
           font-size: 1.3rem;
           font-weight: 700;
           color: var(--bg-dark);
           margin-bottom: 0.5rem;
       }

       .no-jobs p {
           color: var(--text-muted);
       }

       /* Responsive */
       @media (max-width: 768px) {
           .header-section h3 { font-size: 1.4rem; }
           .job-card h4 { font-size: 1.1rem; }
           .job-card-details { grid-template-columns: 1fr; gap: 0.5rem; }
           .stats-bar { flex-direction: column; text-align: center; }
           .pagination .page-link { padding: 0.4rem 0.8rem; font-size: 0.8rem; }
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

<!-- Header Section -->
<div class="header-section">
    <h3><i class="fas fa-briefcase"></i> Job Search Results</h3>
</div>

<!-- Main Content Section -->
<div class="main-content">
    <div class="container">
        <c:choose>
            <c:when test="${not empty jobs && jobs.size() > 0}">
                <div class="stats-bar">
                    <div class="stats-badge">
                        <i class="fas fa-chart-line"></i>
                        <span>Found <span class="count">${fn:length(jobs)}</span> job${fn:length(jobs) != 1 ? 's' : ''}</span>
                    </div>
                    <div class="stats-badge">
                        <i class="fas fa-clock"></i>
                        <span>Latest opportunities</span>
                    </div>
                </div>

                <div class="jobs-grid">
                    <c:forEach var="job" items="${jobs}">
                        <div class="job-card">
                            <h4>
                                <i class="fas fa-briefcase"></i>
                                ${job.title}
                            </h4>
                            <div class="job-card-details">
                                <div><i class="fas fa-map-marker-alt"></i> <strong>Location:</strong> <span>${job.location}</span></div>
                                <div><i class="fas fa-building"></i> <strong>Company:</strong> <span>${job.company.name}</span></div>
                                <div><i class="fas fa-rupee-sign"></i> <strong>Salary:</strong> <span>₹${job.salaryMin} - ₹${job.salaryMax}</span></div>
                                <div><i class="fas fa-user-clock"></i> <strong>Experience:</strong> <span>${job.experienceRequired} years</span></div>
                            </div>
                            <div class="posted-date">
                                <i class="far fa-calendar-alt"></i>
                                <strong>Posted on:</strong> ${job.postedDate}
                            </div>
                            <a href="${pageContext.request.contextPath}/jobs/details/${job.id}" class="btn-primary">
                                <i class="fas fa-eye"></i> View Details
                            </a>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination Section -->
                <c:if test="${not empty page}">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                            <c:if test="${page.hasPrevious()}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/jobs/search?page=${page.number - 1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                            </c:if>
                            <c:forEach var="i" begin="${page.number - 2}" end="${page.number + 2}" step="1">
                                <c:if test="${i >= 0 && i < page.totalPages}">
                                    <li class="page-item ${i == page.number ? 'active' : ''}">
                                        <a class="page-link" href="${pageContext.request.contextPath}/jobs/search?page=${i}">${i + 1}</a>
                                    </li>
                                </c:if>
                            </c:forEach>
                            <c:if test="${page.hasNext()}">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/jobs/search?page=${page.number + 1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </c:if>
                        </ul>
                    </nav>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="no-jobs">
                    <i class="fas fa-search"></i>
                    <h4>No Jobs Found</h4>
                    <p>Try adjusting your search criteria</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- Footer Section -->
<div class="footer">
    <p>&copy; 2025 JobU | All Rights Reserved</p>
</div>

<script>
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