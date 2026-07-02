<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>Pending Organizer Verification | JobU Admin</title>

<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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
    --warning: #f59e0b;
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

/* Container */
.container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 2rem 1.5rem;
    position: relative;
    z-index: 2;
}

/* Premium Header */
.premium-header {
    background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
    color: white;
    padding: 2.5rem 2rem;
    border-radius: var(--radius-lg);
    margin-bottom: 2.5rem;
    position: relative;
    overflow: hidden;
}

.premium-header::before {
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

.premium-header h2 {
    font-size: 2rem;
    font-weight: 800;
    letter-spacing: -0.5px;
    margin: 0 0 0.5rem 0;
    position: relative;
    z-index: 1;
    display: flex;
    align-items: center;
    gap: 1rem;
}

.premium-header h2 i {
    color: var(--accent);
    font-size: 2rem;
}

.premium-header p {
    opacity: 0.85;
    margin: 0;
    position: relative;
    z-index: 1;
}

/* Stats Bar */
.stats-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 1rem;
    margin-bottom: 2rem;
    padding: 1rem 1.5rem;
    background: var(--card-bg);
    backdrop-filter: blur(8px);
    border-radius: var(--radius-md);
    box-shadow: var(--shadow-sm);
    border: 1px solid rgba(25,167,123,0.1);
}

.pending-count {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    font-weight: 600;
}

.pending-count i {
    color: var(--warning);
    font-size: 1.2rem;
}

.pending-count .count-number {
    font-size: 1.8rem;
    font-weight: 800;
    color: var(--primary);
}

/* Organizers Grid */
.organizers-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
    gap: 1.5rem;
}

/* Premium Organizer Card */
.organizer-card {
    background: var(--card-bg);
    backdrop-filter: blur(8px);
    border-radius: var(--radius-md);
    box-shadow: var(--shadow-md), 0 0 0 1px rgba(25,167,123,0.08);
    transition: var(--transition);
    overflow: hidden;
    animation: cardFadeIn 0.5s ease-out both;
    position: relative;
}

@keyframes cardFadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.organizer-card:nth-child(1) { animation-delay: 0.05s; }
.organizer-card:nth-child(2) { animation-delay: 0.1s; }
.organizer-card:nth-child(3) { animation-delay: 0.15s; }
.organizer-card:nth-child(4) { animation-delay: 0.2s; }
.organizer-card:nth-child(5) { animation-delay: 0.25s; }
.organizer-card:nth-child(6) { animation-delay: 0.3s; }

.organizer-card:hover {
    transform: translateY(-6px);
    box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
}

/* Card accent border */
.organizer-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 4px;
    background: linear-gradient(90deg, var(--warning), var(--accent));
    transform: scaleX(0);
    transform-origin: left;
    transition: transform 0.4s ease;
}

.organizer-card:hover::before {
    transform: scaleX(1);
}

/* Card Content */
.card-content {
    padding: 1.5rem;
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.organizer-icon {
    width: 60px;
    height: 60px;
    background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 0.5rem;
}

.organizer-icon i {
    font-size: 2rem;
    color: var(--primary);
}

.organizer-name {
    font-size: 1.3rem;
    font-weight: 800;
    background: linear-gradient(135deg, var(--bg-dark), #4a6569);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    letter-spacing: -0.3px;
}

.pending-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    background: rgba(245, 158, 11, 0.12);
    color: var(--warning);
    padding: 0.3rem 0.8rem;
    border-radius: 40px;
    font-size: 0.7rem;
    font-weight: 700;
    margin-top: 0.5rem;
    width: fit-content;
}

/* Review Button */
.btn-review {
    background: linear-gradient(105deg, var(--primary), var(--primary-dark));
    color: white;
    border: none;
    padding: 0.8rem 1.5rem;
    border-radius: 50px;
    font-weight: 700;
    font-size: 0.9rem;
    transition: var(--transition);
    display: inline-flex;
    align-items: center;
    justify-content: center;
    gap: 0.6rem;
    text-decoration: none;
    margin-top: 0.5rem;
    width: 100%;
    box-shadow: 0 4px 12px rgba(25,167,123,0.25);
}

.btn-review:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(25,167,123,0.4);
    color: white;
}

