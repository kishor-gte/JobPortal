<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>JobU Admin Dashboard | Premium Control Center</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/css/mobile-responsive.css" rel="stylesheet">

<style>
:root {
  --primary: #19A77B;
  --primary-dark: #148F69;
  --primary-light: #3BC49A;
  --accent: #3BC49A;
  --bg-dark: #2E3E41;
  --success: #19A77B;
  --success-dark: #148F69;
  --warning: #f59e0b;
  --warning-dark: #d97706;
  --danger: #ef4444;
  --danger-dark: #dc2626;
  --info: #06b6d4;
  --info-dark: #0891b2;
  --bg-light: #f0f7f4;
  --text-dark: #1e2a2e;
  --text-muted: #5b7c6e;
  --border: #e2ede7;
  --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
  --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
  --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
  --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
  --radius-sm: 12px;
  --radius-md: 16px;
  --radius-lg: 24px;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #e0ece6 100%);
  color: var(--text-dark);
  line-height: 1.6;
}

.stats-row {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1rem;
  margin-bottom: 1.75rem;
}

.stat-card {
  background: rgba(255, 255, 255, 0.97);
  border-radius: var(--radius-md);
  padding: 1.25rem 1.35rem;
  box-shadow: var(--shadow-sm);
  transition: var(--transition);
  border-top: 4px solid var(--primary);
}

.stat-card-link { text-decoration: none; color: inherit; display: block; }
.stat-card-link:hover { text-decoration: none; color: inherit; }
.stat-card:hover { transform: translateY(-4px); box-shadow: var(--shadow-lg); }
.stat-card.success { border-top-color: var(--success); }
.stat-card.warning { border-top-color: var(--warning); }
.stat-card.danger { border-top-color: var(--danger); }
.stat-card.info { border-top-color: var(--info); }

.stat-card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.stat-icon {
  width: 52px; height: 52px;
  border-radius: var(--radius-sm);
  display: flex; align-items: center; justify-content: center;
  font-size: 1.35rem; color: white;
  background: linear-gradient(135deg, var(--primary), var(--primary-light));
  flex-shrink: 0;
}

.stat-card.success .stat-icon { background: linear-gradient(135deg, var(--success), var(--success-dark)); }
.stat-card.warning .stat-icon { background: linear-gradient(135deg, var(--warning), var(--warning-dark)); }
.stat-card.danger .stat-icon { background: linear-gradient(135deg, var(--danger), var(--danger-dark)); }
.stat-card.info .stat-icon { background: linear-gradient(135deg, var(--info), var(--info-dark)); }

.stat-value {
  font-size: 1.85rem; font-weight: 800;
  background: linear-gradient(135deg, var(--text-dark), var(--primary));
  -webkit-background-clip: text; background-clip: text; color: transparent;
  line-height: 1.2; margin-bottom: 0.2rem;
}

.stat-label {
  font-size: 0.72rem; color: var(--text-muted); font-weight: 600;
  text-transform: uppercase; letter-spacing: 0.7px;
}

.section-title {
  font-size: 1.25rem; font-weight: 800; color: var(--text-dark);
  margin-bottom: 1rem; padding-bottom: 0.5rem;
  border-bottom: 3px solid var(--primary); display: inline-block;
}

.hr-stats-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 16px;
  margin-bottom: 1.75rem;
}

.hr-stat-card {
  background: rgba(255, 255, 255, 0.95);
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  padding: 1.1rem;
  transition: var(--transition);
  box-shadow: var(--shadow-sm);
}

.hr-stat-card:hover {
  transform: translateY(-3px);
  box-shadow: var(--shadow-md);
  border-color: var(--primary);
}

.hr-stat-icon {
  width: 42px; height: 42px; border-radius: 10px;
  display: flex; align-items: center; justify-content: center;
  margin-bottom: 10px; font-size: 1.15rem;
}

