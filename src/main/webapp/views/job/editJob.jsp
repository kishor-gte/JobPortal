<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Edit Job | JobU - Recruiter Dashboard</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
            --success: #10b981;
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

        .container {
            max-width: 900px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        /* Header */
        .page-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .page-header h2 {
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

        .page-header h2 i {
            color: var(--accent);
            font-size: 2rem;
        }

        /* Premium Form Card */
        .form-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.1);
            padding: 2.5rem;
            transition: var(--transition);
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .form-card:hover {
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

        input[type="text"],
        input[type="number"],
        input[type="date"],
        textarea,
        select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid #e2ede7;
            border-radius: var(--radius-sm);
            font-size: 0.9rem;
            transition: var(--transition);
            background: white;
            font-family: 'Inter', sans-serif;
        }

        input:focus, textarea:focus, select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.12);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        /* Checkbox */
        .checkbox-wrapper {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1.25rem;
        }

        .checkbox-wrapper input {
            width: 18px;
            height: 18px;
            accent-color: var(--primary);
            cursor: pointer;
        }

        .checkbox-wrapper label {
            margin: 0;
            cursor: pointer;
            font-weight: 500;
        }

        /* Button Group */
        .button-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
            flex-wrap: wrap;
        }

        .btn-update {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            border: none;
            padding: 0.9rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.9rem;
            transition: var(--transition);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
        }

        .btn-update:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
        }

        .btn-delete {
            background: linear-gradient(105deg, #ef4444, #dc2626);
            color: white;
            border: none;
            padding: 0.9rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.9rem;
            transition: var(--transition);
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            box-shadow: 0 8px 20px -8px rgba(239,68,68,0.4);
        }

        .btn-delete:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px -10px rgba(239,68,68,0.5);
        }

        /* Responsive */
        @media (max-width: 768px) {
            body { padding: 1rem; }
            .form-card { padding: 1.5rem; }
            .page-header h2 { font-size: 1.5rem; }
            .button-group { flex-direction: column; }
            .btn-update, .btn-delete { width: 100%; justify-content: center; }
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
    <div class="page-header">
        <h2><i class="fas fa-edit"></i> Edit Job Posting</h2>
    </div>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/jobs/update" method="POST">
            <input type="hidden" name="id" value="${job.id}" />
            <input type="hidden" name="companyId" value="${companyId}" />

            <label class="form-label" for="title"><i class="fas fa-heading"></i> Job Title</label>
            <input type="text" id="title" name="title" value="${job.title}" required />

            <label class="form-label" for="description"><i class="fas fa-align-left"></i> Description</label>
            <textarea id="description" name="description" rows="5" required>${job.description}</textarea>

            <label class="form-label" for="location"><i class="fas fa-map-marker-alt"></i> Location</label>
            <select id="location" name="location" class="form-select" multiple="multiple" required>
                <c:forEach var="loc" items="${location}">
                    <option value="${loc}">${loc}</option>
                </c:forEach>
            </select>

            <label class="form-label" for="employmentType"><i class="fas fa-briefcase"></i> Employment Type</label>
            <select id="employmentType" name="employmentType" required>
                <c:forEach var="type" items="${employmentTypes}">
                    <option value="${type}" ${type == job.employmentType ? 'selected' : ''}>${type}</option>
                </c:forEach>
            </select>

            <label class="form-label" for="workMode"><i class="fas fa-laptop-house"></i> Work Mode</label>
            <select id="workMode" name="workMode" required>
                <c:forEach var="mode" items="${workModes}">
                    <option value="${mode}" ${mode == job.workMode ? 'selected' : ''}>${mode}</option>
                </c:forEach>
            </select>

            <label class="form-label" for="jobCategory"><i class="fas fa-tags"></i> Category</label>
            <select id="jobCategory" name="jobCategory" class="form-select" multiple="multiple" required>
                <c:forEach var="cat" items="${jobCategories}">
                    <option value="${cat}">${cat}</option>
                </c:forEach>
            </select>

            <label class="form-label" for="jobSector"><i class="fas fa-building"></i> Sector</label>
            <select id="jobSector" name="jobSector" required>
                <c:forEach var="sec" items="${jobSectors}">
                    <option value="${sec}" ${sec == job.jobSector ? 'selected' : ''}>${sec}</option>
                </c:forEach>
            </select>

            <label class="form-label" for="education"><i class="fas fa-graduation-cap"></i> Minimum Education Required</label>
            <select id="education" name="education">
                <c:forEach var="edu" items="${educationLevels}">
                    <option value="${edu}" ${edu == job.education ? 'selected' : ''}>${edu}</option>
                </c:forEach>
            </select>

            <label class="form-label" for="salaryMin"><i class="fas fa-rupee-sign"></i> Minimum Salary</label>
            <input type="number" id="salaryMin" name="salaryMin" step="0.01" value="${job.salaryMin}" />

            <label class="form-label" for="salaryMax"><i class="fas fa-rupee-sign"></i> Maximum Salary</label>
            <input type="number" id="salaryMax" name="salaryMax" step="0.01" value="${job.salaryMax}" />

            <label class="form-label" for="experienceRequired"><i class="fas fa-user-clock"></i> Experience Required (years)</label>
            <input type="number" id="experienceRequired" name="experienceRequired" value="${job.experienceRequired}" />

            <div class="checkbox-wrapper">
                <input type="checkbox" id="equityOffered" name="equityOffered" ${job.equityOffered ? 'checked' : ''} />
                <label for="equityOffered"><i class="fas fa-percent"></i> Equity Offered?</label>
            </div>

            <label class="form-label" for="skillRequirement"><i class="fas fa-tools"></i> Skills / Language Requirement</label>
            <select id="skillRequirement" name="skillRequirement" class="form-control" multiple="multiple"></select>

            <label class="form-label" for="status"><i class="fas fa-chart-line"></i> Job Status</label>
            <select id="status" name="status">
                <c:forEach var="stat" items="${statuses}">
                    <option value="${stat}" ${stat == job.status ? 'selected' : ''}>${stat.displayName}</option>
                </c:forEach>
            </select>

            <label class="form-label" for="expiryDate"><i class="fas fa-calendar-times"></i> Expiry Date</label>
            <input type="date" id="expiryDate" name="expiryDate" value="${job.expiryDate}" required />

            <div class="button-group">
                <button type="submit" class="btn-update"><i class="fas fa-save"></i> Update Job</button>
                <a href="${pageContext.request.contextPath}/jobs/delete/${job.id}" 
                   class="btn-delete"
                   onclick="return confirm('Are you sure you want to delete this job?');">
                   <i class="fas fa-trash-alt"></i> Delete Job
                </a>
            </div>
        </form>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
    $(document).ready(function () {
        $('#skillRequirement').select2({
            tags: true,
            tokenSeparators: [',', ' ']
        });
        $('#location').select2();
        $('#jobCategory').select2();

        var locStr = '${job.location}';
        if (locStr) {
            $('#location').val(locStr.split(',')).trigger('change');
        }
        var catStr = '${job.jobCategory}';
        if (catStr) {
            $('#jobCategory').val(catStr.split(',')).trigger('change');
        }
        var skillStr = '${job.skillRequirement}';
        if (skillStr) {
            var skills = skillStr.split(',');
            skills.forEach(function(skill) {
                skill = skill.trim();
                if(skill && $('#skillRequirement').find("option[value='" + skill + "']").length === 0) {
                    $('#skillRequirement').append(new Option(skill, skill, true, true));
                }
            });
            $('#skillRequirement').val(skills.map(s => s.trim())).trigger('change');
        }
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