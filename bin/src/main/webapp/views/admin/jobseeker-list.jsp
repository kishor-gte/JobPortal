<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>All Job Seekers | JobU - Talent Directory</title>
    
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
            --danger: #ef4444;
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
            padding: 2rem 0;
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
            font-size: 1.8rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .page-header p {
            font-size: 0.9rem;
            opacity: 0.85;
            position: relative;
            z-index: 1;
        }

        .seeker-count {
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(8px);
            padding: 0.4rem 1rem;
            border-radius: 40px;
            font-size: 0.8rem;
            font-weight: 500;
            margin-top: 0.75rem;
            position: relative;
            z-index: 1;
        }

        /* Search Section Premium */
        .search-section {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            padding: 1.25rem;
            box-shadow: var(--shadow-md), 0 0 0 1px rgba(25,167,123,0.08);
            margin-bottom: 2rem;
            transition: var(--transition);
        }

        .search-section:hover {
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.15);
        }

        .search-input-group {
            position: relative;
        }

        .search-input-group i {
            position: absolute;
            left: 1.2rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 1rem;
            z-index: 2;
        }

        .search-input-group input {
            padding-left: 3rem;
            border-radius: 60px;
            border: 2px solid #e2ede7;
            font-size: 0.9rem;
            transition: var(--transition);
            background: white;
            height: 48px;
        }

        .search-input-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25, 167, 123, 0.12);
            outline: none;
        }

        /* Grid Layout */
        .seekers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        /* Premium Seeker Cards */
        .seeker-card {
            background: var(--card-bg);
            backdrop-filter: blur(4px);
            border-radius: var(--radius-md);
            padding: 1.25rem;
            box-shadow: var(--shadow-sm), 0 0 0 1px rgba(25,167,123,0.06);
            transition: var(--transition);
            height: 100%;
            display: flex;
            flex-direction: column;
            animation: cardFadeIn 0.5s ease-out both;
        }

        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .seeker-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        .seeker-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .seeker-avatar {
            width: 56px;
            height: 56px;
            border-radius: 20px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary);
            border: 1px solid rgba(25,167,123,0.15);
            transition: var(--transition);
            flex-shrink: 0;
            overflow: hidden;
        }

        .seeker-card:hover .seeker-avatar {
            transform: scale(1.05);
            border-color: var(--primary);
        }

        .seeker-avatar img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .seeker-info {
            flex: 1;
            min-width: 0;
        }

        .seeker-name {
            font-size: 1.1rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--bg-dark), #4a6569);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 0.25rem;
            letter-spacing: -0.3px;
        }

        .seeker-details {
            font-size: 0.8rem;
            color: var(--text-muted);
            display: flex;
            flex-direction: column;
            gap: 0.6rem;
            margin: 0.75rem 0;
            flex-grow: 1;
        }

        .detail-line {
            display: flex;
            align-items: center;
            gap: 0.6rem;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .detail-line i {
            color: var(--primary);
            font-size: 0.75rem;
            width: 18px;
            flex-shrink: 0;
        }

        .detail-line a {
            color: var(--text-dark);
            text-decoration: none;
            font-size: 0.8rem;
            transition: var(--transition);
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .detail-line a:hover {
            color: var(--primary);
            text-decoration: underline;
        }

        .detail-line span {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        /* Premium Buttons */
        .seeker-actions {
            display: flex;
            gap: 0.75rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 2px solid rgba(25,167,123,0.1);
        }

        .btn-action {
            flex: 1;
            padding: 0.6rem 0.75rem;
            border-radius: 40px;
            font-weight: 600;
            font-size: 0.8rem;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            text-decoration: none;
            border: none;
            cursor: pointer;
        }

        .btn-reviews {
            background: rgba(25,167,123,0.08);
            color: var(--primary);
            border: 1px solid rgba(25,167,123,0.15);
        }

        .btn-reviews:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 6px 14px rgba(25,167,123,0.3);
        }

        .btn-profile {
            background: linear-gradient(105deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: 0 4px 12px rgba(25,167,123,0.25);
        }

        .btn-profile:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
            color: white;
        }

        .btn-action i {
            font-size: 0.75rem;
        }

        /* Empty State Premium */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            display: none;
        }

        .empty-state.show {
            display: block;
            animation: fadeInUp 0.4s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
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

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 1.5rem 0; }
            .page-header h1 { font-size: 1.5rem; }
            .seekers-grid { grid-template-columns: 1fr; gap: 1rem; }
            .search-section { padding: 1rem; }
            .seeker-header { flex-direction: column; text-align: center; }
            .seeker-name { text-align: center; }
            .seeker-actions { flex-direction: column; }
            .btn-action { width: 100%; }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection { background: var(--primary); color: white; }
    </style>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <h1><i class="fas fa-users me-2" style="color: var(--accent);"></i>All Job Seekers</h1>
        <p>Browse and manage all registered job seekers</p>
        <div class="seeker-count">
            <i class="fas fa-user-check"></i>
            <span id="seekerCount">${fn:length(jobSeekers)} Job Seeker${fn:length(jobSeekers) != 1 ? 's' : ''}</span>
        </div>
    </div>
</div>

<div class="container">
    <!-- Search Section -->
    <div class="search-section">
        <div class="search-input-group">
            <i class="fas fa-search"></i>
            <input type="text" 
                   id="searchInput" 
                   class="form-control" 
                   placeholder="Search by name, email, phone, or location...">
        </div>
    </div>

    <!-- Job Seekers Listings -->
    <c:choose>
        <c:when test="${empty jobSeekers}">
            <div class="empty-state show">
                <i class="fas fa-users"></i>
                <h3>No Job Seekers</h3>
                <p>There are no job seekers registered in the system at the moment.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="seekers-grid" id="seekerList">
                <c:forEach var="js" items="${jobSeekers}">
                    <c:set var="searchText"
                        value="${fn:toLowerCase(js.name)} ${fn:toLowerCase(js.email)} ${fn:toLowerCase(js.phone)} ${fn:toLowerCase(js.location)}" />
                    
                    <div class="seeker-card-item" 
                         data-search="${fn:escapeXml(searchText)}">
                        <div class="seeker-card">
                            <div class="seeker-header">
                                <div class="seeker-avatar">
                                    <c:choose>
                                        <c:when test="${js.profilePicture != null && js.profilePicture ne ''}">
                                            <img src="${js.profilePicture}" 
                                                 alt="${js.name}" 
                                                 onerror="this.style.display='none'; this.parentElement.innerHTML='${fn:substring(js.name, 0, 1)}';">
                                        </c:when>
                                        <c:otherwise>
                                            ${fn:substring(js.name, 0, 1)}
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="seeker-info">
                                    <div class="seeker-name">${js.name}</div>
                                </div>
                            </div>

                            <div class="seeker-details">
                                <div class="detail-line">
                                    <i class="fas fa-envelope"></i>
                                    <a href="mailto:${js.email}" title="${js.email}">${js.email}</a>
                                </div>
                                <div class="detail-line">
                                    <i class="fas fa-phone"></i>
                                    <span title="${js.phone}">${js.phone}</span>
                                </div>
                                <c:if test="${js.experience != null}">
                                    <div class="detail-line">
                                        <i class="fas fa-briefcase"></i>
                                        <span>${js.experience} years experience</span>
                                    </div>
                                </c:if>
                                <c:if test="${js.location != null}">
                                    <div class="detail-line">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span>${js.location}</span>
                                    </div>
                                </c:if>
                            </div>

                            <div class="seeker-actions">
                                <a href="${pageContext.request.contextPath}/reviews/${js.id}" 
                                   class="btn-action btn-reviews">
                                    <i class="fas fa-star"></i>
                                    Reviews
                                </a>
                                <a href="${pageContext.request.contextPath}/profile/${js.id}" 
                                   class="btn-action btn-profile">
                                    <i class="fas fa-eye"></i>
                                    View Profile
                                </a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="empty-state" id="emptyState">
                <i class="fas fa-search"></i>
                <h3>No Job Seekers Found</h3>
                <p>No job seekers match your search criteria.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Search functionality with animation
document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('searchInput');
    const seekerCards = document.querySelectorAll('.seeker-card-item');
    const emptyState = document.getElementById('emptyState');
    const seekerCount = document.getElementById('seekerCount');
    
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            const filter = this.value.toLowerCase().trim();
            let visibleCount = 0;
            
            seekerCards.forEach(function(card, index) {
                const searchText = card.getAttribute('data-search') || '';
                
                if (searchText.includes(filter)) {
                    card.style.display = '';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            if (emptyState) {
                if (visibleCount === 0 && filter !== '') {
                    emptyState.classList.add('show');
                } else {
                    emptyState.classList.remove('show');
                }
            }
            
            if (seekerCount) {
                const totalCount = seekerCards.length;
                if (filter === '') {
                    seekerCount.textContent = totalCount + ' Job Seeker' + (totalCount !== 1 ? 's' : '');
                } else {
                    seekerCount.textContent = visibleCount + ' of ' + totalCount + ' Job Seeker' + (totalCount !== 1 ? 's' : '');
                }
            }
        });
    }
});

