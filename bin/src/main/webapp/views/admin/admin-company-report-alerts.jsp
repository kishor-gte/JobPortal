<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Admin – Company Alerts</title>

  <!-- Fonts & icons -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

  <style>
    :root{
      --bg:#f6f9fc;
      --card-bg:#ffffff;
      --muted:#6b7280;
      --primary:#2042e3;
      --accent:#6c5ce7;
      --radius:14px;
      --shadow: 0 10px 30px rgba(12, 38, 63, 0.08);
      --gap:18px;
      --max-width:1200px;
      --glass: rgba(255,255,255,0.6);
    }

    *{box-sizing:border-box}
    html,body{height:100%}
    body{
      margin:0;
      font-family: "Inter", system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial;
      background:
        radial-gradient(1000px 400px at -10% -10%, rgba(32,66,227,0.06), transparent 10%),
        linear-gradient(180deg, #f8fbff 0%, var(--bg) 100%);
      color:#08122a;
      -webkit-font-smoothing:antialiased;
      -moz-osx-font-smoothing:grayscale;
      padding:28px;
      display:flex;
      justify-content:center;
    }

    .wrap{
      width:100%;
      max-width:var(--max-width);
    }

    header{
      display:flex;
      flex-wrap:wrap;
      align-items:center;
      justify-content:space-between;
      gap:12px;
      margin-bottom:18px;
    }
    .title{
      display:flex;
      align-items:center;
      gap:12px;
    }
    .title h1{
      margin:0;
      font-size:20px;
      font-weight:700;
      display:flex;
      gap:10px;
      align-items:center;
    }
    .title p{
      margin:0;
      font-size:13px;
      color:var(--muted);
    }

    .controls{
      display:flex;
      gap:10px;
      align-items:center;
      flex-wrap:wrap;
    }

    .control {
      display:inline-flex;
      align-items:center;
      gap:8px;
      background:var(--card-bg);
      padding:8px 10px;
      border-radius:10px;
      box-shadow:0 6px 18px rgba(12,38,63,0.05);
      border:1px solid rgba(15,23,42,0.04);
      font-size:14px;
    }
    .search{
      min-width:220px;
    }
    .search input{
      border:0;
      outline:0;
      font-size:14px;
      background:transparent;
      width:220px;
    }
    select{border:0;background:transparent;font-size:14px;outline:0}

    .summary{
      font-size:13px;
      color:var(--muted);
      display:flex;
      gap:12px;
      align-items:center;
      margin-top:6px;
    }

    /* Grid/list */
    .list{
      display:grid;
      grid-template-columns: 1fr;
      gap:var(--gap);
      margin-top:16px;
    }
    @media (min-width:980px){
      .list{grid-template-columns: 1fr 1fr}
    }

    /* Card */
    .card{
      position:relative;
      display:flex;
      gap:14px;
      padding:18px;
      border-radius:var(--radius);
      background:linear-gradient(180deg, rgba(255,255,255,0.9), var(--card-bg));
      box-shadow:var(--shadow);
      border:1px solid rgba(15,23,42,0.04);
      transition:transform .14s ease, box-shadow .14s ease;
      cursor:pointer;
      align-items:flex-start;
      overflow:hidden;
      min-height:130px;
    }
    .card:hover{ transform: translateY(-6px); box-shadow: 0 22px 40px rgba(12,38,63,0.12); }

    .card:focus-visible{ outline: 3px solid rgba(32,66,227,0.12); outline-offset:2px; }

    /* Left avatar */
    .logo{
      width:64px;
      height:64px;
      border-radius:12px;
      flex-shrink:0;
      display:flex;
      align-items:center;
      justify-content:center;
      font-weight:700;
      color:var(--primary);
      font-size:20px;
      background: linear-gradient(135deg, rgba(101,116,240,0.12), rgba(32,66,227,0.06));
      border:1px solid rgba(32,66,227,0.06);
    }

    .meta{
      flex:1;
      display:flex;
      flex-direction:column;
      gap:8px;
    }

    .top{
      display:flex;
      justify-content:space-between;
      gap:12px;
      align-items:flex-start;
    }

    .company{
      font-size:16px;
      font-weight:700;
      color:#08122a;
      display:flex;
      gap:8px;
      align-items:center;
    }

    .issue-type{
      display:inline-flex;
      align-items:center;
      gap:8px;
      padding:6px 10px;
      border-radius:999px;
      font-size:12px;
      font-weight:700;
      color:white;
      background:linear-gradient(90deg,#ff7a7a,#ff5ea2);
      text-transform:capitalize;
      box-shadow: 0 6px 18px rgba(255,94,162,0.08);
    }

    /* tag color variations (by data-type attribute) */
    .issue-type[data-type="fraud"]{ background: linear-gradient(90deg,#ff7a7a,#ff5e3a); }
    .issue-type[data-type="spam"]{ background: linear-gradient(90deg,#ffb86b,#ff6b6b); }
    .issue-type[data-type="misconduct"]{ background: linear-gradient(90deg,#7ee7c9,#2dd4bf); }
    .issue-type[data-type="others"]{ background: linear-gradient(90deg,#a78bfa,#6c5ce7); }

    .badge{
      display:inline-flex;
      gap:8px;
      align-items:center;
      padding:6px 10px;
      background:linear-gradient(90deg,#2042e3,#132bb8);
      color:white;
      font-weight:700;
      border-radius:999px;
      font-size:13px;
      box-shadow:0 8px 18px rgba(19,43,184,0.08);
    }

    .issue{
      color:var(--muted);
      font-weight:600;
      font-size:13px;
    }

    .description{
      margin:0;
      color:#24324a;
      font-size:14px;
      line-height:1.5;
      /* clamp to 3 lines */
      display:-webkit-box;
      -webkit-line-clamp:3;
      -webkit-box-orient:vertical;
      overflow:hidden;
      text-overflow:ellipsis;
      transition:max-height .18s ease;
      max-height:4.5em;
    }
    .description.expanded{
      -webkit-line-clamp:unset;
      max-height:1000px;
    }

    .foot{
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
      margin-top:8px;
      color:var(--muted);
      font-size:13px;
    }

    .cta{
      display:inline-flex;
      gap:8px;
      align-items:center;
      color:var(--primary);
      font-weight:700;
      text-decoration:none;
      background:transparent;
      border:0;
      cursor:pointer;
    }

    .readmore{
      background:rgba(32,66,227,0.06);
      color:var(--primary);
      border-radius:8px;
      padding:6px 8px;
      font-weight:700;
      font-size:13px;
      border:1px solid rgba(32,66,227,0.06);
      cursor:pointer;
    }

    /* small meta column on right for compact info */
    .meta-right{
      min-width:120px;
      display:flex;
      flex-direction:column;
      gap:8px;
      align-items:flex-end;
    }
    .meta-right .small{ color:var(--muted); font-size:13px; }

    /* empty state */
    .empty{
      text-align:center;
      padding:40px;
      color:var(--muted);
      border-radius:12px;
      background:linear-gradient(180deg, rgba(255,255,255,0.6), rgba(255,255,255,0.4));
      border:1px dashed rgba(15,23,42,0.04);
    }
  </style>
</head>
<body>
  <div class="wrap">
    <header>
      <div class="title">
        <h1><i class="fa-solid fa-shield"></i> Admin – Company Alerts</h1>
        <div class="summary">
          <span class="control">Total alerts: <strong style="margin-left:6px">${fn:length(alerts)}</strong></span>
          <span class="control">Admins view</span>
        </div>
      </div>

      <div class="controls" aria-hidden="false">
        <div class="control search" title="Search alerts">
          <i class="fa-solid fa-magnifying-glass" style="color:var(--muted)"></i>
          <input id="search" placeholder="Search company, reporter, issue..." aria-label="Search alerts" />
        </div>

        <div class="control">
          <select id="filter-type" aria-label="Filter by issue type">
            <option value="">All issues</option>
            <!-- Options will be populated by JS by scanning cards -->
          </select>
        </div>

        <div class="control">
          <select id="sort-by" aria-label="Sort alerts">
            <option value="recent">Sort: Recent</option>
            <option value="reports-desc">Sort: Most reports</option>
            <option value="reports-asc">Sort: Fewest reports</option>
            <option value="company-asc">Sort: Company AÃ¢â€ â€™Z</option>
          </select>
        </div>
      </div>
    </header>

    <main>
      <div id="list" class="list" aria-live="polite">
        <c:forEach var="a" items="${alerts}">
          <article class="card"
                   role="button"
                   tabindex="0"
                   aria-label="Open details for ${a.companyName} alert"
                   data-url="${pageContext.request.contextPath}/admin/alerts/${a.id}"
                   data-company="${fn:toLowerCase(a.companyName)}"
                   data-reporter="${fn:toLowerCase(a.reporterName)}"
                   data-issue="${fn:toLowerCase(a.issueType)}"
                   data-reports="${a.agreeCount}">
            <div class="logo" aria-hidden="true">
              <c:out value="${fn:substring(a.companyName,0,2)}"/>
            </div>

            <div class="meta">
              <div class="top">
                <div>
                  <div class="company">${a.companyName}</div>
                  <div class="issue">${a.issueType}</div>
                </div>

                <div class="meta-right">
                  <div class="badge" title="Number of reports"><i class="fa-solid fa-flag"></i>&nbsp;<span class="reports-count">${a.agreeCount}</span></div>
                  <div class="small">${a.reporterName}</div>
                </div>
              </div>

              <p class="description" id="desc-${a.id}">
                ${a.reportReason}
              </p>

              <div class="foot">
              <%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>

<%
    Object obj = pageContext.getAttribute("a");
    String formatted = "N/A";

    if (obj != null) {
        in.sp.main.Entities.CompanyAlert alert =
                (in.sp.main.Entities.CompanyAlert) obj;

        LocalDateTime dt = alert.getReportedAt();
        if (dt != null) {
            DateTimeFormatter formatter =
                DateTimeFormatter.ofPattern("dd MMM yyyy, hh:mm a");
            formatted = dt.format(formatter);
        }
    }
%>

<div class="small">
    Reported:
    <strong style="color:#0f172a"><%= formatted %></strong>
</div>


                <div style="display:flex;gap:8px;align-items:center">
                  <%-- <button class="readmore" data-target="desc-${a.id}" type="button">Read more</button> --%>
                  <a class="cta" href="${pageContext.request.contextPath}/admin/alerts/${a.id}" onclick="event.stopPropagation();">
                    View More Details <span style="margin-left:6px">Ã¢â€ â€™</span>
                  </a>
                </div>
              </div>
            </div>
          </article>
        </c:forEach>
      </div>

      <c:if test="${empty alerts}">
        <div class="empty">No alerts found.</div>
      </c:if>
    </main>
  </div>

  <script>
    (function(){
      const listEl = document.getElementById('list');
      const cards = Array.from(listEl.querySelectorAll('.card'));
      const search = document.getElementById('search');
      const filterType = document.getElementById('filter-type');
      const sortBy = document.getElementById('sort-by');

      // Populate filter options with unique issue types
      const types = new Set();
      cards.forEach(c => types.add(c.dataset.issue));
      const sortedTypes = Array.from(types).filter(Boolean).sort();
      sortedTypes.forEach(t => {
        const opt = document.createElement('option');
        opt.value = t;
        opt.textContent = t.charAt(0).toUpperCase() + t.slice(1);
        filterType.appendChild(opt);
      });

      // Read more toggle
      listEl.addEventListener('click', (e) => {
        const rm = e.target.closest('.readmore');
        if (rm) {
          e.stopPropagation();
          const id = rm.dataset.target;
          const p = document.getElementById(id);
          p.classList.toggle('expanded');
          rm.textContent = p.classList.contains('expanded') ? 'Show less' : 'Read more';
          return;
        }

        // Card click navigation
        const card = e.target.closest('.card');
        if (card) {
          const url = card.dataset.url;
          if (url) window.location.href = url;
        }
      });

      // keyboard activation for cards
      listEl.addEventListener('keydown', (e) => {
        const card = e.target.closest && e.target.closest('.card');
        if (!card) return;
        if (e.key === 'Enter' || e.key === ' ') {
          e.preventDefault();
          window.location.href = card.dataset.url;
        }
      });

      // Stop navigation when clicking controls inside card (links/buttons)
      const innerInteractive = listEl.querySelectorAll('a, button');
      innerInteractive.forEach(el => {
        el.addEventListener('click', (ev) => ev.stopPropagation());
      });

      // Filtering + Searching + Sorting
      function applyFilters(){
        const q = (search.value || '').trim().toLowerCase();
        const type = filterType.value;
        let visible = cards.filter(c => {
          if (type && c.dataset.issue !== type) return false;
          if (!q) return true;
          return c.dataset.company.includes(q) || c.dataset.reporter.includes(q) || c.dataset.issue.includes(q);
        });

        // Apply sorting
        const mode = sortBy.value;
        if (mode === 'reports-desc') {
          visible.sort((a,b)=> Number(b.dataset.reports) - Number(a.dataset.reports));
        } else if (mode === 'reports-asc') {
          visible.sort((a,b)=> Number(a.dataset.reports) - Number(b.dataset.reports));
        } else if (mode === 'company-asc') {
          visible.sort((a,b)=> a.dataset.company.localeCompare(b.dataset.company));
        } else {
          // recent: keep initial DOM order (assumes backend provided recent order)
          // we'll keep visible ordering by their order in cards array
          visible.sort((a,b)=> cards.indexOf(a) - cards.indexOf(b));
        }

        // Re-render visible in the list container
        listEl.innerHTML = '';
        visible.forEach(c => listEl.appendChild(c));
        // Update summary
        // (If you want a live count you can update a summary element here)
      }

      search.addEventListener('input', applyFilters);
      filterType.addEventListener('change', applyFilters);
      sortBy.addEventListener('change', applyFilters);

      // Initial call
      applyFilters();
    })();
  </script>
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

