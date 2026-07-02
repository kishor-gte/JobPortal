<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<%@ page import="java.time.*, java.time.format.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Notifications | SmartInterview</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">

<style>
:root{
    --primary: #19A77B;
    --primary-dark: #148F69;
    --accent: #3BC49A;
    --bg-dark: #2E3E41;
    --bg-darker: #1a2a2c;
    --bg-lighter: #3a4e51;
    --bg:#f6f9fc;
    --card:#ffffff;
    --text:#1e293b;
    --muted:#64748b;
    --border:#e0e6ed;
    --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
    --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
    --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
    --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
    --success: #10b981;
    --warning: #f59e0b;
    --info: #3b82f6;
}

/* ===== GLOBAL ===== */
body{
    font-family:'Inter',sans-serif;
    background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
    color:var(--text);
    margin:0;
    min-height: 100vh;
    position: relative;
}

/* Animated background pattern */
body::before {
    content: '';
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: 
        radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.03) 0%, transparent 50%),
        radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.03) 0%, transparent 50%);
    pointer-events: none;
    z-index: 0;
    animation: backgroundPulse 15s ease-in-out infinite;
}

@keyframes backgroundPulse {
    0%, 100% { opacity: 0.5; }
    50% { opacity: 1; }
}

/* ===== MAIN CONTENT WRAPPER ===== */
.main-content-wrapper {
    margin-left: 280px;
    padding: 0;
    transition: margin-left 0.3s ease;
    position: relative;
    z-index: 5;
}

@media (max-width: 991.98px) {
    .main-content-wrapper {
        margin-left: 0 !important;
        padding-top: 60px !important;
    }
}

/* ===== SLIM HEADER (LINKEDIN STYLE) ===== */
.page-header{
    background:#fff;
    border-bottom:1px solid var(--border);
    padding:16px 0;
    position: relative;
    z-index: 5;
}

.page-header h1{
    font-size:20px;
    font-weight:700;
    margin:0;
    display:flex;
    align-items:center;
    gap:10px;
    color: var(--primary);
}

.page-header h1 i {
    color: var(--primary);
}

.page-header p{
    display:none;
}

/* ===== CONTENT WRAPPER ===== */
.container-narrow{
    max-width:900px;
    margin:0 auto;
    background:#fff;
    border-radius: 0 0 20px 20px;
    box-shadow: var(--shadow-sm);
    position: relative;
    z-index: 5;
}

/* ===== NOTIFICATION STATS ===== */
.notification-stats {
    padding: 16px 20px;
    border-bottom: 1px solid var(--border);
    display: flex;
    align-items: center;
    gap: 24px;
    flex-wrap: wrap;
}

.stat-badge {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 14px;
    color: var(--muted);
}

.stat-badge i {
    color: var(--primary);
}

.stat-badge .unread-count {
    background: var(--primary);
    color: white;
    padding: 2px 10px;
    border-radius: 20px;
    font-size: 12px;
    font-weight: 600;
}

.mark-all-btn {
    margin-left: auto;
    background: transparent;
    border: 1px solid var(--border);
    color: var(--primary);
    padding: 8px 16px;
    border-radius: 30px;
    font-size: 13px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 6px;
}

.mark-all-btn:hover {
    background: var(--primary);
    color: white;
    border-color: var(--primary);
}

/* ===== NOTIFICATION FEED ===== */
.notification-feed{
    background:#fff;
}

