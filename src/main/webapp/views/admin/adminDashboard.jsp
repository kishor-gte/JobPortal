<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
<title>JobU Admin Dashboard | Premium Control Center</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome Icons -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<!-- Google Fonts -->
<link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800&display=swap" rel="stylesheet">
<!-- Mobile Responsive CSS -->
<link href="${pageContext.request.contextPath}/css/mobile-responsive.css" rel="stylesheet">

<style>
/* ============================================
   PREMIUM COLOR SCHEME
   --primary: #19A77B
   --primary-dark: #148F69
   --accent: #3BC49A
   --bg-dark: #2E3E41
   ============================================ */
:root {
  --primary: #19A77B;
  --primary-dark: #148F69;
  --primary-light: #3BC49A;
  --accent: #3BC49A;
  --accent-light: #6ed4b2;
  --bg-dark: #2E3E41;
  --bg-dark-light: #3d5256;
  --success: #10b981;
  --success-dark: #059669;
  --warning: #f59e0b;
  --warning-dark: #d97706;
  --danger: #ef4444;
  --danger-dark: #dc2626;
  --info: #06b6d4;
  --info-dark: #0891b2;
  --bg-light: #f0f7f4;
  --bg-white: #ffffff;
  --text-dark: #1e2a2e;
  --text-muted: #5b7c6e;
  --border: #e2ede7;
  --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.03);
  --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.05);
  --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.08);
  --shadow-xl: 0 25px 50px -12px rgba(25, 167, 123, 0.25);
  --transition: all 0.35s cubic-bezier(0.2, 0.9, 0.4, 1.1);
  --radius-sm: 12px;
  --radius-md: 16px;
  --radius-lg: 24px;
}

* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

body {
  font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
  background: radial-gradient(ellipse at 20% 30%, #eef7f2 0%, #e0ece6 100%);
  color: var(--text-dark);
  line-height: 1.6;
  position: relative;
  overflow-x: hidden;
}

/* animated background mesh */
body::before {
  content: '';
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: 
    radial-gradient(circle at 15% 30%, rgba(25,167,123,0.05) 0%, transparent 40%),
    radial-gradient(circle at 85% 70%, rgba(59,196,154,0.04) 0%, transparent 45%),
    radial-gradient(circle at 50% 90%, rgba(25,167,123,0.03) 0%, transparent 50%);
  pointer-events: none;
  z-index: 0;
  animation: meshFloat 18s ease-in-out infinite alternate;
}

@keyframes meshFloat {
  0% { opacity: 0.5; transform: scale(1); }
  100% { opacity: 1; transform: scale(1.03); }
}

/* floating particles */
body::after {
  content: '';
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-image: radial-gradient(circle at 20% 40%, rgba(25,167,123,0.06) 1px, transparent 1px);
  background-size: 32px 32px;
  pointer-events: none;
  animation: particleDrift 25s linear infinite;
}

@keyframes particleDrift {
  0% { background-position: 0 0; }
  100% { background-position: 65px 65px; }
}

/* Navbar Premium */
.navbar-custom {
  background: linear-gradient(135deg, var(--bg-dark) 0%, #1f2e30 100%);
  box-shadow: var(--shadow-lg);
  padding: 0.875rem 0;
  position: sticky;
  top: 0;
  z-index: 1000;
  backdrop-filter: blur(10px);
}

.navbar-brand-custom {
  color: white !important;
  font-weight: 800;
  font-size: 1.35rem;
  display: flex;
  align-items: center;
  gap: 0.6rem;
  transition: var(--transition);
}

.navbar-brand-custom:hover {
  color: var(--accent) !important;
  transform: scale(1.02);
}

.navbar-brand-custom i {
  font-size: 1.6rem;
  background: linear-gradient(135deg, var(--accent), var(--primary));
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  animation: gentlePulse 2s ease-in-out infinite;
}

@keyframes gentlePulse {
  0%, 100% { opacity: 0.9; transform: scale(1); }
  50% { opacity: 1; transform: scale(1.05); }
}

.btn-logout {
  background: rgba(255, 255, 255, 0.12);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  color: white;
  padding: 0.5rem 1.2rem;
  border-radius: 40px;
  font-weight: 600;
  transition: var(--transition);
  display: inline-flex;
  align-items: center;
  gap: 0.6rem;
}

.btn-logout:hover {
  background: white;
  color: var(--primary-dark);
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}

/* Dashboard Header */
.dashboard-header {
  background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
  color: white;
  padding: 2.5rem 0;
  margin-bottom: 2rem;
  position: relative;
  overflow: hidden;
}

.dashboard-header::before {
  content: '';
  position: absolute;
  top: -50%;
  right: -20%;
  width: 400px;
  height: 400px;
  background: radial-gradient(circle, rgba(59,196,154,0.15), transparent);
  border-radius: 50%;
  animation: floatGlow 15s ease-in-out infinite;
}

@keyframes floatGlow {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(-30px, 20px) scale(1.1); }
}

.dashboard-header h1 {
  font-size: 2rem;
  font-weight: 800;
  margin-bottom: 0.5rem;
  letter-spacing: -0.5px;
  position: relative;
  z-index: 1;
}

.dashboard-header p {
  font-size: 1rem;
  opacity: 0.9;
  position: relative;
  z-index: 1;
}

/* Stats Wrapper */
.stats-wrapper {
  margin-bottom: 2rem;
  background: linear-gradient(135deg, var(--bg-dark) 0%, var(--primary-dark) 100%);
  padding: 2rem 0;
  border-radius: 1.5rem;
  margin-top: -1rem;
  margin-left: -0.75rem;
  margin-right: -0.75rem;
  position: relative;
  overflow: hidden;
}

/* Stats Cards Premium */
.stat-card {
  background: rgba(255, 255, 255, 0.97);
  backdrop-filter: blur(10px);
  border-radius: var(--radius-md);
  padding: 1.5rem;
  box-shadow: var(--shadow-sm);
  transition: var(--transition);
  border-top: 4px solid var(--primary);
  height: 100%;
  position: relative;
  overflow: hidden;
}

.stat-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(25,167,123,0.08), transparent);
  transition: left 0.6s ease;
}

