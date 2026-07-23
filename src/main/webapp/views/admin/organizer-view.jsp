<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>${organizer.organizationName} | Organizer Review - JobU Admin</title>

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
    --success: #19A77B;
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
    padding: 2rem 2rem;
    border-radius: var(--radius-lg);
    margin-bottom: 2rem;
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
    font-size: 1.8rem;
    font-weight: 800;
    letter-spacing: -0.5px;
    margin: 0;
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
    margin-top: 0.5rem;
    position: relative;
    z-index: 1;
}

/* Info Grid */
.info-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
    gap: 1.5rem;
    margin-bottom: 2rem;
}

/* Premium Card */
.info-card {
    background: var(--card-bg);
    backdrop-filter: blur(8px);
    border-radius: var(--radius-md);
    box-shadow: var(--shadow-md), 0 0 0 1px rgba(25,167,123,0.08);
    transition: var(--transition);
    overflow: hidden;
    animation: cardFadeIn 0.5s ease-out both;
}

@keyframes cardFadeIn {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.info-card:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
}

.card-header {
    background: linear-gradient(135deg, var(--bg-dark), var(--bg-dark-light));
    color: white;
    padding: 1rem 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.card-header i {
    color: var(--accent);
    font-size: 1.2rem;
}

.card-header h3 {
    margin: 0;
    font-size: 1.1rem;
    font-weight: 700;
    letter-spacing: -0.3px;
}

.card-body {
    padding: 1.5rem;
}

.info-row {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    padding: 0.75rem 0;
    border-bottom: 1px solid rgba(25,167,123,0.08);
}

.info-row:last-child {
    border-bottom: none;
}

.info-label {
    font-weight: 600;
    color: var(--text-muted);
    font-size: 0.8rem;
    letter-spacing: 0.3px;
}

.info-value {
    font-weight: 700;
    color: var(--text-dark);
    font-size: 0.9rem;
    text-align: right;
}

/* Document & Photo Gallery */
.documents-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 1rem;
}

.doc-card {
    background: rgba(25,167,123,0.05);
    border-radius: var(--radius-sm);
    padding: 1rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    transition: var(--transition);
}

.doc-card:hover {
    background: rgba(25,167,123,0.1);
    transform: translateX(4px);
}

.doc-info {
    display: flex;
    flex-direction: column;
    gap: 0.25rem;
}

.doc-type {
    font-weight: 700;
    color: var(--text-dark);
    font-size: 0.85rem;
}

.doc-status {
    display: inline-flex;
    align-items: center;
    gap: 0.3rem;
    font-size: 0.7rem;
    padding: 0.2rem 0.5rem;
    border-radius: 20px;
    width: fit-content;
}

.status-verified {
    background: rgba(25, 167, 123, 0.15);
    color: var(--success);
}

.status-pending {
    background: rgba(245, 158, 11, 0.15);
    color: var(--warning);
}

.doc-link {
    color: var(--primary);
    text-decoration: none;
    font-size: 0.8rem;
    font-weight: 600;
    transition: var(--transition);
}

.doc-link:hover {
    color: var(--primary-dark);
    text-decoration: underline;
}

/* Photo Gallery */
.photos-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
    gap: 1rem;
}

.photo-card {
    background: var(--card-bg);
    border-radius: var(--radius-sm);
    overflow: hidden;
    box-shadow: var(--shadow-sm);
    transition: var(--transition);
    cursor: pointer;
}

.photo-card:hover {
    transform: scale(1.02);
    box-shadow: var(--shadow-lg);
}

.photo-card img {
    width: 100%;
    height: 150px;
    object-fit: cover;
    display: block;
}

/* Action Button */
.action-section {
    margin-top: 2rem;
    text-align: center;
}

.btn-approve {
    background: linear-gradient(105deg, var(--primary), var(--primary-dark));
    color: white;
    border: none;
    padding: 1rem 2.5rem;
    border-radius: 50px;
    font-weight: 700;
    font-size: 1rem;
    transition: var(--transition);
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 0.75rem;
    box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
}

.btn-approve:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
}

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
    margin-left: 1rem;
}

.btn-back:hover {
    background: var(--bg-dark-light);
    transform: translateY(-2px);
    color: white;
}

/* Empty State */
.empty-state {
    text-align: center;
    padding: 3rem;
    color: var(--text-muted);
    background: rgba(25,167,123,0.03);
    border-radius: var(--radius-md);
}

