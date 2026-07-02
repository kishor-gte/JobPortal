<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>JobU | Company Management - Admin Command Center</title>
    
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
            --success: #10b981;
            --success-dark: #059669;
            --danger: #ef4444;
            --danger-dark: #dc2626;
            --warning: #f59e0b;
            --warning-dark: #d97706;
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
            --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
            --transition: all 0.4s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            --radius-sm: 12px;
            --radius-md: 20px;
            --radius-lg: 28px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #e0ece6 100%);
            color: var(--text-dark);
            min-height: 100vh;
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
            padding: 3rem 0;
            margin-bottom: 2.5rem;
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
            font-size: 2.2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .page-header p {
            font-size: 1rem;
            opacity: 0.85;
            position: relative;
            z-index: 1;
        }

        /* Management Cards */
        .management-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            padding: 2.5rem;
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.08);
            transition: var(--transition);
            height: 100%;
            display: flex;
            flex-direction: column;
            position: relative;
            overflow: hidden;
            animation: cardFadeIn 0.6s ease-out both;
        }

        @keyframes cardFadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .management-card:nth-child(1) { animation-delay: 0.1s; }
        .management-card:nth-child(2) { animation-delay: 0.2s; }
        .management-card:nth-child(3) { animation-delay: 0.3s; }

        .management-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--accent));
            transform: scaleX(0);
            transition: transform 0.5s cubic-bezier(0.2, 0.9, 0.4, 1.1);
            transform-origin: left;
        }

        .management-card:hover::before {
            transform: scaleX(1);
        }

        .management-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Card specific top borders */
        .management-card.verified {
            border-top: 4px solid transparent;
        }
        .management-card.verified:hover {
            border-top-color: var(--success);
        }

        .management-card.pending {
            border-top: 4px solid transparent;
        }
        .management-card.pending:hover {
            border-top-color: var(--warning);
        }

        .management-card.reported {
            border-top: 4px solid transparent;
        }
        .management-card.reported:hover {
            border-top-color: var(--danger);
        }

        /* Icon Wrapper Premium */
        .card-icon-wrapper {
            width: 85px;
            height: 85px;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1.8rem;
            transition: var(--transition);
            position: relative;
        }

        .management-card.verified .card-icon-wrapper {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.12), rgba(16, 185, 129, 0.05));
        }

        .management-card.pending .card-icon-wrapper {
            background: linear-gradient(135deg, rgba(245, 158, 11, 0.12), rgba(245, 158, 11, 0.05));
        }

        .management-card.reported .card-icon-wrapper {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.12), rgba(239, 68, 68, 0.05));
        }

        .management-card:hover .card-icon-wrapper {
            transform: scale(1.1) rotate(8deg);
        }

        .card-icon {
            font-size: 2.8rem;
            transition: var(--transition);
        }

        .management-card.verified .card-icon {
            color: var(--success);
        }

        .management-card.pending .card-icon {
            color: var(--warning);
        }

        .management-card.reported .card-icon {
            color: var(--danger);
        }

        /* Card Typography */
        .card-title {
            font-size: 1.6rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 1rem;
            letter-spacing: -0.3px;
        }

        .card-description {
            color: var(--text-muted);
            font-size: 0.9rem;
            margin-bottom: 2rem;
            line-height: 1.65;
            flex-grow: 1;
        }

        /* Premium Button */
        .btn-management {
            padding: 0.9rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 0.9rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.6rem;
            text-decoration: none;
            border: none;
            width: 100%;
            cursor: pointer;
            letter-spacing: 0.3px;
            position: relative;
            overflow: hidden;
        }

        .btn-management::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: translate(-50%, -50%);
            transition: width 0.5s, height 0.5s;
        }

        .btn-management:hover::before {
            width: 300px;
            height: 300px;
        }

        .management-card.verified .btn-management {
            background: linear-gradient(105deg, var(--success), var(--success-dark));
            color: white;
            box-shadow: 0 8px 20px -8px rgba(16, 185, 129, 0.4);
        }

        .management-card.verified .btn-management:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 25px -10px rgba(16, 185, 129, 0.5);
        }

        .management-card.pending .btn-management {
            background: linear-gradient(105deg, var(--warning), var(--warning-dark));
            color: white;
            box-shadow: 0 8px 20px -8px rgba(245, 158, 11, 0.4);
        }

        .management-card.pending .btn-management:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 25px -10px rgba(245, 158, 11, 0.5);
        }

        .management-card.reported .btn-management {
            background: linear-gradient(105deg, var(--danger), var(--danger-dark));
            color: white;
            box-shadow: 0 8px 20px -8px rgba(239, 68, 68, 0.4);
        }

        .management-card.reported .btn-management:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 25px -10px rgba(239, 68, 68, 0.5);
        }

        .btn-management i {
            font-size: 1rem;
            transition: transform 0.2s;
        }

        .btn-management:hover i {
            transform: translateX(4px);
        }

        /* Responsive */
        @media (max-width: 991.98px) {
            .page-header {
                padding: 2rem 0;
            }
            .page-header h1 {
                font-size: 1.8rem;
            }
            .management-card {
                margin-bottom: 1.5rem;
                padding: 2rem;
            }
        }

        @media (max-width: 576px) {
            .page-header {
                padding: 1.5rem 0;
            }
            .page-header h1 {
                font-size: 1.5rem;
            }
            .page-header p {
                font-size: 0.85rem;
            }
            .management-card {
                padding: 1.8rem;
            }
            .card-icon-wrapper {
                width: 70px;
                height: 70px;
            }
            .card-icon {
                font-size: 2.2rem;
            }
            .card-title {
                font-size: 1.35rem;
            }
            .btn-management {
                padding: 0.8rem 1.5rem;
                font-size: 0.85rem;
            }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 5px;
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

        /* Glass shine effect */
        .management-card {
            position: relative;
            overflow: hidden;
        }

        .management-card::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -60%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(59,196,154,0.05), transparent);
            opacity: 0;
            transition: opacity 0.5s;
            pointer-events: none;
        }

        .management-card:hover::after {
            opacity: 1;
        }
    </style>
