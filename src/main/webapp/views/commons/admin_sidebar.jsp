<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <div class="sidebar" id="mainSidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-shield-halved"></i></div>
            <h2>Admin Panel</h2>
        </div>
        <div class="nav-section">
            <h4>Overview</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/dashboard" class="nav-link"><i class="fas fa-th-large"></i> Dashboard</a>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/analytics" class="nav-link"><i class="fas fa-chart-bar"></i> Analytics</a>
        </div>
        <div class="nav-section">
            <h4>Management</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/manage-users" class="nav-link"><i class="fas fa-users-cog"></i> Manage Users</a>

        </div>
        <div class="nav-section">
            <h4>Evaluation</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/admin/results" class="nav-link"><i class="fas fa-poll"></i> View Results</a>
            <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="nav-link"><i class="fas fa-robot"></i> AI Evaluations</a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/logout" class="nav-link"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </div>
    </div>
