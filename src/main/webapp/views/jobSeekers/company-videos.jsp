<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Life at the Company | SmartInterview</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
:root{
    --primary: #19A77B;
    --primary-dark: #148F69;
    --accent: #3BC49A;
    --bg-dark: #2E3E41;
    --bg-darker: #1a2a2c;
    --bg-lighter: #3a4e51;
    --text-primary: #1e293b;
    --text-secondary: #475569;
    --text-tertiary: #64748b;
    --border-color: #e0e0e0;
    --card-bg: #ffffff;
    --hover-bg: rgba(25, 167, 123, 0.08);
    --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
    --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
    --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
    --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
    --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
}

*{box-sizing:border-box;}

body{
    margin:0;
    font-family:'Inter',sans-serif;
    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
    color:var(--text-primary);
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

/* ===== PAGE WRAPPER ===== */
.page{
    max-width:1120px;
    margin:0 auto;
    padding:32px 20px 60px;
    position: relative;
    z-index: 1;
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

/* ===== HEADER ===== */
.header{
    margin-bottom:28px;
}

.header h1{
    font-size: 32px;
    font-weight: 800;
    background: var(--gradient-primary);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    margin: 0 0 8px;
    display: flex;
    align-items: center;
    gap: 12px;
}

.header h1 i {
    background: var(--gradient-primary);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
    font-size: 32px;
}

.header p{
    margin-top:8px;
    font-size:15px;
    color:var(--text-tertiary);
}

.video-count{
    margin-top:14px;
    font-size:14px;
    color:var(--text-tertiary);
    display: flex;
    align-items: center;
    gap: 8px;
}

.video-count i {
    color: var(--primary);
}

/* ===== VIDEO LIST ===== */
.video-list{
    background:var(--card-bg);
    border-radius:20px;
    box-shadow:var(--shadow-md);
    overflow:hidden;
    border: 1px solid var(--border-color);
    backdrop-filter: blur(10px);
    animation: slideIn 0.5s ease-out;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateX(-20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

/* ===== VIDEO ITEM ===== */
.video-item{
    display:grid;
    grid-template-columns:320px 1fr;
    gap:24px;
    padding:24px;
    border-bottom:1px solid var(--border-color);
    transition: all 0.3s ease;
    animation: itemAppear 0.4s ease-out;
}

@keyframes itemAppear {
    from {
        opacity: 0;
        transform: translateY(10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.video-item:last-child{
    border-bottom:none;
}

.video-item:hover {
    background: var(--hover-bg);
}

/* fixed video frame */
.video-frame{
    width:100%;
    height:180px;
    background:var(--bg-darker);
    border-radius:14px;
    overflow:hidden;
    box-shadow: var(--shadow-sm);
    border: 1px solid var(--border-color);
    position: relative;
}

.video-frame::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(180deg, transparent 0%, rgba(0,0,0,0.02) 100%);
    pointer-events: none;
    border-radius: 14px;
}

.video-frame video{
    width:100%;
    height:100%;
    object-fit:cover;
}

/* info */
.video-info h3{
    margin:0 0 12px;
    font-size:20px;
    font-weight:700;
    color:var(--text-primary);
    display: flex;
    align-items: center;
    gap: 8px;
}

.video-info h3 i {
    color: var(--primary);
    font-size: 18px;
}

.video-info p{
    margin:0;
    font-size:14px;
    color:var(--text-tertiary);
    line-height:1.7;
}

/* ===== EMPTY STATE ===== */
.empty{
    background:var(--card-bg);
    border-radius:20px;
    box-shadow:var(--shadow-md);
    border: 1px solid var(--border-color);
    padding:60px 40px;
    text-align:center;
    backdrop-filter: blur(10px);
}

.empty i{
    font-size:56px;
    color:var(--primary);
    opacity: 0.3;
    margin-bottom:20px;
    animation: float 3s ease-in-out infinite;
}

@keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

.empty h3 {
    font-size: 22px;
    font-weight: 700;
    color: var(--text-primary);
    margin-bottom: 10px;
}

.empty p {
    font-size: 15px;
    color: var(--text-tertiary);
}

/* Back Button */
.back-link {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    color: var(--primary);
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
    margin-bottom: 24px;
    transition: all 0.3s ease;
    padding: 8px 18px;
    border-radius: 30px;
    background: var(--hover-bg);
    border: 1px solid rgba(25, 167, 123, 0.15);
}

.back-link:hover {
    background: var(--primary);
    color: white;
    transform: translateX(-6px);
    box-shadow: var(--glow-primary);
}

/* ===== MOBILE ===== */
@media(max-width:768px){
    .page {
        padding: 20px 16px 40px;
    }
    
    .video-item{
        grid-template-columns:1fr;
        padding: 20px;
    }
    .video-frame{
        height:200px;
    }
    
    .header h1 {
        font-size: 26px;
    }
}

@media(max-width:480px){
    .video-frame{
        height:180px;
    }
    
    .header h1 {
        font-size: 22px;
    }
}
</style>
</head>

<body>

<div class="page">

    <!-- Back Link -->
    <a href="javascript:history.back()" class="back-link">
        <i class="fas fa-arrow-left"></i> Back
    </a>

    <!-- HEADER -->
    <div class="header">
        <h1>
            <i class="fas fa-building"></i>
            Life at the Company
        </h1>
        <p>Explore workplace culture, people, and experiences</p>

        <c:if test="${not empty videos}">
            <div class="video-count">
                <i class="fas fa-play-circle"></i>
                ${fn:length(videos)} culture video${fn:length(videos) != 1 ? 's' : ''} available
            </div>
        </c:if>
    </div>

    <!-- CONTENT -->
    <c:choose>

        <c:when test="${empty videos}">
            <div class="empty">
                <i class="fas fa-video"></i>
                <h3>No Culture Videos Available</h3>
                <p>This company hasn't shared culture videos yet. Check back later!</p>
            </div>
        </c:when>

        <c:otherwise>
            <div class="video-list">
                <c:forEach var="video" items="${videos}" varStatus="status">
                    <div class="video-item" style="animation-delay: ${status.index * 0.05}s;">

                        <!-- VIDEO -->
                        <div class="video-frame">
                            <video controls preload="metadata" controlsList="nodownload" onerror="console.error('Video failed to load:', this.currentSrc)">
                                <source src="${video.url}" type="video/mp4" onerror="console.error('Source failed:', this.src)">
                                <source src="${pageContext.request.contextPath}${video.url}" type="video/mp4">
                                Your browser does not support the video tag.
                            </video>
                        </div>

                        <!-- INFO -->
                        <div class="video-info">
                            <h3>
                                <i class="fas fa-play-circle"></i>
                                ${video.title}
                            </h3>
                            <c:if test="${not empty video.description}">
                                <p>${video.description}</p>
                            </c:if>
                            <c:if test="${empty video.description}">
                                <p style="font-style: italic;">No description provided.</p>
                            </c:if>
                        </div>

                    </div>
                </c:forEach>
            </div>
        </c:otherwise>

    </c:choose>

</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add loading animation for videos
    const videos = document.querySelectorAll('video');
    videos.forEach(video => {
        video.addEventListener('loadstart', function() {
            this.style.opacity = '0.5';
        });
        video.addEventListener('canplay', function() {
            this.style.opacity = '1';
            this.style.transition = 'opacity 0.3s ease';
        });
    });

    // Keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Escape to go back
        if (e.key === 'Escape') {
            const backLink = document.querySelector('.back-link');
            if (backLink) {
                window.history.back();
            }
        }
    });

    // Mobile responsive menu (if sidebar exists)
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