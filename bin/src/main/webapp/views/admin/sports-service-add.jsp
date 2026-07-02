<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>Add Sports Service | JobU Admin - Premium Service Management</title>

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
}

.premium-card:hover {
    box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
}

/* HEADER STYLE CHANGED TO WHITE */
.card-header-premium {
    background: white;  /* changed from gradient green to white */
    padding: 1.5rem 2rem;
    border-bottom: 1px solid rgba(0,0,0,0.05); /* subtle border for separation */
}

.card-header-premium h4 {
    margin: 0;
    font-weight: 800;
    font-size: 1.5rem;
    letter-spacing: -0.3px;
    display: flex;
    align-items: center;
    gap: 0.75rem;
    color: var(--bg-dark); /* dark text for contrast on white */
}

.card-header-premium h4 i {
    color: var(--primary); /* keep icon green for accent */
    font-size: 1.8rem;
}

.card-header-premium p {
    margin: 0.5rem 0 0;
    opacity: 0.7; /* slightly muted for secondary text */
    font-size: 0.9rem;
    color: var(--text-dark);
}

.card-body-premium {
    padding: 2rem;
}

/* Section Headers */
.section-header {
    margin-top: 2rem;
    margin-bottom: 1.5rem;
    padding-bottom: 0.75rem;
    border-bottom: 2px solid rgba(25,167,123,0.15);
    display: flex;
    align-items: center;
    gap: 0.75rem;
}

.section-header i {
    color: var(--primary);
    font-size: 1.3rem;
}

.section-header h5 {
    margin: 0;
    font-weight: 700;
    font-size: 1.1rem;
    color: var(--bg-dark);
    letter-spacing: -0.2px;
}

/* Form Controls */
.form-label {
    font-size: 0.75rem;
    font-weight: 700;
    color: var(--text-muted);
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 0.5rem;
}

.form-control, .form-select {
    border: 2px solid #e2ede7;
    border-radius: var(--radius-sm);
    padding: 0.75rem 1rem;
    font-size: 0.9rem;
    transition: var(--transition);
    background: white;
}

.form-control:focus, .form-select:focus {
    border-color: var(--primary);
    box-shadow: 0 0 0 4px rgba(25,167,123,0.12);
    outline: none;
}

textarea.form-control {
    resize: vertical;
    min-height: 100px;
}

/* Checkbox Styling */
.form-check {
    margin-bottom: 0.75rem;
}

.form-check-input {
    width: 1.1rem;
    height: 1.1rem;
    cursor: pointer;
    accent-color: var(--primary);
    border-radius: 4px;
}

.form-check-label {
    font-size: 0.85rem;
    font-weight: 500;
    color: var(--text-dark);
    margin-left: 0.5rem;
    cursor: pointer;
}

/* Alert Styling */
.alert-premium {
    border-radius: var(--radius-md);
    border-left: 4px solid #dc3545;
    background: rgba(239,68,68,0.08);
    border: none;
    border-left: 4px solid #dc3545;
}

/* Buttons */
.btn-outline-premium {
    background: transparent;
    border: 2px solid var(--primary);
    color: var(--primary);
    padding: 0.6rem 1.2rem;
    border-radius: 50px;
    font-weight: 600;
    transition: var(--transition);
}

.btn-outline-premium:hover {
    background: var(--primary);
    color: white;
    transform: translateY(-2px);
}

.btn-success-premium {
    background: linear-gradient(105deg, var(--primary), var(--primary-dark));
    color: white;
    border: none;
    padding: 1rem 2rem;
    border-radius: 50px;
    font-weight: 700;
    font-size: 1rem;
    transition: var(--transition);
    width: 100%;
    margin-top: 1rem;
}

.btn-success-premium:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 30px -10px rgba(25,167,123,0.5);
}

/* Gallery Preview */
#galleryPreview img {
    width: 120px;
    height: 90px;
    object-fit: cover;
    border-radius: var(--radius-sm);
    border: 2px solid #e2ede7;
    transition: var(--transition);
}

#galleryPreview img:hover {
    transform: scale(1.05);
    border-color: var(--primary);
}

