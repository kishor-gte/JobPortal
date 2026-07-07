<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Competition Results | SmartInterview</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
    
    <style>
        :root {
            --primary: #19A77B;
            --accent: #3BC49A;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --white: #ffffff;
            --text-primary: #1e293b;
            --border-color: #e0e6ed;
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
        }
        body { font-family: 'Inter', sans-serif; background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%); color: var(--text-primary); }
        .call-action { position: relative; background: var(--gradient-primary); color: #fff; padding: 60px 0; margin-bottom: 40px; border-radius: 0 0 30px 30px; box-shadow: var(--shadow-md); text-align: center; }
        .call-action h2 { color: #fff; font-size: 42px; font-weight: 800; margin: 10px 0 16px; }
        .content { max-width: 1200px; margin: 0 auto; padding: 0 24px 60px; }
        .btn-outline-light { border: 2px solid rgba(255, 255, 255, 0.8); color: #fff; padding: 12px 28px; border-radius: 30px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; }
        .table { background: var(--white); border-radius: 20px; overflow: hidden; box-shadow: var(--shadow-md); }
        .table thead { background: var(--gradient-primary); }
        .table thead th { color: white; padding: 16px 20px; }
        .table tbody td { padding: 20px; vertical-align: middle; border-bottom: 1px solid var(--border-color); }
        .btn-primary { background: var(--gradient-primary); border: none; padding: 10px 20px; border-radius: 30px; color: white; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; font-weight: 600;}
        .empty-state { text-align: center; padding: 60px 20px; background: var(--white); border-radius: 20px; box-shadow: var(--shadow-sm); }
    </style>
</head>
<body>

<section class="call-action">
    <div class="container">
        <h2>Competition Results</h2>
        <p>View the leaderboards and results of competitions created by your company's technical team.</p>
        <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="btn-outline-light">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</section>

<div class="content">
    <c:choose>
        <c:when test="${empty competitions}">
            <div class="empty-state">
                <h4>No Competitions Found</h4>
                <p>There are no competitions created by your company's technical team yet.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Competition Title</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="comp" items="${competitions}">
                            <tr>
                                <td><strong>${comp.title}</strong></td>
                                <td>
                                    <span class="badge bg-${comp.status == 'LIVE' ? 'success' : (comp.status == 'COMPLETED' ? 'primary' : 'secondary')}">
                                        ${comp.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/recruiter/competition-results/${comp.id}" class="btn-primary">
                                        <i class="fas fa-eye"></i> View Leaderboard
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
</body>
</html>