// Preserved original mobile responsive script
document.addEventListener('DOMContentLoaded', function() {
    if (!document.getElementById('mobile-responsive-style')) {
        const style = document.createElement('style');
        style.id = 'mobile-responsive-style';
        style.innerHTML = `@media (max-width: 768px) { .sidebar, .nav-sidebar { transform: translateX(-100%); transition: transform 0.3s ease; position: fixed !important; z-index: 1001 !important; height: 100vh; } .sidebar.active, .nav-sidebar.active { transform: translateX(0); box-shadow: 2px 0 20px rgba(0,0,0,0.2) !important; } .main-content { margin-left: 0 !important; padding: 16px !important; width: 100% !important; max-width: 100% !important; } } .mobile-menu-btn { display: none; }`;
        document.head.appendChild(style);
    }
    
    const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
    if (sidebar) {
        const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
        let heading = null;
        if (topBar && topBar !== document.body) heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
        if (!heading && !document.querySelector('.mobile-menu-btn')) { heading = document.createElement('div'); heading.style.padding = '10px'; document.body.insertBefore(heading, document.body.firstChild); }
        if (heading && !document.querySelector('.mobile-menu-btn')) {
            heading.style.display = 'flex'; heading.style.alignItems = 'center';
            const toggleBtn = document.createElement('button'); toggleBtn.className = 'mobile-menu-btn'; toggleBtn.innerHTML = '<i class="fas fa-bars"></i>';
            heading.insertBefore(toggleBtn, heading.firstChild);
            const overlay = document.createElement('div'); overlay.className = 'mobile-overlay'; document.body.appendChild(overlay);
            let touchstartX = 0, touchendX = 0;
            document.body.addEventListener('touchstart', e => { touchstartX = e.changedTouches[0].screenX; }, {passive: true});
            document.body.addEventListener('touchend', e => { touchendX = e.changedTouches[0].screenX; if (touchendX < touchstartX - 50) closeSidebar(); if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); }, {passive: true});
            function openSidebar() { sidebar.classList.add('active'); overlay.classList.add('active'); document.body.style.overflow = 'hidden'; }
            function closeSidebar() { sidebar.classList.remove('active'); overlay.classList.remove('active'); document.body.style.overflow = ''; }
            toggleBtn.addEventListener('click', openSidebar); overlay.addEventListener('click', closeSidebar);
        }
    }
    
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => {
        const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText);
        const rows = Array.from(table.querySelectorAll('tbody tr'));
        rows.forEach(row => { Array.from(row.querySelectorAll('td')).forEach((td, index) => { if(headers[index]) td.setAttribute('data-label', headers[index]); }); });
    });
});
</script>
</body>
</html>