/* Responsive */
@media (max-width: 768px) {
    .container {
        padding: 1rem;
    }
    .premium-header h2 {
        font-size: 1.4rem;
        flex-direction: column;
        text-align: center;
        gap: 0.5rem;
    }
    .info-grid {
        grid-template-columns: 1fr;
    }
    .info-row {
        flex-direction: column;
        gap: 0.25rem;
    }
    .info-value {
        text-align: left;
    }
    .photos-grid {
        grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
    }
    .action-section {
        display: flex;
        flex-direction: column;
        gap: 1rem;
    }
    .btn-back {
        margin-left: 0;
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
    <div class="premium-header">
        <h2>
            <i class="fas fa-building"></i>
            ${organizer.organizationName}
        </h2>
        <p>Review organizer details and verify application</p>
    </div>

    <!-- Info Grid -->
    <div class="info-grid">
        <!-- Basic Information -->
        <div class="info-card">
            <div class="card-header">
                <i class="fas fa-user-circle"></i>
                <h3>Basic Information</h3>
            </div>
            <div class="card-body">
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-user"></i> Contact Person</span>
                    <span class="info-value">${organizer.contactPersonName}</span>
                </div>
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-envelope"></i> Email</span>
                    <span class="info-value">${organizer.email}</span>
                </div>
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-phone"></i> Phone</span>
                    <span class="info-value">${organizer.phone}</span>
                </div>
            </div>
        </div>

        <!-- Business Details -->
        <div class="info-card">
            <div class="card-header">
                <i class="fas fa-chart-line"></i>
                <h3>Business & Credibility</h3>
            </div>
            <div class="card-body">
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-id-card"></i> Registration No.</span>
                    <span class="info-value">${organizer.registrationNumber}</span>
                </div>
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-file-invoice"></i> GST Number</span>
                    <span class="info-value">${organizer.gstNumber}</span>
                </div>
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-briefcase"></i> Years Experience</span>
                    <span class="info-value">${organizer.yearsOfExperience} years</span>
                </div>
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-calendar"></i> Events Conducted</span>
                    <span class="info-value">${organizer.eventsConducted}</span>
                </div>
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-building"></i> Corporate Clients</span>
                    <span class="info-value">${organizer.corporateClients}</span>
                </div>
            </div>
        </div>

        <!-- About Organization -->
        <div class="info-card">
            <div class="card-header">
                <i class="fas fa-info-circle"></i>
                <h3>About Organization</h3>
            </div>
            <div class="card-body">
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-futbol"></i> Sports Handled</span>
                    <span class="info-value">${organizer.sportsHandled}</span>
                </div>
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-align-left"></i> Description</span>
                    <span class="info-value">${organizer.aboutOrganization}</span>
                </div>
            </div>
        </div>

        <!-- Address -->
        <div class="info-card">
            <div class="card-header">
                <i class="fas fa-map-marker-alt"></i>
                <h3>Address</h3>
            </div>
            <div class="card-body">
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-location-dot"></i> Full Address</span>
                    <span class="info-value">
                        ${organizer.address},<br/>
                        ${organizer.city}, ${organizer.state},<br/>
                        ${organizer.country} - ${organizer.pincode}
                    </span>
                </div>
            </div>
        </div>

        <!-- Bank Details -->
        <div class="info-card">
            <div class="card-header">
                <i class="fas fa-university"></i>
                <h3>Bank / Payment Details</h3>
            </div>
            <div class="card-body">
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-landmark"></i> Bank Name</span>
                    <span class="info-value">${organizer.bankName}</span>
                </div>
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-credit-card"></i> Account Number</span>
                    <span class="info-value">${organizer.accountNumber}</span>
                </div>
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-code"></i> IFSC Code</span>
                    <span class="info-value">${organizer.ifscCode}</span>
                </div>
                <div class="info-row">
                    <span class="info-label"><i class="fas fa-mobile-alt"></i> UPI ID</span>
                    <span class="info-value">${organizer.upiId}</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Verification Documents -->
    <div class="info-card" style="margin-bottom: 2rem;">
        <div class="card-header">
            <i class="fas fa-file-alt"></i>
            <h3>Verification Documents</h3>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty documents}">
                    <div class="empty-state">
                        <i class="fas fa-folder-open"></i>
                        <p>No documents uploaded.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="documents-grid">
                        <c:forEach var="doc" items="${documents}">
                            <div class="doc-card">
                                <div class="doc-info">
                                    <span class="doc-type">${doc.documentType}</span>
                                    <span class="doc-status ${doc.verified ? 'status-verified' : 'status-pending'}">
                                        <i class="fas ${doc.verified ? 'fa-check-circle' : 'fa-clock'}"></i>
                                        ${doc.verified ? 'Verified' : 'Pending'}
                                    </span>
                                </div>
                                <a href="${pageContext.request.contextPath}${doc.filePath}" target="_blank" class="doc-link">
                                    <i class="fas fa-eye"></i> View
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Past Event Photos -->
    <div class="info-card" style="margin-bottom: 2rem;">
        <div class="card-header">
            <i class="fas fa-images"></i>
            <h3>Past Event Photos</h3>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${empty photos}">
                    <div class="empty-state">
                        <i class="fas fa-camera"></i>
                        <p>No event photos uploaded.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="photos-grid">
                        <c:forEach var="photo" items="${photos}">
                            <div class="photo-card" onclick="window.open('${pageContext.request.contextPath}${photo.filePath}', '_blank')">
                                <img src="${pageContext.request.contextPath}${photo.filePath}" alt="Event Photo">
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- Action Section -->
    <div class="action-section">
        <form action="${pageContext.request.contextPath}/admin/organizers/approve/${organizer.id}" method="post" style="display: inline-block;">
            <button type="submit" class="btn-approve" onclick="return confirm('Approve this organizer? They will gain full access to the platform.');">
                <i class="fas fa-check-circle"></i> Approve Organizer
            </button>
        </form>
        <a href="${pageContext.request.contextPath}/admin/organizers/pending" class="btn-back">
            <i class="fas fa-arrow-left"></i> Back to Pending List
        </a>
    </div>
</div>

<script>
// Lightbox for photos (simple click to open)
document.querySelectorAll('.photo-card').forEach(card => {
    card.addEventListener('click', function() {
        const img = this.querySelector('img');
        if (img) {
            window.open(img.src, '_blank');
        }
    });
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