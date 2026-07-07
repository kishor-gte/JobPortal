<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
    <div class="sidebar" id="sidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-chalkboard-teacher"></i></div>
            <h2>Mentor Panel</h2>
        </div>
        <div class="nav-section">
            <h4>Main</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/dashboard" class="nav-link">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/evaluations" class="nav-link">
                <i class="fas fa-chart-pie"></i> Student Performance
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/schedule-interview" class="nav-link">
                <i class="fas fa-calendar-plus"></i> Schedule Interview
            </a>
        </div>
        <div class="nav-section">
            <h4>Tools</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/chat" class="nav-link">
                <i class="fas fa-comments"></i> Messages
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/review-resumes" class="nav-link">
                <i class="fas fa-file-alt"></i> Review Resumes
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="nav-link active">
                <i class="fa-solid fa-robot fa-fw"></i> AI Evaluations
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/candidates" class="nav-link">
                <i class="fas fa-users fa-fw"></i> Candidates
            </a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/logout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>
