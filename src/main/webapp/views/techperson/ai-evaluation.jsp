<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AI Evaluation Dashboard - SmartInterview</title>
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
            --hover-bg: rgba(25, 167, 123, 0.05);
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 30px rgba(25, 167, 123, 0.15);
            --success: #19A77B;
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
            max-width: 1200px;
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
            gap: 8px;
            color: var(--primary);
            text-decoration: none;
            font-size: 14px;
            margin-bottom: 24px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 30px;
            background: rgba(25, 167, 123, 0.05);
            border: 1px solid rgba(25, 167, 123, 0.1);
        }

        .back-link:hover {
            background: var(--primary);
            color: white;
            transform: translateX(-4px);
            box-shadow: var(--glow-primary);
        }

        .page-header {
            margin-bottom: 40px;
            text-align: center;
        }

        .page-header h1 {
            font-size: 42px;
            font-weight: 800;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 16px;
        }

        .page-header h1 i {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 42px;
            animation: robotFloat 3s ease-in-out infinite;
        }

        @keyframes robotFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        .page-header p {
            color: var(--text-tertiary);
            font-size: 16px;
        }

        /* Score Overview Cards */
        .score-overview {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 20px;
            margin-bottom: 40px;
        }

        .score-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px 20px;
            text-align: center;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            box-shadow: var(--shadow-sm);
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
        }

        .score-card:nth-child(1) { animation-delay: 0.1s; }
        .score-card:nth-child(2) { animation-delay: 0.2s; }
        .score-card:nth-child(3) { animation-delay: 0.3s; }
        .score-card:nth-child(4) { animation-delay: 0.4s; }
        .score-card:nth-child(5) { animation-delay: 0.5s; }

        @keyframes cardAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .score-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg), var(--glow-primary);
            border-color: var(--primary);
        }

        .score-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: var(--gradient-primary);
            transform: translateX(-100%);
            transition: transform 0.5s ease;
        }

        .score-card:hover::before {
            transform: translateX(0);
        }

        .score-card.comm .score-ring .fg { stroke: var(--primary); }
        .score-card.tech .score-ring .fg { stroke: var(--accent); }
        .score-card.conf .score-ring .fg { stroke: #fbbf24; }
        .score-card.overall .score-ring .fg { stroke: var(--primary-dark); }
        .score-card.total .score-ring .fg { stroke: #ec4899; }

        .score-ring {
            width: 80px;
            height: 80px;
            margin: 0 auto 16px;
            position: relative;
        }

        .score-ring svg {
            transform: rotate(-90deg);
        }

        .score-ring .bg {
            fill: none;
            stroke: rgba(0, 0, 0, 0.06);
            stroke-width: 6;
        }

        .score-ring .fg {
            fill: none;
            stroke-width: 6;
            stroke-linecap: round;
            transition: stroke-dashoffset 1.5s ease;
        }

        .score-ring .value {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 20px;
            font-weight: 800;
            color: var(--text-primary);
        }

        .score-card h4 {
            font-size: 13px;
            color: var(--text-tertiary);
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 600;
        }

        /* Evaluation List */
        .evaluations-section h2 {
            font-size: 24px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
        }

        .eval-card {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 28px;
            margin-bottom: 20px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: var(--shadow-sm);
            animation: slideIn 0.4s ease-out;
            position: relative;
            overflow: hidden;
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

        .eval-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--gradient-primary);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .eval-card:hover {
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
            transform: translateX(6px);
        }

        .eval-card:hover::before {
            opacity: 1;
        }

        .eval-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .eval-student {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .eval-avatar {
            width: 52px;
            height: 52px;
            background: var(--gradient-primary);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-weight: 700;
            font-size: 20px;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .eval-name h4 {
            font-size: 18px;
            color: var(--text-primary);
            margin-bottom: 4px;
            font-weight: 600;
        }

        .eval-name p {
            font-size: 13px;
            color: var(--text-tertiary);
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .eval-name p i {
            color: var(--primary);
            font-size: 12px;
        }

        .eval-overall {
            font-size: 32px;
            font-weight: 800;
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .eval-scores {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 14px;
            margin-bottom: 20px;
        }

        .eval-score-item {
            padding: 16px;
            border-radius: 14px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .eval-score-item:hover {
            transform: translateY(-2px);
        }

        .eval-score-item.comm {
            background: rgba(25, 167, 123, 0.08);
            border: 1px solid rgba(25, 167, 123, 0.15);
        }

        .eval-score-item.tech {
            background: rgba(59, 196, 154, 0.08);
            border: 1px solid rgba(59, 196, 154, 0.15);
        }

        .eval-score-item.conf {
            background: rgba(251, 191, 36, 0.08);
            border: 1px solid rgba(251, 191, 36, 0.15);
        }

        .eval-score-item.ov {
            background: rgba(20, 143, 105, 0.08);
            border: 1px solid rgba(20, 143, 105, 0.15);
        }

        .eval-score-item .score-val {
            font-size: 26px;
            font-weight: 800;
            margin-bottom: 4px;
        }

        .eval-score-item .score-val.comm {
            color: var(--primary);
        }

        .eval-score-item .score-val.tech {
            color: var(--accent);
        }

        .eval-score-item .score-val.conf {
            color: #fbbf24;
        }

        .eval-score-item .score-val.ov {
            color: var(--primary-dark);
        }

        .eval-score-item .score-lbl {
            font-size: 11px;
            color: var(--text-tertiary);
            text-transform: uppercase;
            letter-spacing: 0.8px;
            font-weight: 600;
        }

        .eval-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
        }

        .detail-box {
            padding: 18px;
            background: rgba(241, 245, 249, 0.8);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            transition: all 0.3s ease;
        }

        .detail-box:hover {
            background: rgba(25, 167, 123, 0.03);
            border-color: var(--primary);
        }

        .detail-box h5 {
            font-size: 13px;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
            font-weight: 600;
        }

        .detail-box p {
            font-size: 14px;
            color: #475569;
            line-height: 1.7;
        }

        .detail-box.full {
            grid-column: 1 / -1;
        }

        .strength-tag {
            display: inline-block;
            padding: 5px 12px;
            background: rgba(25, 167, 123, 0.1);
            color: #15803d;
            border-radius: 8px;
            font-size: 12px;
            margin: 3px;
            font-weight: 500;
            border: 1px solid rgba(25, 167, 123, 0.2);
        }

        .weakness-tag {
            display: inline-block;
            padding: 5px 12px;
            background: rgba(249, 115, 22, 0.1);
            color: #c2410c;
            border-radius: 8px;
            font-size: 12px;
            margin: 3px;
            font-weight: 500;
            border: 1px solid rgba(249, 115, 22, 0.2);
        }

        .empty-state {
            text-align: center;
            padding: 80px 20px;
            color: var(--text-tertiary);
            background: var(--card-bg);
            border-radius: 24px;
            border: 1px solid var(--border-color);
        }

        .empty-state i {
            font-size: 72px;
            display: block;
            margin-bottom: 20px;
            color: var(--primary);
            opacity: 0.3;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .empty-state h3 {
            color: var(--text-primary);
            margin-bottom: 12px;
            font-size: 20px;
        }

        .empty-state p {
            font-size: 15px;
        }

        /* Search Bar Enhancement */
        .search-form {
            display: flex;
            gap: 10px;
        }

        .search-input {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            padding: 10px 18px;
            color: var(--text-primary);
            outline: none;
            width: 280px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }

        .search-input::placeholder {
            color: var(--text-tertiary);
        }

        .search-btn {
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 14px;
            width: 44px;
            height: 44px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .search-btn:hover {
            background: var(--primary-dark);
            transform: scale(1.05);
            box-shadow: var(--glow-primary);
        }

        .clear-btn {
            background: rgba(0, 0, 0, 0.03);
            color: var(--text-tertiary);
            border-radius: 14px;
            width: 44px;
            height: 44px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
        }

        .clear-btn:hover {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border-color: var(--danger);
        }

        .delete-btn {
            color: var(--danger);
            background: rgba(239, 68, 68, 0.08);
            width: 36px;
            height: 36px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            border: 1px solid rgba(239, 68, 68, 0.15);
            transition: all 0.3s ease;
        }

        .delete-btn:hover {
            background: var(--danger);
            color: white;
            transform: scale(1.1);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 1024px) {
            .score-overview {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            .score-overview {
                grid-template-columns: repeat(2, 1fr);
                gap: 12px;
            }

            .page-header h1 {
                font-size: 32px;
            }

            .eval-scores {
                grid-template-columns: repeat(2, 1fr);
            }

            .eval-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }

            .eval-details {
                grid-template-columns: 1fr;
            }

            .search-input {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .score-overview {
                grid-template-columns: 1fr;
            }

            .eval-scores {
                grid-template-columns: 1fr;
            }

            .page-header h1 {
                font-size: 28px;
                flex-direction: column;
                gap: 8px;
            }
        }

        /* Loading Animation */
        .loading-spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 2px solid var(--border-color);
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }

        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* Score Animation */
        .score-ring .fg {
            animation: scoreFill 1.5s ease-out forwards;
        }

        @keyframes scoreFill {
            from { stroke-dashoffset: 100; }
            to { stroke-dashoffset: var(--target-offset, 0); }
        }
        /* Sidebar Styles */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            padding: 24px 16px;
            z-index: 100;
            overflow-y: auto;
            transition: transform 0.3s ease;
        }

        .sidebar::-webkit-scrollbar {
            width: 6px;
        }

        .sidebar::-webkit-scrollbar-track {
            background: transparent;
        }

        .sidebar::-webkit-scrollbar-thumb {
            background: var(--primary);
            border-radius: 3px;
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
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding: 0 12px;
            margin-bottom: 14px;
            font-weight: 700;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 12px 14px;
            border-radius: 12px;
            color: #475569;
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
        }

        .nav-link:hover {
            background: rgba(25,167,123,0.08);
            color: var(--primary);
            transform: translateX(4px);
        }

        .nav-link.active {
            background: rgba(25,167,123,0.08);
            color: var(--primary);
            box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.05);
        }

        .main-content {
            margin-left: 280px;
            padding: 28px 36px;
            position: relative;
            z-index: 1;
            animation: fadeInUp 0.6s ease-out;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
        }

        .mobile-menu-btn {
            display: none;
            background: none;
            border: none;
            font-size: 24px;
            color: var(--text-primary);
            cursor: pointer;
            margin-right: 12px;
        }

        .mobile-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            backdrop-filter: blur(4px);
            z-index: 99;
        }

        .mobile-overlay.active {
            display: block;
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                z-index: 1000;
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
                padding: 20px;
            }

            .mobile-menu-btn {
                display: inline-block;
            }
        }
    </style>
</head>

<body>
    <div class="mobile-overlay" id="mobileOverlay"></div>

    <div class="sidebar" id="sidebar">
        <div class="sidebar-logo">
            <div class="icon"><i class="fas fa-laptop-code"></i></div>
            <h2>Tech Person</h2>
        </div>
        <div class="nav-section">
            <h4>Overview</h4>
            <a href="${pageContext.request.contextPath}/tech/dashboard" class="nav-link">
                <i class="fas fa-th-large"></i> Dashboard
            </a>
        </div>
        <div class="nav-section">
            <h4>Management</h4>
            <a href="${pageContext.request.contextPath}/tech/manage-users" class="nav-link">
                <i class="fas fa-users-cog"></i> Manage Users
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-questions" class="nav-link">
                <i class="fas fa-question-circle"></i> Manage Questions
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-categories" class="nav-link">
                <i class="fas fa-tags"></i> Manage Categories
            </a>
        </div>
        <div class="nav-section">
            <h4>Evaluation</h4>
            <a href="${pageContext.request.contextPath}/tech/results" class="nav-link">
                <i class="fas fa-poll"></i> Results
            </a>
            <a href="${pageContext.request.contextPath}/tech/ai-evaluation" class="nav-link active">
                <i class="fas fa-robot"></i> AI Evaluation
            </a>
        </div>
                <div class="nav-section">
            <h4>Competitions</h4>
            <a href="${pageContext.request.contextPath}/tech/conduct-competition" class="nav-link">
                <i class="fas fa-trophy"></i> Conduct Competition
            </a>
            <a href="${pageContext.request.contextPath}/tech/manage-competitions" class="nav-link">
                <i class="fas fa-tasks"></i> Manage Competitions
            </a>
            <a href="${pageContext.request.contextPath}/tech/competition-results" class="nav-link">
                <i class="fas fa-medal"></i> Competition Results
            </a>
            <a href="${pageContext.request.contextPath}/tech/competition-recordings" class="nav-link">
                <i class="fas fa-video"></i> Competition Recordings
            </a>
        </div>
        <div class="nav-section">
            <h4>Account</h4>
            <a href="${pageContext.request.contextPath}/tech/logout" class="nav-link">
                <i class="fas fa-sign-out-alt"></i> Logout
            </a>
        </div>
    </div>

    <div class="main-content">
        <div class="top-bar">
            <button class="mobile-menu-btn" id="mobileMenuBtn">
                <i class="fas fa-bars"></i>
            </button>
            <a href="javascript:history.back()" class="back-link" style="margin-bottom: 0;">
                <i class="fas fa-arrow-left"></i> Back
            </a>
        </div>

        <div class="page-header">
            <h1>
                <i class="fas fa-robot"></i>
                AI Evaluation Dashboard
            </h1>
            <p>Comprehensive AI-powered assessment of interview performance</p>
        </div>

        <div class="score-overview">
            <div class="score-card comm">
                <div class="score-ring">
                    <svg viewBox="0 0 36 36">
                        <circle class="bg" cx="18" cy="18" r="15.9" />
                        <circle class="fg" cx="18" cy="18" r="15.9" stroke-dasharray="100"
                            stroke-dashoffset="${100 - avgCommunication * 10}" />
                    </svg>
                    <span class="value">
                        <fmt:formatNumber value="${avgCommunication}" maxFractionDigits="1"/>
                    </span>
                </div>
                <h4>Communication</h4>
            </div>
            <div class="score-card tech">
                <div class="score-ring">
                    <svg viewBox="0 0 36 36">
                        <circle class="bg" cx="18" cy="18" r="15.9" />
                        <circle class="fg" cx="18" cy="18" r="15.9" stroke-dasharray="100"
                            stroke-dashoffset="${100 - avgTechnical * 10}" />
                    </svg>
                    <span class="value">
                        <fmt:formatNumber value="${avgTechnical}" maxFractionDigits="1"/>
                    </span>
                </div>
                <h4>Technical</h4>
            </div>
            <div class="score-card conf">
                <div class="score-ring">
                    <svg viewBox="0 0 36 36">
                        <circle class="bg" cx="18" cy="18" r="15.9" />
                        <circle class="fg" cx="18" cy="18" r="15.9" stroke-dasharray="100"
                            stroke-dashoffset="${100 - avgConfidence * 10}" />
                    </svg>
                    <span class="value">
                        <fmt:formatNumber value="${avgConfidence}" maxFractionDigits="1"/>
                    </span>
                </div>
                <h4>Confidence</h4>
            </div>
            <div class="score-card overall">
                <div class="score-ring">
                    <svg viewBox="0 0 36 36">
                        <circle class="bg" cx="18" cy="18" r="15.9" />
                        <circle class="fg" cx="18" cy="18" r="15.9" stroke-dasharray="100"
                            stroke-dashoffset="${100 - avgOverall * 10}" />
                    </svg>
                    <span class="value">
                        <fmt:formatNumber value="${avgOverall}" maxFractionDigits="1"/>
                    </span>
                </div>
                <h4>Global Average</h4>
            </div>
            <div class="score-card total">
                <div class="score-ring">
                    <svg viewBox="0 0 36 36">
                        <circle class="bg" cx="18" cy="18" r="15.9" />
                        <circle class="fg" cx="18" cy="18" r="15.9" stroke-dasharray="100"
                            stroke-dashoffset="${100 - (totalEvaluations > 100 ? 100 : totalEvaluations)}" />
                    </svg>
                    <span class="value">${totalEvaluations}</span>
                </div>
                <h4>Total Evals</h4>
            </div>
        </div>

        <div class="evaluations-section">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 28px; flex-wrap: wrap; gap: 16px;">
                <h2>
                    <i class="fas fa-clipboard-list" style="color: var(--primary); margin-right: 12px;"></i>
                    All Evaluations
                </h2>
                
                <form action="${pageContext.request.contextPath}/tech/ai-evaluation" method="get" class="search-form">
                    <input type="text" name="search" placeholder="Search by student name..." value="${searchQuery}" 
                           class="search-input">
                    <button type="submit" class="search-btn">
                        <i class="fas fa-search"></i>
                    </button>
                    <c:if test="${not empty searchQuery}">
                        <a href="${pageContext.request.contextPath}/tech/ai-evaluation" class="clear-btn">
                            <i class="fas fa-times"></i>
                        </a>
                    </c:if>
                </form>
            </div>

            <c:forEach var="eval" items="${evaluations}" varStatus="status">
                <div class="eval-card" style="animation-delay: ${status.index * 0.05}s;">
                    <div class="eval-header">
                        <div class="eval-student">
                            <div class="eval-avatar"><c:choose><c:when test="${not empty eval.studentName}">${eval.studentName.substring(0,1)}</c:when><c:otherwise>U</c:otherwise></c:choose></div>
                            <div class="eval-name">
                                <h4>${not empty eval.studentName ? eval.studentName : "Unknown User"}</h4>
                                <p>
                                    <i class="fas fa-calendar-alt"></i>
                                    Interview Date: ${eval.scheduledAt}
                                </p>
                            </div>
                        </div>
                        <div style="display: flex; align-items: center; gap: 20px;">
                            <div class="eval-overall">
                                <fmt:formatNumber value="${eval.score != null ? eval.score / 10.0 : 0}" maxFractionDigits="1"/>/10
                            </div>
                            <a href="${pageContext.request.contextPath}/tech/interviewer/delete-interview/${eval.id}?redirect=/tech/ai-evaluation" 
                               class="delete-btn" 
                               onclick="return confirm('Are you sure you want to delete this AI evaluation record?')"
                               title="Delete Evaluation">
                                <i class="fas fa-trash-alt"></i>
                            </a>
                        </div>
                    </div>

                    <div class="eval-scores">
                        <div class="eval-score-item comm">
                            <div class="score-val comm">
                                <fmt:formatNumber value="${eval.communicationScore != null ? eval.communicationScore / 10.0 : 0}" maxFractionDigits="1"/>
                            </div>
                            <div class="score-lbl">Communication</div>
                        </div>
                        <div class="eval-score-item tech">
                            <div class="score-val tech">
                                <fmt:formatNumber value="${eval.technicalScore != null ? eval.technicalScore / 10.0 : 0}" maxFractionDigits="1"/>
                            </div>
                            <div class="score-lbl">Technical</div>
                        </div>
                        <div class="eval-score-item conf">
                            <div class="score-val conf">
                                <fmt:formatNumber value="${eval.confidenceScore != null ? eval.confidenceScore / 10.0 : 0}" maxFractionDigits="1"/>
                            </div>
                            <div class="score-lbl">Confidence</div>
                        </div>
                        <div class="eval-score-item ov">
                            <div class="score-val ov">
                                <fmt:formatNumber value="${eval.score != null ? eval.score / 10.0 : 0}" maxFractionDigits="1"/>
                            </div>
                            <div class="score-lbl">Total Score</div>
                        </div>
                    </div>

                    <div class="eval-details">
                        <div class="detail-box full">
                            <h5>
                                <i class="fas fa-comment-alt"></i>
                                Interviewer Feedback & Analysis
                            </h5>
                            <p>${eval.feedback}</p>
                        </div>
                        <c:if test="${not empty eval.aiAnalysis}">
                            <div class="detail-box full">
                                <h5>
                                    <i class="fas fa-robot"></i>
                                    AI Insights
                                </h5>
                                <p>${eval.aiAnalysis}</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty evaluations}">
                <div class="empty-state">
                    <i class="fas fa-robot"></i>
                    <h3>No AI Evaluations Yet</h3>
                    <p>AI evaluations will appear here after interviews are completed and evaluated.</p>
                </div>
            </c:if>
        </div>
    </div>


    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Animate score rings on load
            const scoreCards = document.querySelectorAll('.score-card');
            scoreCards.forEach((card, index) => {
                setTimeout(() => {
                    const ring = card.querySelector('.fg');
                    if (ring) {
                        const offset = ring.getAttribute('stroke-dashoffset');
                        ring.style.setProperty('--target-offset', offset);
                    }
                }, index * 100);
            });

            // Sidebar and Mobile Menu logic
            const mobileMenuBtn = document.getElementById('mobileMenuBtn');
            const sidebar = document.getElementById('sidebar');
            const overlay = document.getElementById('mobileOverlay');

            if (mobileMenuBtn && sidebar && overlay) {
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

                mobileMenuBtn.addEventListener('click', openSidebar);
                overlay.addEventListener('click', closeSidebar);

                // Touch swipe support
                let touchStartX = 0;
                document.body.addEventListener('touchstart', e => {
                    touchStartX = e.changedTouches[0].screenX;
                }, { passive: true });

                document.body.addEventListener('touchend', e => {
                    let touchEndX = e.changedTouches[0].screenX;
                    if (touchEndX < touchStartX - 50) closeSidebar();
                    if (touchEndX > touchStartX + 50 && touchStartX < 30) openSidebar();
                }, { passive: true });
            }

            // Keyboard shortcuts
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape') {
                    const sidebar = document.getElementById('sidebar');
                    const overlay = document.getElementById('mobileOverlay');
                    if (sidebar && sidebar.classList.contains('active')) {
                        sidebar.classList.remove('active');
                        overlay.classList.remove('active');
                        document.body.style.overflow = '';
                    }
                }
            });
        });
    </script>
</body>
</html>
