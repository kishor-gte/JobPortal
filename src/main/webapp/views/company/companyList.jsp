<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Verified Companies | JobU - Trusted Employers</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
            --success: #19A77B;
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

        /* ========== PAGE HEADER ========== */
        .page-header {
            background: var(--gradient-dark);
            color: white;
            padding: 60px 0 50px;
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
        }
        @keyframes floatGlow {
            0% { transform: translate(0,0) scale(1); opacity: 0.3; }
            100% { transform: translate(-60px, 50px) scale(1.3); opacity: 0.6; }
        }
        @keyframes floatGlow2 {
            0% { transform: translate(0,0) scale(1); opacity: 0.2; }
            100% { transform: translate(60px, -40px) scale(1.2); opacity: 0.5; }
        }
        .page-header h1 {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 12px;
            background: linear-gradient(135deg, #ffffff, #3BC49A);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            animation: textShine 3s infinite;
        }
        @keyframes textShine {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }
        .page-header p {
            font-size: 1rem;
            opacity: 0.9;
        }
        .company-count {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(8px);
            padding: 8px 20px;
            border-radius: 50px;
            font-size: 0.85rem;
            margin-top: 20px;
            border: 1px solid rgba(255,255,255,0.2);
        }

        /* ========== SEARCH SECTION ========== */
        .search-section {
            background: var(--white);
            border-radius: var(--radius-sm);
            padding: 20px 24px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 32px;
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
        }
        .search-section:hover {
            box-shadow: var(--shadow-md);
        }
        .search-input-group {
            position: relative;
        }
        .search-input-group i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 1rem;
            z-index: 1;
        }
        .search-input-group input {
            padding-left: 48px;
            border-radius: 60px;
            border: 2px solid var(--border);
            font-size: 0.9rem;
            transition: var(--transition);
            height: 52px;
            background: var(--bg-light);
        }
        .search-input-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.1);
            background: var(--white);
        }

        /* ========== COMPANY CARDS ========== */
        .companies-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 24px;
        }
        .company-card-item {
            animation: fadeInUp 0.6s ease backwards;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .company-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 24px;
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.1);
            box-shadow: var(--shadow-sm);
            height: 100%;
            display: flex;
            flex-direction: column;
            position: relative;
            overflow: hidden;
        }
        .company-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient);
            transform: scaleX(0);
            transition: transform 0.5s ease;
            transform-origin: left;
        }
        .company-card:hover::before {
            transform: scaleX(1);
        }
        .company-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg);
            border-color: rgba(25,167,123,0.2);
        }
        .company-header {
            display: flex;
            align-items: center;
            gap: 16px;
            margin-bottom: 20px;
        }
        .company-logo-wrapper {
            flex-shrink: 0;
        }
        .company-logo {
            width: 70px;
            height: 70px;
            object-fit: contain;
            border-radius: 20px;
            background: linear-gradient(135deg, var(--bg-light), var(--white));
            padding: 10px;
            border: 1px solid rgba(25,167,123,0.15);
            transition: var(--transition);
        }
        .company-card:hover .company-logo {
            transform: scale(1.02);
            border-color: var(--primary-light);
        }
        .company-info {
            flex: 1;
        }
        .company-name {
            font-size: 1.1rem;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 6px;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }
        .verified-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            background: rgba(25,167,123,0.12);
            color: var(--primary);
            font-size: 0.65rem;
            font-weight: 600;
            padding: 3px 8px;
            border-radius: 50px;
        }
        .company-industry {
            display: flex;
            align-items: center;
            gap: 6px;
            color: var(--text-muted);
            font-size: 0.75rem;
        }
        .company-industry i {
            color: var(--primary);
            font-size: 0.7rem;
        }
        .company-actions {
            display: flex;
            gap: 12px;
            margin-top: 20px;
            padding-top: 16px;
            border-top: 1px solid var(--border);
        }
        .btn-action {
            flex: 1;
            padding: 10px 16px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }
        .btn-view {
            background: var(--gradient);
            color: white;
            box-shadow: 0 4px 12px rgba(25,167,123,0.25);
        }
        .btn-view:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.35);
            color: white;
        }
        .btn-delete {
            background: rgba(239,68,68,0.1);
            color: var(--danger);
            border: 1px solid rgba(239,68,68,0.2);
        }
        .btn-delete:hover {
            background: var(--danger);
            color: white;
            transform: translateY(-2px);
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
        .empty-state p {
            color: var(--text-muted);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header h1 { font-size: 1.8rem; }
            .companies-grid { grid-template-columns: 1fr; gap: 20px; }
            .company-header { flex-direction: column; text-align: center; }
            .company-info { text-align: center; }
            .company-name { justify-content: center; }
            .company-industry { justify-content: center; }
            .company-actions { flex-direction: column; }
            .btn-action { width: 100%; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container">
            <a href="${pageContext.request.contextPath}/company/dashboard" style="display: inline-flex; align-items: center; gap: 0.5rem; color: white; text-decoration: none; font-size: 0.85rem; font-weight: 600; background: rgba(255,255,255,0.15); backdrop-filter: blur(8px); padding: 0.4rem 1rem; border-radius: 40px; margin-bottom: 0.75rem; transition: all 0.3s ease; border: 1px solid rgba(255,255,255,0.2);" onmouseover="this.style.background='rgba(255,255,255,0.25)'" onmouseout="this.style.background='rgba(255,255,255,0.15)'">
                <i class="fas fa-arrow-left"></i> Back to Company Dashboard
            </a>
            <h1><i class="fas fa-building me-2"></i>Verified Companies</h1>
            <p>Manage all verified companies on the platform</p>
            <div class="company-count">
                <i class="fas fa-check-circle"></i>
                <span id="companyCount">${fn:length(companies)} Companies</span>
            </div>
        </div>
    </div>

    <div class="container">
        <!-- Search Section -->
        <div class="search-section" data-aos="fade-up" data-aos-delay="100">
            <div class="search-input-group">
                <i class="fas fa-search"></i>
                <input type="text" 
                       id="searchInput" 
                       class="form-control" 
                       placeholder="Search companies by name or industry...">
            </div>
        </div>

        <!-- Company Listings -->
        <c:choose>
            <c:when test="${empty companies}">
                <div class="empty-state" data-aos="fade-up" data-aos-delay="200">
                    <i class="fas fa-building"></i>
                    <h3>No Verified Companies</h3>
                    <p>There are no verified companies in the system at the moment.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="companies-grid" id="companyList">
                    <c:forEach var="company" items="${companies}" varStatus="status">
                        <div class="company-card-item" 
                             data-name="${fn:toLowerCase(company.name)}" 
                             data-industry="${fn:toLowerCase(company.industry)}"
                             data-aos="fade-up" 
                             data-aos-delay="${100 + status.index * 30}">
                            <div class="company-card">
                                <div class="company-header">
                                    <div class="company-logo-wrapper">
                                        <img src="${pageContext.request.contextPath}${company.logo}" 
                                             alt="${company.name} Logo" 
                                             class="company-logo"
                                             onerror="this.src='${pageContext.request.contextPath}/images/default-company.png'; this.onerror=null;">
                                    </div>
                                    <div class="company-info">
                                        <div class="company-name">
                                            ${company.name}
                                            <span class="verified-badge">
                                                <i class="fas fa-check-circle"></i> Verified
                                            </span>
                                        </div>
                                        <div class="company-industry">
                                            <i class="fas fa-industry"></i>
                                            <span>${company.industry}</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="company-actions">
                                    <a href="${pageContext.request.contextPath}/company/profile/${company.id}" 
                                       class="btn-action btn-view">
                                        <i class="fas fa-eye"></i> View Company
                                    </a>
                                    <a href="${pageContext.request.contextPath}/company/delete/${company.id}"
                                       onclick="return confirm('Delete ${company.name}? This cannot be undone.');"
                                       class="btn-action btn-delete">
                                        <i class="fas fa-trash"></i> Delete
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        // Initialize AOS
        AOS.init({ duration: 800, once: true, offset: 50 });
        
        // Search functionality
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const companyCards = document.querySelectorAll('.company-card-item');
            const companyCount = document.getElementById('companyCount');
            const totalCount = companyCards.length;
            
            if (searchInput) {
                searchInput.addEventListener('keyup', function() {
                    const filter = this.value.toLowerCase().trim();
                    let visibleCount = 0;
                    
                    companyCards.forEach(function(card) {
                        const name = card.getAttribute('data-name') || '';
                        const industry = card.getAttribute('data-industry') || '';
                        
                        if (name.includes(filter) || industry.includes(filter)) {
                            card.style.display = '';
                            visibleCount++;
                        } else {
                            card.style.display = 'none';
                        }
                    });
                    
                    if (companyCount) {
                        if (filter === '') {
                            companyCount.textContent = totalCount + ' Companies';
                        } else {
                            companyCount.textContent = visibleCount + ' of ' + totalCount + ' Companies';
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>