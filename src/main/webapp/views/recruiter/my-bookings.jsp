<%@ page session="false" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Booked Services | SmartInterview</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- ENHANCED THEME STYLING -->
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border-color: #e0e6ed;
            --white: #ffffff;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

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

        .container, .page-header, .pb-5 {
            position: relative;
            z-index: 1;
        }

        .page-header {
            background: var(--gradient-primary);
            padding: 2.5rem 0;
            margin-bottom: 2.5rem;
            border-radius: 0 0 30px 30px;
            box-shadow: var(--shadow-md);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none"><path d="M0,0 L1000,0 L1000,100 L0,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
            opacity: 0.1;
        }

        .page-header .container {
            position: relative;
            z-index: 2;
        }

        .page-header h2 {
            color: #fff;
            font-weight: 800;
            font-size: 2rem;
        }

        .page-header p {
            color: rgba(255, 255, 255, 0.9);
        }

        /* Stats Bar */
        .stats-bar {
            display: flex;
            gap: 16px;
            margin-bottom: 24px;
        }

        .stat-pill {
            background: var(--white);
            border: 1px solid rgba(25, 167, 123, 0.15);
            border-radius: 40px;
            padding: 10px 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: var(--shadow-sm);
        }

        .stat-pill i {
            color: var(--primary);
        }

        .stat-pill .count {
            background: var(--gradient-primary);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            margin-left: 8px;
        }

        .table-card {
            background: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow-md);
            padding: 1.5rem;
            border: 1px solid rgba(25, 167, 123, 0.1);
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

        .table thead th {
            background: linear-gradient(135deg, rgba(25, 167, 123, 0.05), rgba(59, 196, 154, 0.05));
            color: var(--primary);
            font-weight: 600;
            border-bottom: 2px solid rgba(25, 167, 123, 0.15);
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            padding: 16px;
        }

        .table tbody td {
            padding: 16px;
            vertical-align: middle;
            color: var(--text-primary);
            border-bottom: 1px solid var(--border-color);
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(25, 167, 123, 0.03);
        }

        .service-img-thumb {
            width: 44px;
            height: 44px;
            object-fit: cover;
            border-radius: 10px;
            border: 2px solid rgba(25, 167, 123, 0.15);
        }

        .status-badge {
            padding: 6px 14px;
            border-radius: 30px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .status-confirmed {
            background-color: rgba(16, 185, 129, 0.12);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .status-pending {
            background-color: rgba(245, 158, 11, 0.12);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .status-cancelled {
            background-color: rgba(239, 68, 68, 0.12);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }
        
        .btn-outline-primary {
            color: var(--primary);
            border-color: var(--primary);
            font-weight: 600;
            padding: 10px 24px;
            border-radius: 30px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-outline-primary:hover {
            background: var(--primary);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        .btn-primary {
            background: var(--gradient-primary);
            border: none;
            font-weight: 600;
            padding: 12px 28px;
            border-radius: 30px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .btn-sm {
            padding: 6px 12px;
            border-radius: 8px;
        }

        .btn-outline-secondary {
            border-color: var(--border-color);
            color: var(--text-secondary);
        }

        .btn-outline-secondary:hover {
            background: var(--primary);
            color: white;
            border-color: var(--primary);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: var(--success);
            border-radius: 14px;
        }

        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-state i {
            font-size: 56px;
            color: var(--primary);
            opacity: 0.3;
            margin-bottom: 20px;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .empty-state p {
            color: var(--text-secondary);
            font-size: 16px;
            margin-bottom: 20px;
        }

        .booking-id {
            font-weight: 600;
            color: var(--primary);
        }

        .amount-text {
            font-weight: 700;
            color: var(--text-primary);
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 2rem 0;
            }

            .page-header h2 {
                font-size: 1.5rem;
            }

            .stats-bar {
                flex-direction: column;
            }

            .table-card {
                padding: 1rem;
            }
        }
    </style>
</head>

<body>

<div class="page-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h2 class="mb-1"><i class="fas fa-calendar-check me-2"></i>My Booked Services</h2>
                <p class="mb-0">Manage and track your sports service bookings</p>
            </div>
            <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="btn-outline-primary">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<div class="container pb-5">

    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <i class="fas fa-check-circle me-2"></i>${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <c:if test="${not empty bookings}">
        <div class="stats-bar">
            <div class="stat-pill">
                <i class="fas fa-calendar-alt"></i>
                <span>Total Bookings <span class="count">${fn:length(bookings)}</span></span>
            </div>
        </div>
    </c:if>

    <div class="card table-card">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead>
                    <tr>
                        <th><i class="fas fa-hashtag"></i> Booking ID</th>
                        <th><i class="fas fa-box"></i> Service</th>
                        <th><i class="fas fa-calendar-day"></i> Event Date</th>
                        <th><i class="fas fa-clock"></i> Booked On</th>
                        <th><i class="fas fa-rupee-sign"></i> Amount</th>
                        <th><i class="fas fa-info-circle"></i> Status</th>
                        <th><i class="fas fa-credit-card"></i> Payment ID</th>
                        <th><i class="fas fa-cog"></i> Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty bookings}">
                            <tr>
                                <td colspan="8">
                                    <div class="empty-state">
                                        <i class="fas fa-calendar-times fa-3x"></i>
                                        <p>No bookings found. Start exploring services today!</p>
                                        <a href="${pageContext.request.contextPath}/recruiter/explore" class="btn btn-primary">
                                            <i class="fas fa-search"></i> Explore Services
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach items="${bookings}" var="booking" varStatus="status">
                                <tr style="animation: fadeInUp 0.4s ease-out; animation-delay: ${status.index * 0.05}s;">
                                    <td><span class="booking-id">#${booking.id}</span></td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <c:if test="${not empty booking.service.coverImageUrl}">
                                                <img src="${pageContext.request.contextPath}${booking.service.coverImageUrl}" 
                                                     alt="" class="service-img-thumb me-3">
                                            </c:if>
                                            <div>
                                                <div class="fw-bold">${booking.service.serviceTitle}</div>
                                                <small class="text-muted">${booking.service.sportType}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <i class="far fa-calendar-alt" style="color: var(--primary); margin-right: 6px;"></i>
                                        ${booking.eventDate}
                                    </td>
                                    <td>
                                        <div>${booking.bookedAt.toLocalDate()}</div>
                                        <small class="text-muted">
                                            <i class="far fa-clock"></i> ${booking.bookedAt.toLocalTime().toString().substring(0,5)}
                                        </small>
                                    </td>
                                    <td class="amount-text">₹${booking.finalPrice}</td>
                                    <td>
                                        <span class="status-badge 
                                            ${booking.status == 'CONFIRMED' ? 'status-confirmed' : 
                                              booking.status == 'REQUESTED' ? 'status-pending' : 'status-cancelled'}">
                                            <i class="fas fa-${booking.status == 'CONFIRMED' ? 'check-circle' : 
                                                booking.status == 'REQUESTED' ? 'clock' : 'times-circle'}"></i>
                                            ${booking.status}
                                        </span>
                                    </td>
                                    <td>
                                        <c:if test="${not empty booking.payment}">
                                            <small class="font-monospace" style="color: var(--primary);">
                                                <i class="fas fa-check-circle"></i> ${booking.payment.transactionId}
                                            </small>
                                        </c:if>
                                        <c:if test="${empty booking.payment}">
                                            <span class="text-muted">-</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/recruiter/service/${booking.service.id}" 
                                           class="btn btn-sm btn-outline-secondary" title="View Service">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
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