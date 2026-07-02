<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    // WhatsApp readable format
    DateTimeFormatter fmt = DateTimeFormatter.ofPattern("d MMM yyyy, h:mm a");
    request.setAttribute("fmt", fmt);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Notifications | JobU - Your Activity Center</title>

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

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
            --white: #ffffff;
            --border: #e2e8f0;
            --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
            --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
            --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
            --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
            --radius: 24px;
            --radius-sm: 16px;
            --transition: all 0.4s cubic-bezier(0.2, 0.95, 0.4, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            color: var(--text-dark);
            min-height: 100vh;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #e6f4ef; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--primary-dark); }

        /* ========== PAGE HEADER ========== */
        .page-header {
            background: var(--gradient-dark);
            color: white;
            padding: 50px 0 40px;
            position: relative;
            overflow: hidden;
            margin-bottom: 40px;
        }
        .page-header::before {
            content: '';
            position: absolute;
            top: -30%;
            right: -10%;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(59,196,154,0.15) 0%, transparent 70%);
            border-radius: 50%;
            animation: floatGlow 20s infinite alternate;
            pointer-events: none;
        }
        .page-header::after {
            content: '';
            position: absolute;
            bottom: -20%;
            left: -5%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(25,167,123,0.1) 0%, transparent 70%);
            border-radius: 50%;
            animation: floatGlow2 18s infinite alternate;
            pointer-events: none;
        }
        @keyframes floatGlow {
            0% { transform: translate(0,0) scale(1); opacity: 0.3; }
            100% { transform: translate(-60px, 50px) scale(1.3); opacity: 0.6; }
        }
        @keyframes floatGlow2 {
            0% { transform: translate(0,0) scale(1); opacity: 0.2; }
            100% { transform: translate(60px, -40px) scale(1.2); opacity: 0.5; }
        }
        .page-header h3 {
            font-size: 2rem;
            font-weight: 800;
            margin: 0;
            background: linear-gradient(135deg, #ffffff, #3BC49A);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            animation: textShine 3s infinite;
        }
        .page-header .container {
            position: relative;
            z-index: 10;
        }
        @keyframes textShine {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(8px);
            color: white;
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 50px;
            padding: 8px 20px;
            font-weight: 600;
            font-size: 0.85rem;
            text-decoration: none;
            transition: var(--transition);
        }
        .back-btn:hover {
            background: var(--white);
            color: var(--primary);
            transform: translateX(-4px);
        }

        /* ========== NOTIFICATION CARD ========== */
        .notif-card {
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 20px 24px;
            margin-bottom: 16px;
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.1);
            box-shadow: var(--shadow-sm);
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
            animation: fadeInUp 0.6s ease backwards;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .notif-card:hover {
            transform: translateX(6px);
            box-shadow: var(--shadow-md);
            border-color: rgba(25,167,123,0.2);
        }
        .notif-message {
            display: flex;
            align-items: center;
            gap: 14px;
            flex: 1;
        }
        .notif-icon {
            width: 44px;
            height: 44px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 1.2rem;
        }
        .notif-text {
            font-size: 0.9rem;
            color: var(--text-dark);
            font-weight: 500;
            line-height: 1.5;
        }
        .notif-date {
            display: flex;
            align-items: center;
            gap: 6px;
            font-size: 0.75rem;
            color: var(--text-muted);
            background: var(--bg-light);
            padding: 6px 14px;
            border-radius: 50px;
            white-space: nowrap;
        }
        .notif-date i {
            color: var(--primary);
            font-size: 0.7rem;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 40px;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25,167,123,0.1);
        }
        .empty-state i {
            font-size: 4rem;
            color: var(--primary-light);
            margin-bottom: 20px;
            opacity: 0.6;
        }
        .empty-state h3 {
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 10px;
        }

        /* Alert Info */
        .alert-custom {
            border-radius: var(--radius-sm);
            padding: 16px 20px;
            margin-bottom: 24px;
            border: none;
            font-weight: 500;
        }
        .alert-info-custom {
            background: linear-gradient(135deg, rgba(59,130,246,0.1), rgba(59,130,246,0.05));
            color: #3b82f6;
            border-left: 4px solid #3b82f6;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 35px 0 25px; }
            .page-header h3 { font-size: 1.5rem; }
            .notif-card { flex-direction: column; align-items: flex-start; }
            .notif-date { align-self: flex-end; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInRecruiter}">
                        <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="back-btn">
                            <i class="fas fa-arrow-left"></i> Back to Dashboard
                        </a>
                    </c:when>
                    <c:when test="${not empty sessionScope.loggedInCompany}">
                        <a href="${pageContext.request.contextPath}/company/dashboard" class="back-btn">
                            <i class="fas fa-arrow-left"></i> Back to Dashboard
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/index" class="back-btn">
                            <i class="fas fa-arrow-left"></i> Back Home
                        </a>
                    </c:otherwise>
                </c:choose>
                <h3><i class="fas fa-bell me-2"></i>Notifications</h3>
            </div>
        </div>
    </div>

    <div class="container pb-5">

        <!-- No Notifications -->
        <c:if test="${empty notifications}">
            <div class="empty-state" data-aos="fade-up">
                <i class="fas fa-bell-slash"></i>
                <h3>No Notifications</h3>
                <p class="text-muted">You don't have any notifications at the moment.</p>
            </div>
        </c:if>

        <!-- Notification List -->
        <c:if test="${not empty notifications}">
            <c:forEach items="${notifications}" var="n" varStatus="status">
                <div class="notif-card" data-aos="fade-up" data-aos-delay="${50 + status.index * 20}">
                    <div class="notif-message">
                        <div class="notif-icon">
                            <i class="fas fa-bell"></i>
                        </div>
                        <div class="notif-text">${n.message}</div>
                    </div>
                    <div class="notif-date">
                        <i class="far fa-clock"></i>
                        <c:out value="${n.createdAt.format(fmt)}"/>
                    </div>
                </div>
            </c:forEach>
        </c:if>

    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });
    </script>
</body>
</html>