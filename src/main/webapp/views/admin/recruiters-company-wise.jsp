<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Recruiters Company-wise | JobU Admin</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-dark-light: #3d5256;
            --bg-light: #eef3f0;
            --card-bg: rgba(255, 255, 255, 0.98);
            --text-dark: #1e2a2e;
            --text-muted: #5b7c6e;
            --success: #10b981;
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

        .floating-shape {
            position: fixed;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            opacity: 0.03;
            pointer-events: none;
            z-index: 0;
            filter: blur(45px);
        }

        /* Page Header Premium */
        .page-header {
            background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .page-header h1 {
            font-size: 1.8rem;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 0.5rem;
            position: relative;
            z-index: 1;
        }

        .page-header p {
            font-size: 0.9rem;
            opacity: 0.85;
            position: relative;
            z-index: 1;
        }

        /* Search Section Premium */
        .search-section {
            background: var(--card-bg);
            backdrop-filter: blur(8px);
            border-radius: var(--radius-md);
            padding: 1.25rem;
            box-shadow: var(--shadow-md), 0 0 0 1px rgba(25,167,123,0.08);
            margin-bottom: 2rem;
            transition: var(--transition);
        }

        .search-input-group {
            position: relative;
        }

        .search-input-group i {
            position: absolute;
            left: 1.2rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
            font-size: 1rem;
            z-index: 2;
        }

        .search-input-group input {
            padding-left: 3rem;
            border-radius: 60px;
            border: 2px solid #e2ede7;
            font-size: 0.9rem;
            transition: var(--transition);
            background: white;
            height: 48px;
        }

        .search-input-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25, 167, 123, 0.12);
            outline: none;
        }

        /* Company Card */
        .company-card {
            background: var(--card-bg);
            border-radius: var(--radius-md);
            padding: 1.5rem;
            box-shadow: var(--shadow-sm), 0 0 0 1px rgba(25,167,123,0.06);
            margin-bottom: 1.5rem;
            transition: var(--transition);
        }

        .company-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-md), 0 0 0 1px rgba(25,167,123,0.12);
        }

        .company-title {
            font-size: 1.25rem;
            font-weight: 800;
            color: var(--bg-dark);
            border-bottom: 2px solid rgba(25,167,123,0.1);
            padding-bottom: 0.5rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .company-title i {
            color: var(--primary);
        }

        .recruiter-table {
            width: 100%;
            margin-bottom: 0;
        }

        .recruiter-table th {
            background-color: var(--bg-light);
            color: var(--text-dark);
            font-weight: 700;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 0.75rem 1rem;
            border: none;
        }

        .recruiter-table td {
            padding: 0.75rem 1rem;
            vertical-align: middle;
            font-size: 0.9rem;
            border-bottom: 1px solid #e2ede7;
        }

        .no-records {
            color: var(--text-muted);
            font-style: italic;
            font-size: 0.9rem;
            padding: 0.5rem 0;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--card-bg);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-md);
            display: none;
        }

        .empty-state.show {
            display: block;
        }

        .empty-state i {
            font-size: 4rem;
            background: linear-gradient(135deg, var(--primary), var(--accent));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>

<!-- Page Header -->
<div class="page-header">
    <div class="container">
        <a href="${pageContext.request.contextPath}/dashboard" style="display: inline-flex; align-items: center; gap: 0.5rem; color: white; text-decoration: none; font-size: 0.85rem; font-weight: 600; background: rgba(255,255,255,0.15); backdrop-filter: blur(8px); padding: 0.4rem 1rem; border-radius: 40px; margin-bottom: 0.75rem; transition: all 0.3s ease; border: 1px solid rgba(255,255,255,0.2);">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
        <h1><i class="fas fa-user-tie me-2" style="color: var(--accent);"></i>Recruiters Company-wise</h1>
        <p>List of all recruiters grouped by their respective companies</p>
    </div>
</div>

<div class="container">
    <!-- Search Section -->
    <div class="search-section">
        <div class="search-input-group">
            <i class="fas fa-search"></i>
            <input type="text" id="searchInput" class="form-control" placeholder="Search by company name or recruiter details...">
        </div>
    </div>
    
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${success}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Company wise listings -->
    <div id="companyList">
        <c:forEach var="company" items="${companies}">
            <c:set var="recruiters" value="${companyRecruitersMap[company.id]}" />
            <c:set var="recruiterSearchText" value="" />
            <c:forEach var="r" items="${recruiters}">
                <c:set var="recruiterSearchText" value="${recruiterSearchText} ${r.name} ${r.email}" />
            </c:forEach>
            <c:set var="searchText" value="${fn:toLowerCase(company.name)} ${fn:toLowerCase(recruiterSearchText)}" />

            <div class="company-card-item" data-search="${fn:escapeXml(searchText)}">
                <div class="company-card">
                    <div class="company-title">
                        <i class="fas fa-building"></i> ${company.name}
                        <div class="ms-auto d-flex align-items-center gap-2">
                            <span class="badge bg-success" style="font-size: 0.75rem;">${fn:length(recruiters)} Recruiter(s)</span>
                            <button type="button" class="btn btn-sm btn-outline-danger" title="Delete Company" onclick="openDeleteModal('company', ${company.id}, '${fn:escapeXml(company.name)}')">
                                <i class="fas fa-trash"></i>
                            </button>
                        </div>
                    </div>
                    
                    <c:choose>
                        <c:when test="${empty recruiters}">
                            <div class="no-records">
                                <i class="fas fa-info-circle me-1"></i> No recruiters registered under this company yet.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table recruiter-table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th class="text-end">Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="r" items="${recruiters}">
                                            <tr>
                                                <td>#${r.id}</td>
                                                <td><strong>${r.name}</strong></td>
                                                <td><a href="mailto:${r.email}" class="text-success text-decoration-none"><i class="fas fa-envelope me-1"></i>${r.email}</a></td>
                                                <td class="text-end">
                                                    <button type="button" class="btn btn-sm btn-outline-danger" title="Delete Recruiter" onclick="openDeleteModal('recruiter', ${r.id}, '${fn:escapeXml(r.name)}')">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="empty-state" id="emptyState">
        <i class="fas fa-search"></i>
        <h3>No Results Found</h3>
        <p>Try searching with a different term.</p>
    </div>
</div>

<!-- Delete Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <form id="deleteForm" method="post" action="">
        <div class="modal-header">
          <h5 class="modal-title" id="deleteModalLabel">Confirm Deletion</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <p>Are you sure you want to delete <strong id="deleteTargetName"></strong>?</p>
          <div class="mb-3">
            <label for="deleteReason" class="form-label">Reason for deletion <span class="text-danger">*</span></label>
            <textarea class="form-control" id="deleteReason" name="reason" rows="3" required></textarea>
            <div class="invalid-feedback">Please provide a reason.</div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          <button type="submit" class="btn btn-danger" id="confirmDeleteBtn" disabled>Delete</button>
        </div>
      </form>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function openDeleteModal(type, id, name) {
    const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
    document.getElementById('deleteTargetName').textContent = name;
    document.getElementById('deleteReason').value = '';
    document.getElementById('confirmDeleteBtn').disabled = true;
    
    const form = document.getElementById('deleteForm');
    if (type === 'company') {
        form.action = '${pageContext.request.contextPath}/admin/delete-company-recruiter-with-reason/' + id;
    } else if (type === 'recruiter') {
        form.action = '${pageContext.request.contextPath}/admin/delete-recruiter/' + id;
    }
    
    modal.show();
}

document.getElementById('deleteReason').addEventListener('input', function() {
    const btn = document.getElementById('confirmDeleteBtn');
    if (this.value.trim().length > 0) {
        btn.disabled = false;
    } else {
        btn.disabled = true;
    }
});

document.addEventListener('DOMContentLoaded', function() {
    const searchInput = document.getElementById('searchInput');
    const cards = document.querySelectorAll('.company-card-item');
    const emptyState = document.getElementById('emptyState');
    
    if (searchInput) {
        searchInput.addEventListener('keyup', function() {
            const filter = this.value.toLowerCase().trim();
            let visibleCount = 0;
            
            cards.forEach(function(card) {
                const searchText = card.getAttribute('data-search') || '';
                if (searchText.includes(filter)) {
                    card.style.display = '';
                    visibleCount++;
                } else {
                    card.style.display = 'none';
                }
            });
            
            if (emptyState) {
                if (visibleCount === 0) {
                    emptyState.classList.add('show');
                } else {
                    emptyState.classList.remove('show');
                }
            }
        });
    }
});
</script>

</body>
</html>