.hr-stat-icon.orange { background: rgba(249, 115, 22, 0.15); color: #f97316; }
.hr-stat-icon.blue { background: rgba(59, 130, 246, 0.15); color: #3b82f6; }
.hr-stat-icon.green { background: rgba(25, 167, 123, 0.15); color: #19A77B; }
.hr-stat-icon.purple { background: rgba(139, 92, 246, 0.15); color: #8b5cf6; }
.hr-stat-icon.cyan { background: rgba(6, 182, 212, 0.15); color: #06b6d4; }
.hr-stat-icon.yellow { background: rgba(234, 179, 8, 0.15); color: #eab308; }

.hr-stat-value { font-size: 1.45rem; font-weight: 800; color: var(--text-dark); margin-bottom: 2px; }
.hr-stat-label { font-size: 0.68rem; color: var(--text-muted); font-weight: 600; }

.hr-content-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 1.25rem;
  margin-bottom: 1.25rem;
}

.hr-card {
  background: rgba(255, 255, 255, 0.96);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 1.25rem;
  box-shadow: var(--shadow-md);
}

.hr-card-header {
  display: flex; justify-content: space-between; align-items: center;
  margin-bottom: 1.15rem; padding-bottom: 0.65rem;
  border-bottom: 2px solid rgba(25,167,123,0.12);
}

.hr-card-header h3 {
  font-size: 0.95rem; font-weight: 700; color: var(--text-dark);
  display: flex; align-items: center; gap: 8px; margin: 0;
}

.hr-card-header a {
  color: var(--primary); text-decoration: none; font-size: 0.72rem; font-weight: 600;
  padding: 4px 10px; border-radius: 20px; background: rgba(25,167,123,0.08);
}

.hr-card-header a:hover { background: var(--primary); color: white; text-decoration: none; }

.hr-user-item {
  display: flex; justify-content: space-between; align-items: center;
  padding: 0.65rem; background: var(--bg-light); border-radius: 10px; margin-bottom: 6px;
}

.hr-user-info { display: flex; align-items: center; gap: 10px; flex: 1; min-width: 0; }

.hr-user-avatar {
  width: 36px; height: 36px; border-radius: 10px;
  display: flex; align-items: center; justify-content: center;
  font-size: 0.85rem; font-weight: 700; color: white; flex-shrink: 0;
}

.hr-user-avatar.admin { background: linear-gradient(135deg, #f97316, #ef4444); }
.hr-user-avatar.student { background: linear-gradient(135deg, #6366f1, #8b5cf6); }
.hr-user-avatar.interviewer { background: linear-gradient(135deg, #19A77B, #148F69); }
.hr-user-avatar.company { background: linear-gradient(135deg, #19A77B, #148F69); }

.hr-user-details { flex: 1; min-width: 0; }
.hr-user-name {
  font-size: 0.82rem; font-weight: 600; color: var(--text-dark); display: block;
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.hr-user-meta {
  font-size: 0.68rem; color: var(--text-muted);
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}

.hr-user-role {
  font-size: 0.68rem; padding: 3px 10px; border-radius: 20px;
  font-weight: 600; white-space: nowrap; flex-shrink: 0;
}

.hr-role-admin { background: rgba(249, 115, 22, 0.15); color: #f97316; }
.hr-role-student { background: rgba(99, 102, 241, 0.15); color: #6366f1; }
.hr-role-interviewer { background: rgba(25, 167, 123, 0.15); color: #19A77B; }
.hr-role-company { background: rgba(25, 167, 123, 0.15); color: #19A77B; }

.hr-perf-item {
  display: flex; justify-content: space-between; align-items: center;
  padding: 0.55rem 0.65rem; background: var(--bg-light); border-radius: 8px; margin-bottom: 6px;
}

.hr-perf-name { font-size: 0.78rem; color: var(--text-dark); font-weight: 500; }
.hr-perf-score {
  font-size: 0.8rem; font-weight: 700; color: var(--primary);
  padding: 3px 10px; border-radius: 20px; background: rgba(25,167,123,0.08);
}

.applicant-badge {
  background: rgba(25, 167, 123, 0.12); color: #19A77B;
  padding: 3px 10px; border-radius: 20px; font-size: 0.68rem; font-weight: 600; white-space: nowrap;
}

.status-badge { padding: 3px 10px; border-radius: 20px; font-size: 0.68rem; font-weight: 600; white-space: nowrap; }
.status-applied { background: rgba(59, 130, 246, 0.12); color: #3b82f6; }
.status-hired { background: rgba(25, 167, 123, 0.12); color: #19A77B; }
.status-rejected { background: rgba(239, 68, 68, 0.12); color: #ef4444; }

.hr-card-content { max-height: 340px; overflow-y: auto; padding-right: 4px; }

@media (max-width: 1200px) {
  .stats-row { grid-template-columns: repeat(2, 1fr); }
  .hr-stats-grid { grid-template-columns: repeat(2, 1fr); }
}

@media (max-width: 992px) {
  .hr-content-grid { grid-template-columns: 1fr; }
}

@media (max-width: 576px) {
  .stats-row, .hr-stats-grid { grid-template-columns: 1fr; }
  .hr-user-item { flex-wrap: wrap; gap: 6px; }
  .hr-user-role { margin-left: auto; }
}
</style>
<jsp:include page="/views/commons/admin_shell_head.jsp" />
</head>
<body>

<jsp:include page="/views/commons/admin_shell_start.jsp">
  <jsp:param name="pageTitle" value="Admin Dashboard"/>
  <jsp:param name="pageSubtitle" value="Welcome back"/>
  <jsp:param name="activeNav" value="dashboard"/>
</jsp:include>

    <p class="text-muted mb-4" style="font-size: 0.95rem;"><i class="fas fa-hand-sparkles me-2" style="color: var(--primary);"></i>Welcome, ${adminName}! Manage your job portal efficiently with comprehensive administrative tools.</p>
    <!-- Key Statistics -->
    <div class="stats-row">
      <a href="${pageContext.request.contextPath}/allJobSeekers" class="stat-card-link">
        <div class="stat-card success">
          <div class="stat-card-header">
            <div>
              <div class="stat-value">${totalUsers}</div>
              <div class="stat-label">Total Job Seekers</div>
            </div>
            <div class="stat-icon"><i class="fas fa-users"></i></div>
          </div>
        </div>
      </a>
      <a href="${pageContext.request.contextPath}/company_dashboard" class="stat-card-link">
        <div class="stat-card info">
          <div class="stat-card-header">
            <div>
              <div class="stat-value">${totalCompanies}</div>
              <div class="stat-label">Total Companies</div>
            </div>
            <div class="stat-icon"><i class="fas fa-building"></i></div>
          </div>
        </div>
      </a>
      <a href="${pageContext.request.contextPath}/admin/pending" class="stat-card-link">
        <div class="stat-card warning">
          <div class="stat-card-header">
            <div>
              <div class="stat-value">${pendingCompanies}</div>
              <div class="stat-label">Pending Companies</div>
            </div>
            <div class="stat-icon"><i class="fas fa-clock"></i></div>
          </div>
        </div>
      </a>
      <a href="${pageContext.request.contextPath}/reported-jobs" class="stat-card-link">
        <div class="stat-card danger">
          <div class="stat-card-header">
            <div>
              <div class="stat-value">${pendingReports}</div>
              <div class="stat-label">Pending Reports</div>
            </div>
            <div class="stat-icon"><i class="fas fa-exclamation-triangle"></i></div>
          </div>
        </div>
      </a>
    </div>

    <!-- Platform Statistics -->
    <h2 class="section-title">Platform Statistics</h2>
    <div class="hr-stats-grid">
      <div class="hr-stat-card"><div class="hr-stat-icon orange"><i class="fas fa-users"></i></div><div class="hr-stat-value">${totalUsers}</div><div class="hr-stat-label">Total Job Seekers</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon purple"><i class="fas fa-code"></i></div><div class="hr-stat-value">${totalCodingQuestions}</div><div class="hr-stat-label">Coding Questions</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon cyan"><i class="fas fa-comments"></i></div><div class="hr-stat-value">${totalInterviewQuestions}</div><div class="hr-stat-label">Interview Questions</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon yellow"><i class="fas fa-video"></i></div><div class="hr-stat-value">${totalInterviews}</div><div class="hr-stat-label">Total Interviews</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon green"><i class="fas fa-check-double"></i></div><div class="hr-stat-value">${completedInterviews}</div><div class="hr-stat-label">Completed</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon orange"><i class="fas fa-building"></i></div><div class="hr-stat-value">${totalCompanies}</div><div class="hr-stat-label">Companies</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon blue"><i class="fas fa-briefcase"></i></div><div class="hr-stat-value">${totalJobs}</div><div class="hr-stat-label">Total Jobs</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon green"><i class="fas fa-file-alt"></i></div><div class="hr-stat-value">${totalApplications}</div><div class="hr-stat-label">Job Applications</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon purple"><i class="fas fa-handshake"></i></div><div class="hr-stat-value">${activeJobsCount}</div><div class="hr-stat-label">Active Jobs</div></div>
    </div>

    <!-- Recent Job Seekers & Performance -->
    <div class="hr-content-grid">
      <div class="hr-card">
        <div class="hr-card-header">
          <h3><i class="fas fa-user-clock" style="color: #f97316;"></i> Recent Job Seekers</h3>
          <a href="${pageContext.request.contextPath}/admin/manage-users">Manage All <i class="fas fa-arrow-right ms-1"></i></a>
        </div>
        <div class="hr-card-content">
          <c:forEach var="u" items="${recentUsers}" end="7">
            <div class="hr-user-item">
              <div class="hr-user-info">
                <div class="hr-user-avatar ${u.role == 'ADMIN' ? 'admin' : u.role == 'STUDENT' ? 'student' : u.role == 'COMPANY' ? 'company' : 'interviewer'}">${not empty u.name ? u.name.substring(0,1) : 'U'}</div>
                <div class="hr-user-details">
                  <span class="hr-user-name">${not empty u.name ? u.name : u.email}</span>
                  <div class="hr-user-meta">
                    <i class="fas fa-envelope"></i> ${u.email}
                  </div>
                </div>
              </div>
              <span class="hr-user-role hr-role-${u.role == 'ADMIN' ? 'admin' : u.role == 'STUDENT' ? 'student' : u.role == 'COMPANY' ? 'company' : 'interviewer'}">
                <i class="fas fa-badge-check me-1"></i>${u.role}
              </span>
            </div>
          </c:forEach>
          <c:if test="${empty recentUsers}">
            <div class="text-center text-muted py-4">
              <i class="fas fa-user-slash fa-2x mb-2 d-block opacity-50"></i>
              <p class="mb-0">No recent job seekers found</p>
            </div>
          </c:if>
        </div>
      </div>

      <div class="hr-card">
        <div class="hr-card-header">
          <h3><i class="fas fa-trophy" style="color: #fbbf24;"></i> Student Performance</h3>
          <a href="${pageContext.request.contextPath}/admin/analytics">View Analytics <i class="fas fa-arrow-right ms-1"></i></a>
        </div>
        <div class="hr-card-content">
          <c:forEach var="p" items="${performances}" end="7">
            <div class="hr-perf-item">
              <span class="hr-perf-name">
                <i class="fas fa-graduation-cap"></i>
                ${not empty p.studentName ? p.studentName : 'Student'} - ${not empty p.categoryName ? p.categoryName : 'Overall'}
              </span>
              <span class="hr-perf-score">
                <i class="fas fa-chart-simple me-1"></i>${p.overallScore}%
              </span>
            </div>
          </c:forEach>
          <c:if test="${empty performances}">
            <div class="text-center text-muted py-4">
              <i class="fas fa-chart-line fa-2x mb-2 d-block opacity-50"></i>
              <p class="mb-0">No performance data available</p>
            </div>
          </c:if>
        </div>
      </div>
    </div>

    <!-- Companies & Jobs + Applications -->
    <div class="hr-content-grid">
      <div class="hr-card">
        <div class="hr-card-header">
          <h3><i class="fas fa-briefcase" style="color: #3b82f6;"></i> Companies &amp; Active Jobs</h3>
          <a href="${pageContext.request.contextPath}/company_dashboard">View All <i class="fas fa-arrow-right ms-1"></i></a>
        </div>
        <div class="hr-card-content">
          <c:forEach var="j" items="${activeJobs}" end="7">
            <div class="hr-user-item">
              <div class="hr-user-info">
                <div class="hr-user-avatar company">${not empty j.companyName ? j.companyName.substring(0,1) : 'C'}</div>
                <div class="hr-user-details">
                  <span class="hr-user-name">${j.title}</span>
                  <div class="hr-user-meta">
                    <i class="fas fa-building"></i> ${j.companyName}
                    <i class="fas fa-map-marker-alt ms-2"></i> ${j.location}
                  </div>
                </div>
              </div>
              <span class="applicant-badge">
                <i class="fas fa-users me-1"></i>${j.applicantCount} Applicants
              </span>
            </div>
          </c:forEach>
          <c:if test="${empty activeJobs}">
            <div class="text-center text-muted py-4">
              <i class="fas fa-briefcase-slash fa-2x mb-2 d-block opacity-50"></i>
              <p class="mb-0">No active jobs posted yet</p>
            </div>
          </c:if>
        </div>
      </div>

      <div class="hr-card">
        <div class="hr-card-header">
          <h3><i class="fas fa-file-alt" style="color: #19A77B;"></i> Recent Job Applications</h3>
          <a href="${pageContext.request.contextPath}/company_dashboard">Track All <i class="fas fa-arrow-right ms-1"></i></a>
        </div>
        <div class="hr-card-content">
          <c:forEach var="a" items="${recentApplications}" end="7">
            <div class="hr-user-item">
              <div class="hr-user-info">
                <div class="hr-user-avatar student">${not empty a.applicantName ? a.applicantName.substring(0,1) : 'S'}</div>
                <div class="hr-user-details">
                  <span class="hr-user-name">${a.applicantName}</span>
                  <div class="hr-user-meta">
                    <i class="fas fa-briefcase"></i> ${a.jobTitle}
                  </div>
                </div>
              </div>
              <span class="status-badge status-${a.status == 'APPLIED' ? 'applied' : a.status == 'SELECTED' ? 'hired' : 'rejected'}">
                <i class="fas fa-${a.status == 'APPLIED' ? 'clock' : a.status == 'SELECTED' ? 'check-circle' : 'times-circle'} me-1"></i>
                ${a.status}
              </span>
            </div>
          </c:forEach>
          <c:if test="${empty recentApplications}">
            <div class="text-center text-muted py-4">
              <i class="fas fa-inbox fa-2x mb-2 d-block opacity-50"></i>
              <p class="mb-0">No applications received yet</p>
            </div>
          </c:if>
        </div>
      </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/views/commons/admin_shell_end.jsp" />
</body>
</html>
