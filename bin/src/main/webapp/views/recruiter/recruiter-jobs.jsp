<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Your Posted Jobs | SmartInterview</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Bootstrap & Fonts -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/LineIcons.2.0.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/glightbox.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recruiter-jobs.css">

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
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
            --context-path: '${pageContext.request.contextPath}';
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: var(--text-primary);
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

        /* Hero Section */
        .call-action {
            position: relative;
            background: var(--gradient-primary) url('${pageContext.request.contextPath}/resources/images/hero/cat-bg.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            overflow: hidden;
            padding: 60px 0;
            margin-bottom: 40px;
            border-radius: 0 0 30px 30px;
            box-shadow: var(--shadow-md);
            text-align: center;
        }

        .call-action::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(25, 167, 123, 0.85);
        }

        .call-action .container {
            position: relative;
            z-index: 2;
        }

        .call-action span {
            display: inline-block;
            color: rgba(255, 255, 255, 0.9) !important;
            font-size: 18px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 2px;
            margin-bottom: 8px;
        }

        .call-action h2 {
            color: #fff !important;
            font-size: 42px;
            font-weight: 800;
            margin: 10px 0 16px;
        }

        .call-action p {
            color: rgba(255, 255, 255, 0.9) !important;
            font-size: 16px;
            margin-bottom: 24px;
        }

        .call-action .btn-outline-light {
            border: 2px solid rgba(255, 255, 255, 0.8);
            color: #fff;
            padding: 12px 28px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .call-action .btn-outline-light:hover {
            background: #fff;
            color: var(--primary);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Content Section */
        .content {
            position: relative;
            z-index: 1;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 24px 60px;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Stats Bar */
        .stats-bar {
            display: flex;
            gap: 16px;
            margin-bottom: 28px;
        }

        .stat-pill {
            background: var(--white);
            border: 1px solid rgba(25, 167, 123, 0.15);
            border-radius: 40px;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: var(--shadow-sm);
        }

        .stat-pill i {
            color: var(--primary);
        }

        .stat-pill .count {
            background: var(--gradient-primary);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            margin-left: 8px;
        }

        /* Section Title */
        .section-title-text {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-title-text i {
            color: var(--primary);
        }

        .table {
            background: var(--white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            border: 1px solid rgba(25, 167, 123, 0.1);
        }

        .table thead {
            background: var(--gradient-primary);
        }

        .table thead th {
            color: white;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 16px 20px;
            border: none;
        }

        .table thead th i {
            margin-right: 8px;
        }

        .table tbody td {
            padding: 20px;
            vertical-align: middle;
            color: var(--text-primary);
            border-bottom: 1px solid var(--border-color);
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(25, 167, 123, 0.03);
        }

        .job-title-cell {
            font-weight: 600;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .job-title-cell i {
            color: var(--primary);
            font-size: 20px;
        }

        .btn-primary {
            background: var(--gradient-primary);
            border: none;
            padding: 10px 20px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 14px;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
        }

        .candidate-count {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(25, 167, 123, 0.08);
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 13px;
            color: var(--primary);
            font-weight: 600;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            background: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25, 167, 123, 0.1);
        }

        .empty-state i {
            font-size: 56px;
            color: var(--primary);
            opacity: 0.3;
            margin-bottom: 20px;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .empty-state h4 {
            color: var(--text-primary);
            font-weight: 700;
            margin-bottom: 8px;
        }

        .empty-state p {
            color: var(--text-secondary);
        }

        @media (max-width: 768px) {
            .call-action h2 {
                font-size: 32px;
            }

            .call-action {
                padding: 40px 0;
            }

            .content {
                padding: 0 16px 40px;
            }

            .stats-bar {
                flex-direction: column;
            }

            .table thead {
                display: none;
            }

            .table tbody td {
                display: block;
                padding: 12px 16px;
                text-align: left;
            }

            .table tbody tr {
                display: block;
                margin-bottom: 16px;
                border-radius: 12px;
                border: 1px solid var(--border-color);
            }
        }
    </style>
</head>

<body>

<!-- Hero Section -->
<section class="call-action">
    <div class="container">
        <span>Manage Your Jobs Efficiently</span>
        <h2>Your Posted Jobs</h2>
        <p>Track your job listings, view candidates, and manage your hiring process all in one place.</p>
        <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="btn-outline-light">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</section>

<!-- Main Content -->
<div class="content">
    <!-- Stats Bar -->
    <c:if test="${not empty jobs}">
        <div class="stats-bar">
            <div class="stat-pill">
                <i class="fas fa-briefcase"></i>
                <span>Total Jobs Posted <span class="count">${fn:length(jobs)}</span></span>
            </div>
        </div>
    </c:if>

    <!-- Filter Toggle -->
    <div class="d-flex justify-content-center mb-5">
        <ul class="nav nav-pills custom-pills" id="jobFilterTab" role="tablist">
            <li class="nav-item">
                <button class="nav-link active" id="all-tab" data-filter="all" type="button">All Listings</button>
            </li>
            <li class="nav-item">
                <button class="nav-link" id="jobs-tab" data-filter="job" type="button">Jobs Only</button>
            </li>
            <li class="nav-item">
                <button class="nav-link" id="internships-tab" data-filter="internship" type="button">Internships Only</button>
            </li>
        </ul>
    </div>

    <style>
        .custom-pills {
            background: rgba(25, 167, 123, 0.05);
            padding: 8px;
            border-radius: 50px;
            border: 1px solid rgba(25, 167, 123, 0.1);
        }
        .custom-pills .nav-link {
            border-radius: 40px;
            padding: 10px 25px;
            font-weight: 600;
            color: var(--text-dark);
            transition: all 0.3s ease;
        }
        .custom-pills .nav-link.active {
            background: var(--gradient-primary) !important;
            color: white !important;
            box-shadow: 0 4px 15px rgba(25, 167, 123, 0.3);
        }
        .table tr.hidden {
            display: none !important;
        }
    </style>

    <c:choose>
        <c:when test="${empty jobs}">
            <div class="empty-state">
                <i class="fas fa-briefcase"></i>
                <h4>No Jobs Posted Yet</h4>
                <p>Start posting jobs to attract top talent!</p>
                <a href="${pageContext.request.contextPath}/jobs/post/${companyId}" class="btn btn-primary mt-3">
                    <i class="fas fa-plus-circle"></i> Post Your First Job
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="section-title-text">
                <i class="fas fa-list-ul"></i> <span id="section-title-label">Job Listings</span>
            </div>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th><i class="fas fa-briefcase"></i> Job Title</th>
                            <th><i class="fas fa-users"></i> Candidates</th>
                            <th><i class="fas fa-cog"></i> Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="job" items="${jobs}" varStatus="status">
                            <tr class="job-row" data-type="${job.employmentType == 'INTERNSHIP' ? 'internship' : 'job'}" style="animation: fadeInUp 0.4s ease-out; animation-delay: ${status.index * 0.05}s;">
                                <td>
                                    <div class="job-title-cell">
                                        <i class="fas fa-file-alt"></i>
                                        ${job.title}
                                    </div>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${job.applicantCount != null && job.applicantCount > 0}">
                                            <span class="candidate-count">
                                                <i class="fas fa-user-check"></i>
                                                ${job.applicantCount} Candidate${job.applicantCount > 1 ? 's' : ''}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="candidate-count" style="background: rgba(239, 68, 68, 0.08); color: var(--danger);">
                                                <i class="fas fa-user-slash"></i>
                                                No candidates yet
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/recruiter/applicants/${job.id}" class="btn btn-primary">
                                        <i class="fas fa-eye"></i> View Candidates
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Job Filtering Logic
    const filterButtons = document.querySelectorAll('#jobFilterTab .nav-link');
    const jobRows = document.querySelectorAll('.job-row');
    const titleLabel = document.getElementById('section-title-label');

    filterButtons.forEach(button => {
        button.addEventListener('click', () => {
            filterButtons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            const filter = button.getAttribute('data-filter');
            
            // Update title
            if (filter === 'job') titleLabel.textContent = 'Job Listings';
            else if (filter === 'internship') titleLabel.textContent = 'Internship Listings';
            else titleLabel.textContent = 'All Listings';

            jobRows.forEach(row => {
                const type = row.getAttribute('data-type');
                if (filter === 'all' || type === filter) {
                    row.classList.remove('hidden');
                } else {
                    row.classList.add('hidden');
                }
            });
        });
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