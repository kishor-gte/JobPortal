<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Company Dashboard - SmartInterview</title>
    <meta name="description" content="Company dashboard to post jobs, view applicants, shortlist candidates and schedule interviews.">
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
            --purple: #8b5cf6;
            --orange: #f97316;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        body {
            font-family: 'Inter', sans-serif;
            background: var(--gradient-dark);
            color: var(--text-primary);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
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
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.08) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, rgba(25, 167, 123, 0.05) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: backgroundPulse 15s ease-in-out infinite;
        }

        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }

        /* Sidebar */
        .sidebar {
            position: fixed; left: 0; top: 0; width: 280px; height: 100vh;
            background: rgba(26, 42, 44, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            padding: 24px 16px; z-index: 100; overflow-y: auto;
            box-shadow: var(--shadow-lg);
        }
        
        .sidebar::-webkit-scrollbar { width: 6px; }
        .sidebar::-webkit-scrollbar-track { background: transparent; }
        .sidebar::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 3px; }

        .sidebar-logo {
            display: flex; align-items: center; gap: 14px;
            padding: 8px 12px 24px; border-bottom: 1px solid var(--border-color); margin-bottom: 24px;
        }
        .sidebar-logo .icon {
            width: 48px; height: 48px;
            background: var(--gradient-primary);
            border-radius: 14px; display: flex; align-items: center; justify-content: center;
            box-shadow: var(--glow-primary);
            animation: logoGlow 3s ease-in-out infinite;
        }
        
        @keyframes logoGlow {
            0%, 100% { box-shadow: 0 0 20px rgba(25, 167, 123, 0.3); }
            50% { box-shadow: 0 0 30px rgba(25, 167, 123, 0.5); }
        }
        
        .sidebar-logo .icon i { color: #fff; font-size: 24px; }
        .sidebar-logo h2 { 
            font-size: 20px; font-weight: 700; 
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        .sidebar-logo span { font-size: 11px; color: var(--text-tertiary); display: block; }

        .nav-section { margin-bottom: 28px; }
        .nav-section h4 {
            color: var(--text-tertiary); font-size: 11px;
            text-transform: uppercase; letter-spacing: 1.5px; padding: 0 12px; margin-bottom: 14px;
            font-weight: 600;
        }
        .nav-link {
            display: flex; align-items: center; gap: 14px; padding: 12px 14px;
            border-radius: 12px; color: var(--text-secondary); text-decoration: none;
            font-size: 14px; font-weight: 500; transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1); 
            margin-bottom: 4px; position: relative; overflow: hidden;
        }
        .nav-link i { width: 20px; text-align: center; font-size: 16px; transition: transform 0.3s ease; }
        
        .nav-link::before {
            content: ''; position: absolute; left: 0; top: 0; bottom: 0; width: 3px;
            background: var(--gradient-primary); transform: translateX(-100%);
            transition: transform 0.3s ease;
        }
        
        .nav-link:hover { 
            background: var(--hover-bg); 
            color: var(--primary); 
            transform: translateX(4px); 
        }
        .nav-link:hover i { transform: scale(1.1); }
        .nav-link:hover::before { transform: translateX(0); }
        
        .nav-link.active {
            background: var(--hover-bg); color: var(--primary);
            box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.1);
        }
        .nav-link.active::before { transform: translateX(0); }
        .nav-link.active i { color: var(--primary); }
        
        .nav-badge {
            margin-left: auto; padding: 3px 10px; border-radius: 20px;
            background: var(--hover-bg); color: var(--primary);
            font-size: 11px; font-weight: 700; border: 1px solid var(--primary);
        }

        /* Main Content */
        .main-content { 
            margin-left: 280px; padding: 28px 36px; 
            position: relative; z-index: 1;
            animation: fadeInUp 0.6s ease-out;
        }
        
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .top-bar {
            display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px;
        }
        .top-bar h1 {
            font-size: 32px; font-weight: 800;
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text; display: flex; align-items: center; gap: 12px;
        }
        .top-bar-actions { display: flex; align-items: center; gap: 16px; }
        
        .user-avatar {
            width: 44px; height: 44px;
            background: var(--gradient-primary);
            border-radius: 14px; display: flex; align-items: center; justify-content: center;
            color: #fff; font-weight: 700; font-size: 18px;
            box-shadow: var(--glow-primary);
        }
        
        .btn-logout {
            padding: 10px 20px; background: rgba(239, 68, 68, 0.1);
            border: 1px solid rgba(239, 68, 68, 0.2); color: #fca5a5;
            border-radius: 30px; text-decoration: none; font-size: 13px; 
            font-weight: 500; transition: all 0.3s ease; display: flex; align-items: center; gap: 8px;
        }
        .btn-logout:hover { 
            background: rgba(239, 68, 68, 0.2); 
            border-color: var(--danger);
            transform: translateY(-2px);
        }
        
        .btn-post-job {
            padding: 12px 24px; background: var(--gradient-primary);
            color: #fff; border: none; border-radius: 30px; font-size: 14px;
            font-weight: 600; cursor: pointer; transition: all 0.3s ease;
            display: flex; align-items: center; gap: 8px;
            box-shadow: 0 4px 14px rgba(25, 167, 123, 0.3);
        }
        .btn-post-job:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 8px 24px rgba(25, 167, 123, 0.4); 
        }

        /* Alert */
        .alert {
            padding: 16px 20px; border-radius: 16px; margin-bottom: 24px;
            font-size: 14px; display: flex; align-items: center; gap: 12px;
            backdrop-filter: blur(10px);
            animation: slideDown 0.4s ease-out;
        }
        @keyframes slideDown { 
            from { opacity: 0; transform: translateY(-10px); } 
            to { opacity: 1; transform: translateY(0); } 
        }
        .alert-success { 
            background: rgba(16, 185, 129, 0.1); 
            border: 1px solid rgba(16, 185, 129, 0.3); 
            color: #4ade80; 
        }
        .alert-error { 
            background: rgba(239, 68, 68, 0.1); 
            border: 1px solid rgba(239, 68, 68, 0.3); 
            color: #fca5a5; 
        }

        /* Stats Grid */
        .stats-grid {
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 32px;
        }
        .stat-card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 20px; padding: 26px;
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative; overflow: hidden;
            animation: cardAppear 0.5s ease-out forwards; opacity: 0;
        }
        
        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }
        
        @keyframes cardAppear { to { opacity: 1; transform: translateY(0); } }
        
        .stat-card::before {
            content: ''; position: absolute; top: 0; left: 0; right: 0; height: 4px;
            background: var(--gradient-primary); transform: translateX(-100%);
            transition: transform 0.5s ease;
        }
        
        .stat-card:hover {
            transform: translateY(-6px);
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }
        .stat-card:hover::before { transform: translateX(0); }
        
        .stat-icon {
            width: 56px; height: 56px; border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            margin-bottom: 18px; font-size: 26px;
        }
        .stat-icon.green { background: var(--hover-bg); color: var(--primary); border: 1px solid var(--primary); }
        .stat-icon.blue { background: rgba(59, 130, 246, 0.15); color: #60a5fa; border: 1px solid #3b82f6; }
        .stat-icon.purple { background: rgba(139, 92, 246, 0.15); color: #a78bfa; border: 1px solid #8b5cf6; }
        .stat-icon.orange { background: rgba(249, 115, 22, 0.15); color: #fb923c; border: 1px solid #f97316; }
        
        .stat-value { 
            font-size: 38px; font-weight: 800; 
            background: linear-gradient(135deg, #fff, var(--accent));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text; margin-bottom: 6px;
        }
        .stat-label { color: var(--text-tertiary); font-size: 13px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }

        /* Cards */
        .card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px; padding: 28px;
            transition: all 0.3s ease;
            animation: slideIn 0.5s ease-out forwards; opacity: 0;
        }
        
        @keyframes slideIn {
            from { opacity: 0; transform: translateX(-20px); }
            to { opacity: 1; transform: translateX(0); }
        }
        
        .card:hover { 
            border-color: var(--primary); 
            box-shadow: var(--shadow-lg), var(--glow-primary); 
        }
        
        .card-header {
            display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;
        }
        .card-header h3 {
            font-size: 20px; font-weight: 700; color: var(--text-primary);
            display: flex; align-items: center; gap: 12px;
        }
        .card-header h3 i { color: var(--primary); }
        .card-header a {
            color: var(--accent); text-decoration: none; font-size: 13px; font-weight: 600;
            transition: all 0.3s ease; display: flex; align-items: center; gap: 6px;
        }
        .card-header a:hover { color: var(--primary); transform: translateX(4px); }

        /* Job List Items */
        .job-item {
            padding: 20px;
            background: rgba(26, 42, 44, 0.4);
            border: 1px solid var(--border-color);
            border-radius: 16px; margin-bottom: 14px;
            transition: all 0.3s ease;
        }
        .job-item:hover {
            border-color: var(--primary);
            background: var(--hover-bg);
            transform: translateX(4px);
        }
        .job-item-top { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px; }
        .job-item h4 { font-size: 16px; color: var(--text-primary); margin-bottom: 6px; font-weight: 600; }
        .job-item .meta { 
            font-size: 12px; color: var(--text-tertiary); 
            display: flex; gap: 16px; flex-wrap: wrap; 
        }
        .job-item .meta span { display: flex; align-items: center; gap: 6px; }
        .job-item .meta i { color: var(--primary); }
        .job-item-actions { display: flex; gap: 8px; align-items: center; }

        .badge {
            padding: 5px 12px; border-radius: 20px; font-size: 11px; font-weight: 600;
            text-transform: uppercase; letter-spacing: 0.3px;
        }
        .badge-active { background: rgba(16, 185, 129, 0.12); color: #4ade80; border: 1px solid rgba(16, 185, 129, 0.3); }
        .badge-closed { background: rgba(239, 68, 68, 0.12); color: #f87171; border: 1px solid rgba(239, 68, 68, 0.3); }
        .badge-draft { background: rgba(245, 158, 11, 0.12); color: #fbbf24; border: 1px solid rgba(245, 158, 11, 0.3); }

        .btn-sm {
            padding: 8px 14px; border-radius: 30px; font-size: 11px;
            font-weight: 600; cursor: pointer; border: none; transition: all 0.3s ease;
            text-decoration: none; display: inline-flex; align-items: center; gap: 6px;
            backdrop-filter: blur(10px);
        }
        .btn-sm-green { background: var(--hover-bg); color: var(--primary); border: 1px solid var(--primary); }
        .btn-sm-green:hover { background: var(--primary); color: #fff; }
        .btn-sm-blue { background: rgba(59, 130, 246, 0.15); color: #60a5fa; border: 1px solid #3b82f6; }
        .btn-sm-blue:hover { background: #3b82f6; color: #fff; }
        .btn-sm-red { background: rgba(239, 68, 68, 0.12); color: #f87171; border: 1px solid #ef4444; }
        .btn-sm-red:hover { background: #ef4444; color: #fff; }
        .btn-sm-orange { background: rgba(249, 115, 22, 0.12); color: #fb923c; border: 1px solid #f97316; }
        .btn-sm-orange:hover { background: #f97316; color: #fff; }
        .btn-sm-purple { background: rgba(139, 92, 246, 0.12); color: #a78bfa; border: 1px solid #8b5cf6; }
        .btn-sm-purple:hover { background: #8b5cf6; color: #fff; }

        /* Applicant Items */
        .applicant-item {
            padding: 20px;
            background: rgba(26, 42, 44, 0.4);
            border: 1px solid var(--border-color);
            border-radius: 16px; margin-bottom: 14px;
            transition: all 0.3s ease;
        }
        .applicant-item:hover {
            border-color: var(--primary);
            transform: translateX(4px);
        }
        .applicant-top { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px; }
        .applicant-info h4 { font-size: 16px; color: var(--text-primary); margin-bottom: 4px; }
        .applicant-info p { font-size: 12px; color: var(--text-tertiary); }
        .applicant-score {
            display: flex; flex-direction: column; align-items: center; gap: 6px;
        }
        .score-circle {
            width: 56px; height: 56px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 18px; font-weight: 800; color: #fff;
            position: relative;
        }
        .score-circle::after { content: '%'; font-size: 11px; font-weight: 600; margin-left: 2px; }
        .score-high { background: linear-gradient(135deg, var(--primary), var(--accent)); border: 2px solid var(--accent); }
        .score-medium { background: linear-gradient(135deg, #f97316, #fb923c); border: 2px solid #fb923c; }
        .score-low { background: linear-gradient(135deg, #ef4444, #f87171); border: 2px solid #f87171; }
        .score-label { font-size: 10px; color: var(--text-tertiary); font-weight: 600; text-transform: uppercase; }

        .applicant-details {
            display: flex; gap: 14px; margin-bottom: 14px; flex-wrap: wrap;
        }
        .applicant-detail { 
            font-size: 12px; color: var(--text-tertiary); 
            display: flex; align-items: center; gap: 6px; 
        }
        .applicant-detail i { color: var(--primary); }
        .applicant-actions { display: flex; gap: 8px; flex-wrap: wrap; }

        .status-badge {
            display: inline-block; padding: 5px 14px; border-radius: 20px;
            font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.3px;
        }
        .status-applied { background: rgba(59, 130, 246, 0.15); color: #60a5fa; border: 1px solid #3b82f6; }
        .status-viewed { background: rgba(139, 92, 246, 0.15); color: #c084fc; border: 1px solid #8b5cf6; }
        .status-shortlisted { background: rgba(25, 167, 123, 0.15); color: var(--primary); border: 1px solid var(--primary); }
        .status-interview { background: rgba(245, 158, 11, 0.15); color: #fbbf24; border: 1px solid #f59e0b; }
        .status-rejected { background: rgba(239, 68, 68, 0.15); color: #f87171; border: 1px solid #ef4444; }
        .status-hired { background: rgba(16, 185, 129, 0.15); color: #4ade80; border: 1px solid #10b981; }

        .suggestions-box {
            margin-top: 14px; padding: 16px;
            background: rgba(25, 167, 123, 0.05);
            border: 1px solid var(--border-color);
            border-radius: 14px; font-size: 12px; color: var(--text-secondary);
            line-height: 1.7; white-space: pre-line;
            backdrop-filter: blur(10px);
        }

        .empty-state {
            text-align: center; padding: 60px 30px; color: var(--text-tertiary);
        }
        .empty-state i { 
            font-size: 56px; margin-bottom: 16px; display: block; 
            color: var(--primary); opacity: 0.3;
            animation: float 3s ease-in-out infinite;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        .empty-state h4 { font-size: 18px; color: var(--text-primary); margin-bottom: 8px; }

        .full-width { grid-column: 1 / -1; }

        /* Post Job Modal */
        .modal-overlay {
            display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(26, 42, 44, 0.8); backdrop-filter: blur(8px);
            z-index: 1000; align-items: center; justify-content: center;
        }
        .modal-overlay.active { display: flex; }
        .modal {
            background: var(--bg-darker); border: 1px solid var(--border-color);
            border-radius: 28px; padding: 36px; width: 620px; max-width: 92vw;
            max-height: 90vh; overflow-y: auto;
            box-shadow: var(--shadow-lg);
            animation: modalSlideUp 0.4s ease-out;
        }
        @keyframes modalSlideUp { 
            from { opacity: 0; transform: translateY(20px); } 
            to { opacity: 1; transform: translateY(0); } 
        }
        .modal h3 {
            font-size: 24px; font-weight: 700; color: var(--text-primary); margin-bottom: 8px;
            display: flex; align-items: center; gap: 12px;
        }
        .modal h3 i { color: var(--primary); }
        .modal > p { font-size: 14px; color: var(--text-tertiary); margin-bottom: 28px; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label {
            display: block; font-size: 13px; color: var(--text-secondary);
            margin-bottom: 8px; font-weight: 500;
        }
        .form-input {
            width: 100%; background: var(--card-bg);
            border: 1px solid var(--border-color); border-radius: 14px;
            padding: 14px 18px; color: var(--text-primary); font-size: 14px;
            font-family: 'Inter', sans-serif; transition: all 0.3s ease;
        }
        .form-input:focus { 
            outline: none; border-color: var(--primary); 
            box-shadow: var(--glow-primary); 
        }
        .form-input::placeholder { color: var(--text-tertiary); }
        textarea.form-input { resize: vertical; min-height: 100px; }
        select.form-input { cursor: pointer; }
        select.form-input option { background: var(--bg-darker); color: var(--text-primary); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 18px; }

        .modal-actions {
            display: flex; gap: 14px; justify-content: flex-end; margin-top: 28px;
            padding-top: 24px; border-top: 1px solid var(--border-color);
        }
        .btn-cancel {
            padding: 12px 24px; background: transparent;
            border: 1px solid var(--border-color); color: var(--text-tertiary);
            border-radius: 30px; font-size: 14px; cursor: pointer; transition: all 0.3s ease;
        }
        .btn-cancel:hover { background: var(--hover-bg); border-color: var(--primary); color: var(--primary); }
        .btn-submit {
            padding: 12px 32px; background: var(--gradient-primary);
            color: #fff; border: none; border-radius: 30px; font-size: 14px;
            font-weight: 600; cursor: pointer; transition: all 0.3s ease;
            display: flex; align-items: center; gap: 10px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }
        .btn-submit:hover { 
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }

        /* Tabs */
        .tab-container { margin-bottom: 24px; }
        .tabs {
            display: flex; gap: 6px; background: var(--card-bg);
            border-radius: 16px; padding: 6px; border: 1px solid var(--border-color);
            backdrop-filter: blur(10px);
        }
        .tab {
            padding: 12px 24px; border-radius: 12px; font-size: 14px;
            font-weight: 600; cursor: pointer; color: var(--text-tertiary);
            transition: all 0.3s ease; border: none; background: none;
            display: flex; align-items: center; gap: 8px;
        }
        .tab i { font-size: 14px; }
        .tab.active { 
            background: var(--gradient-primary); 
            color: #fff; 
            box-shadow: var(--glow-primary);
        }
        .tab:hover:not(.active) { color: var(--primary); background: var(--hover-bg); }
        .tab-panel { display: none; }
        .tab-panel.active { display: block; animation: fadeIn 0.4s ease-out; }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        /* Theme Toggle */
        .theme-toggle {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            color: var(--text-secondary);
            width: 44px; height: 44px;
            border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        .theme-toggle:hover { 
            background: var(--hover-bg); 
            border-color: var(--primary); 
            color: var(--primary); 
            transform: translateY(-2px);
        }

        /* Light Mode */
        body.light-mode {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%) !important;
            color: #1e293b !important;
        }
        body.light-mode::before {
            background: 
                radial-gradient(circle at 20% 80%, rgba(25, 167, 123, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(59, 196, 154, 0.05) 0%, transparent 50%);
        }
        body.light-mode .sidebar {
            background: rgba(255, 255, 255, 0.95) !important;
            border-right-color: #e2e8f0 !important;
        }
        body.light-mode .sidebar-logo h2 { 
            color: var(--primary) !important;
            -webkit-text-fill-color: var(--primary) !important;
        }
        body.light-mode .nav-link { color: #475569 !important; }
        body.light-mode .nav-link:hover { background: var(--hover-bg) !important; color: var(--primary) !important; }
        body.light-mode .nav-link.active { background: var(--hover-bg) !important; color: var(--primary) !important; }
        body.light-mode .stat-card, 
        body.light-mode .card, 
        body.light-mode .modal {
            background: rgba(255, 255, 255, 0.9) !important;
            border-color: #e2e8f0 !important;
        }
        body.light-mode .stat-value { 
            color: var(--primary) !important;
            -webkit-text-fill-color: var(--primary) !important;
        }
        body.light-mode .stat-label { color: #64748b !important; }
        body.light-mode .card-header h3 { color: #1e293b !important; }
        body.light-mode .job-item, 
        body.light-mode .applicant-item {
            background: #f8fafc !important;
            border-color: #e2e8f0 !important;
        }
        body.light-mode .job-item h4, 
        body.light-mode .applicant-info h4 { color: #1e293b !important; }
        body.light-mode .job-item .meta, 
        body.light-mode .applicant-info p { color: #64748b !important; }
        body.light-mode .tabs { background: #e2e8f0 !important; }
        body.light-mode .tab { color: #475569 !important; }
        body.light-mode .tab.active { background: var(--gradient-primary) !important; color: #fff !important; }
        body.light-mode .form-input {
            background: #ffffff !important;
            border-color: #cbd5e1 !important;
            color: #1e293b !important;
        }
        body.light-mode .form-group label { color: #475569 !important; }
        body.light-mode .modal > p { color: #64748b !important; }
        body.light-mode .btn-cancel { 
            background: #f1f5f9 !important; 
            border-color: #cbd5e1 !important; 
            color: #475569 !important; 
        }
        body.light-mode .theme-toggle {
            background: white !important;
            border-color: #e2e8f0 !important;
            color: #475569 !important;
        }
        body.light-mode .empty-state { color: #94a3b8 !important; }
        body.light-mode .empty-state h4 { color: #64748b !important; }
        body.light-mode .top-bar h1 {
            color: var(--primary) !important;
            -webkit-text-fill-color: var(--primary) !important;
        }

        /* Responsive */
        @media (max-width: 1100px) {
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media (max-width: 768px) {
            .sidebar { 
                transform: translateX(-100%); 
                transition: transform 0.3s ease;
                z-index: 1000;
            }
            .sidebar.active { transform: translateX(0); }
            .main-content { margin-left: 0 !important; padding: 20px !important; }
            .stats-grid { grid-template-columns: 1fr; }
            .form-row { grid-template-columns: 1fr; }
            .top-bar { flex-direction: column; align-items: flex-start; gap: 16px; }
            .top-bar h1 { font-size: 26px; }
        }
    </style>
</head>
<body>
    <script>
        if (localStorage.getItem('theme') !== 'dark') {
            document.body.classList.add('light-mode');
        }
    </script>
    
    <div class="mobile-overlay" id="mobileOverlay"></div>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-building"></i></div>
            <div>
                <h2>SmartInterview</h2>
                <span>Company Portal</span>
            </div>
        </div>
        <div class="nav-section">
            <h4>Dashboard</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/company/dashboard" class="nav-link active">
                <i class="fas fa-th-large"></i> Overview
            </a>
        </div>
        <div class="nav-section">
            <h4>Manage</h4>
            <a href="#" class="nav-link" onclick="switchTab('jobs')">
                <i class="fas fa-clipboard-list"></i> My Job Posts 
                <span class="nav-badge">${totalJobs}</span>
            </a>
            <a href="#" class="nav-link" onclick="switchTab('applicants')">
                <i class="fas fa-users"></i> Applicants 
                <span class="nav-badge">${totalApplications}</span>
            </a>
        </div>
        <div class="nav-section">
            <h4>Tools</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/chat" class="nav-link">
                <i class="fas fa-comments"></i> Messages
            </a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/logout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        <!-- Top Bar -->
        <div class="top-bar">
            <h1>
                <button class="mobile-menu-btn" id="mobileMenuBtn" style="display:none;">
                    <i class="fas fa-bars"></i>
                </button>
                <i class="fas fa-building"></i>
                Company Dashboard
            </h1>
            <div class="top-bar-actions">
                <button id="theme-toggle" class="theme-toggle" title="Toggle Theme" onclick="toggleTheme()">
                    <i class="fas fa-moon"></i>
                </button>
                <a href="${pageContext.request.contextPath}/hackerrank/logout" class="btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </div>
        </div>

        <c:if test="${not empty success}">
            <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-error"><i class="fas fa-exclamation-circle"></i> ${error}</div>
        </c:if>

        <!-- Stats -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon green"><i class="fas fa-briefcase"></i></div>
                <div class="stat-value">${totalJobs}</div>
                <div class="stat-label">Total Job Posts</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon blue"><i class="fas fa-check-circle"></i></div>
                <div class="stat-value">${activeJobs}</div>
                <div class="stat-label">Active Listings</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon purple"><i class="fas fa-users"></i></div>
                <div class="stat-value">${totalApplications}</div>
                <div class="stat-label">Total Applications</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon orange"><i class="fas fa-star"></i></div>
                <div class="stat-value">${shortlisted}</div>
                <div class="stat-label">Shortlisted</div>
            </div>
        </div>

        <!-- Tabs -->
        <div class="tab-container">
            <div class="tabs">
                <button class="tab active" onclick="switchTab('jobs')" id="tab-jobs">
                    <i class="fas fa-clipboard-list"></i> My Job Posts
                </button>
                <button class="tab" onclick="switchTab('applicants')" id="tab-applicants">
                    <i class="fas fa-users"></i> All Applicants
                </button>
            </div>
        </div>

        <!-- Jobs Panel -->
        <div class="tab-panel active" id="panel-jobs">
            <div class="card full-width">
                <div class="card-header">
                    <h3><i class="fas fa-clipboard-list"></i> Your Job Postings</h3>
                    <button class="btn-sm btn-sm-green" onclick="openPostJobModal()">
                        <i class="fas fa-plus"></i> New Job
                    </button>
                </div>
                <c:forEach var="job" items="${jobs}">
                    <div class="job-item">
                        <div class="job-item-top">
                            <div>
                                <h4>${job.title}</h4>
                                <div class="meta">
                                    <span><i class="fas fa-map-marker-alt"></i> ${job.location}</span>
                                    <span><i class="fas fa-money-bill-wave"></i> ${job.salary}</span>
                                    <span><i class="fas fa-layer-group"></i> ${job.experienceLevel}</span>
                                    <span><i class="fas fa-users"></i> ${job.applicantCount} applicants</span>
                                </div>
                            </div>
                            <div class="job-item-actions">
                                <c:choose>
                                    <c:when test="${job.status == 'ACTIVE'}"><span class="badge badge-active">Active</span></c:when>
                                    <c:when test="${job.status == 'CLOSED'}"><span class="badge badge-closed">Closed</span></c:when>
                                    <c:otherwise><span class="badge badge-draft">Draft</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div style="display: flex; gap: 8px; flex-wrap: wrap;">
                            <a href="${pageContext.request.contextPath}/company/applicants/${job.id}" class="btn-sm btn-sm-blue">
                                <i class="fas fa-users"></i> View Applicants (${job.applicantCount})
                            </a>
                            <c:if test="${job.status == 'ACTIVE'}">
                                <form action="${pageContext.request.contextPath}/company/update-job-status/${job.id}" method="post" style="display:inline;">
                                    <input type="hidden" name="status" value="CLOSED">
                                    <button type="submit" class="btn-sm btn-sm-orange"><i class="fas fa-pause"></i> Close</button>
                                </form>
                            </c:if>
                            <c:if test="${job.status == 'CLOSED'}">
                                <form action="${pageContext.request.contextPath}/company/update-job-status/${job.id}" method="post" style="display:inline;">
                                    <input type="hidden" name="status" value="ACTIVE">
                                    <button type="submit" class="btn-sm btn-sm-green"><i class="fas fa-play"></i> Reopen</button>
                                </form>
                            </c:if>
                            <form action="${pageContext.request.contextPath}/company/delete-job/${job.id}" method="post" style="display:inline;"
                                  onsubmit="return confirm('Delete this job and all its applications?');">
                                <button type="submit" class="btn-sm btn-sm-red"><i class="fas fa-trash"></i> Delete</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty jobs}">
                    <div class="empty-state">
                        <i class="fas fa-clipboard-list"></i>
                        <h4>No jobs posted yet</h4>
                        <p>Click "Post New Job" to create your first job listing.</p>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Applicants Panel -->
        <div class="tab-panel" id="panel-applicants">
            <div class="card full-width">
                <div class="card-header">
                    <h3><i class="fas fa-users"></i>
                        <c:choose>
                            <c:when test="${not empty job}">Applicants for: ${job.title}</c:when>
                            <c:otherwise>All Applicants</c:otherwise>
                        </c:choose>
                    </h3>
                </div>

                <c:set var="applicantsList" value="${not empty applicants ? applicants : recentApplications}" />
                <c:forEach var="app" items="${applicantsList}">
                    <div class="applicant-item">
                        <div class="applicant-top">
                            <div class="applicant-info">
                                <h4><i class="fas fa-user-circle" style="margin-right: 8px;"></i>${app.applicantName}</h4>
                                <p>${app.applicantEmail} &bull; Applied for: <strong style="color: var(--accent);">${app.jobTitle}</strong></p>
                            </div>
                            <div class="applicant-score">
                                <div class="score-circle ${app.resumeScore >= 75 ? 'score-high' : app.resumeScore >= 50 ? 'score-medium' : 'score-low'}">
                                    ${app.resumeScore}
                                </div>
                                <span class="score-label">Resume Match</span>
                            </div>
                        </div>
                        <div class="applicant-details">
                            <span class="applicant-detail"><i class="fas fa-file-alt"></i> ${not empty app.resumeFileName ? app.resumeFileName : 'No resume'}</span>
                            <span class="applicant-detail"><i class="fas fa-clock"></i> ${app.appliedAt}</span>
                            <c:choose>
                                <c:when test="${app.status == 'APPLIED'}"><span class="status-badge status-applied">Applied</span></c:when>
                                <c:when test="${app.status == 'VIEWED'}"><span class="status-badge status-viewed">Viewed</span></c:when>
                                <c:when test="${app.status == 'SHORTLISTED'}"><span class="status-badge status-shortlisted">Shortlisted</span></c:when>
                                <c:when test="${app.status == 'INTERVIEW_SCHEDULED'}"><span class="status-badge status-interview">Interview Scheduled</span></c:when>
                                <c:when test="${app.status == 'REJECTED'}"><span class="status-badge status-rejected">Rejected</span></c:when>
                                <c:when test="${app.status == 'HIRED'}"><span class="status-badge status-hired">Hired</span></c:when>
                            </c:choose>
                        </div>

                        <c:if test="${not empty app.coverLetter}">
                            <div class="suggestions-box" style="margin-bottom: 12px;">
                                <strong style="color: var(--accent);"><i class="fas fa-envelope-open"></i> Cover Letter:</strong><br>
                                ${app.coverLetter}
                            </div>
                        </c:if>

                        <c:if test="${not empty app.scoreSuggestions}">
                            <div class="suggestions-box">
                                <strong style="color: #fbbf24;"><i class="fas fa-lightbulb"></i> AI Suggestions:</strong><br>
                                ${app.scoreSuggestions}
                            </div>
                        </c:if>

                        <div class="applicant-actions" style="margin-top: 14px;">
                            <form action="${pageContext.request.contextPath}/company/update-application-status/${app.id}" method="post" style="display:inline;">
                                <input type="hidden" name="jobId" value="${app.jobId}">
                                <input type="hidden" name="status" value="SHORTLISTED">
                                <button type="submit" class="btn-sm btn-sm-green"><i class="fas fa-star"></i> Shortlist</button>
                            </form>
                            <button type="button" class="btn-sm btn-sm-purple" onclick="openScheduleModal('${app.id}', '${app.jobId}', '${app.applicantName}', '${app.aptitudeLink}', '${app.codingLink}', '${app.hrLink}')">
                                <i class="fas fa-calendar"></i> Schedule Interview
                            </button>
                            <form action="${pageContext.request.contextPath}/company/update-application-status/${app.id}" method="post" style="display:inline;">
                                <input type="hidden" name="jobId" value="${app.jobId}">
                                <input type="hidden" name="status" value="HIRED">
                                <button type="submit" class="btn-sm btn-sm-green"><i class="fas fa-check-double"></i> Hire</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/company/update-application-status/${app.id}" method="post" style="display:inline;">
                                <input type="hidden" name="jobId" value="${app.jobId}">
                                <input type="hidden" name="status" value="REJECTED">
                                <button type="submit" class="btn-sm btn-sm-red"><i class="fas fa-times"></i> Reject</button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty applicantsList}">
                    <div class="empty-state">
                        <i class="fas fa-users"></i>
                        <h4>No applicants yet</h4>
                        <p>Applications will appear here when candidates apply for your jobs.</p>
                    </div>
                </c:if>
            </div>
        </div>
    </div>

    <!-- Post Job Modal -->
    <div class="modal-overlay" id="postJobModal">
        <div class="modal">
            <h3><i class="fas fa-plus-circle"></i> Post New Job</h3>
            <p>Fill in the details below to create a new job listing</p>
            <form action="${pageContext.request.contextPath}/company/post-job" method="post">
                <div class="form-group">
                    <label>Job Title *</label>
                    <input type="text" name="title" class="form-input" placeholder="e.g. Java Developer, React Developer..." required>
                </div>
                <div class="form-group">
                    <label>Job Description *</label>
                    <textarea name="description" class="form-input" placeholder="Describe the role, responsibilities, and requirements..." required></textarea>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Location *</label>
                        <input type="text" name="location" class="form-input" placeholder="e.g. Bangalore, Remote..." required>
                    </div>
                    <div class="form-group">
                        <label>Salary *</label>
                        <input type="text" name="salary" class="form-input" placeholder="e.g. 12-18 LPA, 15000/month..." required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label>Experience Level *</label>
                        <select name="experienceLevel" class="form-input" required>
                            <option value="FRESHER">Fresher</option>
                            <option value="JUNIOR">Junior (1-3 yrs)</option>
                            <option value="MID">Mid Level (3-5 yrs)</option>
                            <option value="SENIOR">Senior (5-8 yrs)</option>
                            <option value="LEAD">Lead (8+ yrs)</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Job Type *</label>
                        <select name="jobType" class="form-input" required>
                            <option value="FULL_TIME">Full Time</option>
                            <option value="PART_TIME">Part Time</option>
                            <option value="INTERNSHIP">Internship</option>
                            <option value="CONTRACT">Contract</option>
                            <option value="REMOTE">Remote</option>
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <label>Required Skills *</label>
                    <input type="text" name="skills" class="form-input" placeholder="e.g. Java, Spring Boot, React, SQL (comma separated)" required>
                </div>
                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closePostJobModal()">Cancel</button>
                    <button type="submit" class="btn-submit"><i class="fas fa-paper-plane"></i> Post Job</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Schedule Interview Modal -->
    <div class="modal-overlay" id="scheduleModal">
        <div class="modal">
            <h3><i class="fas fa-calendar-check"></i> Schedule 3-Round Interview</h3>
            <p>Set up the interview pipeline for <strong id="scheduleApplicantName" style="color: var(--accent);"></strong></p>
            <form action="${pageContext.request.contextPath}/company/schedule-interview" method="post">
                <input type="hidden" name="applicationId" id="scheduleApplicationId">
                <input type="hidden" name="jobId" id="scheduleJobId">
                
                <div class="form-group" style="background: rgba(25, 167, 123, 0.05); padding: 18px; border-radius: 14px; border: 1px solid rgba(25, 167, 123, 0.1);">
                    <label style="color: var(--accent);"><i class="fas fa-brain"></i> Round 1: Aptitude Test Link</label>
                    <input type="url" name="aptitudeLink" class="form-input" placeholder="e.g., https://forms.gle/... or test platform link">
                    <div style="font-size: 11px; color: var(--text-tertiary); margin-top: 8px;">Students must complete this before proceeding.</div>
                </div>

                <div class="form-group" style="background: rgba(59, 130, 246, 0.05); padding: 18px; border-radius: 14px; border: 1px solid rgba(59, 130, 246, 0.1);">
                    <label style="color: #93c5fd;"><i class="fas fa-code"></i> Round 2: Coding Assessment Link</label>
                    <input type="url" name="codingLink" class="form-input" placeholder="e.g., HackerRank, LeetCode, or Google Form link">
                    <div style="font-size: 11px; color: var(--text-tertiary); margin-top: 8px;">Link to your technical programming assessment.</div>
                </div>

                <div class="form-group" style="background: rgba(59, 196, 154, 0.05); padding: 18px; border-radius: 14px; border: 1px solid rgba(59, 196, 154, 0.1);">
                    <label style="color: var(--accent);"><i class="fas fa-video"></i> Round 3: HR / Technical Interview Link</label>
                    <input type="url" name="hrLink" class="form-input" placeholder="e.g., Google Meet, Zoom, or Teams link">
                    <div style="font-size: 11px; color: var(--text-tertiary); margin-top: 8px;">Direct video conference link for the final face-to-face round.</div>
                </div>

                <div class="modal-actions">
                    <button type="button" class="btn-cancel" onclick="closeScheduleModal()">Cancel</button>
                    <button type="submit" class="btn-submit" style="background: linear-gradient(135deg, var(--purple), #6d28d9);">
                        <i class="fas fa-paper-plane"></i> Send Links to Candidate
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Tab switching
        function switchTab(tab) {
            document.querySelectorAll('.tab').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
            document.getElementById('tab-' + tab).classList.add('active');
            document.getElementById('panel-' + tab).classList.add('active');
        }

        <c:if test="${not empty applicants}">
            switchTab('applicants');
        </c:if>

        // Modal controls
        function openPostJobModal() {
            document.getElementById('postJobModal').classList.add('active');
        }
        function closePostJobModal() {
            document.getElementById('postJobModal').classList.remove('active');
        }
        document.getElementById('postJobModal').addEventListener('click', function(e) {
            if (e.target === this) closePostJobModal();
        });

        function openScheduleModal(appId, jobId, applicantName, aptLink, codLink, hrLink) {
            document.getElementById('scheduleApplicationId').value = appId;
            document.getElementById('scheduleJobId').value = jobId;
            document.getElementById('scheduleApplicantName').textContent = applicantName;
            
            document.querySelector('#scheduleModal input[name="aptitudeLink"]').value = (aptLink && aptLink !== 'null' && aptLink.trim() !== '') ? aptLink : '';
            document.querySelector('#scheduleModal input[name="codingLink"]').value = (codLink && codLink !== 'null' && codLink.trim() !== '') ? codLink : '';
            document.querySelector('#scheduleModal input[name="hrLink"]').value = (hrLink && hrLink !== 'null' && hrLink.trim() !== '') ? hrLink : '';

            document.getElementById('scheduleModal').classList.add('active');
        }
        function closeScheduleModal() {
            document.getElementById('scheduleModal').classList.remove('active');
        }
        document.getElementById('scheduleModal').addEventListener('click', function(e) {
            if (e.target === this) closeScheduleModal();
        });

        // Theme Toggle
        function updateThemeIcon() {
            const icon = document.querySelector('#theme-toggle i');
            if (document.body.classList.contains('light-mode')) {
                icon.classList.remove('fa-moon');
                icon.classList.add('fa-sun');
            } else {
                icon.classList.remove('fa-sun');
                icon.classList.add('fa-moon');
            }
        }
        updateThemeIcon();

        function toggleTheme() {
            document.body.classList.toggle('light-mode');
            localStorage.setItem('theme', document.body.classList.contains('light-mode') ? 'light' : 'dark');
            updateThemeIcon();
        }

        // Mobile menu
        document.addEventListener('DOMContentLoaded', function() {
            const mobileMenuBtn = document.getElementById('mobileMenuBtn');
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('mobileOverlay');
            
            if (mobileMenuBtn) {
                mobileMenuBtn.style.display = window.innerWidth <= 768 ? 'inline-block' : 'none';
                
                mobileMenuBtn.addEventListener('click', function() {
                    sidebar.classList.add('active');
                    overlay.classList.add('active');
                    document.body.style.overflow = 'hidden';
                });
                
                overlay.addEventListener('click', function() {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                });
            }
            
            window.addEventListener('resize', function() {
                if (mobileMenuBtn) {
                    mobileMenuBtn.style.display = window.innerWidth <= 768 ? 'inline-block' : 'none';
                }
                if (window.innerWidth > 768) {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
            });
        });
    </script>
</body>
</html>
