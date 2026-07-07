<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>JobU | Admin Profile - Premium Account</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">

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
            --radius-lg: 28px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #e0ece6 100%);
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
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
                radial-gradient(circle at 15% 30%, rgba(25,167,123,0.06) 0%, transparent 40%),
                radial-gradient(circle at 85% 70%, rgba(59,196,154,0.05) 0%, transparent 45%),
                radial-gradient(circle at 50% 90%, rgba(25,167,123,0.04) 0%, transparent 50%);
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

        /* Container Premium */
        .container {
            max-width: 500px;
            width: 100%;
            margin: 0 auto;
            position: relative;
            z-index: 2;
            animation: fadeSlideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeSlideUp {
            from {
                opacity: 0;
                transform: translateY(40px) scale(0.96);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        /* Premium Card */
        .profile-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            padding: 40px 35px;
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.1);
            transition: var(--transition);
            text-align: center;
            border: none;
        }

        .profile-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.2);
        }

        /* Avatar Section */
        .avatar-wrapper {
            position: relative;
            margin-bottom: 24px;
            display: inline-block;
        }

        .avatar {
            width: 110px;
            height: 110px;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto;
            box-shadow: 0 15px 30px -10px rgba(25,167,123,0.4);
            transition: var(--transition);
            animation: gentlePulse 2.5s ease-in-out infinite;
        }

        @keyframes gentlePulse {
            0%, 100% { box-shadow: 0 15px 30px -10px rgba(25,167,123,0.4); }
            50% { box-shadow: 0 20px 40px -8px rgba(25,167,123,0.6); }
        }

        .avatar i {
            font-size: 52px;
            color: white;
            text-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }

        .avatar-wrapper:hover .avatar {
            transform: scale(1.05);
        }

        /* Status Badge */
        .status-badge {
            position: absolute;
            bottom: 5px;
            right: 5px;
            background: var(--primary);
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 3px solid white;
            box-shadow: var(--shadow-sm);
        }

        .status-badge i {
            font-size: 12px;
            color: white;
        }

        /* Header */
        h2 {
            font-size: 28px;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        .role-badge {
            display: inline-block;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            padding: 5px 16px;
            border-radius: 40px;
            font-size: 12px;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 28px;
            border: 1px solid rgba(25,167,123,0.2);
        }

        /* Profile Info Grid */
        .profile-info {
            text-align: left;
            margin: 28px 0;
        }

        .info-row {
            display: flex;
            align-items: center;
            padding: 16px 0;
            border-bottom: 2px solid rgba(25,167,123,0.08);
            transition: var(--transition);
        }

        .info-row:hover {
            border-bottom-color: rgba(25,167,123,0.2);
            transform: translateX(4px);
        }

        .info-icon {
            width: 48px;
            height: 48px;
            background: linear-gradient(135deg, rgba(25,167,123,0.1), rgba(59,196,154,0.05));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 18px;
            transition: var(--transition);
        }

        .info-row:hover .info-icon {
            transform: scale(1.05);
            background: linear-gradient(135deg, rgba(25,167,123,0.15), rgba(59,196,154,0.1));
        }

        .info-icon i {
            font-size: 22px;
            color: var(--primary);
        }

        .info-content {
            flex: 1;
        }

        .info-label {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-muted);
            margin-bottom: 4px;
        }

        .info-value {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-dark);
            word-break: break-word;
        }

        /* Button Group */
        .button-group {
            display: flex;
            gap: 16px;
            justify-content: center;
            margin-top: 24px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 12px 28px;
            border-radius: 50px;
            font-weight: 700;
            font-size: 14px;
            text-decoration: none;
            transition: var(--transition);
            cursor: pointer;
            border: none;
        }

        .edit-btn {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
        }

        .edit-btn i {
            font-size: 14px;
            transition: transform 0.2s;
        }

        .edit-btn:hover {
            background: linear-gradient(105deg, var(--primary-dark), #0d5e44);
            transform: translateY(-3px);
            box-shadow: 0 15px 25px -10px rgba(25,167,123,0.5);
            color: white;
        }

        .edit-btn:hover i {
            transform: translateX(-3px);
        }

        .back-btn {
            background: rgba(46, 62, 65, 0.1);
            color: var(--bg-dark);
            border: 1px solid rgba(46, 62, 65, 0.2);
        }

        .back-btn i {
            font-size: 14px;
            transition: transform 0.2s;
        }

        .back-btn:hover {
            background: var(--bg-dark);
            color: white;
            transform: translateY(-3px);
            border-color: transparent;
            box-shadow: var(--shadow-md);
        }

        .back-btn:hover i {
            transform: translateX(-3px);
        }

        /* Responsive */
        @media (max-width: 576px) {
            .container {
                padding: 0 10px;
            }
            .profile-card {
                padding: 28px 20px;
            }
            h2 {
                font-size: 24px;
            }
            .avatar {
                width: 90px;
                height: 90px;
            }
            .avatar i {
                font-size: 42px;
            }
            .info-row {
                padding: 12px 0;
            }
            .info-icon {
                width: 42px;
                height: 42px;
                margin-right: 14px;
            }
            .info-icon i {
                font-size: 18px;
            }
            .info-value {
                font-size: 14px;
            }
            .button-group {
                gap: 12px;
            }
            .btn {
                padding: 10px 20px;
                font-size: 13px;
            }
        }

        @media (max-width: 380px) {
            .button-group {
                flex-direction: column;
            }
            .btn {
                justify-content: center;
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

        /* Selection Styling */
        ::selection {
            background: var(--primary);
            color: white;
        }

        /* shine effect on card */
        .profile-card {
            position: relative;
            overflow: hidden;
        }

        .profile-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -60%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(59,196,154,0.08), transparent);
            opacity: 0;
            transition: opacity 0.6s;
            pointer-events: none;
        }

        .profile-card:hover::before {
            opacity: 1;
        }
    </style>
</head>
<body>

<!-- decorative floating elements -->
<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<div class="container">
    <div class="profile-card">
        <!-- Premium Avatar -->
        <div class="avatar-wrapper">
            <div class="avatar">
                <i class="fas fa-user-shield"></i>
            </div>
            <div class="status-badge">
                <i class="fas fa-check-circle"></i>
            </div>
        </div>
        
        <h2>Admin Profile</h2>
        <div class="role-badge">
            <i class="fas fa-crown" style="margin-right: 6px; font-size: 10px;"></i> Super Administrator
        </div>
        
        <!-- Profile Information with Icons -->
        <div class="profile-info">
            <div class="info-row">
                <div class="info-icon">
                    <i class="fas fa-id-card"></i>
                </div>
                <div class="info-content">
                    <div class="info-label">Administrator ID</div>
                    <div class="info-value">${admin.id}</div>
                </div>
            </div>
            
            <div class="info-row">
                <div class="info-icon">
                    <i class="fas fa-user-circle"></i>
                </div>
                <div class="info-content">
                    <div class="info-label">Full Name</div>
                    <div class="info-value">${admin.name}</div>
                </div>
            </div>
            
            <div class="info-row">
                <div class="info-icon">
                    <i class="fas fa-envelope"></i>
                </div>
                <div class="info-content">
                    <div class="info-label">Email Address</div>
                    <div class="info-value">${admin.email}</div>
                </div>
            </div>
        </div>
        
        <!-- Action Buttons -->
        <div class="button-group">
            <a href="${pageContext.request.contextPath}/admin/edit/${admin.id}" class="btn edit-btn">
                <i class="fas fa-pen"></i> Edit Profile
            </a>
            <a href="${pageContext.request.contextPath}/admin/adminDashboard" class="btn back-btn">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add micro-interaction for buttons
    const buttons = document.querySelectorAll('.btn');
    buttons.forEach(btn => {
        btn.addEventListener('click', function(e) {
            // subtle ripple effect simulation
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
    
    // Add data-labels
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
