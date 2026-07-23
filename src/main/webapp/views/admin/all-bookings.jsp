<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>JobU | Sports Bookings - Admin Command Center</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    
    <style>
        /* ============================================
           PREMIUM COLOR SCHEME
           --primary: #19A77B
           --primary-dark: #148F69
           --accent: #3BC49A
           --bg-dark: #2E3E41
        ============================================ */
        
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --accent-light: #6ed4b2;
            --bg-dark: #2E3E41;
            --bg-dark-light: #3d5256;
            --bg-light: #eef3f0;
            --card-bg: rgba(255, 255, 255, 0.98);
            --text-dark: #1e2a2e;
            --text-muted: #5b7c6e;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
            --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 16px;
            --radius-lg: 24px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #e0ece6 100%);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            color: var(--text-dark);
            line-height: 1.6;
            position: relative;
            overflow-x: hidden;
        }

        /* animated background mesh */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 15% 30%, rgba(25,167,123,0.05) 0%, transparent 40%),
                radial-gradient(circle at 85% 70%, rgba(59,196,154,0.04) 0%, transparent 45%),
                radial-gradient(circle at 50% 90%, rgba(25,167,123,0.03) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: meshFloat 18s ease-in-out infinite alternate;
        }

        @keyframes meshFloat {
            0% { opacity: 0.5; transform: scale(1); }
            100% { opacity: 1; transform: scale(1.03); }
        }

        /* floating particles */
        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: radial-gradient(circle at 20% 40%, rgba(25,167,123,0.06) 1px, transparent 1px);
            background-size: 32px 32px;
            pointer-events: none;
            animation: particleDrift 25s linear infinite;
        }

        @keyframes particleDrift {
            0% { background-position: 0 0; }
            100% { background-position: 65px 65px; }
        }

        /* floating decorative shapes */
        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        /* Page Header Premium */
        .page-header {
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2.5rem 0;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -20%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(59,196,154,0.15), transparent);
            border-radius: 50%;
            animation: floatGlow 15s ease-in-out infinite;
        }

        @keyframes floatGlow {
            0%, 100% { transform: translate(0, 0) scale(1); }
            50% { transform: translate(-30px, 20px) scale(1.1); }
        }

        .page-header h1 {
            font-size: 1.75rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            position: relative;
            z-index: 1;
        }

        .page-header p {
            font-size: 0.9rem;
            opacity: 0.85;
            position: relative;
            z-index: 1;
        }

        .btn-outline-light {
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            padding: 0.5rem 1.2rem;
            border-radius: 40px;
            font-weight: 600;
            transition: var(--transition);
        }

        .btn-outline-light:hover {
            background: white;
            color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
        }

        /* Card Premium */
        .card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.08);
            transition: var(--transition);
            border: none;
            overflow: hidden;
        }

        .card:hover {
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Table Styles */
        .table {
            margin-bottom: 0;
        }

        .table thead th {
            background: linear-gradient(135deg, var(--bg-dark), #3d5256);
            color: white;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            padding: 1rem 0.75rem;
            border-bottom: none;
        }

        .table thead th:first-child {
            border-top-left-radius: var(--radius-md);
            padding-left: 1.5rem;
        }

        .table thead th:last-child {
            border-top-right-radius: var(--radius-md);
        }

        .table tbody tr {
            transition: var(--transition);
            border-bottom: 1px solid rgba(25,167,123,0.08);
        }

        .table tbody tr:hover {
            background: rgba(25,167,123,0.03);
            transform: scale(1.01);
        }

        .table tbody td {
            padding: 1rem 0.75rem;
            vertical-align: middle;
            font-size: 0.85rem;
            color: var(--text-dark);
        }

        .table tbody td:first-child {
            padding-left: 1.5rem;
        }

        /* Status Badge Premium */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 0.4rem 1rem;
            border-radius: 40px;
            font-size: 0.7rem;
            font-weight: 700;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            box-shadow: var(--shadow-sm);
            transition: var(--transition);
        }

        .status-badge:hover {
            transform: scale(1.02);
        }

        .bg-REQUESTED {
            background: linear-gradient(135deg, #f59e0b, #d97706);
            color: white;
        }

        .bg-CONFIRMED {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
        }

        .bg-CANCELLED {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: white;
        }

        /* Payment ID styling */
        .payment-id {
            font-family: 'Monaco', 'Courier New', monospace;
            font-size: 0.7rem;
            background: rgba(25,167,123,0.08);
            padding: 0.3rem 0.6rem;
            border-radius: 8px;
            display: inline-block;
            letter-spacing: 0.3px;
        }

        /* Amount styling */
        .amount {
            font-weight: 800;
            color: var(--primary-dark);
            font-size: 0.9rem;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            color: var(--text-muted);
        }

        .empty-state i {
            font-size: 3.5rem;
            margin-bottom: 1rem;
            opacity: 0.4;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .table-responsive {
                border-radius: var(--radius-md);
            }
        }

        @media (max-width: 768px) {
            .page-header {
                padding: 1.5rem 0;
            }
            .page-header h1 {
                font-size: 1.35rem;
            }
            .btn-outline-light span {
                display: none;
            }
            .btn-outline-light i {
                margin-right: 0;
            }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 5px;
            height: 5px;
        }
        ::-webkit-scrollbar-track {
            background: #e0ece6;
        }
        ::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 10px;
        }

        /* Selection */
        ::selection {
            background: var(--primary);
            color: white;
        }

        /* Animation for rows */
        .table tbody tr {
            animation: fadeInRow 0.4s ease-out both;
        }

        @keyframes fadeInRow {
            from {
                opacity: 0;
                transform: translateX(-10px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .table tbody tr:nth-child(1) { animation-delay: 0.05s; }
        .table tbody tr:nth-child(2) { animation-delay: 0.1s; }
        .table tbody tr:nth-child(3) { animation-delay: 0.15s; }
        .table tbody tr:nth-child(4) { animation-delay: 0.2s; }
        .table tbody tr:nth-child(5) { animation-delay: 0.25s; }
        .table tbody tr:nth-child(6) { animation-delay: 0.3s; }
        .table tbody tr:nth-child(7) { animation-delay: 0.35s; }
        .table tbody tr:nth-child(8) { animation-delay: 0.4s; }
        .table tbody tr:nth-child(9) { animation-delay: 0.45s; }
        .table tbody tr:nth-child(10) { animation-delay: 0.5s; }
    </style>
<jsp:include page="/views/commons/admin_shell_head.jsp" />
</head>
<body>

<jsp:include page="/views/commons/admin_shell_start.jsp">
  <jsp:param name="pageTitle" value="All Bookings"/>
  <jsp:param name="pageSubtitle" value="Sports service bookings"/>
  <jsp:param name="activeNav" value="bookings"/>
</jsp:include>

<!-- decorative floating elements -->
<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<!-- Header -->
<div class="page-header">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center flex-wrap gap-3">
            <div>
                <h1><i class="fas fa-calendar-check me-2" style="color: var(--accent);"></i> All Sports Bookings</h1>
                <p class="mb-0 opacity-75">Manage and monitor all recruiter sports service bookings</p>
            </div>
            <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-light btn-sm">
                <i class="fas fa-arrow-left me-2"></i><span>Back to Dashboard</span>
            </a>
        </div>
    </div>
</div>

<div class="container pb-5">
    <div class="card shadow-sm border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4"><i class="fas fa-hashtag me-1"></i> ID</th>
                            <th><i class="fas fa-user-tie me-1"></i> Recruiter</th>
                            <th><i class="fas fa-dumbbell me-1"></i> Service</th>
                            <th><i class="fas fa-calendar-alt me-1"></i> Event Date</th>
                            <th><i class="fas fa-rupee-sign me-1"></i> Amount</th>
                            <th><i class="fas fa-credit-card me-1"></i> Payment ID</th>
                            <th><i class="fas fa-clock me-1"></i> Booked At</th>
                            <th><i class="fas fa-chart-line me-1"></i> Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty bookings}">
                                <c:forEach items="${bookings}" var="booking">
                                    <tr>
                                        <td class="ps-4 fw-bold">#${booking.id}</td>
                                        <td>
                                            <div class="d-flex flex-column">
                                                <span class="fw-semibold">${booking.recruiter.name}</span>
                                                <span class="text-muted small">${booking.recruiter.email}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="fw-medium">${booking.service.serviceTitle}</span>
                                        </td>
                                        <td>
                                            <i class="far fa-calendar me-1 text-muted"></i> ${booking.eventDate}
                                        </td>
                                        <td class="amount">
                                            <i class="fas fa-rupee-sign me-1" style="font-size: 0.7rem;"></i> 
                                            <fmt:formatNumber value="${booking.finalPrice}" pattern="#,##0.00"/>
                                        </td>
                                        <td>
                                            <span class="payment-id">
                                                <i class="fas fa-receipt me-1" style="font-size: 0.6rem;"></i> 
                                                ${booking.payment.transactionId}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="text-muted small">
                                                <i class="far fa-calendar-alt me-1"></i> ${booking.bookedAt}
                                            </span>
                                        </td>
                                        <td>
                                            <span class="status-badge bg-${booking.status}">
                                                <i class="fas ${booking.status == 'CONFIRMED' ? 'fa-check-circle' : booking.status == 'REQUESTED' ? 'fa-clock' : 'fa-times-circle'} me-1"></i>
                                                ${booking.status}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" class="text-center py-5">
                                        <div class="empty-state">
                                            <i class="fas fa-calendar-times"></i>
                                            <p class="mb-0">No bookings found yet.</p>
                                            <small class="text-muted">Bookings will appear here once recruiters make a reservation</small>
                                        </div>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add micro-interaction for table rows
    const rows = document.querySelectorAll('.table tbody tr');
    rows.forEach(row => {
        row.addEventListener('click', function(e) {
            // Don't trigger if clicking on interactive elements
            if (e.target.tagName === 'A' || e.target.tagName === 'BUTTON') return;
            this.style.backgroundColor = 'rgba(25,167,123,0.05)';
            setTimeout(() => {
                this.style.backgroundColor = '';
            }, 200);
        });
    });
    
    // Preserved original mobile responsive script
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
                /* Table responsiveness */
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
    
    // Add data-labels for responsive tables
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText.replace(/[^\w\s]/g, '').trim());
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
<jsp:include page="/views/commons/admin_shell_end.jsp" />
</body>
</html>