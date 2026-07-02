<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Corporate Sports Events | JobU - Team Building & Sports</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
            padding: 60px 0 50px;
            position: relative;
            overflow: hidden;
            margin-bottom: 50px;
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
        .page-header h2 {
            font-size: 2rem;
            font-weight: 800;
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

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: rgba(255,255,255,0.15);
            backdrop-filter: blur(8px);
            color: white;
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 50px;
            padding: 10px 24px;
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

        /* ========== SPORTS CARDS ========== */
        .sports-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 30px;
            margin-top: 20px;
        }
        .sports-card {
            background: var(--white);
            border-radius: var(--radius);
            overflow: hidden;
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.1);
            box-shadow: var(--shadow-sm);
            animation: fadeInUp 0.6s ease backwards;
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .sports-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-lg);
            border-color: rgba(25,167,123,0.2);
        }
        .card-img-wrapper {
            height: 220px;
            overflow: hidden;
            position: relative;
        }
        .card-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        .sports-card:hover .card-img {
            transform: scale(1.05);
        }
        .card-badge {
            position: absolute;
            top: 15px;
            right: 15px;
            background: var(--gradient);
            color: white;
            padding: 6px 14px;
            border-radius: 50px;
            font-size: 0.7rem;
            font-weight: 700;
            box-shadow: var(--shadow-sm);
        }
        .card-body {
            padding: 24px;
        }
        .card-title {
            font-size: 1.2rem;
            font-weight: 800;
            color: var(--text-dark);
            margin-bottom: 8px;
        }
        .card-location {
            display: flex;
            align-items: center;
            gap: 6px;
            color: var(--text-muted);
            font-size: 0.8rem;
            margin-bottom: 12px;
        }
        .card-location i {
            color: var(--primary);
        }
        .card-description {
            color: var(--text-muted);
            font-size: 0.85rem;
            line-height: 1.6;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .price-tag {
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--primary);
        }
        .price-unit {
            font-size: 0.7rem;
            font-weight: 500;
            color: var(--text-muted);
        }
        .btn-book {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 10px 20px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            color: white;
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

        /* Alert Messages */
        .alert-custom {
            border-radius: 16px;
            padding: 16px 20px;
            margin-bottom: 24px;
            border: none;
            font-weight: 500;
        }
        .alert-success-custom {
            background: linear-gradient(135deg, rgba(25,167,123,0.1), rgba(59,196,154,0.05));
            color: var(--primary-dark);
            border-left: 4px solid var(--primary);
        }
        .alert-danger-custom {
            background: linear-gradient(135deg, rgba(239,68,68,0.1), rgba(239,68,68,0.05));
            color: #ef4444;
            border-left: 4px solid #ef4444;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 40px 0 30px; }
            .page-header h2 { font-size: 1.5rem; }
            .sports-grid { grid-template-columns: 1fr; gap: 20px; }
            .card-img-wrapper { height: 180px; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <h2><i class="fas fa-futbol me-2"></i>Corporate Sports Events</h2>
                    <p>Explore and book sports services for your company</p>
                </div>
                <a href="${pageContext.request.contextPath}/company/dashboard" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <div class="container py-4">

        <!-- Alert Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success-custom alert-custom" data-aos="fade-up">
                <i class="fas fa-check-circle me-2"></i>${message}
                <button type="button" class="btn-close float-end" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger-custom alert-custom" data-aos="fade-up">
                <i class="fas fa-exclamation-circle me-2"></i>${error}
                <button type="button" class="btn-close float-end" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Sports Services Grid -->
        <c:choose>
            <c:when test="${empty services}">
                <div class="empty-state" data-aos="fade-up">
                    <i class="fas fa-futbol"></i>
                    <h3>No Sports Services Available</h3>
                    <p>No sports services available at the moment.</p>
                    <p class="small text-muted">Please check back later or contact admin.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="sports-grid">
                    <c:forEach items="${services}" var="service" varStatus="status">
                        <div class="sports-card" data-aos="fade-up" data-aos-delay="${50 + status.index * 30}">
                            <div class="card-img-wrapper">
                                <c:choose>
                                    <c:when test="${not empty service.coverImageUrl}">
                                        <img src="${pageContext.request.contextPath}${service.coverImageUrl}"
                                             class="card-img" alt="${service.serviceTitle}"
                                             onerror="this.src='https://placehold.co/600x400/e2e8f0/5a6e66?text=Sports+Event'">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="https://placehold.co/600x400/e2e8f0/5a6e66?text=Sports+Event" class="card-img" alt="${service.serviceTitle}">
                                    </c:otherwise>
                                </c:choose>
                                <div class="card-badge">
                                    <i class="fas fa-star"></i> Featured
                                </div>
                            </div>
                            <div class="card-body">
                                <h3 class="card-title">${service.serviceTitle}</h3>
                                <div class="card-location">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${not empty service.city ? service.city : 'Location TBD'}</span>
                                </div>
                                <p class="card-description">${service.description}</p>
                                <div class="d-flex justify-content-between align-items-center mt-3">
                                    <div>
                                        <span class="price-tag">₹${service.basePrice}</span>
                                        <span class="price-unit"> / ${service.pricingUnit}</span>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/company/sports/service/${service.id}" class="btn-book">
                                        <i class="fas fa-calendar-check"></i> Book Now
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
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });
    </script>
</body>
</html>