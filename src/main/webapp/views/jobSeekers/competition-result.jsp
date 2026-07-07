<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Competition Result | Student Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #19A77B;
            --bg-light: #f4fbf9;
            --text-dark: #1a2c2f;
            --text-muted: #5a6e66;
            --white: #ffffff;
            --border: #e2e8f0;
            --radius-lg: 16px;
            --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background: #f8fafc;
            color: var(--text-dark);
            display: flex;
            min-height: 100vh;
        }

        .main-content {
            margin-left: 280px;
            padding: 32px 40px;
            width: calc(100% - 280px);
        }

        .header {
            background: #fff;
            padding: 16px 24px;
            margin-bottom: 2rem;
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .btn-back {
            color: var(--text-muted);
            text-decoration: none;
            font-size: 1.2rem;
        }

        .header h1 {
            font-size: 20px;
            color: var(--primary);
            margin: 0;
        }

        .result-summary {
            background: #fff;
            border-radius: var(--radius-lg);
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: var(--shadow-sm);
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            text-align: center;
        }

        .summary-box {
            background: var(--bg-light);
            padding: 20px;
            border-radius: 12px;
            border: 1px solid rgba(25,167,123,0.1);
        }

        .summary-box i {
            font-size: 2rem;
            color: var(--primary);
            margin-bottom: 10px;
        }

        .summary-box h3 {
            font-size: 0.9rem;
            color: var(--text-muted);
            margin-bottom: 5px;
        }

        .summary-box .val {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-dark);
        }

        .leaderboard-section {
            background: #fff;
            border-radius: var(--radius-lg);
            padding: 30px;
            box-shadow: var(--shadow-sm);
        }

        .leaderboard-section h2 {
            font-size: 18px;
            margin-bottom: 20px;
            color: var(--text-dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .table-responsive {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        th, td {
            padding: 15px;
            border-bottom: 1px solid var(--border);
        }

        th {
            background: var(--bg-light);
            color: var(--text-muted);
            font-weight: 600;
            font-size: 0.9rem;
        }

        td {
            font-size: 0.95rem;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .rank-1 { color: #FFD700; font-weight: bold; }
        .rank-2 { color: #C0C0C0; font-weight: bold; }
        .rank-3 { color: #CD7F32; font-weight: bold; }
    </style>
</head>
<body>
    <jsp:include page="/views/commons/student_sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <a href="${pageContext.request.contextPath}/student/coding-competitions/history" class="btn-back"><i class="fas fa-arrow-left"></i></a>
            <h1>${competition.title} - Result Details</h1>
        </div>

        <div class="result-summary">
            <div class="summary-box">
                <i class="fas fa-medal"></i>
                <h3>Final Rank</h3>
                <div class="val">
                    <c:choose>
                        <c:when test="${not empty myResult.rank}">#${myResult.rank}</c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="summary-box">
                <i class="fas fa-check-circle"></i>
                <h3>Questions Solved</h3>
                <div class="val">${myResult.questionsSolved} / ${competition.numberOfQuestions}</div>
            </div>
            <div class="summary-box">
                <i class="fas fa-stopwatch"></i>
                <h3>Time Taken</h3>
                <div class="val">${timeTaken}</div>
            </div>
        </div>

        <div class="leaderboard-section">
            <h2><i class="fas fa-list-ol" style="color: var(--primary);"></i> Leaderboard</h2>
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Rank</th>
                            <th>Student Name</th>
                            <th>Questions Solved</th>
                            <th>Submitted At</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty leaderboard}">
                                <c:forEach var="item" items="${leaderboard}" varStatus="status">
                                    <tr>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty item.result.rank}">
                                                    <span class="${item.result.rank <= 3 ? 'rank-' += item.result.rank : ''}">
                                                        <c:if test="${item.result.rank <= 3}"><i class="fas fa-trophy"></i></c:if>
                                                        #${item.result.rank}
                                                    </span>
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="font-weight: 500;">${item.studentName}</td>
                                        <td>${item.result.questionsSolved}</td>
                                        <td>
                                            <fmt:parseDate value="${item.result.submittedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                            <fmt:formatDate pattern="MMM dd, yyyy h:mm a" value="${parsedDate}" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" style="text-align: center; color: var(--text-muted);">No results found for this competition.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
