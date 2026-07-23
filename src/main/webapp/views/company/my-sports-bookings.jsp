<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Sports Bookings | JobU - Corporate Events Management</title>
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

        /* ========== TABLE CARD ========== */
        .table-card {
            background: var(--white);
            border-radius: var(--radius);
            padding: 0;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25,167,123,0.1);
            overflow: hidden;
            transition: var(--transition);
        }
        .table-card:hover {
            box-shadow: var(--shadow-md);
        }
        .table {
            margin-bottom: 0;
        }
        .table thead th {
            background: var(--bg-light);
            color: var(--text-dark);
            font-weight: 700;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 16px 20px;
            border-bottom: 2px solid var(--border);
        }
        .table tbody td {
            padding: 16px 20px;
            vertical-align: middle;
            color: var(--text-muted);
            font-size: 0.85rem;
            border-bottom: 1px solid var(--border);
        }
        .table tbody tr:hover {
            background: var(--bg-light);
            transition: var(--transition);
        }

        /* Status Badges */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 50px;
            font-size: 0.7rem;
            font-weight: 700;
            text-transform: uppercase;
        }
        .status-confirmed {
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            color: var(--primary-dark);
        }
        .status-requested {
            background: linear-gradient(135deg, rgba(59,130,246,0.12), rgba(59,130,246,0.08));
            color: #3b82f6;
        }
        .status-pending {
            background: linear-gradient(135deg, rgba(245,158,11,0.12), rgba(245,158,11,0.08));
            color: #f59e0b;
        }
        .status-completed {
            background: linear-gradient(135deg, rgba(25, 167, 123,0.12), rgba(25, 167, 123,0.08));
            color: #19A77B;
        }
        .status-cancelled {
            background: linear-gradient(135deg, rgba(239,68,68,0.12), rgba(239,68,68,0.08));
            color: #ef4444;
        }
        .status-refunded {
            background: linear-gradient(135deg, rgba(139,92,246,0.12), rgba(139,92,246,0.08));
            color: #8b5cf6;
        }

        /* Buttons */
        .btn-sm-custom {
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            transition: var(--transition);
        }
        .btn-pay {
            background: var(--gradient);
            color: white;
            border: none;
        }
        .btn-pay:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-sm);
        }
        .btn-cancel {
            background: rgba(239,68,68,0.1);
            color: #ef4444;
            border: 1px solid rgba(239,68,68,0.2);
        }
        .btn-cancel:hover {
            background: #ef4444;
            color: white;
            transform: translateY(-2px);
        }
        .btn-book-new {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 50px;
            padding: 12px 32px;
            font-weight: 700;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
            margin-top: 30px;
        }
        .btn-book-new:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            color: white;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 40px;
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
            border-radius: var(--radius-sm);
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
        .alert-warning-custom {
            background: linear-gradient(135deg, rgba(245,158,11,0.1), rgba(245,158,11,0.05));
            color: #f59e0b;
            border-left: 4px solid #f59e0b;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 40px 0 30px; }
            .page-header h2 { font-size: 1.5rem; }
            .table thead { display: none; }
            .table tbody td {
                display: block;
                padding: 12px 16px;
                text-align: right;
                position: relative;
                padding-left: 50%;
            }
            .table tbody td:before {
                content: attr(data-label);
                position: absolute;
                left: 16px;
                width: 45%;
                font-weight: 700;
                text-align: left;
                color: var(--text-dark);
            }
            .table tbody tr {
                display: block;
                margin-bottom: 16px;
                border: 1px solid var(--border);
                border-radius: var(--radius-sm);
            }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
                <div>
                    <h2><i class="fas fa-calendar-check me-2"></i>My Sports Bookings</h2>
                    <p>Manage and track your company's sports service bookings</p>
                </div>
                <a href="${pageContext.request.contextPath}/company/dashboard" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
            </div>
        </div>
    </div>

    <div class="container pb-5">

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
        <c:if test="${not empty warning}">
            <div class="alert alert-warning-custom alert-custom" data-aos="fade-up">
                <i class="fas fa-exclamation-triangle me-2"></i>${warning}
                <button type="button" class="btn-close float-end" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>

        <!-- Bookings Table Card -->
        <div class="table-card" data-aos="fade-up" data-aos-delay="100">
            <div class="table-responsive">
                <table class="table align-middle">
                    <thead>
                        <tr>
                            <th>Booking ID</th>
                            <th>Service</th>
                            <th>Event Date</th>
                            <th>Booked On</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Payment ID</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty bookings}">
                                <tr>
                                    <td colspan="8" class="text-center py-5">
                                        <div class="empty-state">
                                            <i class="fas fa-calendar-times"></i>
                                            <h3>No Bookings Found</h3>
                                            <p class="text-muted">You haven't made any sports service bookings yet.</p>
                                            <a href="${pageContext.request.contextPath}/company/sports/explore" class="btn-book-new" style="margin-top: 0;">
                                                <i class="fas fa-futbol me-2"></i>Explore Services
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach items="${bookings}" var="booking">
                                    <tr data-aos="fade-up" data-aos-delay="${150}">
                                        <td data-label="Booking ID"><span class="fw-bold text-primary">#${booking.id}</span></td>
                                        <td data-label="Service">
                                            <div class="d-flex align-items-center gap-2">
                                                <i class="fas fa-futbol" style="color: var(--primary);"></i>
                                                <span class="fw-semibold">${booking.service.serviceTitle}</span>
                                            </div>
                                        </td>
                                        <td data-label="Event Date">
                                            <fmt:parseDate value="${booking.eventDate}" pattern="yyyy-MM-dd" var="parsedDate" />
                                            <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy" />
                                        </td>
                                        <td data-label="Booked On">
                                            <fmt:parseDate value="${booking.bookedAt}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedBookedAt" />
                                            <fmt:formatDate value="${parsedBookedAt}" pattern="MMM dd, yyyy HH:mm" />
                                        </td>
                                        <td data-label="Amount">
                                            <span class="fw-bold" style="color: var(--primary);">₹<fmt:formatNumber value="${booking.finalPrice}" pattern="#,##0.00"/></span>
                                        </td>
                                        <td data-label="Status">
                                            <c:choose>
                                                <c:when test="${booking.status == 'CONFIRMED'}">
                                                    <span class="status-badge status-confirmed"><i class="fas fa-check-circle me-1"></i>Confirmed</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'REQUESTED'}">
                                                    <span class="status-badge status-requested"><i class="fas fa-clock me-1"></i>Requested</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'PAYMENT_PENDING'}">
                                                    <span class="status-badge status-pending"><i class="fas fa-hourglass-half me-1"></i>Payment Pending</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'COMPLETED'}">
                                                    <span class="status-badge status-completed"><i class="fas fa-check-double me-1"></i>Completed</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'CANCELLED'}">
                                                    <span class="status-badge status-cancelled"><i class="fas fa-times-circle me-1"></i>Cancelled</span>
                                                </c:when>
                                                <c:when test="${booking.status == 'REFUNDED'}">
                                                    <span class="status-badge status-refunded"><i class="fas fa-undo-alt me-1"></i>Refunded</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-pending">${booking.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td data-label="Payment ID">
                                            <c:choose>
                                                <c:when test="${booking.status == 'REFUNDED'}">
                                                    <small class="text-success"><i class="fas fa-undo-alt me-1"></i>Refund Processed</small>
                                                </c:when>
                                                <c:when test="${not empty booking.payment}">
                                                    <small class="text-muted">${booking.payment.transactionId}</small>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">—</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td data-label="Actions">
                                            <c:choose>
                                                <c:when test="${booking.status == 'REQUESTED' || booking.status == 'PAYMENT_PENDING'}">
                                                    <a href="${pageContext.request.contextPath}/company/sports/service/${booking.service.id}" 
                                                       class="btn btn-sm-custom btn-pay">
                                                        <i class="fas fa-credit-card me-1"></i>Pay Now
                                                    </a>
                                                </c:when>
                                                <c:when test="${booking.status == 'CONFIRMED'}">
                                                    <form action="${pageContext.request.contextPath}/company/sports/booking/cancel/${booking.id}" 
                                                          method="post" 
                                                          style="display: inline;"
                                                          onsubmit="return confirm('Are you sure you want to cancel this booking? The refund will be processed to your original payment method within 5-7 business days.');">
                                                        <button type="submit" class="btn btn-sm-custom btn-cancel">
                                                            <i class="fas fa-times-circle me-1"></i>Cancel & Refund
                                                        </button>
                                                    </form>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-sm-custom" disabled style="background: #e2e8f0; color: #94a3b8;">
                                                        <i class="fas fa-ban me-1"></i>${booking.status}
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Book New Service Button -->
        <div class="text-center mt-4" data-aos="fade-up" data-aos-delay="200">
            <a href="${pageContext.request.contextPath}/company/sports/explore" class="btn-book-new">
                <i class="fas fa-plus me-2"></i>Book New Service
            </a>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });
    </script>
</body>
</html>