</head>
<body>

<!-- decorative floating elements -->
<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <h1><i class="fas fa-building me-2" style="color: var(--accent);"></i>Company Management Dashboard</h1>
        <p>Manage verified companies, pending approvals, and reported jobs</p>
    </div>
</div>

<div class="container">
    <div class="row g-4">
        <!-- Verified Companies Card -->
        <div class="col-lg-4 col-md-6">
            <div class="management-card verified">
                <div class="card-icon-wrapper">
                    <i class="fas fa-check-circle card-icon"></i>
                </div>
                <h3 class="card-title">Verified Companies</h3>
                <p class="card-description">
                    View and manage all verified companies. Delete companies that no longer meet requirements.
                </p>
                <a href="${pageContext.request.contextPath}/company/list" class="btn-management">
                    <i class="fas fa-eye"></i>
                    View & Delete
                </a>
            </div>
        </div>

        <!-- Pending Companies Card -->
        <div class="col-lg-4 col-md-6">
            <div class="management-card pending">
                <div class="card-icon-wrapper">
                    <i class="fas fa-clock card-icon"></i>
                </div>
                <h3 class="card-title">Pending Companies</h3>
                <p class="card-description">
                    Review and approve company registration requests. Accept companies that meet the criteria.
                </p>
                <a href="${pageContext.request.contextPath}/admin/pending" class="btn-management">
                    <i class="fas fa-check"></i>
                    Review & Accept
                </a>
            </div>
        </div>

        <!-- Reported Jobs Card -->
        <div class="col-lg-4 col-md-6">
            <div class="management-card reported">
                <div class="card-icon-wrapper">
                    <i class="fas fa-flag card-icon"></i>
                </div>
                <h3 class="card-title">Reported Jobs</h3>
                <p class="card-description">
                    Investigate and manage reported jobs. View complaints and take appropriate actions.
                </p>
                <a href="${pageContext.request.contextPath}/reported-jobs" class="btn-management">
                    <i class="fas fa-search"></i>
                    View & Delete
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add micro-interaction for buttons
    const buttons = document.querySelectorAll('.btn-management');
    buttons.forEach(btn => {
        btn.addEventListener('click', function(e) {
            // subtle ripple simulation
            this.style.transform = 'scale(0.98)';
            setTimeout(() => {
                this.style.transform = '';
            }, 150);
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