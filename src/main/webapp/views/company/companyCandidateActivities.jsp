<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>Company - Candidate Activities</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">

<style>
:root {
  --primary: #19A77B;
  --primary-dark: #148F69;
  --bg-dark: #2E3E41;
  --bg-light: #f0f7f4;
  --text-dark: #1e2a2e;
  --text-muted: #5b7c6e;
  --border: #e2ede7;
  --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
}

body {
  font-family: 'Inter', sans-serif;
  background-color: var(--bg-light);
  color: var(--text-dark);
}

.navbar-custom {
  background: linear-gradient(135deg, var(--bg-dark) 0%, #1f2e30 100%);
  padding: 0.875rem 0;
}
.navbar-brand-custom {
  color: white !important;
  font-weight: 800;
  font-size: 1.35rem;
  text-decoration: none;
}
.btn-back {
  background: rgba(255, 255, 255, 0.12);
  color: white;
  padding: 0.5rem 1.2rem;
  border-radius: 40px;
  text-decoration: none;
  font-weight: 600;
}
.btn-back:hover {
  background: white;
  color: var(--primary-dark);
}

.page-header {
  background: white;
  padding: 2rem 0;
  border-bottom: 1px solid var(--border);
  margin-bottom: 2rem;
}
.page-title {
  font-weight: 800;
  font-size: 1.8rem;
  color: var(--text-dark);
}

.stat-card {
  background: white;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--border);
  display: flex;
  align-items: center;
  transition: transform 0.2s;
}
.stat-card:hover {
  transform: translateY(-5px);
}
.stat-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5rem;
  margin-right: 1rem;
}
.stat-icon.blue { background: rgba(13, 110, 253, 0.1); color: #0d6efd; }
.stat-icon.green { background: rgba(25, 135, 84, 0.1); color: #148F69; }
.stat-icon.yellow { background: rgba(255, 193, 7, 0.1); color: #ffc107; }
.stat-icon.red { background: rgba(220, 53, 69, 0.1); color: #dc3545; }
.stat-icon.purple { background: rgba(111, 66, 193, 0.1); color: #6f42c1; }
.stat-icon.teal { background: rgba(32, 201, 151, 0.1); color: #3BC49A; }

.stat-details h3 {
  margin: 0;
  font-size: 1.5rem;
  font-weight: 800;
  color: var(--text-dark);
}
.stat-details p {
  margin: 0;
  font-size: 0.85rem;
  color: var(--text-muted);
  font-weight: 500;
}

.filter-card {
  background: white;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: var(--shadow-sm);
  margin-bottom: 2rem;
  border: 1px solid var(--border);
}

.table-custom {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: var(--shadow-sm);
  border: 1px solid var(--border);
}
.table-custom th {
  background-color: rgba(25,167,123,0.05);
  color: var(--text-dark);
  font-weight: 600;
  font-size: 0.85rem;
  text-transform: uppercase;
  border-bottom: 2px solid rgba(25,167,123,0.1);
  white-space: nowrap;
}
.table-custom td {
  vertical-align: middle;
  font-size: 0.9rem;
  color: var(--text-dark);
  border-bottom: 1px solid var(--border);
}

.table-row-clickable {
  cursor: pointer;
  transition: background-color 0.2s;
}
.table-row-clickable:hover {
  background-color: rgba(25, 167, 123, 0.05) !important;
}

.badge-type {
  padding: 6px 12px;
  border-radius: 30px;
  font-size: 0.75rem;
  font-weight: 700;
}
.badge-blue { background: rgba(13, 110, 253, 0.1); color: #0d6efd; }
.badge-green { background: rgba(25, 135, 84, 0.1); color: #148F69; }
.badge-yellow { background: rgba(255, 193, 7, 0.1); color: #ffc107; }
.badge-orange { background: rgba(253, 126, 20, 0.1); color: #fd7e14; }
.badge-red { background: rgba(220, 53, 69, 0.1); color: #dc3545; }

.candidate-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid var(--border);
}

.pagination-custom .page-link {
  color: var(--primary-dark);
  border: 1px solid var(--border);
  border-radius: 6px;
  margin: 0 4px;
}
.pagination-custom .page-item.active .page-link {
  background-color: var(--primary);
  border-color: var(--primary);
  color: white;
}

/* Modal styling */
.modal-header-custom {
  background-color: var(--bg-light);
  border-bottom: 1px solid var(--border);
}
.modal-title-custom {
  font-weight: 800;
  color: var(--text-dark);
}
.profile-section {
  background: rgba(25, 167, 123, 0.05);
  border-radius: 12px;
  padding: 1.5rem;
  margin-bottom: 1.5rem;
}
.modal-avatar {
  width: 80px;
  height: 80px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid white;
  box-shadow: var(--shadow-sm);
}
</style>
</head>
<body>

<nav class="navbar-custom">
  <div class="container-fluid px-4">
    <div class="d-flex justify-content-between align-items-center">
      <a href="${pageContext.request.contextPath}/company/dashboard" class="navbar-brand-custom">
        <i class="fas fa-building me-2"></i> Company Dashboard
      </a>
      <a href="${pageContext.request.contextPath}/company/dashboard" class="btn-back">
        <i class="fas fa-arrow-left me-2"></i> Back to Dashboard
      </a>
    </div>
  </div>
</nav>

<div class="page-header">
  <div class="container-fluid px-4">
    <h1 class="page-title"><i class="fas fa-users text-success me-2"></i> Candidate Activities</h1>
    <p class="text-muted mb-0">Track how candidates are interacting with your job postings.</p>
  </div>
</div>

<div class="container-fluid px-4 mb-5">

  <!-- Statistics Cards -->
  <div class="row g-4 mb-4">
    <div class="col-md-2 col-sm-4 col-6">
      <div class="stat-card">
        <div class="stat-icon blue"><i class="fas fa-eye"></i></div>
        <div class="stat-details">
          <h3>${stats.totalViews}</h3>
          <p>Total Views</p>
        </div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-6">
      <div class="stat-card">
        <div class="stat-icon green"><i class="fas fa-paper-plane"></i></div>
        <div class="stat-details">
          <h3>${stats.totalApplications}</h3>
          <p>Applications</p>
        </div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-6">
      <div class="stat-card">
        <div class="stat-icon yellow"><i class="fas fa-bookmark"></i></div>
        <div class="stat-details">
          <h3>${stats.totalSaved}</h3>
          <p>Saved Jobs</p>
        </div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-6">
      <div class="stat-card">
        <div class="stat-icon red"><i class="fas fa-times-circle"></i></div>
        <div class="stat-details">
          <h3>${stats.totalWithdrawn}</h3>
          <p>Withdrawn</p>
        </div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-6">
      <div class="stat-card">
        <div class="stat-icon purple"><i class="fas fa-calendar-day"></i></div>
        <div class="stat-details">
          <h3>${stats.todayActivities}</h3>
          <p>Today's Activity</p>
        </div>
      </div>
    </div>
    <div class="col-md-2 col-sm-4 col-6">
      <div class="stat-card">
        <div class="stat-icon teal"><i class="fas fa-calendar-week"></i></div>
        <div class="stat-details">
          <h3>${stats.thisWeekActivities}</h3>
          <p>This Week</p>
        </div>
      </div>
    </div>
  </div>

  <!-- Filter Card -->
  <div class="filter-card">
    <form action="${pageContext.request.contextPath}/company/candidate-activities" method="get" class="row g-3 align-items-end">
      <div class="col-md-2">
        <label class="form-label text-muted small fw-bold">Candidate Name</label>
        <input type="text" class="form-control" name="userName" value="${userName}">
      </div>
      <div class="col-md-2">
        <label class="form-label text-muted small fw-bold">Candidate Email</label>
        <input type="text" class="form-control" name="userEmail" value="${userEmail}">
      </div>
      <div class="col-md-2">
        <label class="form-label text-muted small fw-bold">Job Title</label>
        <input type="text" class="form-control" name="jobTitle" value="${jobTitle}">
      </div>
      <div class="col-md-2">
        <label class="form-label text-muted small fw-bold">Activity Type</label>
        <select class="form-select" name="activityType">
          <option value="">All</option>
          <c:forEach var="type" items="${activityTypes}">
            <option value="${type}" ${type == activityType ? 'selected' : ''}>${type}</option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-2">
        <label class="form-label text-muted small fw-bold">Application Status</label>
        <select class="form-select" name="applicationStatus">
          <option value="">All</option>
          <c:forEach var="status" items="${applicationStatuses}">
            <option value="${status}" ${status == applicationStatus ? 'selected' : ''}>${status}</option>
          </c:forEach>
        </select>
      </div>
      
      <div class="col-md-1">
        <label class="form-label text-muted small fw-bold">Start Date</label>
        <input type="date" class="form-control px-1" name="startDate" value="${startDate}">
      </div>
      <div class="col-md-1">
        <label class="form-label text-muted small fw-bold">End Date</label>
        <input type="date" class="form-control px-1" name="endDate" value="${endDate}">
      </div>
      <div class="col-md-12 d-flex justify-content-end mt-3">
        <a href="${pageContext.request.contextPath}/company/candidate-activities" class="btn btn-light me-2 border">Clear</a>
        <button type="submit" class="btn btn-success" style="background-color: var(--primary); border-color: var(--primary);">
          <i class="fas fa-filter me-2"></i> Apply Filters
        </button>
      </div>
    </form>
  </div>

  <!-- Activities Table -->
  <div class="table-responsive table-custom">
    <table class="table table-hover mb-0 align-middle">
      <thead>
        <tr>
          <th>Date & Time</th>
          <th>Candidate</th>
          <th>Job Title</th>
          <th>Activity</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty activities.content}">
            <tr>
              <td colspan="6" class="text-center py-5 text-muted">
                <i class="fas fa-inbox fa-3x mb-3 text-light"></i><br>
                No activities found matching your filters.
              </td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="item" items="${activities.content}">
              <c:set var="log" value="${item.activity}" />
              <tr class="table-row-clickable" onclick="openCandidateModal('${log.userId}', '${log.userName}', '${log.userEmail}', '${item.candidateProfilePicture}', '${item.jobTitle}', '${log.activityType}', '${log.description}')">
                <td>
                  <div class="fw-bold"><c:out value="${log.createdAt.toLocalDate()}" /></div>
                  <div class="text-muted small"><c:out value="${log.createdAt.toLocalTime()}" /></div>
                </td>
                <td>
                  <div class="d-flex align-items-center">
                    <c:choose>
                      <c:when test="${not empty item.candidateProfilePicture}">
                        <img src="${pageContext.request.contextPath}/uploads/${item.candidateProfilePicture}" class="candidate-avatar me-3" alt="Profile">
                      </c:when>
                      <c:otherwise>
                        <div class="candidate-avatar me-3 bg-secondary text-white d-flex align-items-center justify-content-center fw-bold">
                          ${not empty log.userName ? log.userName.substring(0,1).toUpperCase() : 'U'}
                        </div>
                      </c:otherwise>
                    </c:choose>
                    <div>
                      <div class="fw-bold text-dark"><c:out value="${log.userName != null ? log.userName : 'Unknown Candidate'}" /></div>
                      <div class="text-muted small"><c:out value="${log.userEmail != null ? log.userEmail : 'System'}" /></div>
                    </div>
                  </div>
                </td>
                <td>
                  <span class="fw-semibold"><c:out value="${item.jobTitle != null ? item.jobTitle : 'N/A'}" /></span>
                </td>
                <td>
                  <c:choose>
                    <c:when test="${log.activityType == 'VIEWED_JOB'}">
                      <span class="badge-type badge-blue"><i class="fas fa-eye me-1"></i> Viewed</span>
                    </c:when>
                    <c:when test="${log.activityType == 'APPLIED_TO_JOB'}">
                      <span class="badge-type badge-green"><i class="fas fa-check-circle me-1"></i> Applied</span>
                    </c:when>
                    <c:when test="${log.activityType == 'SAVED_JOB'}">
                      <span class="badge-type badge-yellow"><i class="fas fa-bookmark me-1"></i> Saved</span>
                    </c:when>
                    <c:when test="${log.activityType == 'REMOVED_SAVED_JOB'}">
                      <span class="badge-type badge-orange"><i class="fas fa-times me-1"></i> Removed</span>
                    </c:when>
                    <c:when test="${log.activityType == 'WITHDRAWN_APPLICATION'}">
                      <span class="badge-type badge-red"><i class="fas fa-ban me-1"></i> Withdrawn</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge-type badge-blue"><c:out value="${log.activityType}" /></span>
                    </c:otherwise>
                  </c:choose>
                  <div class="small text-muted mt-1"><c:out value="${log.description}" /></div>
                </td>
                <td>
                  <c:if test="${not empty item.applicationStatus}">
                    <span class="badge bg-secondary"><c:out value="${item.applicationStatus}" /></span>
                  </c:if>
                  <c:if test="${empty item.applicationStatus}">
                    <span class="text-muted small">-</span>
                  </c:if>
                </td>
                <td onclick="event.stopPropagation();">
                  <c:if test="${not empty item.resumePath}">
                    <a href="${pageContext.request.contextPath}/uploads/${item.resumePath}" target="_blank" class="btn btn-sm btn-outline-primary rounded-pill">
                      <i class="fas fa-file-pdf"></i> Resume
                    </a>
                  </c:if>
                  <button class="btn btn-sm btn-outline-success rounded-pill ms-1" onclick="openCandidateModal('${log.userId}', '${log.userName}', '${log.userEmail}', '${item.candidateProfilePicture}', '${item.jobTitle}', '${log.activityType}', '${log.description}')">
                    <i class="fas fa-user"></i> Profile
                  </button>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>

  <c:if test="${activities.totalPages > 1}">
    <nav class="mt-4">
      <ul class="pagination pagination-custom justify-content-center">
        <li class="page-item ${activities.first ? 'disabled' : ''}">
          <a class="page-link" href="?page=${activities.number - 1}&size=${activities.size}&userName=${userName}&userEmail=${userEmail}&jobTitle=${jobTitle}&activityType=${activityType}&applicationStatus=${applicationStatus}&startDate=${startDate}&endDate=${endDate}">Previous</a>
        </li>
        <li class="page-item active">
          <span class="page-link">Page ${activities.number + 1} of ${activities.totalPages}</span>
        </li>
        <li class="page-item ${activities.last ? 'disabled' : ''}">
          <a class="page-link" href="?page=${activities.number + 1}&size=${activities.size}&userName=${userName}&userEmail=${userEmail}&jobTitle=${jobTitle}&activityType=${activityType}&applicationStatus=${applicationStatus}&startDate=${startDate}&endDate=${endDate}">Next</a>
        </li>
      </ul>
    </nav>
  </c:if>
</div>

<!-- Candidate Details Modal -->
<div class="modal fade" id="candidateModal" tabindex="-1" aria-labelledby="candidateModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header modal-header-custom">
        <h5 class="modal-title modal-title-custom" id="candidateModalLabel">Candidate Details</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4">
        <!-- Basic Info Section -->
        <div class="profile-section d-flex align-items-center">
          <img id="modalProfilePic" src="" class="modal-avatar me-4" alt="Profile" style="display:none;">
          <div id="modalProfileInitials" class="modal-avatar me-4 bg-success text-white d-flex align-items-center justify-content-center fw-bold fs-2" style="display:none;"></div>
          <div>
            <h4 id="modalName" class="fw-bold mb-1"></h4>
            <p id="modalEmail" class="text-muted mb-1"><i class="fas fa-envelope me-2"></i></p>
            <p id="modalPhone" class="text-muted mb-0" style="display:none;"><i class="fas fa-phone me-2"></i><span></span></p>
          </div>
        </div>

        <div class="row">
          <div class="col-md-6 mb-3">
            <h6 class="fw-bold text-success border-bottom pb-2">Interaction Details</h6>
            <p class="mb-1"><span class="text-muted">Job:</span> <span id="modalJobTitle" class="fw-semibold"></span></p>
            <p class="mb-1"><span class="text-muted">Activity:</span> <span id="modalActivityType" class="badge bg-secondary ms-2"></span></p>
            <p class="mb-1"><span class="text-muted">Details:</span> <span id="modalActivityDesc"></span></p>
          </div>
          <div class="col-md-6 mb-3">
            <h6 class="fw-bold text-success border-bottom pb-2">Professional Info</h6>
            <div id="loadingDetails" class="text-center text-muted py-2">
              <div class="spinner-border spinner-border-sm text-success me-2" role="status"></div> Loading profile...
            </div>
            <div id="extendedDetails" style="display:none;">
              <p class="mb-1"><span class="text-muted">Experience:</span> <span id="modalExperience"></span></p>
              <p class="mb-1"><span class="text-muted">Education:</span> <span id="modalEducation"></span></p>
              <div class="mt-2">
                <span class="text-muted d-block mb-1">Skills:</span>
                <div id="modalSkills"></div>
              </div>
            </div>
          </div>
        </div>

      </div>
      <div class="modal-footer">
        <a id="modalResumeBtn" href="#" target="_blank" class="btn btn-outline-primary" style="display:none;">
          <i class="fas fa-file-pdf me-2"></i>View Full Resume
        </a>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function openCandidateModal(userId, name, email, pic, jobTitle, activityType, desc) {
  // Reset modal content
  document.getElementById('modalName').innerText = name || 'Unknown Candidate';
  document.getElementById('modalEmail').innerHTML = '<i class="fas fa-envelope me-2"></i>' + (email || 'N/A');
  document.getElementById('modalJobTitle').innerText = jobTitle || 'N/A';
  document.getElementById('modalActivityType').innerText = activityType;
  document.getElementById('modalActivityDesc').innerText = desc;
  
  // Set Profile Picture
  const picEl = document.getElementById('modalProfilePic');
  const initEl = document.getElementById('modalProfileInitials');
  if (pic && pic !== 'null' && pic !== '') {
    picEl.src = '${pageContext.request.contextPath}/uploads/' + pic;
    picEl.style.display = 'block';
    initEl.style.display = 'none';
  } else {
    picEl.style.display = 'none';
    initEl.innerText = name ? name.charAt(0).toUpperCase() : 'U';
    initEl.style.display = 'flex';
  }

  // Hide extended details initially
  document.getElementById('extendedDetails').style.display = 'none';
  document.getElementById('modalResumeBtn').style.display = 'none';
  document.getElementById('modalPhone').style.display = 'none';
  
  // Show Modal
  const modal = new bootstrap.Modal(document.getElementById('candidateModal'));
  modal.show();

  // Fetch candidate details via AJAX if userId is available
  if (userId && userId !== 'null') {
    document.getElementById('loadingDetails').style.display = 'block';
    
    fetch('${pageContext.request.contextPath}/company/api/candidate-details/' + userId)
      .then(response => {
        if (!response.ok) throw new Error('Network response was not ok');
        return response.json();
      })
      .then(data => {
        document.getElementById('loadingDetails').style.display = 'none';
        document.getElementById('extendedDetails').style.display = 'block';
        
        if(data.phone) {
          const phoneEl = document.getElementById('modalPhone');
          phoneEl.querySelector('span').innerText = data.phone;
          phoneEl.style.display = 'block';
        }
        
        document.getElementById('modalExperience').innerText = data.experience ? data.experience + ' years' : 'Not specified';
        document.getElementById('modalEducation').innerText = data.education || 'Not specified';
        
        // Render Skills
        const skillsContainer = document.getElementById('modalSkills');
        skillsContainer.innerHTML = '';
        if (data.skills && data.skills.length > 0) {
          data.skills.forEach(skill => {
            const span = document.createElement('span');
            span.className = 'badge bg-light text-dark border me-1 mb-1';
            span.innerText = skill;
            skillsContainer.appendChild(span);
          });
        } else {
          skillsContainer.innerHTML = '<span class="text-muted small">No skills listed</span>';
        }

        // Resume Button
        if (data.resumeUploaded) {
          const resumeBtn = document.getElementById('modalResumeBtn');
          resumeBtn.href = '${pageContext.request.contextPath}/uploads/' + data.resumeUploaded;
          resumeBtn.style.display = 'inline-block';
        }
      })
      .catch(error => {
        document.getElementById('loadingDetails').innerHTML = '<span class="text-danger"><i class="fas fa-exclamation-circle me-1"></i> Failed to load extended profile.</span>';
      });
  } else {
    document.getElementById('loadingDetails').style.display = 'none';
    document.getElementById('extendedDetails').innerHTML = '<span class="text-muted small">No extended profile available for this user.</span>';
    document.getElementById('extendedDetails').style.display = 'block';
  }
}
</script>
</body>
</html>
