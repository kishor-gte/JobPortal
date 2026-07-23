<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Evaluation Detail - SmartInterview</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.85);
            --text-tertiary: rgba(255, 255, 255, 0.5);
            --border-color: rgba(255, 255, 255, 0.08);
            --card-bg: rgba(46, 62, 65, 0.6);
            --hover-bg: rgba(25, 167, 123, 0.15);
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --gradient-dark: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-darker) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.15);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.2);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.3);
            --glow-primary: 0 0 30px rgba(25, 167, 123, 0.2);
            --success: #19A77B;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--gradient-dark);
            color: var(--text-primary);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
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
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(25, 167, 123, 0.05) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: backgroundPulse 15s ease-in-out infinite;
        }

        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        .container {
            max-width: 900px;
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
            gap: 8px;
            color: var(--accent);
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 24px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 30px;
            background: var(--hover-bg);
            border: 1px solid rgba(25, 167, 123, 0.2);
        }

        .back-link:hover {
            background: var(--primary);
            color: white;
            transform: translateX(-4px);
            box-shadow: var(--glow-primary);
        }

        .page-header {
            margin-bottom: 32px;
            text-align: center;
            animation: slideDown 0.5s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .page-header h1 {
            font-size: 32px;
            font-weight: 800;
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .page-header h1 i {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 32px;
            animation: robotPulse 2s ease-in-out infinite;
        }

        @keyframes robotPulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }

        .page-header p {
            color: var(--text-tertiary);
            font-size: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .page-header p i {
            color: var(--primary);
        }

        .student-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 6px 16px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 30px;
            backdrop-filter: blur(10px);
        }

        .scores-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 32px;
        }

        .score-box {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 28px 20px;
            text-align: center;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
        }

        .score-box:nth-child(1) { animation-delay: 0.1s; }
        .score-box:nth-child(2) { animation-delay: 0.2s; }
        .score-box:nth-child(3) { animation-delay: 0.3s; }
        .score-box:nth-child(4) { animation-delay: 0.4s; }

        @keyframes cardAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .score-box::before {
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

        .score-box:hover {
            transform: translateY(-6px);
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }

        .score-box:hover::before {
            transform: translateX(0);
        }

        .score-box .value {
            font-size: 42px;
            font-weight: 800;
            margin-bottom: 8px;
            transition: all 0.3s ease;
        }

        .score-box:hover .value {
            transform: scale(1.1);
        }

        .score-box .value.comm { 
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .score-box .value.tech { 
            background: linear-gradient(135deg, var(--accent), #19A77B);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .score-box .value.conf { 
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .score-box .value.overall { 
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .score-box .label {
            font-size: 12px;
            color: var(--text-tertiary);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
        }

        .score-box .trend {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 4px;
            margin-top: 12px;
            font-size: 11px;
            color: var(--success);
        }

        .detail-section {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 28px;
            margin-bottom: 20px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            animation: slideIn 0.5s ease-out forwards;
            opacity: 0;
            position: relative;
            overflow: hidden;
        }

        .detail-section:nth-child(1) { animation-delay: 0.5s; }
        .detail-section:nth-child(2) { animation-delay: 0.6s; }
        .detail-section:nth-child(3) { animation-delay: 0.7s; }
        .detail-section:nth-child(4) { animation-delay: 0.8s; }
        .detail-section:nth-child(5) { animation-delay: 0.9s; }

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

        .detail-section::before {
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

        .detail-section:hover {
            border-color: var(--primary);
            box-shadow: var(--shadow-lg);
            transform: translateX(6px);
        }

        .detail-section:hover::before {
            opacity: 1;
        }

        .detail-section h3 {
            font-size: 18px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .detail-section h3 i {
            font-size: 20px;
        }

        .detail-section p {
            font-size: 15px;
            color: var(--text-secondary);
            line-height: 1.8;
        }

        .tags-container {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .tag-green {
            padding: 8px 18px;
            background: rgba(25, 167, 123, 0.12);
            color: #3BC49A;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 500;
            border: 1px solid rgba(25, 167, 123, 0.3);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            animation: tagPop 0.3s ease-out;
        }

        @keyframes tagPop {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .tag-green:hover {
            background: rgba(25, 167, 123, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.2);
        }

        .tag-orange {
            padding: 8px 18px;
            background: rgba(249, 115, 22, 0.12);
            color: #fb923c;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 500;
            border: 1px solid rgba(249, 115, 22, 0.3);
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            animation: tagPop 0.3s ease-out;
        }

        .tag-orange:hover {
            background: rgba(249, 115, 22, 0.2);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(249, 115, 22, 0.2);
        }

        /* Progress Bar for Scores */
        .score-progress {
            margin-top: 12px;
            height: 4px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 2px;
            overflow: hidden;
        }

        .score-progress-bar {
            height: 100%;
            border-radius: 2px;
            transition: width 1s ease-out;
        }

        .score-progress-bar.comm { background: linear-gradient(90deg, var(--primary), var(--accent)); }
        .score-progress-bar.tech { background: linear-gradient(90deg, var(--accent), #19A77B); }
        .score-progress-bar.conf { background: linear-gradient(90deg, #fbbf24, #f59e0b); }
        .score-progress-bar.overall { background: linear-gradient(90deg, var(--primary-dark), var(--primary)); }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin-top: 32px;
        }

        .btn {
            padding: 14px 28px;
            border-radius: 14px;
            font-size: 14px;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid transparent;
            text-decoration: none;
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: white;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .btn-secondary {
            background: transparent;
            border-color: var(--border-color);
            color: var(--text-secondary);
        }

        .btn-secondary:hover {
            border-color: var(--primary);
            color: var(--primary);
            background: var(--hover-bg);
            transform: translateY(-2px);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .scores-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 12px;
            }

            .page-header h1 {
                font-size: 26px;
            }

            .detail-section {
                padding: 20px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .scores-grid {
                grid-template-columns: 1fr;
            }

            .page-header h1 {
                font-size: 22px;
                flex-direction: column;
            }

            .tags-container {
                justify-content: center;
            }
        }

        /* Loading Animation */
        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid var(--border-color);
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Tooltip */
        [data-tooltip] {
            position: relative;
            cursor: help;
        }

        [data-tooltip]:before {
            content: attr(data-tooltip);
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            padding: 6px 12px;
            background: var(--bg-darker);
            color: var(--text-primary);
            font-size: 12px;
            border-radius: 8px;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
            pointer-events: none;
            z-index: 1000;
        }

        [data-tooltip]:hover:before {
            opacity: 1;
            visibility: visible;
            bottom: calc(100% + 8px);
        }

        /* Print Styles */
        @media print {
            body {
                background: white;
                color: black;
            }

            .back-link,
            .action-buttons {
                display: none;
            }

            .detail-section,
            .score-box {
                background: white;
                border: 1px solid #ddd;
                box-shadow: none;
                break-inside: avoid;
            }

            .score-box .value {
                color: black !important;
                -webkit-text-fill-color: black !important;
            }
        }
        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: rgba(30, 41, 44, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            padding: 24px 16px;
            z-index: 100;
            overflow-y: auto;
            transition: transform 0.3s ease;
        }

        .sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: transparent;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 3px;
        }

        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 8px 12px 24px;
            border-bottom: 1px solid var(--border-color);
            margin-bottom: 24px;
        }

        .sidebar-logo .icon {
            width: 48px;
            height: 48px;
            background: var(--gradient-primary);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--glow-primary);
        }

        .sidebar-logo .icon i {
            color: #fff;
            font-size: 24px;
        }

        .sidebar-logo h2 {
            font-size: 20px;
            font-weight: 700;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
        }

        .nav-section {
            margin-bottom: 28px;
        }

        .nav-section h4 {
            color: var(--text-tertiary);
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding: 0 12px;
            margin-bottom: 14px;
            font-weight: 600;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 14px;
            border-radius: 12px;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 4px;
            position: relative;
            overflow: hidden;
        }

        .nav-link i {
            width: 20px;
            text-align: center;
            font-size: 16px;
        }

        .nav-link:hover {
            background: var(--hover-bg);
            color: var(--primary);
            transform: translateX(4px);
        }

        .nav-link.active {
            background: var(--hover-bg);
            color: var(--primary);
            box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.05);
        }

        .main-content {
            margin-left: 280px;
            padding: 28px 36px;
            position: relative;
            z-index: 1;
            animation: fadeInUp 0.6s ease-out;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .mobile-menu-btn {
            display: none;
            background: none;
            border: none;
            font-size: 24px;
            color: var(--text-primary);
            cursor: pointer;
            margin-right: 12px;
        }

        .mobile-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            z-index: 99;
        }

        .mobile-overlay.active {
            display: block;
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                z-index: 1000;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .mobile-menu-btn {
                display: inline-block;
            }
        }
    </style>
	<jsp:include page="/views/commons/hackerrank_sidebar_styles.jsp" />
</head>

<body>
    <div class="mobile-overlay" id="mobileOverlay"></div>

    <c:choose>
        <c:when test="${not empty sessionScope.admin or not empty sessionScope.loggedInAdmin}">
            <jsp:include page="/views/commons/admin_sidebar.jsp" />
        </c:when>
        <c:when test="${not empty sessionScope.loggedInCompany or not empty sessionScope.company}">
            <jsp:include page="/views/commons/interviewer_sidebar.jsp" />
        </c:when>
        <c:when test="${not empty sessionScope.jobSeeker and sessionScope.jobSeeker.role == 'INTERVIEWER'}">
            <jsp:include page="/views/commons/interviewer_sidebar.jsp" />
        </c:when>
        <c:otherwise>
            <jsp:include page="/views/commons/student_sidebar.jsp" />
        </c:otherwise>
    </c:choose>

    <div class="main-content">
        <div class="top-bar">
            <button class="mobile-menu-btn" id="mobileMenuBtn">
                <i class="fas fa-bars"></i>
            </button>
            <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="back-link" style="margin-bottom: 0;">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>

        <div class="page-header">
            <h1>
                <i class="fas fa-robot"></i>
                Evaluation Detail
            </h1>
            <p>
                <span class="student-badge">
                    <i class="fas fa-user-graduate"></i>
                    Student: ${evaluation.studentName}
                </span>
                <span class="student-badge">
                    <i class="fas fa-calendar-alt"></i>
                    Date: ${evaluation.evaluatedAt}
                </span>
            </p>
        </div>

        <div class="scores-grid">
            <div class="score-box" data-tooltip="Communication skills assessment">
                <div class="value comm">${evaluation.communicationScore}</div>
                <div class="label">Communication</div>
                <div class="score-progress">
                    <div class="score-progress-bar comm" style="width: ${evaluation.communicationScore}%"></div>
                </div>
                <div class="trend">
                    <i class="fas fa-arrow-up"></i>
                    <span>Above average</span>
                </div>
            </div>
            <div class="score-box" data-tooltip="Technical knowledge evaluation">
                <div class="value tech">${evaluation.technicalScore}</div>
                <div class="label">Technical</div>
                <div class="score-progress">
                    <div class="score-progress-bar tech" style="width: ${evaluation.technicalScore}%"></div>
                </div>
                <div class="trend">
                    <i class="fas fa-chart-line"></i>
                    <span>Strong performance</span>
                </div>
            </div>
            <div class="score-box" data-tooltip="Confidence level during interview">
                <div class="value conf">${evaluation.confidenceScore}</div>
                <div class="label">Confidence</div>
                <div class="score-progress">
                    <div class="score-progress-bar conf" style="width: ${evaluation.confidenceScore}%"></div>
                </div>
                <div class="trend">
                    <i class="fas fa-star"></i>
                    <span>Good presence</span>
                </div>
            </div>
            <div class="score-box" data-tooltip="Overall interview performance">
                <div class="value overall">${evaluation.overallScore}</div>
                <div class="label">Overall</div>
                <div class="score-progress">
                    <div class="score-progress-bar overall" style="width: ${evaluation.overallScore}%"></div>
                </div>
                <div class="trend">
                    <i class="fas fa-trophy"></i>
                    <span>Excellent</span>
                </div>
            </div>
        </div>

        <div class="detail-section">
            <h3>
                <i class="fas fa-search-plus" style="color: var(--primary);"></i>
                Answer Analysis
            </h3>
            <p>${evaluation.answerAnalysis}</p>
        </div>

        <div class="detail-section">
            <h3>
                <i class="fas fa-thumbs-up" style="color: #3BC49A;"></i>
                Strengths
            </h3>
            <div class="tags-container">
                <c:forEach var="s" items="${evaluation.strengths.split(',')}">
                    <span class="tag-green">
                        <i class="fas fa-check-circle" style="margin-right: 6px;"></i>
                        ${s.trim()}
                    </span>
                </c:forEach>
            </div>
        </div>

        <div class="detail-section">
            <h3>
                <i class="fas fa-exclamation-triangle" style="color: #fb923c;"></i>
                Areas for Improvement
            </h3>
            <div class="tags-container">
                <c:forEach var="w" items="${evaluation.weaknesses.split(',')}">
                    <span class="tag-orange">
                        <i class="fas fa-arrow-up" style="margin-right: 6px;"></i>
                        ${w.trim()}
                    </span>
                </c:forEach>
            </div>
        </div>

        <div class="detail-section">
            <h3>
                <i class="fas fa-lightbulb" style="color: #fbbf24;"></i>
                Improvement Suggestions
            </h3>
            <p>${evaluation.improvementSuggestions}</p>
        </div>

        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
            <button class="btn btn-primary" onclick="window.print()">
                <i class="fas fa-print"></i>
                Print Report
            </button>
            <button class="btn btn-secondary" onclick="exportAsPDF()">
                <i class="fas fa-download"></i>
                Export PDF
            </button>
        </div>
    </div>

    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate progress bars
            const progressBars = document.querySelectorAll('.score-progress-bar');
            progressBars.forEach(bar => {
                const width = bar.style.width;
                bar.style.width = '0%';
                setTimeout(() => {
                    bar.style.width = width;
                }, 100);
            });

            // Sidebar and Mobile Menu logic
            const mobileMenuBtn = document.getElementById('mobileMenuBtn');
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('mobileOverlay');

            if (mobileMenuBtn && sidebar && overlay) {
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

                mobileMenuBtn.addEventListener('click', openSidebar);
                overlay.addEventListener('click', closeSidebar);

                // Touch swipe support
                let touchStartX = 0;
                document.body.addEventListener('touchstart', e => {
                    touchStartX = e.changedTouches[0].screenX;
                }, { passive: true });

                document.body.addEventListener('touchend', e => {
                    let touchEndX = e.changedTouches[0].screenX;
                    if (touchEndX < touchStartX - 50) closeSidebar();
                    if (touchEndX > touchStartX + 50 && touchStartX < 30) openSidebar();
                }, { passive: true });
            }

            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape') {
                    const sidebar = document.getElementById('sidebar');
                    const overlay = document.getElementById('mobileOverlay');
                    if (sidebar && sidebar.classList.contains('active')) {
                        sidebar.classList.remove('active');
                        overlay.classList.remove('active');
                        document.body.style.overflow = '';
                    } else {
                        window.location.href = '${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard';
                    }
                }
                
                // Ctrl/Cmd + P for print
                if ((e.ctrlKey || e.metaKey) && e.key === 'p') {
                    e.preventDefault();
                    window.print();
                }
            });
        });

        // Export as PDF function
        function exportAsPDF() {
            const btn = event.target.closest('.btn');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<span class="loading-spinner"></span> Generating PDF...';
            btn.disabled = true;
            
            setTimeout(() => {
                window.print();
                btn.innerHTML = originalText;
                btn.disabled = false;
            }, 500);
        }
    </script>
</body>
</html>
</body>
</html>