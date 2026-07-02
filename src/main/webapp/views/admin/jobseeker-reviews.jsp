<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>${jobSeeker.name} | Reviews & Ratings - JobU Admin</title>

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
    --star-color: #fbbf24;
    --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
    --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
    --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
    --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
    --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
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

/* Premium Header */
.premium-header {
    background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
    color: white;
    padding: 2.5rem 2rem;
    text-align: center;
    position: relative;
    overflow: hidden;
    margin-bottom: 2.5rem;
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
    margin: 0;
    position: relative;
    z-index: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.75rem;
    flex-wrap: wrap;
}

.premium-header h2 i {
    color: var(--accent);
    font-size: 2rem;
}

.premium-header .subtitle {
    font-size: 1rem;
    opacity: 0.85;
    margin-top: 0.75rem;
    position: relative;
    z-index: 1;
}

/* Reviews Grid */
.reviews-container {
    max-width: 1300px;
    margin: 0 auto 60px auto;
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
    gap: 1.5rem;
    padding: 0 1.5rem;
}

/* Premium Review Card */
.review-card {
    background: var(--card-bg);
    backdrop-filter: blur(8px);
    padding: 1.5rem;
    border-radius: var(--radius-md);
    box-shadow: var(--shadow-md), 0 0 0 1px rgba(25,167,123,0.08);
    transition: var(--transition);
    display: flex;
    flex-direction: column;
    position: relative;
    overflow: hidden;
    animation: cardFadeIn 0.5s ease-out both;
}

@keyframes cardFadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.review-card:nth-child(1) { animation-delay: 0.05s; }
.review-card:nth-child(2) { animation-delay: 0.1s; }
.review-card:nth-child(3) { animation-delay: 0.15s; }
.review-card:nth-child(4) { animation-delay: 0.2s; }
.review-card:nth-child(5) { animation-delay: 0.25s; }
.review-card:nth-child(6) { animation-delay: 0.3s; }

.review-card:hover {
    transform: translateY(-6px);
    box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
}

/* Card accent border */
.review-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 4px;
    background: linear-gradient(90deg, var(--primary), var(--accent));
    transform: scaleX(0);
    transform-origin: left;
    transition: transform 0.4s ease;
}

.review-card:hover::before {
    transform: scaleX(1);
}

/* Company Header */
.company-header {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    margin-bottom: 1rem;
    padding-bottom: 0.75rem;
    border-bottom: 2px solid rgba(25,167,123,0.1);
}

.company-icon {
    width: 48px;
    height: 48px;
    background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.06));
    border-radius: 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.25rem;
    font-weight: 700;
    color: var(--primary);
    transition: var(--transition);
}

.review-card:hover .company-icon {
    transform: scale(1.05);
    background: linear-gradient(135deg, rgba(25,167,123,0.2), rgba(59,196,154,0.1));
}