.stat-card:hover::before {
  left: 100%;
}

.stat-card:hover {
  transform: translateY(-8px) scale(1.02);
  box-shadow: var(--shadow-xl);
}

.stat-card-link {
  text-decoration: none;
  color: inherit;
  display: block;
  height: 100%;
  cursor: pointer;
}

.stat-card-link:hover {
  text-decoration: none;
  color: inherit;
}

.stat-card.success { border-top-color: var(--success); }
.stat-card.warning { border-top-color: var(--warning); }
.stat-card.danger { border-top-color: var(--danger); }
.stat-card.info { border-top-color: var(--info); }

.stat-card-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 1rem;
}

.stat-icon {
  width: 70px;
  height: 70px;
  border-radius: var(--radius-sm);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.75rem;
  color: white;
  background: linear-gradient(135deg, var(--primary), var(--primary-light));
  box-shadow: var(--shadow-md);
  transition: var(--transition);
}

.stat-card:hover .stat-icon {
  transform: scale(1.1) rotate(5deg);
  box-shadow: var(--shadow-lg);
}

.stat-card.success .stat-icon { background: linear-gradient(135deg, var(--success), var(--success-dark)); }
.stat-card.warning .stat-icon { background: linear-gradient(135deg, var(--warning), var(--warning-dark)); }
.stat-card.danger .stat-icon { background: linear-gradient(135deg, var(--danger), var(--danger-dark)); }
.stat-card.info .stat-icon { background: linear-gradient(135deg, var(--info), var(--info-dark)); }

.stat-value {
  font-size: 2.2rem;
  font-weight: 800;
  background: linear-gradient(135deg, var(--text-dark), var(--primary));
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  line-height: 1.2;
  margin-bottom: 0.25rem;
}

.stat-label {
  font-size: 0.8rem;
  color: var(--text-muted);
  font-weight: 600;
  text-transform: uppercase;
  letter-spacing: 0.8px;
}

/* Section Title */
.section-title {
  font-size: 1.6rem;
  font-weight: 800;
  color: var(--text-dark);
  margin-bottom: 1.5rem;
  padding-bottom: 0.75rem;
  border-bottom: 3px solid var(--primary);
  display: inline-block;
  letter-spacing: -0.3px;
}

/* Action Cards Premium */
.action-card {
  background: rgba(255, 255, 255, 0.97);
  backdrop-filter: blur(8px);
  border-radius: var(--radius-md);
  padding: 1.75rem;
  box-shadow: var(--shadow-sm);
  transition: var(--transition);
  border: 1px solid var(--border);
  text-decoration: none;
  color: var(--text-dark);
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  height: 100%;
  position: relative;
  overflow: hidden;
}

