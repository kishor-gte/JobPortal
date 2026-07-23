<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate Management - SmartInterview</title>
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
            --success: #19A77B;
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

        body::before {
            content: '';
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
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

        /* Sidebar (Same as Dashboard) */
        .sidebar {
            position: fixed;
            left: 0; top: 0;
            width: 280px;
            height: 100vh;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-right: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm);
            padding: 24px 16px;
            z-index: 100;
            overflow-y: auto;
        }

        .sidebar::-webkit-scrollbar { width: 6px; }
        .sidebar::-webkit-scrollbar-track { background: transparent; }
        .sidebar::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 3px; }

        .sidebar-logo {
            display: flex; align-items: center; gap: 14px;
            padding: 8px 12px 24px; border-bottom: 1px solid var(--border-color);
            margin-bottom: 24px;
        }

        .sidebar-logo .icon {
            width: 48px; height: 48px;
            background: var(--gradient-primary); border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            box-shadow: var(--glow-primary); animation: logoGlow 3s ease-in-out infinite;
        }

        @keyframes logoGlow {
            0%, 100% { box-shadow: 0 0 20px rgba(25, 167, 123, 0.2); }
            50% { box-shadow: 0 0 30px rgba(25, 167, 123, 0.4); }
        }

        .sidebar-logo .icon i { color: #fff; font-size: 24px; }
        .sidebar-logo h2 {
            font-size: 20px; font-weight: 700;
            background: var(--gradient-primary);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text; letter-spacing: -0.5px;
        }

        .nav-section { margin-bottom: 28px; }
        .nav-section h4 {
            color: var(--text-tertiary); font-size: 11px; text-transform: uppercase;
            letter-spacing: 1.5px; padding: 0 12px; margin-bottom: 14px; font-weight: 600;
        }

        .nav-link {
            display: flex; align-items: center; gap: 14px;
            padding: 12px 14px; border-radius: 12px;
            color: var(--text-secondary); text-decoration: none;
            font-size: 14px; font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            margin-bottom: 4px; position: relative; overflow: hidden;
        }
        .nav-link i { width: 20px; text-align: center; font-size: 16px; transition: transform 0.3s ease; }
        .nav-link::before {
            content: ''; position: absolute; left: 0; top: 0; bottom: 0;
            width: 3px; background: var(--gradient-primary);
            transform: translateX(-100%); transition: transform 0.3s ease;
        }
        .nav-link:hover { background: var(--hover-bg); color: var(--primary); transform: translateX(4px); }
        .nav-link:hover i { transform: scale(1.1); }
        .nav-link:hover::before { transform: translateX(0); }
        .nav-link.active { background: var(--hover-bg); color: var(--primary); box-shadow: inset 0 0 20px rgba(25, 167, 123, 0.05); }
        .nav-link.active::before { transform: translateX(0); }
        .nav-link.active i { color: var(--primary); }

        /* Main Content */
        .main-content {
            margin-left: 280px; padding: 28px 36px;
            position: relative; z-index: 1; animation: fadeInUp 0.6s ease-out;
        }
        @keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }

        .top-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px; }
        .top-bar h1 {
            font-size: 32px; font-weight: 800;
            background: var(--gradient-primary);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent;
            background-clip: text; display: flex; align-items: center; gap: 12px;
        }
        .top-bar p { color: var(--text-tertiary); font-size: 15px; margin-top: 6px; }

        /* Stats Grid */
        .stats-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 20px; margin-bottom: 32px; }
        .stat-card {
            background: var(--card-bg); backdrop-filter: blur(10px);
            border: 1px solid var(--border-color); border-radius: 20px;
            padding: 24px; text-align: center; box-shadow: var(--shadow-sm);
            transition: all 0.3s ease; position: relative; overflow: hidden;
        }
        .stat-card::before {
            content: ''; position: absolute; top: 0; left: 0; right: 0;
            height: 4px; background: var(--gradient-primary); transform: translateX(-100%); transition: transform 0.5s ease;
        }
        .stat-card:hover { transform: translateY(-6px); border-color: var(--primary); box-shadow: var(--shadow-lg), var(--glow-primary); }
        .stat-card:hover::before { transform: translateX(0); }
        .stat-icon {
            width: 48px; height: 48px; margin: 0 auto 12px;
            background: var(--hover-bg); border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
        }
        .stat-icon i { font-size: 24px; color: var(--primary); }
        .stat-value {
            font-size: 32px; font-weight: 800; margin-bottom: 6px;
            background: var(--gradient-primary);
            -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
        }
        .stat-label { color: var(--text-tertiary); font-size: 12px; text-transform: uppercase; font-weight: 600; }

        /* Filters and Search */
        .filter-section {
            background: var(--card-bg); padding: 24px; border-radius: 20px;
            border: 1px solid var(--border-color); box-shadow: var(--shadow-sm); margin-bottom: 24px;
            display: flex; flex-wrap: wrap; gap: 16px; align-items: flex-end;
        }
        .filter-group { display: flex; flex-direction: column; gap: 8px; flex: 1; min-width: 200px; }
        .filter-group label { font-size: 12px; font-weight: 600; color: var(--text-secondary); text-transform: uppercase; }
        .filter-control {
            padding: 12px 16px; border-radius: 12px; border: 1px solid var(--border-color);
            background: #f8fafc; font-family: 'Inter', sans-serif; font-size: 14px; outline: none; transition: all 0.3s;
        }
        .filter-control:focus { border-color: var(--primary); background: #fff; box-shadow: 0 0 0 4px rgba(25, 167, 123, 0.1); }
        .btn-filter {
            background: var(--gradient-primary); color: #fff; border: none;
            padding: 12px 24px; border-radius: 12px; font-weight: 600; cursor: pointer; transition: all 0.3s;
        }
        .btn-filter:hover { transform: translateY(-2px); box-shadow: 0 6px 16px rgba(25, 167, 123, 0.3); }

        /* Table */
        .table-container {
            background: var(--card-bg); border-radius: 24px; border: 1px solid var(--border-color);
            box-shadow: var(--shadow-sm); overflow: hidden; margin-bottom: 30px;
        }
        .table-wrapper { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th {
            background: rgba(248, 250, 252, 0.8); padding: 18px 24px; font-size: 13px; font-weight: 600;
            color: var(--text-secondary); text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 1px solid var(--border-color);
            white-space: nowrap;
        }
        td { padding: 16px 24px; border-bottom: 1px solid var(--border-color); font-size: 14px; vertical-align: middle; }
        tr:last-child td { border-bottom: none; }
        tr:hover td { background: rgba(241, 245, 249, 0.5); }
        
        .candidate-cell { display: flex; align-items: center; gap: 14px; }
        .candidate-avatar {
            width: 40px; height: 40px; border-radius: 50%; background: var(--gradient-primary);
            color: white; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 16px; overflow: hidden;
        }
        .candidate-avatar img { width: 100%; height: 100%; border-radius: 50%; object-fit: cover; }
        .candidate-info h4 { margin: 0 0 4px 0; font-size: 15px; color: var(--text-primary); font-weight: 600; }
        .candidate-info p { margin: 0; font-size: 12px; color: var(--text-tertiary); }
        
        .badge { padding: 6px 12px; border-radius: 30px; font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.3px; white-space: nowrap; display: inline-flex; align-items: center; gap: 4px; }
        .badge-success { background: rgba(25, 167, 123, 0.1); color: var(--success); border: 1px solid rgba(25, 167, 123, 0.3); }
        .badge-warning { background: rgba(245, 158, 11, 0.1); color: var(--warning); border: 1px solid rgba(245, 158, 11, 0.3); }

        .btn-profile {
            background: var(--hover-bg);
            color: var(--primary);
            border: 1px solid var(--primary);
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
        }
        .btn-profile:hover {
            background: var(--primary);
            color: #fff;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.2);
        }

        /* Actions Dropdown */
        .dropdown { position: relative; display: inline-block; }
        .dropbtn {
            background: #f1f5f9; color: var(--text-secondary); border: 1px solid var(--border-color);
            padding: 8px 16px; border-radius: 8px; cursor: pointer; font-size: 13px; font-weight: 600; transition: all 0.3s;
        }
        .dropbtn:hover { background: #e2e8f0; color: var(--text-primary); }
        .dropdown-content {
            display: none; position: absolute; right: 0; background-color: #fff;
            min-width: 200px; box-shadow: var(--shadow-lg); border-radius: 12px; border: 1px solid var(--border-color); z-index: 100;
            overflow: hidden;
        }
        .dropdown:hover .dropdown-content { display: block; animation: slideDown 0.2s ease-out; }
        .dropdown-content a, .dropdown-content button {
            color: var(--text-secondary); padding: 12px 16px; text-decoration: none; display: flex; align-items: center;
            gap: 10px; font-size: 13px; font-weight: 500; transition: background 0.3s; width: 100%; border: none; background: none; text-align: left; cursor: pointer;
        }
        .dropdown-content a:hover, .dropdown-content button:hover { background-color: var(--hover-bg); color: var(--primary); }

        /* Modals */
        .modal-overlay {
            display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5); backdrop-filter: blur(4px); z-index: 999;
            align-items: center; justify-content: center;
        }
        .modal-content {
            background: #fff; border-radius: 24px; width: 95%; max-width: 1000px;
            max-height: 90vh; overflow-y: auto; padding: 32px; position: relative;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2); animation: modalPop 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        @keyframes modalPop { from { opacity: 0; transform: scale(0.95); } to { opacity: 1; transform: scale(1); } }
        .modal-close {
            position: absolute; top: 24px; right: 24px; font-size: 20px; color: var(--text-tertiary);
            cursor: pointer; background: #f1f5f9; width: 36px; height: 36px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center; transition: all 0.3s;
        }
        .modal-close:hover { background: #e2e8f0; color: var(--danger); transform: rotate(90deg); }
        .modal-header h2 { font-size: 24px; color: var(--text-primary); margin-bottom: 24px; display: flex; align-items: center; gap: 12px; }
        .modal-header h2 i { color: var(--primary); }
        
        .profile-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; }
        .profile-item { background: #f8fafc; padding: 16px; border-radius: 12px; border: 1px solid var(--border-color); }
        .profile-item label { display: block; font-size: 11px; text-transform: uppercase; color: var(--text-tertiary); font-weight: 600; margin-bottom: 6px; }
        .profile-item p { margin: 0; font-size: 14px; color: var(--text-primary); font-weight: 500; }

        .timeline { border-left: 2px solid var(--border-color); margin-left: 20px; padding-left: 20px; }
        .timeline-item { position: relative; margin-bottom: 24px; }
        .timeline-item::before {
            content: ''; position: absolute; left: -27px; top: 0; width: 12px; height: 12px;
            border-radius: 50%; background: var(--primary); border: 2px solid #fff; box-shadow: 0 0 0 2px var(--primary);
        }
        .timeline-date { font-size: 12px; color: var(--text-tertiary); margin-bottom: 4px; font-weight: 600; }
        .timeline-content { background: #f8fafc; padding: 16px; border-radius: 12px; border: 1px solid var(--border-color); }
        .timeline-content h4 { margin: 0 0 6px 0; font-size: 14px; color: var(--text-primary); }
        .timeline-content p { margin: 0; font-size: 13px; color: var(--text-secondary); }

        /* Pagination */
        .pagination { display: flex; justify-content: center; gap: 8px; margin-top: 20px; }
        .page-item { display: inline-block; }
        .page-link {
            padding: 8px 16px; background: #fff; border: 1px solid var(--border-color); border-radius: 8px;
            color: var(--text-secondary); text-decoration: none; font-weight: 500; transition: all 0.3s;
        }
        .page-item.active .page-link { background: var(--primary); color: #fff; border-color: var(--primary); }
        .page-item:not(.active) .page-link:hover { background: #f1f5f9; color: var(--text-primary); }

        /* 360 Dashboard Modal */
        .dashboard-modal { max-width: 1400px !important; height: 95vh; display: flex; flex-direction: column; padding: 0 !important; overflow: hidden !important; }
        .modal-header-360 { padding: 24px 32px; border-bottom: 1px solid var(--border-color); background: #f8fafc; border-radius: 24px 24px 0 0; display: flex; justify-content: space-between; align-items: center; position: relative; }
        .modal-header-360 h2 { font-size: 24px; color: var(--text-primary); display: flex; align-items: center; gap: 12px; margin: 0; }
        .modal-header-360 h2 i { color: var(--primary); }
        .modal-body-360 { display: flex; flex: 1; overflow: hidden; }
        .sidebar-360 { width: 260px; background: #fff; border-right: 1px solid var(--border-color); padding: 20px 0; overflow-y: auto; }
        .tab-btn { display: block; width: 100%; text-align: left; padding: 16px 24px; border: none; background: none; color: var(--text-secondary); font-size: 14px; font-weight: 600; cursor: pointer; transition: all 0.3s; border-left: 3px solid transparent; }
        .tab-btn:hover { background: var(--hover-bg); color: var(--primary); }
        .tab-btn.active { background: var(--hover-bg); color: var(--primary); border-left-color: var(--primary); }
        .tab-btn i { width: 24px; }
        .content-360 { flex: 1; padding: 32px; overflow-y: auto; background: #f8fafc; }
        .tab-pane { display: none; animation: fadeIn 0.3s ease; }
        .tab-pane.active { display: block; }
        
        .grid-360 { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 24px; margin-bottom: 24px; }
        .card-360 { background: #fff; border-radius: 16px; padding: 24px; border: 1px solid var(--border-color); box-shadow: var(--shadow-sm); }
        .card-360 h3 { font-size: 16px; color: var(--text-primary); margin-bottom: 20px; display: flex; align-items: center; gap: 10px; padding-bottom: 12px; border-bottom: 1px solid var(--border-color); }
        .card-360 h3 i { color: var(--primary); }
        .stat-row { display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px dashed var(--border-color); font-size: 14px; }
        .stat-row:last-child { border-bottom: none; padding-bottom: 0; }
        .stat-row span:first-child { color: var(--text-tertiary); font-weight: 500; }
        .stat-row span:last-child { color: var(--text-primary); font-weight: 700; text-align: right;}
        
        .table-360 { width: 100%; border-collapse: collapse; background: #fff; border-radius: 16px; overflow: hidden; border: 1px solid var(--border-color); }
        .table-360 th { background: #f1f5f9; padding: 16px 20px; font-size: 12px; font-weight: 600; color: var(--text-secondary); text-transform: uppercase; border-bottom: 1px solid var(--border-color); text-align: left; }
        .table-360 td { padding: 16px 20px; font-size: 13px; color: var(--text-primary); border-bottom: 1px solid var(--border-color); }
        .table-360 tr:last-child td { border-bottom: none; }
        
        @keyframes fadeIn { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }
    </style>
</head>

<body>
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
                <i class="fas fa-chart-line"></i> Student Performance
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/schedule-interview" class="nav-link">
                <i class="fas fa-calendar-plus"></i> Schedule Interview
            </a>
        </div>
        <div class="nav-section">
            <h4>Tools</h4>
            <a href="${pageContext.request.contextPath}/hackerrank/chat" class="nav-link">
                <i class="fas fa-comments"></i> Messages
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/review-resumes" class="nav-link">
                <i class="fas fa-file-alt"></i> Review Resumes
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/ai-evaluation/dashboard" class="nav-link">
                <i class="fa-solid fa-robot fa-fw"></i> AI Evaluations
            </a>
            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/candidates" class="nav-link active">
                <i class="fas fa-users fa-fw"></i> Candidates
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
        <div class="top-bar">
            <div>
                <h1><i class="fas fa-users"></i> Candidate Management</h1>
                <p>View all registered candidates and manage their information.</p>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-users"></i></div>
                <div class="stat-value">${totalCandidates}</div>
                <div class="stat-label">Total Candidates</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-file-alt"></i></div>
                <div class="stat-value">${candidatesWithResume}</div>
                <div class="stat-label">With Resumes</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-paper-plane"></i></div>
                <div class="stat-value">${candidatesApplied}</div>
                <div class="stat-label">Applied</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-calendar-check"></i></div>
                <div class="stat-value">${candidatesInterviewScheduled}</div>
                <div class="stat-label">Interviews Scheduled</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon"><i class="fas fa-trophy"></i></div>
                <div class="stat-value">${candidatesHired}</div>
                <div class="stat-label">Hired</div>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/hackerrank/interviewer/candidates" method="GET" class="filter-section">
            <div class="filter-group">
                <label>Search Name / Email</label>
                <input type="text" name="search" value="${search}" class="filter-control" placeholder="Search...">
            </div>
            <div class="filter-group">
                <label>Minimum Experience (Years)</label>
                <input type="number" name="experience" value="${experience}" class="filter-control" placeholder="e.g. 2">
            </div>
            <div class="filter-group">
                <label>Location</label>
                <select name="location" class="filter-control">
                    <option value="">All Locations</option>
                    <option value="BANGALORE" ${location == 'BANGALORE' ? 'selected' : ''}>Bangalore</option>
                    <option value="HYDERABAD" ${location == 'HYDERABAD' ? 'selected' : ''}>Hyderabad</option>
                    <option value="PUNE" ${location == 'PUNE' ? 'selected' : ''}>Pune</option>
                    <option value="MUMBAI" ${location == 'MUMBAI' ? 'selected' : ''}>Mumbai</option>
                    <option value="CHENNAI" ${location == 'CHENNAI' ? 'selected' : ''}>Chennai</option>
                    <option value="DELHI" ${location == 'DELHI' ? 'selected' : ''}>Delhi</option>
                </select>
            </div>
            <div class="filter-group">
                <label>Sort By</label>
                <select name="sort" class="filter-control">
                    <option value="newest" ${sort == 'newest' ? 'selected' : ''}>Newest First</option>
                    <option value="oldest" ${sort == 'oldest' ? 'selected' : ''}>Oldest First</option>
                    <option value="name" ${sort == 'name' ? 'selected' : ''}>Name A-Z</option>
                    <option value="experienced" ${sort == 'experienced' ? 'selected' : ''}>Most Experienced</option>
                </select>
            </div>
            <button type="submit" class="btn-filter"><i class="fas fa-filter"></i> Apply Filters</button>
        </form>

        <div class="table-container">
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Candidate</th>
                            <th>Contact</th>
                            <th>Experience</th>
                            <th>Education</th>
                            <th>Location</th>
                            <th>Resume Status</th>
                            <th>Reg. Date</th>
                            <th>Profile</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="candidate" items="${candidatesPage.content}">
                            <tr>
                                <td>
                                    <div class="candidate-cell">
                                        <div class="candidate-avatar">
                                            <c:choose>
                                                <c:when test="${not empty candidate.profilePicture}">
                                                    <c:set var="initial" value="${not empty candidate.name ? candidate.name.substring(0,1).toUpperCase() : 'C'}" />
                                                    <img src="${pageContext.request.contextPath}/${candidate.profilePicture}" alt="" onerror="this.onerror=null; this.outerHTML='<span>${initial}</span>';">
                                                </c:when>
                                                <c:otherwise>
                                                    ${not empty candidate.name ? candidate.name.substring(0,1).toUpperCase() : 'C'}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="candidate-info">
                                            <h4>${candidate.name}</h4>
                                            <p>${candidate.gender != null ? candidate.gender : 'Not Specified'}</p>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="candidate-info">
                                        <p><i class="fas fa-envelope text-secondary"></i> ${candidate.email}</p>
                                        <p><i class="fas fa-phone text-secondary"></i> ${not empty candidate.phone ? candidate.phone : 'N/A'}</p>
                                    </div>
                                </td>
                                <td>${candidate.experience != null ? candidate.experience.toString().concat(' Years') : 'Fresher'}</td>
                                <td>${candidate.education != null ? candidate.education : 'Not Specified'}</td>
                                <td>${candidate.location != null ? candidate.location : 'Not Specified'}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty candidate.resumeUploaded}">
                                            <span class="badge badge-success"><i class="fas fa-check-circle"></i> Uploaded</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-warning"><i class="fas fa-exclamation-circle"></i> Not Uploaded</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>${candidate.createdAt != null ? candidate.createdAt : 'N/A'}</td>
                                <td>
                                    <button onclick="viewProfile(${candidate.id})" class="btn-profile"><i class="fas fa-user-circle"></i> View Profile</button>
                                </td>
                                <td>
                                    <div class="dropdown">
                                        <button class="dropbtn">Actions <i class="fas fa-chevron-down ms-1"></i></button>
                                        <div class="dropdown-content">
                                            <c:if test="${not empty candidate.resumeUploaded}">
                                                <a href="${pageContext.request.contextPath}/${candidate.resumeUploaded}" target="_blank"><i class="fas fa-file-pdf"></i> View Resume</a>
                                                <a href="${pageContext.request.contextPath}/${candidate.resumeUploaded}" download><i class="fas fa-download"></i> Download Resume</a>
                                            </c:if>
                                            <a href="${pageContext.request.contextPath}/hackerrank/interviewer/schedule-interview?studentId=${candidate.id}"><i class="fas fa-calendar-plus"></i> Schedule Interview</a>
                                            <a href="${pageContext.request.contextPath}/hackerrank/chat/${candidate.id}?type=STUDENT"><i class="fas fa-comment-dots"></i> Send Message</a>
                                            <button onclick="viewActivity(${candidate.id})"><i class="fas fa-history"></i> View Activity</button>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty candidatesPage.content}">
                            <tr><td colspan="9" style="text-align:center; padding: 40px; color: #64748b;">No candidates found matching your criteria.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            
            <c:if test="${candidatesPage.totalPages > 1}">
                <div style="padding: 20px; border-top: 1px solid var(--border-color);">
                    <ul class="pagination">
                        <c:forEach begin="0" end="${candidatesPage.totalPages - 1}" var="i">
                            <li class="page-item ${i == candidatesPage.number ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&size=${candidatesPage.size}&search=${search}&experience=${experience}&location=${location}&sort=${sort}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Profile Modal -->
    <div class="modal-overlay" id="profileModal">
        <div class="modal-content">
            <div class="modal-close" onclick="closeModal('profileModal')"><i class="fas fa-times"></i></div>
            <div class="modal-header">
                <h2><i class="fas fa-id-card"></i> Candidate Profile</h2>
            </div>
            <div class="profile-grid" id="profileContent">
                <!-- Data populated by JS -->
                <div style="text-align:center; width:100%; grid-column: 1 / -1;"><i class="fas fa-spinner fa-spin fa-2x"></i></div>
            </div>
        </div>
    </div>

    <!-- Activity Modal (360 Dashboard) -->
    <div class="modal-overlay" id="activityModal">
        <div class="modal-content dashboard-modal">
            <div class="modal-header-360">
                <h2><i class="fas fa-chart-pie"></i> Candidate 360° Performance Dashboard</h2>
                <div class="modal-close" style="position:relative; top:0; right:0;" onclick="closeModal('activityModal')"><i class="fas fa-times"></i></div>
            </div>
            <div class="modal-body-360">
                <div class="sidebar-360">
                    <button class="tab-btn active" onclick="switchTab('tab-overview')"><i class="fas fa-home"></i> Overview</button>
                    <button class="tab-btn" onclick="switchTab('tab-login')"><i class="fas fa-sign-in-alt"></i> Login History</button>
                    <button class="tab-btn" onclick="switchTab('tab-coding')"><i class="fas fa-code"></i> Coding Performance</button>
                    <button class="tab-btn" onclick="switchTab('tab-questions')"><i class="fas fa-list-ol"></i> Question History</button>
                    <button class="tab-btn" onclick="switchTab('tab-jobs')"><i class="fas fa-briefcase"></i> Job Activity</button>
                    <button class="tab-btn" onclick="switchTab('tab-interviews')"><i class="fas fa-user-tie"></i> Interview History</button>
                    <button class="tab-btn" onclick="switchTab('tab-resume')"><i class="fas fa-file-pdf"></i> Resume History</button>
                    <button class="tab-btn" onclick="switchTab('tab-timeline')"><i class="fas fa-stream"></i> Full Timeline</button>
                </div>
                <div class="content-360">
                    <div id="loader-360" style="text-align:center; padding-top:100px;"><i class="fas fa-spinner fa-spin fa-3x" style="color:var(--primary);"></i><p style="margin-top:20px;color:var(--text-secondary);">Compiling comprehensive report...</p></div>
                    
                    <div id="dashboard-content" style="display:none;">
                        <!-- Overview Tab -->
                        <div id="tab-overview" class="tab-pane active">
                            <h2 style="margin-bottom:24px;">Performance Summary</h2>
                            <div class="grid-360">
                                <div class="card-360">
                                    <h3><i class="fas fa-chart-bar"></i> Quick Stats</h3>
                                    <div id="overview-stats"></div>
                                </div>
                                <div class="card-360">
                                    <h3><i class="fas fa-id-card"></i> Profile Completion</h3>
                                    <div id="overview-profile"></div>
                                </div>
                            </div>
                        </div>

                        <!-- Login History Tab -->
                        <div id="tab-login" class="tab-pane">
                            <h2 style="margin-bottom:24px;">Login & Session History</h2>
                            <div class="card-360">
                                <h3><i class="fas fa-shield-alt"></i> Access Logs</h3>
                                <div id="login-history"></div>
                            </div>
                        </div>

                        <!-- Coding Tab -->
                        <div id="tab-coding" class="tab-pane">
                            <h2 style="margin-bottom:24px;">Coding Performance</h2>
                            <div class="grid-360">
                                <div class="card-360">
                                    <h3><i class="fas fa-trophy"></i> Accuracy & Stats</h3>
                                    <div id="coding-stats"></div>
                                </div>
                            </div>
                        </div>

                        <!-- Questions Tab -->
                        <div id="tab-questions" class="tab-pane">
                            <h2 style="margin-bottom:24px;">Every Question Attempted</h2>
                            <div id="questions-history"></div>
                        </div>

                        <!-- Jobs Tab -->
                        <div id="tab-jobs" class="tab-pane">
                            <h2 style="margin-bottom:24px;">Job Application History</h2>
                            <div class="grid-360">
                                <div class="card-360">
                                    <h3><i class="fas fa-chart-pie"></i> Funnel Stats</h3>
                                    <div id="job-stats"></div>
                                </div>
                            </div>
                            <h3 style="margin:24px 0 16px;">Detailed Applications</h3>
                            <div id="job-list"></div>
                        </div>

                        <!-- Interviews Tab -->
                        <div id="tab-interviews" class="tab-pane">
                            <h2 style="margin-bottom:24px;">Mock & Live Interviews</h2>
                            <div id="interview-list"></div>
                        </div>

                        <!-- Resumes Tab -->
                        <div id="tab-resume" class="tab-pane">
                            <h2 style="margin-bottom:24px;">Resume Upload History</h2>
                            <div id="resume-list"></div>
                        </div>

                        <!-- Timeline Tab -->
                        <div id="tab-timeline" class="tab-pane">
                            <h2 style="margin-bottom:24px;">Complete Platform Activity</h2>
                            <div class="filter-section" style="padding:16px; margin-bottom:20px;">
                                <div class="filter-group" style="flex-direction:row; align-items:center;">
                                    <label style="margin:0; width:100px;">Filter Activity:</label>
                                    <select id="timeline-filter" class="filter-control" style="width:250px;" onchange="renderTimeline()">
                                        <option value="ALL">All Activities</option>
                                        <option value="LOG">Logins / Logouts</option>
                                        <option value="JOB">Job Related</option>
                                        <option value="CODING">Coding Tests</option>
                                        <option value="INTERVIEW">Interviews</option>
                                    </select>
                                </div>
                            </div>
                            <div class="timeline" id="full-timeline"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openModal(id) {
            document.getElementById(id).style.display = 'flex';
        }
        function closeModal(id) {
            document.getElementById(id).style.display = 'none';
        }

        async function viewProfile(id) {
            openModal('profileModal');
            const content = document.getElementById('profileContent');
            content.innerHTML = '<div style="text-align:center; width:100%; grid-column: 1 / -1;"><i class="fas fa-spinner fa-spin fa-2x"></i> Loading profile...</div>';
            
            try {
                const response = await fetch(`${pageContext.request.contextPath}/hackerrank/interviewer/api/candidate-profile/` + id);
                if (!response.ok) throw new Error("Failed to fetch profile");
                const data = await response.json();
                
                content.innerHTML = `
                    <div class="profile-item"><label>Full Name</label><p>` + (data.name || 'N/A') + `</p></div>
                    <div class="profile-item"><label>Email</label><p>` + (data.email || 'N/A') + `</p></div>
                    <div class="profile-item"><label>Phone</label><p>` + (data.phone || 'N/A') + `</p></div>
                    <div class="profile-item"><label>Location</label><p>` + (data.location || 'N/A') + `</p></div>
                    <div class="profile-item"><label>Experience</label><p>` + (data.experience ? data.experience + ' Years' : 'Fresher') + `</p></div>
                    <div class="profile-item"><label>Education Level</label><p>` + (data.education || 'N/A') + `</p></div>
                    <div class="profile-item"><label>UG Details</label><p>` + (data.ugDegree || 'N/A') + ` - ` + (data.ugUniversity || '') + `</p></div>
                    <div class="profile-item"><label>PG Details</label><p>` + (data.pgDegree || 'N/A') + ` - ` + (data.pgUniversity || '') + `</p></div>
                    <div class="profile-item" style="grid-column: 1 / -1;"><label>Skills</label><p>` + (data.skills && data.skills.length ? data.skills.join(', ') : 'No skills listed') + `</p></div>
                `;
            } catch (error) {
                content.innerHTML = '<div style="color:red; grid-column: 1 / -1;">Error loading profile.</div>';
            }
        }

        let candidate360Data = null;

        function switchTab(tabId) {
            document.querySelectorAll('.tab-pane').forEach(el => el.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(el => el.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            event.currentTarget.classList.add('active');
        }

        async function viewActivity(id) {
            openModal('activityModal');
            document.getElementById('loader-360').style.display = 'block';
            document.getElementById('dashboard-content').style.display = 'none';
            
            try {
                const response = await fetch(`${pageContext.request.contextPath}/hackerrank/interviewer/api/candidate-activities/` + id);
                if (!response.ok) throw new Error("Failed to fetch activity");
                candidate360Data = await response.json();
                
                renderDashboard(candidate360Data);

                document.getElementById('loader-360').style.display = 'none';
                document.getElementById('dashboard-content').style.display = 'block';
            } catch (error) {
                console.error(error);
                document.getElementById('loader-360').innerHTML = '<div style="color:red; padding:40px;">Error loading Candidate 360 dashboard.</div>';
            }
        }

        function renderDashboard(data) {
            // 9. Overview
            if(data.performanceSummary) {
                document.getElementById('overview-stats').innerHTML = `
                    <div class="stat-row"><span>Total Platform Logins</span><span>` + data.performanceSummary.totalLogins + `</span></div>
                    <div class="stat-row"><span>Coding Questions Solved</span><span>` + data.performanceSummary.questionsSolved + `</span></div>
                    <div class="stat-row"><span>Overall Coding Accuracy</span><span>` + data.performanceSummary.codingAccuracy + `%</span></div>
                    <div class="stat-row"><span>Job Applications</span><span>` + data.performanceSummary.applications + `</span></div>
                    <div class="stat-row"><span>Interviews Conducted</span><span>` + data.performanceSummary.interviews + `</span></div>
                `;
            }
            if(data.profileActivity) {
                document.getElementById('overview-profile').innerHTML = `
                    <div style="margin-bottom:12px; font-weight:600; color:var(--primary);">Profile Completion: ` + data.profileActivity.completion + `%</div>
                    <div class="stat-row"><span>Skills Linked</span><span>` + (data.profileActivity.skills ? data.profileActivity.skills.length : 0) + `</span></div>
                    <div class="stat-row"><span>Education Details</span><span>` + (data.profileActivity.education ? "Added" : "Missing") + `</span></div>
                    <div class="stat-row"><span>Experience Details</span><span>` + (data.profileActivity.experience ? "Added" : "Missing") + `</span></div>
                `;
            }

            // 1. Login History
            if(data.loginHistory) {
                document.getElementById('login-history').innerHTML = `
                    <div class="stat-row"><span>Current Status</span><span style="color:` + (data.loginHistory.status === 'Online' ? 'var(--success)' : 'var(--text-secondary)') + `">` + data.loginHistory.status + `</span></div>
                    <div class="stat-row"><span>Total Logins</span><span>` + data.loginHistory.totalLogins + `</span></div>
                    <div class="stat-row"><span>Total Logouts</span><span>` + data.loginHistory.totalLogouts + `</span></div>
                    <div class="stat-row"><span>Last Login</span><span>` + (data.loginHistory.lastLogin ? new Date(data.loginHistory.lastLogin).toLocaleString() : 'N/A') + `</span></div>
                    <div class="stat-row"><span>First Login</span><span>` + (data.loginHistory.firstLogin ? new Date(data.loginHistory.firstLogin).toLocaleString() : 'N/A') + `</span></div>
                    <div class="stat-row"><span>Last Browser</span><span>` + data.loginHistory.browser + `</span></div>
                    <div class="stat-row"><span>Last OS</span><span>` + data.loginHistory.os + `</span></div>
                    <div class="stat-row"><span>Last IP Address</span><span>` + data.loginHistory.ipAddress + `</span></div>
                `;
            }

            // 2. Coding Stats
            if(data.codingPerformance) {
                document.getElementById('coding-stats').innerHTML = `
                    <div class="stat-row"><span>Total Attempts</span><span>` + data.codingPerformance.attempted + `</span></div>
                    <div class="stat-row"><span>Correct Solutions</span><span>` + data.codingPerformance.correct + `</span></div>
                    <div class="stat-row"><span>Distinct Questions Solved</span><span>` + data.codingPerformance.solved + `</span></div>
                    <div class="stat-row"><span>Total Execution Time</span><span>` + data.codingPerformance.totalTime + ` ms</span></div>
                    <div class="stat-row"><span>Average Time/Question</span><span>` + data.codingPerformance.avgTime + ` ms</span></div>
                `;
            }

            // 3. Question History
            if(data.questionHistory) {
                let qHtml = `<table class="table-360"><thead><tr><th>Question</th><th>Type</th><th>Status</th><th>Score</th><th>Exec Time</th><th>Submitted</th></tr></thead><tbody>`;
                if(data.questionHistory.length === 0) qHtml += `<tr><td colspan="6" style="text-align:center;">No questions attempted</td></tr>`;
                data.questionHistory.forEach(q => {
                    qHtml += `<tr>
                        <td><strong>` + q.questionName + `</strong></td>
                        <td><span class="badge badge-` + (q.type === 'CODING' ? 'success' : 'warning') + `">` + q.type + `</span></td>
                        <td>` + q.status + `</td>
                        <td>` + q.score + `</td>
                        <td>` + q.executionTime + `</td>
                        <td>` + (q.submittedAt ? new Date(q.submittedAt).toLocaleString() : 'N/A') + `</td>
                    </tr>`;
                });
                qHtml += `</tbody></table>`;
                document.getElementById('questions-history').innerHTML = qHtml;
            }

            // 7. Jobs
            if(data.jobHistory) {
                document.getElementById('job-stats').innerHTML = `
                    <div class="stat-row"><span>Total Applied</span><span>` + data.jobHistory.applied + `</span></div>
                    <div class="stat-row"><span>Saved Jobs</span><span>` + data.jobHistory.saved + `</span></div>
                    <div class="stat-row"><span>Shortlisted</span><span>` + data.jobHistory.shortlisted + `</span></div>
                    <div class="stat-row"><span>Selected (Hired)</span><span style="color:var(--success)">` + data.jobHistory.selected + `</span></div>
                    <div class="stat-row"><span>Rejected</span><span style="color:var(--danger)">` + data.jobHistory.rejected + `</span></div>
                `;

                let jHtml = `<table class="table-360"><thead><tr><th>Job Title</th><th>Company</th><th>Status</th><th>Applied On</th></tr></thead><tbody>`;
                if(data.jobHistory.history.length === 0) jHtml += `<tr><td colspan="4" style="text-align:center;">No job applications</td></tr>`;
                data.jobHistory.history.forEach(j => {
                    jHtml += `<tr>
                        <td><strong>` + j.jobTitle + `</strong></td>
                        <td>` + j.company + `</td>
                        <td><span class="badge badge-success">` + j.status + `</span></td>
                        <td>` + (j.appliedAt ? new Date(j.appliedAt).toLocaleString() : 'N/A') + `</td>
                    </tr>`;
                });
                jHtml += `</tbody></table>`;
                document.getElementById('job-list').innerHTML = jHtml;
            }

            // 5. Interviews
            if(data.interviewHistory) {
                let iHtml = `<table class="table-360"><thead><tr><th>Interview</th><th>Interviewer</th><th>Scheduled</th><th>Status</th><th>Score (Overall / Tech)</th></tr></thead><tbody>`;
                if(data.interviewHistory.length === 0) iHtml += `<tr><td colspan="5" style="text-align:center;">No interviews scheduled</td></tr>`;
                data.interviewHistory.forEach(i => {
                    iHtml += `<tr>
                        <td><strong>` + i.name + `</strong></td>
                        <td>` + i.interviewer + `</td>
                        <td>` + (i.scheduledAt ? new Date(i.scheduledAt).toLocaleString() : 'N/A') + `</td>
                        <td>` + i.status + `</td>
                        <td>` + i.overallScore + ` / ` + i.techScore + `</td>
                    </tr>`;
                });
                iHtml += `</tbody></table>`;
                document.getElementById('interview-list').innerHTML = iHtml;
            }

            // 6. Resumes
            if(data.resumeHistory) {
                let rHtml = `<table class="table-360"><thead><tr><th>File Name</th><th>Uploaded At</th><th>Status</th><th>AI Score</th></tr></thead><tbody>`;
                if(data.resumeHistory.length === 0) rHtml += `<tr><td colspan="4" style="text-align:center;">No resumes uploaded</td></tr>`;
                data.resumeHistory.forEach(r => {
                    rHtml += `<tr>
                        <td><strong>` + r.fileName + `</strong></td>
                        <td>` + (r.uploadedAt ? new Date(r.uploadedAt).toLocaleString() : 'N/A') + `</td>
                        <td>` + r.status + `</td>
                        <td>` + r.score + `</td>
                    </tr>`;
                });
                rHtml += `</tbody></table>`;
                document.getElementById('resume-list').innerHTML = rHtml;
            }

            // 4 & 10. Timeline
            renderTimeline();
        }

        function renderTimeline() {
            if(!candidate360Data || !candidate360Data.timeline) return;
            const filter = document.getElementById('timeline-filter').value;
            let filtered = candidate360Data.timeline;
            
            if(filter === 'LOG') {
                filtered = filtered.filter(a => a.activityType.includes('LOG'));
            } else if(filter === 'JOB') {
                filtered = filtered.filter(a => a.activityType.includes('JOB') || a.activityType.includes('COMPANY'));
            } else if(filter === 'CODING') {
                filtered = filtered.filter(a => a.activityType.includes('CODING') || a.activityType.includes('QUESTION'));
            } else if(filter === 'INTERVIEW') {
                filtered = filtered.filter(a => a.activityType.includes('INTERVIEW'));
            }

            let html = '';
            if(filtered.length === 0) {
                html = '<p style="text-align:center; padding:20px; color:var(--text-secondary);">No activities found for this filter.</p>';
            } else {
                filtered.forEach(act => {
                    const date = new Date(act.createdAt).toLocaleString();
                    html += `
                    <div class="timeline-item">
                        <div class="timeline-date">` + date + `</div>
                        <div class="timeline-content" style="background:#fff;">
                            <h4 style="color:var(--primary); font-weight:700; margin-bottom:4px;">` + act.activityType.replace(/_/g, ' ') + `</h4>
                            <p>` + (act.description || 'Action performed on the platform') + `</p>
                        </div>
                    </div>`;
                });
            }
            document.getElementById('full-timeline').innerHTML = html;
        }

        // Close modals on outside click
        window.onclick = function(event) {
            const profileModal = document.getElementById('profileModal');
            const activityModal = document.getElementById('activityModal');
            if (event.target == profileModal) closeModal('profileModal');
            if (event.target == activityModal) closeModal('activityModal');
        }
    </script>
</body>
</html>
