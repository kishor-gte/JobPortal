<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>${service.serviceTitle} | JobU - Sports Service Details</title>
    
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

        .container {
            max-width: 1200px;
            position: relative;
            z-index: 2;
            padding: 2rem 1rem;
        }

        /* Premium Card */
        .premium-card {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.08);
            overflow: hidden;
            transition: var(--transition);
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .premium-card:hover {
            box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
        }

        /* Header */
        .service-header {
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
            padding: 2rem;
            color: white;
        }

        .service-header h2 {
            margin: 0;
            font-size: 2rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .service-header h2 i {
            color: var(--accent);
            font-size: 2rem;
        }

        /* Cover Image */
        .cover-image {
            width: 100%;
            max-height: 400px;
            object-fit: cover;
            transition: var(--transition);
        }

        .cover-image:hover {
            transform: scale(1.01);
        }

        /* Section Styles */
        .info-section {
            padding: 2rem;
            border-bottom: 1px solid rgba(25,167,123,0.1);
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--bg-dark);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid var(--primary);
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            color: var(--primary);
            font-size: 1.2rem;
        }

        /* Info Grid */
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1rem;
        }

        .info-item {
            background: rgba(25,167,123,0.03);
            border-radius: var(--radius-sm);
            padding: 1rem;
            transition: var(--transition);
        }

        .info-item:hover {
            background: rgba(25,167,123,0.06);
            transform: translateX(4px);
        }

        .info-label {
            font-size: 0.7rem;
            font-weight: 700;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
            display: block;
        }

        .info-value {
            font-size: 0.95rem;
            color: var(--text-dark);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .info-value i {
            color: var(--primary);
            width: 20px;
        }

        .info-value a {
            color: var(--primary);
            text-decoration: none;
            transition: var(--transition);
            word-break: break-all;
        }

        .info-value a:hover {
            text-decoration: underline;
        }

        /* List styling */
        .inclusion-list {
            list-style: none;
            padding: 0;
            display: flex;
            flex-wrap: wrap;
            gap: 0.75rem;
        }

        .inclusion-list li {
            background: rgba(25,167,123,0.08);
            padding: 0.5rem 1rem;
            border-radius: 40px;
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .inclusion-list li i {
            color: var(--primary);
        }

        /* Gallery */
        .gallery-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 1rem;
        }

        .gallery-img {
            width: 100%;
            height: 150px;
            object-fit: cover;
            border-radius: var(--radius-sm);
            transition: var(--transition);
            cursor: pointer;
        }

        .gallery-img:hover {
            transform: scale(1.02);
            box-shadow: var(--shadow-md);
        }

        /* Badge */
        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.3rem 1rem;
            border-radius: 40px;
            font-size: 0.75rem;
            font-weight: 700;
        }

        .status-ACTIVE {
            background: rgba(25, 167, 123, 0.12);
            color: #19A77B;
        }

        .status-INACTIVE {
            background: rgba(239, 68, 68, 0.12);
            color: #ef4444;
        }

        /* Back Button */
        .btn-back {
            background: var(--bg-dark);
            color: white;
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 0.6rem;
            text-decoration: none;
            margin: 2rem 0 1rem;
        }

        .btn-back:hover {
            background: var(--bg-dark-light);
            transform: translateY(-2px);
            color: white;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .service-header h2 { font-size: 1.5rem; }
            .info-section { padding: 1.5rem; }
            .section-title { font-size: 1.1rem; }
            .info-grid { grid-template-columns: 1fr; }
            .gallery-grid { grid-template-columns: repeat(auto-fill, minmax(140px, 1fr)); }
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: #e0ece6; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

        ::selection { background: var(--primary); color: white; }
    </style>
<jsp:include page="/views/commons/admin_shell_head.jsp" />
</head>
<body>

<jsp:include page="/views/commons/admin_shell_start.jsp">
  <jsp:param name="pageTitle" value="View Sports Service"/>
  <jsp:param name="pageSubtitle" value="Service details"/>
  <jsp:param name="activeNav" value="sports-list"/>
</jsp:include>

<!-- decorative floating elements -->
<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<div class="container">
    <div class="premium-card">
        <!-- Header -->
        <div class="service-header">
            <h2>
                <i class="fas fa-dumbbell"></i>
                ${service.serviceTitle}
            </h2>
        </div>

        <!-- Cover Image -->
        <c:if test="${not empty service.coverImageUrl}">
            <img src="${service.coverImageUrl}" class="cover-image" alt="${service.serviceTitle}">
        </c:if>

        <!-- Basic Details -->
        <div class="info-section">
            <h3 class="section-title"><i class="fas fa-info-circle"></i> Basic Details</h3>
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">Sport Type</span>
                    <span class="info-value"><i class="fas fa-futbol"></i> ${service.sportType}</span>
                </div>
                <div class="info-item">
                    <span class="info-label">Status</span>
                    <span class="info-value">
                        <span class="status-badge status-${service.status}">
                            <i class="fas ${service.status == 'ACTIVE' ? 'fa-check-circle' : 'fa-ban'}"></i>
                            ${service.status}
                        </span>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Description</span>
                    <span class="info-value">${service.description}</span>
                </div>
            </div>
        </div>

        <!-- Pricing -->
        <div class="info-section">
            <h3 class="section-title"><i class="fas fa-tag"></i> Pricing</h3>
            <div class="info-grid">
                <div class="info-item"><span class="info-label">Base Price</span><span class="info-value"><i class="fas fa-rupee-sign"></i> ${service.basePrice}</span></div>
                <div class="info-item"><span class="info-label">Pricing Unit</span><span class="info-value"><i class="fas fa-clock"></i> ${service.pricingUnit}</span></div>
                <div class="info-item"><span class="info-label">Tax %</span><span class="info-value"><i class="fas fa-percent"></i> ${service.taxPercent}</span></div>
                <div class="info-item"><span class="info-label">Refundable Deposit</span><span class="info-value"><i class="fas fa-rupee-sign"></i> ${service.refundableDeposit}</span></div>
                <div class="info-item"><span class="info-label">Advance Payment %</span><span class="info-value"><i class="fas fa-percent"></i> ${service.advancePaymentPercent}</span></div>
                <div class="info-item"><span class="info-label">Min Booking Notice</span><span class="info-value"><i class="fas fa-hourglass-half"></i> ${service.minimumBookingNoticeHours} hrs</span></div>
            </div>
        </div>

        <!-- Capacity & Experience -->
        <div class="info-section">
            <h3 class="section-title"><i class="fas fa-users"></i> Capacity & Experience</h3>
            <div class="info-grid">
                <div class="info-item"><span class="info-label">Duration</span><span class="info-value"><i class="fas fa-hourglass"></i> ${service.durationInHours} hrs</span></div>
                <div class="info-item"><span class="info-label">Max Participants</span><span class="info-value"><i class="fas fa-user-friends"></i> ${service.maxParticipants}</span></div>
                <div class="info-item"><span class="info-label">Team Size</span><span class="info-value"><i class="fas fa-people-arrows"></i> ${service.recommendedTeamSizeMin} - ${service.recommendedTeamSizeMax}</span></div>
                <div class="info-item"><span class="info-label">Experience Level</span><span class="info-value"><i class="fas fa-chart-line"></i> ${service.experienceLevel}</span></div>
            </div>
        </div>

        <!-- Inclusions -->
        <div class="info-section">
            <h3 class="section-title"><i class="fas fa-check-circle"></i> Inclusions</h3>
            <ul class="inclusion-list">
                <li><i class="fas ${service.refereeIncluded ? 'fa-check-circle' : 'fa-times-circle'}"></i> Referee</li>
                <li><i class="fas ${service.equipmentIncluded ? 'fa-check-circle' : 'fa-times-circle'}"></i> Equipment</li>
                <li><i class="fas ${service.groundIncluded ? 'fa-check-circle' : 'fa-times-circle'}"></i> Ground</li>
                <li><i class="fas ${service.medicalSupport ? 'fa-check-circle' : 'fa-times-circle'}"></i> Medical Support</li>
            </ul>
            <c:if test="${not empty service.otherInclusions}">
                <div class="info-item mt-2"><span class="info-label">Other Inclusions</span><span class="info-value">${service.otherInclusions}</span></div>
            </c:if>
        </div>

        <!-- Customization -->
        <c:if test="${service.customizable}">
            <div class="info-section">
                <h3 class="section-title"><i class="fas fa-sliders-h"></i> Customization</h3>
                <div class="info-item"><span class="info-label">Customization Options</span><span class="info-value">${service.customizationOptions}</span></div>
            </div>
        </c:if>

        <!-- Location -->
        <div class="info-section">
            <h3 class="section-title"><i class="fas fa-map-marker-alt"></i> Location</h3>
            <div class="info-grid">
                <div class="info-item"><span class="info-label">City</span><span class="info-value"><i class="fas fa-city"></i> ${service.city}</span></div>
                <div class="info-item"><span class="info-label">Venue</span><span class="info-value"><i class="fas fa-building"></i> ${service.venueName}</span></div>
                <div class="info-item"><span class="info-label">Address</span><span class="info-value"><i class="fas fa-location-dot"></i> ${service.venueAddress}</span></div>
                <c:if test="${not empty service.googleMapUrl}">
                    <div class="info-item"><span class="info-label">Map</span><span class="info-value"><a href="${service.googleMapUrl}" target="_blank"><i class="fas fa-map"></i> View on Map</a></span></div>
                </c:if>
            </div>
        </div>

        <!-- Gallery -->
        <c:if test="${not empty service.galleryImageUrls}">
            <div class="info-section">
                <h3 class="section-title"><i class="fas fa-images"></i> Gallery</h3>
                <div class="gallery-grid">
                    <c:forEach var="img" items="${service.galleryImageUrls}">
                        <img src="${img}" class="gallery-img" alt="Gallery Image" onclick="window.open(this.src, '_blank')">
                    </c:forEach>
                </div>
            </div>
        </c:if>

        <!-- Rules & Legal -->
        <div class="info-section">
            <h3 class="section-title"><i class="fas fa-gavel"></i> Rules & Legal</h3>
            <div class="info-grid">
                <div class="info-item"><span class="info-label">Rules & Guidelines</span><span class="info-value">${service.rulesAndGuidelines}</span></div>
                <div class="info-item"><span class="info-label">Requirements</span><span class="info-value">${service.requirementsFromClient}</span></div>
                <div class="info-item"><span class="info-label">Terms & Conditions</span><span class="info-value">${service.termsAndConditions}</span></div>
                <div class="info-item"><span class="info-label">Liability Disclaimer</span><span class="info-value">${service.liabilityDisclaimer}</span></div>
            </div>
        </div>

        <!-- Safety & Backup -->
        <div class="info-section">
            <h3 class="section-title"><i class="fas fa-shield-alt"></i> Safety & Backup</h3>
            <div class="info-grid">
                <div class="info-item"><span class="info-label">Insurance</span><span class="info-value"><i class="fas ${service.insuranceCovered ? 'fa-check-circle' : 'fa-times-circle'}"></i> ${service.insuranceCovered ? 'Covered' : 'Not Covered'}</span></div>
                <div class="info-item"><span class="info-label">Insurance Details</span><span class="info-value">${service.insuranceDetails}</span></div>
                <div class="info-item"><span class="info-label">Safety Standards</span><span class="info-value">${service.safetyStandardsFollowed}</span></div>
                <div class="info-item"><span class="info-label">Weather Backup</span><span class="info-value"><i class="fas ${service.weatherBackupAvailable ? 'fa-check-circle' : 'fa-times-circle'}"></i> ${service.weatherBackupAvailable ? 'Available' : 'Not Available'}</span></div>
                <div class="info-item"><span class="info-label">Backup Venue</span><span class="info-value"><i class="fas ${service.backupVenueAvailable ? 'fa-check-circle' : 'fa-times-circle'}"></i> ${service.backupVenueAvailable ? 'Available' : 'Not Available'}</span></div>
            </div>
        </div>

        <!-- Availability -->
        <div class="info-section">
            <h3 class="section-title"><i class="fas fa-calendar-alt"></i> Availability</h3>
            <div class="info-grid">
                <div class="info-item"><span class="info-label">Weekdays</span><span class="info-value"><i class="fas ${service.availableOnWeekdays ? 'fa-check-circle' : 'fa-times-circle'}"></i> ${service.availableOnWeekdays ? 'Available' : 'Not Available'}</span></div>
                <div class="info-item"><span class="info-label">Weekends</span><span class="info-value"><i class="fas ${service.availableOnWeekends ? 'fa-check-circle' : 'fa-times-circle'}"></i> ${service.availableOnWeekends ? 'Available' : 'Not Available'}</span></div>
                <div class="info-item"><span class="info-label">Time Slot</span><span class="info-value"><i class="fas fa-clock"></i> ${service.availableFrom} - ${service.availableTo}</span></div>
                <div class="info-item"><span class="info-label">Max Bookings/Day</span><span class="info-value"><i class="fas fa-calendar-day"></i> ${service.maxBookingsPerDay}</span></div>
                <div class="info-item"><span class="info-label">Multiple Teams</span><span class="info-value"><i class="fas ${service.allowsMultipleTeams ? 'fa-check-circle' : 'fa-times-circle'}"></i> ${service.allowsMultipleTeams ? 'Allowed' : 'Not Allowed'}</span></div>
            </div>
        </div>

        <!-- Admin Controls -->
        <div class="info-section">
            <h3 class="section-title"><i class="fas fa-cog"></i> Admin Controls</h3>
            <div class="info-grid">
                <div class="info-item"><span class="info-label">Priority Score</span><span class="info-value"><i class="fas fa-star"></i> ${service.priorityScore}</span></div>
                <div class="info-item"><span class="info-label">Featured</span><span class="info-value"><i class="fas ${service.featured ? 'fa-gem' : 'fa-ban'}"></i> ${service.featured ? 'Yes' : 'No'}</span></div>
                <div class="info-item"><span class="info-label">Internal Notes</span><span class="info-value"><i class="fas fa-sticky-note"></i> ${service.internalNotes}</span></div>
            </div>
        </div>

        <!-- Back Button -->
        <div class="text-center pb-4">
            <a href="${pageContext.request.contextPath}/admin/sports/service/list" class="btn-back">
                <i class="fas fa-arrow-left"></i> Back to Services
            </a>
        </div>
    </div>
</div>

<script>
// Gallery image click to open full size
document.querySelectorAll('.gallery-img').forEach(img => {
    img.addEventListener('click', function() {
        window.open(this.src, '_blank');
    });
});

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
<jsp:include page="/views/commons/admin_shell_end.jsp" />
</body>
</html>