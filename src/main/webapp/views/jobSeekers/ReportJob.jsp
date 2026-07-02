<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Report Job | SmartInterview</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --background-light: #f6f9fc;
            --white: #ffffff;
            --box-shadow: rgba(25, 167, 123, 0.15);
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --border-light: #e0e6ed;
            --font-main: "Inter", sans-serif;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            font-family: var(--font-main);
            color: var(--text-primary);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 20px;
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

        .wrapper {
            width: 100%;
            max-width: 560px;
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

        .report-form-container {
            background-color: var(--white);
            padding: 36px 32px;
            border-radius: 24px;
            box-shadow: var(--shadow-md);
            width: 100%;
            border: 1px solid rgba(25, 167, 123, 0.1);
            position: relative;
            overflow: hidden;
        }

        .report-form-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
        }

        .header-icon {
            width: 56px;
            height: 56px;
            background: rgba(25, 167, 123, 0.1);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            border: 1px solid rgba(25, 167, 123, 0.2);
        }

        .header-icon i {
            font-size: 28px;
            color: var(--primary);
        }

        h2 {
            text-align: center;
            margin-bottom: 8px;
            color: var(--text-primary);
            font-weight: 700;
            font-size: 26px;
        }

        .subtitle {
            text-align: center;
            color: var(--text-secondary);
            font-size: 14px;
            margin-bottom: 28px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 14px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 8px;
        }

        label i {
            color: var(--primary);
            margin-right: 6px;
        }

        textarea {
            width: 100%;
            padding: 14px 16px;
            border-radius: 14px;
            border: 2px solid var(--border-light);
            resize: vertical;
            font-size: 14px;
            font-family: var(--font-main);
            background: #f8fafc;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }

        textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25, 167, 123, 0.1);
            background: var(--white);
        }

        textarea::placeholder {
            color: var(--text-secondary);
            opacity: 0.7;
        }

        .char-count {
            text-align: right;
            font-size: 12px;
            color: var(--text-secondary);
            margin-top: 6px;
        }

        .btn-submit {
            width: 100%;
            padding: 14px 20px;
            background: var(--gradient-primary);
            color: var(--white);
            border: none;
            border-radius: 14px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
            box-sizing: border-box;
            margin-top: 28px;
        }

        .btn-submit:hover {
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        .btn-cancel {
            width: 100%;
            padding: 12px 20px;
            background: transparent;
            color: var(--text-secondary);
            border: 1px solid var(--border-light);
            border-radius: 14px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            box-sizing: border-box;
            margin-top: 12px;
            text-decoration: none;
        }

        .btn-cancel:hover {
            background: rgba(25, 167, 123, 0.05);
            border-color: var(--primary);
            color: var(--primary);
        }

        .info-note {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 14px 16px;
            background: rgba(25, 167, 123, 0.05);
            border-radius: 12px;
            margin-bottom: 24px;
            border: 1px solid rgba(25, 167, 123, 0.1);
        }

        .info-note i {
            color: var(--primary);
            font-size: 20px;
        }

        .info-note p {
            font-size: 13px;
            color: var(--text-secondary);
            margin: 0;
        }

        .loading-spinner {
            display: inline-block;
            width: 18px;
            height: 18px;
            border: 2px solid rgba(255,255,255,0.3);
            border-top-color: #fff;
            border-radius: 50%;
            animation: spin 0.6s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Responsive */
        @media (max-width: 576px) {
            .wrapper {
                padding: 0;
            }

            .report-form-container {
                padding: 28px 20px;
                border-radius: 20px;
            }

            h2 {
                font-size: 22px;
            }

            .header-icon {
                width: 48px;
                height: 48px;
            }

            .header-icon i {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
<div class="wrapper">
    <div class="report-form-container">
        <div class="header-icon">
            <i class="fas fa-flag"></i>
        </div>
        <h2>Report This Job</h2>
        <p class="subtitle">Let us know why you're reporting this job posting</p>

        <div class="info-note">
            <i class="fas fa-shield-alt"></i>
            <p>Your report helps keep our job listings safe and trustworthy for everyone.</p>
        </div>

        <form action="${pageContext.request.contextPath}/report-job" method="post" id="reportForm">
            <input type="hidden" name="jobId" value="${jobReport.job.id}" />
            
            <div class="form-group">
                <label><i class="fas fa-exclamation-triangle"></i> Reason for Reporting *</label>
                <textarea name="reason" id="reason" placeholder="Please describe why you're reporting this job (e.g., scam, misleading information, inappropriate content, etc.)" required rows="4" maxlength="1000"></textarea>
                <div class="char-count"><span id="reasonCount">0</span>/1000 characters</div>
            </div>
            
            <div class="form-group">
                <label><i class="fas fa-info-circle"></i> Additional Information (Optional)</label>
                <textarea name="additionalInfo" id="additionalInfo" placeholder="Provide any additional details that might help us investigate" rows="3" maxlength="500"></textarea>
                <div class="char-count"><span id="additionalCount">0</span>/500 characters</div>
            </div>
            
            <button type="submit" class="btn-submit" id="submitBtn">
                <i class="fas fa-paper-plane"></i> Submit Report
            </button>
        </form>

        <a href="javascript:history.back()" class="btn-cancel">
            <i class="fas fa-arrow-left"></i> Cancel
        </a>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const reasonTextarea = document.getElementById('reason');
        const additionalTextarea = document.getElementById('additionalInfo');
        const reasonCount = document.getElementById('reasonCount');
        const additionalCount = document.getElementById('additionalCount');
        const form = document.getElementById('reportForm');
        const submitBtn = document.getElementById('submitBtn');

        // Character count
        if (reasonTextarea && reasonCount) {
            reasonCount.textContent = reasonTextarea.value.length;
            reasonTextarea.addEventListener('input', function() {
                reasonCount.textContent = this.value.length;
            });
        }

        if (additionalTextarea && additionalCount) {
            additionalCount.textContent = additionalTextarea.value.length;
            additionalTextarea.addEventListener('input', function() {
                additionalCount.textContent = this.value.length;
            });
        }

        // Form submission with loading state
        if (form && submitBtn) {
            form.addEventListener('submit', function(e) {
                const reason = reasonTextarea.value.trim();
                if (!reason) {
                    e.preventDefault();
                    alert('Please provide a reason for reporting this job.');
                    return;
                }

                submitBtn.innerHTML = '<span class="loading-spinner"></span> Submitting...';
                submitBtn.disabled = true;
            });
        }

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            // Ctrl+Enter to submit
            if (e.ctrlKey && e.key === 'Enter') {
                const reason = reasonTextarea.value.trim();
                if (reason) {
                    form.dispatchEvent(new Event('submit'));
                }
            }
            
            // Escape to cancel/go back
            if (e.key === 'Escape') {
                window.history.back();
            }
        });

        // Auto-resize textareas
        function autoResize(textarea) {
            textarea.style.height = 'auto';
            textarea.style.height = textarea.scrollHeight + 'px';
        }

        if (reasonTextarea) {
            reasonTextarea.addEventListener('input', function() {
                autoResize(this);
            });
        }

        if (additionalTextarea) {
            additionalTextarea.addEventListener('input', function() {
                autoResize(this);
            });
        }
    });
</script>
</body>
</html>