/* Responsive */
@media (max-width: 768px) {
    .card-body-premium { padding: 1.5rem; }
    .card-header-premium { padding: 1rem 1.5rem; }
    .section-header { margin-top: 1.5rem; }
}

@media (max-width: 576px) {
    .card-body-premium { padding: 1rem; }
}

/* Custom Scrollbar */
::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: #e0ece6; }
::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }

::selection { background: var(--primary); color: white; }
</style>

<script>
function toggleOther(selectId, inputId){
    const s = document.getElementById(selectId);
    const i = document.getElementById(inputId);
    if(s && i) {
        if(s.value === 'OTHER'){
            i.style.display = 'block'; 
            i.required = true;
        } else {
            i.style.display = 'none'; 
            i.required = false; 
            i.value = '';
        }
    }
}

let galleryFiles = [];

function handleGallerySelect(input) {
    const file = input.files[0];
    if (!file) return;
    galleryFiles.push(file);
    const reader = new FileReader();
    reader.onload = e => {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.style.width = "120px";
        img.style.border = "2px solid #e2ede7";
        img.style.borderRadius = "12px";
        img.style.padding = "4px";
        document.getElementById("galleryPreview").appendChild(img);
    };
    reader.readAsDataURL(file);
    input.value = "";
    syncFiles();
}

function syncFiles() {
    const dt = new DataTransfer();
    galleryFiles.forEach(f => dt.items.add(f));
    document.getElementById("finalGalleryInput").files = dt.files;
}
</script>

</head>
<body>

<!-- decorative floating elements -->
<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<div class="container">
<div class="premium-card">
<!-- HEADER NOW HAS WHITE BACKGROUND with dark text, icon remains green -->
<div class="card-header-premium">
    <h4><i class="fas fa-dumbbell"></i> Add Sports Service</h4>
    <p>Create a new sports service package with complete details</p>
</div>
<div class="card-body-premium">

    <spring:hasBindErrors name="service">
        <div class="alert alert-premium alert-danger">
            <strong><i class="fas fa-exclamation-triangle me-2"></i>Please correct the following errors:</strong>
            <ul class="mb-0 mt-2">
                <c:forEach var="error" items="${errors.allErrors}">
                    <li>${error.defaultMessage}</li>
                </c:forEach>
            </ul>
        </div>
    </spring:hasBindErrors>

<form action="${pageContext.request.contextPath}/admin/sports/service/add"
      method="post" enctype="multipart/form-data">

<!-- BASIC INFORMATION -->
<div class="section-header">
    <i class="fas fa-info-circle"></i>
    <h5>Basic Information</h5>
</div>

<label class="form-label">Service Title *</label>
<input id="serviceTitle" name="serviceTitle" class="form-control mb-3" required>

<label class="form-label">Sport Type *</label>
<select id="sportType" name="sportType" class="form-select mb-2"
        onchange="toggleOther('sportType','customSportType')">
    <option value="Cricket">Cricket</option>
    <option value="Football">Football</option>
    <option value="Badminton">Badminton</option>
    <option value="Tennis">Tennis</option>
    <option value="OTHER">Other</option>
</select>

<input id="customSportType" name="customSportType"
       class="form-control mb-3"
       placeholder="Enter custom sport type"
       style="display:none">

<label class="form-label">Description</label>
<textarea id="description" name="description" class="form-control mb-3"></textarea>

<!-- PRICING -->
<div class="section-header">
    <i class="fas fa-tag"></i>
    <h5>Pricing</h5>
</div>

<label class="form-label">Base Price *</label>
<input id="basePrice" name="basePrice" type="number" class="form-control mb-3" required>

<label class="form-label">Pricing Unit</label>
<select id="pricingUnit" name="pricingUnit" class="form-select mb-2">
    <option value="PER_MATCH">Per Match</option>
    <option value="PER_HOUR">Per Hour</option>
    <option value="PER_DAY">Per Day</option>
    <option value="PER_PERSON">Per Person</option>
</select>

<label class="form-label">Tax Percentage</label>
<input id="taxPercent" name="taxPercent" class="form-control mb-3">

<label class="form-label">Refundable Deposit</label>
<input id="refundableDeposit" name="refundableDeposit" class="form-control mb-3">

