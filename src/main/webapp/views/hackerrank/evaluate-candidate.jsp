<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evaluate Candidate - SmartInterview</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
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
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --purple: #8b5cf6;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: var(--text-primary);
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

        .container {
            max-width: 900px;
            margin: 0 auto;
            padding: 32px;
            position: relative;
            z-index: 1;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            color: var(--primary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 24px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 8px 18px;
            border-radius: 30px;
            background: var(--hover-bg);
            border: 1px solid rgba(25, 167, 123, 0.15);
        }

        .back-link:hover {
            background: var(--primary);
            color: white;
            transform: translateX(-6px);
            box-shadow: var(--glow-primary);
        }

        .page-header {
            margin-bottom: 32px;
        }

        .page-header h1 {
            font-size: 32px;
            font-weight: 800;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .page-header h1 i {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 32px;
        }

        .page-header p {
            color: var(--text-tertiary);
            font-size: 15px;
        }

        .interview-info {
            background: linear-gradient(135deg, rgba(25, 167, 123, 0.05), rgba(59, 196, 154, 0.05));
            border: 1px solid rgba(25, 167, 123, 0.15);
            border-radius: 20px;
            padding: 24px 28px;
            margin-bottom: 32px;
            display: flex;
            gap: 40px;
            flex-wrap: wrap;
            backdrop-filter: blur(10px);
            box-shadow: var(--shadow-sm);
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .interview-info div h4 {
            color: var(--text-tertiary);
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 6px;
            font-weight: 600;
        }

        .interview-info div p {
            color: var(--text-primary);
            font-size: 16px;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .interview-info div p i {
            color: var(--primary);
            font-size: 14px;
        }

        .feedback-form {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 36px;
            box-shadow: var(--shadow-md);
            backdrop-filter: blur(10px);
            animation: fadeIn 0.6s ease-out 0.1s both;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .feedback-form h3 {
            font-size: 22px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 28px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .feedback-form h3 i {
            color: var(--primary);
        }

        .rating-group {
            margin-bottom: 28px;
        }

        .rating-group label {
            display: block;
            color: var(--text-secondary);
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .rating-group label i {
            color: var(--primary);
            font-size: 16px;
        }

        .rating-stars {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .rating-stars input[type="radio"] {
            display: none;
        }

        .rating-stars label {
            width: 48px;
            height: 48px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 16px;
            font-weight: 700;
            color: var(--text-tertiary);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin: 0;
        }

        .rating-stars label:hover {
            background: var(--hover-bg);
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .rating-stars input:checked + label {
            background: var(--gradient-primary);
            color: #fff;
            border-color: transparent;
            box-shadow: 0 6px 16px rgba(25, 167, 123, 0.3);
            transform: scale(1.05);
        }

        .rating-stars input:checked + label i {
            color: #fff;
        }

        .form-group {
            margin-bottom: 24px;
        }

        .form-group label {
            display: block;
            color: var(--text-secondary);
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-group label i {
            color: var(--primary);
            font-size: 16px;
        }

        .form-group textarea {
            width: 100%;
            min-height: 140px;
            padding: 16px 18px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            color: var(--text-primary);
            font-size: 14px;
            font-family: 'Inter', sans-serif;
            resize: vertical;
            outline: none;
            transition: all 0.3s ease;
            line-height: 1.6;
        }

        .form-group textarea:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        .form-group textarea::placeholder {
            color: var(--text-tertiary);
        }

        .form-group select {
            width: 100%;
            padding: 14px 18px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            color: var(--text-primary);
            font-size: 14px;
            font-family: 'Inter', sans-serif;
            outline: none;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .form-group select:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        .form-group select option {
            background: var(--card-bg);
            color: var(--text-primary);
            padding: 10px;
        }

        .btn-submit {
            padding: 16px 36px;
            background: var(--gradient-primary);
            color: #fff;
            border: none;
            border-radius: 16px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-family: 'Inter', sans-serif;
            margin-top: 16px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 6px 16px rgba(25, 167, 123, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 28px rgba(25, 167, 123, 0.4);
        }

        .btn-submit:active {
            transform: translateY(-1px);
        }

        .existing-feedback {
            margin-top: 40px;
        }

        .existing-feedback h3 {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .existing-feedback h3 i {
            color: var(--info);
        }

        .fb-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 18px;
            padding: 24px;
            margin-bottom: 16px;
            box-shadow: var(--shadow-sm);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
            animation: slideIn 0.4s ease-out;
        }

        .fb-card:hover {
            border-color: var(--primary);
            box-shadow: var(--shadow-md);
            transform: translateX(4px);
        }

        .fb-scores {
            display: flex;
            gap: 12px;
            margin-bottom: 16px;
            flex-wrap: wrap;
        }

        .fb-score {
            padding: 8px 18px;
            border-radius: 30px;
            font-size: 13px;
            font-weight: 600;
            backdrop-filter: blur(10px);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .fb-score i {
            font-size: 12px;
        }

        .fb-card p {
            color: var(--text-secondary);
            font-size: 14px;
            line-height: 1.7;
        }

        .fb-card .recommendation {
            margin-top: 12px;
            font-size: 13px;
            color: var(--text-tertiary);
        }

        .fb-card .recommendation strong {
            color: var(--primary);
        }

        /* Loading Animation */
        .loading-spinner {
            display: inline-block;
            width: 18px;
            height: 18px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-top-color: #fff;
            border-radius: 50%;
            animation: spin 0.6s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .interview-info {
                gap: 20px;
                padding: 20px;
            }

            .feedback-form {
                padding: 24px;
            }

            .rating-stars label {
                width: 42px;
                height: 42px;
                font-size: 14px;
            }

            .page-header h1 {
                font-size: 26px;
            }

            .btn-submit {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .rating-stars label {
                width: 38px;
                height: 38px;
            }

            .fb-scores {
                gap: 8px;
            }

            .fb-score {
                padding: 6px 12px;
                font-size: 11px;
            }
        }
    </style>
</head>

<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/hackerrank/interviewer/dashboard" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>

        <div class="page-header">
            <h1>
                <i class="fas fa-star"></i>
                Evaluate Candidate
            </h1>
            <p>Provide detailed feedback for this interview session</p>
        </div>

        <div class="interview-info">
            <div>
                <h4>Student</h4>
                <p>
                    <i class="fas fa-user-graduate"></i>
                    ${interview.studentName}
                </p>
            </div>
            <div>
                <h4>Date</h4>
                <p>
                    <i class="fas fa-calendar-alt"></i>
                    ${interview.scheduledAt}
                </p>
            </div>
            <div>
                <h4>Duration</h4>
                <p>
                    <i class="fas fa-clock"></i>
                    ${interview.durationMinutes} minutes
                </p>
            </div>
            <div>
                <h4>Status</h4>
                <p>
                    <i class="fas fa-info-circle"></i>
                    ${interview.status}
                </p>
            </div>
        </div>

        <div class="feedback-form">
            <h3>
                <i class="fas fa-clipboard-check"></i>
                Submit Feedback
            </h3>
            <form action="${pageContext.request.contextPath}/interviewer/submit-feedback" method="post" id="feedbackForm">
                <input type="hidden" name="interviewId" value="${interview.id}">
                <input type="hidden" name="studentId" value="${interview.studentId}">

                <div class="rating-group">
                    <label>
                        <i class="fas fa-laptop-code"></i>
                        Technical Skills (1-10)
                    </label>
                    <div class="rating-stars">
                        <c:forEach begin="1" end="10" var="i">
                            <input type="radio" name="technicalRating" id="tech${i}" value="${i}" ${i==7 ? 'checked' : ''}>
                            <label for="tech${i}">${i}</label>
                        </c:forEach>
                    </div>
                </div>

                <div class="rating-group">
                    <label>
                        <i class="fas fa-comments"></i>
                        Communication (1-10)
                    </label>
                    <div class="rating-stars">
                        <c:forEach begin="1" end="10" var="i">
                            <input type="radio" name="communicationRating" id="comm${i}" value="${i}" ${i==7 ? 'checked' : ''}>
                            <label for="comm${i}">${i}</label>
                        </c:forEach>
                    </div>
                </div>

                <div class="rating-group">
                    <label>
                        <i class="fas fa-brain"></i>
                        Problem Solving (1-10)
                    </label>
                    <div class="rating-stars">
                        <c:forEach begin="1" end="10" var="i">
                            <input type="radio" name="problemSolvingRating" id="ps${i}" value="${i}" ${i==7 ? 'checked' : ''}>
                            <label for="ps${i}">${i}</label>
                        </c:forEach>
                    </div>
                </div>

                <div class="rating-group">
                    <label>
                        <i class="fas fa-star"></i>
                        Overall Rating (1-10)
                    </label>
                    <div class="rating-stars">
                        <c:forEach begin="1" end="10" var="i">
                            <input type="radio" name="overallRating" id="overall${i}" value="${i}" ${i==7 ? 'checked' : ''}>
                            <label for="overall${i}">${i}</label>
                        </c:forEach>
                    </div>
                </div>

                <div class="form-group">
                    <label>
                        <i class="fas fa-comment-dots"></i>
                        Comments
                    </label>
                    <textarea name="comments" id="commentsInput"
                        placeholder="Provide detailed feedback about the candidate's performance, strengths, and areas for improvement..."></textarea>
                </div>

                <div class="form-group">
                    <label>
                        <i class="fas fa-thumbs-up"></i>
                        Recommendation
                    </label>
                    <select name="recommendation" required>
                        <option value="STRONG_YES">🌟 Strong Yes - Excellent candidate</option>
                        <option value="YES">👍 Yes - Good candidate</option>
                        <option value="MAYBE" selected>🤔 Maybe - Needs improvement</option>
                        <option value="NO">👎 No - Not ready yet</option>
                        <option value="STRONG_NO">⚠️ Strong No - Significant gaps</option>
                    </select>
                </div>

                <button type="submit" class="btn-submit" id="submitBtn">
                    <i class="fas fa-paper-plane"></i> Submit Feedback
                </button>
            </form>
        </div>

        <c:if test="${not empty existingFeedback}">
            <div class="existing-feedback">
                <h3>
                    <i class="fas fa-history"></i>
                    Previous Feedback
                </h3>
                <c:forEach var="fb" items="${existingFeedback}" varStatus="status">
                    <div class="fb-card" style="animation-delay: ${status.index * 0.1}s;">
                        <div class="fb-scores">
                            <span class="fb-score" style="background: rgba(25, 167, 123, 0.1); color: var(--primary); border: 1px solid var(--primary);">
                                <i class="fas fa-laptop-code"></i> Technical: ${fb.technicalRating}/10
                            </span>
                            <span class="fb-score" style="background: rgba(59, 196, 154, 0.1); color: var(--accent); border: 1px solid var(--accent);">
                                <i class="fas fa-comments"></i> Communication: ${fb.communicationRating}/10
                            </span>
                            <span class="fb-score" style="background: rgba(245, 158, 11, 0.1); color: var(--warning); border: 1px solid var(--warning);">
                                <i class="fas fa-brain"></i> Problem Solving: ${fb.problemSolvingRating}/10
                            </span>
                            <span class="fb-score" style="background: rgba(139, 92, 246, 0.1); color: var(--purple); border: 1px solid var(--purple);">
                                <i class="fas fa-star"></i> Overall: ${fb.overallRating}/10
                            </span>
                        </div>
                        <p>${fb.comments}</p>
                        <p class="recommendation">
                            Recommendation: <strong>${fb.recommendation}</strong>
                        </p>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Form validation
            const form = document.getElementById('feedbackForm');
            const submitBtn = document.getElementById('submitBtn');
            
            if (form) {
                form.addEventListener('submit', function(e) {
                    // Check if all ratings are selected
                    const techRating = document.querySelector('input[name="technicalRating"]:checked');
                    const commRating = document.querySelector('input[name="communicationRating"]:checked');
                    const psRating = document.querySelector('input[name="problemSolvingRating"]:checked');
                    const overallRating = document.querySelector('input[name="overallRating"]:checked');
                    
                    if (!techRating || !commRating || !psRating || !overallRating) {
                        e.preventDefault();
                        alert('Please provide all ratings before submitting.');
                        return;
                    }
                    
                    // Show loading state
                    submitBtn.innerHTML = '<span class="loading-spinner"></span> Submitting...';
                    submitBtn.disabled = true;
                });
            }

            // Rating hover effects
            const ratingLabels = document.querySelectorAll('.rating-stars label');
            ratingLabels.forEach(label => {
                label.addEventListener('mouseenter', function() {
                    const value = parseInt(this.textContent);
                    const parent = this.parentElement;
                    const labels = parent.querySelectorAll('label');
                    
                    labels.forEach((l, index) => {
                        if (index < value) {
                            l.style.background = 'var(--hover-bg)';
                            l.style.borderColor = 'var(--primary)';
                            l.style.color = 'var(--primary)';
                        }
                    });
                });
                
                label.addEventListener('mouseleave', function() {
                    const parent = this.parentElement;
                    const labels = parent.querySelectorAll('label');
                    const checked = parent.querySelector('input:checked');
                    
                    labels.forEach(l => {
                        l.style.background = '';
                        l.style.borderColor = '';
                        l.style.color = '';
                    });
                    
                    if (checked) {
                        const checkedValue = parseInt(checked.value);
                        labels.forEach((l, index) => {
                            if (index < checkedValue) {
                                // Keep the checked styling
                            }
                        });
                    }
                });
            });

            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Ctrl/Cmd + Enter to submit
                if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
                    e.preventDefault();
                    if (form) {
                        form.dispatchEvent(new Event('submit'));
                    }
                }
                
                // Escape to go back
                if (e.key === 'Escape') {
                    const backLink = document.querySelector('.back-link');
                    if (backLink) {
                        window.location.href = backLink.href;
                    }
                }
            });

            // Auto-save draft (optional)
            let autoSaveTimer;
            const commentInput = document.getElementById('commentsInput');
            
            if (commentInput) {
                commentInput.addEventListener('input', function() {
                    clearTimeout(autoSaveTimer);
                    autoSaveTimer = setTimeout(() => {
                        // Save to localStorage as draft
                        const draft = {
                            comments: this.value,
                            timestamp: new Date().toISOString()
                        };
                        localStorage.setItem('feedbackDraft_' + '${interview.id}', JSON.stringify(draft));
                        console.log('Draft saved');
                    }, 1000);
                });
                
                // Load draft if exists
                const savedDraft = localStorage.getItem('feedbackDraft_' + '${interview.id}');
                if (savedDraft) {
                    try {
                        const draft = JSON.parse(savedDraft);
                        commentInput.value = draft.comments;
                        console.log('Draft loaded from', draft.timestamp);
                    } catch (e) {
                        console.error('Failed to load draft');
                    }
                }
            }

            // Mobile responsive menu (if sidebar exists)
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