/* ===== LINKEDIN-LIKE NOTIFICATION ROW ===== */
.notification-card{
    display:flex;
    gap:16px;
    padding:18px 20px;
    border-bottom:1px solid var(--border);
    cursor:pointer;
    transition:all 0.3s ease;
    animation: fadeIn 0.4s ease-out;
    position: relative;
}

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateX(-10px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

.notification-card::before {
    content: '';
    position: absolute;
    left: 0;
    top: 0;
    bottom: 0;
    width: 4px;
    background: var(--gradient-primary);
    opacity: 0;
    transition: opacity 0.3s ease;
}

.notification-card:hover{
    background: #f8fafc;
}

.notification-card:hover::before {
    opacity: 1;
}

.notification-card.unseen{
    background: rgba(25, 167, 123, 0.04);
    border-left: 3px solid var(--primary);
}

/* ===== ICON ===== */
.notification-icon{
    width:44px;
    height:44px;
    border-radius:14px;
    background: rgba(25, 167, 123, 0.1);
    color:var(--primary);
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:18px;
    flex-shrink:0;
    border: 1px solid rgba(25, 167, 123, 0.2);
    transition: all 0.3s ease;
}

.notification-card.unseen .notification-icon {
    background: var(--primary);
    color: white;
    box-shadow: var(--glow-primary);
}

/* ===== CONTENT ===== */
.notification-content{
    flex:1;
}

.notification-message{
    font-size:14px;
    font-weight:500;
    line-height:1.5;
    margin-bottom:6px;
    color: var(--text);
}

.notification-card.unseen .notification-message {
    font-weight: 600;
}

.notification-date{
    font-size:12px;
    color:var(--muted);
    display:flex;
    align-items:center;
    gap:8px;
}

.notification-date i {
    color: var(--primary);
    font-size: 12px;
}

/* Unread dot */
.unread-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    background: var(--primary);
    display: inline-block;
    margin-left: 8px;
    box-shadow: 0 0 8px var(--primary);
}

/* ===== EMPTY STATE ===== */
.empty-state{
    padding:80px 20px;
    text-align:center;
    background: #fff;
    border-radius: 0 0 20px 20px;
}

.empty-state i{
    font-size:56px;
    color:var(--primary);
    opacity: 0.3;
    margin-bottom:20px;
    animation: float 3s ease-in-out infinite;
}

@keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-10px); }
}

.empty-state h4 {
    font-size: 20px;
    font-weight: 700;
    color: var(--text);
    margin-bottom: 8px;
}

.empty-state p {
    color: var(--muted);
    font-size: 14px;
}

.empty-state .btn-browse {
    margin-top: 24px;
    padding: 12px 28px;
    background: var(--gradient-primary);
    color: white;
    border: none;
    border-radius: 30px;
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
}

.empty-state .btn-browse:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
}

/* ===== MOBILE ===== */
@media(max-width:576px){
    .top-nav{
        padding:10px 16px;
    }
    
    .notification-card{
        padding:14px;
    }
    
    .brand-text{
        display:none;
    }
    
    .nav-links a{
        margin-left:12px;
        font-size:13px;
    }
    
    .page-header h1{
        font-size:18px;
    }
    
    .notification-stats {
        flex-wrap: wrap;
    }
    
    .mark-all-btn {
        margin-left: 0;
        width: 100%;
        justify-content: center;
    }
}
</style>

</head>

<body>

<jsp:include page="/views/commons/student_sidebar.jsp" />

