<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Results - SmartInterview Admin</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #f8fafc;
            --bg-darker: #f1f5f9;
            --bg-lighter: #ffffff;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --text-tertiary: #94a3b8;
            --border-color: #e2e8f0;
            --card-bg: #ffffff;
            --hover-bg: rgba(25, 167, 123, 0.08);
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --gradient-dark: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-darker) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
            --success: #19A77B;
            --warning: #f59e0b;
            --danger: #ef4444;
            --info: #3b82f6;
            --sidebar-bg: #ffffff;
            --ans-card-bg: #ffffff;
            --ans-bg: #f8fafc;
            --bg-pulse-1: rgba(25, 167, 123, 0.03);
            --bg-pulse-2: rgba(59, 196, 154, 0.03);
            --title-gradient: linear-gradient(135deg, #1e293b 0%, #64748b 100%);
        }
        
        * { 
            margin: 0; 
            padding: 0; 
            box-sizing: border-box; 
        }
        
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
                radial-gradient(circle at 20% 80%, var(--bg-pulse-1) 0%, transparent 50%),
                radial-gradient(circle at 80% 20%, var(--bg-pulse-2) 0%, transparent 50%),
                radial-gradient(circle at 40% 40%, var(--bg-pulse-1) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
            animation: backgroundPulse 15s ease-in-out infinite;
        }
        
        @keyframes backgroundPulse {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }
        
        .container { 
            display: flex; 
            min-height: 100vh;
            position: relative;
            z-index: 1;
        }
        
        /* Enhanced Sidebar */
        .sidebar {
            position: fixed;
            left: 0;
            top: 0;
            width: 280px;
            height: 100vh;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            padding: 24px 16px;
            z-index: 100;
            overflow-y: auto;
            box-shadow: var(--shadow-lg);
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
            animation: logoGlow 3s ease-in-out infinite;
        }

        @keyframes logoGlow {
            0%, 100% { box-shadow: 0 0 20px rgba(25, 167, 123, 0.3); }
            50% { box-shadow: 0 0 30px rgba(25, 167, 123, 0.5); }
        }

        .sidebar-logo .icon i {
            color: #fff;
            font-size: 24px;
        }

        .sidebar-logo h2 {
            font-size: 20px;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
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
            background: rgba(25,167,123,0.08);
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
            background: rgba(25,167,123,0.08);
            color: var(--primary);
        }

        .nav-link.active::before {
            transform: translateX(0);
        }

        
        .nav-link.active i {
            color: var(--primary);
        }
        
        /* Enhanced Main Content */
        .main-content { 
            flex: 1; 
            margin-left: 280px; 
            padding: 32px 40px;
            position: relative;
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
        
        /* Enhanced Top Bar */
        .top-bar {
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            margin-bottom: 36px;
            padding: 8px 0;
        }
        
        .top-bar h1 { 
            font-size: 32px; 
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 16px;
            letter-spacing: -0.5px;
            background: var(--title-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        
        .top-bar h1 i {
            background: var(--gradient-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 32px;
        }
        
        .top-bar-actions {
            display: flex;
            gap: 16px;
            align-items: center;
        }
        
        .search-bar {
            display: flex;
            align-items: center;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 40px;
            padding: 10px 20px;
            backdrop-filter: blur(10px);
            transition: all 0.3s ease;
        }
        
        .search-bar:focus-within {
            border-color: var(--primary);
            box-shadow: var(--glow-primary);
        }
        
        .search-bar i {
            color: var(--text-tertiary);
            margin-right: 12px;
        }
        
        .search-bar input {
            background: none;
            border: none;
            color: var(--text-primary);
            font-size: 14px;
            outline: none;
            width: 240px;
        }
        
        .search-bar input::placeholder {
            color: var(--text-tertiary);
        }
        
        /* Enhanced Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
        }
        
        .stat-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 20px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            animation: cardAppear 0.5s ease-out forwards;
            opacity: 0;
        }
        
        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }
        
        @keyframes cardAppear {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .stat-card::before {
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
        
        .stat-card:hover {
            transform: translateY(-4px);
            border-color: var(--primary);
            box-shadow: var(--shadow-lg), var(--glow-primary);
        }
        
        .stat-card:hover::before {
            transform: translateX(0);
        }
        
        .stat-card .stat-icon {
            width: 48px;
            height: 48px;
            background: rgba(25,167,123,0.08);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 14px;
        }
        
        .stat-card .stat-icon i {
            font-size: 24px;
            color: var(--primary);
        }
        
        .stat-card .stat-value {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 6px;
            color: var(--text-primary);
        }
        
        .stat-card .stat-label {
            font-size: 13px;
            color: #475569;
            font-weight: 500;
        }
        
        .stat-card .stat-trend {
            display: flex;
            align-items: center;
            gap: 6px;
            margin-top: 10px;
            font-size: 11px;
        }
        
        .stat-card .stat-trend.positive {
            color: var(--success);
        }
        
        .stat-card .stat-trend.negative {
            color: var(--danger);
        }
        
        .stat-card .stat-trend.neutral {
            color: var(--warning);
        }
        
        /* Enhanced Main Card */
        .card {
            background: var(--card-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 28px;
            box-shadow: var(--shadow-lg);
            transition: all 0.3s ease;
            animation: cardAppear 0.6s ease-out 0.2s both;
        }
        
        .card:hover {
            border-color: rgba(25, 167, 123, 0.2);
            box-shadow: var(--shadow-lg), 0 0 40px rgba(25, 167, 123, 0.1);
        }
        
        .card-header {
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .card-header h3 {
            font-size: 20px; 
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 12px;
            color: var(--text-primary);
        }
        
        .card-header h3 i {
            color: var(--primary);
        }
        
        .header-actions {
            display: flex;
            gap: 12px;
        }
        
        .btn {
            padding: 10px 18px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            border: 1px solid transparent;
            background: transparent;
        }
        
        .btn-primary {
            background: var(--gradient-primary);
            color: white;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
        }
        
        .btn-secondary {
            background: transparent;
            border-color: var(--border-color);
            color: #475569;
        }
        
        .btn-secondary:hover {
            border-color: var(--primary);
            color: var(--primary);
            background: rgba(25,167,123,0.08);
        }
        
        /* Enhanced Tabs */
        .tabs-container {
            display: flex;
            gap: 8px;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 4px;
            margin-bottom: 20px;
        }
        
        .tab-btn {
            background: none; 
            border: none; 
            color: #475569; 
            font-size: 14px; 
            font-weight: 500;
            padding: 12px 24px; 
            cursor: pointer;
            border-radius: 12px 12px 0 0;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .tab-btn i {
            font-size: 15px;
        }
        
        .tab-btn::after {
            content: '';
            position: absolute;
            bottom: -4px;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--gradient-primary);
            transform: scaleX(0);
            transition: transform 0.3s ease;
            border-radius: 3px 3px 0 0;
        }
        
        .tab-btn:hover {
            color: var(--text-primary);
            background: rgba(25,167,123,0.08);
        }
        
        .tab-btn.active { 
            color: var(--primary);
        }
        
        .tab-btn.active::after {
            transform: scaleX(1);
        }
        
        .tab-content { 
            display: none; 
            padding-top: 8px;
            animation: fadeIn 0.4s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        .tab-content.active { 
            display: block; 
        }
        
        /* Filter Bar */
        .filter-bar {
            display: flex;
            gap: 12px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }
        
        .filter-select {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 8px 14px;
            color: var(--text-primary);
            font-size: 13px;
            cursor: pointer;
            outline: none;
            min-width: 160px;
            backdrop-filter: blur(10px);
        }
        
        .filter-select option {
            background: var(--bg-dark);
        }
        
        .filter-select:focus {
            border-color: var(--primary);
        }
        
        /* Enhanced Answer Cards */
        .answer-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 18px;
        }
        
        .answer-card {
            padding: 22px;
            background: var(--ans-card-bg);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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
        
        .answer-card::before {
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
        
        .answer-card:hover {
            transform: translateX(4px);
            border-color: var(--primary);
            box-shadow: var(--shadow-md);
        }
        
        .answer-card:hover::before {
            opacity: 1;
        }
        
        .answer-card h4 {
            color: var(--primary);
            margin-bottom: 10px;
            font-size: 16px;
            font-weight: 600;
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }
        
        .question-type-badge {
            font-size: 11px; 
            padding: 3px 10px; 
            background: rgba(25,167,123,0.08);
            border: 1px solid var(--primary);
            border-radius: 20px;
            color: var(--primary);
            font-weight: 500;
            letter-spacing: 0.3px;
        }
        
        .topic-badge {
            font-size: 11px; 
            padding: 3px 10px; 
            background: rgba(59, 196, 154, 0.15);
            border: 1px solid var(--accent);
            border-radius: 20px;
            color: var(--accent);
            font-weight: 500;
        }
        
        .answer-card .meta {
            display: flex; 
            gap: 18px; 
            font-size: 12px; 
            color: var(--text-tertiary); 
            margin-bottom: 14px;
            flex-wrap: wrap;
        }
        
        .answer-card .meta span {
            display: flex;
            align-items: center;
            gap: 6px;
        }
        
        .answer-card .meta i {
            color: var(--primary);
            font-size: 13px;
        }
        
        .answer-card p.ans-text {
            color: var(--text-primary); 
            font-size: 14px; 
            line-height: 1.7;
            white-space: pre-wrap;
            background: var(--ans-bg);
            padding: 16px; 
            border-radius: 12px; 
            border-left: 3px solid var(--primary);
            backdrop-filter: blur(10px);
        }
        
        .score-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .score-badge.high {
            background: rgba(25, 167, 123, 0.15);
            color: var(--success);
            border: 1px solid var(--success);
        }
        
        .score-badge.medium {
            background: rgba(245, 158, 11, 0.15);
            color: var(--warning);
            border: 1px solid var(--warning);
        }
        
        .score-badge.low {
            background: rgba(239, 68, 68, 0.15);
            color: var(--danger);
            border: 1px solid var(--danger);
        }
        
        /* Enhanced Group Headers */
        .group-header {
            margin: 28px 0 18px 0; 
            font-size: 18px; 
            font-weight: 700; 
            color: var(--accent);
            padding-bottom: 10px; 
            border-bottom: 2px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 12px;
            position: relative;
        }
        
        .group-header::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 50px;
            height: 2px;
            background: var(--gradient-primary);
        }
        
        .group-header i {
            color: var(--primary);
            font-size: 18px;
        }
        
        .group-header .count-badge {
            font-size: 12px; 
            color: var(--text-tertiary); 
            font-weight: 400;
            background: var(--card-bg);
            padding: 3px 10px;
            border-radius: 20px;
            border: 1px solid var(--border-color);
        }
        
        /* Empty State Enhancement */
        .empty-state {
            text-align: center; 
            padding: 80px 20px;
            color: var(--text-tertiary);
        }
        
        .empty-state i { 
            font-size: 64px; 
            margin-bottom: 20px; 
            display: block; 
            color: var(--primary);
            opacity: 0.5;
            animation: float 3s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }
        
        .empty-state p {
            font-size: 16px;
            margin-bottom: 20px;
        }
        
        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            gap: 8px;
            margin-top: 28px;
        }
        
        .page-btn {
            width: 38px;
            height: 38px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            color: #475569;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 13px;
        }
        
        .page-btn:hover,
        .page-btn.active {
            background: var(--primary);
            border-color: var(--primary);
            color: white;
        }
        
        /* Responsive Design */
        @media (max-width: 1024px) {
            .main-content {
                padding: 24px;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                transition: transform 0.3s ease;
                z-index: 1000;
            }
            
            .sidebar.active {
                transform: translateX(0);
                box-shadow: var(--shadow-lg);
            }
            
            .main-content {
                margin-left: 0 !important;
                padding: 20px !important;
            }
            
            .stats-grid {
                grid-template-columns: 1fr;
            }
            
            .top-bar {
                flex-direction: column;
                align-items: flex-start;
                gap: 16px;
            }
            
            .top-bar h1 {
                font-size: 26px;
            }
            
            .search-bar {
                width: 100%;
            }
            
            .search-bar input {
                width: 100%;
            }
            
            .card-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .tabs-container {
                width: 100%;
                overflow-x: auto;
                padding-bottom: 8px;
            }
            
            .tab-btn {
                white-space: nowrap;
                padding: 12px 16px;
            }
            
            .answer-card .meta {
                flex-direction: column;
                gap: 8px;
            }
            
            .mobile-menu-btn {
                display: inline-block !important;
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
                background: rgba(0, 0, 0, 0.7);
                backdrop-filter: blur(4px);
                z-index: 999;
            }
            
            .mobile-overlay.active {
                display: block;
            }
        }
        
        .mobile-menu-btn { 
            display: none; 
        }
        
        /* Loading Animation */
        .loading-spinner {
            display: inline-block;
            width: 18px;
            height: 18px;
            border: 2px solid var(--border-color);
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        /* Tooltip */
        [data-tooltip] {
            position: relative;
        }
        
        [data-tooltip]:before {
            content: attr(data-tooltip);
            position: absolute;
            bottom: 100%;
            left: 50%;
            transform: translateX(-50%);
            padding: 6px 12px;
            background: var(--bg-darker);
            color: var(--text-primary);
            font-size: 12px;
            border-radius: 8px;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
            pointer-events: none;
        }
        
        [data-tooltip]:hover:before {
            opacity: 1;
            visibility: visible;
            bottom: calc(100% + 8px);
        }
            
        /* Dark Mode Overrides */
        [data-theme="dark"] {
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #ffffff;
            --text-secondary: rgba(255, 255, 255, 0.7);
            --text-tertiary: rgba(255, 255, 255, 0.4);
            --border-color: rgba(255, 255, 255, 0.08);
            --card-bg: rgba(46, 62, 65, 0.6);
            --hover-bg: rgba(25, 167, 123, 0.15);
            --gradient-dark: linear-gradient(135deg, var(--bg-dark) 0%, var(--bg-darker) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.15);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.2);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.3);
            --sidebar-bg: rgba(46, 62, 65, 0.8);
            --ans-card-bg: rgba(46, 62, 65, 0.6);
            --ans-bg: rgba(26, 42, 44, 0.6);
            --bg-pulse-1: rgba(25, 167, 123, 0.1);
            --bg-pulse-2: rgba(59, 196, 154, 0.1);
            --title-gradient: linear-gradient(135deg, #ffffff 0%, rgba(255,255,255,0.7) 100%);
        }

        [data-theme="dark"]::before {
            display: block;
        }

        [data-theme="dark"] .sidebar {
            background: var(--sidebar-bg);
        }

        [data-theme="dark"] .sidebar-logo h2,
        [data-theme="dark"] .top-bar h1 {
            color: var(--text-primary);
            -webkit-text-fill-color: transparent;
        }

        [data-theme="dark"] .nav-link {
            color: #475569;
        }

        [data-theme="dark"] .answer-card p.ans-text {
            background: var(--ans-bg);
        }

        [data-theme="dark"] .filter-select option {
            background: var(--bg-darker);
        }

        .theme-toggle {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            color: #475569;
            width: 44px;
            height: 44px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .theme-toggle:hover {
            border-color: var(--primary);
            color: var(--primary);
            box-shadow: var(--glow-primary);
        }


        body.light-mode .theme-toggle {
            background: white;
            border-color: #e2e8f0;
            color: #475569;
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
            <a href="${pageContext.request.contextPath}/tech/results" class="nav-link active">
                <i class="fas fa-poll"></i> Results
            </a>
            <a href="${pageContext.request.contextPath}/tech/ai-evaluation" class="nav-link">
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
                <i class="fas fa-chart-bar"></i> Competition Results
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
                <h1>
                    <button class="mobile-menu-btn" id="mobileMenuBtn">
                        <i class="fas fa-bars"></i>
                    </button>
                    <i class="fas fa-poll"></i>
                    Student Results
                </h1>
                
                <div class="top-bar-actions">
                    <div class="search-bar">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Search results..." id="searchInput">
                    </div>
                    <button id="themeToggleBtn" class="theme-toggle" title="Toggle Theme" onclick="toggleTheme()">
                        <i class="fas fa-moon"></i>
                    </button>
                </div>
            </div>
            
            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-value">
                        <c:set var="uniqueStudents" value="0"/>
                        <c:if test="${not empty studentAnswers}">
                            <c:set var="studentSet" value="${studentAnswers.stream().map(a -> a.studentId).distinct().count()}"/>
                            <c:out value="${studentSet}"/>
                        </c:if>
                        <c:if test="${empty studentAnswers}">0</c:if>
                    </div>
                    <div class="stat-label">Active Jobseekers</div>
                    <div class="stat-trend positive">
                        <i class="fas fa-arrow-up"></i>
                        <span>+8% this week</span>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <div class="stat-value">
                        <c:out value="${studentAnswers != null ? studentAnswers.size() : '0'}"/>
                    </div>
                    <div class="stat-label">Total Submissions</div>
                    <div class="stat-trend positive">
                        <i class="fas fa-arrow-up"></i>
                        <span>+12% vs last month</span>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-value">
                        <c:set var="totalTime" value="0"/>
                        <c:set var="validCount" value="0"/>
                        <c:if test="${not empty studentAnswers}">
                            <c:forEach var="ans" items="${studentAnswers}">
                                <c:if test="${ans.timeTaken != null}">
                                    <c:set var="totalTime" value="${totalTime + ans.timeTaken}"/>
                                    <c:set var="validCount" value="${validCount + 1}"/>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <c:choose>
                            <c:when test="${validCount > 0}">
                                <fmt:formatNumber value="${totalTime / validCount}" maxFractionDigits="0"/>s
                            </c:when>
                            <c:otherwise>
                                0s
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-label">Avg. Completion Time</div>
                    <div class="stat-trend neutral">
                        <i class="fas fa-minus"></i>
                        <span>Consistent</span>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-star"></i>
                    </div>
                    <div class="stat-value">86%</div>
                    <div class="stat-label">Avg. Score</div>
                    <div class="stat-trend positive">
                        <i class="fas fa-arrow-up"></i>
                        <span>+5% improvement</span>
                    </div>
                </div>
            </div>
            
            <!-- Main Card -->
            <div class="card">
                <div class="card-header">
                    <h3>
                        <i class="fas fa-code"></i>
                        Coding & Interview Validations
                    </h3>
                    
                    <div class="header-actions">
                        <button class="btn btn-secondary" onclick="exportResults()">
                            <i class="fas fa-download"></i>
                            Export
                        </button>
                        <button class="btn btn-primary" onclick="refreshResults()">
                            <i class="fas fa-sync-alt"></i>
                            Refresh
                        </button>
                    </div>
                </div>
                
                <!-- Filter Bar -->
                <div class="filter-bar">
                    <select class="filter-select" id="filterTopic" onchange="filterResults()">
                        <option value="">All Topics</option>
                        <option value="Coding">Coding</option>
                        <option value="Technical">Technical</option>
                        <option value="Behavioral">Behavioral</option>
                        <option value="INTERVIEW">Interview</option>
                    </select>
                    
                    <select class="filter-select" id="filterType" onchange="filterResults()">
                        <option value="">All Types</option>
                        <option value="Coding">Coding</option>
                        <option value="Technical">Technical</option>
                        <option value="Behavioral">Behavioral</option>
                    </select>
                    
                    <select class="filter-select" id="sortBy" onchange="sortResults()">
                        <option value="recent">Most Recent</option>
                        <option value="oldest">Oldest First</option>
                        <option value="timeHigh">Time Taken (High to Low)</option>
                        <option value="timeLow">Time Taken (Low to High)</option>
                    </select>
                </div>
                
                <!-- Enhanced Tabs -->
                <div class="tabs-container">
                    <button onclick="switchTab(this, 'tab-all')" class="tab-btn active">
                        <i class="fas fa-list"></i>
                        Latest Submissions
                    </button>
                    <button onclick="switchTab(this, 'tab-user')" class="tab-btn">
                        <i class="fas fa-user-graduate"></i>
                        Group by User
                    </button>
                    <button onclick="switchTab(this, 'tab-topic')" class="tab-btn">
                        <i class="fas fa-layer-group"></i>
                        Group by Topic
                    </button>
                </div>
                
                <c:if test="${empty studentAnswers}">
                    <div class="empty-state">
                        <i class="fas fa-comment-slash"></i>
                        <p>No answers submitted by jobseekers yet.</p>
                        <button class="btn btn-primary" onclick="window.location.reload()">
                            <i class="fas fa-sync-alt"></i>
                            Check Again
                        </button>
                    </div>
                </c:if>

                <c:if test="${not empty studentAnswers}">
                    <!-- ALL SUBMISSIONS TAB -->
                    <div id="tab-all" class="tab-content active">
                        <div class="answer-grid">
                            <c:forEach var="ans" items="${studentAnswers}" varStatus="status">
                                <div class="answer-card" data-topic="${ans.questionType}" data-type="${ans.questionType}">
                                    <h4>
                                        ${ans.questionText != null ? ans.questionText : 'Question ID: '}${ans.questionId}
                                        <span class="question-type-badge">
                                            <i class="fas fa-tag"></i>
                                            ${ans.questionType}
                                        </span>
                                        <c:if test="${ans.questionType != null}">
                                            <span class="topic-badge">
                                                <i class="fas fa-folder"></i>
                                                ${ans.questionType}
                                            </span>
                                        </c:if>
                                        <c:if test="${ans.score != null}">
                                            <c:choose>
                                                <c:when test="${ans.score >= 80}">
                                                    <span class="score-badge high">
                                                        <i class="fas fa-check-circle"></i>
                                                        ${ans.score}%
                                                    </span>
                                                </c:when>
                                                <c:when test="${ans.score >= 60}">
                                                    <span class="score-badge medium">
                                                        <i class="fas fa-exclamation-circle"></i>
                                                        ${ans.score}%
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="score-badge low">
                                                        <i class="fas fa-times-circle"></i>
                                                        ${ans.score}%
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </h4>
                                    <div class="meta">
                                        <span>
                                            <i class="fas fa-user-circle"></i>
                                            ${ans.studentName != null ? ans.studentName : 'User #'}${ans.studentId}
                                        </span>
                                        <span>
                                            <i class="fas fa-stopwatch"></i>
                                            ${ans.timeTaken}s Total
                                        </span>
                                        <span>
                                            <i class="fas fa-calendar-alt"></i>
                                            ${ans.submittedAt}
                                        </span>
                                    </div>
                                    <p class="ans-text">${ans.answer}</p>
                                </div>
                            </c:forEach>
                        </div>
                        
                        <!-- Pagination -->
                        <div class="pagination">
                            <button class="page-btn"><i class="fas fa-chevron-left"></i></button>
                            <button class="page-btn active">1</button>
                            <button class="page-btn">2</button>
                            <button class="page-btn">3</button>
                            <button class="page-btn">4</button>
                            <button class="page-btn"><i class="fas fa-ellipsis-h"></i></button>
                            <button class="page-btn"><i class="fas fa-chevron-right"></i></button>
                        </div>
                    </div>

                    <!-- BY USER TAB -->
                    <div id="tab-user" class="tab-content">
                        <c:forEach var="entry" items="${answersByUser}">
                            <div class="group-header">
                                <i class="fas fa-user-graduate"></i> 
                                ${entry.key} 
                                <span class="count-badge">${entry.value.size()} tests</span>
                            </div>
                            <div class="answer-grid">
                                <c:forEach var="ans" items="${entry.value}">
                                    <div class="answer-card" data-topic="${ans.questionType}" data-type="${ans.questionType}">
                                        <h4>
                                            ${ans.questionText != null ? ans.questionText : 'Question ID: '}${ans.questionId}
                                            <span class="question-type-badge">
                                                <i class="fas fa-tag"></i>
                                                ${ans.questionType}
                                            </span>
                                            <c:if test="${ans.score != null}">
                                                <c:choose>
                                                    <c:when test="${ans.score >= 80}">
                                                        <span class="score-badge high">${ans.score}%</span>
                                                    </c:when>
                                                    <c:when test="${ans.score >= 60}">
                                                        <span class="score-badge medium">${ans.score}%</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="score-badge low">${ans.score}%</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </h4>
                                        <div class="meta">
                                            <span>
                                                <i class="fas fa-stopwatch"></i>
                                                ${ans.timeTaken}s
                                            </span>
                                            <span>
                                                <i class="fas fa-calendar-alt"></i>
                                                ${ans.submittedAt}
                                            </span>
                                        </div>
                                        <p class="ans-text">${ans.answer}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- BY TOPIC TAB -->
                    <div id="tab-topic" class="tab-content">
                        <c:forEach var="entry" items="${answersByTopic}">
                            <div class="group-header">
                                <i class="fas fa-layer-group"></i> 
                                ${entry.key}
                                <span class="count-badge">${entry.value.size()} submissions</span>
                            </div>
                            <div class="answer-grid">
                                <c:forEach var="ans" items="${entry.value}">
                                    <div class="answer-card" data-topic="${ans.questionType}" data-type="${ans.questionType}">
                                        <h4>
                                            ${ans.questionText != null ? ans.questionText : 'Question ID: '}${ans.questionId}
                                            <c:if test="${ans.score != null}">
                                                <c:choose>
                                                    <c:when test="${ans.score >= 80}">
                                                        <span class="score-badge high">${ans.score}%</span>
                                                    </c:when>
                                                    <c:when test="${ans.score >= 60}">
                                                        <span class="score-badge medium">${ans.score}%</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="score-badge low">${ans.score}%</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:if>
                                        </h4>
                                        <div class="meta">
                                            <span>
                                                <i class="fas fa-user-circle"></i>
                                                ${ans.studentName != null ? ans.studentName : 'User #'}${ans.studentId}
                                            </span>
                                            <span>
                                                <i class="fas fa-stopwatch"></i>
                                                ${ans.timeTaken}s
                                            </span>
                                            <span>
                                                <i class="fas fa-calendar-alt"></i>
                                                ${ans.submittedAt}
                                            </span>
                                        </div>
                                        <p class="ans-text">${ans.answer}</p>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    
    <script>
        // Enhanced JavaScript Functions
        
        function switchTab(btnElement, tabId) {
            document.querySelectorAll('.tab-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });
            
            btnElement.classList.add('active');
            document.getElementById(tabId).classList.add('active');
            
            const activeContent = document.getElementById(tabId);
            activeContent.style.animation = 'none';
            setTimeout(() => {
                activeContent.style.animation = 'fadeIn 0.4s ease-out';
            }, 10);
        }
        
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const answerCards = document.querySelectorAll('.answer-card');
            
            answerCards.forEach(card => {
                const text = card.textContent.toLowerCase();
                if (text.includes(searchTerm)) {
                    card.style.display = 'block';
                    card.style.animation = 'slideIn 0.4s ease-out';
                } else {
                    card.style.display = 'none';
                }
            });
        });
        
        // Filter functionality
        function filterResults() {
            const topic = document.getElementById('filterTopic').value.toLowerCase();
            const type = document.getElementById('filterType').value.toLowerCase();
            const answerCards = document.querySelectorAll('.answer-card');
            
            answerCards.forEach(card => {
                const cardTopic = (card.dataset.topic || '').toLowerCase();
                const cardType = (card.dataset.type || '').toLowerCase();
                
                let show = true;
                
                if (topic && !cardTopic.includes(topic)) show = false;
                if (type && !cardType.includes(type)) show = false;
                
                card.style.display = show ? 'block' : 'none';
                if (show) {
                    card.style.animation = 'slideIn 0.4s ease-out';
                }
            });
        }
        
        // Sort functionality
        function sortResults() {
            const sortBy = document.getElementById('sortBy').value;
            const grid = document.querySelector('.tab-content.active .answer-grid');
            const cards = Array.from(grid.children);
            
            cards.sort((a, b) => {
                if (sortBy === 'recent') {
                    return (b.dataset.timestamp || 0) - (a.dataset.timestamp || 0);
                } else if (sortBy === 'oldest') {
                    return (a.dataset.timestamp || 0) - (b.dataset.timestamp || 0);
                } else if (sortBy === 'timeHigh') {
                    return parseInt(b.dataset.time || 0) - parseInt(a.dataset.time || 0);
                } else if (sortBy === 'timeLow') {
                    return parseInt(a.dataset.time || 0) - parseInt(b.dataset.time || 0);
                }
                return 0;
            });
            
            cards.forEach(card => grid.appendChild(card));
        }
        
        // Export functionality
        function exportResults() {
            const data = [];
            document.querySelectorAll('.answer-card').forEach(card => {
                data.push({
                    question: card.querySelector('h4')?.textContent || '',
                    student: card.querySelector('.meta span:first-child')?.textContent || '',
                    time: card.querySelector('.meta span:nth-child(2)')?.textContent || '',
                    answer: card.querySelector('.ans-text')?.textContent || ''
                });
            });
            
            const blob = new Blob([JSON.stringify(data, null, 2)], { type: 'application/json' });
            const url = URL.createObjectURL(blob);
            const a = document.createElement('a');
            a.href = url;
            a.download = 'student-results.json';
            a.click();
            URL.revokeObjectURL(url);
        }
        
        // Refresh functionality
        function refreshResults() {
            const btn = event.target.closest('.btn');
            const originalText = btn.innerHTML;
            btn.innerHTML = '<span class="loading-spinner"></span> Refreshing...';
            btn.disabled = true;
            
            setTimeout(() => {
                window.location.reload();
            }, 1000);
        }
        
        // Mobile menu functionality
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
            
            // Add touch swipe support
            let touchStartX = 0;
            let touchEndX = 0;
            
            document.body.addEventListener('touchstart', e => {
                touchStartX = e.changedTouches[0].screenX;
            }, { passive: true });
            
            document.body.addEventListener('touchend', e => {
                touchEndX = e.changedTouches[0].screenX;
                if (touchEndX < touchStartX - 50) {
                    sidebar.classList.remove('active');
                    overlay.classList.remove('active');
                    document.body.style.overflow = '';
                }
                if (touchEndX > touchStartX + 50 && touchStartX < 30) {
                    sidebar.classList.add('active');
                    overlay.classList.add('active');
                    document.body.style.overflow = 'hidden';
                }
            }, { passive: true });
            
            // Handle window resize
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
            
            // Add data attributes for sorting
            document.querySelectorAll('.answer-card').forEach((card, index) => {
                const timeElement = card.querySelector('.meta span:nth-child(2)');
                if (timeElement) {
                    const timeText = timeElement.textContent;
                    const timeMatch = timeText.match(/(\d+)s/);
                    if (timeMatch) {
                        card.dataset.time = timeMatch[1];
                    }
                }
                card.dataset.timestamp = Date.now() - (index * 3600000);
            });
            
            initTooltips();
        });
        
        function initTooltips() {
            const tooltips = document.querySelectorAll('[data-tooltip]');
            tooltips.forEach(element => {
                element.addEventListener('mouseenter', function() {
                    const tooltip = this.dataset.tooltip;
                    if (!this.querySelector('.custom-tooltip')) {
                        const tooltipEl = document.createElement('div');
                        tooltipEl.className = 'custom-tooltip';
                        tooltipEl.textContent = tooltip;
                        tooltipEl.style.cssText = `
                            position: absolute;
                            bottom: 100%;
                            left: 50%;
                            transform: translateX(-50%);
                            padding: 6px 12px;
                            background: var(--bg-darker);
                            color: var(--text-primary);
                            font-size: 12px;
                            border-radius: 8px;
                            white-space: nowrap;
                            border: 1px solid var(--border-color);
                            pointer-events: none;
                            z-index: 1000;
                            margin-bottom: 8px;
                        `;
                        this.style.position = 'relative';
                        this.appendChild(tooltipEl);
                    }
                });
                
                element.addEventListener('mouseleave', function() {
                    const tooltip = this.querySelector('.custom-tooltip');
                    if (tooltip) {
                        tooltip.remove();
                    }
                });
            });
        }
        
        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                e.preventDefault();
                document.querySelector('#searchInput').focus();
            }
            
            if (e.key === 'Escape') {
                document.querySelector('#searchInput').value = '';
                document.querySelector('#searchInput').dispatchEvent(new Event('input'));
                document.querySelector('#searchInput').blur();
            }
            
            // Ctrl+E for export
            if ((e.ctrlKey || e.metaKey) && e.key === 'e') {
                e.preventDefault();
                exportResults();
            }
        });
    </script>
    <script>
        // Theme toggle logic
        function toggleTheme() {
            const currentTheme = document.documentElement.getAttribute("data-theme");
            const newTheme = currentTheme === "dark" ? "light" : "dark";
            document.documentElement.setAttribute("data-theme", newTheme);
            localStorage.setItem("theme", newTheme);
            updateThemeIcon(newTheme);
        }

        function updateThemeIcon(theme) {
            const icon = document.querySelector("#themeToggleBtn i");
            if (icon) {
                if (theme === "dark") {
                    icon.className = "fas fa-sun";
                } else {
                    icon.className = "fas fa-moon";
                }
            }
        }

        // Initialize theme on load (Light is default)
        const savedTheme = localStorage.getItem("theme");
        if (savedTheme === "dark") {
            document.documentElement.setAttribute("data-theme", "dark");
            document.addEventListener("DOMContentLoaded", function() {
                updateThemeIcon("dark");
            });
        }
    </script>
</body>
</html>










