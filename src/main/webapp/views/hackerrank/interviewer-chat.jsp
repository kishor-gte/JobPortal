<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Interviewer Chat - SmartInterview</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #1e293b;
            --text-secondary: #475569;
            --text-tertiary: #64748b;
            --border-color: rgba(0, 0, 0, 0.08);
            --card-bg: #ffffff;
            --hover-bg: rgba(25, 167, 123, 0.08);
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: var(--text-primary);
            height: 100vh;
            overflow: hidden;
            display: flex;
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

        .sidebar {
            width: 280px;
            height: 100vh;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            padding: 24px 16px;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            z-index: 100;
            position: relative;
            box-shadow: var(--shadow-sm);
        }

        .sidebar-logo {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 8px 12px 24px;
            border-bottom: 1px solid var(--border-color);
            margin-bottom: 24px;
        }

        .sidebar-logo .icon {
            width: 48px;
            height: 48px;
            background: var(--gradient-primary);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: var(--glow-primary);
            animation: logoGlow 3s ease-in-out infinite;
        }

        @keyframes logoGlow {
            0%, 100% { box-shadow: 0 0 20px rgba(25, 167, 123, 0.2); }
            50% { box-shadow: 0 0 30px rgba(25, 167, 123, 0.4); }
        }

        .sidebar-logo .icon i {
            color: #fff;
            font-size: 24px;
        }

        .sidebar-logo h2 {
            font-size: 20px;
            font-weight: 700;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
        }

        .nav-section {
            margin-bottom: 28px;
        }

        .nav-section h4 {
            color: var(--text-tertiary);
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding: 0 12px;
            margin-bottom: 14px;
            font-weight: 600;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 14px;
            border-radius: 12px;
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 4px;
            position: relative;
            overflow: hidden;
        }

        .nav-link i {
            width: 20px;
            text-align: center;
            font-size: 16px;
            transition: transform 0.3s ease;
        }

        .nav-link::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 3px;
            background: var(--gradient-primary);
            transform: translateX(-100%);
            transition: transform 0.3s ease;
        }

        .nav-link:hover {
            background: var(--hover-bg);
            color: var(--primary);
            transform: translateX(4px);
        }

        .nav-link:hover i {
            transform: scale(1.1);
        }

        .nav-link:hover::before {
            transform: translateX(0);
        }

        .nav-link.active {
            background: var(--hover-bg);
            color: var(--primary);
            box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.05);
        }

        .nav-link.active::before {
            transform: translateX(0);
        }

        .nav-link.active i {
            color: var(--primary);
        }

        .chat-sidebar {
            width: 300px;
            height: 100vh;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            padding: 24px 16px;
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            position: relative;
            z-index: 50;
        }

        .contacts-header {
            padding: 0 12px 16px;
            color: var(--primary);
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .contacts-header i {
            font-size: 14px;
        }

        .contacts-list {
            flex: 1;
            overflow-y: auto;
        }

        .contacts-list::-webkit-scrollbar { 
            width: 6px; 
        }
        
        .contacts-list::-webkit-scrollbar-track {
            background: transparent;
        }
        
        .contacts-list::-webkit-scrollbar-thumb { 
            background: var(--primary);
            border-radius: 3px;
            opacity: 0.5;
        }

        .contact-item {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px;
            border-radius: 14px;
            text-decoration: none;
            color: var(--text-primary);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 6px;
            position: relative;
            overflow: hidden;
        }

        .contact-item::before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 3px;
            background: var(--gradient-primary);
            transform: translateX(-100%);
            transition: transform 0.3s ease;
        }

        .contact-item:hover {
            background: var(--hover-bg);
            transform: translateX(4px);
        }

        .contact-item:hover::before {
            transform: translateX(0);
        }

        .contact-item.active {
            background: var(--hover-bg);
            border: 1px solid var(--primary);
            box-shadow: var(--glow-primary);
        }

        .contact-item.active::before {
            transform: translateX(0);
        }

        .contact-avatar {
            width: 48px; 
            height: 48px;
            background: var(--gradient-primary);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 700;
            font-size: 18px;
            flex-shrink: 0;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .contact-info {
            overflow: hidden;
            flex: 1;
        }

        .contact-info h4 {
            font-size: 15px;
            font-weight: 600;
            color: var(--text-primary);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            margin-bottom: 4px;
        }

        .contact-info p {
            font-size: 12px;
            color: var(--text-tertiary);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .contact-info p i {
            font-size: 10px;
            color: var(--primary);
        }

        .online-indicator {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--primary);
            display: inline-block;
            margin-right: 4px;
            box-shadow: 0 0 8px var(--primary);
        }

        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
            background: rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(20px);
            position: relative;
            z-index: 40;
        }

        .chat-header {
            padding: 20px 28px;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(10px);
            z-index: 10;
        }

        .chat-header-info {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .btn-back-dashboard {
            padding: 10px 18px;
            background: var(--hover-bg);
            border: 1px solid var(--primary);
            border-radius: 30px;
            color: var(--primary);
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back-dashboard:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        .chat-area {
            flex: 1;
            padding: 28px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
            gap: 18px;
            background: rgba(248, 250, 252, 0.5);
        }

        .chat-area::-webkit-scrollbar { 
            width: 8px; 
        }
        
        .chat-area::-webkit-scrollbar-track {
            background: transparent;
        }
        
        .chat-area::-webkit-scrollbar-thumb { 
            background: var(--primary);
            border-radius: 4px;
            opacity: 0.5;
        }

        .message {
            max-width: 70%;
            display: flex;
            flex-direction: column;
            gap: 6px;
            animation: messageAppear 0.3s ease-out;
        }

        @keyframes messageAppear {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .message-incoming { align-self: flex-start; }
        .message-outgoing { align-self: flex-end; align-items: flex-end; }

        .message-bubble {
            padding: 14px 18px;
            border-radius: 18px;
            font-size: 14px;
            line-height: 1.6;
            position: relative;
            word-wrap: break-word;
        }

        .message-incoming .message-bubble {
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-bottom-left-radius: 4px;
            color: var(--text-primary);
            min-height: 40px;
            min-width: 60px;
            box-shadow: var(--shadow-sm);
        }

        .message-outgoing .message-bubble {
            background: var(--gradient-primary);
            border-bottom-right-radius: 4px;
            color: #fff;
            box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
            min-height: 40px;
            min-width: 60px;
        }

        .message-time {
            font-size: 11px;
            color: var(--text-tertiary);
            margin: 4px 10px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .message-outgoing .message-time {
            justify-content: flex-end;
        }

        .message-status {
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .message-status i {
            font-size: 10px;
            color: var(--primary);
        }

        .empty-chat {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            color: var(--text-tertiary);
            background: rgba(248, 250, 252, 0.5);
        }

        .empty-chat i {
            font-size: 72px;
            margin-bottom: 20px;
            color: var(--primary);
            opacity: 0.3;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        
        .empty-chat h2 {
            color: var(--text-primary);
            font-size: 22px;
            margin-bottom: 8px;
        }

        .chat-input-area {
            padding: 20px 28px;
            background: rgba(255, 255, 255, 0.6);
            backdrop-filter: blur(10px);
            border-top: 1px solid var(--border-color);
        }

        .chat-form {
            display: flex;
            gap: 14px;
            align-items: flex-end;
        }

        .chat-input {
            flex: 1;
            background: #ffffff;
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 16px 18px;
            color: var(--text-primary);
            font-family: 'Inter', sans-serif;
            font-size: 14px;
            resize: none;
            outline: none;
            max-height: 120px;
            min-height: 56px;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-sm);
        }

        .chat-input::placeholder {
            color: var(--text-tertiary);
        }

        .chat-input:focus {
            border-color: var(--primary);
            box-shadow: var(--shadow-md), var(--glow-primary);
        }

        .btn-send {
            width: 56px;
            height: 56px;
            border-radius: 16px;
            background: var(--gradient-primary);
            border: none;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            flex-shrink: 0;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-send:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .btn-send:active {
            transform: translateY(0);
        }

        .theme-toggle-wrapper { display: none; }
        .header-actions { display: flex; align-items: center; gap: 16px; }

        /* Typing Indicator */
        .typing-indicator {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 8px 16px;
            color: var(--text-tertiary);
            font-size: 12px;
            font-style: italic;
        }

        .typing-dots {
            display: flex;
            gap: 4px;
        }

        .typing-dots span {
            width: 6px;
            height: 6px;
            border-radius: 50%;
            background: var(--primary);
            animation: typingDot 1.4s infinite;
            opacity: 0.6;
        }

        .typing-dots span:nth-child(2) { animation-delay: 0.2s; }
        .typing-dots span:nth-child(3) { animation-delay: 0.4s; }

        @keyframes typingDot {
            0%, 60%, 100% { transform: translateY(0); opacity: 0.6; }
            30% { transform: translateY(-6px); opacity: 1; }
        }

        /* Mobile Responsive */
        @media (max-width: 768px) {
            .sidebar, .chat-sidebar {
                position: fixed;
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 1000;
            }
            
            .sidebar.active, .chat-sidebar.active {
                transform: translateX(0);
                box-shadow: var(--shadow-lg);
            }
            
            .main-content {
                width: 100%;
            }
            
            .message {
                max-width: 85%;
            }
        }

        .mobile-menu-btn {
            display: none;
        }

        .loading-spinner {
            display: inline-block;
            width: 16px;
            height: 16px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top-color: #fff;
            border-radius: 50%;
            animation: spin 0.6s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }
    </style>
</head>
<body>

    <!-- Mobile Overlay -->
    <div class="mobile-overlay" id="mobileOverlay"></div>

    <!-- Navigation Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-chalkboard-teacher"></i></div>
            <h2>Mentor Panel</h2>
        </div>
        <div class="nav-section">
            <h4>Main</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/dashboard" class="nav-link">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/evaluations" class="nav-link">
                <i class="fas fa-chart-pie"></i> Student Analytics
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/schedule-interview" class="nav-link">
                <i class="fas fa-calendar-plus"></i> Schedule Interview
            </a>
        </div>
        <div class="nav-section">
            <h4>Tools</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/chat" class="nav-link active">
                <i class="fas fa-comments"></i> Messages
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/review-resumes" class="nav-link">
                <i class="fas fa-file-alt"></i> Review Resumes
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="nav-link">
                <i class="fas fa-robot"></i> AI Evaluations
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/candidates" class="nav-link">
                <i class="fas fa-users"></i> Candidates
            </a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/logout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <!-- Chat Contacts Sidebar -->
    <div class="chat-sidebar" id="chatSidebar">
        <div class="contacts-header">
            <i class="fas fa-users"></i>
            Available Contacts
        </div>
        <div class="contacts-list">
            <c:forEach var="contact" items="${contacts}">
                <a href="${pageContext.request.contextPath}/hackerrank/chat/${contact.id}?type=${contact.role}" 
                   class="contact-item ${contact.id == selectedPartnerId && contact.role == partner.role ? 'active' : ''}">
                    <div class="contact-avatar">${contact.fullName.substring(0,1).toUpperCase()}</div>
                    <div class="contact-info">
                        <h4>${contact.fullName}</h4>
                        <p>
                            <span class="online-indicator"></span>
                            ${contact.role}
                        </p>
                    </div>
                </a>
            </c:forEach>
            <c:if test="${empty contacts}">
                <div style="padding: 30px 20px; text-align: center; color: var(--text-tertiary); font-size: 13px;">
                    <i class="fas fa-user-slash" style="font-size: 32px; margin-bottom: 12px; opacity: 0.3;"></i>
                    <p>No contacts available.</p>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Main Chat Area -->
    <div class="main-content">
        <div class="chat-header">
            <c:if test="${not empty partner}">
                <div class="chat-header-info">
                    <button class="mobile-menu-btn" id="mobileMenuBtn" onclick="toggleChatSidebar()">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="contact-avatar" style="width: 42px; height: 42px; font-size: 16px;">
                        ${partner.fullName.substring(0,1).toUpperCase()}
                    </div>
                    <div>
                        <h3 style="font-size: 16px; font-weight: 700; color: var(--text-primary);">${partner.fullName}</h3>
                        <p style="font-size: 12px; color: var(--primary); display: flex; align-items: center; gap: 4px;">
                            <span class="online-indicator"></span>
                            ${partner.role} • Online
                        </p>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty partner}">
                <div style="color: var(--text-tertiary); display: flex; align-items: center; gap: 12px;">
                    <button class="mobile-menu-btn" id="mobileMenuBtn2" onclick="toggleChatSidebar()">
                        <i class="fas fa-bars"></i>
                    </button>
                    <span>Select a conversation</span>
                </div>
            </c:if>
            
            <div class="header-actions">
                <a href="${pageContext.request.contextPath}/hackerrank/interviewer/dashboard" class="btn-back-dashboard">
                    <i class="fas fa-arrow-left"></i> Dashboard
                </a>
            </div>
        </div>

        <c:if test="${empty partner}">
            <div class="empty-chat">
                <i class="far fa-comments"></i>
                <h2>Your Messages</h2>
                <p>Select a contact from the sidebar to start chatting.</p>
            </div>
        </c:if>

        <c:if test="${not empty partner}">
            <div class="chat-area" id="chatArea">
                <c:if test="${empty messages}">
                    <div style="text-align: center; color: var(--text-tertiary); padding: 50px 20px; font-size: 13px;">
                        <i class="far fa-smile" style="font-size: 40px; margin-bottom: 16px; opacity: 0.3;"></i>
                        <p>No messages yet. Send a message to start the conversation!</p>
                    </div>
                </c:if>
                
                <c:forEach var="msg" items="${messages}">
                    <c:set var="isOutgoing" value="${msg.senderId == currentUserId && msg.senderType == currentUserType}" />
                    <div class="message ${isOutgoing ? 'message-outgoing' : 'message-incoming'}">
                        <div class="message-bubble">${msg.content}</div>
                        <div class="message-time">
                            <fmt:formatDate value="${msg.timestamp}" pattern="hh:mm a" />
                            <c:if test="${isOutgoing}">
                                <span class="message-status">
                                    <i class="fas fa-check-circle"></i>
                                </span>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
                
                <div class="typing-indicator" id="typingIndicator" style="display: none;">
                    <div class="typing-dots">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                    <span>${partner.fullName} is typing...</span>
                </div>
            </div>

            <div class="chat-input-area">
                <form action="${pageContext.request.contextPath}/hackerrank/chat/send" method="post" class="chat-form" id="chatForm">
                    <input type="hidden" name="receiverId" value="${partner.id}">
                    <input type="hidden" name="receiverType" value="${partner.role}">
                    <textarea name="content" class="chat-input" id="messageInput" placeholder="Type a message..." required></textarea>
                    <button type="submit" class="btn-send" id="sendButton">
                        <i class="fas fa-paper-plane"></i>
                    </button>
                </form>
            </div>
        </c:if>
    </div>

    <script>
        // Mobile menu functionality
        function toggleChatSidebar() {
            const sidebar = document.getElementById('chatSidebar');
            const overlay = document.getElementById('mobileOverlay');
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
            document.body.style.overflow = sidebar.classList.contains('active') ? 'hidden' : '';
        }

        function toggleNavSidebar() {
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('mobileOverlay');
            sidebar.classList.toggle('active');
            overlay.classList.toggle('active');
            document.body.style.overflow = sidebar.classList.contains('active') ? 'hidden' : '';
        }

        document.addEventListener('DOMContentLoaded', function() {
            if ("Notification" in window && Notification.permission !== "denied" && Notification.permission !== "granted") {
                Notification.requestPermission();
            }
            const chatArea = document.getElementById('chatArea');
            if (chatArea) {
                chatArea.scrollTop = chatArea.scrollHeight;
            }
            
            const overlay = document.getElementById('mobileOverlay');
            if (overlay) {
                overlay.addEventListener('click', function() {
                    document.getElementById('chatSidebar').classList.remove('active');
                    document.getElementById('sidebar').classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                });
            }
            
            const mobileMenuBtn = document.getElementById('mobileMenuBtn');
            const mobileMenuBtn2 = document.getElementById('mobileMenuBtn2');
            if (mobileMenuBtn) mobileMenuBtn.addEventListener('click', toggleChatSidebar);
            if (mobileMenuBtn2) mobileMenuBtn2.addEventListener('click', toggleChatSidebar);
            
            const textarea = document.getElementById('messageInput');
            const form = document.getElementById('chatForm');
            if (textarea && form) {
                textarea.addEventListener('keydown', function(e) {
                    if (e.ctrlKey && e.key === 'Enter') {
                        e.preventDefault();
                        if (this.value.trim() !== '') {
                            const sendBtn = document.getElementById('sendButton');
                            sendBtn.innerHTML = '<span class="loading-spinner"></span>';
                            sendBtn.disabled = true;
                            form.submit();
                        }
                    }
                });
                
                textarea.addEventListener('input', function() {
                    this.style.height = 'auto';
                    this.style.height = Math.min(this.scrollHeight, 120) + 'px';
                });
            }

            // Touch swipe for mobile
            let touchStartX = 0;
            let touchEndX = 0;
            
            document.body.addEventListener('touchstart', e => {
                touchStartX = e.changedTouches[0].screenX;
            }, { passive: true });
            
            document.body.addEventListener('touchend', e => {
                touchEndX = e.changedTouches[0].screenX;
                if (touchEndX < touchStartX - 50) {
                    document.getElementById('chatSidebar').classList.remove('active');
                    document.getElementById('sidebar').classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
                if (touchEndX > touchStartX + 50 && touchStartX < 30) {
                    document.getElementById('chatSidebar').classList.add('active');
                    overlay.classList.add('active');
                    document.body.style.overflow = 'hidden';
                }
            }, { passive: true });
        });

        // AJAX Polling for new messages
        let messageCount = ${not empty messages ? messages.size() : 0};
        const partnerId = '${selectedPartnerId}';
        const partnerType = '${partnerType}';
        const currentId = '${currentUserId}';
        const currentType = '${currentUserType}';

        function pollMessages() {
            if (!partnerId) return;
            
            fetch(`${pageContext.request.contextPath}/hackerrank/chat/api/messages?partnerId=${partnerId}&partnerType=${partnerType}`)
                .then(res => res.json())
                .then(data => {
                    if (data.length > messageCount) {
                        const chatArea = document.getElementById('chatArea');
                        const typingIndicator = document.getElementById('typingIndicator');
                        const newMessages = data.slice(messageCount);
                        
                        let hasNewIncoming = false;
                        newMessages.forEach(msg => {
                            if (!msg.content || msg.content.trim() === '') return;
                            
                            const isOutgoing = (String(msg.senderId) === String(currentId) && String(msg.senderType) === String(currentType));
                            if (!isOutgoing) hasNewIncoming = true;
                            const msgDiv = document.createElement('div');
                            msgDiv.className = `message ${isOutgoing ? 'message-outgoing' : 'message-incoming'}`;
                            
                            let timeStr = msg.timestamp;
                            try {
                                const date = new Date(msg.timestamp);
                                if (!isNaN(date)) {
                                    timeStr = date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
                                }
                            } catch (e) {}

                            const statusHtml = isOutgoing ? '<span class="message-status"><i class="fas fa-check-circle"></i></span>' : '';
                            
                            msgDiv.innerHTML = `
                                <div class="message-bubble">${'$'}{escapeHtml(msg.content)}</div>
                                <div class="message-time">${'$'}{timeStr} ${'$'}{statusHtml}</div>
                            `;
                            
                            if (typingIndicator) {
                                chatArea.insertBefore(msgDiv, typingIndicator);
                            } else {
                                chatArea.appendChild(msgDiv);
                            }
                        });
                        
                        messageCount = data.length;
                        chatArea.scrollTop = chatArea.scrollHeight;
                        
                        if (typingIndicator) {
                            typingIndicator.style.display = 'none';
                        }
                        
                        if (hasNewIncoming && document.hidden) {
                            if ("Notification" in window && Notification.permission === "granted") {
                                new Notification("New Message", { body: "You have a new message from ${partner.fullName}" });
                            }
                        }
                    }
                })
                .catch(err => console.error("Error polling messages:", err));
        }

        function escapeHtml(text) {
            const div = document.createElement('div');
            div.textContent = text;
            return div.innerHTML;
        }

        if (partnerId) {
            setInterval(pollMessages, 2000);
        }

        window.addEventListener('resize', function() {
            if (window.innerWidth > 768) {
                document.getElementById('chatSidebar').classList.remove('active');
                document.getElementById('sidebar').classList.remove('active');
                document.getElementById('mobileOverlay').classList.remove('active');
                document.body.style.overflow = '';
            }
        });
    </script>
</body>
</html>