.btn-review i {
    transition: transform 0.2s;
}

.btn-review:hover i {
    transform: translateX(3px);
}

/* Empty State */
.empty-state {
    text-align: center;
    padding: 4rem 2rem;
    background: var(--card-bg);
    backdrop-filter: blur(8px);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-md);
}

.empty-state i {
    font-size: 4rem;
    background: linear-gradient(135deg, var(--primary), var(--accent));
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    margin-bottom: 1rem;
}

.empty-state h3 {
    font-size: 1.3rem;
    font-weight: 700;
    color: var(--bg-dark);
    margin-bottom: 0.5rem;
}

.empty-state p {
    color: var(--text-muted);
}

/* Back Button */
.btn-back {
    display: inline-flex;
    align-items: center;
    gap: 0.6rem;
    background: var(--bg-dark);
    color: white;
    padding: 0.7rem 1.5rem;
    border-radius: 50px;
    text-decoration: none;
    font-weight: 600;
    transition: var(--transition);
    margin-top: 2rem;
}

.btn-back:hover {
    background: var(--bg-dark-light);
    transform: translateY(-2px);
    color: white;
}

/* Responsive */
@media (max-width: 768px) {
    .container {
        padding: 1rem;
    }
    .premium-header {
        padding: 1.5rem;
    }
    .premium-header h2 {
        font-size: 1.5rem;
        flex-direction: column;
        text-align: center;
        gap: 0.5rem;
    }
    .organizers-grid {
        grid-template-columns: 1fr;
    }
    .stats-bar {
        flex-direction: column;
        text-align: center;
    }
}

@media (max-width: 480px) {
    .card-content {
        padding: 1.2rem;
    }
    .organizer-name {
        font-size: 1.1rem;
    }
}

/* Custom Scrollbar */
::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: #e0ece6; }
::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

::selection { background: var(--primary); color: white; }
</style>
</head>
<body>

<!-- decorative floating elements -->
<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<div class="container">
    <!-- Premium Header -->
    <div class="premium-header">
        <h2>
            <i class="fas fa-user-check"></i>
            Pending Organizer Verification
        </h2>
        <p>Review and verify organizer applications to activate their accounts</p>
    </div>

    <!-- Stats Bar -->
    <div class="stats-bar">
        <div class="pending-count">
            <i class="fas fa-clock"></i>
            <span>Pending Verifications</span>
        </div>
        <div class="pending-count">
            <i class="fas fa-building"></i>
            <span class="count-number">${fn:length(organizers)}</span>
            <span>Organizer${fn:length(organizers) != 1 ? 's' : ''} waiting</span>
        </div>
    </div>

    <!-- Organizers Grid -->
    <c:choose>
        <c:when test="${not empty organizers}">
            <div class="organizers-grid">
                <c:forEach var="org" items="${organizers}">
                    <div class="organizer-card">
                        <div class="card-content">
                            <div class="organizer-icon">
                                <i class="fas fa-building"></i>
                            </div>
                            <div class="organizer-name">${org.organizationName}</div>
                            <div class="pending-badge">
                                <i class="fas fa-hourglass-half"></i>
                                Pending Review
                            </div>
                            <a href="${pageContext.request.contextPath}/admin/organizers/view/${org.id}" 
                               class="btn-review">
                                Review Application
                                <i class="fas fa-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-check-circle"></i>
                <h3>All Clear!</h3>
                <p>No pending organizer verification requests at this time.</p>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Back Button -->
    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn-back">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
    </a>
</div>

<script>
// Preserved original mobile responsive script
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
            let touchstartX = 0, touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { 
                touchendX = e.changedTouches[0].screenX; 
                if (touchendX < touchstartX - 50) closeSidebar(); 
                if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); 
            }, {passive: true});
            function openSidebar() { sidebar.classList.add('active'); overlay.classList.add('active'); document.body.style.overflow = 'hidden'; }
            function closeSidebar() { sidebar.classList.remove('active'); overlay.classList.remove('active'); document.body.style.overflow = ''; }
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
                if(headers[index]) td.setAttribute('data-label', headers[index]);
            });
        });
    });
});
</script>
</body>
</html>