<%@ page session="false" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
    <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>Add Sports Service</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <style>
                body {
                    background-color: #f8f9fa;
                }
            </style>
        </head>

        <body>

            <div class="container mt-5">
                <div class="row justify-content-center">
                    <div class="col-md-10">
                        <div class="card shadow">
                            <div class="card-header bg-primary text-white">
                                <h3 class="mb-0">Add New Service</h3>
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/organizer/service/add" method="post"
                                    enctype="multipart/form-data">

                                    <h5 class="text-primary mb-3">Basic Information</h5>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label">Service Title</label>
                                            <input type="text" name="serviceTitle" class="form-control" required
                                                placeholder="e.g. Weekend Cricket League">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Sport Type</label>
                                            <select name="sportType" class="form-select">
                                                <option value="Cricket">Cricket</option>
                                                <option value="Football">Football</option>
                                                <option value="Badminton">Badminton</option>
                                                <option value="Tennis">Tennis</option>
                                                <option value="Other">Other</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Description</label>
                                        <textarea name="description" class="form-control" rows="3"></textarea>
                                    </div>

                                    <h5 class="text-primary mt-4 mb-3">Pricing & Deposit</h5>
                                    <div class="row mb-3">
                                        <div class="col-md-3">
                                            <label class="form-label">Base Price (Ã¢Â‚Â¹)</label>
                                            <input type="number" step="0.01" name="basePrice" class="form-control"
                                                required>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">Pricing Unit</label>
                                            <select name="pricingUnit" class="form-select">
                                                <option value="PER_MATCH">Per Match</option>
                                                <option value="PER_HOUR">Per Hour</option>
                                                <option value="PER_DAY">Per Day</option>
                                                <option value="PER_PERSON">Per Person</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">Tax %</label>
                                            <input type="number" step="0.1" name="taxPercent" class="form-control"
                                                value="0">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">Refundable Deposit (Ã¢Â‚Â¹)</label>
                                            <input type="number" step="0.01" name="refundableDeposit"
                                                class="form-control" value="0">
                                        </div>
                                    </div>

                                    <h5 class="text-primary mt-4 mb-3">Capacity & Availability</h5>
                                    <div class="row mb-3">
                                        <div class="col-md-3">
                                            <label class="form-label">Duration (Hours)</label>
                                            <input type="number" name="durationInHours" class="form-control" value="1">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">Max Participants</label>
                                            <input type="number" name="maxParticipants" class="form-control" value="22">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">Available From</label>
                                            <input type="time" name="availableFrom" class="form-control">
                                        </div>
                                        <div class="col-md-3">
                                            <label class="form-label">Available To</label>
                                            <input type="time" name="availableTo" class="form-control">
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox"
                                                    name="availableOnWeekdays" checked>
                                                <label class="form-check-label">Available on Weekdays</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox"
                                                    name="availableOnWeekends" checked>
                                                <label class="form-check-label">Available on Weekends</label>
                                            </div>
                                        </div>
                                    </div>

                                    <h5 class="text-primary mt-4 mb-3">Inclusions & Customization</h5>
                                    <div class="row mb-3">
                                        <div class="col-md-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="refereeIncluded">
                                                <label class="form-check-label">Referee Included</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox"
                                                    name="equipmentIncluded">
                                                <label class="form-check-label">Equipment</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="groundIncluded">
                                                <label class="form-check-label">Ground</label>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" name="medicalSupport">
                                                <label class="form-check-label">Medical Support</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Other Inclusions</label>
                                        <input type="text" name="otherInclusions" class="form-control"
                                            placeholder="e.g. Refreshments, Floodlights">
                                    </div>
                                    <div class="mb-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="customizable">
                                            <label class="form-check-label fw-bold">Customizable Package?</label>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Customization Options</label>
                                        <textarea name="customizationOptions" class="form-control" rows="2"
                                            placeholder="e.g. Team Jerseys, Trophies"></textarea>
                                    </div>

                                    <h5 class="text-primary mt-4 mb-3">Rules & Requirements</h5>
                                    <div class="mb-3">
                                        <label class="form-label">Rules and Guidelines</label>
                                        <textarea name="rulesAndGuidelines" class="form-control" rows="3"
                                            placeholder="e.g. No spiked shoes allowed"></textarea>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Requirements from Client</label>
                                        <textarea name="requirementsFromClient" class="form-control" rows="2"
                                            placeholder="e.g. List of players, ID proof"></textarea>
                                    </div>

                                    <h5 class="text-primary mt-4 mb-3">Location & Media</h5>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label class="form-label">City</label>
                                            <input type="text" name="city" class="form-control">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Venue Name</label>
                                            <input type="text" name="venueName" class="form-control">
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Venue Address</label>
                                        <input type="text" name="venueAddress" class="form-control">
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Google Maps URL</label>
                                        <input type="url" name="googleMapUrl" class="form-control">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Cover Image</label>
                                        <input type="file" name="coverImage" class="form-control" accept="image/*"
                                            required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Gallery Images (Multiple)</label>
                                        <input type="file" name="galleryImages" class="form-control" accept="image/*"
                                            multiple>
                                    </div>
                                    
                                    

                                    <div class="mt-4 text-end">
                                        <a href="${pageContext.request.contextPath}/organizer/dashboard"
                                            class="btn btn-secondary me-2">Cancel</a>
                                        <button type="submit" class="btn btn-success">Save Service</button>
                                    </div>
                                </form>
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

