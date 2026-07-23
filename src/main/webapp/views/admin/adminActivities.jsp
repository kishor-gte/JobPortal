<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>Admin - User Activities | Premium Dashboard</title>

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
  --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
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
  letter-spacing: 0.5px;
  border-bottom: 2px solid rgba(25,167,123,0.1);
}
.table-custom td {
  vertical-align: middle;
  font-size: 0.9rem;
  color: var(--text-dark);
  border-bottom: 1px solid var(--border);
}
.badge-role {
  padding: 5px 10px;
  border-radius: 20px;
  font-size: 0.75rem;
  font-weight: 600;
}
.role-admin { background: rgba(249, 115, 22, 0.15); color: #f97316; }
.role-jobseeker { background: rgba(99, 102, 241, 0.15); color: #6366f1; }
.role-recruiter { background: rgba(25, 167, 123, 0.15); color: #19A77B; }
.role-company { background: rgba(25, 167, 123, 0.15); color: #19A77B; }

.badge-type {
  padding: 5px 10px;
  border-radius: 6px;
  background: rgba(25, 167, 123, 0.1);
  color: var(--primary-dark);
  font-size: 0.75rem;
  font-weight: 600;
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
</style>
<jsp:include page="/views/commons/admin_shell_head.jsp" />
</head>
<body>

<jsp:include page="/views/commons/admin_shell_start.jsp">
  <jsp:param name="pageTitle" value="Activity Logs"/>
  <jsp:param name="pageSubtitle" value="Track user actions across the portal"/>
  <jsp:param name="activeNav" value="activities"/>
</jsp:include>

<div class="page-header">
  <div class="container">
    <h1 class="page-title"><i class="fas fa-history text-success me-2"></i> User Activities Log</h1>
    <p class="text-muted mb-0">Monitor platform activity, user actions, and system logs.</p>
  </div>
</div>

<div class="container mb-5">
  <!-- Filters -->
  <div class="filter-card">
    <form action="${pageContext.request.contextPath}/admin/activities" method="get" class="row g-3 align-items-end">
      <div class="col-md-2">
        <label class="form-label text-muted small fw-bold">User Name</label>
        <input type="text" class="form-control" name="userName" value="${userName}">
      </div>
      <div class="col-md-3">
        <label class="form-label text-muted small fw-bold">User Email</label>
        <input type="text" class="form-control" name="userEmail" value="${userEmail}">
      </div>
      <div class="col-md-2">
        <label class="form-label text-muted small fw-bold">Activity Type</label>
        <select class="form-select" name="activityType">
          <option value="">All Activities</option>
          <c:forEach var="type" items="${activityTypes}">
            <option value="${type}" ${type == activityType ? 'selected' : ''}>${type}</option>
          </c:forEach>
        </select>
      </div>
      <div class="col-md-2">
        <label class="form-label text-muted small fw-bold">Start Date</label>
        <input type="date" class="form-control" name="startDate" value="${startDate}">
      </div>
      <div class="col-md-2">
        <label class="form-label text-muted small fw-bold">End Date</label>
        <input type="date" class="form-control" name="endDate" value="${endDate}">
      </div>
      <div class="col-md-1">
        <button type="submit" class="btn btn-success w-100" style="background-color: var(--primary); border-color: var(--primary);">
          <i class="fas fa-search"></i>
        </button>
      </div>
    </form>
  </div>

  <!-- Activity Table -->
  <div class="table-responsive table-custom">
    <table class="table table-hover mb-0">
      <thead>
          <th>Date & Time</th>
          <th>User</th>
          <th>Role</th>
          <th>Activity Type</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty activities.content}">
            <tr>
              <td colspan="5" class="text-center py-4 text-muted">No activities found matching your criteria.</td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="log" items="${activities.content}">
              <tr>
                <td>
                  <div class="fw-bold"><c:out value="${log.createdAt.toLocalDate()}" /></div>
                  <div class="text-muted small"><c:out value="${log.createdAt.toLocalTime()}" /></div>
                </td>
                <td>
                  <div class="fw-bold text-dark"><c:out value="${log.userName != null ? log.userName : 'Unknown'}" /></div>
                  <div class="text-muted small"><c:out value="${log.userEmail != null ? log.userEmail : 'System'}" /></div>
                </td>
                <td>
                  <span class="badge-role 
                    <c:choose>
                      <c:when test="${log.role == 'ADMIN'}">role-admin</c:when>
                      <c:when test="${log.role == 'JOBSEEKER'}">role-jobseeker</c:when>
                      <c:when test="${log.role == 'RECRUITER'}">role-recruiter</c:when>
                      <c:when test="${log.role == 'COMPANY'}">role-company</c:when>
                      <c:otherwise>bg-secondary text-white</c:otherwise>
                    </c:choose>">
                    <c:out value="${log.role != null ? log.role : 'GUEST'}" />
                  </span>
                </td>
                <td>
                  <span class="badge-type"><c:out value="${log.activityType}" /></span>
                </td>
                <td><c:out value="${log.description}" /></td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>

  <!-- Pagination -->
  <c:if test="${activities.totalPages > 1}">
    <nav class="mt-4">
      <ul class="pagination pagination-custom justify-content-center">
        <li class="page-item ${activities.first ? 'disabled' : ''}">
          <a class="page-link" href="?page=${activities.number - 1}&size=${activities.size}&userName=${userName}&userEmail=${userEmail}&activityType=${activityType}&startDate=${startDate}&endDate=${endDate}">Previous</a>
        </li>
        <li class="page-item active">
          <span class="page-link">Page ${activities.number + 1} of ${activities.totalPages}</span>
        </li>
        <li class="page-item ${activities.last ? 'disabled' : ''}">
          <a class="page-link" href="?page=${activities.number + 1}&size=${activities.size}&userName=${userName}&userEmail=${userEmail}&activityType=${activityType}&startDate=${startDate}&endDate=${endDate}">Next</a>
        </li>
      </ul>
    </nav>
  </c:if>

</div>

<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<jsp:include page="/views/commons/admin_shell_end.jsp" />
</body>
</html>
