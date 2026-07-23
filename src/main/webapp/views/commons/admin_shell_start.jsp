<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%--
  Shared Admin Shell — start
  Params (optional):
    pageTitle    - top bar title
    pageSubtitle - top bar subtitle
    activeNav    - sidebar active key (dashboard|jobseekers|recruiters|technicians|activities|
                   companies|pending|alerts|reported|sports-add|sports-list|bookings|
                   qna|assessments|hackerrank|profile)
--%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="pageTitle" value="${empty param.pageTitle ? 'Admin Panel' : param.pageTitle}" />
<c:set var="pageSubtitle" value="${empty param.pageSubtitle ? 'JobU Control Center' : param.pageSubtitle}" />
<c:set var="activeNav" value="${param.activeNav}" />

<script>document.body.classList.add('admin-shell');</script>
<style>body.admin-shell{display:block!important;align-items:stretch!important;justify-content:flex-start!important;padding:0!important;min-height:100vh!important;}</style>

<div class="admin-shell-overlay" id="adminShellOverlay" onclick="closeAdminSidebar()"></div>

<aside class="admin-sidebar" id="adminSidebar" aria-label="Admin navigation">
  <a class="sidebar-brand" href="${ctx}/dashboard">
    <img src="${ctx}/assets/images/logo/logo.png" alt="JobU Logo" />
    <span>JobU Admin</span>
  </a>

  <nav class="sidebar-nav">
    <div class="nav-section">
      <div class="nav-section-title">Overview</div>
      <a href="${ctx}/dashboard" class="sidebar-link ${activeNav == 'dashboard' ? 'active' : ''}">
        <i class="fas fa-th-large"></i> Dashboard
      </a>
    </div>

    <div class="nav-section">
      <div class="nav-section-title">Users</div>
      <a href="${ctx}/allJobSeekers" class="sidebar-link ${activeNav == 'jobseekers' ? 'active' : ''}">
        <i class="fas fa-users"></i> Job Seekers
      </a>
      <a href="${ctx}/admin/recruiters" class="sidebar-link ${activeNav == 'recruiters' ? 'active' : ''}">
        <i class="fas fa-user-tie"></i> Recruiters
      </a>
      <a href="${ctx}/admin/technicians" class="sidebar-link ${activeNav == 'technicians' ? 'active' : ''}">
        <i class="fas fa-tools"></i> Technicians
      </a>
      <a href="${ctx}/admin/activity-logs" class="sidebar-link ${activeNav == 'activities' ? 'active' : ''}">
        <i class="fas fa-history"></i> Activity Logs
      </a>
    </div>

    <div class="nav-section">
      <div class="nav-section-title">Companies</div>
      <a href="${ctx}/company_dashboard" class="sidebar-link ${activeNav == 'companies' ? 'active' : ''}">
        <i class="fas fa-building"></i> Manage Companies
      </a>
      <a href="${ctx}/admin/pending" class="sidebar-link ${activeNav == 'pending' ? 'active' : ''}">
        <i class="fas fa-clock"></i> Pending Companies
      </a>
      <a href="${ctx}/admin/alerts" class="sidebar-link ${activeNav == 'alerts' ? 'active' : ''}">
        <i class="fas fa-flag"></i> Reported Companies
      </a>
    </div>

    <div class="nav-section">
      <div class="nav-section-title">Jobs &amp; Reports</div>
      <a href="${ctx}/reported-jobs" class="sidebar-link ${activeNav == 'reported' ? 'active' : ''}">
        <i class="fas fa-exclamation-triangle"></i> Reported Jobs
      </a>
    </div>

    <div class="nav-section">
      <div class="nav-section-title">Sports Services</div>
      <a href="${ctx}/admin/sports/service/add" class="sidebar-link ${activeNav == 'sports-add' ? 'active' : ''}">
        <i class="fas fa-futbol"></i> Add Sports Services
      </a>
      <a href="${ctx}/admin/sports/service/list" class="sidebar-link ${activeNav == 'sports-list' ? 'active' : ''}">
        <i class="fas fa-list"></i> Manage Sports Services
      </a>
      <a href="${ctx}/admin/bookings" class="sidebar-link ${activeNav == 'bookings' ? 'active' : ''}">
        <i class="fas fa-list-alt"></i> All Bookings
      </a>
    </div>

    <div class="nav-section">
      <div class="nav-section-title">Assessments</div>
      <a href="${ctx}/qna/admin/questions" class="sidebar-link ${activeNav == 'qna' ? 'active' : ''}">
        <i class="fas fa-question-circle"></i> Manage Q&amp;A
      </a>
      <a href="${ctx}/admin/assessments/uploadpage" class="sidebar-link ${activeNav == 'assessments' ? 'active' : ''}">
        <i class="fas fa-file-alt"></i> Assessment Questions
      </a>
      <a href="${ctx}/had" class="sidebar-link ${activeNav == 'hackerrank' ? 'active' : ''}">
        <i class="fas fa-chart-line"></i> HackerRank Dashboard
      </a>
    </div>
  </nav>

  <div class="sidebar-footer">
    <a href="${ctx}/admin/profile" class="sidebar-link ${activeNav == 'profile' ? 'active' : ''}">
      <i class="fas fa-user-edit"></i> Edit Profile
    </a>
    <form action="${ctx}/adminLogout" method="post">
      <button type="submit" class="sidebar-link logout">
        <i class="fas fa-sign-out-alt"></i> Logout
      </button>
    </form>
  </div>
</aside>

<div class="admin-main-wrapper">
  <header class="admin-top-bar">
    <div class="admin-top-bar-left">
      <button type="button" class="admin-menu-toggle" aria-label="Toggle menu" onclick="toggleAdminSidebar()">
        <i class="fas fa-bars"></i>
      </button>
      <div class="admin-welcome-block">
        <h1>${pageTitle}</h1>
        <p>${pageSubtitle}</p>
      </div>
    </div>
    <div class="admin-top-bar-actions">
      <a href="${ctx}/admin/profile" class="admin-btn-top">
        <i class="fas fa-user-edit"></i> <span>Profile</span>
      </a>
      <form action="${ctx}/adminLogout" method="post" style="display:inline;margin:0;">
        <button type="submit" class="admin-btn-top logout">
          <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
        </button>
      </form>
    </div>
  </header>

  <div class="admin-main-content">
