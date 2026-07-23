<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>JobU | Edit Sports Service - Premium Management</title>
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

* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #e0ece6 100%);
    font-family: 'Inter', system-ui, -apple-system, sans-serif;
    color: var(--text-dark);
    min-height: 100vh;
    position: relative;
    overflow-x: hidden;
    padding: 2rem 0;
}

/* animated background */
body::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: radial-gradient(circle at 15% 30%, rgba(25,167,123,0.05) 0%, transparent 40%),
                radial-gradient(circle at 85% 70%, rgba(59,196,154,0.04) 0%, transparent 45%);
    pointer-events: none;
    z-index: 0;
    animation: meshFloat 18s ease-in-out infinite alternate;
}
@keyframes meshFloat {
    0% { opacity: 0.5; transform: scale(1); }
    100% { opacity: 1; transform: scale(1.03); }
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

.container {
    position: relative;
    z-index: 2;
}

/* Premium Card */
.premium-card {
    background: var(--card-bg);
    backdrop-filter: blur(8px);
    border-radius: var(--radius-lg);
    box-shadow: var(--shadow-lg), 0 0 0 1px rgba(25,167,123,0.08);
    transition: var(--transition);
    overflow: hidden;
    margin-bottom: 2rem;
}

.premium-card:hover {
    box-shadow: var(--shadow-xl), 0 0 0 1px rgba(25,167,123,0.15);
}

.card-header-premium {
    background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
    color: white;
    padding: 1.5rem 2rem;
    border-bottom: none;
}

.card-header-premium h2 {
    font-size: 1.8rem;
    font-weight: 700;
    margin: 0;
    letter-spacing: -0.3px;
}

.card-header-premium p {
    opacity: 0.85;
    margin-top: 0.5rem;
    margin-bottom: 0;
}

.card-body-premium {
    padding: 2rem;
}

/* Form Sections */
.form-section {
    background: rgba(25,167,123,0.02);
    border-radius: var(--radius-md);
    padding: 1.5rem;
    margin-bottom: 2rem;
    border: 1px solid rgba(25,167,123,0.1);
    transition: var(--transition);
}

.form-section:hover {
    border-color: rgba(25,167,123,0.25);
    box-shadow: var(--shadow-sm);
}

.section-title {
    font-size: 1.3rem;
    font-weight: 700;
    color: var(--bg-dark);
    margin-bottom: 1.5rem;
    padding-bottom: 0.75rem;
    border-bottom: 2px solid var(--primary);
    display: inline-block;
}

/* Form Controls */
.form-label {
    font-weight: 600;
    color: var(--text-dark);
    margin-bottom: 0.5rem;
    font-size: 0.85rem;
    letter-spacing: 0.3px;
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

/* Checkbox styling */
.custom-check {
    display: inline-flex;
    align-items: center;
    gap: 0.5rem;
    margin-right: 1.5rem;
    margin-bottom: 0.5rem;
    cursor: pointer;
    font-weight: 500;
}

.custom-check input {
    width: 18px;
    height: 18px;
    accent-color: var(--primary);
    cursor: pointer;
}

/* Image preview */
.image-preview {
    border-radius: var(--radius-sm);
    border: 2px solid #e2ede7;
    padding: 0.5rem;
    transition: var(--transition);
}

.image-preview:hover {
    border-color: var(--primary);
    transform: scale(1.02);
}

/* Buttons */
.btn-premium {
    background: linear-gradient(105deg, var(--primary), var(--primary-dark));
    color: white;
    border: none;
    padding: 0.85rem 2rem;
    border-radius: 50px;
    font-weight: 700;
    transition: var(--transition);
    box-shadow: 0 8px 20px -8px rgba(25,167,123,0.4);
}

.btn-premium:hover {
    transform: translateY(-3px);
    box-shadow: 0 15px 25px -10px rgba(25,167,123,0.5);
    color: white;
}

.btn-outline-premium {
    background: transparent;
    border: 2px solid var(--primary);
    color: var(--primary);
    padding: 0.7rem 1.5rem;
    border-radius: 50px;
    font-weight: 600;
    transition: var(--transition);
}

.btn-outline-premium:hover {
    background: var(--primary);
    color: white;
    transform: translateY(-2px);
}

.btn-secondary-custom {
    background: var(--bg-dark);
    color: white;
    border: none;
    padding: 0.85rem 2rem;
    border-radius: 50px;
    font-weight: 600;
    transition: var(--transition);
}

.btn-secondary-custom:hover {
    background: var(--bg-dark-light);
    transform: translateY(-2px);
    color: white;
}

/* Alert styling */
.alert-premium {
    border-radius: var(--radius-md);
    border-left: 4px solid var(--primary);
    background: rgba(25,167,123,0.08);
    border: none;
    border-left: 4px solid var(--primary);
}

/* Gallery image container */
.gallery-img-container {
    position: relative;
    display: inline-block;
}

.delete-image-btn {
    position: absolute;
    top: -8px;
    right: -8px;
    background: #ef4444;
    color: white;
    border-radius: 50%;
    width: 24px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: center;
    text-decoration: none;
    font-size: 12px;
    transition: var(--transition);
}

.delete-image-btn:hover {
    transform: scale(1.1);
    background: #dc2626;
}

/* Responsive */
@media (max-width: 768px) {
    body { padding: 1rem; }
    .card-header-premium { padding: 1rem 1.5rem; }
    .card-header-premium h2 { font-size: 1.4rem; }
    .card-body-premium { padding: 1.5rem; }
    .form-section { padding: 1rem; }
    .section-title { font-size: 1.1rem; }
}

@media (max-width: 576px) {
    .card-body-premium { padding: 1rem; }
    .btn-premium, .btn-secondary-custom { padding: 0.7rem 1.5rem; font-size: 0.85rem; }
}

::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: #e0ece6; }
::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
::selection { background: var(--primary); color: white; }
</style>
<jsp:include page="/views/commons/admin_shell_head.jsp" />
</head>
<body>

<jsp:include page="/views/commons/admin_shell_start.jsp">
  <jsp:param name="pageTitle" value="Edit Sports Service"/>
  <jsp:param name="pageSubtitle" value="Update service details"/>
  <jsp:param name="activeNav" value="sports-list"/>
</jsp:include>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>

<div class="container">
    <div class="premium-card">
        <div class="card-header-premium">
            <h2><i class="fas fa-dumbbell me-2" style="color: var(--accent);"></i>Edit Sports Service</h2>
            <p>Modify service details, pricing, media, and availability</p>
        </div>
        <div class="card-body-premium">
            
            <spring:hasBindErrors name="service">
                <div class="alert alert-premium alert-danger">
                    <i class="fas fa-exclamation-triangle me-2"></i>
                    <strong>Please correct the following errors:</strong>
                    <ul class="mb-0 mt-2">
                        <c:forEach var="error" items="${errors.allErrors}">
                            <li>${error.defaultMessage}</li>
                        </c:forEach>
                    </ul>
                </div>
            </spring:hasBindErrors>

            <form method="post" action="${pageContext.request.contextPath}/admin/sports/service/update" enctype="multipart/form-data">
                <input type="hidden" name="id" value="${service.id}"/>

                <!-- BASIC INFO SECTION -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-info-circle me-2" style="color: var(--primary);"></i>Basic Information</h5>
                    <div class="mb-3">
                        <label class="form-label">Service Title *</label>
                        <input name="serviceTitle" value="${service.serviceTitle}" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Sport Type *</label>
                        <select id="sportTypeSelect" name="sportType" class="form-select" onchange="toggleSportTypeOther()">
                            <option value="">-- Select --</option>
                            <option value="Cricket">Cricket</option>
                            <option value="Football">Football</option>
                            <option value="Badminton">Badminton</option>
                            <option value="Tennis">Tennis</option>
                            <option value="OTHER">Other</option>
                        </select>
                        <input type="text" id="customSportType" name="customSportType" class="form-control mt-2" placeholder="Enter custom sport type" style="display:none;">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-control" rows="4">${service.description}</textarea>
                    </div>
                </div>

                <!-- PRICING SECTION -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-tag me-2" style="color: var(--primary);"></i>Pricing & Fees</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3"><label class="form-label">Base Price</label><input name="basePrice" value="${service.basePrice}" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="form-label">Tax Percent</label><input name="taxPercent" value="${service.taxPercent}" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="form-label">Refundable Deposit</label><input name="refundableDeposit" value="${service.refundableDeposit}" class="form-control"></div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Pricing Unit</label>
                            <select name="pricingUnit" class="form-select">
                                <option value="PER_MATCH" ${service.pricingUnit=='PER_MATCH'?'selected':''}>Per Match</option>
                                <option value="PER_HOUR" ${service.pricingUnit=='PER_HOUR'?'selected':''}>Per Hour</option>
                                <option value="PER_DAY" ${service.pricingUnit=='PER_DAY'?'selected':''}>Per Day</option>
                                <option value="PER_PERSON" ${service.pricingUnit=='PER_PERSON'?'selected':''}>Per Person</option>
                            </select>
                        </div>
                        <div class="col-md-6 mb-3"><label class="form-label">Advance Payment %</label><input name="advancePaymentPercent" value="${service.advancePaymentPercent}" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="form-label">Min Booking Notice (hrs)</label><input name="minimumBookingNoticeHours" value="${service.minimumBookingNoticeHours}" class="form-control"></div>
                    </div>
                </div>

                <!-- CAPACITY SECTION -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-users me-2" style="color: var(--primary);"></i>Capacity & Requirements</h5>
                    <div class="row">
                        <div class="col-md-6 mb-3"><label class="form-label">Duration (hrs)</label><input name="durationInHours" value="${service.durationInHours}" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="form-label">Max Participants</label><input name="maxParticipants" value="${service.maxParticipants}" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="form-label">Team Size Min</label><input name="recommendedTeamSizeMin" value="${service.recommendedTeamSizeMin}" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="form-label">Team Size Max</label><input name="recommendedTeamSizeMax" value="${service.recommendedTeamSizeMax}" class="form-control"></div>
                        <div class="col-md-12 mb-3">
                            <label class="form-label">Experience Level</label>
                            <select name="experienceLevel" class="form-select">
                                <option value="">-- Select --</option>
                                <option value="BEGINNER" ${service.experienceLevel=='BEGINNER'?'selected':''}>Beginner</option>
                                <option value="INTERMEDIATE" ${service.experienceLevel=='INTERMEDIATE'?'selected':''}>Intermediate</option>
                                <option value="PROFESSIONAL" ${service.experienceLevel=='PROFESSIONAL'?'selected':''}>Professional</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- INCLUSIONS -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-check-circle me-2" style="color: var(--primary);"></i>Inclusions</h5>
                    <div>
                        <label class="custom-check"><input type="checkbox" name="refereeIncluded" ${service.refereeIncluded?'checked':''}> Referee</label>
                        <label class="custom-check"><input type="checkbox" name="equipmentIncluded" ${service.equipmentIncluded?'checked':''}> Equipment</label>
                        <label class="custom-check"><input type="checkbox" name="groundIncluded" ${service.groundIncluded?'checked':''}> Ground</label>
                        <label class="custom-check"><input type="checkbox" name="medicalSupport" ${service.medicalSupport?'checked':''}> Medical</label>
                    </div>
                    <div class="mt-3"><label class="form-label">Other Inclusions</label><textarea name="otherInclusions" class="form-control">${service.otherInclusions}</textarea></div>
                </div>

                <!-- LOCATION -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-map-marker-alt me-2" style="color: var(--primary);"></i>Location</h5>
                    <div class="mb-3"><input name="city" value="${service.city}" class="form-control" placeholder="City"></div>
                    <div class="mb-3"><input name="venueName" value="${service.venueName}" class="form-control" placeholder="Venue Name"></div>
                    <div class="mb-3"><textarea name="venueAddress" class="form-control" placeholder="Venue Address">${service.venueAddress}</textarea></div>
                    <div class="mb-3"><input name="googleMapUrl" value="${service.googleMapUrl}" class="form-control" placeholder="Google Map URL"></div>
                </div>

                <!-- MEDIA SECTION -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-image me-2" style="color: var(--primary);"></i>Media</h5>
                    <div class="mb-3">
                        <label class="form-label">Cover Image</label>
                        <c:if test="${not empty service.coverImageUrl}">
                            <div class="mb-2"><img src="${pageContext.request.contextPath}${service.coverImageUrl}" width="200" class="image-preview"></div>
                            <small class="text-muted">Current cover image. Upload a new one to replace it.</small>
                        </c:if>
                        <input type="file" name="coverImage" class="form-control mt-2" accept="image/*">
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Existing Gallery Images</label>
                        <c:if test="${not empty service.galleryImageUrls}">
                            <div class="d-flex flex-wrap gap-3">
                                <c:forEach var="img" items="${service.galleryImageUrls}">
                                    <div class="gallery-img-container">
                                        <img src="${pageContext.request.contextPath}${img}" width="120" class="image-preview">
                                        <a href="${pageContext.request.contextPath}/admin/sports/service/image/delete?serviceId=${service.id}&imageUrl=${img}" onclick="return confirm('Delete this image?')" class="delete-image-btn">�</a>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:if>
                        <c:if test="${empty service.galleryImageUrls}"><p class="text-muted">No gallery images uploaded yet.</p></c:if>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Add New Gallery Images</label>
                        <input type="file" id="galleryPicker" accept="image/*" style="display:none" onchange="handleGallerySelect(this)">
                        <button type="button" class="btn-outline-premium" onclick="document.getElementById('galleryPicker').click()"><i class="fas fa-plus me-2"></i>Add Image</button>
                        <div id="galleryPreview" class="d-flex flex-wrap gap-2 mt-3"></div>
                        <input type="file" name="galleryImages" id="finalGalleryInput" multiple style="display:none">
                    </div>
                </div>

                <!-- RULES & SAFETY -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-shield-alt me-2" style="color: var(--primary);"></i>Rules & Safety</h5>
                    <div class="mb-3"><label class="form-label">Rules & Guidelines</label><textarea name="rulesAndGuidelines" class="form-control">${service.rulesAndGuidelines}</textarea></div>
                    <div class="mb-3"><label class="form-label">Requirements from Client</label><textarea name="requirementsFromClient" class="form-control">${service.requirementsFromClient}</textarea></div>
                    <div class="mb-3"><label class="form-label">Terms & Conditions</label><textarea name="termsAndConditions" class="form-control">${service.termsAndConditions}</textarea></div>
                    <div class="mb-3"><label class="form-label">Liability Disclaimer</label><textarea name="liabilityDisclaimer" class="form-control">${service.liabilityDisclaimer}</textarea></div>
                    <div><label class="custom-check"><input type="checkbox" name="insuranceCovered" ${service.insuranceCovered?'checked':''}> Insurance Covered</label></div>
                    <div class="mt-3"><label class="form-label">Insurance Details</label><textarea name="insuranceDetails" class="form-control">${service.insuranceDetails}</textarea></div>
                    <div class="mt-3"><label class="form-label">Safety Standards Followed</label><textarea name="safetyStandardsFollowed" class="form-control">${service.safetyStandardsFollowed}</textarea></div>
                    <div class="mt-3"><label class="custom-check"><input type="checkbox" name="weatherBackupAvailable" ${service.weatherBackupAvailable?'checked':''}> Weather Backup Available</label></div>
                    <div><label class="custom-check"><input type="checkbox" name="backupVenueAvailable" ${service.backupVenueAvailable?'checked':''}> Backup Venue Available</label></div>
                </div>

                <!-- AVAILABILITY -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-calendar-alt me-2" style="color: var(--primary);"></i>Availability</h5>
                    <div class="mb-3">
                        <label class="custom-check"><input type="checkbox" name="availableOnWeekdays" ${service.availableOnWeekdays?'checked':''}> Available on Weekdays</label>
                        <label class="custom-check"><input type="checkbox" name="availableOnWeekends" ${service.availableOnWeekends?'checked':''}> Available on Weekends</label>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3"><label class="form-label">Available From</label><input type="time" name="availableFrom" value="${service.availableFrom}" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="form-label">Available To</label><input type="time" name="availableTo" value="${service.availableTo}" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="form-label">Max Bookings Per Day</label><input name="maxBookingsPerDay" value="${service.maxBookingsPerDay}" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="custom-check"><input type="checkbox" name="allowsMultipleTeams" ${service.allowsMultipleTeams?'checked':''}> Allows Multiple Teams</label></div>
                    </div>
                </div>

                <!-- ADMIN SETTINGS -->
                <div class="form-section">
                    <h5 class="section-title"><i class="fas fa-cog me-2" style="color: var(--primary);"></i>Admin Settings</h5>
                    <div class="mb-3"><label class="form-label">Internal Notes</label><textarea name="internalNotes" class="form-control">${service.internalNotes}</textarea></div>
                    <div class="row">
                        <div class="col-md-6 mb-3"><label class="form-label">Priority Score</label><input name="priorityScore" value="${service.priorityScore}" class="form-control"></div>
                        <div class="col-md-6 mb-3"><label class="custom-check"><input type="checkbox" name="featured" ${service.featured?'checked':''}> Featured Service</label></div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Status</label>
                            <select name="status" class="form-select">
                                <option ${service.status=='ACTIVE'?'selected':''}>ACTIVE</option>
                                <option ${service.status=='INACTIVE'?'selected':''}>INACTIVE</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- FORM ACTIONS -->
                <div class="d-flex gap-3 justify-content-end mt-4">
                    <a href="${pageContext.request.contextPath}/admin/sports/service/list" class="btn-secondary-custom"><i class="fas fa-times me-2"></i>Cancel</a>
                    <button type="submit" class="btn-premium"><i class="fas fa-save me-2"></i>Update Service</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
let galleryFiles = [];

function handleGallerySelect(input) {
    const file = input.files[0];
    if (!file) return;
    galleryFiles.push(file);
    const reader = new FileReader();
    reader.onload = function(e) {
        const img = document.createElement("img");
        img.src = e.target.result;
        img.style.width = "100px";
        img.style.borderRadius = "8px";
        img.style.border = "2px solid #e2ede7";
        img.style.padding = "4px";
        document.getElementById("galleryPreview").appendChild(img);
    };
    reader.readAsDataURL(file);
    input.value = "";
    syncFiles();
}

function syncFiles() {
    const dataTransfer = new DataTransfer();
    galleryFiles.forEach(f => dataTransfer.items.add(f));
    document.getElementById("finalGalleryInput").files = dataTransfer.files;
}

function toggleSportTypeOther() {
    const select = document.getElementById("sportTypeSelect");
    const customInput = document.getElementById("customSportType");
    if (select.value === "OTHER") {
        customInput.style.display = "block";
        customInput.required = true;
    } else {
        customInput.style.display = "none";
        customInput.required = false;
        customInput.value = "";
    }
}

(function initSportTypeEdit() {
    const savedValue = "${service.sportType}";
    const select = document.getElementById("sportTypeSelect");
    const options = Array.from(select.options).map(o => o.value);
    if (options.includes(savedValue)) {
        select.value = savedValue;
    } else {
        select.value = "OTHER";
        const customInput = document.getElementById("customSportType");
        customInput.style.display = "block";
        customInput.value = savedValue;
        customInput.required = true;
    }
})();

document.addEventListener('DOMContentLoaded', function() {
    // preserved mobile responsive script
    if (!document.getElementById('mobile-responsive-style')) {
        const style = document.createElement('style');
        style.id = 'mobile-responsive-style';
        style.innerHTML = `@media (max-width: 768px) { .sidebar, .nav-sidebar { transform: translateX(-100%); transition: transform 0.3s ease; position: fixed !important; z-index: 1001 !important; height: 100vh; } .sidebar.active, .nav-sidebar.active { transform: translateX(0); } .mobile-menu-btn { display: inline-block !important; } .mobile-overlay { display: none; position: fixed; top: 0; left: 0; right: 0; bottom: 0; background: rgba(0,0,0,0.5); z-index: 1000; } .mobile-overlay.active { display: block; } } .mobile-menu-btn { display: none; }`;
        document.head.appendChild(style);
    }
    const sidebar = document.querySelector('.sidebar') || document.querySelector('.nav-sidebar');
    if (sidebar) {
        const topBar = document.querySelector('.top-bar') || document.querySelector('.chat-header') || document.querySelector('.dashboard-header') || document.body;
        let heading = null;
        if (topBar && topBar !== document.body) heading = topBar.querySelector('h1') || topBar.querySelector('.chat-header-info') || topBar.querySelector('h2');
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
            document.body.addEventListener('touchend', e => { touchendX = e.changedTouches[0].screenX; if (touchendX < touchstartX - 50) closeSidebar(); if (touchendX > touchstartX + 50 && touchstartX < 30) openSidebar(); }, {passive: true});
            function openSidebar() { sidebar.classList.add('active'); overlay.classList.add('active'); document.body.style.overflow = 'hidden'; }
            function closeSidebar() { sidebar.classList.remove('active'); overlay.classList.remove('active'); document.body.style.overflow = ''; }
            toggleBtn.addEventListener('click', openSidebar);
            overlay.addEventListener('click', closeSidebar);
        }
    }
    const tables = document.querySelectorAll('table:not(.table-responsive)');
    tables.forEach(table => { const headers = Array.from(table.querySelectorAll('th')).map(th => th.innerText); const rows = Array.from(table.querySelectorAll('tbody tr')); rows.forEach(row => { Array.from(row.querySelectorAll('td')).forEach((td, index) => { if(headers[index]) td.setAttribute('data-label', headers[index]); }); }); });
});
</script>
<jsp:include page="/views/commons/admin_shell_end.jsp" />
</body>
</html>