<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>Manage Sports Services | JobU Admin</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
    --danger: #ef4444;
    --warning: #f59e0b;
    --info: #3b82f6;
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
    position: relative;
    z-index: 2;
    padding: 2rem 1.5rem;
    max-width: 1400px;
}

/* Premium Header */
.page-header {
    background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
    color: white;
    padding: 2rem 2rem;
    border-radius: var(--radius-lg);
    margin-bottom: 2rem;
    position: relative;
    overflow: hidden;
}

.page-header::before {
    content: '';
    position: absolute;
    top: -50%;
    right: -20%;
    width: 300px;
    height: 300px;
    background: radial-gradient(circle, rgba(59,196,154,0.15), transparent);
    border-radius: 50%;
    animation: floatGlow 15s ease-in-out infinite;
}

@keyframes floatGlow {
    0%, 100% { transform: translate(0, 0) scale(1); }
    50% { transform: translate(-30px, 20px) scale(1.1); }
}

.page-header h3 {
    font-size: 1.8rem;
    font-weight: 800;
    letter-spacing: -0.5px;
    margin: 0 0 0.5rem 0;
    position: relative;
    z-index: 1;
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.page-header h3 i {
    color: var(--accent);
    font-size: 2rem;
}

.page-header p {
    opacity: 0.85;
    margin: 0;
    position: relative;
    z-index: 1;
}

/* Add Button Premium */
.btn-add {
    background: linear-gradient(105deg, var(--primary), var(--primary-dark));
    color: white;
    border: none;
    padding: 0.85rem 2rem;
    border-radius: 50px;
    font-weight: 700;
    transition: var(--transition);
    box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
    display: inline-flex;
    align-items: center;
    gap: 0.75rem;
    text-decoration: none;
    margin-bottom: 2rem;
}

.btn-add:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 25px -10px rgba(25,167,123,0.5);
    color: white;
}

/* Table Premium */
.table-wrapper {
    background: var(--card-bg);
    backdrop-filter: blur(8px);
    border-radius: var(--radius-lg);
    overflow: hidden;
    box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.08);
    margin-bottom: 2rem;
    transition: var(--transition);
}

.table-wrapper:hover {
    box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
}

.table {
    margin-bottom: 0;
}

.table thead th {
    background: linear-gradient(135deg, var(--bg-dark), #3d5256);
    color: white;
    font-weight: 700;
    font-size: 0.85rem;
    text-transform: uppercase;
    letter-spacing: 0.8px;
    padding: 1.2rem 1rem;
    border: none;
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
    padding: 1rem;
    vertical-align: middle;
    font-size: 0.9rem;
    color: var(--text-dark);
}

/* Status Badge Premium */
.status-badge {
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    padding: 0.3rem 0.8rem;
    border-radius: 40px;
    font-size: 0.7rem;
    font-weight: 700;
    letter-spacing: 0.5px;
}

.status-ACTIVE {
    background: linear-gradient(135deg, rgba(16, 185, 129, 0.15), rgba(16, 185, 129, 0.08));
    color: var(--success);
    border: 1px solid rgba(16, 185, 129, 0.3);
}

.status-INACTIVE {
    background: linear-gradient(135deg, rgba(239, 68, 68, 0.15), rgba(239, 68, 68, 0.08));
    color: var(--danger);
    border: 1px solid rgba(239, 68, 68, 0.3);
}

/* Action Buttons */
.action-buttons {
    display: flex;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.btn-action {
    padding: 0.5rem 1rem;
    border-radius: 40px;
    font-size: 0.75rem;
    font-weight: 600;
    transition: var(--transition);
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    text-decoration: none;
    border: none;
}

.btn-view {
    background: rgba(59, 130, 246, 0.1);
    color: #3b82f6;
    border: 1px solid rgba(59, 130, 246, 0.2);
}

.btn-view:hover {
    background: #3b82f6;
    color: white;
    transform: translateY(-2px);
}

.btn-edit {
    background: rgba(245, 158, 11, 0.1);
    color: #f59e0b;
    border: 1px solid rgba(245, 158, 11, 0.2);
}

.btn-edit:hover {
    background: #f59e0b;
    color: white;
    transform: translateY(-2px);
}

.btn-delete {
    background: rgba(239, 68, 68, 0.1);
    color: #ef4444;
    border: 1px solid rgba(239, 68, 68, 0.2);
}

.btn-delete:hover {
    background: #ef4444;
    color: white;
    transform: translateY(-2px);
}

/* Back Button */
.btn-back {
    background: var(--bg-dark);
    color: white;
    border: none;
    padding: 0.75rem 1.5rem;
    border-radius: 50px;
    font-weight: 600;
    transition: var(--transition);
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    text-decoration: none;
}

.btn-back:hover {
    background: var(--bg-dark-light);
    transform: translateY(-2px);
    color: white;
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

.empty-state h4 {
    font-size: 1.3rem;
    font-weight: 700;
    color: var(--bg-dark);
    margin-bottom: 0.5rem;
}

.empty-state p {
    color: var(--text-muted);
}

/* Responsive */
@media (max-width: 992px) {
    .container {
        padding: 1rem;
    }
    .table thead th {
        font-size: 0.75rem;
        padding: 1rem 0.75rem;
    }
    .table tbody td {
        font-size: 0.8rem;
        padding: 0.75rem;
    }
}

@media (max-width: 768px) {
    .page-header h3 {
        font-size: 1.4rem;
    }
    .action-buttons {
        flex-direction: column;
    }
    .btn-action {
        width: 100%;
        justify-content: center;
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
    <div class="page-header">
        <h3>
            <i class="fas fa-dumbbell"></i>
            Manage Sports Services
        </h3>
        <p>Create, edit, and manage all sports and fitness services</p>
    </div>

    <!-- Add Button -->
    <a href="${pageContext.request.contextPath}/admin/sports/service/add" class="btn-add">
        <i class="fas fa-plus-circle"></i> Add New Service
    </a>

    <!-- Table -->
    <c:choose>
        <c:when test="${not empty services}">
            <div class="table-wrapper">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th><i class="fas fa-tag me-1"></i> Title</th>
                                <th><i class="fas fa-futbol me-1"></i> Sport</th>
                                <th><i class="fas fa-rupee-sign me-1"></i> Price</th>
                                <th><i class="fas fa-chart-line me-1"></i> Status</th>
                                <th><i class="fas fa-cog me-1"></i> Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="service" items="${services}">
                                <tr>
                                    <td class="fw-semibold">${service.serviceTitle}</td>
                                    <td>${service.sportType}</td>
                                    <td class="fw-bold" style="color: var(--primary);">₹ ${service.basePrice}</td>
                                    <td>
                                        <span class="status-badge status-${service.status}">
                                            <i class="fas ${service.status == 'ACTIVE' ? 'fa-check-circle' : 'fa-ban'}"></i>
                                            ${service.status}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <a class="btn-action btn-view"
                                               href="${pageContext.request.contextPath}/admin/sports/service/view/${service.id}">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                            <a class="btn-action btn-edit"
                                               href="${pageContext.request.contextPath}/admin/sports/service/edit/${service.id}">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <a class="btn-action btn-delete"
                                               href="${pageContext.request.contextPath}/admin/sports/service/delete/${service.id}"
                                               onclick="return confirm('⚠️ Delete this service permanently? This action cannot be undone.');">
                                                <i class="fas fa-trash"></i> Delete
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-dumbbell"></i>
                <h4>No Services Found</h4>
                <p>Get started by adding your first sports service.</p>
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