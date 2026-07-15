<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Applicants | SmartInterview</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/LineIcons.2.0.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/glightbox.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/applicantlist.css">
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



        /* Hero Section */
        .call-action {
            position: relative;
            background: var(--gradient-primary) url('${pageContext.request.contextPath}/resources/images/hero/cat-bg.jpg') no-repeat center center;
            background-size: cover;
            color: #fff;
            overflow: hidden;
            border-radius: 0 0 30px 30px;
            box-shadow: var(--shadow-md);
            margin-bottom: 40px;
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

        .call-action .btn-primary {
            background: #fff;
            color: var(--primary) !important;
            border: none;
            padding: 12px 28px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .call-action .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
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
        }

        /* Filter Form */
        .filter-form {
            background: var(--white);
            padding: 28px 32px;
            border-radius: 20px;
            box-shadow: var(--shadow-md);
            border: 1px solid rgba(25, 167, 123, 0.1);
            margin-bottom: 32px;
        }

        .filter-form .form-label {
            font-weight: 600;
            color: var(--text-primary);
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .filter-form .form-select,
        .filter-form .form-control {
            border: 2px solid var(--border-color);
            border-radius: 10px;
            padding: 10px 14px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .filter-form .form-select:focus,
        .filter-form .form-control:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
            outline: none;
        }

        .filter-form .btn-primary {
            background: var(--gradient-primary);
            border: none;
            padding: 12px 24px;
            border-radius: 30px;
            font-weight: 600;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .filter-form .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .filter-form .btn-outline-primary {
            border: 2px solid var(--primary);
            color: var(--primary);
            padding: 12px 24px;
            border-radius: 30px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .filter-form .btn-outline-primary:hover {
            background: var(--primary);
            color: white;
        }

        .form-check-input:checked {
            background-color: var(--primary);
            border-color: var(--primary);
        }

        /* Table Styling */
        .table {
            background: var(--white);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: var(--shadow-md);
            border: 1px solid rgba(25, 167, 123, 0.1);
            margin-bottom: 40px;
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
            padding: 16px;
            border: none;
        }

        .table tbody tr {
            border-bottom: 1px solid var(--border-color);
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(25, 167, 123, 0.03);
        }

        .table tbody td {
            padding: 20px 16px;
            vertical-align: middle;
            color: var(--text-primary);
        }

        .table .rounded-circle {
            border: 3px solid var(--primary);
            box-shadow: var(--shadow-sm);
            object-fit: cover;
        }

        .table .btn-primary {
            background: var(--gradient-primary);
            border: none;
            padding: 8px 16px;
            border-radius: 30px;
            font-weight: 500;
            font-size: 13px;
            color: white;
            transition: all 0.3s ease;
        }

        .table .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        .table .btn-sm {
            padding: 6px 12px;
            font-size: 12px;
        }

        .table .form-select-sm {
            border-radius: 8px;
            border: 2px solid var(--border-color);
            font-size: 13px;
            padding: 6px 10px;
        }

        .table .form-select-sm:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        /* Status Badges */
        .badge-score {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-fail {
            background: rgba(239, 68, 68, 0.12);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .badge-bronze {
            background: rgba(205, 127, 50, 0.12);
            color: #cd7f32;
            border: 1px solid rgba(205, 127, 50, 0.3);
        }

        .badge-silver {
            background: rgba(192, 192, 192, 0.15);
            color: #a0a0a0;
            border: 1px solid rgba(192, 192, 192, 0.4);
        }

        .badge-gold {
            background: rgba(255, 215, 0, 0.12);
            color: #d4a017;
            border: 1px solid rgba(255, 215, 0, 0.3);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .call-action .section-title h2 {
                font-size: 32px;
            }

            .filter-form {
                padding: 20px;
            }

            .table {
                font-size: 13px;
            }

            .table .rounded-circle {
                width: 50px !important;
                height: 50px !important;
            }
        }

        @media (max-width: 576px) {
            .call-action {
                border-radius: 0 0 20px 20px;
            }
        }
    </style>
</head>
<body>

<!-- Hero Section -->
<section class="call-action overlay section">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 offset-lg-2 col-12">
                <div class="inner text-center">
                    <div class="section-title">
                       <p>Accelerate Your Hiring Process</p>
                        <h2>Connect with Top Talent Effortlessly</h2>
                        <p>Simplify your recruitment journey by accessing a pool of qualified candidates, managing applications seamlessly, and making informed hiring decisions.</p>
                        <div class="button mt-4 d-flex justify-content-center align-items-center flex-wrap gap-3">
                            <a href="${pageContext.request.contextPath}/applications/recruiter/download-applicants/${jobId}" class="btn btn-primary d-flex align-items-center gap-2 m-0">
                                <i class="bi bi-download"></i> Download Excel
                            </a>
                            <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="btn btn-outline-light d-flex align-items-center gap-2 m-0">
                                <i class="bi bi-house-door"></i> Back to Dashboard
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<br>
<br>

<!-- Filter Form -->
<div class="container">
    <form class="row g-3 align-items-end filter-form mb-4" method="get" action="${pageContext.request.contextPath}/recruiter/applicants/${jobId}">

        <div class="col-md-2">
            <label class="form-label"><i class="fas fa-tag"></i> Status</label>
            <select name="status" class="form-select">
                <option value="">All</option>
                <option value="VIEWED_BY_RECRUITER" ${param.status == 'VIEWED_BY_RECRUITER' ? 'selected' : ''}>Viewed</option>
                <option value="SHORTLISTED" ${param.status == 'SHORTLISTED' ? 'selected' : ''}>Shortlisted</option>
                <option value="INTERVIEW_SCHEDULED" ${param.status == 'INTERVIEW_SCHEDULED' ? 'selected' : ''}>Interview</option>
                <option value="SELECTED" ${param.status == 'SELECTED' ? 'selected' : ''}>Selected</option>
                <option value="REJECTED" ${param.status == 'REJECTED' ? 'selected' : ''}>Rejected</option>
            </select>
        </div>

        <div class="col-md-2">
            <label class="form-label"><i class="fas fa-map-marker-alt"></i> Location</label>
            <select name="location" class="form-select">
                <option value="">All</option>
                <c:forEach var="loc" items="${location}">
                    <option value="${loc}" ${param.location == loc.name() ? 'selected' : ''}>${loc}</option>
                </c:forEach>
            </select>
        </div>

        <div class="col-md-2">
            <label class="form-label"><i class="fas fa-briefcase"></i> Experience</label>
            <input type="number" name="experience" class="form-control" placeholder="Years" value="${param.experience}" />
        </div>

        <div class="col-md-3">
            <label class="form-label"><i class="fas fa-code"></i> Skills</label>
            <input type="text" name="skills" id="skills" class="form-control" placeholder="Comma-separated" value="${param.skills}" />
        </div>

        <div class="col-md-2" id="matchAllSkillsContainer" style="${not empty param.skills ? '' : 'display:none;'}">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" name="matchAllSkills" id="matchAllSkills" ${param.matchAllSkills == 'on' ? 'checked' : ''}>
                <label class="form-check-label" for="matchAllSkills">Match All</label>
            </div>
        </div>
        
        <div class="col-md-2">
            <label class="form-label"><i class="fas fa-medal"></i> Badge</label>
            <select name="badge" class="form-select">
                <option value="">All</option>
                <option value="Fail" ${param.badge == 'Fail' ? 'selected' : ''}>❌ Fail</option>
                <option value="Bronze" ${param.badge == 'Bronze' ? 'selected' : ''}>🥉 Bronze</option>
                <option value="Silver" ${param.badge == 'Silver' ? 'selected' : ''}>🥈 Silver</option>
                <option value="Gold" ${param.badge == 'Gold' ? 'selected' : ''}>🥇 Gold</option>
            </select>
        </div>

        <div class="col-md-2">
            <label class="form-label"><i class="fas fa-chart-line"></i> Min Score (%)</label>
            <input type="number" name="minScore" class="form-control" value="${param.minScore}" min="0" max="100" />
        </div>

        <div class="col-md-2">
            <label class="form-label"><i class="fas fa-chart-bar"></i> Max Score (%)</label>
            <input type="number" name="maxScore" class="form-control" value="${param.maxScore}" min="0" max="100" />
        </div>

        <div class="col-md-12 d-flex gap-2 flex-wrap">
            <button type="submit" class="btn btn-primary"><i class="fas fa-filter"></i> Apply Filters</button>
            <a href="${pageContext.request.contextPath}/recruiter/applicants/${jobId}" class="btn btn-outline-primary"><i class="fas fa-times"></i> Clear</a>
            <a href="${pageContext.request.contextPath}/applications/recruiter/download-applicants/${jobId}" class="btn btn-primary"><i class="fas fa-download"></i> Download Excel</a>
        </div>
    </form>
</div>
<br>
<!-- Applicants Table -->
<div class="container">
    <table class="table table-bordered">
        <thead>
            <tr>
                <th><i class="fas fa-user"></i> Candidate</th>
                <th><i class="fas fa-info-circle"></i> Status</th>
                <th><i class="fas fa-chart-bar"></i> Assessment Score</th>
                <th><i class="fas fa-eye"></i> View Profile</th>
                <th><i class="fas fa-edit"></i> Update Status</th>
            </tr>
        </thead>
       <tbody>
<c:forEach var="wrapper" items="${applications}">
  <c:set var="app" value="${wrapper.application}" />
  <c:set var="result" value="${wrapper.latestResult}" />

  <tr>
    <td>
      <div class="d-flex align-items-center">
        <img src="${pageContext.request.contextPath}${app.jobSeeker.profilePicture}" 
             alt="Profile" class="rounded-circle me-3" width="60" height="60"
             onerror="this.src='${pageContext.request.contextPath}/images/default-profile.png'">
        <div>
          <strong>${app.jobSeeker.name}</strong><br>
          <small class="text-muted"><i class="fas fa-envelope"></i> ${app.jobSeeker.email}</small><br>
          <small><i class="fas fa-map-pin"></i> ${app.jobSeeker.location} | <i class="fas fa-briefcase"></i> ${app.jobSeeker.experience} yrs | <i class="fas fa-calendar"></i> Age: ${app.jobSeeker.age}</small><br>
          <small><span class="badge-status" style="background: var(--primary); color: white; padding: 2px 10px; border-radius: 20px; font-size: 11px;">${fn:replace(app.jobSeeker.accountStatus, '_', ' ')}</span></small>
        </div>
      </div>
    </td>

    <td>
        <span style="font-weight: 500;">${app.status}</span>
    </td>

    <td>
      <c:choose>
        <c:when test="${result != null}">
          <div>
            <strong>Score: ${result.correctAnswers}/${result.totalQuestions}</strong><br>
            <small><i class="far fa-clock"></i> ${result.submittedAt}</small><br>
            <small>
              <c:set var="percentage" value="${(result.correctAnswers * 100) / result.totalQuestions}" />
              <c:choose>
                <c:when test="${percentage lt 60}">
                    <span class="badge-score badge-fail"><i class="fas fa-times-circle"></i> Fail</span>
                </c:when>
                <c:when test="${percentage lt 70}">
                    <span class="badge-score badge-bronze"><i class="fas fa-medal"></i> Bronze</span>
                </c:when>
                <c:when test="${percentage lt 85}">
                    <span class="badge-score badge-silver"><i class="fas fa-medal"></i> Silver</span>
                </c:when>
                <c:otherwise>
                    <span class="badge-score badge-gold"><i class="fas fa-trophy"></i> Gold</span>
                </c:otherwise>
              </c:choose>
            </small>
          </div>
        </c:when>
        <c:otherwise>
          <em class="text-muted"><i class="fas fa-minus"></i> No test submitted</em>
        </c:otherwise>
      </c:choose>
    </td>

    <td>
      <a href="${pageContext.request.contextPath}/recruiter/applicant/${app.id}/profile" class="btn btn-primary">
        <i class="bi bi-person-fill"></i> View
      </a>
    </td>

    <td>
      <form method="post" action="${pageContext.request.contextPath}/recruiter/applicant/${app.id}/status" onsubmit="return validateForm(this)">
        <div class="d-flex align-items-center gap-2">
          <select name="status" onchange="handleStatusChange(this, ${app.id})"
                  class="form-select form-select-sm" id="status-${app.id}">
            <option value="">Change Status</option>
            <option value="VIEWED_BY_RECRUITER">Viewed</option>
            <option value="SHORTLISTED">Shortlist</option>
            <option value="SCHEDULE_ASSESSMENT">Schedule Assessment</option>
            <option value="INTERVIEW_SCHEDULED">Schedule Interview</option>
            <option value="SELECTED">Select</option>
            <option value="REJECTED">Reject</option>
          </select>
          <div id="interviewDateContainer-${app.id}" style="display:none;">
            <input type="datetime-local" name="interviewDate" class="form-control form-control-sm" />
          </div>
          <button type="submit" class="btn btn-sm btn-primary">
            <i class="bi bi-check2-circle"></i> Update
          </button>
        </div>
      </form>
    </td>
  </tr>
</c:forEach>

</tbody>
    </table>
</div>

<!-- Scripts -->
<script>
    function handleStatusChange(select, id) {
        const container = document.getElementById('interviewDateContainer-' + id);
        container.style.display = select.value === 'INTERVIEW_SCHEDULED' ? 'block' : 'none';
    }

    function validateForm(form) {
        const status = form.querySelector('select[name="status"]').value;
        if (status === 'INTERVIEW_SCHEDULED') {
            const dateInput = form.querySelector('input[name="interviewDate"]');
            if (!dateInput.value) {
                alert("Please provide an interview date.");
                return false;
            }
        }
        return true;
    }

    document.getElementById('skills').addEventListener('input', function () {
        document.getElementById('matchAllSkillsContainer').style.display = this.value.trim() !== '' ? 'flex' : 'none';
    });
</script>

<script>
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
