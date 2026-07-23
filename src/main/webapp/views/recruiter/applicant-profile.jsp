<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Applicant Profile | SmartInterview</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap + Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/LineIcons.2.0.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/glightbox.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">

   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/applicantProfile.css">
   <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border-color: #e0e6ed;
            --white: #ffffff;
            --success: #19A77B;
            --danger: #ef4444;
            --warning: #f59e0b;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            min-height: 100vh;
            position: relative;
        }

        /* Animated background pattern */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.03) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.03) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: backgroundPulse 15s ease-in-out infinite;
        }

        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        /* Hero Section Override */
        .call-action {
            position: relative;
            background: var(--gradient-primary) url('${pageContext.request.contextPath}/resources/images/hero/cat-bg.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            overflow: hidden;
            border-radius: 0 0 30px 30px;
            box-shadow: var(--shadow-md);
            min-height: 350px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 40px 20px;
            margin-bottom: -60px;
        }

        .call-action::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(25, 167, 123, 0.85);
            z-index: 1;
        }

        .call-action .container {
            position: relative;
            z-index: 2;
        }

        .call-action .section-title p {
            color: rgba(255, 255, 255, 0.9) !important;
            font-size: 18px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 2px;
        }

        .call-action .section-title h2 {
            color: #fff !important;
            font-size: 42px;
            font-weight: 800;
            margin: 15px 0;
        }

        .call-action .section-title p:last-of-type {
            color: rgba(255, 255, 255, 0.8) !important;
            font-size: 16px;
            text-transform: none;
            letter-spacing: normal;
        }

        .call-action .btn-outline-light {
            border: 2px solid rgba(255, 255, 255, 0.8);
            color: #fff;
            padding: 12px 28px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .call-action .btn-outline-light:hover {
            background: #fff;
            color: var(--primary) !important;
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        .call-action .btn-light {
            background: #fff;
            color: var(--primary) !important;
            padding: 12px 28px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .call-action .btn-light:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Profile Header */
        .profile-header {
            background: var(--gradient-primary) url('${pageContext.request.contextPath}/resources/images/hero/cat-bg.jpg') no-repeat center center;
            background-size: cover;
            height: 120px;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: flex-end;
            padding-bottom: 0;
            border-radius: 20px 20px 0 0;
        }

        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(25, 167, 123, 0.7);
            border-radius: 20px 20px 0 0;
        }

        /* Profile Container */
        .profile-container {
            max-width: 900px;
            margin: 0 auto 60px;
            background: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow-lg);
            position: relative;
            z-index: 10;
            animation: fadeInUp 0.6s ease-out;
            border: 1px solid rgba(25, 167, 123, 0.1);
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .avatar {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            border: 5px solid var(--white);
            box-shadow: var(--shadow-lg);
            object-fit: cover;
            position: relative;
            z-index: 2;
            margin-bottom: -70px;
            background: var(--white);
        }

        .profile-body {
            padding: 90px 40px 40px;
            text-align: center;
        }

        .profile-body h2 {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        .profile-body p {
            color: var(--text-secondary);
            margin-bottom: 6px;
            font-size: 15px;
        }

        .badge-status {
            display: inline-block;
            padding: 8px 20px;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 16px 0 24px;
            background: var(--primary);
            color: white;
            box-shadow: var(--glow-primary);
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 16px;
            margin: 32px 0;
            padding: 24px;
            background: rgba(25, 167, 123, 0.03);
            border-radius: 16px;
            border: 1px solid rgba(25, 167, 123, 0.1);
        }

        .info-box {
            padding: 16px;
            background: var(--white);
            border-radius: 12px;
            border: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .info-box:hover {
            border-color: var(--primary);
            box-shadow: var(--shadow-sm);
            transform: translateY(-2px);
        }

        .info-box strong {
            display: block;
            color: var(--primary);
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
        }

        .info-box span {
            display: inline-block;
            background: rgba(25, 167, 123, 0.08);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            margin: 2px 4px 2px 0;
            color: var(--text-primary);
        }

        .action-buttons {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin: 32px 0;
        }

        .btn-primary {
            background: var(--gradient-primary);
            border: none;
            padding: 14px 32px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 15px;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
        }

        .video-resume {
            margin-top: 32px;
            padding: 24px;
            background: rgba(25, 167, 123, 0.03);
            border-radius: 16px;
            border: 1px solid rgba(25, 167, 123, 0.1);
        }

        .video-resume h5 {
            color: var(--primary);
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .video-resume h5 i {
            font-size: 20px;
        }

        .video-resume video {
            width: 100%;
            max-width: 600px;
            border-radius: 16px;
            box-shadow: var(--shadow-md);
            border: 2px solid rgba(25, 167, 123, 0.15);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .call-action {
                min-height: 300px;
                margin-bottom: -40px;
            }

            .call-action .section-title h2 {
                font-size: 32px;
            }

            .profile-body {
                padding: 80px 24px 32px;
            }

            .avatar {
                width: 120px;
                height: 120px;
            }

            .info-grid {
                grid-template-columns: 1fr;
                padding: 16px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn-primary {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .profile-body h2 {
                font-size: 24px;
            }

            .call-action .button {
                display: flex;
                flex-direction: column;
                gap: 12px;
            }
        }
    </style>
</head>

<body>

<!-- Hero Section -->
<section class="call-action overlay section py-5 mb-4">
    <div class="container">
        <div class="section-title">
            <p>Discover Applicant Insights</p>
            <h2>Your Candidate, Their Story</h2>
            <p>Explore detailed applicant information and make smarter hiring decisions.</p>
            <div class="button mt-4">
                <a href="${pageContext.request.contextPath}/recruiter/applicants/${application.job.id}" class="btn btn-outline-light">
                    <i class="bi bi-arrow-left-circle"></i> Back to Applicants
                </a>
                <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="btn btn-light">
                    <i class="bi bi-house-door"></i> Recruiter Dashboard
                </a>
            </div>
        </div>
    </div>
</section> 

<!-- Profile Card -->
<div class="profile-container" id="profile">
    <div class="profile-header">
        <img src="${pageContext.request.contextPath}${application.jobSeeker.profilePicture}" 
             alt="Profile Picture" 
             class="avatar"
             onerror="this.src='${pageContext.request.contextPath}/images/default-profile.png'">
    </div>

    <div class="profile-body">
        <h2>${application.jobSeeker.name}</h2>
        <p><i class="fas fa-envelope" style="color: var(--primary); margin-right: 8px;"></i>${application.jobSeeker.email}</p>
        <p><i class="fas fa-phone" style="color: var(--primary); margin-right: 8px;"></i>${application.jobSeeker.phone}</p>
        <div class="badge-status">
            <i class="fas fa-circle" style="font-size: 8px; margin-right: 8px;"></i>
            ${fn:replace(application.jobSeeker.accountStatus, '_', ' ')}
        </div>

        <div class="info-grid">
            <div class="info-box">
                <strong><i class="fas fa-map-marker-alt"></i> Location</strong>
                ${application.jobSeeker.location}
            </div>
            <div class="info-box">
                <strong><i class="fas fa-briefcase"></i> Experience</strong>
                ${application.jobSeeker.experience} years
            </div>
            <div class="info-box">
                <strong><i class="fas fa-venus-mars"></i> Gender</strong>
                ${application.jobSeeker.gender}
            </div>
            <div class="info-box">
                <strong><i class="fas fa-calendar"></i> Age</strong>
                ${application.jobSeeker.age}
            </div>
            <div class="info-box">
                <strong><i class="fas fa-code"></i> Skills</strong>
                <c:choose>
                    <c:when test="${not empty application.jobSeeker.skills}">
                        <c:forEach var="skill" items="${application.jobSeeker.skills}">
                            <span>${skill}</span>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <span style="color: var(--text-secondary);">No skills listed</span>
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="info-box">
                <strong><i class="fas fa-language"></i> Languages</strong>
                <c:choose>
                    <c:when test="${not empty application.jobSeeker.languagesKnown}">
                        <c:forEach var="language" items="${application.jobSeeker.languagesKnown}">
                            <span>${language}</span>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <span style="color: var(--text-secondary);">No languages listed</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="action-buttons">
            <c:if test="${not empty application.jobSeeker.resumeUploaded}">
                <a href="${pageContext.request.contextPath}${application.jobSeeker.resumeUploaded}" target="_blank" class="btn btn-primary">
                    <i class="fas fa-file-pdf"></i> View Resume
                </a>
            </c:if>
            <c:if test="${empty application.jobSeeker.resumeUploaded}">
                <span class="btn btn-primary" style="opacity: 0.5; cursor: not-allowed; background: #94a3b8;">
                    <i class="fas fa-file"></i> No Resume Uploaded
                </span>
            </c:if>
        </div>
       
        <!-- Video Resume Section (if available) -->
        <c:if test="${not empty videoResume}">
            <div class="video-resume">
                <h5><i class="fas fa-video"></i> Video Resume</h5>
                <video controls>
                    <source src="${pageContext.request.contextPath}${videoResume.filePath}" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
            </div>
        </c:if>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add fade-in animation to info boxes
    const infoBoxes = document.querySelectorAll('.info-box');
    infoBoxes.forEach((box, index) => {
        box.style.opacity = '0';
        box.style.transform = 'translateY(10px)';
        setTimeout(() => {
            box.style.transition = 'all 0.4s ease';
            box.style.opacity = '1';
            box.style.transform = 'translateY(0)';
        }, index * 50);
    });

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
                .stats-grid, .content-grid, .grid, .hr-stats-grid, .hr-content-grid, .profile-grid, .dashboard-grid {
                    grid-template-columns: 1fr !important;
                    display: grid !important; 
                }
                .top-bar {
                    flex-direction: column !important;
                    align-items: flex-start !important;
                    gap: 16px;
                }
                .chat-header {
                    flex-wrap: wrap;
                    gap: 12px;
                }
                .top-bar h1, .chat-header h3 {
                    font-size: 22px !important;
                    display: flex;
                    align-items: center;
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
                .chat-sidebar {
                    position: fixed !important;
                    transform: translateX(-100%);
                    transition: transform 0.3s;
                    z-index: 1000;
                }
                .chat-sidebar.active {
                    transform: translateX(0);
                }
                table:not(.table-responsive), table:not(.table-responsive) thead, table:not(.table-responsive) tbody, table:not(.table-responsive) th, table:not(.table-responsive) td, table:not(.table-responsive) tr { 
                    display: block; 
                }
                table:not(.table-responsive) thead tr { 
                    position: absolute;
                    top: -9999px;
                    left: -9999px;
                }
                table:not(.table-responsive) tr { border: 1px solid #e2e8f0; margin-bottom: 12px; border-radius: 8px; overflow:hidden; }
                table:not(.table-responsive) td { 
                    border: none;
                    border-bottom: 1px solid #f1f5f9; 
                    position: relative;
                    padding-left: 50% !important; 
                    text-align: right;
                    font-size: 14px;
                }
                table:not(.table-responsive) td:last-child {
                    border-bottom: none;
                }
                table:not(.table-responsive) td:before { 
                    position: absolute;
                    top: 50%;
                    transform: translateY(-50%);
                    left: 12px;
                    width: 45%; 
                    padding-right: 10px; 
                    white-space: nowrap;
                    content: attr(data-label);
                    font-weight: 600;
                    text-align: left;
                    color: #64748b;
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
        } else if (!document.querySelector('.mobile-menu-btn')) {
            heading = document.createElement('div');
            heading.style.padding = '10px';
            document.body.insertBefore(heading, document.body.firstChild);
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

            let touchstartX = 0;
            let touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { 
                touchendX = e.changedTouches[0].screenX; 
                if (touchendX < touchstartX - 50) closeSidebar(); 
                if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); 
            }, {passive: true});
            
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
    
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        rows.forEach(row => {
            Array.from(row.querySelectorAll('td')).forEach((td, index) => {
                if(headers[index]) {
                    td.setAttribute('data-label', headers[index]);
                }
            });
        });
    });
});
</script>
</body>
</html>