<label class="form-label">Advance Payment %</label>
<input id="advancePaymentPercent" name="advancePaymentPercent" class="form-control mb-3">

<label class="form-label">Minimum Booking Notice (Hours)</label>
<input id="minimumBookingNoticeHours" name="minimumBookingNoticeHours" class="form-control mb-3">

<!-- CAPACITY -->
<div class="section-header">
    <i class="fas fa-users"></i>
    <h5>Capacity & Experience</h5>
</div>

<label class="form-label">Duration (Hours)</label>
<input id="durationInHours" name="durationInHours" class="form-control mb-3">

<label class="form-label">Maximum Participants</label>
<input id="maxParticipants" name="maxParticipants" class="form-control mb-3">

<label class="form-label">Recommended Team Size (Min)</label>
<input id="recommendedTeamSizeMin" name="recommendedTeamSizeMin" class="form-control mb-3">

<label class="form-label">Recommended Team Size (Max)</label>
<input id="recommendedTeamSizeMax" name="recommendedTeamSizeMax" class="form-control mb-3">

<label class="form-label">Experience Level</label>
<select id="experienceLevel" name="experienceLevel" class="form-select mb-3">
    <option value="BEGINNER">Beginner</option>
    <option value="INTERMEDIATE">Intermediate</option>
    <option value="PROFESSIONAL">Professional</option>
</select>

<!-- INCLUSIONS -->
<div class="section-header">
    <i class="fas fa-check-circle"></i>
    <h5>Inclusions</h5>
</div>

<div class="form-check">
    <input type="checkbox" class="form-check-input" name="refereeIncluded" id="refereeIncluded">
    <label class="form-check-label" for="refereeIncluded">Referee Included</label>
</div>
<div class="form-check">
    <input type="checkbox" class="form-check-input" name="equipmentIncluded" id="equipmentIncluded">
    <label class="form-check-label" for="equipmentIncluded">Equipment Included</label>
</div>
<div class="form-check">
    <input type="checkbox" class="form-check-input" name="groundIncluded" id="groundIncluded">
    <label class="form-check-label" for="groundIncluded">Ground Included</label>
</div>
<div class="form-check mb-3">
    <input type="checkbox" class="form-check-input" name="medicalSupport" id="medicalSupport">
    <label class="form-check-label" for="medicalSupport">Medical Support</label>
</div>

<label class="form-label">Other Inclusions</label>
<input id="otherInclusions" name="otherInclusions" class="form-control mb-3">

<!-- CUSTOMIZATION -->
<div class="section-header">
    <i class="fas fa-sliders-h"></i>
    <h5>Customization</h5>
</div>

<div class="form-check mb-2">
    <input type="checkbox" class="form-check-input" name="customizable" id="customizable">
    <label class="form-check-label" for="customizable">Customizable Package</label>
</div>

<label class="form-label">Customization Options</label>
<textarea id="customizationOptions" name="customizationOptions" class="form-control mb-3"></textarea>

<!-- LOCATION -->
<div class="section-header">
    <i class="fas fa-map-marker-alt"></i>
    <h5>Location</h5>
</div>

<label class="form-label">City</label>
<input id="city" name="city" class="form-control mb-3">

<label class="form-label">Venue Name</label>
<input id="venueName" name="venueName" class="form-control mb-3">

<label class="form-label">Venue Address</label>
<input id="venueAddress" name="venueAddress" class="form-control mb-3">

<label class="form-label">Google Map URL</label>
<input id="googleMapUrl" name="googleMapUrl" class="form-control mb-3">

<!-- SAFETY & BACKUP -->
<div class="section-header">
    <i class="fas fa-shield-alt"></i>
    <h5>Safety & Backup</h5>
</div>

<div class="form-check">
    <input type="checkbox" class="form-check-input" name="insuranceCovered" id="insuranceCovered">
    <label class="form-check-label" for="insuranceCovered">Insurance Covered</label>
</div>

<label class="form-label">Insurance Details</label>
<textarea id="insuranceDetails" name="insuranceDetails" class="form-control mb-3"></textarea>

