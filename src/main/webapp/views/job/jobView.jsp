<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>${job.title} | JobU - Job Details</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
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

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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

        /* Premium Job Card */
        .job-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.1);
            overflow: hidden;
            max-width: 1000px;
            margin: 0 auto;
            transition: var(--transition);
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .job-card:hover {
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Card Header Premium */
        .job-card-header {
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2rem;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .job-card-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(59,196,154,0.15), transparent);
            border-radius: 50%;
            animation: floatGlow 15s ease-in-out infinite;
        }

        @keyframes floatGlow {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(-20px, 15px) scale(1.1); }
        }

        .job-card-header h2 {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            position: relative;
            z-index: 1;
        }

        /* Card Content */
        .job-card-content {
            padding: 2rem;
        }

        /* Info Grid */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .info-item {
            background: rgba(25,167,123,0.03);
            border-radius: var(--radius-sm);
            padding: 1rem;
            transition: var(--transition);
        }

        .info-item:hover {
            background: rgba(25,167,123,0.06);
            transform: translateX(4px);
        }

        .label {
            font-size: 0.7rem;
            font-weight: 700;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 1px;
            display: block;
            margin-bottom: 0.5rem;
        }

        .value {
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .value i {
            color: var(--primary);
            width: 20px;
        }

        /* Description Section */
        .description-section {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 2px solid rgba(25,167,123,0.1);
        }

        .description-section .label {
            margin-bottom: 0.75rem;
        }

        .description-text {
            background: rgba(25,167,123,0.03);
            border-radius: var(--radius-sm);
            padding: 1.25rem;
            line-height: 1.6;
            font-size: 0.9rem;
        }

        /* HR Divider */
        hr {
            border: none;
            height: 2px;
            background: linear-gradient(90deg, transparent, var(--primary), transparent);
            margin: 1.5rem 0;
        }

        /* Action Section */
        .action-section {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .btn-link {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 700;
            transition: var(--transition);
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
        }

        .btn-link:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        button {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            border: none;
            color: white;
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            font-size: 0.9rem;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        /* Responsive */
        @media (max-width: 768px) {
            body { padding: 1rem; }
            .job-card-header h2 { font-size: 1.4rem; }
            .job-card-content { padding: 1.5rem; }
            .info-grid { grid-template-columns: 1fr; }
            .action-section { flex-direction: column; }
            .btn-link, button { width: 100%; justify-content: center; }
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

<div class="job-card">
    <div class="job-card-header">
        <h2><i class="fas fa-briefcase" style="color: var(--accent); margin-right: 0.5rem;"></i> ${job.title}</h2>
    </div>

    <div class="job-card-content">
        <div class="info-grid">
            <div class="info-item">
                <span class="label"><i class="fas fa-building"></i> Company</span>
                <span class="value">${job.company.name}</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-map-marker-alt"></i> Location</span>
                <span class="value">${job.location}</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-briefcase"></i> Employment Type</span>
                <span class="value">${job.employmentType}</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-rupee-sign"></i> Salary</span>
                <span class="value">₹${job.salaryMin} - ₹${job.salaryMax}</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-user-clock"></i> Experience Required</span>
                <span class="value">${job.experienceRequired} years</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-laptop-house"></i> Work Mode</span>
                <span class="value">${job.workMode}</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-graduation-cap"></i> Education</span>
                <span class="value">${job.education}</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-tools"></i> Skills</span>
                <span class="value">${job.skillRequirement}</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-tags"></i> Job Category</span>
                <span class="value">${job.jobCategory}</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-chart-line"></i> Job Sector</span>
                <span class="value">${job.jobSector}</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-calendar-plus"></i> Posted Date</span>
                <span class="value">${job.postedDate}</span>
            </div>
            <div class="info-item">
                <span class="label"><i class="fas fa-calendar-times"></i> Expiry Date</span>
                <span class="value">${job.expiryDate}</span>
            </div>
        </div>

        <hr>

        <div class="description-section">
            <span class="label"><i class="fas fa-align-left"></i> Description</span>
            <div class="description-text">${job.description}</div>
        </div>

        <div class="action-section">
            <a href="${pageContext.request.contextPath}/jobs/all" class="btn-link">
                <i class="fas fa-arrow-left"></i> Back to Jobs
            </a>
            <form action="${pageContext.request.contextPath}/applications/apply" method="post">
                <input type="hidden" name="jobId" value="${job.id}">
                <button type="submit">
                    <i class="fas fa-paper-plane"></i> Apply Now
                </button>
            </form>
        </div>
    </div>
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