<div class="main-content-wrapper">
    <!-- PAGE HEADER -->
    <div class="page-header">
        <div class="container-narrow px-3 px-md-4">
            <h1><i class="fas fa-bell"></i> Notifications</h1>
        </div>
    </div>
    
    <!-- CONTENT -->
    <div class="container-narrow">
    
    <c:choose>
    <c:when test="${empty notifications}">
        <div class="empty-state">
            <i class="fas fa-bell-slash"></i>
            <h4>No Notifications Yet</h4>
            <p>You don't have any notifications. We'll notify you about important updates here.</p>
            <a href="${pageContext.request.contextPath}/jobs/all" class="btn-browse">
                <i class="fas fa-search"></i> Browse Jobs
            </a>
        </div>
    </c:when>
    
    <c:otherwise>
        <!-- Notification Stats -->
        <div class="notification-stats">
            <div class="stat-badge">
                <i class="fas fa-bell"></i>
                <span>Total: <strong>${fn:length(notifications)}</strong></span>
            </div>
            <c:set var="unreadCount" value="0"/>
            <c:forEach var="note" items="${notifications}">
                <c:if test="${!note.seen}">
                    <c:set var="unreadCount" value="${unreadCount + 1}"/>
                </c:if>
            </c:forEach>
            <div class="stat-badge">
                <i class="fas fa-envelope"></i>
                <span>Unread: <span class="unread-count">${unreadCount}</span></span>
            </div>
            <c:if test="${unreadCount > 0}">
                <button class="mark-all-btn" onclick="markAllAsRead()">
                    <i class="fas fa-check-double"></i> Mark all as read
                </button>
            </c:if>
        </div>
    
        <c:forEach var="note" items="${notifications}" varStatus="status">
            <div class="notification-card ${note.seen ? 'seen' : 'unseen'}" 
                 style="animation-delay: ${status.index * 0.03}s;"
                 onclick="markAsRead('${note.id}', this)">
                <div class="notification-icon">
                    <i class="fas ${note.seen ? 'fa-bell' : 'fa-bell'}"></i>
                </div>
    
                <div class="notification-content">
                    <div class="notification-message">
                        ${note.message}
                        <c:if test="${!note.seen}">
                            <span class="unread-dot"></span>
                        </c:if>
                    </div>
                    <div class="notification-date">
                        <i class="far fa-clock"></i>
                        <%
                            in.sp.main.Entities.Notification n =
                                (in.sp.main.Entities.Notification) pageContext.findAttribute("note");
                            if(n != null && n.getCreatedAt()!=null){
                                LocalDateTime t = n.getCreatedAt();
                                out.print(t.format(DateTimeFormatter.ofPattern("MMM dd, yyyy '•' hh:mm a")));
                            }
                        %>
                    </div>
                </div>
            </div>
        </c:forEach>
    </c:otherwise>
    </c:choose>
    
    </div>
</div>

<script>
    function markAsRead(notificationId, element) {
        // Remove unseen class
        element.classList.remove('unseen');
        element.classList.add('seen');
        
        // Update icon
        const icon = element.querySelector('.notification-icon i');
        if (icon) {
            icon.className = 'fas fa-bell';
        }
        
        // Remove unread dot
        const dot = element.querySelector('.unread-dot');
        if (dot) {
            dot.remove();
        }
        
        // Update unread count
        updateUnreadCount();
        
        // You can add an AJAX call here to mark as read on server
        // fetch('/api/notifications/mark-read/' + notificationId, { method: 'POST' });
    }
    
    function markAllAsRead() {
        const unseenCards = document.querySelectorAll('.notification-card.unseen');
        unseenCards.forEach(card => {
            card.classList.remove('unseen');
            card.classList.add('seen');
            
            const icon = card.querySelector('.notification-icon i');
            if (icon) {
                icon.className = 'fas fa-bell';
            }
            
            const dot = card.querySelector('.unread-dot');
            if (dot) {
                dot.remove();
            }
        });
        
        updateUnreadCount();
        
        // Hide the mark all button
        const markAllBtn = document.querySelector('.mark-all-btn');
        if (markAllBtn) {
            markAllBtn.style.display = 'none';
        }
    }
    
    function updateUnreadCount() {
        const unseenCount = document.querySelectorAll('.notification-card.unseen').length;
        const countBadge = document.querySelector('.unread-count');
        if (countBadge) {
            countBadge.textContent = unseenCount;
        }
        
        if (unseenCount === 0) {
            const markAllBtn = document.querySelector('.mark-all-btn');
            if (markAllBtn) {
                markAllBtn.style.display = 'none';
            }
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        // Add click handlers for notification cards
        const cards = document.querySelectorAll('.notification-card');
        cards.forEach(card => {
            card.addEventListener('click', function(e) {
                // Don't trigger if clicking on a link
                if (e.target.closest('a')) return;
                
                const notificationId = this.dataset.id;
                if (notificationId) {
                    markAsRead(notificationId, this);
                }
            });
        });
        
        // Keyboard shortcut to mark all as read
        document.addEventListener('keydown', function(e) {
            if (e.ctrlKey && e.key === 'e') {
                e.preventDefault();
                markAllAsRead();
            }
        });
    });
</script>
</body>
</html>