<label class="form-label">Safety Standards Followed</label>
<textarea id="safetyStandardsFollowed" name="safetyStandardsFollowed" class="form-control mb-3"></textarea>

<div class="form-check">
    <input type="checkbox" class="form-check-input" name="weatherBackupAvailable" id="weatherBackupAvailable">
    <label class="form-check-label" for="weatherBackupAvailable">Weather Backup Available</label>
</div>

<div class="form-check mb-3">
    <input type="checkbox" class="form-check-input" name="backupVenueAvailable" id="backupVenueAvailable">
    <label class="form-check-label" for="backupVenueAvailable">Backup Venue Available</label>
</div>

<!-- RULES & LEGAL -->
<div class="section-header">
    <i class="fas fa-gavel"></i>
    <h5>Rules & Legal</h5>
</div>

<label class="form-label">Rules & Guidelines</label>
<textarea id="rulesAndGuidelines" name="rulesAndGuidelines" class="form-control mb-3"></textarea>

<label class="form-label">Requirements From Client</label>
<textarea id="requirementsFromClient" name="requirementsFromClient" class="form-control mb-3"></textarea>

<label class="form-label">Terms & Conditions</label>
<textarea id="termsAndConditions" name="termsAndConditions" class="form-control mb-3"></textarea>

<label class="form-label">Liability Disclaimer</label>
<textarea id="liabilityDisclaimer" name="liabilityDisclaimer" class="form-control mb-3"></textarea>

<!-- ADMIN CONTROLS -->
<div class="section-header">
    <i class="fas fa-cog"></i>
    <h5>Admin Controls</h5>
</div>

<label class="form-label">Priority Score</label>
<input id="priorityScore" name="priorityScore" class="form-control mb-3">

<div class="form-check mb-3">
    <input type="checkbox" class="form-check-input" name="featured" id="featured">
    <label class="form-check-label" for="featured">Featured Service</label>
</div>

<label class="form-label">Internal Notes</label>
<textarea id="internalNotes" name="internalNotes" class="form-control mb-3"></textarea>

<!-- AVAILABILITY -->
<div class="section-header">
    <i class="fas fa-calendar-alt"></i>
    <h5>Availability</h5>
</div>

<div class="form-check">
    <input type="checkbox" class="form-check-input" name="availableOnWeekdays" id="availableOnWeekdays">
    <label class="form-check-label" for="availableOnWeekdays">Available on Weekdays</label>
</div>

<div class="form-check">
    <input type="checkbox" class="form-check-input" name="availableOnWeekends" id="availableOnWeekends">
    <label class="form-check-label" for="availableOnWeekends">Available on Weekends</label>
</div>

<label class="form-label">Available From</label>
<input id="availableFrom" type="time" name="availableFrom" class="form-control mb-3">

<label class="form-label">Available To</label>
<input id="availableTo" type="time" name="availableTo" class="form-control mb-3">

<label class="form-label">Max Bookings Per Day</label>
<input id="maxBookingsPerDay" name="maxBookingsPerDay" class="form-control mb-3">

<div class="form-check mb-3">
    <input type="checkbox" class="form-check-input" name="allowsMultipleTeams" id="allowsMultipleTeams">
    <label class="form-check-label" for="allowsMultipleTeams">Allows Multiple Teams</label>
</div>

<!-- MEDIA -->
<div class="section-header">
    <i class="fas fa-image"></i>
    <h5>Media</h5>
</div>

<label class="form-label">Cover Image *</label>
<input id="coverImage" type="file" name="coverImage" class="form-control mb-3" required>

<label class="form-label">Gallery Images</label>
<button type="button" class="btn-outline-premium mb-2" onclick="document.getElementById('galleryPicker').click()">
    <i class="fas fa-plus me-2"></i>Add Image
</button>

<input type="file" id="galleryPicker" accept="image/*" style="display:none" onchange="handleGallerySelect(this)">
<div id="galleryPreview" class="d-flex flex-wrap gap-2 mb-3"></div>
<input type="file" name="galleryImages" id="finalGalleryInput" multiple style="display:none">

<button class="btn-success-premium" type="submit">
    <i class="fas fa-save me-2"></i>Save Service
</button>

</form>
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