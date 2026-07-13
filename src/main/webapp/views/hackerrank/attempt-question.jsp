<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${question.title} - SmartInterview Compiler</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- CodeMirror 5 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/codemirror.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/theme/dracula.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/hint/show-hint.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/fold/foldgutter.min.css">
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.85);
            --text-tertiary: rgba(255, 255, 255, 0.5);
            --border-color: rgba(255, 255, 255, 0.08);
            --card-bg: rgba(46, 62, 65, 0.6);
            --hover-bg: rgba(25, 167, 123, 0.15);
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --gradient-dark: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-darker) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.15);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.2);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.3);
            --glow-primary: 0 0 30px rgba(25, 167, 123, 0.2);
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--gradient-dark);
            color: var(--text-primary);
            min-height: 100vh;
            overflow: hidden;
            position: relative;
        }

        /* Animated background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.08) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: backgroundPulse 15s ease-in-out infinite;
        }

        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        /* ===== TOP NAVBAR ===== */
        .top-navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 20px;
            height: 56px;
            background: rgba(26, 42, 44, 0.95);
            border-bottom: 1px solid var(--border-color);
            backdrop-filter: blur(20px);
            z-index: 200;
            position: relative;
        }
        .nav-left {
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .nav-left .back-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            color: var(--accent);
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            padding: 8px 14px;
            border-radius: 30px;
            background: var(--hover-bg);
            border: 1px solid rgba(25, 167, 123, 0.2);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .nav-left .back-btn:hover {
            background: var(--primary);
            color: white;
            transform: translateX(-4px);
            box-shadow: var(--glow-primary);
        }
        .nav-title {
            font-size: 16px;
            font-weight: 700;
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            max-width: 400px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .nav-center {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .lang-selector {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .lang-selector label {
            font-size: 12px;
            color: var(--text-tertiary);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }
        .lang-selector select {
            padding: 8px 36px 8px 14px;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 30px;
            color: var(--text-primary);
            font-size: 13px;
            font-family: 'Inter', sans-serif;
            font-weight: 500;
            cursor: pointer;
            outline: none;
            appearance: none;
            backdrop-filter: blur(10px);
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%2319A77B' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpath d='M6 9l6 6 6-6'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            transition: all 0.3s ease;
        }
        .lang-selector select:hover {
            border-color: var(--primary);
        }
        .lang-selector select:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }
        .lang-selector select option {
            background: var(--bg-darker);
            color: var(--text-primary);
        }
        .nav-right {
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .timer-badge {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 16px;
            background: rgba(251, 191, 36, 0.08);
            border: 1px solid rgba(251, 191, 36, 0.2);
            border-radius: 30px;
            font-size: 13px;
            color: #fbbf24;
            backdrop-filter: blur(10px);
        }
        .timer-badge i { font-size: 12px; }
        .timer-badge span {
            font-family: 'JetBrains Mono', monospace;
            font-weight: 600;
        }

        .timer-badge.warning {
            background: rgba(239, 68, 68, 0.1);
            border-color: rgba(239, 68, 68, 0.3);
            color: #ef4444;
            animation: pulse-timer 1s infinite;
        }
        @keyframes pulse-timer {
            0% { opacity: 1; }
            50% { opacity: 0.7; }
            100% { opacity: 1; }
        }

        /* ===== MAIN LAYOUT ===== */
        .ide-container {
            display: flex;
            height: calc(100vh - 56px);
            position: relative;
            z-index: 1;
        }

        /* ===== LEFT PANEL - PROBLEM ===== */
        .problem-panel {
            width: 38%;
            min-width: 320px;
            background: rgba(26, 42, 44, 0.7);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }
        .panel-tabs {
            display: flex;
            border-bottom: 1px solid var(--border-color);
            background: rgba(26, 42, 44, 0.9);
            padding: 0 4px;
        }
        .panel-tab {
            padding: 14px 24px;
            font-size: 13px;
            font-weight: 600;
            color: var(--text-tertiary);
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 8px;
            position: relative;
        }
        .panel-tab i {
            font-size: 14px;
        }
        .panel-tab:hover { 
            color: var(--text-secondary);
            background: var(--hover-bg);
        }
        .panel-tab.active {
            color: var(--primary);
            border-bottom-color: var(--primary);
        }
        .panel-tab.active::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            right: 0;
            height: 2px;
            background: var(--gradient-primary);
        }
        .panel-content {
            flex: 1;
            overflow-y: auto;
            padding: 28px;
        }
        .panel-content::-webkit-scrollbar { width: 6px; }
        .panel-content::-webkit-scrollbar-track { background: transparent; }
        .panel-content::-webkit-scrollbar-thumb { 
            background: var(--primary);
            border-radius: 3px;
            opacity: 0.5;
        }

        .tab-pane { display: none; }
        .tab-pane.active { 
            display: block;
            animation: fadeIn 0.4s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .problem-title {
            font-size: 24px;
            font-weight: 800;
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 16px;
            line-height: 1.3;
        }
        .problem-meta {
            display: flex;
            gap: 10px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }
        .meta-badge {
            padding: 5px 14px;
            border-radius: 30px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            backdrop-filter: blur(10px);
        }
        .badge-easy { 
            background: rgba(16, 185, 129, 0.12); 
            color: #4ade80; 
            border: 1px solid rgba(16, 185, 129, 0.3); 
        }
        .badge-medium { 
            background: rgba(245, 158, 11, 0.12); 
            color: #fbbf24; 
            border: 1px solid rgba(245, 158, 11, 0.3); 
        }
        .badge-hard { 
            background: rgba(239, 68, 68, 0.12); 
            color: #f87171; 
            border: 1px solid rgba(239, 68, 68, 0.3); 
        }
        .badge-cat { 
            background: rgba(25, 167, 123, 0.12); 
            color: var(--accent); 
            border: 1px solid rgba(25, 167, 123, 0.3); 
        }

        .problem-section {
            margin-bottom: 28px;
        }
        .problem-section h3 {
            font-size: 15px;
            font-weight: 700;
            color: var(--accent);
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .problem-section h3 i {
            font-size: 14px;
            color: var(--primary);
        }
        .problem-desc {
            font-size: 14px;
            color: var(--text-secondary);
            line-height: 1.8;
            white-space: pre-wrap;
        }
        .sample-block {
            background: rgba(26, 42, 44, 0.6);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            overflow: hidden;
            backdrop-filter: blur(10px);
        }
        .sample-block-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 16px;
            background: rgba(25, 167, 123, 0.05);
            border-bottom: 1px solid var(--border-color);
        }
        .sample-block-header span {
            font-size: 11px;
            font-weight: 700;
            color: var(--text-tertiary);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .copy-btn {
            background: none;
            border: none;
            color: var(--text-tertiary);
            cursor: pointer;
            font-size: 12px;
            padding: 6px 10px;
            border-radius: 6px;
            transition: all 0.3s ease;
        }
        .copy-btn:hover { 
            color: var(--primary); 
            background: var(--hover-bg);
        }
        .sample-block pre {
            padding: 16px;
            font-family: 'JetBrains Mono', monospace;
            font-size: 13px;
            color: var(--accent);
            white-space: pre-wrap;
            line-height: 1.7;
        }

        /* ===== RESIZE HANDLE ===== */
        .resize-handle {
            width: 5px;
            background: transparent;
            cursor: col-resize;
            position: relative;
            z-index: 10;
            transition: background 0.3s;
        }
        .resize-handle:hover,
        .resize-handle.active {
            background: var(--primary);
        }

        /* ===== RIGHT PANEL - EDITOR + OUTPUT ===== */
        .editor-panel {
            flex: 1;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            background: var(--bg-darker);
        }

        /* Editor toolbar */
        .editor-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
            background: rgba(26, 42, 44, 0.9);
            border-bottom: 1px solid var(--border-color);
            backdrop-filter: blur(10px);
        }
        .toolbar-left {
            display: flex;
            align-items: center;
            gap: 14px;
        }
        .toolbar-left .file-tab {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 6px 16px;
            background: var(--hover-bg);
            border: 1px solid var(--border-color);
            border-radius: 30px;
            font-size: 12px;
            font-weight: 500;
            color: var(--text-secondary);
        }
        .toolbar-left .file-tab i { color: var(--primary); font-size: 12px; }
        .toolbar-actions {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .tool-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 18px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 600;
            cursor: pointer;
            border: none;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-family: 'Inter', sans-serif;
        }
        .btn-reset {
            background: transparent;
            color: var(--text-secondary);
            border: 1px solid var(--border-color);
        }
        .btn-reset:hover {
            background: var(--hover-bg);
            border-color: var(--primary);
            color: var(--primary);
            transform: translateY(-2px);
        }
        .btn-run {
            background: var(--gradient-primary);
            color: #fff;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }
        .btn-run:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }
        .btn-run:active { transform: translateY(0); }
        .btn-run.loading {
            opacity: 0.7;
            pointer-events: none;
        }
        .btn-run .spinner {
            display: none;
            width: 14px;
            height: 14px;
            border: 2px solid rgba(255,255,255,0.3);
            border-top-color: #fff;
            border-radius: 50%;
            animation: spin 0.6s linear infinite;
        }
        .btn-run.loading .spinner { display: block; }
        .btn-run.loading .run-icon { display: none; }

        @keyframes spin { to { transform: rotate(360deg); } }

        .btn-submit-code {
            background: linear-gradient(135deg, var(--primary-dark), var(--primary));
            color: #fff;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }
        .btn-submit-code:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        /* CodeMirror overrides */
        .editor-wrapper {
            flex: 1;
            overflow: hidden;
            position: relative;
        }
        .CodeMirror {
            height: 100% !important;
            font-family: 'JetBrains Mono', monospace !important;
            font-size: 14px !important;
            line-height: 1.7 !important;
            background: var(--bg-darker) !important;
        }
        .CodeMirror-gutters {
            background: var(--bg-darker) !important;
            border-right: 1px solid var(--border-color) !important;
        }
        .CodeMirror-linenumber {
            color: rgba(255,255,255,0.2) !important;
            padding: 0 8px 0 14px !important;
        }
        .CodeMirror-cursor {
            border-left: 2px solid var(--primary) !important;
        }
        .CodeMirror-selected {
            background: rgba(25, 167, 123, 0.2) !important;
        }
        .CodeMirror-activeline-background {
            background: rgba(25, 167, 123, 0.05) !important;
        }
        .cm-s-dracula .CodeMirror-activeline-background {
            background: rgba(25, 167, 123, 0.05) !important;
        }
        .CodeMirror-matchingbracket {
            color: var(--accent) !important;
            font-weight: 700;
            border-bottom: 1px solid var(--accent);
        }

        /* ===== OUTPUT PANEL ===== */
        .output-resize-handle {
            height: 5px;
            background: transparent;
            cursor: row-resize;
            transition: background 0.3s;
        }
        .output-resize-handle:hover,
        .output-resize-handle.active {
            background: var(--primary);
        }
        .output-panel {
            height: 220px;
            min-height: 100px;
            display: flex;
            flex-direction: column;
            border-top: 1px solid var(--border-color);
            background: rgba(26, 42, 44, 0.95);
            backdrop-filter: blur(20px);
        }
        .output-tabs {
            display: flex;
            align-items: center;
            background: rgba(26, 42, 44, 0.9);
            border-bottom: 1px solid var(--border-color);
        }
        .output-tab {
            padding: 12px 20px;
            font-size: 12px;
            font-weight: 600;
            color: var(--text-tertiary);
            cursor: pointer;
            border-bottom: 2px solid transparent;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .output-tab:hover { 
            color: var(--text-secondary);
            background: var(--hover-bg);
        }
        .output-tab.active {
            color: var(--primary);
            border-bottom-color: var(--primary);
        }
        .output-tab .status-dot {
            display: inline-block;
            width: 8px;
            height: 8px;
            border-radius: 50%;
            margin-left: 6px;
        }
        .status-dot.success { 
            background: var(--success); 
            box-shadow: 0 0 8px rgba(16, 185, 129, 0.5);
        }
        .status-dot.error { 
            background: var(--danger); 
            box-shadow: 0 0 8px rgba(239, 68, 68, 0.5);
        }
        .output-body {
            flex: 1;
            overflow-y: auto;
            padding: 16px 20px;
        }
        .output-body::-webkit-scrollbar { width: 6px; }
        .output-body::-webkit-scrollbar-track { background: transparent; }
        .output-body::-webkit-scrollbar-thumb { 
            background: var(--primary);
            border-radius: 3px;
        }

        .output-content { display: none; }
        .output-content.active { 
            display: block;
            animation: fadeIn 0.3s ease-out;
        }

        .output-text {
            font-family: 'JetBrains Mono', monospace;
            font-size: 13px;
            line-height: 1.7;
            white-space: pre-wrap;
            word-break: break-all;
        }
        .output-text.stdout { color: var(--accent); }
        .output-text.stderr { color: #f87171; }

        .output-placeholder {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100%;
            color: var(--text-tertiary);
            gap: 10px;
        }
        .output-placeholder i { 
            font-size: 32px; 
            color: var(--primary);
            opacity: 0.3;
        }
        .output-placeholder span { font-size: 13px; }

        .stdin-area {
            width: 100%;
            min-height: 100px;
            background: rgba(26, 42, 44, 0.6);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 14px;
            color: var(--accent);
            font-family: 'JetBrains Mono', monospace;
            font-size: 13px;
            resize: vertical;
            outline: none;
            line-height: 1.7;
            backdrop-filter: blur(10px);
        }
        .stdin-area:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }
        .stdin-area::placeholder {
            color: var(--text-tertiary);
        }

        /* Execution result banner */
        .exec-result {
            display: none;
            align-items: center;
            gap: 12px;
            padding: 12px 18px;
            margin-bottom: 14px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 500;
            backdrop-filter: blur(10px);
        }
        .exec-result.show { display: flex; }
        .exec-result.pass {
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: #4ade80;
        }
        .exec-result.fail {
            background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.3);
            color: #f87171;
        }
        .exec-result i { font-size: 16px; }
        .exec-time {
            margin-left: auto;
            font-size: 12px;
            color: var(--text-tertiary);
            font-family: 'JetBrains Mono', monospace;
        }

        /* ===== LIGHT MODE ===== */
        body.light-mode {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%) !important;
            color: #1e293b !important;
        }
        body.light-mode::before {
            background: 
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.05) 0%, transparent 50%);
        }
        body.light-mode .top-navbar {
            background: rgba(255,255,255,0.95) !important;
            border-bottom-color: rgba(0,0,0,0.08) !important;
        }
        body.light-mode .nav-title { 
            color: var(--primary) !important;
            -webkit-text-fill-color: var(--primary) !important;
        }
        body.light-mode .lang-selector select {
            background: rgba(241,245,249,0.9) !important;
            border-color: rgba(0,0,0,0.1) !important;
            color: #1e293b !important;
        }
        body.light-mode .lang-selector select option {
            background: #ffffff !important;
            color: #1e293b !important;
        }
        body.light-mode .lang-selector label {
            color: #475569 !important;
        }
        body.light-mode .timer-badge {
            background: rgba(217, 119, 6, 0.08) !important;
            border-color: rgba(217, 119, 6, 0.2) !important;
            color: #b45309 !important;
        }
        body.light-mode .timer-badge i {
            color: #b45309 !important;
        }
        body.light-mode .problem-panel {
            background: rgba(255,255,255,0.8) !important;
            border-right-color: rgba(0,0,0,0.08) !important;
        }
        body.light-mode .panel-tabs { background: rgba(248,250,252,0.95) !important; }
        body.light-mode .panel-tab { color: #64748b !important; }
        body.light-mode .panel-tab.active { color: var(--primary) !important; }
        body.light-mode .problem-title { 
            color: var(--primary) !important;
            -webkit-text-fill-color: var(--primary) !important;
            background-clip: text;
        }
        body.light-mode .problem-desc { color: #475569 !important; }
        body.light-mode .problem-section h3 { color: var(--primary) !important; }
        body.light-mode .sample-block {
            background: rgba(241,245,249,0.8) !important;
            border-color: rgba(0,0,0,0.08) !important;
        }
        body.light-mode .sample-block pre { color: var(--primary-dark) !important; }
        body.light-mode .editor-panel { background: #fafbfc !important; }
        body.light-mode .editor-toolbar {
            background: rgba(248,250,252,0.95) !important;
            border-bottom-color: rgba(0,0,0,0.06) !important;
        }
        body.light-mode .CodeMirror { background: #fafbfc !important; }
        body.light-mode .CodeMirror-gutters {
            background: #fafbfc !important;
            border-right-color: rgba(0,0,0,0.06) !important;
        }
        body.light-mode .output-panel { background: rgba(248,250,252,0.95) !important; }
        body.light-mode .output-tab { color: #64748b !important; }
        body.light-mode .output-tab.active { color: var(--primary) !important; }
        body.light-mode .output-text.stdout { color: var(--primary) !important; }
        body.light-mode .stdin-area {
            background: rgba(241,245,249,0.8) !important;
            border-color: rgba(0,0,0,0.1) !important;
            color: var(--primary-dark) !important;
        }
        body.light-mode .theme-toggle-label { color: #64748b !important; }
        body.light-mode .toolbar-left .file-tab {
            color: #334155 !important;
            background: rgba(0, 0, 0, 0.04) !important;
            border-color: rgba(0, 0, 0, 0.08) !important;
        }
        body.light-mode .sample-block-header span {
            color: #475569 !important;
        }

        /* Theme toggle */
        .theme-toggle-wrapper {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .theme-toggle-label {
            font-size: 11px;
            font-weight: 500;
            color: var(--text-tertiary);
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .theme-toggle {
            position: relative;
            width: 48px;
            height: 26px;
            background: rgba(25, 167, 123, 0.2);
            border: 1px solid rgba(25, 167, 123, 0.3);
            border-radius: 30px;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4,0,0.2,1);
            display: flex;
            align-items: center;
            padding: 0 3px;
        }
        .theme-toggle:hover { 
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }
        .theme-toggle .toggle-thumb {
            width: 20px;
            height: 20px;
            background: var(--gradient-primary);
            border-radius: 50%;
            transition: all 0.4s cubic-bezier(0.4,0,0.2,1);
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 2px 8px rgba(25, 167, 123, 0.4);
        }
        .theme-toggle .toggle-thumb i { font-size: 10px; color: #fff; transition: transform 0.4s ease; }
        .theme-toggle.light .toggle-thumb {
            transform: translateX(22px);
            background: linear-gradient(135deg, #f59e0b, #f97316);
            box-shadow: 0 2px 8px rgba(245,158,11,0.4);
        }
        .theme-toggle.light .toggle-thumb i { transform: rotate(180deg); }
        .theme-toggle.light {
            background: rgba(245,158,11,0.15);
            border-color: rgba(245,158,11,0.4);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .ide-container { flex-direction: column; }
            .problem-panel { width: 100% !important; max-height: 40vh; }
            .resize-handle { display: none; }
        }

        /* ===== ANTI-CHEAT OVERLAY ===== */
        .violation-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: var(--bg-darker);
            z-index: 9999;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 40px;
        }
        .violation-overlay.active { display: flex; }
        .violation-card {
            background: var(--card-bg);
            border: 1px solid rgba(239, 68, 68, 0.3);
            border-radius: 28px;
            padding: 48px;
            max-width: 500px;
            box-shadow: var(--shadow-lg);
            backdrop-filter: blur(20px);
        }
        .violation-icon {
            font-size: 72px;
            color: var(--danger);
            margin-bottom: 24px;
            animation: pulse-red 2s infinite;
        }
        @keyframes pulse-red {
            0% { transform: scale(1); opacity: 1; text-shadow: 0 0 0 rgba(239, 68, 68, 0); }
            50% { transform: scale(1.1); opacity: 0.8; text-shadow: 0 0 20px rgba(239, 68, 68, 0.5); }
            100% { transform: scale(1); opacity: 1; text-shadow: 0 0 0 rgba(239, 68, 68, 0); }
        }
        .violation-title {
            font-size: 28px;
            font-weight: 800;
            color: var(--text-primary);
            margin-bottom: 16px;
        }
        .violation-message {
            font-size: 16px;
            color: var(--text-secondary);
            line-height: 1.6;
            margin-bottom: 32px;
        }
        .violation-btn {
            background: var(--danger);
            color: #fff;
            padding: 14px 36px;
            border-radius: 30px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }
        .violation-btn:hover { 
            background: #dc2626; 
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* ===== WARNING MODAL ===== */
        .warning-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: rgba(26, 42, 44, 0.95);
            z-index: 10000;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(8px);
        }
        .warning-overlay.active { display: flex; }
        .warning-card {
            background: var(--card-bg);
            border: 2px solid var(--warning);
            border-radius: 24px;
            padding: 36px;
            max-width: 420px;
            text-align: center;
            box-shadow: var(--shadow-lg);
            backdrop-filter: blur(20px);
        }
        .warning-icon { font-size: 52px; color: var(--warning); margin-bottom: 20px; }
        .warning-title { font-size: 22px; font-weight: 700; color: var(--text-primary); margin-bottom: 12px; }
        .warning-text { color: var(--text-secondary); font-size: 14px; margin-bottom: 24px; line-height: 1.5; }
        .warning-btn {
            background: var(--warning);
            color: #000;
            padding: 12px 28px;
            border-radius: 30px;
            font-weight: 700;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .warning-btn:hover { 
            background: #f59e0b; 
            transform: scale(1.05);
        }
    </style>
</head>

<body>
    <!-- ANTI-CHEAT OVERLAYS -->
    <div id="warningOverlay" class="warning-overlay">
        <div class="warning-card">
            <div class="warning-icon"><i class="fas fa-exclamation-circle"></i></div>
            <h2 class="warning-title">Violation Warning!</h2>
            <p class="warning-text" id="warningMessage"></p>
            <p style="color: var(--warning); font-weight: 700; margin-bottom: 20px; font-size: 12px; text-transform: uppercase; letter-spacing: 1px;">
                Warnings Remaining: <span id="warningsRemaining">2</span>
            </p>
            <button class="warning-btn" onclick="closeWarning()">I Understand</button>
        </div>
    </div>

    <div id="violationOverlay" class="violation-overlay">
        <div class="violation-card">
            <div class="violation-icon"><i class="fas fa-exclamation-triangle"></i></div>
            <h1 class="violation-title">Exam Terminated</h1>
            <p class="violation-message" id="violationMessage">
                Suspicious activity detected (switching tabs or copying). Your exam has been ended to ensure academic integrity.
            </p>
            <button class="violation-btn" onclick="location.href='${pageContext.request.contextPath}/hackerrank/student/dashboard'">Return to Dashboard</button>
        </div>
    </div>

    <!-- TOP NAVBAR -->
    <div class="top-navbar">
        <div class="nav-left">
            <a href="${pageContext.request.contextPath}/hackerrank/student/coding-practice" class="back-btn"><i class="fas fa-arrow-left"></i> Back</a>
            <span class="nav-title">${question.title}</span>
            <c:if test="${savedAnswer != null}">
                <span id="solvedBadge" style="display:inline-flex; align-items:center; gap:6px; padding:5px 14px; border-radius:30px; font-size:11px; font-weight:700; letter-spacing:0.5px;
                      background:${savedAnswer.isCorrect ? 'rgba(16,185,129,0.15)' : 'rgba(239,68,68,0.12)'};
                      color:${savedAnswer.isCorrect ? '#4ade80' : '#f87171'};
                      border:1px solid ${savedAnswer.isCorrect ? 'rgba(16,185,129,0.3)' : 'rgba(239,68,68,0.3)'}; text-transform:uppercase;">
                    <i class="fas ${savedAnswer.isCorrect ? 'fa-check-circle' : 'fa-times-circle'}"></i>
                    ${savedAnswer.isCorrect ? 'Solved' : 'Attempted'}
                </span>
            </c:if>
        </div>
        <div class="nav-center">
            <div class="lang-selector">
                <label>Language</label>
                <select id="languageSelect" onchange="changeLanguage()">
                    <option value="java" data-version="15.0.2" data-ext="java" data-mime="text/x-java">Java</option>
                    <option value="python" data-version="3.10.0" data-ext="py" data-mime="text/x-python">Python 3</option>
                    <option value="c" data-version="10.2.0" data-ext="c" data-mime="text/x-csrc">C</option>
                    <option value="c++" data-version="10.2.0" data-ext="cpp" data-mime="text/x-c++src">C++</option>
                    <option value="javascript" data-version="18.15.0" data-ext="js" data-mime="text/javascript">JavaScript</option>
                </select>
            </div>
        </div>
        <div class="nav-right">
            <div class="timer-badge">
                <i class="fas fa-clock"></i>
                <span id="timerDisplay">00:00</span>
            </div>
            <div class="theme-toggle-wrapper">
                <span class="theme-toggle-label">Theme</span>
                <div class="theme-toggle" id="themeToggle" onclick="toggleTheme()" title="Toggle light/dark mode">
                    <div class="toggle-thumb"><i class="fas fa-moon"></i></div>
                </div>
            </div>
        </div>
    </div>

    <!-- MAIN IDE LAYOUT -->
    <div class="ide-container">
        <!-- LEFT: Problem Description -->
        <div class="problem-panel" id="problemPanel">
            <div class="panel-tabs">
                <div class="panel-tab active" data-tab="description" onclick="switchPanelTab(this, 'description')">
                    <i class="fas fa-file-alt"></i> Description
                </div>
                <div class="panel-tab" data-tab="solution" onclick="switchPanelTab(this, 'solution')">
                    <i class="fas fa-lightbulb"></i> Hints
                </div>
            </div>
            <div class="panel-content">
                <!-- Description Tab -->
                <div class="tab-pane active" id="tab-description" style="display:block;">
                    <h1 class="problem-title">${question.title}</h1>
                    <div class="problem-meta">
                        <span class="meta-badge badge-${question.difficulty == 'EASY' ? 'easy' : question.difficulty == 'MEDIUM' ? 'medium' : 'hard'}">${question.difficulty}</span>
                        <c:if test="${not empty question.categoryName}">
                            <span class="meta-badge badge-cat">${question.categoryName}</span>
                        </c:if>
                    </div>

                    <div class="problem-section">
                        <h3><i class="fas fa-align-left"></i> Problem Statement</h3>
                        <div class="problem-desc">${question.description}</div>
                    </div>

                    <c:if test="${not empty question.sampleInput}">
                        <div class="problem-section">
                            <h3><i class="fas fa-sign-in-alt"></i> Sample Input</h3>
                            <div class="sample-block">
                                <div class="sample-block-header">
                                    <span>Input</span>
                                    <button class="copy-btn" onclick="copyToClipboard(this, '${question.sampleInput}')" title="Copy"><i class="fas fa-copy"></i></button>
                                </div>
                                <pre>${question.sampleInput}</pre>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty question.sampleOutput}">
                        <div class="problem-section">
                            <h3><i class="fas fa-sign-out-alt"></i> Expected Output</h3>
                            <div class="sample-block">
                                <div class="sample-block-header">
                                    <span>Output</span>
                                    <button class="copy-btn" onclick="copyToClipboard(this, '${question.sampleOutput}')" title="Copy"><i class="fas fa-copy"></i></button>
                                </div>
                                <pre>${question.sampleOutput}</pre>
                            </div>
                        </div>
                    </c:if>

                    <c:if test="${not empty question.constraintsInfo}">
                        <div class="problem-section">
                            <h3><i class="fas fa-exclamation-triangle"></i> Constraints</h3>
                            <div class="problem-desc">${question.constraintsInfo}</div>
                        </div>
                    </c:if>
                </div>

                <!-- Hints Tab -->
                <div class="tab-pane" id="tab-solution">
                    <div class="problem-section">
                        <h3><i class="fas fa-lightbulb"></i> Approach Hints</h3>
                        <div class="problem-desc" style="color: var(--text-tertiary);">
                            Think about the problem step by step:
                            <br><br>
                            1. Understand the input format and constraints
                            <br>2. Identify the pattern or algorithm needed
                            <br>3. Consider edge cases
                            <br>4. Test with sample inputs before submitting
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- RESIZE HANDLE -->
        <div class="resize-handle" id="resizeHandle"></div>

        <!-- RIGHT: Code Editor + Output -->
        <div class="editor-panel">
            <!-- Editor Toolbar -->
            <div class="editor-toolbar">
                <div class="toolbar-left">
                    <div class="file-tab">
                        <i class="fas fa-file-code"></i>
                        <span id="fileTabName">Main.java</span>
                    </div>
                </div>
                <div class="toolbar-actions">
                    <button class="tool-btn btn-reset" onclick="resetCode()" title="Reset to template">
                        <i class="fas fa-undo"></i> Reset
                    </button>
                    <button class="tool-btn btn-run" id="runBtn" onclick="runCode()" title="Run code (Ctrl+Enter)">
                        <div class="spinner"></div>
                        <i class="fas fa-play run-icon"></i> <span class="run-icon">Run Code</span>
                    </button>
                    <button class="tool-btn btn-submit-code" onclick="submitCode()" title="Submit solution">
                        <i class="fas fa-paper-plane"></i> Submit
                    </button>
                </div>
            </div>

            <!-- Code Editor -->
            <div class="editor-wrapper">
                <textarea id="codeEditor"></textarea>
            </div>

            <!-- Output Resize Handle -->
            <div class="output-resize-handle" id="outputResizeHandle"></div>

            <!-- Output Panel -->
            <div class="output-panel" id="outputPanel">
                <div class="output-tabs">
                    <div class="output-tab active" data-out="output" onclick="switchOutputTab(this, 'output')">
                        Output <span class="status-dot" id="outputStatusDot" style="display:none;"></span>
                    </div>
                    <div class="output-tab" data-out="input" onclick="switchOutputTab(this, 'input')">
                        Custom Input
                    </div>
                </div>
                <div class="output-body">
                    <!-- Output Tab -->
                    <div class="output-content active" id="out-output" style="display:block;">
                        <div class="exec-result" id="execResult">
                            <i></i>
                            <span></span>
                            <span class="exec-time" id="execTime"></span>
                        </div>
                        <div id="outputArea">
                            <div class="output-placeholder">
                                <i class="fas fa-terminal"></i>
                                <span>Run your code to see output here</span>
                            </div>
                        </div>
                    </div>
                    <!-- Custom Input Tab -->
                    <div class="output-content" id="out-input">
                        <textarea class="stdin-area" id="stdinInput" placeholder="Enter custom input here (stdin)..."></textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Hidden form for submit -->
    <form id="submitForm" action="${pageContext.request.contextPath}/hackerrank/student/submit-answer" method="post" style="display:none;">
        <input type="hidden" name="questionId" value="${question.id}">
        <input type="hidden" name="questionType" value="CODING">
        <input type="hidden" name="timeTaken" id="timeTakenInput" value="0">
        <input type="hidden" name="answer" id="answerInput">
        <input type="hidden" name="language" id="languageInput" value="java">
        <input type="hidden" name="submissionStatus" id="submissionStatusInput" value="NORMAL">
    </form>
    
    <textarea id="hiddenSampleInput" style="display:none;">${question.sampleInput}</textarea>

    <%-- Hidden element carrying the previously submitted code (empty if never submitted) --%>
    <textarea id="savedAnswerCode" style="display:none;"><c:out value="${savedAnswer.answer}" escapeXml="false"/></textarea>
    <input type="hidden" id="savedAnswerCorrect" value="${savedAnswer != null ? savedAnswer.isCorrect : 'false'}">

    <!-- CodeMirror JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/codemirror.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/mode/clike/clike.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/mode/python/python.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/mode/javascript/javascript.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/edit/matchbrackets.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/edit/closebrackets.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/selection/active-line.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/fold/foldcode.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/fold/foldgutter.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/fold/brace-fold.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.65.16/addon/fold/indent-fold.min.js"></script>

    <script>
        // === BOILERPLATE TEMPLATES ===
        const templates = {
            'java': 'import java.util.*;\n\nclass Main {\n    public static void main(String[] args) {\n        Scanner sc = new Scanner(System.in);\n        \n        // Write your solution here\n        \n        sc.close();\n    }\n}',
            'python': '# Write your solution here\n\nimport sys\n\ndef solve():\n    # Read input\n    \n    # Your logic here\n    pass\n\nsolve()',
            'c': '#include <stdio.h>\n#include <stdlib.h>\n\nint main() {\n    // Write your solution here\n    \n    return 0;\n}',
            'c++': '#include <iostream>\n#include <vector>\n#include <algorithm>\nusing namespace std;\n\nint main() {\n    ios_base::sync_with_stdio(false);\n    cin.tie(NULL);\n    \n    // Write your solution here\n    \n    return 0;\n}',
            'javascript': '// Write your solution here\nconst readline = require("readline");\nconst rl = readline.createInterface({ input: process.stdin });\n\nconst lines = [];\nrl.on("line", (line) => lines.push(line));\nrl.on("close", () => {\n    // Your logic here\n    \n});'
        };

        const fileNames = {
            'java': 'Main.java',
            'python': 'solution.py',
            'c': 'solution.c',
            'c++': 'solution.cpp',
            'javascript': 'solution.js'
        };

        const mimeTypes = {
            'java': 'text/x-java',
            'python': 'text/x-python',
            'c': 'text/x-csrc',
            'c++': 'text/x-c++src',
            'javascript': 'text/javascript'
        };

        // === INIT CODEMIRROR ===
        let editor = CodeMirror.fromTextArea(document.getElementById('codeEditor'), {
            mode: 'text/x-java',
            theme: 'dracula',
            lineNumbers: true,
            matchBrackets: true,
            autoCloseBrackets: true,
            styleActiveLine: true,
            indentUnit: 4,
            indentWithTabs: false,
            tabSize: 4,
            lineWrapping: false,
            foldGutter: true,
            gutters: ["CodeMirror-linenumber", "CodeMirror-foldgutter"],
            extraKeys: {
                "Ctrl-Enter": function() { runCode(); },
                "Cmd-Enter": function() { runCode(); },
                "Tab": function(cm) {
                    if (cm.somethingSelected()) {
                        cm.indentSelection("add");
                    } else {
                        cm.replaceSelection("    ", "end");
                    }
                }
            }
        });

        // === RESTRICT EDITOR ACTIONS ===
        const editorWrapper = editor.getWrapperElement();
        ['copy', 'cut', 'paste', 'drop'].forEach(evt => {
            editorWrapper.addEventListener(evt, e => {
                e.preventDefault();
                e.stopPropagation();
                if (window.handleViolation) {
                    window.handleViolation('Copying, pasting, or cutting code is not allowed during the coding assessment.');
                }
            }, true);
        });
        ['dragenter', 'dragover', 'contextmenu'].forEach(evt => {
            editorWrapper.addEventListener(evt, e => {
                e.preventDefault();
                e.stopPropagation();
            }, true);
        });

        // === RESTORE SAVED ANSWER OR USE TEMPLATE ===
        (function initEditorContent() {
            const savedCode = document.getElementById('savedAnswerCode').value.trim();
            if (savedCode) {
                // Detect language from first line or saved code patterns
                let lang = 'java';
                if (savedCode.includes('def ') || savedCode.startsWith('import sys') || savedCode.startsWith('# ')) lang = 'python';
                else if (savedCode.includes('#include <iostream>') || savedCode.includes('using namespace std')) lang = 'c++';
                else if (savedCode.includes('#include <stdio.h>') && !savedCode.includes('using namespace')) lang = 'c';
                else if (savedCode.includes('require("readline")') || savedCode.includes('const readline')) lang = 'javascript';

                const sel = document.getElementById('languageSelect');
                sel.value = lang;
                editor.setOption('mode', mimeTypes[lang]);
                document.getElementById('fileTabName').textContent = fileNames[lang];
                editor.setValue(savedCode);

                // Show a banner that previous solution was loaded
                const outputArea = document.getElementById('outputArea');
                const isCorrect = document.getElementById('savedAnswerCorrect').value === 'true';
                outputArea.innerHTML = '<div style="display:flex;align-items:center;gap:10px;padding:12px 16px;border-radius:10px;margin-bottom:8px;background:' +
                    (isCorrect ? 'rgba(16,185,129,0.08);border:1px solid rgba(16,185,129,0.2);color:#4ade80' : 'rgba(239,68,68,0.08);border:1px solid rgba(239,68,68,0.2);color:#f87171') +
                    '"><i class="fas ' + (isCorrect ? 'fa-check-circle' : 'fa-history') + '"></i><span style="font-size:13px;font-weight:600;">' +
                    (isCorrect ? 'Previous correct solution loaded — you can re-submit or edit.' : 'Previous attempt loaded — keep working on it!') +
                    '</span></div>';
            } else {
                editor.setValue(templates['java']);
            }
        })();

        // === LANGUAGE CHANGE ===
        function changeLanguage() {
            const sel = document.getElementById('languageSelect');
            const lang = sel.value;
            const mime = mimeTypes[lang];
            editor.setOption('mode', mime);
            editor.setValue(templates[lang]);
            document.getElementById('fileTabName').textContent = fileNames[lang];
            updateEditorTheme();
        }

        function updateEditorTheme() {
            const isLight = document.body.classList.contains('light-mode');
            editor.setOption('theme', isLight ? 'default' : 'dracula');
        }

        // === RUN CODE ===
        async function runCode() {
            const runBtn = document.getElementById('runBtn');
            if (runBtn.classList.contains('loading')) return;

            runBtn.classList.add('loading');

            const sel = document.getElementById('languageSelect');
            const opt = sel.options[sel.selectedIndex];
            const language = sel.value;
            const version = opt.getAttribute('data-version');
            const code = editor.getValue();
            let stdin = document.getElementById('stdinInput').value;
            
            // Fallback to sample input if custom input is empty
            if (!stdin.trim()) {
                const hiddenSample = document.getElementById('hiddenSampleInput');
                if (hiddenSample && hiddenSample.value) {
                    stdin = hiddenSample.value;
                }
            }

            switchOutputTab(document.querySelector('[data-out="output"]'), 'output');

            const outputArea = document.getElementById('outputArea');
            outputArea.innerHTML = '<div class="output-text stdout" style="color: var(--text-tertiary);"><i class="fas fa-spinner fa-spin"></i> Compiling and running...</div>';

            const execResult = document.getElementById('execResult');
            execResult.classList.remove('show', 'pass', 'fail');

            const startTime = performance.now();

            try {
                const response = await fetch('/hackerrank/student/run-code', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ language, version, code, stdin })
                });

                const data = await response.json();
                const elapsed = ((performance.now() - startTime) / 1000).toFixed(2);

                const statusDot = document.getElementById('outputStatusDot');
                statusDot.style.display = 'inline-block';

                if (data.success) {
                    const output = data.output || '(No output)';
                    const stderr = data.stderr || '';
                    const exitCode = data.exitCode || 0;

                    let html = '';
                    if (exitCode !== 0 || stderr) {
                        statusDot.className = 'status-dot error';
                        if (stderr) {
                            html += '<div class="output-text stderr">' + escapeHtml(stderr) + '</div>';
                        }
                        if (output && output !== stderr) {
                            html += '<div class="output-text stdout">' + escapeHtml(output) + '</div>';
                        }
                        execResult.classList.add('show', 'fail');
                        execResult.querySelector('i').className = 'fas fa-times-circle';
                        execResult.querySelector('span:not(.exec-time)').textContent = 'Runtime Error (Exit Code: ' + exitCode + ')';
                    } else {
                        statusDot.className = 'status-dot success';
                        html = '<div class="output-text stdout">' + escapeHtml(output) + '</div>';
                        execResult.classList.add('show', 'pass');
                        execResult.querySelector('i').className = 'fas fa-check-circle';
                        execResult.querySelector('span:not(.exec-time)').textContent = 'Executed Successfully';
                    }
                    document.getElementById('execTime').textContent = elapsed + 's';
                    outputArea.innerHTML = html;
                } else {
                    statusDot.className = 'status-dot error';
                    outputArea.innerHTML = '<div class="output-text stderr">' + escapeHtml(data.error || 'Unknown error') + '</div>';
                    execResult.classList.add('show', 'fail');
                    execResult.querySelector('i').className = 'fas fa-exclamation-triangle';
                    execResult.querySelector('span:not(.exec-time)').textContent = 'Execution Failed';
                    document.getElementById('execTime').textContent = elapsed + 's';
                }
            } catch (err) {
                const statusDot = document.getElementById('outputStatusDot');
                statusDot.className = 'status-dot error';
                statusDot.style.display = 'inline-block';
                outputArea.innerHTML = '<div class="output-text stderr">Network error: ' + escapeHtml(err.message) + '</div>';
            } finally {
                runBtn.classList.remove('loading');
            }
        }

        function escapeHtml(str) {
            const div = document.createElement('div');
            div.textContent = str;
            return div.innerHTML;
        }

        // === SUBMIT CODE ===
        function submitCode(status = 'NORMAL') {
            document.getElementById('answerInput').value = editor.getValue();
            document.getElementById('timeTakenInput').value = timeElapsed;
            document.getElementById('languageInput').value = document.getElementById('languageSelect').value;
            document.getElementById('submissionStatusInput').value = status;
            document.getElementById('submitForm').submit();
        }

        // === RESET CODE ===
        function resetCode() {
            const lang = document.getElementById('languageSelect').value;
            editor.setValue(templates[lang]);
        }

        // === TABS ===
        function switchPanelTab(el, tabId) {
            document.querySelectorAll('.panel-tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-pane').forEach(t => t.classList.remove('active'));
            el.classList.add('active');
            document.getElementById('tab-' + tabId).classList.add('active');
        }

        function switchOutputTab(el, tabId) {
            document.querySelectorAll('.output-tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.output-content').forEach(t => t.classList.remove('active'));
            el.classList.add('active');
            document.getElementById('out-' + tabId).classList.add('active');
        }

        // === COPY TO CLIPBOARD ===
        function copyToClipboard(btn, text) {
            navigator.clipboard.writeText(text).then(() => {
                const orig = btn.innerHTML;
                btn.innerHTML = '<i class="fas fa-check"></i>';
                btn.style.color = 'var(--success)';
                setTimeout(() => { btn.innerHTML = orig; btn.style.color = ''; }, 1500);
            });
        }

        // === TIMER ===
        let totalSeconds = 1800; // 30 minutes
        let timeElapsed = 0;
        
        let timer = setInterval(function () {
            if (totalSeconds <= 0) {
                clearInterval(timer);
                submitCode('TIMEOUT');
                return;
            }

            totalSeconds--;
            timeElapsed++;

            let mins = Math.floor(totalSeconds / 60);
            let secs = totalSeconds % 60;
            
            const display = document.getElementById('timerDisplay');
            display.textContent = (mins < 10 ? '0' : '') + mins + ':' + (secs < 10 ? '0' : '') + secs;

            if (totalSeconds < 300) {
                document.querySelector('.timer-badge').classList.add('warning');
            }
        }, 1000);

        // === ANTI-CHEAT LOGIC ===
        (function() {
            let isTerminated = false;
            const questionId = '${question.id}';
            const storageKey = 'examWarningCount_' + questionId;
            let warningCount = parseInt(sessionStorage.getItem(storageKey) || '0', 10);
            const maxWarnings = 3;

            window.closeWarning = function() {
                document.getElementById('warningOverlay').classList.remove('active');
            };

            window.handleViolation = function(reason) {
                if (isTerminated) return;

                warningCount++;
                sessionStorage.setItem(storageKey, warningCount);
                const remaining = maxWarnings - warningCount;

                if (warningCount < maxWarnings) {
                    document.querySelector('#warningOverlay .warning-title').innerText = 'Warning ' + warningCount + ' of ' + maxWarnings;
                    
                    let displayReason = reason;
                    if (warningCount === 2) {
                        displayReason = 'You have violated the coding assessment rules again. Another violation will end your session.';
                    }
                    
                    document.getElementById('warningMessage').innerText = displayReason;
                    document.getElementById('warningsRemaining').innerText = remaining;
                    document.getElementById('warningOverlay').classList.add('active');
                    console.warn(`Violation ${warningCount}/${maxWarnings}: ${reason}`);
                } else {
                    terminateExam('You have exceeded the maximum number of violations. Your coding session has been terminated.');
                }
            };

            function terminateExam(reason) {
                if (isTerminated) return;
                isTerminated = true;
                
                clearInterval(timer);
                
                const vTitle = document.querySelector('#violationOverlay .violation-title');
                if (vTitle) vTitle.innerText = 'Warning 3 of 3';
                
                document.getElementById('violationMessage').innerText = reason;
                document.getElementById('violationOverlay').classList.add('active');
                document.getElementById('warningOverlay').classList.remove('active');
                
                // Disable editor and run button
                if (typeof editor !== 'undefined') {
                    editor.setOption('readOnly', 'nocursor');
                }
                const runBtn = document.getElementById('runBtn');
                if (runBtn) {
                    runBtn.disabled = true;
                    runBtn.style.opacity = '0.5';
                    runBtn.style.pointerEvents = 'none';
                }
                
                // Submit the code
                submitCode('TERMINATED');
                
                console.error('Exam terminated due to repeated violations: ' + reason);
                
                // Countdown redirect
                let redirectTimer = 5;
                const btn = document.querySelector('#violationOverlay .violation-btn');
                if (btn) {
                    btn.innerText = 'Redirecting in ' + redirectTimer + 's...';
                    btn.onclick = function(e) { e.preventDefault(); };
                }
                
                setInterval(() => {
                    redirectTimer--;
                    if (redirectTimer <= 0) {
                        location.href = '${pageContext.request.contextPath}/hackerrank/student/coding-practice';
                    } else if (btn) {
                        btn.innerText = 'Redirecting in ' + redirectTimer + 's...';
                    }
                }, 1000);
            }

            // Check if already terminated on load
            if (warningCount >= maxWarnings) {
                terminateExam('You have exceeded the maximum number of violations. Your coding session has been terminated.');
            }
        })();

        // === RESIZE PANELS ===
        (function () {
            const handle = document.getElementById('resizeHandle');
            const problemPanel = document.getElementById('problemPanel');
            let isResizing = false;

            handle.addEventListener('mousedown', function (e) {
                isResizing = true;
                handle.classList.add('active');
                document.body.style.cursor = 'col-resize';
                document.body.style.userSelect = 'none';
                e.preventDefault();
            });

            document.addEventListener('mousemove', function (e) {
                if (!isResizing) return;
                const containerRect = document.querySelector('.ide-container').getBoundingClientRect();
                let newWidth = e.clientX - containerRect.left;
                newWidth = Math.max(280, Math.min(newWidth, containerRect.width - 400));
                problemPanel.style.width = newWidth + 'px';
            });

            document.addEventListener('mouseup', function () {
                if (isResizing) {
                    isResizing = false;
                    handle.classList.remove('active');
                    document.body.style.cursor = '';
                    document.body.style.userSelect = '';
                    editor.refresh();
                }
            });
        })();

        // === OUTPUT PANEL RESIZE ===
        (function () {
            const handle = document.getElementById('outputResizeHandle');
            const outputPanel = document.getElementById('outputPanel');
            const editorPanel = document.querySelector('.editor-panel');
            let isResizing = false;

            handle.addEventListener('mousedown', function (e) {
                isResizing = true;
                handle.classList.add('active');
                document.body.style.cursor = 'row-resize';
                document.body.style.userSelect = 'none';
                e.preventDefault();
            });

            document.addEventListener('mousemove', function (e) {
                if (!isResizing) return;
                const panelRect = editorPanel.getBoundingClientRect();
                let newHeight = panelRect.bottom - e.clientY;
                newHeight = Math.max(100, Math.min(newHeight, panelRect.height - 200));
                outputPanel.style.height = newHeight + 'px';
            });

            document.addEventListener('mouseup', function () {
                if (isResizing) {
                    isResizing = false;
                    handle.classList.remove('active');
                    document.body.style.cursor = '';
                    document.body.style.userSelect = '';
                    editor.refresh();
                }
            });
        })();

        // === THEME TOGGLE ===
        function toggleTheme() {
            const body = document.body;
            const toggle = document.getElementById('themeToggle');
            const icon = toggle.querySelector('i');
            const isLight = body.classList.toggle('light-mode');
            toggle.classList.toggle('light', isLight);
            icon.className = isLight ? 'fas fa-sun' : 'fas fa-moon';
            localStorage.setItem('compilerTheme', isLight ? 'light' : 'dark');
            updateEditorTheme();
        }

        (function () {
            const saved = localStorage.getItem('compilerTheme');
            if (saved !== 'dark') {
                document.body.classList.add('light-mode');
                const toggle = document.getElementById('themeToggle');
                if (toggle) {
                    toggle.classList.add('light');
                    toggle.querySelector('i').className = 'fas fa-sun';
                }
                updateEditorTheme();
            }
        })();

        window.addEventListener('resize', function() {
            editor.refresh();
        });
    </script>
</body>
</html>
