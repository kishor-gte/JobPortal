<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Competition Rules | ${competition.title}</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #2563eb;
            --bg-main: #0f172a;
            --bg-surface: #1e293b;
            --text-main: #f8fafc;
            --text-secondary: #94a3b8;
            --border: #334155;
            --radius-lg: 20px;
            --gradient-primary: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Outfit', sans-serif; }
        body { background-color: var(--bg-main); color: var(--text-main); display: flex; justify-content: center; align-items: center; min-height: 100vh; padding: 20px; }

        .rules-container {
            background: var(--bg-surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            width: 100%;
            max-width: 800px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }

        .header { text-align: center; margin-bottom: 30px; border-bottom: 1px solid var(--border); padding-bottom: 20px; }
        .header h1 { font-size: 28px; color: var(--primary); margin-bottom: 10px; }
        .header p { color: var(--text-secondary); }

        .rules-section { margin-bottom: 24px; }
        .rules-section h3 { font-size: 18px; color: #fff; margin-bottom: 12px; display: flex; align-items: center; gap: 8px; }
        .rules-section h3 i { color: var(--primary); }
        .rules-section p { color: var(--text-secondary); line-height: 1.6; font-size: 15px; }
        
        .rules-list { list-style: none; }
        .rules-list li { margin-bottom: 10px; color: var(--text-secondary); display: flex; gap: 10px; }
        .rules-list li i { color: var(--primary); margin-top: 4px; font-size: 14px; }

        .security-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-top: 10px; }
        .security-item { background: rgba(0,0,0,0.2); padding: 12px 16px; border-radius: 8px; border: 1px solid rgba(255,255,255,0.05); font-size: 14px; color: var(--text-secondary); display: flex; align-items: center; gap: 10px; }
        .security-item i { color: #ef4444; }
        .security-item i.fa-check-circle { color: #19A77B; }

        .agreement { margin-top: 40px; padding: 20px; background: rgba(59, 130, 246, 0.1); border: 1px solid rgba(59, 130, 246, 0.2); border-radius: 12px; display: flex; align-items: center; gap: 12px; }
        .agreement input[type="checkbox"] { width: 20px; height: 20px; accent-color: var(--primary); cursor: pointer; }
        .agreement label { font-size: 15px; font-weight: 500; cursor: pointer; user-select: none; }

        .btn-start {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 16px 32px;
            border-radius: 12px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            margin-top: 24px;
            transition: all 0.3s ease;
            opacity: 0.5;
            pointer-events: none;
        }

        .btn-start.enabled {
            opacity: 1;
            pointer-events: auto;
        }
        
        .btn-start.enabled:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px -10px rgba(37, 99, 235, 0.5);
        }
        
        body.light-mode {
            --bg-main: #f8fafc;
            --bg-surface: #ffffff;
            --text-main: #0f172a;
            --border: #e2e8f0;
        }
        body.light-mode .rules-section h3 { color: #0f172a; }
        body.light-mode .security-item { background: #f1f5f9; border-color: #cbd5e1; color: #475569; }
    </style>
</head>
<body>
    <div class="rules-container">
        <div class="header">
            <h1><i class="fas fa-clipboard-list"></i> ${competition.title}</h1>
            <p>Please read all instructions carefully before starting the exam.</p>
        </div>

        <div class="rules-section">
            <h3><i class="fas fa-info-circle"></i> General Information</h3>
            <div class="security-grid">
                <div class="security-item"><i class="fas fa-clock" style="color:var(--primary)"></i> Duration: ${competition.examDurationMinutes} Minutes</div>
                <div class="security-item"><i class="fas fa-file-code" style="color:var(--primary)"></i> Questions: ${competition.numberOfQuestions}</div>
                <div class="security-item"><i class="fas fa-language" style="color:var(--primary)"></i> Allowed: ${competition.allowedLanguages}</div>
                <div class="security-item"><i class="fas fa-layer-group" style="color:var(--primary)"></i> Difficulty: ${competition.difficulty}</div>
            </div>
        </div>

        <div class="rules-section">
            <h3><i class="fas fa-scroll"></i> Competition Rules</h3>
            <p style="white-space: pre-line;">${competition.rules}</p>
        </div>

        <div class="rules-section">
            <h3><i class="fas fa-shield-alt"></i> Security Measures</h3>
            <p style="margin-bottom: 12px;">This is a proctored environment. The following restrictions are in place:</p>
            <div class="security-grid">
                <c:if test="${competition.disableCopyPaste}">
                    <div class="security-item"><i class="fas fa-ban"></i> Copy/Paste Disabled</div>
                </c:if>
                <c:if test="${competition.disableRightClick}">
                    <div class="security-item"><i class="fas fa-mouse"></i> Right Click Disabled</div>
                </c:if>
                <c:if test="${competition.fullScreenMode}">
                    <div class="security-item"><i class="fas fa-expand"></i> Full Screen Enforced</div>
                </c:if>
                <c:if test="${competition.autoSubmitTabSwitch}">
                    <div class="security-item"><i class="fas fa-window-restore"></i> Tab Switching Monitored</div>
                </c:if>
            </div>
        </div>

        <div class="agreement">
            <input type="checkbox" id="agreeCheckbox" onchange="toggleStartBtn()">
            <label for="agreeCheckbox">I have read and agree to all the competition rules and security policies.</label>
        </div>

        <!-- Routes to Exam Environment -->
        <a href="${pageContext.request.contextPath}/student/coding-competitions/${competition.id}/start" class="btn-start" id="startBtn" style="display: block; text-align: center; text-decoration: none;">
            Start Exam Now <i class="fas fa-arrow-right" style="margin-left: 8px;"></i>
        </a>
        
        <div style="text-align: center; margin-top: 16px;">
            <a href="${pageContext.request.contextPath}/student/coding-competitions" style="color: var(--text-secondary); text-decoration: none; font-size: 14px;">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
        </div>
    </div>

    <script>
        if (localStorage.getItem('theme') !== 'dark' && document.body.classList) {
            document.body.classList.add('light-mode');
        }

        function toggleStartBtn() {
            const cb = document.getElementById('agreeCheckbox');
            const btn = document.getElementById('startBtn');
            if (cb.checked) {
                btn.classList.add('enabled');
            } else {
                btn.classList.remove('enabled');
            }
        }
    </script>
</body>
</html>
