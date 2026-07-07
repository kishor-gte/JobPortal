<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Competition Leaderboard - Job Portal</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --bg-dark: #2E3E41;
            --bg-light: #f8fafc;
            --text-dark: #1a2c2f;
            --text-muted: #64748b;
            --white: #ffffff;
            --border: #e2e8f0;
            --radius-md: 12px;
            --shadow-sm: 0 4px 6px -1px rgba(0, 0, 0, 0.05);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--bg-light);
            color: var(--text-dark);
            display: flex;
            min-height: 100vh;
        }

        /* Basic Sidebar */
        .sidebar {
            width: 280px;
            background: var(--bg-dark);
            color: white;
            padding: 24px 0;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            transition: transform 0.3s ease;
            z-index: 1000;
        }
        .sidebar-header {
            padding: 0 24px 24px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 24px;
        }
        .sidebar-header h2 {
            font-size: 20px;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .nav-list {
            list-style: none;
            padding: 0 12px;
        }
        .nav-item {
            margin-bottom: 4px;
        }
        .nav-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            color: rgba(255,255,255,0.7);
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .nav-link:hover, .nav-link.active {
            background: rgba(25,167,123,0.1);
            color: var(--primary);
        }
        
        .main-content {
            margin-left: 280px;
            padding: 32px 40px;
            width: calc(100% - 280px);
        }

        .header-section {
            background: #fff;
            padding: 24px;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            margin-bottom: 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-title h1 {
            font-size: 24px;
            margin-bottom: 8px;
        }
        .header-title p {
            color: var(--text-muted);
            font-size: 14px;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: var(--bg-light);
            border: 1px solid var(--border);
            border-radius: 8px;
            color: var(--text-dark);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.2s;
        }
        .btn-back:hover {
            background: #e2e8f0;
        }

        .table-container {
            background: #fff;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: #f8fafc;
            padding: 16px 24px;
            text-align: left;
            font-weight: 600;
            color: var(--text-muted);
            border-bottom: 1px solid var(--border);
            font-size: 14px;
        }

        td {
            padding: 16px 24px;
            border-bottom: 1px solid var(--border);
            font-size: 14px;
        }

        tr:last-child td {
            border-bottom: none;
        }
        
        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            background: rgba(25, 167, 123, 0.1);
            color: var(--primary);
        }

        @media (max-width: 768px) {
            .sidebar { transform: translateX(-100%); }
            .sidebar.active { transform: translateX(0); }
            .main-content { margin-left: 0; width: 100%; padding: 20px; }
            .header-section { flex-direction: column; align-items: flex-start; gap: 16px; }
        }
    </style>
</head>
<body>

    <!-- Sidebar -->
    <aside class="sidebar" id="mainSidebar">
        <div class="sidebar-header">
            <h2><i class="fas fa-laptop-code"></i> Tech Dashboard</h2>
        </div>
        <ul class="nav-list">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link">
                    <i class="fas fa-chart-pie"></i> Overview
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/tech/manage-competitions" class="nav-link active">
                    <i class="fas fa-trophy"></i> Manage Competitions
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/tech/competition-results" class="nav-link">
                    <i class="fas fa-poll"></i> Competition Results
                </a>
            </li>
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/tech/logout" class="nav-link" style="color: #ef4444;">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </li>
        </ul>
    </aside>

    <div class="main-content">
        <div class="header-section">
            <div class="header-title">
                <h1>Leaderboard: ${competition.title}</h1>
                <p>Top Performers</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/tech/competition-results" class="btn-back">
                    <i class="fas fa-arrow-left"></i> Back to Results
                </a>
            </div>
        </div>

        <div class="table-container">
            <c:choose>
                <c:when test="${not empty leaderboard}">
                    <table>
                        <thead>
                            <tr>
                                <th>Rank</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th>Questions Solved</th>
                                <th>Submission Time</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="entry" items="${leaderboard}">
                                <tr>
                                    <td>
                                        <c:choose>
                                            <c:when test="${entry.rank == 1}"><i class="fas fa-trophy" style="color: gold;"></i> 1</c:when>
                                            <c:when test="${entry.rank == 2}"><i class="fas fa-medal" style="color: silver;"></i> 2</c:when>
                                            <c:when test="${entry.rank == 3}"><i class="fas fa-medal" style="color: #cd7f32;"></i> 3</c:when>
                                            <c:otherwise>${entry.rank}</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td style="font-weight: 500;">${entry.name}</td>
                                    <td style="color: var(--text-muted);">${entry.email}</td>
                                    <td><strong>${entry.questionsSolved}</strong> / ${competition.numberOfQuestions}</td>
                                    <td>${entry.submittedAt}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div style="padding: 40px; text-align: center; color: var(--text-muted);">
                        <i class="fas fa-list-ol" style="font-size: 32px; margin-bottom: 12px; color: #cbd5e1;"></i>
                        <p>No students have submitted the exam yet.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