.company-name {
    font-size: 1.2rem;
    font-weight: 700;
    background: linear-gradient(135deg, var(--bg-dark), #4a6569);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    letter-spacing: -0.3px;
}

/* Rating Stars */
.rating-container {
    display: flex;
    align-items: center;
    gap: 0.75rem;
    margin-bottom: 1rem;
    flex-wrap: wrap;
}

.stars {
    display: flex;
    gap: 0.25rem;
}

.star {
    font-size: 1.1rem;
    transition: var(--transition);
}

.star.filled {
    color: var(--star-color);
}

.star.empty {
    color: #e2e8f0;
}

.rating-value {
    font-weight: 700;
    font-size: 0.9rem;
    color: var(--primary);
    background: rgba(25,167,123,0.1);
    padding: 0.2rem 0.6rem;
    border-radius: 40px;
}

/* Comment Section */
.comment-section {
    background: rgba(25,167,123,0.03);
    border-radius: var(--radius-sm);
    padding: 1rem;
    margin-top: 0.5rem;
    border-left: 3px solid var(--primary);
}

.comment-label {
    font-size: 0.7rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: var(--primary);
    margin-bottom: 0.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.comment-label i {
    font-size: 0.7rem;
}

.comment-text {
    font-size: 0.9rem;
    line-height: 1.6;
    color: var(--text-dark);
    font-style: normal;
    word-wrap: break-word;
}

.comment-text i {
    color: var(--text-muted);
    font-style: italic;
}

/* Empty State */
.empty-state {
    text-align: center;
    padding: 4rem 2rem;
    background: var(--card-bg);
    backdrop-filter: blur(8px);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-md);
    max-width: 500px;
    margin: 0 auto;
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
.back-button {
    position: fixed;
    bottom: 2rem;
    right: 2rem;
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    color: white;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    box-shadow: var(--shadow-lg);
    transition: var(--transition);
    z-index: 100;
}

.back-button:hover {
    transform: translateY(-3px) scale(1.05);
    box-shadow: var(--shadow-xl);
    color: white;
}

/* Stats Summary */
.stats-summary {
    display: flex;
    justify-content: center;
    gap: 2rem;
    margin-bottom: 2rem;
    flex-wrap: wrap;
}

.stat-badge {
    background: var(--card-bg);
    backdrop-filter: blur(8px);
    padding: 0.75rem 1.5rem;
    border-radius: 60px;
    display: flex;
    align-items: center;
    gap: 0.75rem;
    box-shadow: var(--shadow-sm);
    border: 1px solid rgba(25,167,123,0.1);
}

.stat-badge i {
    color: var(--primary);
    font-size: 1.1rem;
}

.stat-badge span {
    font-weight: 700;
    color: var(--text-dark);
}

/* Responsive */
@media (max-width: 768px) {
    .premium-header h2 {
        font-size: 1.5rem;
        flex-direction: column;
    }
    .reviews-container {
        grid-template-columns: 1fr;
        padding: 0 1rem;
        gap: 1rem;
    }
    .review-card {
        padding: 1.25rem;
    }
    .company-name {
        font-size: 1rem;
    }
    .stats-summary {
        gap: 1rem;
    }
    .stat-badge {
        padding: 0.5rem 1rem;
        font-size: 0.8rem;
    }
    .back-button {
        bottom: 1rem;
        right: 1rem;
        width: 45px;
        height: 45px;
    }
}

@media (max-width: 480px) {
    .premium-header {
        padding: 1.5rem 1rem;
    }
    .premium-header h2 {
        font-size: 1.25rem;
    }
    .rating-container {
        flex-direction: column;
        align-items: flex-start;
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

<!-- Premium Header -->
<div class="premium-header">
    <a href="${pageContext.request.contextPath}/allJobSeekers" style="display: inline-flex; align-items: center; gap: 0.5rem; color: white; text-decoration: none; font-size: 0.85rem; font-weight: 600; background: rgba(255,255,255,0.15); backdrop-filter: blur(8px); padding: 0.4rem 1rem; border-radius: 40px; margin-bottom: 1.25rem; transition: all 0.3s ease; border: 1px solid rgba(255,255,255,0.2);" onmouseover="this.style.background='rgba(255,255,255,0.25)'" onmouseout="this.style.background='rgba(255,255,255,0.15)'">
        <i class="fas fa-arrow-left"></i> Back to Job Seekers
    </a>
    <h2>
        <i class="fas fa-star"></i>
        Reviews by ${jobSeeker.name}
    </h2>
    <div class="subtitle">
        <i class="fas fa-chart-line"></i> Real feedback from verified companies
    </div>
</div>

<!-- Stats Summary -->
<div class="stats-summary">
    <div class="stat-badge">
        <i class="fas fa-building"></i>
        <span>${fn:length(reviews)} Company Review${fn:length(reviews) != 1 ? 's' : ''}</span>
    </div>
    <div class="stat-badge">
        <i class="fas fa-calendar-alt"></i>
        <span>Latest feedback</span>
    </div>
</div>

<div class="reviews-container">
    <c:forEach var="review" items="${reviews}">
        <div class="review-card">
            <div class="company-header">
                <div class="company-icon">
                    <i class="fas fa-building"></i>
                </div>
                <div class="company-name">${review.company.name}</div>
            </div>
            
            <div class="rating-container">
                <div class="stars">
                    <c:forEach begin="1" end="5" var="i">
                        <c:choose>
                            <c:when test="${i <= review.rating}">
                                <i class="fas fa-star star filled"></i>
                            </c:when>
                            <c:otherwise>
                                <i class="far fa-star star empty"></i>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>
                <div class="rating-value">${review.rating}/5</div>
            </div>
            
            <div class="comment-section">
                <div class="comment-label">
                    <i class="fas fa-comment-dots"></i>
                    FEEDBACK
                </div>
                <div class="comment-text">
                    <c:choose>
                        <c:when test="${empty review.comment}">
                            <i class="fas fa-minus-circle"></i> No comment provided
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-quote-left" style="margin-right: 0.5rem; opacity: 0.5;"></i>
                            ${review.comment}
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </c:forEach>
</div>

<c:if test="${empty reviews}">
    <div class="empty-state">
        <i class="fas fa-star-of-life"></i>
        <h3>No Reviews Yet</h3>
        <p>${jobSeeker.name} hasn't received any company reviews yet.</p>
    </div>
</c:if>

<!-- Back to Top Button -->
<a href="#" class="back-button" id="backToTop">
    <i class="fas fa-arrow-up"></i>
</a>

<script>
// Back to top functionality
document.getElementById('backToTop').addEventListener('click', function(e) {
    e.preventDefault();
    window.scrollTo({ top: 0, behavior: 'smooth' });
});

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