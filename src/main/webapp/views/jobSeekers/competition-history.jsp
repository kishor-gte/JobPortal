<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Competition History | Student Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --bg-light: #f4fbf9;
            --text-dark: #1a2c2f;
            --text-muted: #5a6e66;
            --white: #ffffff;
            --border: #e2e8f0;
            --danger: #ef4444;
            --success: #19A77B;
            --warning: #f59e0b;
            --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
            --radius-lg: 16px;
            --transition: all 0.3s ease;
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
        }

        .header h1 {
            font-size: 20px;
            color: var(--primary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .history-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 20px;
        }

        .history-card {
            background: var(--white);
            border-radius: var(--radius-lg);
            border: 1px solid var(--border);
            padding: 20px;
            position: relative;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .history-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 30px -10px rgba(0,0,0,0.1);
        }

        .status-badge {
            position: absolute;
            top: 20px;
            right: 20px;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-Completed { background: #e6f6f0; color: var(--success); }
        .status-Missed { background: #fee2e2; color: var(--danger); }
        .status-Registered { background: #fef3c7; color: var(--warning); }

        .comp-title {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 5px;
            padding-right: 80px;
        }

        .comp-date {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: 15px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
            margin-bottom: 20px;
            background: var(--bg-light);
            padding: 12px;
            border-radius: 8px;
        }

        .stat-item {
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .stat-value {
            font-weight: 600;
            color: var(--text-dark);
            margin-left: 5px;
        }

        .winner-badge {
            display: inline-block;
            background: linear-gradient(135deg, #FFD700 0%, #FDB931 100%);
            color: #fff;
            padding: 4px 8px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .btn-view {
            display: block;
            text-align: center;
            background: var(--primary);
            color: white;
            text-decoration: none;
            padding: 10px;
            border-radius: 8px;
            font-weight: 600;
            transition: var(--transition);
        }

        .btn-view:hover {
            background: var(--primary-dark);
        }
        
        .empty-state {
            text-align: center;
            padding: 40px;
            color: var(--text-muted);
            grid-column: 1 / -1;
            background: white;
            border-radius: var(--radius-lg);
            border: 1px dashed var(--border);
        }
    </style>
</head>
<body>
    <jsp:include page="/views/commons/student_sidebar.jsp" />

    <div class="main-content">
        <div class="header">
            <h1><i class="fas fa-history"></i> My Competition History</h1>
        </div>

        <div class="history-grid">
            <c:choose>
                <c:when test="${not empty historyList}">
                    <c:forEach var="item" items="${historyList}">
                        <div class="history-card">
                            <div class="status-badge status-${item.status}">
                                ${item.status}
                            </div>
                            
                            <h3 class="comp-title">${item.competition.title}</h3>
                            <div class="comp-date">
                                <i class="fas fa-calendar-alt"></i> 
                                <fmt:parseDate value="${item.competition.examStartTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                <fmt:formatDate pattern="MMM dd, yyyy" value="${parsedDate}" />
                            </div>

                            <c:if test="${not empty item.result and item.result.rank <= 10 and item.result.rank > 0}">
                                <div class="winner-badge"><i class="fas fa-crown"></i> Top 10 Winner!</div>
                            </c:if>

                            <div class="stats-grid">
                                <div class="stat-item">Difficulty: <span class="stat-value">${item.competition.difficulty}</span></div>
                                <div class="stat-item">Questions: <span class="stat-value">
                                    ${item.status == 'Completed' ? item.result.questionsSolved : 0} / ${item.competition.numberOfQuestions}
                                </span></div>
                                <div class="stat-item">Final Rank: <span class="stat-value">
                                    <c:choose>
                                        <c:when test="${not empty item.result and not empty item.result.rank}">
                                            #${item.result.rank}
                                        </c:when>
                                        <c:otherwise>-</c:otherwise>
                                    </c:choose>
                                </span></div>
                            </div>

                            <c:if test="${item.status == 'Completed'}">
                                <a href="${pageContext.request.contextPath}/student/coding-competitions/${item.competition.id}/result" class="btn-view">
                                    <i class="fas fa-chart-bar"></i> View Result
                                </a>
                            </c:if>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-box-open fa-3x" style="margin-bottom: 15px; color: #cbd5e1;"></i>
                        <p>No competition history found.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