.action-card::after {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: radial-gradient(circle, rgba(25,167,123,0.08) 0%, transparent 70%);
  transform: scale(0);
  transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1);
}

.action-card:hover::after {
  transform: scale(1);
}

.action-card:hover {
  transform: translateY(-8px) scale(1.02);
  box-shadow: var(--shadow-xl);
  border-color: var(--primary);
  color: var(--primary-dark);
  text-decoration: none;
}

.action-icon {
  width: 90px;
  height: 90px;
  border-radius: var(--radius-sm);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 2.5rem;
  color: white;
  background: linear-gradient(135deg, var(--primary), var(--primary-light));
  margin-bottom: 1rem;
  transition: var(--transition);
  box-shadow: var(--shadow-md);
  position: relative;
  z-index: 1;
}

.action-card:hover .action-icon {
  transform: scale(1.15) rotate(8deg);
  box-shadow: var(--shadow-lg);
}

.action-card.users .action-icon { background: linear-gradient(135deg, var(--success), var(--success-dark)); }
.action-card.companies .action-icon { background: linear-gradient(135deg, var(--info), var(--info-dark)); }
.action-card.reports .action-icon { background: linear-gradient(135deg, var(--warning), var(--warning-dark)); }
.action-card.qa .action-icon { background: linear-gradient(135deg, #8b5cf6, #7c3aed); }
.action-card.assessments .action-icon { background: linear-gradient(135deg, var(--danger), var(--danger-dark)); }
.action-card.sports .action-icon { background: linear-gradient(135deg, #10b981, #059669); }

.action-title {
  font-size: 1.1rem;
  font-weight: 700;
  margin-bottom: 0.5rem;
  position: relative;
  z-index: 1;
}

.action-desc {
  font-size: 0.8rem;
  color: var(--text-muted);
  margin: 0;
  position: relative;
  z-index: 1;
}

/* HR Stats Grid */
.hr-stats-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 20px;
  margin-bottom: 24px;
}

.hr-stat-card {
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(8px);
  border: 1px solid var(--border);
  border-radius: var(--radius-sm);
  padding: 1.25rem;
  transition: var(--transition);
  box-shadow: var(--shadow-sm);
}

.hr-stat-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: var(--primary);
}

.hr-stat-icon {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 12px;
  font-size: 1.3rem;
}

.hr-stat-icon.orange { background: rgba(249, 115, 22, 0.15); color: #f97316; }
.hr-stat-icon.blue { background: rgba(59, 130, 246, 0.15); color: #3b82f6; }
.hr-stat-icon.green { background: rgba(34, 197, 94, 0.15); color: #22c55e; }
.hr-stat-icon.purple { background: rgba(139, 92, 246, 0.15); color: #8b5cf6; }
.hr-stat-icon.cyan { background: rgba(6, 182, 212, 0.15); color: #06b6d4; }
.hr-stat-icon.pink { background: rgba(236, 72, 153, 0.15); color: #ec4899; }
.hr-stat-icon.yellow { background: rgba(234, 179, 8, 0.15); color: #eab308; }
.hr-stat-icon.red { background: rgba(239, 68, 68, 0.15); color: #ef4444; }

.hr-stat-value {
  font-size: 1.6rem;
  font-weight: 800;
  color: var(--text-dark);
  margin-bottom: 4px;
}

.hr-stat-label {
  font-size: 0.7rem;
  color: var(--text-muted);
  font-weight: 600;
  letter-spacing: 0.5px;
}

/* ============================================
   ENHANCED CONTENT GRID - Better Alignment
   ============================================ */
.hr-content-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 28px;
  margin-top: 24px;
}

.hr-card {
  background: rgba(255, 255, 255, 0.96);
  backdrop-filter: blur(8px);
  border: 1px solid var(--border);
  border-radius: var(--radius-lg);
  padding: 1.5rem;
  box-shadow: var(--shadow-md);
  transition: all 0.3s ease;
}

.hr-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-lg);
  border-color: rgba(25,167,123,0.3);
}

.hr-card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1.5rem;
  padding-bottom: 0.75rem;
  border-bottom: 2px solid rgba(25,167,123,0.12);
}

.hr-card-header h3 {
  font-size: 1rem;
  font-weight: 700;
  color: var(--text-dark);
  display: flex;
  align-items: center;
  gap: 8px;
  margin: 0;
}

.hr-card-header a {
  color: var(--primary);
  text-decoration: none;
  font-size: 0.75rem;
  font-weight: 600;
  padding: 4px 10px;
  border-radius: 20px;
  background: rgba(25,167,123,0.08);
  transition: all 0.2s ease;
}

.hr-card-header a:hover {
  background: var(--primary);
  color: white;
  text-decoration: none;
}

/* Enhanced User Items - Better Alignment */
.hr-user-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem;
  background: var(--bg-light);
  border-radius: 12px;
  margin-bottom: 8px;
  transition: all 0.25s ease;
}

.hr-user-item:hover {
  transform: translateX(4px);
  background: white;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.hr-user-info {
  display: flex;
  align-items: center;
  gap: 12px;
  flex: 1;
}

.hr-user-avatar {
  width: 40px;
  height: 40px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.9rem;
  font-weight: 700;
  color: white;
  flex-shrink: 0;
}

.hr-user-avatar.admin { background: linear-gradient(135deg, #f97316, #ef4444); }
.hr-user-avatar.student { background: linear-gradient(135deg, #6366f1, #8b5cf6); }
.hr-user-avatar.interviewer { background: linear-gradient(135deg, #22c55e, #16a34a); }
.hr-user-avatar.company { background: linear-gradient(135deg, #10b981, #059669); }

.hr-user-details {
  flex: 1;
}

.hr-user-name {
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--text-dark);
  display: block;
  margin-bottom: 2px;
}

.hr-user-meta {
  font-size: 0.7rem;
  color: var(--text-muted);
  display: flex;
  align-items: center;
  gap: 6px;
}

.hr-user-role {
  font-size: 0.7rem;
  padding: 4px 12px;
  border-radius: 20px;
  font-weight: 600;
  white-space: nowrap;
  flex-shrink: 0;
}

.hr-role-admin { background: rgba(249, 115, 22, 0.15); color: #f97316; }
.hr-role-student { background: rgba(99, 102, 241, 0.15); color: #6366f1; }
.hr-role-interviewer { background: rgba(34, 197, 94, 0.15); color: #22c55e; }
.hr-role-company { background: rgba(16, 185, 129, 0.15); color: #10b981; }

/* Enhanced Performance Items */
.hr-perf-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.6rem 0.75rem;
  background: var(--bg-light);
  border-radius: 10px;
  margin-bottom: 8px;
  transition: all 0.25s ease;
}

.hr-perf-item:hover {
  transform: translateX(4px);
  background: white;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.hr-perf-name {
  font-size: 0.8rem;
  color: var(--text-dark);
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 6px;
}

.hr-perf-score {
  font-size: 0.85rem;
  font-weight: 700;
  color: var(--primary);
  padding: 4px 10px;
  border-radius: 20px;
  background: rgba(25,167,123,0.08);
}

/* Job Items Enhancement */
.applicant-badge {
  background: rgba(16, 185, 129, 0.12);
  color: #10b981;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.7rem;
  font-weight: 600;
  white-space: nowrap;
}

.status-badge {
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 0.7rem;
  font-weight: 600;
  white-space: nowrap;
}

.status-applied { background: rgba(59, 130, 246, 0.12); color: #3b82f6; }
.status-hired { background: rgba(16, 185, 129, 0.12); color: #10b981; }
.status-rejected { background: rgba(239, 68, 68, 0.12); color: #ef4444; }

/* Scroll inside cards if needed */
.hr-card-content {
  max-height: 380px;
  overflow-y: auto;
  padding-right: 4px;
}

.hr-card-content::-webkit-scrollbar {
  width: 4px;
}

.hr-card-content::-webkit-scrollbar-track {
  background: #e2ede7;
  border-radius: 10px;
}

.hr-card-content::-webkit-scrollbar-thumb {
  background: var(--primary);
  border-radius: 10px;
}

/* Footer */
.footer-custom {
  background: var(--bg-dark);
  color: white;
  padding: 1.5rem 0;
  margin-top: 3rem;
  text-align: center;
  position: relative;
  z-index: 1;
}

.footer-custom p {
  margin-bottom: 0.5rem;
  font-size: 0.8rem;
  opacity: 0.8;
}

.footer-links {
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  flex-wrap: wrap;
}

.footer-links a {
  color: rgba(255, 255, 255, 0.7);
  text-decoration: none;
  font-size: 0.8rem;
  transition: var(--transition);
}

.footer-links a:hover {
  color: var(--accent);
  text-decoration: underline;
}

/* Animations */
@keyframes fadeInUp {
  from { opacity: 0; transform: translateY(30px); }
  to { opacity: 1; transform: translateY(0); }
}

.stat-card, .action-card, .hr-stat-card, .hr-card {
  animation: fadeInUp 0.5s ease-out both;
}

.stat-card:nth-child(1) { animation-delay: 0.05s; }
.stat-card:nth-child(2) { animation-delay: 0.1s; }
.stat-card:nth-child(3) { animation-delay: 0.15s; }
.stat-card:nth-child(4) { animation-delay: 0.2s; }

/* Responsive */
@media (max-width: 992px) {
  .stats-wrapper { margin-left: -0.5rem; margin-right: -0.5rem; padding: 1.5rem 0; }
  .stat-icon { width: 60px; height: 60px; font-size: 1.5rem; }
  .hr-stats-grid { grid-template-columns: repeat(2, 1fr); }
  .hr-content-grid { grid-template-columns: 1fr; gap: 20px; }
}

@media (max-width: 768px) {
  .dashboard-header { padding: 1.5rem 0; }
  .dashboard-header h1 { font-size: 1.5rem; }
  .stat-value { font-size: 1.6rem; }
  .stat-icon { width: 52px; height: 52px; font-size: 1.3rem; }
  .section-title { font-size: 1.3rem; }
  .action-icon { width: 75px; height: 75px; font-size: 2rem; }
  .btn-logout span { display: none; }
}

@media (max-width: 576px) {
  .stats-wrapper { padding: 1rem 0; }
  .stat-card { padding: 1rem; }
  .stat-icon { width: 48px; height: 48px; font-size: 1.2rem; }
  .stat-value { font-size: 1.4rem; }
  .action-card { padding: 1.25rem; }
  .action-icon { width: 65px; height: 65px; font-size: 1.75rem; }
  .hr-stats-grid { grid-template-columns: 1fr; }
  .hr-card { padding: 1rem; }
  .hr-user-item { flex-wrap: wrap; gap: 8px; }
  .hr-user-role { margin-left: auto; }
}

html { scroll-behavior: smooth; }
::selection { background: var(--primary); color: white; }

/* floating decorative shapes */
.floating-shape {
  position: fixed;
  border-radius: 50%;
  background: linear-gradient(135deg, var(--primary), var(--accent));
  opacity: 0.03;
  pointer-events: none;
  z-index: 0;
  filter: blur(45px);
}
</style>
</head>
<body>

<div class="floating-shape" style="width: 350px; height: 350px; top: -120px; right: -80px;"></div>
<div class="floating-shape" style="width: 250px; height: 250px; bottom: 60px; left: -60px; opacity: 0.04;"></div>
<div class="floating-shape" style="width: 180px; height: 180px; bottom: 20%; right: 5%; opacity: 0.05;"></div>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-custom">
  <div class="container">
    <a class="navbar-brand-custom" href="${pageContext.request.contextPath}/dashboard">
      <i class="fas fa-briefcase"></i> <span>JobU Admin</span>
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
      aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"
      style="border: 1px solid rgba(255, 255, 255, 0.3);">
      <span class="navbar-toggler-icon" style="filter: brightness(0) invert(1);"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <div class="ms-auto">
        <form action="${pageContext.request.contextPath}/adminLogout" method="post" class="d-inline">
          <button type="submit" class="btn btn-logout">
            <i class="fas fa-sign-out-alt"></i> <span>Logout</span>
          </button>
        </form>
      </div>
    </div>
  </div>
</nav>

<!-- Dashboard Header -->
<div class="dashboard-header">
  <div class="container">
    <h1>Welcome, ${adminName}!</h1>
    <p>Manage your job portal efficiently with comprehensive administrative tools</p>
  </div>
</div>

<!-- Main Content -->
<div class="container">
  <!-- Statistics Section -->
  <div class="stats-wrapper">
    <div class="container">
      <div class="row g-3">
        <div class="col-lg-3 col-md-6 col-sm-6">
          <a href="${pageContext.request.contextPath}/allJobSeekers" class="stat-card-link">
          <div class="stat-card success">
            <div class="stat-card-header">
              <div>
                <div class="stat-value">${totalUsers}</div>
                <div class="stat-label">Total Job Seekers</div>
              </div>
              <div class="stat-icon"><i class="fas fa-users"></i></div>
            </div>
          </div>
          </a>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6">
          <a href="${pageContext.request.contextPath}/company_dashboard" class="stat-card-link">
          <div class="stat-card info">
            <div class="stat-card-header">
              <div>
                <div class="stat-value">${totalCompanies}</div>
                <div class="stat-label">Total Companies</div>
              </div>
              <div class="stat-icon"><i class="fas fa-building"></i></div>
            </div>
          </div>
          </a>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6">
          <a href="${pageContext.request.contextPath}/admin/pending" class="stat-card-link">
          <div class="stat-card warning">
            <div class="stat-card-header">
              <div>
                <div class="stat-value">${pendingCompanies}</div>
                <div class="stat-label">Pending Companies</div>
              </div>
              <div class="stat-icon"><i class="fas fa-clock"></i></div>
            </div>
          </div>
          </a>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6">
          <a href="${pageContext.request.contextPath}/reported-jobs" class="stat-card-link">
          <div class="stat-card danger">
            <div class="stat-card-header">
              <div>
                <div class="stat-value">${pendingReports}</div>
                <div class="stat-label">Pending Reports</div>
              </div>
              <div class="stat-icon"><i class="fas fa-exclamation-triangle"></i></div>
            </div>
          </div>
          </a>
        </div>
      </div>
    </div>
  </div>

  <!-- Quick Actions Section -->
  <div class="mb-4">
    <h2 class="section-title">Quick Actions</h2>
    <div class="row g-3">
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/allJobSeekers" class="action-card users"><div class="action-icon"><i class="fas fa-users"></i></div><div class="action-title">Manage Job Seekers</div><p class="action-desc">View and manage all job seekers</p></a></div>
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/company_dashboard" class="action-card companies"><div class="action-icon"><i class="fas fa-building"></i></div><div class="action-title">Manage Companies</div><p class="action-desc">Verify and manage company accounts</p></a></div>
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/reported-jobs" class="action-card reports"><div class="action-icon"><i class="fas fa-flag"></i></div><div class="action-title">Reported Jobs</div><p class="action-desc">Review and resolve job reports</p></a></div>
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/qna/admin/questions" class="action-card qa"><div class="action-icon"><i class="fas fa-question-circle"></i></div><div class="action-title">Manage Q&A</div><p class="action-desc">Moderate questions and answers</p></a></div>
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/admin/sports/service/add" class="action-card sports"><div class="action-icon"><i class="fas fa-futbol"></i></div><div class="action-title">Add Sports Services</div><p class="action-desc">Create & manage corporate sports packages</p></a></div>
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/admin/sports/service/list" class="action-card sports"><div class="action-icon"><i class="fas fa-tools"></i></div><div class="action-title">Manage Sports Services</div><p class="action-desc">View, edit & control all sports services</p></a></div>
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/admin/bookings" class="action-card sports"><div class="action-icon"><i class="fas fa-list-alt"></i></div><div class="action-title">All Bookings</div><p class="action-desc">View all sports service bookings by recruiters</p></a></div>
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/admin/alerts" class="action-card reports"><div class="action-icon"><i class="fas fa-flag"></i></div><div class="action-title">Reported Companies</div><p class="action-desc">Review, respond & remove company alerts</p></a></div>
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/admin/assessments/uploadpage" class="action-card assessments"><div class="action-icon"><i class="fas fa-file-alt"></i></div><div class="action-title">Assessment Questions</div><p class="action-desc">Add and manage assessment questions</p></a></div>
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/had" class="action-card assessments"><div class="action-icon"><i class="fas fa-chart-line"></i></div><div class="action-title">HackerRank Dashboard</div><p class="action-desc">Advanced analytics & coding assessments</p></a></div>
      <div class="col-lg-4 col-md-6"><a href="${pageContext.request.contextPath}/admin/activity-logs" class="action-card qa"><div class="action-icon"><i class="fas fa-history"></i></div><div class="action-title">User Activity Logs</div><p class="action-desc">Track and monitor all user actions across the portal</p></a></div>
    </div>
  </div>
</div>

<!-- Hackerrank Admin Dashboard Additional Stats -->
<div class="container">
  <div class="mb-4">
    <h2 class="section-title">Platform Statistics</h2>
    <div class="hr-stats-grid">
      <div class="hr-stat-card"><div class="hr-stat-icon orange"><i class="fas fa-users"></i></div><div class="hr-stat-value">${totalUsers}</div><div class="hr-stat-label">Total Job Seekers</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon blue"><i class="fas fa-user-graduate"></i></div><div class="hr-stat-value">${totalStudents}</div><div class="hr-stat-label">Job Seekers</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon green"><i class="fas fa-chalkboard-teacher"></i></div><div class="hr-stat-value">${totalInterviewers}</div><div class="hr-stat-label">Interviewers</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon purple"><i class="fas fa-code"></i></div><div class="hr-stat-value">${totalCodingQuestions}</div><div class="hr-stat-label">Coding Questions</div></div>
    </div>
    <div class="hr-stats-grid">
      <div class="hr-stat-card"><div class="hr-stat-icon cyan"><i class="fas fa-comments"></i></div><div class="hr-stat-value">${totalInterviewQuestions}</div><div class="hr-stat-label">Interview Questions</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon pink"><i class="fas fa-tags"></i></div><div class="hr-stat-value">${totalCategories}</div><div class="hr-stat-label">Categories</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon yellow"><i class="fas fa-video"></i></div><div class="hr-stat-value">${totalInterviews}</div><div class="hr-stat-label">Total Interviews</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon green"><i class="fas fa-check-double"></i></div><div class="hr-stat-value">${completedInterviews}</div><div class="hr-stat-label">Completed</div></div>
    </div>
    <div class="hr-stats-grid">
      <div class="hr-stat-card"><div class="hr-stat-icon orange"><i class="fas fa-building"></i></div><div class="hr-stat-value">${totalCompanies}</div><div class="hr-stat-label">Companies</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon blue"><i class="fas fa-briefcase"></i></div><div class="hr-stat-value">${totalJobs}</div><div class="hr-stat-label">Total Jobs</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon green"><i class="fas fa-file-alt"></i></div><div class="hr-stat-value">${totalApplications}</div><div class="hr-stat-label">Job Applications</div></div>
      <div class="hr-stat-card"><div class="hr-stat-icon purple"><i class="fas fa-handshake"></i></div><div class="hr-stat-value">${activeJobsCount}</div><div class="hr-stat-label">Active Jobs</div></div>
    </div>
  </div>

  <!-- Enhanced Recent Job Seekers & Performance Section -->
  <div class="hr-content-grid">
    <div class="hr-card">
      <div class="hr-card-header">
        <h3><i class="fas fa-user-clock" style="color: #f97316;"></i> Recent Job Seekers</h3>
        <a href="${pageContext.request.contextPath}/admin/manage-users">Manage All <i class="fas fa-arrow-right ms-1"></i></a>
      </div>
      <div class="hr-card-content">
        <c:forEach var="u" items="${recentUsers}" end="7">
          <div class="hr-user-item">
            <div class="hr-user-info">
              <div class="hr-user-avatar ${u.role == 'ADMIN' ? 'admin' : u.role == 'STUDENT' ? 'student' : u.role == 'COMPANY' ? 'company' : 'interviewer'}">${u.name.substring(0,1)}</div>
              <div class="hr-user-details">
                <span class="hr-user-name">${u.name}</span>
                <div class="hr-user-meta">
                  <i class="fas fa-envelope"></i> ${u.email}
                </div>
              </div>
            </div>
            <span class="hr-user-role hr-role-${u.role == 'ADMIN' ? 'admin' : u.role == 'STUDENT' ? 'student' : u.role == 'COMPANY' ? 'company' : 'interviewer'}">
              <i class="fas fa-badge-check me-1"></i>${u.role}
            </span>
          </div>
        </c:forEach>
        <c:if test="${empty recentUsers}">
          <div class="text-center text-muted py-4">
            <i class="fas fa-user-slash fa-2x mb-2 d-block opacity-50"></i>
            <p class="mb-0">No recent job seekers found</p>
          </div>
        </c:if>
      </div>
    </div>

    <div class="hr-card">
      <div class="hr-card-header">
        <h3><i class="fas fa-trophy" style="color: #fbbf24;"></i> Student Performance</h3>
        <a href="${pageContext.request.contextPath}/admin/analytics">View Analytics <i class="fas fa-arrow-right ms-1"></i></a>
      </div>
      <div class="hr-card-content">
        <c:forEach var="p" items="${performances}" end="7">
          <div class="hr-perf-item">
            <span class="hr-perf-name">
              <i class="fas fa-graduation-cap"></i>
              ${not empty p.studentName ? p.studentName : 'Student'} - ${not empty p.categoryName ? p.categoryName : 'Overall'}
            </span>
            <span class="hr-perf-score">
              <i class="fas fa-chart-simple me-1"></i>${p.overallScore}%
            </span>
          </div>
        </c:forEach>
        <c:if test="${empty performances}">
          <div class="text-center text-muted py-4">
            <i class="fas fa-chart-line fa-2x mb-2 d-block opacity-50"></i>
            <p class="mb-0">No performance data available</p>
          </div>
        </c:if>
      </div>
    </div>
  </div>

  <!-- Enhanced Companies & Jobs + Recent Applications Section -->
  <div class="hr-content-grid" style="margin-top: 24px;">
    <div class="hr-card">
      <div class="hr-card-header">
        <h3><i class="fas fa-briefcase" style="color: #3b82f6;"></i> Companies & Active Jobs</h3>
        <a href="${pageContext.request.contextPath}/company_dashboard">View All <i class="fas fa-arrow-right ms-1"></i></a>
      </div>
      <div class="hr-card-content">
        <c:forEach var="j" items="${activeJobs}" end="7">
          <div class="hr-user-item">
            <div class="hr-user-info">
              <div class="hr-user-avatar company">${not empty j.companyName ? j.companyName.substring(0,1) : 'C'}</div>
              <div class="hr-user-details">
                <span class="hr-user-name">${j.title}</span>
                <div class="hr-user-meta">
                  <i class="fas fa-building"></i> ${j.companyName}
                  <i class="fas fa-map-marker-alt ms-2"></i> ${j.location}
                </div>
              </div>
            </div>
            <span class="applicant-badge">
              <i class="fas fa-users me-1"></i>${j.applicantCount} Applicants
            </span>
          </div>
        </c:forEach>
        <c:if test="${empty activeJobs}">
          <div class="text-center text-muted py-4">
            <i class="fas fa-briefcase-slash fa-2x mb-2 d-block opacity-50"></i>
            <p class="mb-0">No active jobs posted yet</p>
          </div>
        </c:if>
      </div>
    </div>

    <div class="hr-card">
      <div class="hr-card-header">
        <h3><i class="fas fa-file-alt" style="color: #22c55e;"></i> Recent Job Applications</h3>
        <a href="${pageContext.request.contextPath}/applications/track">Track All <i class="fas fa-arrow-right ms-1"></i></a>
      </div>
      <div class="hr-card-content">
        <c:forEach var="a" items="${recentApplications}" end="7">
          <div class="hr-user-item">
            <div class="hr-user-info">
              <div class="hr-user-avatar student">${not empty a.applicantName ? a.applicantName.substring(0,1) : 'S'}</div>
              <div class="hr-user-details">
                <span class="hr-user-name">${a.applicantName}</span>
                <div class="hr-user-meta">
                  <i class="fas fa-briefcase"></i> ${a.jobTitle}
                </div>
              </div>
            </div>
            <span class="status-badge status-${a.status == 'APPLIED' ? 'applied' : a.status == 'HIRED' ? 'hired' : 'rejected'}">
              <i class="fas fa-${a.status == 'APPLIED' ? 'clock' : a.status == 'HIRED' ? 'check-circle' : 'times-circle'} me-1"></i>
              ${a.status}
            </span>
          </div>
        </c:forEach>
        <c:if test="${empty recentApplications}">
          <div class="text-center text-muted py-4">
            <i class="fas fa-inbox fa-2x mb-2 d-block opacity-50"></i>
            <p class="mb-0">No applications received yet</p>
          </div>
        </c:if>
      </div>
    </div>
  </div>
</div>

<!-- Footer -->
<footer class="footer-custom">
  <div class="container">
    <p>&copy; 2026 JobU. All rights reserved.</p>
    <div class="footer-links">
      <a href="#">Privacy Policy</a> <a href="#">Terms of Service</a> <a href="#">Support</a>
    </div>
  </div>
</footer>

<!-- Bootstrap 5 JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>