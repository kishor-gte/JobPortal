<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html class="no-js" lang="zxx">
<head>
<meta charset="utf-8" />
<meta http-equiv="x-ua-compatible" content="ie=edge" />
<title>JobU - Premium Job Portal | Find Your Dream Career</title>
<meta name="description" content="Revolutionary job portal connecting talent with opportunity." />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/assets/images/favicon.svg" />

<!-- Google Fonts: Plus Jakarta Sans & Outfit -->
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Outfit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- External CSS (preserved for backend compatibility) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/LineIcons.2.0.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/glightbox.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css" />
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

<!-- ========== PREMIUM FRONTEND - MODERN CRYSTAL DESIGN ========== -->
<style>
  :root {
    --primary: #19A77B;
    --primary-dark: #12825d;
    --primary-light: #3BC49A;
    --primary-soft: rgba(25, 167, 123, 0.08);
    --accent: #06B6D4;
    --success: #10B981;
    --slate-900: #0f172a;
    --slate-800: #1e293b;
    --slate-700: #334155;
    --slate-600: #475569;
    --slate-50: #f8fafc;
    --white: #ffffff;
    --glass: rgba(255, 255, 255, 0.7);
    --glass-border: rgba(255, 255, 255, 0.2);
    --gradient-primary: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
    --gradient-dark: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
    --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
    --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
    --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
    --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
    --shadow-premium: 0 25px 50px -12px rgba(25, 167, 123, 0.15);
    --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  }

  * {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }

  body {
    font-family: 'Outfit', sans-serif;
    overflow-x: hidden;
    background: var(--slate-50);
    color: var(--slate-700);
  }

  h1, h2, h3, h4, h5, h6 {
    font-family: 'Plus Jakarta Sans', sans-serif;
    color: var(--slate-900);
  }

  /* Premium Custom Scrollbar */
  ::-webkit-scrollbar { width: 10px; }
  ::-webkit-scrollbar-track { background: var(--slate-50); }
  ::-webkit-scrollbar-thumb { background: var(--primary-light); border-radius: 10px; border: 3px solid var(--slate-50); }
  ::-webkit-scrollbar-thumb:hover { background: var(--primary); }

  html { scroll-behavior: smooth; }

  /* ========== PREMIUM NAVBAR DESIGN ========== */
  .navbar-area {
    position: fixed;
    top: 0;
    left: 0;
    transform: none;
    width: 100%;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border-radius: 0;
    padding: 0px 30px;
    z-index: 1000;
    transition: all 0.3s ease-in-out;
    border-bottom: 1px solid #E5E7EB;
    box-shadow: 0 10px 40px rgba(0, 0, 0, 0.05);
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 72px;
  }

  .navbar-area.sticky {
    height: 64px;
    background: rgba(255, 255, 255, 0.98);
    box-shadow: 0 15px 45px rgba(0, 0, 0, 0.08);
  }

  .navbar-brand.logo {
    padding: 0;
    margin-right: 40px;
    display: flex;
    align-items: center;
  }

  .logo1 {
    height: 48px !important;
    width: auto;
    transition: all 0.3s ease;
  }

  .navbar-nav {
    display: flex;
    align-items: center;
    gap: 6px;
    height: 100%;
  }

  .navbar-nav .nav-item .nav-link {
    font-family: 'Plus Jakarta Sans', 'Poppins', sans-serif;
    font-weight: 600;
    font-size: 0.9rem;
    color: #374151 !important;
    padding: 8px 14px !important;
    border-radius: 50px;
    display: flex;
    align-items: center;
    gap: 4px;
    transition: all 0.3s ease;
  }

  .navbar-nav .nav-item .nav-link i { 
    font-size: 0.85rem; 
    opacity: 0.7; 
    transition: opacity 0.3s ease;
  }

  .navbar-nav .nav-item .nav-link:hover {
    color: #19A77B !important;
    background: #E6F6F1;
    transform: translateY(-2px);
  }

  .navbar-nav .nav-item .nav-link:hover i {
    opacity: 1;
  }

  .navbar-nav .nav-item .nav-link.active {
    background: linear-gradient(135deg, #19A77B, #3BC49A);
    color: white !important;
    box-shadow: 0 4px 15px rgba(25, 167, 123, 0.25);
  }

  .navbar-nav .nav-item .nav-link.active i {
    color: white !important;
    opacity: 1;
  }

  .btn-login {
    background: linear-gradient(135deg, #19A77B, #3BC49A);
    color: white !important;
    font-weight: 600;
    padding: 10px 24px !important;
    border-radius: 50px;
    font-size: 0.95rem;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(25, 167, 123, 0.2);
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    border: none;
  }

  .btn-login:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(25, 167, 123, 0.45);
    color: white !important;
  }

  .btn-register {
    background: white;
    color: #19A77B !important;
    font-weight: 600;
    padding: 10px 24px !important;
    border-radius: 50px;
    font-size: 0.95rem;
    transition: all 0.3s ease;
    border: 1.5px solid #19A77B;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 6px;
  }

  .btn-register:hover {
    background: #19A77B;
    transform: translateY(-2px);
    color: white !important;
    box-shadow: 0 4px 12px rgba(25, 167, 123, 0.2);
  }

  /* Dropdown Menu Glass Effect */
  .sub-menu {
    background: rgba(255, 255, 255, 0.98);
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    border-radius: 18px;
    box-shadow: 0 15px 45px rgba(0, 0, 0, 0.08);
    border: 1px solid rgba(255, 255, 255, 0.4);
    padding: 12px;
    min-width: 240px;
    transform: translateY(15px);
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    position: absolute;
    top: 100%;
    margin-top: 5px;
    list-style: none;
  }

  .nav-item:hover .sub-menu {
    transform: translateY(0);
    opacity: 1;
    visibility: visible;
  }

  .sub-menu li {
    margin-bottom: 2px;
  }

  .sub-menu li a {
    padding: 14px 18px !important;
    border-radius: 12px;
    font-weight: 500;
    color: #4B5563 !important;
    transition: all 0.2s ease;
    display: flex;
    align-items: center;
    gap: 8px;
    text-decoration: none;
  }

  .sub-menu li a:hover {
    background: #E6F6F1 !important;
    color: #19A77B !important;
  }

  .sub-menu li a i {
    color: inherit;
  }

  /* Notifications Badge */
  .nav-badge {
    position: absolute;
    top: 5px;
    right: 5px;
    background: #EF4444;
    color: white;
    border-radius: 50%;
    width: 16px;
    height: 16px;
    font-size: 0.65rem;
    display: flex;
    align-items: center;
    justify-content: center;
    font-weight: bold;
    border: 2px solid white;
  }

  /* ========== PREMIUM HERO AREA ========== */
  .premium-hero-area {
    position: relative;
    background: linear-gradient(135deg, #F8FAFC 0%, #DBEAFE 50%, #E6F6F1 100%);
    padding: 100px 0 90px;
    overflow: hidden;
    margin-top: 0 !important;
  }
  
  .premium-hero-bg-elements {
    position: absolute;
    top: 0; left: 0; width: 100%; height: 100%;
    z-index: 0; pointer-events: none;
  }
  .premium-blob-1 {
    position: absolute; width: 600px; height: 600px; background: radial-gradient(circle, rgba(25, 167, 123,0.08) 0%, rgba(255,255,255,0) 70%);
    top: -10%; right: -5%; border-radius: 50%; animation: float-blob 20s infinite alternate;
  }
  .premium-blob-2 {
    position: absolute; width: 500px; height: 500px; background: radial-gradient(circle, rgba(16,185,129,0.05) 0%, rgba(255,255,255,0) 70%);
    bottom: -10%; left: -10%; border-radius: 50%; animation: float-blob 15s infinite alternate-reverse;
  }

  .premium-hero-content {
    position: relative;
    z-index: 5;
    text-align: left;
  }
  
  .premium-hero-badge {
    display: inline-block;
    background: white; color: #0F172A; font-weight: 700; font-size: 0.8rem;
    padding: 6px 16px; border-radius: 50px; margin-bottom: 20px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.05); border: 1px solid rgba(255,255,255,0.8);
  }
  .premium-hero-badge i { color: #F59E0B; margin-right: 8px; }

  .premium-hero-title {
    font-size: clamp(2.8rem, 4vw, 4.2rem);
    font-weight: 800;
    line-height: 1.1;
    color: #0F172A;
    margin-bottom: 20px;
    letter-spacing: -1.5px;
  }
  .premium-hero-title .gradient-text {
    background: linear-gradient(135deg, #19A77B, #06B6D4);
    -webkit-background-clip: text; color: transparent;
  }
  .premium-hero-title .light-text { color: #3BC49A; }
  
  .premium-hero-subtitle {
    font-size: 1.05rem; color: #475569; max-width: 550px; line-height: 1.6; margin-bottom: 30px;
  }
  
  .premium-hero-buttons {
    display: flex; gap: 15px; margin-bottom: 40px;
  }
  .btn-premium-primary {
    background: linear-gradient(135deg, #19A77B, #3BC49A); color: white !important;
    padding: 14px 30px; border-radius: 14px; font-weight: 700; font-size: 1rem;
    box-shadow: 0 10px 25px rgba(25, 167, 123,0.3); transition: all 0.3s; border: none; text-decoration: none;
    display: inline-flex; align-items: center; gap: 10px;
  }
  .btn-premium-primary:hover { transform: translateY(-3px); box-shadow: 0 15px 35px rgba(25, 167, 123,0.4); }
  
  .btn-premium-secondary {
    background: white; color: #0F172A !important;
    padding: 14px 30px; border-radius: 14px; font-weight: 700; font-size: 1rem;
    box-shadow: 0 10px 25px rgba(0,0,0,0.05); border: 1px solid rgba(0,0,0,0.05);
    transition: all 0.3s; text-decoration: none; display: inline-flex; align-items: center; gap: 10px;
  }
  .btn-premium-secondary:hover { transform: translateY(-3px); box-shadow: 0 15px 35px rgba(0,0,0,0.1); border-color: rgba(25, 167, 123,0.2); color: #19A77B !important; }

  .premium-search-panel {
    background: #FFFFFF;
    padding: 12px 12px 12px 24px; border-radius: 16px; box-shadow: 0 15px 40px rgba(15,23,42,0.06);
    border: 1px solid #E2E8F0; display: flex; align-items: center; gap: 15px; margin-bottom: 25px;
  }
  .premium-search-field { flex: 1; padding-right: 15px; border-right: 1px solid #E2E8F0; display: flex; align-items: center; gap: 12px; }
  .premium-search-field:last-of-type { border-right: none; }
  .premium-search-field i { color: #94A3B8; font-size: 1.1rem; }
  .premium-search-field input { border: none; background: transparent; font-size: 1.05rem; font-weight: 500; color: #0F172A; outline: none; width: 100%; }
  .premium-search-field input::placeholder { color: #94A3B8; font-weight: 400; }
  .premium-search-btn {
    background: #19A77B; color: white; border: none; padding: 14px 28px; border-radius: 12px;
    font-size: 1.05rem; font-weight: 700; display: flex; align-items: center; gap: 8px;
    box-shadow: 0 8px 15px rgba(25, 167, 123,0.2); transition: all 0.3s; cursor: pointer;
  }
  .premium-search-btn:hover { background: #1D4ED8; transform: translateY(-2px); box-shadow: 0 12px 20px rgba(25, 167, 123,0.3); }

  .premium-popular-searches { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
  .premium-popular-searches span { font-size: 0.85rem; font-weight: 600; color: #64748B; }
  .premium-popular-pill {
    background: white; padding: 4px 14px; border-radius: 50px; font-size: 0.8rem; font-weight: 600;
    color: #475569; box-shadow: 0 4px 10px rgba(0,0,0,0.03); border: 1px solid #F1F5F9;
    transition: all 0.3s; cursor: pointer; text-decoration: none;
  }
  .premium-popular-pill:hover { background: #19A77B; color: white; transform: translateY(-2px); box-shadow: 0 10px 20px rgba(25, 167, 123,0.2); }

  .premium-hero-image-wrapper { position: relative; z-index: 5; margin-left: 20px; }
  .premium-hero-image {
    width: 100%; height: auto; object-fit: contain;
    border-radius: 25px; box-shadow: 0 30px 60px rgba(0,0,0,0.15);
    border: none;
  }
  .premium-floating-card {
    position: absolute; background: rgba(255,255,255,0.95); backdrop-filter: blur(20px);
    padding: 16px 20px; border-radius: 16px; box-shadow: 0 20px 40px rgba(0,0,0,0.1);
    border: 1px solid rgba(255,255,255,1); display: flex; align-items: center; gap: 12px;
    z-index: 10; transition: all 0.3s; text-align: left;
  }
  .premium-floating-card:hover { transform: translateY(-5px) scale(1.02); }
  .floating-1 { top: 10%; left: -30px; animation: float-card 6s ease-in-out infinite alternate; }
  .floating-2 { bottom: 15%; right: -20px; animation: float-card 7s ease-in-out infinite alternate-reverse; }
  
  @keyframes float-card {
    0% { transform: translateY(0px); }
    100% { transform: translateY(-25px); }
  }
  
  .fc-icon { width: 44px; height: 44px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 1.3rem; }
  .fc-content h4 { font-size: 1.2rem; font-weight: 800; color: #0F172A; margin: 0 0 2px; }
  .fc-content p { font-size: 0.8rem; font-weight: 600; color: #64748B; margin: 0; }
  
  .premium-stats-bar {
    position: relative; z-index: 10; margin-top: -60px;
  }
  .premium-stats-container {
    background: rgba(255,255,255,0.9); backdrop-filter: blur(20px);
    border-radius: 20px; padding: 30px;
    box-shadow: 0 25px 50px rgba(0,0,0,0.05); border: 1px solid rgba(255,255,255,1);
    display: flex; justify-content: space-around; align-items: center; flex-wrap: wrap; gap: 20px;
  }
  .premium-stat-item { display: flex; align-items: center; gap: 16px; transition: transform 0.3s; text-align: left; }
  .premium-stat-item:hover { transform: translateY(-5px); }
  .stat-icon { width: 54px; height: 54px; border-radius: 16px; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; color: white; box-shadow: 0 10px 20px rgba(0,0,0,0.1); }
  .stat-info h3 { font-size: 1.6rem; font-weight: 800; color: #0F172A; margin: 0 0 2px; letter-spacing: -0.5px; }
  .stat-info p { font-size: 0.9rem; font-weight: 600; color: #64748B; margin: 0; }

  /* ========== FEATURE CARDS - SOFT PREMIUM ========== */
  .features-section { background: var(--white) !important; }

  .feature-card {
    background: var(--white);
    padding: 48px 32px;
    border-radius: 32px;
    border: 1px solid var(--slate-50);
    transition: var(--transition);
    position: relative;
    overflow: hidden;
  }

  .feature-card:hover {
    transform: translateY(-12px);
    box-shadow: var(--shadow-premium);
    border-color: var(--primary-soft);
  }

  .feature-card {
    background: var(--white);
    padding: 0;
    border-radius: 24px;
    transition: var(--transition);
    border: 1px solid rgba(0, 0, 0, 0.05);
    overflow: hidden;
    height: 100%;
    display: flex;
    flex-direction: column;
  }

  .feature-img-wrapper {
    width: 100%;
    height: 180px;
    overflow: hidden;
  }

  .feature-img-wrapper img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: var(--transition);
  }

  .feature-card:hover .feature-img-wrapper img {
    transform: scale(1.1);
  }

  .feature-card-content {
    padding: 30px;
    flex-grow: 1;
    display: flex;
    flex-direction: column;
  }

  .feature-card h3 {
    font-size: 1.4rem;
    font-weight: 800;
    margin-bottom: 15px;
    color: var(--slate-900);
  }

  .feature-card p {
    font-size: 1rem;
    color: var(--slate-600);
    margin-bottom: 25px;
    line-height: 1.6;
  }

  .btn-feature {
    color: var(--primary);
    font-weight: 700;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: var(--transition);
    margin-top: auto;
  }

  .feature-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 30px 60px -15px rgba(16, 185, 129, 0.2);
  }
  
  .btn-feature:hover { gap: 12px; }

  /* ========== JOB CATEGORY - GLASS TILES ========== */
  .section-title span {
    color: var(--primary);
    font-weight: 800;
    text-transform: uppercase;
    letter-spacing: 2px;
    font-size: 0.85rem;
    margin-bottom: 12px;
    display: block;
  }

  .section-title h2 { font-size: 3rem; font-weight: 800; margin-bottom: 60px; letter-spacing: -1px; }

  /* Explore Opportunities CSS removed - moved to inline style block in the section below */

  /* ========== FOOTER - SLEEK DARK ========== */
  .footer {
    background: var(--slate-900);
    padding: 60px 0 0;
    color: var(--slate-50);
  }

  .footer .logo img { height: 70px !important; filter: brightness(0) invert(1); opacity: 0.9; }

  .footer h3 { color: var(--white); font-size: 1.25rem; font-weight: 700; margin-bottom: 20px; }

  .footer .quick-links li a {
    color: var(--slate-50);
    opacity: 0.7;
    transition: var(--transition);
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .footer .quick-links li a:hover { opacity: 1; color: var(--primary); transform: translateX(8px); }

  .btn-legal {
    background: #10b981 !important;
    padding: 8px 16px !important;
    border-radius: 6px !important;
    display: inline-flex !important;
    align-items: center !important;
    justify-content: center !important;
    text-decoration: none !important;
    margin-top: 5px;
    transition: var(--transition);
    opacity: 1 !important;
    color: #10b981 !important; /* text color inside will be different */
    font-weight: 900 !important;
  }

  .btn-legal {
    background: #10b981 !important;
    color: #10b981 !important;
    padding: 10px 20px !important;
    border-radius: 8px !important;
    font-family: 'Plus Jakarta Sans', sans-serif;
    position: relative;
    overflow: hidden;
  }

  .btn-legal::before {
    content: 'LEGAL INFO';
    background: #64b5f6; /* Blueish color from screenshot */
    padding: 4px 12px;
    border-radius: 4px;
    color: #ffffff; /* Changed from #10b981 to white */
    font-size: 0.8rem;
    letter-spacing: 1px;
    font-weight: 800;
  }

  .btn-legal:hover {
    transform: scale(1.05);
    box-shadow: 0 10px 20px rgba(0,0,0,0.2);
  }

  .newsletter-inner .common-input {
    background: rgba(255, 255, 255, 0.05);
    border: 1px solid rgba(255, 255, 255, 0.1);
    border-radius: 14px;
    padding: 14px 20px;
    color: var(--white);
    width: 100%;
    margin-bottom: 12px;
  }

  .newsletter-inner .btn {
    background: var(--primary);
    width: 100%;
    padding: 14px;
    border-radius: 14px;
    border: none;
    color: var(--white);
    font-weight: 700;
  }

  .footer-bottom {
    border-top: 1px solid rgba(255, 255, 255, 0.05);
    padding: 25px 0;
    margin-top: 40px;
    font-size: 0.9rem;
    opacity: 0.6;
  }

  /* Floating Widgets */
  .whatsapp-float {
    background: #22c55e;
    box-shadow: 0 10px 25px -5px rgba(34, 197, 94, 0.4);
  }

  .scroll-top {
    background: var(--primary);
    box-shadow: 0 10px 25px -5px rgba(16, 185, 129, 0.4);
  }

  /* ========== RESPONSIVE ========== */
  @media (max-width: 991px) {
    .navbar-area { width: 100%; top: 0; border-radius: 0; padding: 15px 20px; height: auto !important; position: absolute; }
    .navbar-area.sticky { position: fixed; }
    
    .navbar-collapse {
      background: #ffffff !important;
      padding: 20px !important;
      border-radius: 16px !important;
      box-shadow: 0 15px 35px rgba(0,0,0,0.1) !important;
      margin-top: 15px !important;
      height: auto !important;
      max-height: calc(100vh - 100px) !important;
      overflow-y: auto !important;
      border: 1px solid #E5E7EB !important;
    }

    .navbar-nav {
      flex-direction: column !important;
      align-items: flex-start !important;
      width: 100% !important;
      height: auto !important;
      max-height: none !important;
      overflow: visible !important;
    }

    .navbar-nav .nav-item {
      width: 100%;
      margin-bottom: 8px;
    }

    .navbar-nav .nav-item .nav-link {
      width: 100%;
      justify-content: flex-start;
      padding: 12px 16px !important;
    }

    .header .navbar-nav .nav-item .sub-menu {
      position: static !important;
      box-shadow: none !important;
      border: none !important;
      background: #F8FAFC !important;
      margin-top: 8px !important;
      padding: 10px !important;
      opacity: 1 !important;
      visibility: visible !important;
      transform: none !important;
      display: none !important;
    }

    .header .navbar-nav .nav-item:hover .sub-menu {
      display: block !important;
    }

    .button-group {
      flex-direction: column !important;
      width: 100% !important;
      gap: 10px !important;
      margin-top: 20px !important;
    }
    
    .btn-register, .btn-login {
      width: 100% !important;
      justify-content: center !important;
      margin: 0 !important;
    }

    .hero-text h1 { font-size: 2.5rem; }
    .premium-search-panel { flex-direction: column; padding: 16px; border-radius: 20px; gap: 10px; }
    .premium-search-field { width: 100%; border-right: none; border-bottom: 1px solid #E2E8F0; padding-bottom: 10px; margin-bottom: 5px; }
    .premium-search-field:last-of-type { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
    .premium-search-btn { width: 100%; justify-content: center; }
    .premium-hero-area { padding: 120px 0 60px; }
    .premium-hero-buttons { flex-direction: column; }
    .premium-hero-buttons a { width: 100%; justify-content: center; text-align: center; }
    .premium-stats-bar { margin-top: 30px; }
    .scroll-top { right: 20px !important; bottom: 80px !important; }
    .whatsapp-float { right: 20px !important; bottom: 20px !important; }
    .chat-widget { right: 20px !important; bottom: 140px !important; }
    .chat-container { width: 300px; height: 400px; right: 0; }
  }

  @keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-20px); }
  }

  /* ========== CHAT WIDGET ========== */
  .chat-widget {
    position: fixed;
    bottom: 28px;
    right: 28px;
    z-index: 9999;
    display: flex;
    flex-direction: column;
    align-items: flex-end;
    gap: 12px;
  }

  .chat-container {
    display: none;
    flex-direction: column;
    width: 360px;
    height: 480px;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.18);
    overflow: hidden;
    border: 1px solid rgba(0,0,0,0.07);
    animation: slideUp 0.3s ease;
  }

  .chat-container.active {
    display: flex;
  }

  @keyframes slideUp {
    from { opacity: 0; transform: translateY(20px); }
    to   { opacity: 1; transform: translateY(0); }
  }

  .chat-header {
    background: var(--gradient-primary);
    padding: 16px 20px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-shrink: 0;
  }

  .chat-header h3 {
    color: #fff;
    font-size: 1rem;
    font-weight: 700;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .chat-header button {
    background: rgba(255,255,255,0.2);
    border: none;
    color: #fff;
    width: 30px;
    height: 30px;
    border-radius: 50%;
    cursor: pointer;
    font-size: 0.9rem;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s;
  }

  .chat-header button:hover { background: rgba(255,255,255,0.35); }

  .chat-messages {
    flex: 1;
    overflow-y: auto;
    padding: 16px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    background: #f8fafc;
  }

  .chat-messages .message {
    max-width: 80%;
    padding: 10px 14px;
    border-radius: 16px;
    font-size: 0.88rem;
    line-height: 1.5;
    word-wrap: break-word;
  }

  .chat-messages .message.bot {
    background: #fff;
    color: var(--slate-700);
    border-radius: 4px 16px 16px 16px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.06);
    align-self: flex-start;
  }

  .chat-messages .message.user {
    background: var(--gradient-primary);
    color: #fff;
    border-radius: 16px 16px 4px 16px;
    align-self: flex-end;
  }

  .typing-indicator {
    display: none;
    padding: 10px 16px;
    gap: 5px;
    align-items: center;
    background: #f8fafc;
  }

  .typing-indicator span {
    width: 8px;
    height: 8px;
    background: var(--primary);
    border-radius: 50%;
    opacity: 0.4;
    animation: typingBounce 1.2s infinite;
  }

  .typing-indicator span:nth-child(2) { animation-delay: 0.2s; }
  .typing-indicator span:nth-child(3) { animation-delay: 0.4s; }

  @keyframes typingBounce {
    0%, 60%, 100% { transform: translateY(0); opacity: 0.4; }
    30% { transform: translateY(-6px); opacity: 1; }
  }

  .chat-input-container {
    display: flex;
    align-items: center;
    padding: 12px 16px;
    background: #fff;
    border-top: 1px solid rgba(0,0,0,0.06);
    gap: 10px;
    flex-shrink: 0;
  }

  .chat-input {
    flex: 1;
    border: 1px solid rgba(0,0,0,0.1);
    border-radius: 50px;
    padding: 10px 16px;
    font-size: 0.88rem;
    outline: none;
    font-family: 'Outfit', sans-serif;
    transition: border-color 0.2s;
  }

  .chat-input:focus { border-color: var(--primary); }

  .chat-send {
    width: 38px;
    height: 38px;
    background: var(--gradient-primary);
    border: none;
    border-radius: 50%;
    color: #fff;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    font-size: 0.85rem;
    flex-shrink: 0;
    transition: transform 0.2s;
  }

  .chat-send:hover { transform: scale(1.1); }

  .chat-button {
    width: 56px;
    height: 56px;
    background: var(--gradient-primary);
    border: none;
    border-radius: 50%;
    color: #fff;
    font-size: 1.4rem;
    cursor: pointer;
    box-shadow: 0 8px 24px rgba(16,185,129,0.4);
    display: flex;
    align-items: center;
    justify-content: center;
    transition: transform 0.2s, box-shadow 0.2s;
  }

  .chat-button:hover {
    transform: scale(1.1);
    box-shadow: 0 12px 30px rgba(16,185,129,0.5);
  }

</style>
</head>
<body>

<!-- Preloader -->
<div id="loading-area" style="
  position: fixed; top: 0; left: 0; width: 100%; height: 100%;
  background: #fff; z-index: 99999;
  display: flex; align-items: center; justify-content: center;
  transition: opacity 0.4s ease;">
  <div style="
    width: 48px; height: 48px;
    border: 4px solid rgba(16,185,129,0.15);
    border-top-color: #10b981;
    border-radius: 50%;
    animation: spin 0.8s linear infinite;">
  </div>
</div>
<style>@keyframes spin { to { transform: rotate(360deg); } }</style>

<!-- Header -->
<header class="header">
  <div class="navbar-area" id="navbarSticky">
    <div class="container-fluid">
          <nav class="navbar navbar-expand-lg w-100 position-relative">
            
            <!-- Left: Logo -->
            <a class="navbar-brand custom-premium-logo" href="${pageContext.request.contextPath}/" style="display: flex; align-items: center; text-decoration: none; z-index: 1000; background-color: transparent !important;"> 
              <img src="${pageContext.request.contextPath}/assets/images/logo/logo.png" alt="JobU Logo" style="height: 45px; width: auto; object-fit: contain; display: block; opacity: 1 !important; visibility: visible !important; background-color: transparent !important;" />
            </a>
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            
            <div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
              
              <!-- Center: Nav Options -->
              <ul id="nav" class="navbar-nav mx-auto" style="display: flex; gap: 8px; align-items: center; margin-left: auto; margin-right: auto;">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-briefcase"></i> Services</a>
                  <ul class="sub-menu">
                    <li><a href="${pageContext.request.contextPath}/services.html">Services</a></li>
                    <li><a href="${pageContext.request.contextPath}/faq.html">FAQ</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact.html">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/terms-conditions.html">Terms & Conditions</a></li>
                    <li><a href="${pageContext.request.contextPath}/policy.html">Privacy Policy</a></li>
                  </ul>
                </li>
                <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-users"></i> JobSeekers</a>
                  <ul class="sub-menu">
                    <li><a href="${pageContext.request.contextPath}/jobSeekers/profile">Create/Update Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/company/Alllist">Companies</a></li>
                    <li><a href="${pageContext.request.contextPath}/applications/track">Track applications</a></li>
                    <li><a href="${pageContext.request.contextPath}/jobseeker/videos">Upload Video Resume</a></li>
                    <li><a href="${pageContext.request.contextPath}/assessment/available-badges">Your Badges</a></li>
                    <li><a href="${pageContext.request.contextPath}/qna">Ask or View Questions</a></li>
                  </ul>
                </li>
                <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-building"></i> Employers</a>
                  <ul class="sub-menu">
                    <li><a href="${pageContext.request.contextPath}/company/register">Register Company</a></li>
                    <li><a href="${pageContext.request.contextPath}/company/login">Company Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/recruiter/login">Recruiters Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/tech/login">Tech Persons Login</a></li>
                  </ul>
                </li>
                <li class="nav-item"><a class="nav-link" href="#"><i class="fas fa-search"></i> Jobs</a>
                  <ul class="sub-menu">
                    <li><a href="${pageContext.request.contextPath}/jobs/all">Browse Jobs</a></li>
                    <li><a href="${pageContext.request.contextPath}/seeker/saved-jobs">Saved Jobs</a></li>
                    <li><a href="${pageContext.request.contextPath}/seeker/reported-jobs">Reported Jobs</a></li>
                  </ul>
                </li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/notifications"><i class="fas fa-bell"></i> Notifications</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/assessment/my-invites"><i class="fas fa-trophy"></i> Assessments</a></li>
              </ul>
              
              <!-- Right: Action Buttons -->
              <div class="button-group d-flex align-items-center mt-3 mt-lg-0" style="gap: 15px;">
                <a href="${pageContext.request.contextPath}/jobSeekers/register" class="btn-register" style="display: flex; align-items: center; gap: 8px; white-space: nowrap; padding: 10px 20px; font-weight: 600;"><i class="fas fa-user-plus"></i> Register</a>
                <a href="${pageContext.request.contextPath}/jobSeekers/login"  class="btn-login" style="display: flex; align-items: center; gap: 8px; white-space: nowrap; padding: 10px 20px; font-weight: 600; background: var(--primary); color: white; border-radius: 8px;"><i class="lni lni-lock-alt"></i> Login</a>
              </div>
              
            </div>
          </nav>
    </div>
  </div>
</header>

<!-- Hero Area Premium Redesign -->
<section class="premium-hero-area">
  <div class="premium-hero-bg-elements">
    <div class="premium-blob-1"></div>
    <div class="premium-blob-2"></div>
  </div>
  
  <div class="container-fluid">
    <div class="row align-items-center">
      <div class="col-lg-6">
        <div class="premium-hero-content animate-fade-up">
          
          <div class="premium-hero-badge">
            <i class="fas fa-crown"></i> No.1 Verified Job Portal
          </div>
          
          <h1 class="premium-hero-title">
            Find Your Dream Job<br>
            <span class="gradient-text">Build Your Future</span><br>
            <span class="light-text">With Confidence</span>
          </h1>
          
          <p class="premium-hero-subtitle">
            Discover thousands of verified job opportunities from leading companies. Apply smarter, get hired faster, and take the next step in your career with our AI-powered platform.
          </p>
          
          <div class="premium-hero-buttons">
            <a href="${pageContext.request.contextPath}/jobs/all" class="btn-premium-primary">
              Find Jobs <i class="fas fa-arrow-right"></i>
            </a>
            <a href="${pageContext.request.contextPath}/jobseeker/videos" class="btn-premium-secondary">
              <i class="fas fa-file-upload"></i> Upload Resume
            </a>
          </div>
          
          <form action="${pageContext.request.contextPath}/jobs/search" method="get">
            <div class="premium-search-panel">
              <div class="premium-search-field">
                <i class="fas fa-search"></i>
                <input type="text" name="keyword" placeholder="Job title, keyword, or company">
              </div>
              <div class="premium-search-field">
                <i class="fas fa-map-marker-alt"></i>
                <input type="text" name="location" placeholder="City, state, or remote">
              </div>
              <button type="submit" class="premium-search-btn">
                Search
              </button>
            </div>
          </form>
          
          <div class="premium-popular-searches">
            <span>Popular:</span>
            <a href="${pageContext.request.contextPath}/jobs/search?keyword=Developer" class="premium-popular-pill">Developer</a>
            <a href="${pageContext.request.contextPath}/jobs/search?keyword=Java" class="premium-popular-pill">Java</a>
            <a href="${pageContext.request.contextPath}/jobs/search?keyword=Python" class="premium-popular-pill">Python</a>
            <a href="${pageContext.request.contextPath}/jobs/search?keyword=React" class="premium-popular-pill">React</a>
          </div>
          
        </div>
      </div>
      
      <div class="col-lg-6 mt-5 mt-lg-0">
        <div class="premium-hero-image-wrapper animate-fade-up" style="animation-delay: 0.2s;">
          <img src="${pageContext.request.contextPath}/assets/images/premium-hero-img.png" alt="Professional Corporate Team" class="premium-hero-image">
          
          <!-- Floating Card 1 -->
         
          
          <!-- Floating Card 2 -->
          <div class="premium-floating-card floating-2">
            <div class="fc-icon" style="background: #FEF3C7; color: #F59E0B;"><i class="fas fa-star"></i></div>
            <div class="fc-content">
              <h4><span class="premium-counter" data-target="${topCompanies != null ? topCompanies : 0}">0</span>+</h4>
              <p>Top Companies</p>
            </div>
          </div>
          
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Dashboard Stats Bar Integrated -->
<section class="premium-stats-bar">
  <div class="container-fluid">
    <div class="premium-stats-container animate-fade-up" style="animation-delay: 0.4s;">
      
      <div class="premium-stat-item">
        <div class="stat-icon" style="background: linear-gradient(135deg, #19A77B, #3BC49A); box-shadow: 0 10px 20px rgba(25, 167, 123,0.3);"><i class="fas fa-briefcase"></i></div>
		<div class="stat-info">
		          <h3><span class="premium-counter" data-target="${activeJobs != null ? activeJobs : 0}">0</span>+</h3>
		          <p>Active Jobs</p>
		        </div>
      </div>
      
      <div class="premium-stat-item">
        <div class="stat-icon" style="background: linear-gradient(135deg, #10B981, #34D399); box-shadow: 0 10px 20px rgba(16,185,129,0.3);"><i class="fas fa-star"></i></div>
        <div class="stat-info">
          <h3><span class="premium-counter" data-target="${topCompanies != null ? topCompanies : 0}">0</span>+</h3>
          <p>Top Companies</p>
        </div>
      </div>
      
      <div class="premium-stat-item">
        <div class="stat-icon" style="background: linear-gradient(135deg, #8B5CF6, #A78BFA); box-shadow: 0 10px 20px rgba(139,92,246,0.3);"><i class="fas fa-user-tie"></i></div>
        <div class="stat-info">
          <h3><span class="premium-counter" data-target="${professionals != null ? professionals : 0}">0</span>+</h3>
          <p>Professionals</p>
        </div>
      </div>
      
      <div class="premium-stat-item">
        <div class="stat-icon" style="background: linear-gradient(135deg, #F59E0B, #FBBF24); box-shadow: 0 10px 20px rgba(245,158,11,0.3);"><i class="fas fa-rocket"></i></div>
        <div class="stat-info">
          <h3><span class="premium-counter" data-target="98">0</span>%</h3>
          <p>Hiring Success</p>
        </div>
      </div>
      
    </div>
  </div>
</section>

<!-- FEATURE CARDS SECTION -->
<section class="features-section" style="padding: 100px 0; background-color: #ffffff;">
  <div class="container-fluid">
    <div class="row justify-content-center mb-5 animate-fade-up">
      <div class="col-lg-8 col-md-10 text-center">
        <div class="mb-0">
          <span style="background: #E8F5E9; color: #19A77B; border: 1px solid #A5D6A7; padding: 8px 20px; border-radius: 30px; font-weight: 700; font-size: 0.85rem; display: inline-block; margin-bottom: 20px; letter-spacing: 0.5px;"><i class="fas fa-bolt" style="margin-right: 5px;"></i>GET STARTED</span>
          <h2 style="font-size: 2.8rem; font-weight: 800; margin-bottom: 15px; color: #0F172A; letter-spacing: -1px;">How It Works</h2>
          <p style="color: #64748B; font-size: 1.1rem; max-width: 650px; margin: 0 auto; line-height: 1.7;">Everything you need to accelerate your job search, build your professional brand, and stand out to top employers.</p>
          <div style="height: 3px; width: 60px; background: linear-gradient(90deg, #19A77B, #3BC49A); margin: 25px auto 0; border-radius: 3px;"></div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col-lg-4 col-md-6 mb-4">
        <div class="feature-card">
          <div class="feature-img-wrapper"><img src="${pageContext.request.contextPath}/assets/images/categories/create_profile.png" alt="Create Profile"></div>
          <div class="feature-card-content">
            <h3>Create Profile</h3>
            <p>Build an outstanding professional profile and get matched with dream jobs instantly.</p>
            <a href="${pageContext.request.contextPath}/jobSeekers/profile" class="btn-feature">Build Profile <i class="fas fa-chevron-right"></i></a>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-md-6 mb-4">
        <div class="feature-card">
          <div class="feature-img-wrapper"><img src="${pageContext.request.contextPath}/assets/images/categories/video_resume.png" alt="Video Resume"></div>
          <div class="feature-card-content">
            <h3>Video Resume</h3>
            <p>Upload a video introduction and stand out to top recruiters with your personality.</p>
            <a href="${pageContext.request.contextPath}/jobseeker/videos" class="btn-feature">Upload Now <i class="fas fa-chevron-right"></i></a>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-md-6 mb-4">
        <div class="feature-card">
          <div class="feature-img-wrapper"><img src="${pageContext.request.contextPath}/assets/images/categories/smart_apply.png" alt="Smart Apply"></div>
          <div class="feature-card-content">
            <h3> Apply Jobs</h3>
            <p>Explore thousands of curated opportunities and apply with a single click.</p>
            <a href="${pageContext.request.contextPath}/jobs/all" class="btn-feature">Explore Jobs <i class="fas fa-chevron-right"></i></a>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-md-6 mb-4">
        <div class="feature-card">
          <div class="feature-img-wrapper"><img src="${pageContext.request.contextPath}/assets/images/categories/create_profile.png" alt="Apply Fulltime"></div>
          <div class="feature-card-content">
            <h3>Apply Fulltime</h3>
            <p>Find permanent, full-time positions with top companies and secure your long-term career.</p>
            <a href="${pageContext.request.contextPath}/jobs/all?employmentType=FULLTIME" class="btn-feature">Explore Jobs <i class="fas fa-chevron-right"></i></a>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-md-6 mb-4">
        <div class="feature-card">
          <div class="feature-img-wrapper"><img src="${pageContext.request.contextPath}/assets/images/categories/video_resume.png" alt="Apply Parttime"></div>
          <div class="feature-card-content">
            <h3>Apply Parttime</h3>
            <p>Discover flexible part-time opportunities that fit your schedule and lifestyle.</p>
            <a href="${pageContext.request.contextPath}/jobs/all?employmentType=PARTTIME" class="btn-feature">Explore Jobs <i class="fas fa-chevron-right"></i></a>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-md-6 mb-4">
        <div class="feature-card">
          <div class="feature-img-wrapper"><img src="${pageContext.request.contextPath}/assets/images/categories/smart_apply.png" alt="Apply Internship"></div>
          <div class="feature-card-content">
            <h3>Apply Internship</h3>
            <p>Kickstart your career with exciting internship opportunities for students and freshers.</p>
            <a href="${pageContext.request.contextPath}/jobs/all?employmentType=INTERNSHIP" class="btn-feature">Explore Jobs <i class="fas fa-chevron-right"></i></a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Job Category Area Premium Redesign -->
<style>
.premium-explore-section {
  background: linear-gradient(180deg, #F8FAFC 0%, #FFFFFF 100%);
  position: relative;
  overflow: hidden;
  padding: 100px 0;
}
.premium-explore-section::before {
  content: '';
  position: absolute;
  top: -50%; left: -10%; width: 120%; height: 200%;
  background: radial-gradient(circle, rgba(25, 167, 123,0.03) 0%, rgba(255,255,255,0) 70%);
  z-index: 0;
}
.premium-explore-header {
  position: relative;
  z-index: 1;
  text-align: center;
  margin-bottom: 60px;
}
.premium-explore-badge {
  display: inline-block;
  background: #E6F6F1;
  color: #19A77B;
  font-weight: 700;
  font-size: 0.85rem;
  padding: 8px 18px;
  border-radius: 50px;
  margin-bottom: 16px;
  border: 1px solid rgba(25, 167, 123,0.15);
  box-shadow: 0 4px 10px rgba(25, 167, 123,0.05);
}
.premium-explore-title {
  font-size: 2.8rem;
  font-weight: 800;
  color: #0F172A;
  margin-bottom: 20px;
  letter-spacing: -1px;
}
.premium-explore-subtitle {
  color: #64748B;
  font-size: 1.1rem;
  max-width: 600px;
  margin: 0 auto;
  line-height: 1.6;
}
.premium-explore-divider {
  width: 80px;
  height: 4px;
  background: linear-gradient(90deg, #19A77B, #06B6D4);
  margin: 25px auto 0;
  border-radius: 4px;
}
.premium-cat-card {
  background: rgba(255,255,255,0.8);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(229,231,235,0.8);
  border-radius: 20px;
  padding: 30px;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  display: flex;
  flex-direction: column;
  position: relative;
  overflow: hidden;
  text-decoration: none;
  height: 100%;
  z-index: 1;
  box-shadow: 0 4px 15px rgba(0,0,0,0.02);
}
.premium-cat-card::before {
  content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 100%;
  background: linear-gradient(135deg, rgba(25, 167, 123,0.03), rgba(255,255,255,0));
  opacity: 0; transition: all 0.4s ease; z-index: -1;
}
.premium-cat-card:hover {
  transform: translateY(-8px);
  box-shadow: 0 20px 40px rgba(25, 167, 123,0.08);
  border-color: rgba(25, 167, 123,0.3);
}
.premium-cat-card:hover::before { opacity: 1; }
.premium-cat-card .icon-wrapper {
  width: 70px; height: 70px;
  border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  margin-bottom: 24px;
  font-size: 1.8rem;
  transition: all 0.4s cubic-bezier(0.34, 1.56, 0.64, 1);
}
.premium-cat-card:hover .icon-wrapper {
  transform: scale(1.1) translateY(-2px);
}
.premium-cat-card h3 {
  font-size: 1.25rem; font-weight: 800; color: #1E293B; margin-bottom: 12px; transition: color 0.3s;
}
.premium-cat-card:hover h3 { color: #19A77B; }
.premium-cat-card p {
  font-size: 0.9rem; color: #64748B; margin-bottom: 24px; line-height: 1.6;
}
.premium-cat-job-count {
  background: #F8FAFC; color: #475569; font-size: 0.8rem; font-weight: 700;
  padding: 6px 14px; border-radius: 8px; display: inline-block;
  margin-bottom: auto; border: 1px solid #E2E8F0;
  transition: all 0.3s;
}
.premium-cat-card:hover .premium-cat-job-count {
  background: #E6F6F1; border-color: rgba(25, 167, 123,0.1); color: #19A77B;
}
.premium-cat-footer {
  margin-top: 24px;
  display: flex;
  align-items: center;
  color: #19A77B;
  font-weight: 700;
  font-size: 0.95rem;
}
.premium-cat-footer i {
  margin-left: 8px; transition: transform 0.3s;
}
.premium-cat-card:hover .premium-cat-footer i {
  transform: translateX(5px);
}
.premium-btn-view-all {
  display: inline-block;
  background: linear-gradient(135deg, #19A77B, #3BC49A);
  color: white !important;
  font-weight: 700;
  padding: 16px 36px;
  border-radius: 50px;
  text-decoration: none;
  box-shadow: 0 10px 25px rgba(25, 167, 123,0.3);
  transition: all 0.3s;
  margin-top: 50px;
}
.premium-btn-view-all:hover {
  transform: translateY(-3px);
  box-shadow: 0 15px 35px rgba(25, 167, 123,0.4);
}
@keyframes fadeUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
.animate-fade-up { animation: fadeUp 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards; }
</style>

<section class="premium-explore-section">
  <div class="container position-relative z-index-1">
    <div class="premium-explore-header animate-fade-up">
      <span class="premium-explore-badge"> Explore Careers</span>
      <h2 class="premium-explore-title">Explore Opportunities</h2>
      <p class="premium-explore-subtitle">Discover thousands of jobs across multiple industries and find the perfect opportunity for your career.</p>
      <div class="premium-explore-divider"></div>
    </div>
    
    <div class="row g-4">
      <!-- Card 1 -->
      <div class="col-lg-3 col-md-6 animate-fade-up" style="animation-delay: 0.1s;">
        <a href="${pageContext.request.contextPath}/jobs/category/IT_SOFTWARE" class="premium-cat-card">
          <div class="icon-wrapper" style="background: #E6F6F1; color: #3BC49A;"><i class="fas fa-laptop-code"></i></div>
          <h3>IT & Software</h3>
          <p>Software engineering, cloud architecture, and data science roles.</p>
          <div><span class="premium-cat-job-count">${countIT != null ? countIT : 0} Jobs</span></div>
          <div class="premium-cat-footer">Explore Jobs <i class="fas fa-arrow-right"></i></div>
        </a>
      </div>
      <!-- Card 2 -->
      <div class="col-lg-3 col-md-6 animate-fade-up" style="animation-delay: 0.2s;">
        <a href="${pageContext.request.contextPath}/jobs/category/FINANCE" class="premium-cat-card">
          <div class="icon-wrapper" style="background: #ECFDF5; color: #10B981;"><i class="fas fa-chart-line"></i></div>
          <h3>Finance & Banking</h3>
          <p>Investment banking, accounting, and financial planning careers.</p>
          <div><span class="premium-cat-job-count">${countFinance != null ? countFinance : 0} Openings</span></div>
          <div class="premium-cat-footer">Explore Jobs <i class="fas fa-arrow-right"></i></div>
        </a>
      </div>
      <!-- Card 3 -->
      <div class="col-lg-3 col-md-6 animate-fade-up" style="animation-delay: 0.3s;">
        <a href="${pageContext.request.contextPath}/jobs/category/HEALTHCARE" class="premium-cat-card">
          <div class="icon-wrapper" style="background: #FEF2F2; color: #EF4444;"><i class="fas fa-heartbeat"></i></div>
          <h3>Healthcare Services</h3>
          <p>Medical, nursing, hospital and healthcare careers.</p>
          <div><span class="premium-cat-job-count">${countHealthcare != null ? countHealthcare : 0} Jobs</span></div>
          <div class="premium-cat-footer">Explore Jobs <i class="fas fa-arrow-right"></i></div>
        </a>
      </div>
      <!-- Card 4 -->
      <div class="col-lg-3 col-md-6 animate-fade-up" style="animation-delay: 0.4s;">
        <a href="${pageContext.request.contextPath}/jobs/category/EDUCATION" class="premium-cat-card">
          <div class="icon-wrapper" style="background: #FFFBEB; color: #F59E0B;"><i class="fas fa-graduation-cap"></i></div>
          <h3>Education Services</h3>
          <p>Teaching, administration, and academic research positions.</p>
          <div><span class="premium-cat-job-count">${countEducation != null ? countEducation : 0} Jobs</span></div>
          <div class="premium-cat-footer">Explore Jobs <i class="fas fa-arrow-right"></i></div>
        </a>
      </div>
      <!-- Card 5 -->
      <div class="col-lg-3 col-md-6 animate-fade-up" style="animation-delay: 0.1s;">
        <a href="${pageContext.request.contextPath}/jobs/category/MARKETING" class="premium-cat-card">
          <div class="icon-wrapper" style="background: #F5F3FF; color: #8B5CF6;"><i class="fas fa-bullhorn"></i></div>
          <h3>Marketing Services</h3>
          <p>Digital marketing, brand management, and content creation.</p>
          <div><span class="premium-cat-job-count">${countMarketing != null ? countMarketing : 0} Openings</span></div>
          <div class="premium-cat-footer">Explore Jobs <i class="fas fa-arrow-right"></i></div>
        </a>
      </div>
      <!-- Card 6 -->
      <div class="col-lg-3 col-md-6 animate-fade-up" style="animation-delay: 0.2s;">
        <a href="${pageContext.request.contextPath}/jobs/category/LEGAL" class="premium-cat-card">
          <div class="icon-wrapper" style="background: #F3F4F6; color: #4B5563;"><i class="fas fa-balance-scale"></i></div>
          <h3>Legal & Defense</h3>
          <p>Corporate law, litigation, and defense attorney roles.</p>
          <div><span class="premium-cat-job-count">${countLegal != null ? countLegal : 0} Jobs</span></div>
          <div class="premium-cat-footer">Explore Jobs <i class="fas fa-arrow-right"></i></div>
        </a>
      </div>
      <!-- Card 7 -->
      <div class="col-lg-3 col-md-6 animate-fade-up" style="animation-delay: 0.3s;">
        <a href="${pageContext.request.contextPath}/jobs/category/TECHNICAL_SUPPORT" class="premium-cat-card">
          <div class="icon-wrapper" style="background: #FDF4FF; color: #D946EF;"><i class="fas fa-headset"></i></div>
          <h3>Technical Support</h3>
          <p>Helping customers solve technical issues and product support.</p>
          <div><span class="premium-cat-job-count">${countTechSupport != null ? countTechSupport : 0} Jobs</span></div>
          <div class="premium-cat-footer">Explore Jobs <i class="fas fa-arrow-right"></i></div>
        </a>
      </div>
      <!-- Card 8 -->
      <div class="col-lg-3 col-md-6 animate-fade-up" style="animation-delay: 0.4s;">
        <a href="${pageContext.request.contextPath}/jobs/category/LOCAL_JOBS" class="premium-cat-card">
          <div class="icon-wrapper" style="background: #F0FDF4; color: #22C55E;"><i class="fas fa-store"></i></div>
          <h3>Local Jobs</h3>
          <p>Retail, hospitality, and local business opportunities.</p>
          <div><span class="premium-cat-job-count">${countLocal != null ? countLocal : 0} Openings</span></div>
          <div class="premium-cat-footer">Explore Jobs <i class="fas fa-arrow-right"></i></div>
        </a>
      </div>
    </div>
    
    <div class="text-center animate-fade-up" style="animation-delay: 0.5s;">
      <a href="${pageContext.request.contextPath}/jobs/all" class="premium-btn-view-all">View All Opportunities <i class="fas fa-arrow-right"></i></a>
    </div>
  </div>
</section>

<!-- FEATURED JOBS SECTION -->
<style>
  .premium-job-card {
    background: #FFFFFF;
    border-radius: 20px;
    padding: 25px;
    display: flex;
    flex-direction: column;
    height: 100%;
    border: 1px solid #E2E8F0;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.03);
    transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    text-decoration: none !important;
    position: relative;
    overflow: hidden;
  }
  .premium-job-card:hover {
    transform: translateY(-8px);
    box-shadow: 0 20px 40px rgba(25, 167, 123, 0.08);
    border-color: var(--primary);
  }
  .premium-job-card .company-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 20px; }
  .premium-job-card .company-logo { 
    width: 50px; height: 50px; border-radius: 12px; background: #F8FAFC; 
    display: flex; align-items: center; justify-content: center; 
    border: 1px solid #F1F5F9; overflow: hidden;
    transition: all 0.3s;
  }
  .premium-job-card:hover .company-logo {
    transform: scale(1.05);
  }
  .premium-job-card h3 { font-size: 1.25rem; font-weight: 800; color: #0F172A; margin-bottom: 10px; transition: color 0.3s; }
  .premium-job-card:hover h3 { color: #19A77B; }
  .premium-job-card .location { font-size: 0.9rem; color: #6B7280; margin-bottom: 25px; font-weight: 500; }
  .premium-job-card .tags-container { margin-top: auto; display: flex; justify-content: space-between; align-items: flex-end; }
  .premium-job-card .premium-tag { background: #E8F5E9; color: #19A77B; font-size: 0.8rem; padding: 6px 14px; border-radius: 20px; font-weight: 700; border: 1px solid rgba(25,167,123,0.2); }
  .premium-job-card .time-ago { font-size: 0.8rem; color: #9CA3AF; font-weight: 600; }

  .premium-pill-btn {
    background: linear-gradient(135deg, #19A77B, #3BC49A);
    color: white !important;
    font-weight: 700;
    text-decoration: none;
    padding: 12px 28px;
    border-radius: 50px;
    box-shadow: 0 10px 20px rgba(25, 167, 123, 0.2);
    display: inline-flex;
    align-items: center;
    gap: 10px;
    transition: all 0.3s;
  }
  .premium-pill-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 15px 30px rgba(25, 167, 123, 0.3);
  }
</style>

<section class="featured-jobs section py-5" style="background: #F8FAFC; padding-top: 80px !important; padding-bottom: 80px !important;">
  <div class="container-fluid">
    <div class="row justify-content-center mb-5">
      <div class="col-lg-8 col-md-10 text-center">
        <div class="mb-0">
          <span style="background: #E8F5E9; color: #19A77B; border: 1px solid #A5D6A7; padding: 8px 20px; border-radius: 30px; font-weight: 700; font-size: 0.85rem; display: inline-block; margin-bottom: 20px; letter-spacing: 0.5px;"><i class="fas fa-rocket" style="margin-right: 5px;"></i>EXPLORE CAREERS</span>
          <h2 style="font-size: 2.8rem; font-weight: 800; margin-bottom: 15px; color: #0F172A; letter-spacing: -1px;">Explore Opportunities</h2>
          <p style="color: #64748B; font-size: 1.1rem; max-width: 650px; margin: 0 auto; line-height: 1.7;">Discover thousands of jobs across multiple industries and find the perfect opportunity for your career.</p>
          <div style="height: 3px; width: 60px; background: linear-gradient(90deg, #19A77B, #3BC49A); margin: 25px auto 0; border-radius: 3px;"></div>
        </div>
      </div>
    </div>
    <div class="row g-4">
      <c:choose>
        <c:when test="${empty featuredJobs}">
          <div class="col-12 text-center py-5">
            <h4 style="color: #475569; font-weight: 600;">No featured jobs are available right now. Please check back later.</h4>
          </div>
        </c:when>
        <c:otherwise>
          <c:forEach var="job" items="${featuredJobs}">
            <div class="col-lg-3 col-md-6 mb-4">
              <a href="${pageContext.request.contextPath}/jobs/details?id=${job.id}" class="premium-job-card">
                <div class="company-header">
                  <div style="display: flex; align-items: center; gap: 15px;">
                    <div class="company-logo">
                      <c:choose>
                        <c:when test="${not empty job.company.logo}">
                          <img src="${job.company.logo}" alt="${job.company.name} Logo" style="width: 100%; height: 100%; object-fit: contain;">
                        </c:when>
                        <c:otherwise>
                          <span style="font-size: 1.5rem; font-weight: 700; color: #19A77B;">${job.company.name.substring(0, 1).toUpperCase()}</span>
                        </c:otherwise>
                      </c:choose>
                    </div>
                    <h4 style="font-size: 1rem; font-weight: 700; margin: 0; color: #475569; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 100px;">${job.company.name}</h4>
                  </div>
                  <i class="far fa-bookmark" style="color: #9CA3AF; font-size: 1.2rem;"></i>
                </div>
                <h3 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" title="${job.title}">${job.title}</h3>
                <p class="location"><i class="fas fa-map-marker-alt" style="margin-right: 5px; color: #19A77B;"></i> ${job.location}</p>
                <div class="tags-container">
                  <div style="display: flex; gap: 8px; flex-wrap: wrap;">
                    <c:if test="${not empty job.employmentType}">
                      <span class="premium-tag">${job.employmentType}</span>
                    </c:if>
                    <c:if test="${not empty job.workMode}">
                      <span class="premium-tag" style="background: #ECFDF5; color: #10B981; border-color: rgba(16,185,129,0.2);">${job.workMode}</span>
                    </c:if>
                  </div>
                  <span class="time-ago">${job.postedDate}</span>
                </div>
              </a>
            </div>
          </c:forEach>
        </c:otherwise>
      </c:choose>
    </div>
    <div class="row mt-5">
      <div class="col-12 text-center">
        <a href="${pageContext.request.contextPath}/jobs/all" class="premium-pill-btn">View All Jobs <i class="fas fa-arrow-right"></i></a>
      </div>
    </div>
  </div>
</section>

<!-- Login Modal -->
<div class="modal fade form-modal" id="login" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog max-width-px-840 position-relative">
    <button type="button" class="circle-32 btn-reset bg-white pos-abs-tr mt-md-n6 mr-lg-n6 focus-reset z-index-supper" data-bs-dismiss="modal"><i class="lni lni-close"></i></button>
    <div class="modal-content login-modal-main" style="pointer-events: auto; border: none;">
      <div class="row no-gutters"><div class="col-12"><div class="row"><div class="heading"><h3>JobSeeker Login</h3><p>Access your JobSeeker account<br> to find and apply for your dream jobs.</p></div><div class="social-login"><ul></ul></div><div class="or-devider"><span>Or</span></div>
      <form action="${pageContext.request.contextPath}/jobSeekers/authenticate" method="post">
        <div class="form-group"><label for="email" class="label">E-mail</label><input type="email" class="form-control" name="email" placeholder="example@gmail.com" id="email"></div>
        <div class="form-group"><label for="password" class="label">Password</label><div class="position-relative"><input type="password" class="form-control" name="password" id="password" placeholder="Enter password" style="padding-right: 40px;"><i class="far fa-eye" id="togglePassword" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #64748B; z-index: 10;"></i></div></div>
        <div class="form-group d-flex flex-wrap justify-content-between"><div class="form-check"><input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" /><label class="form-check-label" for="flexCheckDefault">Remember password</label></div><a href="${pageContext.request.contextPath}/jobSeekers/forgot-password" class="font-size-3 text-dodger line-height-reset">Forget Password</a></div>
        <div class="form-group mb-8 button"><button class="btn">Log in</button></div>
        <p class="text-center create-new-account">Don't have an account? <a href="javascript:void(0)" data-bs-toggle="modal" data-bs-target="#signup" data-bs-dismiss="modal">Create a free account</a></p>
      </form>
      </div></div></div>
    </div>
  </div>
</div>

<!-- Signup Modal -->
<div class="modal fade form-modal" id="signup" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog max-width-px-840 position-relative">
    <button type="button" class="circle-32 btn-reset bg-white pos-abs-tr mt-md-n6 mr-lg-n6 focus-reset z-index-supper" data-bs-dismiss="modal"><i class="lni lni-close"></i></button>
    <div class="modal-content login-modal-main" style="pointer-events: auto; border: none;">
      <div class="row no-gutters"><div class="col-12"><div class="row"><div class="heading"><h3>Create Your JobSeeker Account<br> Today</h3><p>Sign up to start your job search,<br> apply for roles, and grow your career.</p></div><div class="social-login"><ul></ul></div><div class="or-devider"></div>
      <form action="${pageContext.request.contextPath}/jobSeekers/signup" method="post" id="jobSeekerSignupForm">
        <div class="form-group"><label for="name" class="label">Full Name</label><input type="text" class="form-control" name="name" placeholder="John Doe" required></div>
        <div class="form-group"><label for="phone" class="label">Mobile Number</label><input type="tel" class="form-control" name="phone" placeholder="9876543210" required></div>
        <div class="form-group"><label for="email" class="label">E-mail</label><input type="email" class="form-control" name="email" placeholder="example@gmail.com" required></div>
        <div class="form-group"><label for="password" class="label">Password</label><div class="position-relative"><input type="password" class="form-control" name="password" placeholder="Enter password" id="signupPassword" required style="padding-right: 40px;"><i class="far fa-eye" id="toggleSignupPassword" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #64748B; z-index: 10;"></i></div></div>
        <div class="form-group"><label for="confirmPassword" class="label">Confirm Password</label><div class="position-relative"><input type="password" class="form-control" name="confirmPassword" placeholder="Confirm password" id="signupConfirmPassword" required style="padding-right: 40px;"><i class="far fa-eye" id="toggleSignupConfirmPassword" style="position: absolute; right: 15px; top: 50%; transform: translateY(-50%); cursor: pointer; color: #64748B; z-index: 10;"></i></div></div>
        <div class="form-group d-flex flex-wrap justify-content-between"><div class="form-check"><input class="form-check-input" type="checkbox" value="" id="termsCheckbox" required><label class="form-check-label" for="termsCheckbox">Agree to the <a href="${pageContext.request.contextPath}/terms-conditions.html">Terms & Conditions</a></label></div></div>
        <div class="form-group mb-8 button"><button class="btn" type="submit">Sign Up</button></div>
      </form>
      </div></div></div>
    </div>
  </div>
</div>

<!-- Footer - Premium Design -->
<style>
  .modal-backdrop { z-index: 1040 !important; }
  .modal { z-index: 1055 !important; }
  
  .footer-premium {
    background: #0B0F19; /* Extremely deep dark blue */
    padding: 100px 0 40px;
    color: #94A3B8;
    position: relative;
    border-top: 1px solid rgba(255,255,255,0.05);
  }
  .footer-premium::before {
    content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 5px;
    background: linear-gradient(90deg, #19A77B, #06B6D4, #8B5CF6);
  }
  .footer-premium h3 { color: white; font-size: 1.25rem; font-weight: 800; margin-bottom: 25px; }
  .footer-premium a { color: #94A3B8; text-decoration: none; transition: color 0.3s; font-size: 0.95rem; }
  .footer-premium a:hover { color: #3BC49A; }
  .footer-social-icons { display: flex; gap: 15px; list-style: none; padding: 0; margin-top: 30px; }
  .footer-social-icons a { 
    background: rgba(255,255,255,0.05); width: 45px; height: 45px; border-radius: 50%; 
    display: flex; align-items: center; justify-content: center; font-size: 1.1rem;
    border: 1px solid rgba(255,255,255,0.1); transition: all 0.3s;
  }
  .footer-social-icons a:hover { background: #19A77B; color: white; transform: translateY(-3px); border-color: transparent; box-shadow: 0 10px 20px rgba(25, 167, 123,0.3); }
  .footer-bottom { border-top: 1px solid rgba(255,255,255,0.05); padding-top: 30px; margin-top: 60px; font-size: 0.9rem; }
</style>

<footer class="footer-premium">
  <div class="container-fluid">
    <div class="row g-5">
      <div class="col-lg-4 col-md-6">
        <p style="line-height: 1.8; color: #64748B;">JobU is the world's leading job search platform, dedicated to connecting ambitious talent with the most innovative companies on the planet.</p>
        <ul class="footer-social-icons">
          <li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
          <li><a href="#"><i class="fab fa-twitter"></i></a></li>
          <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
          <li><a href="#"><i class="fab fa-instagram"></i></a></li>
        </ul>
      </div>
      <div class="col-lg-2 col-md-6">
        <h3>Platform</h3>
        <ul style="list-style: none; padding: 0;">
          <li style="margin-bottom: 15px;"><a href="${pageContext.request.contextPath}/jobSeekers/login">Browse Jobs</a></li>
          <li style="margin-bottom: 15px;"><a href="${pageContext.request.contextPath}/jobSeekers/login">Companies</a></li>
          <li style="margin-bottom: 15px;"><a href="${pageContext.request.contextPath}/jobSeekers/login">Candidates</a></li>
          <li style="margin-bottom: 15px;"><a href="${pageContext.request.contextPath}/jobSeekers/login">Pricing</a></li>
        </ul>
      </div>
      <div class="col-lg-2 col-md-6">
        <h3>Support</h3>
        <ul style="list-style: none; padding: 0;">
          <li style="margin-bottom: 15px;"><a href="${pageContext.request.contextPath}/about-us.html">About Us</a></li>
          <li style="margin-bottom: 15px;"><a href="${pageContext.request.contextPath}/contact.html">Help Center</a></li>
          <li style="margin-bottom: 15px;"><a href="${pageContext.request.contextPath}/terms-conditions.html">Terms & Conditions</a></li>
          <li style="margin-bottom: 15px;"><a href="${pageContext.request.contextPath}/policy.html">Privacy Policy</a></li>
        </ul>
      </div>
      <div class="col-lg-4 col-md-6">
        <h3>Stay Updated</h3>
        <p style="margin-bottom: 25px; color: #64748B;">Subscribe to our newsletter for the latest career tips and job alerts.</p>
        <form action="${pageContext.request.contextPath}/subscribe" method="post" style="display: flex; gap: 10px;">
          <input name="email" type="email" required placeholder="Email address" style="background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.1); color: white; padding: 12px 20px; border-radius: 12px; width: 100%; outline: none;">
          <button type="submit" style="background: linear-gradient(135deg, #19A77B, #3BC49A); color: white; border: none; padding: 0 25px; border-radius: 12px; font-weight: 700; cursor: pointer; transition: all 0.3s;">Join</button>
        </form>
      </div>
    </div>
    <div class="footer-bottom">
      <div class="row align-items-center">
        <div class="col-md-6 text-center text-md-start">
          <p class="mb-0 text-white">&copy; 2026 JobU. Built for the future of work.</p>
        </div>
        <div class="col-md-6 text-center text-md-end mt-3 mt-md-0">
          <p class="mb-0 text-white">Designed with <i class="fas fa-heart text-danger"></i> by JobU Platform</p>
        </div>
      </div>
    </div>
  </div>
</footer>

<a href="#" class="scroll-top btn-hover" style="position:fixed;bottom:28px;right:172px;z-index:9998;width:50px;height:50px;border-radius:50%;background:var(--primary);color:#fff;display:flex;align-items:center;justify-content:center;font-size:1.1rem;box-shadow:0 8px 24px rgba(16,185,129,0.4);text-decoration:none;transition:transform 0.2s;"><i class="lni lni-chevron-up"></i></a>
<a href="https://api.whatsapp.com/send?phone=918660609247&text=Hi%20there!" target="_blank" class="whatsapp-float" style="position:fixed;bottom:28px;right:100px;z-index:9998;width:56px;height:56px;border-radius:50%;background:#22c55e;color:#fff;display:flex;align-items:center;justify-content:center;font-size:1.5rem;box-shadow:0 8px 24px rgba(34,197,94,0.4);text-decoration:none;transition:transform 0.2s;"><i class="fab fa-whatsapp"></i></a>

<!-- Chat Widget -->
<div class="chat-widget">
  <div class="chat-container" id="chatContainer">
    <div class="chat-header"><h3><i class="fas fa-robot"></i>JobU AI Assistant</h3><button onclick="toggleChat()"><i class="fas fa-times"></i></button></div>
    <div class="chat-messages" id="chatMessages"><div class="message bot">Hello! I'm your JobU AI assistant. How can I help you with your job search or recruitment today?</div></div>
    <div class="typing-indicator" id="typingIndicator"><span></span><span></span><span></span></div>
    <div class="chat-input-container"><input type="text" class="chat-input" id="chatInput" placeholder="Type your message..." onkeypress="handleKeyPress(event)"><button class="chat-send" onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button></div>
  </div>
  <button class="chat-button" id="chatButton" onclick="toggleChat()"><i class="fas fa-comment-dots"></i></button>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/wow.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<script>
  new WOW().init();
  window.addEventListener('scroll', function() {
    const navbar = document.getElementById('navbarSticky');
    if (window.scrollY > 20) navbar.classList.add('scrolled');
    else navbar.classList.remove('scrolled');
  });
  function toggleChat() { 
    const container = document.getElementById('chatContainer'); 
    const button = document.getElementById('chatButton'); 
    if(container && button) { 
      container.classList.toggle('active'); 
      button.style.display = container.classList.contains('active') ? 'none' : 'flex'; 
    } 
  }
  function handleKeyPress(e) { if(e.key === 'Enter') sendMessage(); }
  async function sendMessage() { 
    const input = document.getElementById('chatInput'); 
    const msg = input.value.trim(); 
    if(!msg) return; 
    addMessage(msg, 'user'); 
    input.value = ''; 
    showTypingIndicator(); 
    try { 
      const res = await fetch((window.location.pathname.includes('/jobportal/') ? '/jobportal' : '') + '/api/chat', { 
        method: 'POST', 
        headers: { 'Content-Type': 'application/json' }, 
        body: JSON.stringify({ message: msg }) 
      }); 
      hideTypingIndicator(); 
      if(res.ok) { const d = await res.json(); addMessage(d.response, 'bot'); } 
      else addMessage('Having trouble connecting. Please try again.', 'bot'); 
    } catch(e) { 
      hideTypingIndicator(); 
      addMessage('I\'m here to help with job searching, company registration, and more!', 'bot'); 
    } 
  }
  function addMessage(t, s) { 
    const m = document.getElementById('chatMessages'); 
    if(m) { const d = document.createElement('div'); d.className = 'message ' + s; d.textContent = t; m.appendChild(d); m.scrollTop = m.scrollHeight; } 
  }
  function showTypingIndicator() { const i = document.getElementById('typingIndicator'); if(i) i.style.display = 'flex'; }
  function hideTypingIndicator() { const i = document.getElementById('typingIndicator'); if(i) i.style.display = 'none'; }
  document.addEventListener('DOMContentLoaded', function() { 
    const togglePassword = document.querySelector('#togglePassword');
    const password = document.querySelector('#password');
    if (togglePassword && password) {
      togglePassword.addEventListener('click', function (e) {
        const type = password.getAttribute('type') === 'password' ? 'text' : 'password';
        password.setAttribute('type', type);
        this.classList.toggle('fa-eye-slash');
        this.classList.toggle('fa-eye');
      });
    }

    const toggleSignupPassword = document.querySelector('#toggleSignupPassword');
    const signupPassword = document.querySelector('#signupPassword');
    if (toggleSignupPassword && signupPassword) {
      toggleSignupPassword.addEventListener('click', function (e) {
        const type = signupPassword.getAttribute('type') === 'password' ? 'text' : 'password';
        signupPassword.setAttribute('type', type);
        this.classList.toggle('fa-eye-slash');
        this.classList.toggle('fa-eye');
      });
    }

    const toggleSignupConfirmPassword = document.querySelector('#toggleSignupConfirmPassword');
    const signupConfirmPassword = document.querySelector('#signupConfirmPassword');
    if (toggleSignupConfirmPassword && signupConfirmPassword) {
      toggleSignupConfirmPassword.addEventListener('click', function (e) {
        const type = signupConfirmPassword.getAttribute('type') === 'password' ? 'text' : 'password';
        signupConfirmPassword.setAttribute('type', type);
        this.classList.toggle('fa-eye-slash');
        this.classList.toggle('fa-eye');
      });
    }
    const signupForm = document.getElementById('jobSeekerSignupForm');
    if(signupForm){ 
      signupForm.addEventListener('submit', function(e) { 
        const pwd = document.getElementById('signupPassword')?.value; 
        const conf = document.getElementById('signupConfirmPassword')?.value; 
        const terms = document.getElementById('termsCheckbox'); 
        if(pwd !== conf){ e.preventDefault(); alert('Passwords do not match.'); return false; } 
        if(pwd && pwd.length < 6){ e.preventDefault(); alert('Password must be at least 6 characters.'); return false; } 
        if(pwd && !/[A-Z]/.test(pwd)){ e.preventDefault(); alert('Password must contain at least one uppercase letter.'); return false; }
        if(pwd && !/[a-z]/.test(pwd)){ e.preventDefault(); alert('Password must contain at least one lowercase letter.'); return false; }
        if(pwd && !/[0-9]/.test(pwd)){ e.preventDefault(); alert('Password must contain at least one number.'); return false; }
        if(pwd && !/[!@#$%^&*()_+\-=\[\]{}|;:',.<>?\/]/.test(pwd)){ e.preventDefault(); alert('Password must contain at least one special character.'); return false; }
        if(terms && !terms.checked){ e.preventDefault(); alert('Please agree to Terms & Conditions.'); return false; } 
        
        alert("Registration successful!");
        return true; 
      }); 
    } 

    // Subscription Razorpay Integration
    var newsletterForm = document.querySelector('.newsletter-inner');
    if (newsletterForm) {
        newsletterForm.addEventListener('submit', function (e) {
            e.preventDefault();
            var btn = this.querySelector('button[type="submit"]');
            var originalHtml = btn.innerHTML;
            btn.innerHTML = '<i class="fas fa-spinner fa-pulse"></i> Processing...';
            btn.disabled = true;

            var email = this.querySelector('input[name="email"]').value;

            fetch("/api/subscription/createOrder", {
                method: "POST",
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: "amount=99&email=" + encodeURIComponent(email) // Subscription amount
            })
            .then(response => {
                if (response.status === 409) throw new Error("You already have an active subscription.");
                if (!response.ok) throw new Error("Order creation failed");
                return response.json();
            })
            .then(order => {
                btn.innerHTML = originalHtml;
                btn.disabled = false;
                
                if (order.id && order.id.startsWith("order_mock_")) {
                    // Mock flow bypass: submit dummy details to backend
                    fetch("/api/subscription/verify", {
                        method: "POST",
                        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                        body: "razorpay_payment_id=mock_payment_id" +
                              "&razorpay_order_id=" + encodeURIComponent(order.id) +
                              "&razorpay_signature=mock_signature" +
                              "&email=" + encodeURIComponent(email)
                    })
                    .then(res => {
                        if(res.ok) {
                            alert("You have claimed the subscription.");
                            window.location.reload();
                        } else {
                            alert("Payment verification failed.");
                        }
                    });
                    return;
                }
                
                var options = {
                    "key": "rzp_test_YourKeyID", 
                    "amount": order.amount,
                    "currency": "INR",
                    "name": "JobU Subscription",
                    "description": "Premium Job Alerts",
                    "order_id": order.id,
                    "handler": function (response) {
                        // Payment successful, submit to backend for verification
                        fetch("/api/subscription/verify", {
                            method: "POST",
                            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                            body: "razorpay_payment_id=" + encodeURIComponent(response.razorpay_payment_id) +
                                  "&razorpay_order_id=" + encodeURIComponent(response.razorpay_order_id) +
                                  "&razorpay_signature=" + encodeURIComponent(response.razorpay_signature) +
                                  "&email=" + encodeURIComponent(email)
                        })
                        .then(res => {
                            if(res.ok) {
                                alert("You have claimed the subscription.");
                                window.location.reload();
                            } else {
                                alert("Payment verification failed.");
                            }
                        }).catch(err => {
                            alert("Error verifying payment.");
                        });
                    },
                    "prefill": {
                        "email": email
                    },
                    "theme": {
                        "color": "#10b981"
                    },
                    "modal": {
                        "ondismiss": function() {
                            btn.innerHTML = originalHtml;
                            btn.disabled = false;
                        }
                    }
                };
                var rzp = new Razorpay(options);
                rzp.open();
            })
            .catch(error => {
                console.error("Error:", error);
                btn.innerHTML = originalHtml;
                btn.disabled = false;
                alert(error.message || "Something went wrong with the payment system.");
            });
        });
    }
  });
</script>

<script>
  document.addEventListener('DOMContentLoaded', () => {
    const counters = document.querySelectorAll('.premium-counter');
    
    const animateCounter = (counter) => {
      const target = +counter.getAttribute('data-target');
      const duration = 2000; 
      let current = 0;
      
      const updateCounter = () => {
        const increment = target / (duration / 16); // 60fps
        current += increment;
        
        if (current < target) {
          counter.innerText = Math.ceil(current);
          requestAnimationFrame(updateCounter);
        } else {
          counter.innerText = target;
        }
      };
      
      updateCounter();
    };

    const observer = new IntersectionObserver((entries, obs) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          animateCounter(entry.target);
          obs.unobserve(entry.target);
        }
      });
    }, { threshold: 0.1 });

    counters.forEach(counter => {
      observer.observe(counter);
    });
  });
</script>
</body>
</html>

