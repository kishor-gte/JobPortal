<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="in.sp.main.Entities.JobSeeker" %>
<%
    JobSeeker jobSeeker = (JobSeeker) session.getAttribute("jobSeeker");
    pageContext.setAttribute("jobSeeker", jobSeeker);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Verified Companies | JobU - Find Trusted Employers</title>
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
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
            --danger: #ef4444;
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

        /* Main Content */
        .main-content-wrapper {
            margin-left: 280px;
            padding: 32px 40px;
            transition: margin-left 0.3s ease;
        }

        /* Page Header Slim (White Style) */
        .page-header {
            background: #fff !important;
            border-bottom: 1px solid var(--border-color, #e0e6ed) !important;
            padding: 16px 24px !important;
            margin-bottom: 2rem !important;
            position: relative !important;
            z-index: 5 !important;
        }
        .page-header h2 {
            font-size: 20px !important;
            font-weight: 700 !important;
            margin: 0 !important;
            display: flex !important;
            align-items: center !important;
            gap: 10px !important;
            color: var(--primary, #19A77B) !important;
            background: none !important;
            -webkit-background-clip: unset !important;
            background-clip: unset !important;
        }
        .page-header h2 i {
            color: var(--primary, #19A77B) !important;
        }
        .page-header p {
            display: none !important;
        }

        /* Search Form */
        .search-card {
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 20px 24px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 28px;
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
        }
        .search-card:hover {
            box-shadow: var(--shadow-md);
        }
        .search-form {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }
        .search-input-wrapper {
            flex: 1;
            position: relative;
        }
        .search-input-wrapper i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 1rem;
        }
        .search-input-wrapper input {
            width: 100%;
            padding: 14px 16px 14px 48px;
            border: 2px solid var(--border);
            border-radius: 60px;
            font-size: 0.9rem;
            transition: var(--transition);
            background: var(--bg-light);
        }
        .search-input-wrapper input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.1);
            outline: none;
            background: var(--white);
        }
        .search-btn {
            background: var(--gradient);
            border: none;
            padding: 12px 32px;
            border-radius: 60px;
            font-weight: 700;
            color: white;
            transition: var(--transition);
            cursor: pointer;
        }
        .search-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Action Button Row */
        .action-row {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 24px;
        }
        .btn-reported {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: var(--white);
            color: var(--primary);
            border: 1px solid rgba(25,167,123,0.3);
            padding: 10px 24px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.85rem;
            text-decoration: none;
            transition: var(--transition);
        }
        .btn-reported:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }

        /* Company Cards Grid */
        .company-list {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 24px;
        }
        .company-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 24px;
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.1);
            box-shadow: var(--shadow-sm);
            display: flex;
            justify-content: space-between;
            align-items: center;
            animation: fadeInUp 0.6s ease backwards;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .company-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-lg);
            border-color: rgba(25,167,123,0.2);
        }
        .company-info-wrapper {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .company-logo {
            width: 60px;
            height: 60px;
            object-fit: contain;
            border-radius: 16px;
            background: var(--bg-light);
            padding: 8px;
            border: 1px solid var(--border);
            transition: var(--transition);
        }
        .company-card:hover .company-logo {
            transform: scale(1.02);
            border-color: var(--primary-light);
        }
        .company-info {
            display: flex;
            flex-direction: column;
        }
        .company-name {
            font-size: 1rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 4px;
        }
        .company-details {
            color: var(--text-muted);
            font-size: 0.75rem;
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }
        .action-icons {
            display: flex;
            gap: 16px;
        }
        .icon-wrapper {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 6px;
            cursor: pointer;
            transition: var(--transition);
        }
        .icon-circle {
            width: 44px;
            height: 44px;
            background: rgba(25,167,123,0.1);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: var(--transition);
        }
        .icon-circle i {
            font-size: 1.2rem;
            color: var(--primary);
        }
        .icon-wrapper:hover .icon-circle {
            background: var(--gradient);
            transform: translateY(-3px);
        }
        .icon-wrapper:hover .icon-circle i {
            color: white;
        }
        .tooltip-text {
            font-size: 0.7rem;
            font-weight: 600;
            color: var(--text-muted);
        }
        .icon-wrapper:hover .tooltip-text {
            color: var(--primary);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 40px;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow-sm);
        }
        .empty-state i {
            font-size: 4rem;
            color: var(--primary-light);
            margin-bottom: 20px;
        }

        /* Mobile Toggle */
        .sidebar-toggle-btn {
            display: none;
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1001;
            background: var(--gradient);
            color: white;
            border: none;
            padding: 12px 16px;
            border-radius: 12px;
            font-size: 1.2rem;
            cursor: pointer;
            box-shadow: var(--shadow-sm);
        }
        .sidebar-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.5);
            z-index: 999;
        }

        @media (max-width: 768px) {
            .career-sidebar { transform: translateX(-100%); }
            .career-sidebar.show { transform: translateX(0); }
            .sidebar-toggle-btn { display: block; }
            .sidebar-overlay.show { display: block; }
            .main-content-wrapper { margin-left: 0; padding: 80px 20px 32px; }
            .company-list { grid-template-columns: 1fr; }
            .company-card { flex-direction: column; text-align: center; gap: 16px; }
            .company-info-wrapper { flex-direction: column; }
            .action-icons { justify-content: center; }
        }
    </style>
