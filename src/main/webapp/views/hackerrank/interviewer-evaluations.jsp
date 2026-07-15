<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interviewer Analytics - SmartInterview</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #1e293b;
            --text-secondary: #475569;
            --text-tertiary: #64748b;
            --border-color: rgba(0, 0, 0, 0.08);
            --card-bg: #ffffff;
            --hover-bg: rgba(25, 167, 123, 0.08);
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --purple: #8b5cf6;
            --orange: #f97316;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        
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

        .container { 
            max-width: 1200px; 
            margin: 0 auto; 
            padding: 32px; 
            position: relative;
            z-index: 1;
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

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: var(--primary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 24px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 8px 18px;
            border-radius: 30px;
            background: var(--hover-bg);
            border: 1px solid rgba(25, 167, 123, 0.15);
        }

        .back-link:hover {
            background: var(--primary);
            color: white;
            transform: translateX(-6px);
            box-shadow: var(--glow-primary);
        }

        .page-header { 
            margin-bottom: 30px; 
            text-align: left; 
            display: flex; 
            justify-content: space-between; 
            align-items: flex-end;
            flex-wrap: wrap;
            gap: 16px;
        }

        .page-header h1 {
            font-size: 32px;
            font-weight: 800;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .page-header h1 i {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 32px;
        }

        .certified-badge {
            background: var(--hover-bg);
            color: var(--primary);
            padding: 10px 20px;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 600;
            border: 1px solid var(--primary);
            display: flex;
            align-items: center;
            gap: 8px;
            backdrop-filter: blur(10px);
        }

        .certified-badge i {
            color: var(--primary);
        }

        /* Filter Bar */
        .filter-section {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 24px 28px;
            margin-bottom: 32px;
            display: flex;
            align-items: center;
            gap: 24px;
            box-shadow: var(--shadow-sm);
            backdrop-filter: blur(10px);
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .filter-group { 
            display: flex; 
            flex-direction: column; 
            gap: 10px; 
            flex: 1; 
            max-width: 450px; 
        }

        .filter-group label { 
            font-size: 11px; 
            color: var(--text-tertiary); 
            text-transform: uppercase; 
            letter-spacing: 1.5px; 
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .filter-group label i {
            color: var(--primary);
        }

        .filter-select {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            color: var(--text-primary);
            padding: 14px 18px;
            border-radius: 14px;
            font-size: 15px;
            outline: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Inter', sans-serif;
        }

        .filter-select:focus { 
            border-color: var(--primary); 
            box-shadow: var(--glow-primary); 
        }

        .filter-select option {
            background: var(--card-bg);
            color: var(--text-primary);
        }

        /* Stats Cards */
        .score-overview { 
            display: grid; 
            grid-template-columns: repeat(4, 1fr); 
            gap: 20px; 
            margin-bottom: 40px; 
        }

        .score-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 20px;
            text-align: center;
            position: relative;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
            backdrop-filter: blur(10px);
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
        }

        .score-card:nth-child(1) { animation-delay: 0.1s; }
        .score-card:nth-child(2) { animation-delay: 0.2s; }
        .score-card:nth-child(3) { animation-delay: 0.3s; }
        .score-card:nth-child(4) { animation-delay: 0.4s; }

        @keyframes cardAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .score-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-lg), var(--glow-primary);
            border-color: var(--primary);
        }

        .score-card::before { 
            content: ''; 
            position: absolute; 
            top: 0; 
            left: 0; 
            right: 0; 
            height: 4px; 
            background: var(--gradient-primary);
            transform: translateX(-100%);
            transition: transform 0.5s ease;
        }

        .score-card:hover::before {
            transform: translateX(0);
        }

        .score-ring { 
            width: 80px; 
            height: 80px; 
            margin: 0 auto 16px; 
            position: relative; 
        }

        .score-ring svg { transform: rotate(-90deg); }
        .score-ring circle { fill: none; stroke-width: 6; stroke-linecap: round; }
        .score-ring .bg { stroke: var(--border-color); }
        .score-ring .fg { transition: stroke-dashoffset 1.5s ease; }

        .score-card.comm .fg { stroke: var(--info); }
        .score-card.tech .fg { stroke: var(--success); }
        .score-card.conf .fg { stroke: var(--orange); }
        .score-card.overall .fg { stroke: var(--purple); }

        .score-ring .value { 
            position: absolute; 
            top: 50%; 
            left: 50%; 
            transform: translate(-50%, -50%); 
            font-size: 20px; 
            font-weight: 800; 
            color: var(--text-primary); 
        }

        .score-card label {
            font-size: 13px;
            color: var(--text-tertiary);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* Eval Cards */
        .eval-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 28px;
            margin-bottom: 20px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow-sm);
            backdrop-filter: blur(10px);
            animation: slideIn 0.5s ease-out;
            position: relative;
            overflow: hidden;
        }

        .eval-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--gradient-primary);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .eval-card:hover { 
            transform: translateX(6px); 
            border-color: var(--primary); 
            box-shadow: var(--shadow-lg), var(--glow-primary); 
        }

        .eval-card:hover::before {
            opacity: 1;
        }

        .eval-header { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 20px; 
        }

        .eval-student { 
            display: flex; 
            align-items: center; 
            gap: 16px; 
        }

        .eval-avatar { 
            width: 52px; 
            height: 52px; 
            background: var(--gradient-primary); 
            color: #fff; 
            border-radius: 14px; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            font-weight: 700; 
            font-size: 20px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .eval-student h4 {
            color: var(--text-primary);
            font-size: 18px;
            margin-bottom: 4px;
        }

        .eval-student p {
            font-size: 12px;
            color: var(--text-tertiary);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .eval-student p i {
            color: var(--primary);
        }

        .eval-overall { 
            font-size: 32px; 
            font-weight: 800; 
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .delete-btn {
            color: var(--danger);
            background: rgba(239, 68, 68, 0.08);
            width: 38px;
            height: 38px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            border: 1px solid rgba(239, 68, 68, 0.2);
            transition: all 0.3s ease;
        }

        .delete-btn:hover {
            background: var(--danger);
            color: #fff;
            transform: scale(1.1);
        }

        .eval-scores { 
            display: grid; 
            grid-template-columns: repeat(4, 1fr); 
            gap: 14px; 
            margin-bottom: 20px; 
        }

        .score-item { 
            padding: 16px; 
            background: var(--hover-bg); 
            border: 1px solid var(--border-color); 
            border-radius: 14px; 
            text-align: center;
            transition: all 0.3s ease;
        }

        .score-item:hover {
            transform: translateY(-2px);
            border-color: var(--primary);
        }

        .score-item .val { 
            font-size: 24px; 
            font-weight: 800; 
            display: block; 
            margin-bottom: 4px;
        }

        .score-item .lbl { 
            font-size: 11px; 
            color: var(--text-tertiary); 
            text-transform: uppercase; 
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .feedback-box { 
            padding: 18px 20px; 
            background: var(--hover-bg); 
            border: 1px solid var(--border-color); 
            border-radius: 14px; 
            font-size: 14px; 
            line-height: 1.7; 
            color: var(--text-secondary);
        }

        .feedback-box h5 {
            font-size: 13px;
            color: var(--primary);
            margin-bottom: 10px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .empty-state { 
            text-align: center; 
            padding: 80px 20px; 
            color: var(--text-tertiary); 
        }

        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            color: var(--primary);
            opacity: 0.3;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .empty-state h3 {
            color: var(--text-primary);
            margin-bottom: 8px;
            font-size: 20px;
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .score-overview {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .score-overview {
                grid-template-columns: 1fr;
            }

            .eval-scores {
                grid-template-columns: repeat(2, 1fr);
            }

            .filter-section {
                flex-direction: column;
                align-items: stretch;
            }

            .filter-group {
                max-width: 100%;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .page-header h1 {
                font-size: 26px;
            }
        }

        @media (max-width: 480px) {
            .eval-scores {
                grid-template-columns: 1fr;
            }

            .eval-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/hackerrank/interviewer/dashboard" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        
        <div class="page-header">
            <div>
                <h1>
                    <i class="fas fa-chart-pie"></i>
                    Student Performance Analytics
                </h1>
                <p style="color: var(--text-tertiary); margin-top: 8px; font-size: 15px;">
                    Detailed performance insights for your interviewed candidates
                </p>
            </div>
            <div class="certified-badge">
                <i class="fas fa-check-circle"></i> Mentor Certified Analytics
            </div>
        </div>

        <div class="filter-section">
            <div class="filter-group">
                <label>
                    <i class="fas fa-filter"></i>
                    Filter by Candidate
                </label>
                <form action="${pageContext.request.contextPath}/hackerrank/interviewer/evaluations" method="get">
                    <select name="studentId" class="filter-select" onchange="this.form.submit()">
                        <option value="">-- All Interviewed Candidates --</option>
                        <c:forEach var="student" items="${interviewedStudents}">
                            <option value="${student.id}" ${student.id == selectedStudentId ? 'selected' : ''}>
                                ${not empty student.name ? student.name : 'Candidate #'.concat(student.id)}
                            </option>
                        </c:forEach>
                    </select>
                </form>
            </div>
        </div>

        <c:if test="${not empty evaluations}">
            <div class="score-overview">
                <div class="score-card comm">
                    <div class="score-ring">
                        <svg viewBox="0 0 36 36">
                            <circle class="bg" cx="18" cy="18" r="15.9" />
                            <circle class="fg" cx="18" cy="18" r="15.9" stroke-dasharray="100" stroke-dashoffset="${100 - avgCommunication * 10}" />
                        </svg>
                        <span class="value">
                            <fmt:formatNumber value="${avgCommunication}" maxFractionDigits="1"/>
                        </span>
                    </div>
                    <label>Communication</label>
                </div>
                <div class="score-card tech">
                    <div class="score-ring">
                        <svg viewBox="0 0 36 36">
                            <circle class="bg" cx="18" cy="18" r="15.9" />
                            <circle class="fg" cx="18" cy="18" r="15.9" stroke-dasharray="100" stroke-dashoffset="${100 - avgTechnical * 10}" />
                        </svg>
                        <span class="value">
                            <fmt:formatNumber value="${avgTechnical}" maxFractionDigits="1"/>
                        </span>
                    </div>
                    <label>Technical</label>
                </div>
                <div class="score-card conf">
                    <div class="score-ring">
                        <svg viewBox="0 0 36 36">
                            <circle class="bg" cx="18" cy="18" r="15.9" />
                            <circle class="fg" cx="18" cy="18" r="15.9" stroke-dasharray="100" stroke-dashoffset="${100 - avgConfidence * 10}" />
                        </svg>
                        <span class="value">
                            <fmt:formatNumber value="${avgConfidence}" maxFractionDigits="1"/>
                        </span>
                    </div>
                    <label>Confidence</label>
                </div>
                <div class="score-card overall">
                    <div class="score-ring">
                        <svg viewBox="0 0 36 36">
                            <circle class="bg" cx="18" cy="18" r="15.9" />
                            <circle class="fg" cx="18" cy="18" r="15.9" stroke-dasharray="100" stroke-dashoffset="${100 - avgOverall * 10}" />
                        </svg>
                        <span class="value">
                            <fmt:formatNumber value="${avgOverall}" maxFractionDigits="1"/>
                        </span>
                    </div>
                    <label>Overall Fit</label>
                </div>
            </div>

            <c:forEach var="eval" items="${evaluations}" varStatus="status">
                <div class="eval-card" style="animation-delay: ${status.index * 0.05}s;">
                    <div class="eval-header">
                        <div class="eval-student">
                            <div class="eval-avatar">${not empty eval.studentName ? eval.studentName.substring(0,1) : 'S'}</div>
                            <div>
                                <h4>${not empty eval.studentName ? eval.studentName : 'Candidate #'.concat(eval.studentId)}</h4>
                                <p>
                                    <i class="far fa-calendar-alt"></i> 
                                    Interview Date: ${eval.scheduledAt}
                                </p>
                            </div>
                        </div>
                        <div style="display: flex; align-items: center; gap: 20px;">
                            <div class="eval-overall">
                                <fmt:formatNumber value="${eval.score / 10.0}" maxFractionDigits="1"/>
                            </div>
                            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/delete-interview/${eval.id}?redirect=/hackerrank/interviewer/evaluations" 
                               class="delete-btn" 
                               onclick="return confirm('Are you sure you want to delete this evaluation record?')"
                               title="Delete Evaluation">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </div>
                    </div>
                    
                    <div class="eval-scores">
                        <div class="score-item">
                            <span class="val" style="color: var(--info);">
                                <fmt:formatNumber value="${eval.communicationScore / 10.0}" maxFractionDigits="1"/>
                            </span>
                            <span class="lbl">Communication</span>
                        </div>
                        <div class="score-item">
                            <span class="val" style="color: var(--success);">
                                <fmt:formatNumber value="${eval.technicalScore / 10.0}" maxFractionDigits="1"/>
                            </span>
                            <span class="lbl">Technical</span>
                        </div>
                        <div class="score-item">
                            <span class="val" style="color: var(--orange);">
                                <fmt:formatNumber value="${eval.confidenceScore / 10.0}" maxFractionDigits="1"/>
                            </span>
                            <span class="lbl">Confidence</span>
                        </div>
                        <div class="score-item">
                            <span class="val" style="color: var(--purple);">
                                <fmt:formatNumber value="${eval.score / 10.0}" maxFractionDigits="1"/>
                            </span>
                            <span class="lbl">Overall</span>
                        </div>
                    </div>
                    
                    <div class="feedback-box">
                        <h5>
                            <i class="fas fa-comment-dots"></i> 
                            Your Detailed Feedback:
                        </h5>
                        ${eval.feedback}
                    </div>
                </div>
            </c:forEach>
        </c:if>

        <c:if test="${empty evaluations}">
            <div class="empty-state">
                <i class="fas fa-user-slash"></i>
                <h3>No Completed Evaluations Found</h3>
                <p>Select a candidate from the dropdown or complete an interview to see data here.</p>
            </div>
        </c:if>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate score rings on load
            const scoreCards = document.querySelectorAll('.score-card');
            scoreCards.forEach((card, index) => {
                setTimeout(() => {
                    const ring = card.querySelector('.fg');
                    if (ring) {
                        const offset = ring.getAttribute('stroke-dashoffset');
                        ring.style.setProperty('--target-offset', offset);
                    }
                }, index * 100);
            });

            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Escape to go back
                if (e.key === 'Escape') {
                    const backLink = document.querySelector('.back-link');
                    if (backLink) {
                        window.location.href = backLink.href;
                    }
                }
            });

            // Mobile responsive menu (if sidebar exists)
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