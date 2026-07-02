<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>${isInternship ? 'Post an Internship' : 'Post a Job'} | JobU - Recruiter Dashboard</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>

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

        /* Hero Section Premium */
        .call-action {
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
            color: white;
            text-align: center;
            padding: 3rem 2rem;
            position: relative;
            overflow: hidden;
            margin-bottom: 2rem;
        }

        .call-action::before {
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

        .call-action h1 {
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 1rem;
            position: relative;
            z-index: 1;
        }

        .call-action p {
            font-size: 1rem;
            opacity: 0.85;
            margin-bottom: 1.5rem;
            position: relative;
            z-index: 1;
        }

        .btn-primary-custom {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 50px;
            padding: 0.7rem 1.8rem;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            color: white;
            text-decoration: none;
        }

        .btn-primary-custom:hover {
            background: white;
            color: var(--primary-dark);
            transform: translateY(-2px);
        }

        /* Form Card Premium */
        .form-container {
            max-width: 900px;
            margin: 0 auto 3rem;
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.1);
            padding: 2rem;
            transition: var(--transition);
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .form-container:hover {
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Form Elements */
        .form-label {
            font-weight: 700;
            color: var(--bg-dark);
            margin-bottom: 0.5rem;
            display: block;
            font-size: 0.85rem;
            letter-spacing: 0.3px;
        }

        .form-label i {
            color: var(--primary);
            margin-right: 0.5rem;
        }

        .form-control, .form-select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e2ede7;
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
            transition: var(--transition);
            background: white;
        }

        .form-control:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.12);
        }

        textarea.form-control {
            resize: vertical;
            min-height: 120px;
        }

        .form-check {
            margin: 1rem 0;
        }

        .form-check-input {
            width: 18px;
            height: 18px;
            accent-color: var(--primary);
            cursor: pointer;
        }

        .form-check-label {
            font-weight: 500;
            margin-left: 0.5rem;
            cursor: pointer;
        }

        /* Submit Button */
        .btn-submit {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 0.9rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1rem;
            transition: var(--transition);
            cursor: pointer;
            width: 100%;
            box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
        }

        /* Select2 Overrides */
        .select2-container--default .select2-selection--single {
            border: 2px solid #e2ede7;
            border-radius: var(--radius-sm);
            height: auto;
            padding: 0.6rem 1rem;
        }

        .select2-container--default .select2-selection--single .select2-selection__arrow {
            top: 50%;
            transform: translateY(-50%);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .form-container { padding: 1.5rem; margin: 0 1rem 2rem; }
            .call-action h1 { font-size: 1.5rem; }
            .call-action { padding: 2rem 1rem; }
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

<!-- Hero Section -->
<section class="call-action">
    <div class="container">
        <h1><i class="fas ${isInternship ? 'fa-user-graduate' : 'fa-briefcase'}" style="color: var(--accent); margin-right: 0.5rem;"></i> ${isInternship ? 'Post an Internship' : 'Create a Job Posting'}</h1>
        <p>${isInternship ? 'Fill in the details below to post a new internship opportunity for students and fresh graduates.' : 'Fill in the details below to post a new job opportunity and attract top candidates.'}</p>
        <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="btn-primary-custom">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</section>

<!-- Job Form Section -->
<div class="form-container">
    <form action="${pageContext.request.contextPath}/jobs/post" method="POST">
        <input type="hidden" name="companyId" value="${companyId}" />

        <div class="form-group mb-3">
            <label class="form-label" for="title"><i class="fas fa-heading"></i> ${isInternship ? 'Internship Title' : 'Job Title'}</label>
            <input type="text" id="title" name="title" class="form-control" placeholder="${isInternship ? 'e.g., Frontend Development Intern' : 'e.g., Senior Software Engineer'}" required />
        </div>

        <div class="form-group mb-3">
            <label class="form-label" for="description"><i class="fas fa-align-left"></i> Description</label>
            <textarea id="description" name="description" class="form-control" placeholder="Enter the job description" rows="5" required></textarea>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label" for="location"><i class="fas fa-map-marker-alt"></i> Location</label>
                <select id="location" name="location" class="form-select" required>
                    <option value="">-- Select Location --</option>
                    <c:forEach var="loc" items="${locations}">
                        <option value="${loc}">${loc}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label" for="employmentType"><i class="fas fa-briefcase"></i> Employment Type</label>
                <select id="employmentType" name="employmentType" class="form-select" required>
                    <option value="" disabled ${empty job.employmentType ? 'selected' : ''}>Select Employment Type</option>
                    <c:forEach var="type" items="${employmentTypes}">
                        <option value="${type}" <c:if test="${job.employmentType eq type}">selected</c:if>>${type}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label" for="workMode"><i class="fas fa-laptop-house"></i> Work Mode</label>
                <select id="workMode" name="workMode" class="form-select" required>
                    <option value="" disabled selected>Select Work Mode</option>
                    <c:forEach var="mode" items="${workModes}">
                        <option value="${mode}">${mode}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label" for="jobCategory"><i class="fas fa-tags"></i> Category</label>
                <select id="jobCategory" name="jobCategory" class="form-select" required>
                    <option value="" disabled selected>Select Job Category</option>
                    <c:forEach var="cat" items="${jobCategories}">
                        <option value="${cat}">${cat}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label" for="jobSector"><i class="fas fa-building"></i> Sector</label>
                <select id="jobSector" name="jobSector" class="form-select" required>
                    <option value="" disabled selected>Select Job Sector</option>
                    <c:forEach var="sec" items="${jobSectors}">
                        <option value="${sec}">${sec}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label" for="education"><i class="fas fa-graduation-cap"></i> Minimum Education</label>
                <select id="education" name="education" class="form-select">
                    <option value="" disabled selected>Select Education Level</option>
                    <c:forEach var="edu" items="${educationLevels}">
                        <option value="${edu}">${edu}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-md-4 mb-3">
                <label class="form-label" for="salaryMin"><i class="fas fa-rupee-sign"></i> Minimum Salary</label>
                <input type="number" id="salaryMin" name="salaryMin" step="0.01" class="form-control" placeholder="e.g., 30000" />
            </div>
            <div class="col-md-4 mb-3">
                <label class="form-label" for="salaryMax"><i class="fas fa-rupee-sign"></i> Maximum Salary</label>
                <input type="number" id="salaryMax" name="salaryMax" step="0.01" class="form-control" placeholder="e.g., 50000" />
            </div>
            <div class="col-md-4 mb-3">
                <label class="form-label" for="experienceRequired"><i class="fas fa-user-clock"></i> Experience (Years)</label>
                <input type="number" id="experienceRequired" name="experienceRequired" class="form-control" placeholder="e.g., 2" />
            </div>
        </div>

        <div class="form-check mb-3">
            <input type="checkbox" id="equityOffered" name="equityOffered" value="true" class="form-check-input" />
            <label class="form-check-label" for="equityOffered"><i class="fas fa-percent"></i> Equity Offered?</label>
        </div>

        <div class="form-group mb-3">
            <label class="form-label" for="skillRequirement"><i class="fas fa-tools"></i> Skills / Language Requirement</label>
            <input type="text" id="skillRequirement" name="skillRequirement" class="form-control" placeholder="e.g., Java, Python, React" />
        </div>

        <div class="form-group mb-4">
            <label class="form-label" for="expiryDate"><i class="fas fa-calendar-times"></i> Expiry Date</label>
            <input type="date" id="expiryDate" name="expiryDate" class="form-control" required />
        </div>

        <button type="submit" class="btn-submit">
            <i class="fas fa-paper-plane"></i> ${isInternship ? 'Create Internship' : 'Create Job'}
        </button>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    $(document).ready(function () {
        $('#skillRequirement').select2();
        
        var dtToday = new Date();
        var month = dtToday.getMonth() + 1;
        var day = dtToday.getDate();
        var year = dtToday.getFullYear();
        if(month < 10) month = '0' + month.toString();
        if(day < 10) day = '0' + day.toString();
        var minDate = year + '-' + month + '-' + day;
        $('#expiryDate').attr('min', minDate);
    });

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