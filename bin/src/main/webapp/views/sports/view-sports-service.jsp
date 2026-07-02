<%@ page session="false" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>View Service Details</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <style>
                .img-preview {
                    height: 200px;
                    object-fit: cover;
                    border-radius: 8px;
                }
            </style>
        </head>

        <body>

            <div class="container mt-5 mb-5">
                <div class="row justify-content-center">
                    <div class="col-md-10">
                        <div class="d-flex justify-content-between mb-3">
                            <a href="${pageContext.request.contextPath}/organizer/dashboard"
                                class="btn btn-secondary">&larr; Back</a>
                            <a href="${pageContext.request.contextPath}/organizer/service/edit/${service.id}"
                                class="btn btn-warning">Edit Service</a>
                        </div>

                        <div class="card shadow">
                            <div class="card-header bg-info text-white">
                                <h3 class="mb-0">${service.serviceTitle}</h3>
                            </div>
                            <div class="card-body">
                                <div class="row mb-4">
                                    <div class="col-md-4">
                                        <h6 class="text-primary fw-bold">Basic Info</h6>
                                        <p><strong>Sport Type:</strong> ${service.sportType}</p>
                                        <p><strong>Status:</strong> <span
                                                class="badge bg-success">${service.status}</span></p>
                                        <p><strong>City:</strong> ${service.city}</p>
                                        <p><strong>Venue:</strong> ${service.venueName}</p>
                                    </div>
                                    <div class="col-md-4">
                                        <h6 class="text-primary fw-bold">Pricing & Capacity</h6>
                                        <p><strong>Price:</strong> Ã¢Â‚Â¹${service.basePrice} / ${service.pricingUnit}</p>
                                        <p><strong>Tax:</strong> ${service.taxPercent}%</p>
                                        <p><strong>Deposit:</strong> Ã¢Â‚Â¹${service.refundableDeposit}</p>
                                        <p><strong>Duration:</strong> ${service.durationInHours} Hours</p>
                                        <p><strong>Participants:</strong> Max ${service.maxParticipants}</p>
                                    </div>
                                    <div class="col-md-4">
                                        <h6 class="text-primary fw-bold">Availability</h6>
                                        <ul class="list-unstyled small">
                                            <li>${service.availableOnWeekdays ? 'Ã¢ÂœÂ…' : 'Ã¢ÂÂŒ'} Weekdays</li>
                                            <li>${service.availableOnWeekends ? 'Ã¢ÂœÂ…' : 'Ã¢ÂÂŒ'} Weekends</li>
                                            <li>Time: ${service.availableFrom} - ${service.availableTo}</li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="row mb-4">
                                    <div class="col-md-6">
                                        <h6 class="text-primary fw-bold">Inclusions</h6>
                                        <ul class="list-unstyled">
                                            <li>${service.refereeIncluded ? 'Ã¢ÂœÂ…' : 'Ã¢ÂÂŒ'} Referee</li>
                                            <li>${service.equipmentIncluded ? 'Ã¢ÂœÂ…' : 'Ã¢ÂÂŒ'} Equipment</li>
                                            <li>${service.groundIncluded ? 'Ã¢ÂœÂ…' : 'Ã¢ÂÂŒ'} Ground</li>
                                            <li>${service.medicalSupport ? 'Ã¢ÂœÂ…' : 'Ã¢ÂÂŒ'} Medical Support</li>
                                        </ul>
                                        <p><strong>Others:</strong> ${service.otherInclusions}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6 class="text-primary fw-bold">Customization</h6>
                                        <p><strong>Customizable:</strong> ${service.customizable ? 'Yes' : 'No'}</p>
                                        <p><strong>Options:</strong> ${service.customizationOptions}</p>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <h6 class="text-primary fw-bold">Location Details</h6>
                                    <p><strong>Address:</strong> ${service.venueAddress}</p>
                                    <c:if test="${not empty service.googleMapUrl}">
                                        <a href="${service.googleMapUrl}" target="_blank"
                                            class="btn btn-sm btn-outline-primary"><i class="fas fa-map-marker-alt"></i>
                                            View on Google Maps</a>
                                    </c:if>
                                </div>

                                <div class="mb-4">
                                    <h6 class="text-primary fw-bold">Rules & Requirements</h6>
                                    <p class="small"><strong>Description:</strong> ${service.description}</p>
                                    <p class="small"><strong>Rules:</strong> ${service.rulesAndGuidelines}</p>
                                    <p class="small"><strong>Client Req:</strong> ${service.requirementsFromClient}</p>
                                </div>

                                <div class="mb-4">
                                    <h5>Images</h5>
                                    <div class="row g-2">
                                        <c:if test="${not empty service.coverImageUrl}">
                                            <div class="col-md-3">
                                                <div class="card h-100">
                                                    <img src="${pageContext.request.contextPath}${service.coverImageUrl}"
                                                        class="img-preview" alt="Cover">
                                                    <div class="card-footer text-center small text-muted">Cover Image
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                        <c:forEach items="${service.galleryImageUrls}" var="img">
                                            <div class="col-md-3">
                                                <img src="${pageContext.request.contextPath}${img}"
                                                    class="img-preview w-100" alt="Gallery">
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>

                                <div class="row text-muted small mt-4">
                                    <div class="col-12">
                                        <strong>Service ID:</strong> ${service.id} | <strong>Updated At:</strong> Not
                                        Tracked
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        <script>
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
            // Absolute fallback for simple pages
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

