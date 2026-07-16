<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Coding Competitions | Student Dashboard</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --primary-light: #3BC49A;
            --primary-glow: rgba(25,167,123,0.15);
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-light: #f4fbf9;
            --text-dark: #1a2c2f;
            --text-muted: #5a6e66;
            --text-main: #1a2c2f;
            --text-secondary: #5a6e66;
            --white: #ffffff;
            --border: #e2e8f0;
            --danger: #ef4444;
            --success: #19A77B;
            --warning: #f59e0b;
            --bg-surface: #ffffff;
            --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --gradient-primary: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
            --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
            --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
            --radius-md: 16px;
            --radius-lg: 24px;
            --transition: all 0.4s cubic-bezier(0.2, 0.95, 0.4, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            color: var(--text-dark);
            display: flex;
            min-height: 100vh;
        }

        .main-content {
            margin-left: 280px;
            padding: 32px 40px;
            width: calc(100% - 280px);
            transition: margin-left 0.3s ease;
        }

        .header {
            background: #fff;
            border-bottom: 1px solid var(--border);
            padding: 16px 24px;
            margin-bottom: 2rem;
            position: relative;
            z-index: 5;
            border-radius: var(--radius-md);
            box-shadow: var(--shadow-sm);
        }

        .header h1 {
            font-size: 20px;
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
            gap: 10px;
            color: var(--primary);
        }

        .header p {
            display: none;
        }

        /* Tabs */
        .tabs {
            display: flex;
            gap: 16px;
            margin-bottom: 30px;
            border-bottom: 1px solid var(--border);
            padding-bottom: 2px;
        }

        .tab-btn {
            background: transparent;
            border: none;
            color: var(--text-muted);
            font-size: 15px;
            font-weight: 600;
            padding: 12px 20px;
            cursor: pointer;
            position: relative;
            transition: var(--transition);
        }

        .tab-btn:hover {
            color: var(--primary);
        }

        .tab-btn.active {
            color: var(--primary);
        }

        .tab-btn.active::after {
            content: '';
            position: absolute;
            bottom: -3px;
            left: 0;
            width: 100%;
            height: 3px;
            background: var(--gradient);
            border-radius: 3px 3px 0 0;
        }

        /* Competition Cards */
        .tab-pane {
            display: none;
            animation: fadeIn 0.4s ease;
        }
        .tab-pane.active {
            display: block;
        }

        .competitions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 24px;
        }

        .comp-card {
            background: var(--white);
            border-radius: var(--radius-lg);
            overflow: hidden;
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.1);
            box-shadow: var(--shadow-sm);
            display: flex;
            flex-direction: column;
        }

        .comp-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-lg);
            border-color: rgba(25,167,123,0.2);
        }

        .comp-banner {
            height: 120px;
            background: var(--bg-light);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            color: var(--primary-light);
            position: relative;
        }

        .comp-banner img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .comp-status-badge {
            position: absolute;
            top: 12px;
            right: 12px;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            backdrop-filter: blur(4px);
        }

        .status-upcoming { background: rgba(25, 167, 123, 0.9); color: white; }
        .status-live { background: rgba(245, 158, 11, 0.9); color: #000000; animation: pulseLive 2s infinite; }
        .status-completed { background: rgba(90, 110, 102, 0.9); color: white; }
        .status-closed { background: rgba(239, 68, 68, 0.9); color: white; }

        @keyframes pulseLive {
            0% { box-shadow: 0 0 0 0 rgba(245, 158, 11, 0.4); }
            70% { box-shadow: 0 0 0 10px rgba(245, 158, 11, 0); }
            100% { box-shadow: 0 0 0 0 rgba(245, 158, 11, 0); }
        }

        .comp-body {
            padding: 24px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .comp-title {
            font-size: 1.1rem;
            font-weight: 700;
            margin-bottom: 8px;
            color: var(--text-dark);
        }

        .comp-desc {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-bottom: 16px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .comp-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            margin-bottom: 20px;
        }

        .detail-item {
            display: flex;
            align-items: flex-start;
            gap: 8px;
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .detail-item i {
            color: var(--primary);
            margin-top: 3px;
        }

        .comp-footer {
            margin-top: auto;
            padding-top: 16px;
            border-top: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .btn-register {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            transition: var(--transition);
            width: 100%;
            text-align: center;
        }

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        .btn-register:disabled {
            background: var(--border);
            color: var(--text-muted);
            cursor: not-allowed;
            transform: none;
            box-shadow: none;
        }

        .btn-start {
            background: var(--gradient);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.9rem;
            cursor: pointer;
            transition: var(--transition);
            width: 100%;
            text-align: center;
            text-decoration: none;
        }

        .btn-start:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
            color: white;
        }
        
        .countdown {
            font-size: 0.85rem;
            font-weight: 700;
            color: #b45309;
            text-align: center;
            padding: 8px;
            background: rgba(245, 158, 11, 0.1);
            border-radius: 8px;
            margin-top: 12px;
            letter-spacing: 0.5px;
        }

        /* Toast */
        .toast-container {
            position: fixed;
            bottom: 24px;
            right: 24px;
            z-index: 9999;
        }
        
        .toast {
            background: var(--white);
            border-left: 4px solid var(--success);
            color: var(--text-dark);
            padding: 16px 24px;
            border-radius: 8px;
            box-shadow: var(--shadow-md);
            display: flex;
            align-items: center;
            gap: 12px;
            margin-top: 12px;
            transform: translateX(120%);
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .toast.show {
            transform: translateX(0);
        }
        
        .toast.error {
            border-left-color: var(--danger);
        }
        
        .toast i.success-icon { color: var(--success); }
        .toast i.error-icon { color: var(--danger); }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
                width: 100%;
                padding: 80px 20px 32px;
            }
        }
    </style>
</head>
<body>

    <!-- Sidebar Include -->
    <jsp:include page="/views/commons/student_sidebar.jsp" />

    <main class="main-content">
        <div class="header">
            <h1><i class="fas fa-trophy" style="color: var(--primary); margin-right: 10px;"></i> Coding Competitions</h1>
            <p>Challenge yourself, compete with peers, and showcase your skills.</p>
        </div>

        <div class="tabs" role="tablist" aria-label="Competition tabs">
            <button class="tab-btn active" id="tab-upcoming" role="tab" aria-selected="true" aria-controls="upcoming" data-tab="upcoming">Upcoming</button>
            <button class="tab-btn" id="tab-live" role="tab" aria-selected="false" aria-controls="live" data-tab="live">Live</button>
            <button class="tab-btn" id="tab-completed" role="tab" aria-selected="false" aria-controls="completed" data-tab="completed">Completed</button>
            <button class="tab-btn" id="tab-my-competitions" role="tab" aria-selected="false" aria-controls="my-competitions" data-tab="my-competitions">My Competitions</button>
        </div>

        <%
            LocalDateTime currentNow = LocalDateTime.now();
            request.setAttribute("now", currentNow);
            DateTimeFormatter dtFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy h:mm a");
            request.setAttribute("dtFormatter", dtFormatter);
            DateTimeFormatter shortFormatter = DateTimeFormatter.ofPattern("MMM dd, h:mm a");
            request.setAttribute("shortFormatter", shortFormatter);
            DateTimeFormatter sortFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
            request.setAttribute("sortFormatter", sortFormatter);
        %>

        <!-- Upcoming Tab -->
        <div class="tab-pane active" id="upcoming" role="tabpanel" aria-labelledby="tab-upcoming">
            <div class="competitions-grid">
                <c:set var="upcomingCount" value="0"/>
                <c:forEach var="comp" items="${allCompetitions}">
                    <c:if test="${comp.examStartTime.format(sortFormatter) gt now.format(sortFormatter)}">
                        <c:set var="upcomingCount" value="${upcomingCount + 1}"/>
                        <%@ include file="comp-card.jsp" %>
                    </c:if>
                </c:forEach>
                <c:if test="${upcomingCount == 0}">
                    <p style="color: var(--text-secondary); text-align: center; grid-column: 1/-1; padding: 40px;">No upcoming competitions right now.</p>
                </c:if>
            </div>
        </div>

        <!-- Live Tab -->
        <div class="tab-pane" id="live" role="tabpanel" aria-labelledby="tab-live">
            <div class="competitions-grid">
                <c:set var="liveCount" value="0"/>
                <c:forEach var="comp" items="${allCompetitions}">
                    <c:set var="isCompleted" value="false"/>
                    <c:forEach var="completedId" items="${completedCompetitionIds}">
                        <c:if test="${completedId == comp.id}">
                            <c:set var="isCompleted" value="true"/>
                        </c:if>
                    </c:forEach>
                    <c:if test="${!isCompleted && (comp.examStartTime.format(sortFormatter) le now.format(sortFormatter)) && comp.examStartTime.plusMinutes(comp.examDurationMinutes).format(sortFormatter) gt now.format(sortFormatter)}">
                        <c:set var="liveCount" value="${liveCount + 1}"/>
                        <%@ include file="comp-card.jsp" %>
                    </c:if>
                </c:forEach>
                <c:if test="${liveCount == 0}">
                    <p style="color: var(--text-secondary); text-align: center; grid-column: 1/-1; padding: 40px;">No live competitions at the moment.</p>
                </c:if>
            </div>
        </div>

        <!-- Completed Tab -->
        <div class="tab-pane" id="completed" role="tabpanel" aria-labelledby="tab-completed">
            <div class="competitions-grid">
                <c:set var="compCount" value="0"/>
                <c:forEach var="comp" items="${allCompetitions}">
                    <c:set var="isCompleted" value="false"/>
                    <c:forEach var="completedId" items="${completedCompetitionIds}">
                        <c:if test="${completedId == comp.id}">
                            <c:set var="isCompleted" value="true"/>
                        </c:if>
                    </c:forEach>
                    <c:if test="${isCompleted || comp.examStartTime.plusMinutes(comp.examDurationMinutes).format(sortFormatter) lt now.format(sortFormatter)}">
                        <c:set var="compCount" value="${compCount + 1}"/>
                        <%@ include file="comp-card.jsp" %>
                    </c:if>
                </c:forEach>
                <c:if test="${compCount == 0}">
                    <p style="color: var(--text-secondary); text-align: center; grid-column: 1/-1; padding: 40px;">No completed competitions yet.</p>
                </c:if>
            </div>
        </div>

        <!-- My Competitions Tab -->
        <div class="tab-pane" id="my-competitions" role="tabpanel" aria-labelledby="tab-my-competitions">
            <div class="competitions-grid">
                <c:choose>
                    <c:when test="${not empty studentRegistrations}">
                        <c:forEach var="reg" items="${studentRegistrations}">
                            <!-- Find corresponding competition -->
                            <c:set var="comp" value="${null}"/>
                            <c:forEach var="c" items="${allCompetitions}">
                                <c:if test="${c.id == reg.competitionId}">
                                    <c:set var="comp" value="${c}"/>
                                </c:if>
                            </c:forEach>
                            
                            <c:if test="${not empty comp}">
                                <c:set var="isCompleted" value="false"/>
                                <c:forEach var="completedId" items="${completedCompetitionIds}">
                                    <c:if test="${completedId == comp.id}">
                                        <c:set var="isCompleted" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <!-- My Competition Card -->
                                <div class="comp-card">
                                    <div class="comp-banner">
                                        <c:choose>
                                            <c:when test="${not empty comp.bannerImage}">
                                                <img src="${comp.bannerImage}" alt="Competition Banner for ${comp.title}">
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fas fa-code" aria-hidden="true"></i>
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="comp-status-badge ${reg.status eq 'REGISTERED' ? 'status-upcoming' : 'status-closed'}" style="right: auto; left: 12px; background: rgba(0,0,0,0.8);">
                                            ${reg.status}
                                        </div>
                                    </div>
                                    <div class="comp-body">
                                        <h2 class="comp-title">${comp.title}</h2>
                                        <div class="comp-details" style="grid-template-columns: 1fr;">
                                            <div class="detail-item"><i class="fas fa-calendar-alt"></i> Exam: 
                                                <c:choose>
                                                    <c:when test="${not empty comp.examStartTime}">
                                                        ${comp.examStartTime.format(dtFormatter)}
                                                    </c:when>
                                                    <c:otherwise>
                                                        TBA
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class="detail-item"><i class="fas fa-stopwatch"></i> Duration: ${comp.examDurationMinutes} Mins</div>
                                            <div class="detail-item"><i class="fas fa-language"></i> Lang: ${comp.allowedLanguages}</div>
                                        </div>
                                        
                                        <div class="comp-footer" style="flex-direction: column; gap: 10px;">
                                            <!-- Action Button / Countdown -->
                                            <c:choose>
                                                <c:when test="${isCompleted}">
                                                    <button class="btn-register" disabled style="background: var(--text-muted); color: white;"><i class="fas fa-check-circle"></i> Exam Submitted</button>
                                                </c:when>
                                                <c:when test="${comp.examStartTime.plusMinutes(comp.examDurationMinutes).format(sortFormatter) lt now.format(sortFormatter)}">
                                                    <button class="btn-register" disabled>Competition Closed</button>
                                                </c:when>
                                                <c:when test="${(comp.examStartTime.format(sortFormatter) le now.format(sortFormatter)) && comp.examStartTime.plusMinutes(comp.examDurationMinutes).format(sortFormatter) gt now.format(sortFormatter)}">
                                                    <a href="${pageContext.request.contextPath}/student/coding-competitions/rules/${comp.id}" class="btn-start" role="button"><i class="fas fa-play" aria-hidden="true"></i> Start Exam</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <c:choose>
                                                        <c:when test="${not empty comp.examStartTime}">
                                                            
                                                            <button class="btn-register" disabled style="font-size: 0.8rem; background: var(--success);"><i class="fas fa-check-circle"></i> Registered</button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="btn-register" disabled style="background: var(--success);"><i class="fas fa-check-circle"></i> Registered</button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <!-- Live Countdown Data -->
                                                    <div class="countdown" data-exam-time="${comp.examStartTime}">
                                                        Calculating...
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p style="color: var(--text-secondary); text-align: center; grid-column: 1/-1; padding: 40px;">You haven't registered for any competitions yet.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <!-- Toast Container -->
    <div class="toast-container" id="toastContainer"></div>

    <script>
        // Tab Switching Setup
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('.tab-btn').forEach(btn => {
                btn.addEventListener('click', function() {
                    const tabId = this.getAttribute('data-tab');
                    if(!tabId) return;
                    
                    document.querySelectorAll('.tab-btn').forEach(b => {
                        b.classList.remove('active');
                        b.setAttribute('aria-selected', 'false');
                    });
                    document.querySelectorAll('.tab-pane').forEach(pane => pane.classList.remove('active'));
                    
                    this.classList.add('active');
                    this.setAttribute('aria-selected', 'true');
                    const targetPane = document.getElementById(tabId);
                    if (targetPane) {
                        targetPane.classList.add('active');
                    }
                });
            });
        });

        // Countdown Logic
        function updateCountdowns() {
            const elements = document.querySelectorAll('.countdown');
            elements.forEach(el => {
                const examTimeStr = el.getAttribute('data-exam-time');
                if (!examTimeStr) return;
                
                const examTime = new Date(examTimeStr).getTime();
                const now = new Date().getTime();
                const diff = examTime - now;
                
                if (diff <= 0) {
                    el.innerText = "Exam is Live! Please refresh.";
                    el.style.color = "var(--success)";
                    el.style.background = "rgba(16, 185, 129, 0.1)";
                    return;
                }
                
                const days = Math.floor(diff / (1000 * 60 * 60 * 24));
                const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                const mins = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
                const secs = Math.floor((diff % (1000 * 60)) / 1000);
                
                el.innerText = 'Starts in: ' + String(days).padStart(2,'0') + 'd ' + String(hours).padStart(2,'0') + 'h ' + String(mins).padStart(2,'0') + 'm ' + String(secs).padStart(2,'0') + 's';
            });
        }
        
        setInterval(updateCountdowns, 1000);
        updateCountdowns();

        // Registration Logic
        function registerForCompetition(compId) {
            const btn = document.getElementById('regBtn_' + compId);
            const originalText = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Registering...';
            btn.disabled = true;

            fetch('${pageContext.request.contextPath}/student/coding-competitions/register', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: 'competitionId=' + compId
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showToast(data.message, false);
                    setTimeout(() => window.location.reload(), 1500);
                } else {
                    showToast(data.message, true);
                    btn.innerHTML = originalText;
                    btn.disabled = false;
                }
            })
            .catch(error => {
                showToast("An error occurred during registration.", true);
                btn.innerHTML = originalText;
                btn.disabled = false;
            });
        }

        // Toast Notification Logic
        function showToast(message, isError) {
            const container = document.getElementById('toastContainer');
            const toast = document.createElement('div');
            toast.className = `toast ${isError ? 'error' : ''}`;
            
            const icon = isError ? '<i class="fas fa-exclamation-circle error-icon"></i>' : '<i class="fas fa-check-circle success-icon"></i>';
            
            toast.innerHTML = `${icon} <span>${message}</span>`;
            container.appendChild(toast);
            
            setTimeout(() => toast.classList.add('show'), 10);
            
            setTimeout(() => {
                toast.classList.remove('show');
                setTimeout(() => toast.remove(), 300);
            }, 3000);
        }

        // Check for URL errors
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            const errorType = urlParams.get('error');
            let errorMsg = "An error occurred.";
            if (errorType === 'ExamAlreadySubmitted') errorMsg = "You have already submitted this exam.";
            else if (errorType === 'ExamHasNotStarted') errorMsg = "The exam has not started yet.";
            else if (errorType === 'ExamHasEnded') errorMsg = "The exam has already ended.";
            
            // Wait slightly for DOM to be fully ready before showing toast
            setTimeout(() => {
                showToast(errorMsg, true);
            }, 500);
            
            // Clean up URL
            window.history.replaceState({}, document.title, window.location.pathname);
        }
    </script>
</body>
</html>