</head>
<body>

<jsp:include page="/views/commons/student_sidebar.jsp" />

<!-- Main Content -->
<div class="main-content-wrapper">
    <div class="page-header" data-aos="fade-down">
        <h2><i class="fas fa-building" style="color: var(--primary); margin-right: 10px;"></i>Verified Companies</h2>
        <p>Browse and connect with trusted employers</p>
    </div>

    <!-- Search Card -->
    <div class="search-card" data-aos="fade-up" data-aos-delay="100">
        <form method="get" action="${pageContext.request.contextPath}/company/Alllist" class="search-form">
            <div class="search-input-wrapper">
                <i class="fas fa-search"></i>
                <input type="text" name="keyword" placeholder="Search companies by name..." value="${keyword}">
            </div>
            <button type="submit" class="search-btn">Search</button>
        </form>
    </div>

    <!-- Action Row -->
    <div class="action-row" data-aos="fade-up" data-aos-delay="150">
        <a href="${pageContext.request.contextPath}/alerts/list" class="btn-reported">
            <i class="fas fa-flag"></i> View Reported Companies
        </a>
    </div>

    <!-- Company List Grid -->
    <div class="company-list">
        <c:if test="${not empty companies}">
            <c:forEach var="company" items="${companies}" varStatus="status">
                <div class="company-card" data-aos="fade-up" data-aos-delay="${200 + status.index * 30}">
                    <div class="company-info-wrapper">
                        <img src="${pageContext.request.contextPath}${company.logo}" alt="Logo" class="company-logo"
                             onerror="this.src='${pageContext.request.contextPath}/assets/images/default-company.png'">
                        <div class="company-info">
                            <div class="company-name">${company.name}</div>
                            <div class="company-details">
                                <span><i class="fas fa-industry"></i> ${company.industry}</span>
                                <span><i class="fas fa-map-marker-alt"></i> ${company.location}</span>
                            </div>
                        </div>
                    </div>
                    <div class="action-icons">
                        <div class="icon-wrapper" onclick="location.href='${pageContext.request.contextPath}/company/details/${company.id}'">
                            <div class="icon-circle"><i class="fas fa-user"></i></div>
                            <div class="tooltip-text">View Profile</div>
                        </div>
                        <div class="icon-wrapper" onclick="location.href='${pageContext.request.contextPath}/company/review/${company.id}'">
                            <div class="icon-circle"><i class="fas fa-star"></i></div>
                            <div class="tooltip-text">Rate Company</div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty companies}">
            <div class="empty-state">
                <i class="fas fa-building"></i>
                <h3>No Companies Found</h3>
                <p>Try adjusting your search criteria.</p>
            </div>
        </c:if>
    </div>
</div>

<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true, offset: 50 });
</script>
</body>
</html>