<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>${jobSeeker.name} | Premium Profile - JobU Talent Hub</title>
    
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

        /* Page Header Premium */
        .page-header {
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
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

        .page-header h1 {
            font-size: 1.8rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .page-header p {
            font-size: 0.9rem;
            opacity: 0.85;
            position: relative;
            z-index: 1;
        }

        /* Profile Card Premium */
        .profile-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            padding: 2.5rem;
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.1);
            transition: var(--transition);
            margin-bottom: 2rem;
            animation: fadeInUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(40px) scale(0.96); }
            to { opacity: 1; transform: translateY(0) scale(1); }
        }

        .profile-card:hover {
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Profile Header */
        .profile-header {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-bottom: 2rem;
            padding-bottom: 2rem;
            border-bottom: 2px solid rgba(25,167,123,0.1);
        }

        .profile-avatar {
            width: 140px;
            height: 140px;
            border-radius: 35px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
            font-weight: 800;
            color: var(--primary);
            border: 3px solid rgba(25,167,123,0.2);
            overflow: hidden;
            flex-shrink: 0;
            transition: var(--transition);
        }

        .profile-avatar:hover {
            transform: scale(1.05);
            border-color: var(--primary);
            box-shadow: var(--shadow-md);
        }

        .profile-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .profile-info h2 {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.5rem;
            letter-spacing: -0.5px;
        }

        .profile-headline {
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-bottom: 1rem;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.4rem 1rem;
            border-radius: 40px;
            font-size: 0.75rem;
            font-weight: 700;
            background: rgba(25,167,123,0.12);
            color: var(--primary-dark);
            border: 1px solid rgba(25,167,123,0.2);
        }

        .profile-actions {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        /* Section Styles */
        .profile-section {
            margin-bottom: 2rem;
        }

        .section-title {
            font-size: 1.2rem;
            font-weight: 800;
            color: var(--bg-dark);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--primary);
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            color: var(--primary);
            font-size: 1.1rem;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1rem;
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

        .info-label {
            font-size: 0.7rem;
            font-weight: 700;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
            display: block;
        }

        .info-value {
            font-size: 0.9rem;
            font-weight: 600;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 0.6rem;
        }

        .info-value i {
            color: var(--primary);
            width: 20px;
            font-size: 0.85rem;
        }

        .info-value a {
            color: var(--text-dark);
            text-decoration: none;
            transition: var(--transition);
        }

        .info-value a:hover {
            color: var(--primary);
            text-decoration: underline;
        }

        /* Skills Container */
        .skills-container {
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .skill-pill {
            background: linear-gradient(135deg, rgba(25,167,123,0.1), rgba(59,196,154,0.05));
            color: var(--primary-dark);
            padding: 0.5rem 1.2rem;
            border-radius: 40px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            border: 1px solid rgba(25,167,123,0.15);
        }

        .skill-pill:hover {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 6px 14px rgba(25,167,123,0.3);
            border-color: transparent;
        }

        .skill-pill i {
            font-size: 0.75rem;
        }

        /* Documents Container */
        .documents-container {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .doc-link {
            background: white;
            border: 2px solid rgba(25,167,123,0.15);
            padding: 0.8rem 1.5rem;
            border-radius: 60px;
            font-weight: 600;
            color: var(--primary);
            text-decoration: none;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
        }

        .doc-link:hover {
            background: var(--primary);
            border-color: var(--primary);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.3);
            color: white;
        }

        .doc-link i {
            font-size: 1rem;
        }

        /* Meta Information */
        .meta-info {
            display: flex;
            gap: 2rem;
            padding-top: 1.5rem;
            border-top: 2px solid rgba(25,167,123,0.1);
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .meta-info i {
            color: var(--primary);
            margin-right: 0.5rem;
        }

        .meta-info strong {
            color: var(--text-dark);
        }

        /* Buttons */
        .btn-custom {
            padding: 0.7rem 1.5rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.85rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.6rem;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }

        .btn-primary-custom {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
        }

        .btn-primary-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
            color: white;
        }

        .btn-outline-custom {
            background: white;
            border: 2px solid rgba(25,167,123,0.2);
            color: var(--primary);
        }

        .btn-outline-custom:hover {
            background: rgba(25,167,123,0.08);
            border-color: var(--primary);
            transform: translateY(-2px);
            color: var(--primary-dark);
        }

        /* Responsive */
        @media (max-width: 991.98px) {
            .profile-header {
                flex-direction: column;
                text-align: center;
            }
            .profile-avatar {
                width: 120px;
                height: 120px;
                font-size: 2.5rem;
            }
            .info-grid {
                grid-template-columns: 1fr;
            }
            .profile-actions {
                justify-content: center;
            }
            .section-title {
                display: flex;
                justify-content: center;
            }
        }

        @media (max-width: 768px) {
            .page-header { padding: 1.5rem 0; }
            .page-header h1 { font-size: 1.5rem; }
            .profile-card { padding: 1.5rem; }
            .profile-info h2 { font-size: 1.5rem; text-align: center; }
            .profile-headline { text-align: center; }
        }

        @media (max-width: 576px) {
            .profile-actions { flex-direction: column; width: 100%; }
            .btn-custom { width: 100%; }
            .meta-info { flex-direction: column; gap: 0.75rem; }
            .doc-link { width: 100%; justify-content: center; }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection { background: var(--primary); color: white; }
    </style>
<jsp:include page="/views/commons/admin_shell_head.jsp" />
</head>
<body>

<jsp:include page="/views/commons/admin_shell_start.jsp">
  <jsp:param name="pageTitle" value="Job Seeker Profile"/>
  <jsp:param name="pageSubtitle" value="Profile details"/>
  <jsp:param name="activeNav" value="jobseekers"/>
</jsp:include>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <a href="${pageContext.request.contextPath}/allJobSeekers" style="display: inline-flex; align-items: center; gap: 0.5rem; color: white; text-decoration: none; font-size: 0.85rem; font-weight: 600; background: rgba(255,255,255,0.15); backdrop-filter: blur(8px); padding: 0.4rem 1rem; border-radius: 40px; margin-bottom: 0.75rem; transition: all 0.3s ease; border: 1px solid rgba(255,255,255,0.2);" onmouseover="this.style.background='rgba(255,255,255,0.25)'" onmouseout="this.style.background='rgba(255,255,255,0.15)'">
            <i class="fas fa-arrow-left"></i> Back to Job Seekers
        </a>
        <h1><i class="fas fa-user-circle me-2" style="color: var(--accent);"></i>Job Seeker Profile</h1>
        <p>Detailed profile information and documents</p>
    </div>
</div>

<div class="container">
    <div class="profile-card">
        <!-- Profile Header -->
        <div class="profile-header">
            <div class="profile-avatar">
                <c:choose>
                    <c:when test="${not empty jobSeeker.profilePicture}">
                        <img src="${jobSeeker.profilePicture}" 
                             alt="${jobSeeker.name}"
                             onerror="this.style.display='none'; this.parentElement.innerHTML='${fn:substring(jobSeeker.name, 0, 1)}';">
                    </c:when>
                    <c:otherwise>
                        ${fn:substring(jobSeeker.name, 0, 1)}
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="profile-info flex-grow-1">
                <h2>${jobSeeker.name}</h2>
                <c:if test="${not empty jobSeeker.resumeHeadline}">
                    <div class="profile-headline">${jobSeeker.resumeHeadline}</div>
                </c:if>
                <c:if test="${not empty jobSeeker.accountStatus}">
                    <span class="status-badge">
                        <i class="fas fa-circle"></i>
                        ${jobSeeker.accountStatus}
                    </span>
                </c:if>
                <div class="profile-actions">
                    <c:if test="${not empty jobSeeker.resumeUploaded}">
                        <a href="${jobSeeker.resumeUploaded}" 
                           target="_blank" 
                           class="btn-custom btn-outline-custom">
                            <i class="fas fa-file-pdf"></i>
                            View Resume
                        </a>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Basic Details Section -->
        <div class="profile-section">
            <h3 class="section-title">
                <i class="fas fa-user"></i>
                Basic Details
            </h3>
            <div class="info-grid">
                <c:if test="${not empty jobSeeker.email}">
                    <div class="info-item">
                        <span class="info-label">Email Address</span>
                        <span class="info-value">
                            <i class="fas fa-envelope"></i>
                            <a href="mailto:${jobSeeker.email}">${jobSeeker.email}</a>
                        </span>
                    </div>
                </c:if>

                <c:if test="${not empty jobSeeker.phone}">
                    <div class="info-item">
                        <span class="info-label">Phone Number</span>
                        <span class="info-value">
                            <i class="fas fa-phone"></i>
                            ${jobSeeker.phone}
                        </span>
                    </div>
                </c:if>

                <c:if test="${not empty jobSeeker.location}">
                    <div class="info-item">
                        <span class="info-label">Location</span>
                        <span class="info-value">
                            <i class="fas fa-map-marker-alt"></i>
                            ${jobSeeker.location}
                        </span>
                    </div>
                </c:if>

                <c:if test="${not empty jobSeeker.gender}">
                    <div class="info-item">
                        <span class="info-label">Gender</span>
                        <span class="info-value">
                            <i class="fas fa-venus-mars"></i>
                            ${jobSeeker.gender}
                        </span>
                    </div>
                </c:if>

                <c:if test="${not empty jobSeeker.experience}">
                    <div class="info-item">
                        <span class="info-label">Experience</span>
                        <span class="info-value">
                            <i class="fas fa-briefcase"></i>
                            ${jobSeeker.experience} years
                        </span>
                    </div>
                </c:if>

                <c:if test="${not empty jobSeeker.age}">
                    <div class="info-item">
                        <span class="info-label">Age</span>
                        <span class="info-value">
                            <i class="fas fa-birthday-cake"></i>
                            ${jobSeeker.age} years
                        </span>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Skills Section -->
        <c:if test="${not empty jobSeeker.skills && fn:length(jobSeeker.skills) > 0}">
            <div class="profile-section">
                <h3 class="section-title">
                    <i class="fas fa-code"></i>
                    Skills
                </h3>
                <div class="skills-container">
                    <c:forEach var="skill" items="${jobSeeker.skills}">
                        <span class="skill-pill">
                            <i class="fas fa-check-circle"></i>
                            ${skill}
                        </span>
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Documents Section -->
        <c:if test="${not empty jobSeeker.resumeUploaded or not empty jobSeeker.videoResumeUrl or not empty jobSeeker.identityDocument}">
            <div class="profile-section">
                <h3 class="section-title">
                    <i class="fas fa-folder-open"></i>
                    Documents
                </h3>
                <div class="documents-container">
                    <c:if test="${not empty jobSeeker.resumeUploaded}">
                        <a href="${jobSeeker.resumeUploaded}" 
                           target="_blank" 
                           class="doc-link">
                            <i class="fas fa-file-pdf"></i>
                            <span>Resume</span>
                        </a>
                    </c:if>
                    <c:if test="${not empty jobSeeker.videoResumeUrl}">
                        <a href="${jobSeeker.videoResumeUrl}" 
                           target="_blank" 
                           class="doc-link">
                            <i class="fas fa-video"></i>
                            <span>Video Resume</span>
                        </a>
                    </c:if>
                    <c:if test="${not empty jobSeeker.identityDocument}">
                        <a href="${jobSeeker.identityDocument}" 
                           target="_blank" 
                           class="doc-link">
                            <i class="fas fa-id-card"></i>
                            <span>ID Proof</span>
                        </a>
                    </c:if>
                </div>
            </div>
        </c:if>

        <!-- Meta Information -->
        <div class="meta-info">
            <c:if test="${not empty jobSeeker.createdAt}">
                <div>
                    <i class="fas fa-calendar-plus"></i>
                    Created: <strong>${jobSeeker.createdAt}</strong>
                </div>
            </c:if>
            <c:if test="${not empty jobSeeker.updatedAt}">
                <div>
                    <i class="fas fa-calendar-check"></i>
                    Updated: <strong>${jobSeeker.updatedAt}</strong>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

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
<jsp:include page="/views/commons/admin_shell_end.jsp" />
</body>
</html>