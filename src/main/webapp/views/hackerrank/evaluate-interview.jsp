<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evaluate Interview - SmartInterview</title>
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
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
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
            max-width: 850px;
            margin: 40px auto;
            padding: 20px;
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

        .card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 28px;
            padding: 40px;
            box-shadow: var(--shadow-md);
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }

        .card:hover {
            box-shadow: var(--shadow-lg);
            border-color: rgba(25, 167, 123, 0.15);
        }

        .header {
            margin-bottom: 36px;
            text-align: center;
        }

        .header h1 {
            font-size: 32px;
            font-weight: 800;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
        }

        .header h1 i {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 32px;
        }

        .header p {
            color: var(--text-tertiary);
            font-size: 15px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 24px;
            margin-bottom: 36px;
            padding: 28px;
            background: linear-gradient(135deg, rgba(25, 167, 123, 0.03), rgba(59, 196, 154, 0.03));
            border: 1px solid rgba(25, 167, 123, 0.1);
            border-radius: 20px;
            backdrop-filter: blur(10px);
        }

        .info-item {
            position: relative;
        }

        .info-item label {
            display: block;
            font-size: 11px;
            color: var(--text-tertiary);
            margin-bottom: 6px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
        }

        .info-item span {
            font-size: 17px;
            font-weight: 700;
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-item span i {
            color: var(--primary);
            font-size: 16px;
        }

        .form-group {
            margin-bottom: 28px;
        }

        .form-group label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 12px;
            color: var(--text-secondary);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-group label i {
            color: var(--primary);
            font-size: 16px;
        }

        textarea {
            width: 100%;
            min-height: 160px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 18px;
            color: var(--text-primary);
            font-family: inherit;
            font-size: 15px;
            resize: vertical;
            transition: all 0.3s ease;
            outline: none;
            line-height: 1.7;
        }

        textarea::placeholder {
            color: var(--text-tertiary);
        }

        textarea:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        .score-input {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .score-input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        input[type="number"] {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            padding: 14px 18px;
            color: var(--text-primary);
            width: 120px;
            font-size: 16px;
            font-weight: 600;
            outline: none;
            transition: all 0.3s ease;
        }

        input[type="number"]:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        input[type="number"]::-webkit-inner-spin-button,
        input[type="number"]::-webkit-outer-spin-button {
            opacity: 0.5;
        }

        .score-hint {
            color: var(--text-tertiary);
            font-weight: 500;
            font-size: 14px;
        }

        .score-hint i {
            color: var(--primary);
            margin-right: 6px;
        }

        .score-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 28px;
        }

        .score-grid .form-group {
            margin-bottom: 0;
        }

        .score-grid input {
            width: 100%;
        }

        .score-preview {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 16px 20px;
            background: var(--hover-bg);
            border: 1px solid rgba(25, 167, 123, 0.15);
            border-radius: 14px;
            margin-top: 24px;
        }

        .score-preview-label {
            font-size: 14px;
            font-weight: 600;
            color: var(--primary);
        }

        .score-preview-value {
            font-size: 24px;
            font-weight: 800;
            color: var(--primary);
        }

        .actions {
            display: flex;
            justify-content: flex-end;
            gap: 16px;
            margin-top: 36px;
        }

        .btn {
            padding: 14px 32px;
            border-radius: 14px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            text-decoration: none;
            border: none;
            font-family: inherit;
            display: inline-flex;
            align-items: center;
            gap: 10px;
        }

        .btn-secondary {
            background: transparent;
            color: var(--text-secondary);
            border: 1px solid var(--border-color);
        }

        .btn-secondary:hover {
            background: var(--hover-bg);
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: #fff;
            box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 24px rgba(25, 167, 123, 0.4);
        }

        .btn-primary:active {
            transform: translateY(-1px);
        }

        .btn-primary:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }

        /* Loading spinner */
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
                margin: 20px auto;
                padding: 16px;
            }

            .card {
                padding: 24px;
            }

            .info-grid {
                grid-template-columns: 1fr;
                gap: 16px;
                padding: 20px;
            }

            .score-grid {
                grid-template-columns: 1fr;
                gap: 16px;
            }

            .header h1 {
                font-size: 26px;
            }

            .actions {
                flex-direction: column-reverse;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .container {
                padding: 12px;
            }

            .card {
                padding: 20px;
            }

            .score-input {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            input[type="number"] {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="header">
                <h1>
                    <i class="fas fa-clipboard-check"></i>
                    Interview Evaluation
                </h1>
                <p>Provide detailed feedback and score for the candidate</p>
            </div>

            <div class="info-grid">
                <div class="info-item">
                    <label>Candidate</label>
                    <span>
                        <i class="fas fa-user-graduate"></i>
                        ${interview.studentName}
                    </span>
                </div>
                <div class="info-item">
                    <label>Scheduled Date</label>
                    <span>
                        <i class="fas fa-calendar-alt"></i>
                        ${interview.scheduledAt}
                    </span>
                </div>
                <div class="info-item">
                    <label>Duration</label>
                    <span>
                        <i class="fas fa-clock"></i>
                        ${interview.durationMinutes} Minutes
                    </span>
                </div>
                <div class="info-item">
                    <label>Status</label>
                    <span style="color: var(--primary);">
                        <i class="fas fa-info-circle"></i>
                        ${interview.status}
                    </span>
                </div>
            </div>

            <form action="${pageContext.request.contextPath}/hackerrank/interviewer/submit-feedback" method="post" id="evaluationForm">
                <input type="hidden" name="id" value="${interview.id}">
                
                <div class="form-group">
                    <label for="feedback">
                        <i class="fas fa-comment-dots"></i>
                        Detailed Feedback
                    </label>
                    <textarea id="feedback" name="feedback" 
                        placeholder="Enter your observations about the candidate's performance, strengths, and areas for improvement...">${interview.feedback}</textarea>
                </div>

                <div class="score-grid">
                    <div class="form-group">
                        <label for="tech">
                            <i class="fas fa-laptop-code"></i>
                            Technical (0-100)
                        </label>
                        <input type="number" id="tech" name="tech" min="0" max="100" 
                            value="${interview.technicalScore != null ? interview.technicalScore : 0}" 
                            oninput="updateOverallScore()">
                    </div>
                    <div class="form-group">
                        <label for="comm">
                            <i class="fas fa-comments"></i>
                            Communication (0-100)
                        </label>
                        <input type="number" id="comm" name="comm" min="0" max="100" 
                            value="${interview.communicationScore != null ? interview.communicationScore : 0}"
                            oninput="updateOverallScore()">
                    </div>
                    <div class="form-group">
                        <label for="conf">
                            <i class="fas fa-star"></i>
                            Confidence (0-100)
                        </label>
                        <input type="number" id="conf" name="conf" min="0" max="100" 
                            value="${interview.confidenceScore != null ? interview.confidenceScore : 0}"
                            oninput="updateOverallScore()">
                    </div>
                </div>

                <div class="form-group">
                    <label for="score">
                        <i class="fas fa-trophy"></i>
                        Overall Performance Score
                    </label>
                    <div class="score-input">
                        <input type="number" id="score" name="score" min="0" max="100" 
                            value="${interview.score != null ? interview.score : 0}" required>
                        <span class="score-hint">
                            <i class="fas fa-info-circle"></i>
                            Auto-calculated from sub-scores or set manually
                        </span>
                    </div>
                </div>

                <div class="score-preview" id="scorePreview" style="display: none;">
                    <span class="score-preview-label">
                        <i class="fas fa-calculator"></i>
                        Calculated Average:
                    </span>
                    <span class="score-preview-value" id="calculatedScore">0</span>
                </div>

                <div class="actions">
                    <a href="${pageContext.request.contextPath}/hackerrank/interviewer/dashboard" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                    <button type="submit" class="btn btn-primary" id="submitBtn">
                        <i class="fas fa-check-circle"></i> Save & Complete
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Auto-calculate overall score from sub-scores
        function updateOverallScore() {
            const techScore = parseInt(document.getElementById('tech').value) || 0;
            const commScore = parseInt(document.getElementById('comm').value) || 0;
            const confScore = parseInt(document.getElementById('conf').value) || 0;
            
            const avgScore = Math.round((techScore + commScore + confScore) / 3);
            
            const scoreInput = document.getElementById('score');
            const scorePreview = document.getElementById('scorePreview');
            const calculatedSpan = document.getElementById('calculatedScore');
            
            if (!scoreInput.value || scoreInput.value === '0') {
                scoreInput.value = avgScore;
            }
            
            calculatedSpan.textContent = avgScore;
            scorePreview.style.display = 'flex';
        }

        // Initialize on page load
        document.addEventListener('DOMContentLoaded', function() {
            updateOverallScore();
            
            const form = document.getElementById('evaluationForm');
            const submitBtn = document.getElementById('submitBtn');
            const scoreInputs = document.querySelectorAll('input[type="number"]');
            
            // Validate number inputs
            scoreInputs.forEach(input => {
                input.addEventListener('input', function() {
                    let value = parseInt(this.value);
                    if (value < 0) this.value = 0;
                    if (value > 100) this.value = 100;
                });
            });
            
            // Form submission with loading state
            if (form) {
                form.addEventListener('submit', function(e) {
                    // Validate required fields
                    const feedback = document.getElementById('feedback').value.trim();
                    const overallScore = document.getElementById('score').value;
                    
                    if (!feedback) {
                        e.preventDefault();
                        alert('Please provide detailed feedback before submitting.');
                        return;
                    }
                    
                    if (!overallScore || overallScore < 0 || overallScore > 100) {
                        e.preventDefault();
                        alert('Please provide a valid overall score between 0 and 100.');
                        return;
                    }
                    
                    // Show loading state
                    submitBtn.innerHTML = '<span class="loading-spinner"></span> Saving...';
                    submitBtn.disabled = true;
                });
            }
            
            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                // Ctrl/Cmd + Enter to submit
                if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') {
                    e.preventDefault();
                    if (form) {
                        form.dispatchEvent(new Event('submit'));
                    }
                }
                
                // Escape to cancel/go back
                if (e.key === 'Escape') {
                    const cancelBtn = document.querySelector('.btn-secondary');
                    if (cancelBtn) {
                        window.location.href = cancelBtn.href;
                    }
                }
            });
            
            // Auto-save draft
            let autoSaveTimer;
            const feedbackTextarea = document.getElementById('feedback');
            
            if (feedbackTextarea) {
                // Load saved draft
                const savedDraft = localStorage.getItem('interviewEvalDraft_' + '${interview.id}');
                if (savedDraft && !feedbackTextarea.value) {
                    try {
                        const draft = JSON.parse(savedDraft);
                        feedbackTextarea.value = draft.feedback || '';
                        if (draft.tech) document.getElementById('tech').value = draft.tech;
                        if (draft.comm) document.getElementById('comm').value = draft.comm;
                        if (draft.conf) document.getElementById('conf').value = draft.conf;
                        if (draft.score) document.getElementById('score').value = draft.score;
                        updateOverallScore();
                        console.log('Draft loaded');
                    } catch (e) {
                        console.error('Failed to load draft');
                    }
                }
                
                // Save draft on input
                const saveDraft = () => {
                    clearTimeout(autoSaveTimer);
                    autoSaveTimer = setTimeout(() => {
                        const draft = {
                            feedback: feedbackTextarea.value,
                            tech: document.getElementById('tech').value,
                            comm: document.getElementById('comm').value,
                            conf: document.getElementById('conf').value,
                            score: document.getElementById('score').value,
                            timestamp: new Date().toISOString()
                        };
                        localStorage.setItem('interviewEvalDraft_' + '${interview.id}', JSON.stringify(draft));
                        console.log('Draft saved');
                    }, 1000);
                };
                
                feedbackTextarea.addEventListener('input', saveDraft);
                document.getElementById('tech').addEventListener('input', saveDraft);
                document.getElementById('comm').addEventListener('input', saveDraft);
                document.getElementById('conf').addEventListener('input', saveDraft);
                document.getElementById('score').addEventListener('input', saveDraft);
            }
            
            // Clear draft after successful submission
            if (form) {
                form.addEventListener('submit', function() {
                    localStorage.removeItem('interviewEvalDraft_' + '${interview.id}');
                });
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