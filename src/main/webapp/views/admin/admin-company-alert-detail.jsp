<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>Admin Company Alert</title>
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
<style>
:root{
  --blue:#2042e3;
  --blue-dark:#081828;
  --bg:#f6f9fc;
  --card:#fff;
  --text:#081828;
  --muted:#7E8890;
  --danger:#dc2626;
  --border:#e6e8ec;
  --shadow:0 6px 18px rgba(35,38,45,.12);
}

*{box-sizing:border-box}

body{
  margin:0;
  background:var(--bg);
  font-family:Inter,system-ui;
  color:var(--text);
}

.wrapper{
  max-width:980px;
  margin:20px auto;
  padding:0 16px;
}

/* Header */
.topbar{
  display:flex;
  align-items:center;
  justify-content:space-between;
  margin-bottom:10px;
}

.back a{
  color:var(--blue);
  text-decoration:none;
  font-weight:600;
  font-size:14px;
}

/* Card */
.card{
  background:var(--card);
  border-radius:12px;
  box-shadow:var(--shadow);
  border:1px solid var(--border);
  padding:18px 20px;
}

/* Title row */
.title-row{
  display:flex;
  justify-content:space-between;
  align-items:flex-start;
  gap:12px;
}

.company{
  font-size:20px;
  font-weight:700;
  line-height:1.2;
}

.badge{
  font-size:11px;
  font-weight:700;
  padding:4px 8px;
  border-radius:6px;
  background:#eef2ff;
  color:var(--blue);
}

/* Meta */
.meta{
  margin-top:4px;
  font-size:13px;
  color:var(--muted);
}

/* Sections */
.section{
  margin-top:14px;
}

.label{
  font-size:12px;
  font-weight:700;
  color:var(--muted);
  margin-bottom:4px;
  text-transform:uppercase;
}

.value{
  font-size:14px;
  line-height:1.55;
}

/* Actions bar */
.actions{
  display:flex;
  align-items:center;
  justify-content:space-between;
  margin-top:14px;
  padding-top:10px;
  border-top:1px solid var(--border);
}

.delete-btn{
  background:transparent;
  color:var(--danger);
  border:1px solid var(--danger);
  padding:6px 10px;
  border-radius:6px;
  font-size:13px;
  font-weight:600;
  cursor:pointer;
}

.delete-btn:hover{
  background:rgba(220,38,38,.06);
}

/* Admin reply */
.reply-box{
  margin-top:14px;
}

.reply-box textarea{
  width:100%;
  resize:none;
  padding:10px 12px;
  border-radius:8px;
  border:1px solid var(--border);
  font-size:13px;
}

.reply-box button{
  margin-top:6px;
  background:var(--blue);
  color:#fff;
  border:none;
  padding:7px 14px;
  border-radius:6px;
  font-size:13px;
  font-weight:600;
  cursor:pointer;
}

.reply-box button:hover{
  background:var(--blue-dark);
}

/* Comments */
.thread{
  margin-top:16px;
  border-top:1px solid var(--border);
  padding-top:10px;
}

.comment{
  padding:8px 10px;
  border-radius:8px;
  margin-bottom:6px;
  font-size:13px;
  background:#f8fafc;
}

.comment.admin{
  background:#eef2ff;
  border-left:3px solid var(--blue);
}

.author{
  font-weight:700;
  font-size:12px;
  margin-bottom:2px;
}
.icon-delete{
  background:transparent;
  border:1px solid rgba(220,38,38,.35);
  color:#dc2626;
  padding:6px 8px;
  border-radius:6px;
  cursor:pointer;
  font-size:13px;
}

.icon-delete:hover{
  background:rgba(220,38,38,.06);
}

</style>
</head>
<body>
<div class="wrapper">
  <!-- Top -->
  <div class="topbar">
    <div class="back">
      <a href="${pageContext.request.contextPath}/admin/alerts">
        â† Back to Alerts
      </a>
    </div>
  </div>
  <!-- Card -->
  <div class="card">
    <!-- Title -->
 <div class="title-row">
  <div>
    <div class="company">${alert.companyName}</div>
    <div class="meta">Issue: ${alert.issueType}</div>
  </div>
  <!-- Top-right admin actions -->
  <div style="display:flex; align-items:center; gap:8px;">
    <span class="badge">USER REPORT</span>
    <form action="${pageContext.request.contextPath}/admin/alerts/${alert.id}/delete"
          method="post"
          onsubmit="return confirm('Delete this report permanently?');"
          style="margin:0;">
      <button class="icon-delete" title="Delete report">
        <i class="fa-solid fa-trash"></i>
      </button>
    </form>
  </div>
</div>
    <!-- Description -->
    <div class="section">
      <div class="label">Reported Description</div>
      <div class="value">${alert.reportReason}</div>
    </div>
    
    <!-- Actions -->
<%--     <div class="actions">
      <form action="${pageContext.request.contextPath}/admin/alerts/${alert.id}/delete"
            method="post"
            onsubmit="return confirm('Delete this report permanently?');">
        <button class="delete-btn">
          <i class="fa-solid fa-trash"></i> Delete
        </button>
      </form>
    </div> --%>

    <!-- Admin Reply -->
    <div class="reply-box">
      <div class="label">Admin Reply</div>
      <form action="${pageContext.request.contextPath}/admin/alerts/${alert.id}/comment"
            method="post">
        <textarea name="commentText" rows="3"
                  placeholder="Official admin response…" required></textarea>
        <button type="submit">Post Reply</button>
      </form>
    </div>

    <!-- Thread -->
    <div class="thread">
      <div class="label">Discussion</div>

      <c:forEach var="c" items="${comments}">
        <div class="comment ${c.adminComment ? 'admin' : ''}">
          <div class="author">
            <c:choose>
              <c:when test="${c.adminComment}">
                Jobu Admin
              </c:when>
              <c:otherwise>
                ${empty c.commenterName ? 'Anonymous' : c.commenterName}
              </c:otherwise>
            </c:choose>
          </div>
          <div>${c.commentText}</div>
        </div>
      </c:forEach>
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

