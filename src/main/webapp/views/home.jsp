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
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/LineIcons.2.0.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/animate.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/tiny-slider.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/glightbox.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/footer.css" />

<!-- ========== PREMIUM FRONTEND - MODERN CRYSTAL DESIGN ========== -->
<style>
  :root {
    --primary: #10b981;
    --primary-dark: #059669;
    --primary-light: #34d399;
    --primary-soft: rgba(16, 185, 129, 0.08);
    --accent: #fbbf24;
    --slate-900: #0f172a;
    --slate-800: #000000;
    --slate-700: #000000;
    --slate-600: #000000;
    --slate-50: #f8fafc;
    --white: #ffffff;
    --glass: rgba(255, 255, 255, 0.7);
    --glass-border: rgba(255, 255, 255, 0.2);
    --gradient-primary: linear-gradient(135deg, #10b981 0%, #059669 100%);
    --gradient-dark: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
    --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
    --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
    --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
    --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
    --shadow-premium: 0 25px 50px -12px rgba(0, 0, 0, 0.08);
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

  /* ========== NAVBAR - SQUARE REFINED DESIGN ========== */
  .navbar-area {
    position: fixed;
    top: 0;
    left: 0;
    transform: none;
    width: 100%;
    background: rgba(255, 255, 255, 0.98);
    backdrop-filter: blur(15px);
    border-radius: 0;
    padding: 0px 30px;
    z-index: 1000;
    transition: var(--transition);
    border-bottom: 1px solid rgba(0, 0, 0, 0.08);
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.04);
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 60px; /* Increased balanced height */
  }

  .navbar-area.sticky {
    height: 56px;
    background: white;
  }

  .navbar-brand.logo {
    padding: 0;
    margin-right: 15px;
    display: flex;
    align-items: center;
  }

  .logo1 {
    height: 36px !important;
    width: auto;
    transition: var(--transition);
  }

  .navbar-nav {
    display: flex;
    align-items: center;
    gap: 0;
    height: 100%;
  }

  .navbar-nav .nav-item .nav-link {
    font-family: 'Plus Jakarta Sans', sans-serif;
    font-weight: 600;
    font-size: 0.9rem;
    color: var(--slate-700) !important;
    padding: 0 16px !important;
    height: 60px;
    display: flex;
    align-items: center;
    gap: 5px;
    transition: var(--transition);
  }

  .navbar-nav .nav-item .nav-link i { 
    font-size: 0.75rem; 
    opacity: 0.7; 
  }

  .navbar-nav .nav-item .nav-link:hover, 
  .navbar-nav .nav-item .nav-link.active {
    color: var(--primary) !important;
    background: var(--primary-soft);
  }

  .btn-login {
    background: var(--gradient-primary);
    color: white !important;
    font-weight: 700;
    padding: 6px 18px !important;
    border-radius: 6px;
    font-size: 0.8rem;
    transition: var(--transition);
    box-shadow: 0 2px 8px rgba(16, 185, 129, 0.2);
    margin-left: 10px;
  }

  .btn-login:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(16, 185, 129, 0.35);
    color: white !important;
  }

  .btn-register {
    background: transparent;
    color: var(--primary) !important;
    font-weight: 700;
    padding: 6px 18px !important;
    border-radius: 6px;
    font-size: 0.8rem;
    transition: var(--transition);
    border: 1.5px solid var(--primary);
    margin-left: 8px;
    text-decoration: none;
    display: inline-flex;
    align-items: center;
    gap: 5px;
  }

  .btn-register:hover {
    background: var(--primary-soft);
    transform: translateY(-2px);
    color: var(--primary-dark) !important;
  }

  .sub-menu {
    background: var(--white);
    border-radius: 18px;
    box-shadow: var(--shadow-xl);
    border: 1px solid var(--slate-50);
    padding: 12px;
    min-width: 220px;
    transform: translateY(10px);
    transition: var(--transition);
  }

  .button .login, .button .btn {
    padding: 12px 28px !important;
    border-radius: 16px !important;
    font-weight: 700 !important;
    font-family: 'Plus Jakarta Sans', sans-serif;
    transition: var(--transition);
    box-shadow: var(--shadow-md);
  }

  .button .login {
    background: var(--white) !important;
    color: var(--primary) !important;
    border: 1px solid var(--primary) !important;
  }

  .button .btn {
    background: var(--gradient-primary) !important;
    color: var(--white) !important;
    border: none !important;
  }

  .button .btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 20px -8px var(--primary);
  }

  /* ========== HERO AREA - CINEMATIC ========== */
  .hero-area {
    min-height: 100vh;
    background: url('https://media.licdn.com/dms/image/v2/D5612AQHmWpsKqCEUgQ/article-cover_image-shrink_600_2000/article-cover_image-shrink_600_2000/0/1692110377639?e=2147483647&v=beta&t=8o8pbq1bZtrQjOZxyCis8GkK8FtHx38WqMoea3qjPB0') no-repeat center center;
    background-size: cover;
    position: relative;
    display: flex;
    align-items: center;
    justify-content: center;
    overflow: hidden;
    padding-top: 100px;
  }

  .hero-area::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(135deg, rgba(15, 23, 42, 0.9) 0%, rgba(15, 23, 42, 0.4) 100%);
    z-index: 1;
  }

  .hero-area::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: radial-gradient(circle at 70% 30%, rgba(16, 185, 129, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 20% 70%, rgba(59, 130, 246, 0.05) 0%, transparent 50%);
    z-index: 1;
  }

  .hero-content-wrapper {
    position: relative;
    z-index: 2;
    text-align: center;
  }

  .hero-text h1 {
    font-size: 5rem;
    font-weight: 800;
    color: var(--white);
    line-height: 1.1;
    margin-bottom: 24px;
    letter-spacing: -2px;
  }

  .hero-text p {
    font-size: 1.25rem;
    color: var(--slate-50);
    opacity: 0.8;
    max-width: 700px;
    margin: 0 auto 48px;
  }

  /* Floating Search Bar */
  .job-search-form {
    background: var(--white);
    padding: 12px;
    border-radius: 24px;
    box-shadow: 0 30px 60px -12px rgba(0, 0, 0, 0.25);
    display: flex;
    align-items: center;
    max-width: 900px;
    margin: 0 auto;
    border: 1px solid var(--slate-50);
  }

  .single-field-item {
    flex: 1;
    padding: 0 24px;
    border-right: 1px solid var(--slate-50);
    text-align: left;
  }

  .single-field-item:last-child { border-right: none; }

  .single-field-item label {
    font-size: 0.75rem;
    font-weight: 700;
    color: var(--slate-600);
    text-transform: uppercase;
    letter-spacing: 1px;
  }

  .single-field-item input {
    border: none;
    background: transparent;
    width: 100%;
    font-size: 1rem;
    font-weight: 500;
    padding: 4px 0;
    outline: none;
  }

  .submit-btn button {
    background: var(--gradient-primary);
    color: var(--white);
    padding: 16px 40px;
    border-radius: 18px;
    border: none;
    font-weight: 700;
    font-family: 'Plus Jakarta Sans', sans-serif;
    transition: var(--transition);
  }

  .submit-btn button:hover {
    transform: scale(1.02);
    box-shadow: 0 15px 30px -10px var(--primary);
  }

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

  .single-cat {
    background: var(--white);
    border: 1px solid var(--slate-50);
    border-radius: 24px;
    padding: 40px 24px;
    transition: var(--transition);
    text-align: center;
    display: block;
    text-decoration: none;
    height: 100%;
  }

  .single-cat:hover {
    background: var(--gradient-primary);
    transform: scale(1.05);
    box-shadow: 0 30px 60px -15px rgba(16, 185, 129, 0.3);
  }

  .single-cat .icon {
    width: 100%;
    height: 140px;
    margin-bottom: 20px;
    border-radius: 12px;
    overflow: hidden;
    background: var(--slate-50);
    display: flex;
    align-items: center;
    justify-content: center;
    transition: var(--transition);
  }

  .single-cat .icon img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: var(--transition);
    opacity: 0.9;
  }

  .single-cat:hover .icon img {
    transform: scale(1.1);
    opacity: 1;
  }

  .single-cat h3 {
    font-size: 1.05rem;
    font-weight: 700;
    color: var(--slate-800);
    transition: var(--transition);
    text-align: center;
  }

  .single-cat:hover h3 {
    color: var(--primary);
  }

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

  @media (max-width: 991px) {
    .navbar-area { width: 100%; top: 0; border-radius: 0; }
    .hero-text h1 { font-size: 3rem; }
    .job-search-form { flex-direction: column; padding: 24px; border-radius: 32px; }
    .single-field-item { border-right: none; border-bottom: 1px solid var(--slate-50); width: 100%; padding: 16px 0; }
    .submit-btn { width: 100%; margin-top: 24px; }
    .submit-btn button { width: 100%; }
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
    <div class="container">
      <div class="row align-items-center">
        <div class="col-lg-12">
          <nav class="navbar navbar-expand-lg">
            <a class="navbar-brand logo" href="${pageContext.request.contextPath}/"> 
              <img class="logo1" src="${pageContext.request.contextPath}/assets/images/logo/logo-premium.png" alt="Logo" />
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="toggler-icon"></span> <span class="toggler-icon"></span> <span class="toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse sub-menu-bar" id="navbarSupportedContent">
              <ul id="nav" class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/"><i class="fas fa-home"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/services.html"><i class="fas fa-briefcase"></i> Services</a></li>
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
            </div>
            <div class="button-group d-flex align-items-center ml-auto">
              <a href="javascript:void(0)" data-toggle="modal" data-target="#signup" class="btn-register"><i class="fas fa-user-plus"></i> Register</a>
              <a href="javascript:void(0)" data-toggle="modal" data-target="#login" class="btn-login"> <i class="lni lni-lock-alt"></i> Login </a>
            </div>
          </nav>
        </div>
      </div>
    </div>
  </div>
</header>

<!-- Hero Area -->
<section class="hero-area">
  <div class="container">
    <div class="row">
      <div class="col-lg-10 offset-lg-1">
        <div class="hero-content-wrapper">
          <div class="hero-text wow fadeInUp" data-wow-delay=".3s">
            <h1>Elevate Your Career <br>With JobU.</h1>
            <p>Connect with the world's most innovative companies. <br> Your next big opportunity is just a search away.</p>
          </div>
          
          <div class="job-search-wrap-two mt-40 wow fadeInUp" data-wow-delay=".5s">
            <div class="job-search-form">
              <form action="${pageContext.request.contextPath}/jobs/search" method="get" style="display: flex; flex-wrap: wrap; width: 100%; align-items: center;">
                <div class="single-field-item keyword">
                  <label for="keyword">Role or Keyword</label> 
                  <input id="keyword" name="keyword" type="text" placeholder="e.g. Software Engineer">
                </div>
                <div class="single-field-item location">
                  <label for="location">Location</label> 
                  <input id="location" name="location" type="text" placeholder="Remote, New York, etc.">
                </div>
                <div class="submit-btn">
                  <button class="btn" type="submit">Find Jobs <i class="fas fa-arrow-right ml-2"></i></button>
                </div>
              </form>
            </div>
            
            <div class="trending-keywords mt-30">
              <div class="keywords style-two">
                <span style="color: rgba(255,255,255,0.6); font-size: 0.9rem; margin-right: 12px;">Trusted by candidates from:</span>
                <div style="display: flex; justify-content: center; gap: 40px; margin-top: 20px; opacity: 0.5; filter: grayscale(1) invert(1);">
                   <i class="fab fa-google fa-2x"></i>
                   <i class="fab fa-amazon fa-2x"></i>
                   <i class="fab fa-microsoft fa-2x"></i>
                   <i class="fab fa-apple fa-2x"></i>
                   <i class="fab fa-meta fa-2x"></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Dashboard Stats -->
<!-- FEATURE CARDS SECTION -->
<section class="features-section" style="padding: 100px 0;">
  <div class="container">
    <div class="row">
      <div class="col-lg-4 col-md-6 mb-4">
        <div class="feature-card">
          <div class="feature-img-wrapper"><img src="${pageContext.request.contextPath}/assets/images/categories/create_profile.png" alt="Create Profile"></div>
          <div class="feature-card-content">
            <h3>Create Profile</h3>
            <p>Build an outstanding professional profile and get matched with dream jobs instantly.</p>
            <a href="/jobSeekers/profile" class="btn-feature">Build Profile <i class="fas fa-chevron-right"></i></a>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-md-6 mb-4">
        <div class="feature-card">
          <div class="feature-img-wrapper"><img src="${pageContext.request.contextPath}/assets/images/categories/video_resume.png" alt="Video Resume"></div>
          <div class="feature-card-content">
            <h3>Video Resume</h3>
            <p>Upload a video introduction and stand out to top recruiters with your personality.</p>
            <a href="#" class="btn-feature">Upload Now <i class="fas fa-chevron-right"></i></a>
          </div>
        </div>
      </div>

      <div class="col-lg-4 col-md-6 mb-4">
        <div class="feature-card">
          <div class="feature-img-wrapper"><img src="${pageContext.request.contextPath}/assets/images/categories/smart_apply.png" alt="Smart Apply"></div>
          <div class="feature-card-content">
            <h3> Apply Jobs</h3>
            <p>Explore thousands of curated opportunities and apply with a single click.</p>
            <a href="#" class="btn-feature">Explore Jobs <i class="fas fa-chevron-right"></i></a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Job Category Area -->
<section class="job-category section py-5">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <div class="section-title text-center">
        
          <h2>Find Jobs by Interest</h2>
        </div>
      </div>
    </div>
    <div class="row g-4">
      <div class="col-lg-3 col-md-6"><a href="${pageContext.request.contextPath}/jobs/category/TECHNICAL_SUPPORT" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/assets/images/categories/technical_support.png" alt="Technical Support"></div><h3>Technical Support</h3></a></div>
      <div class="col-lg-3 col-md-6"><a href="${pageContext.request.contextPath}/jobs/category/HEALTHCARE" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/assets/images/categories/healthcare.png" alt="Healthcare"></div><h3>Healthcare Services</h3></a></div>
      <div class="col-lg-3 col-md-6"><a href="${pageContext.request.contextPath}/jobs/category/FINANCE" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/assets/images/categories/finance.png" alt="Finance"></div><h3>Finance & Banking</h3></a></div>
      <div class="col-lg-3 col-md-6"><a href="${pageContext.request.contextPath}/jobs/category/EDUCATION" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/assets/images/categories/education.png" alt="Education"></div><h3>Education Services</h3></a></div>
      <div class="col-lg-3 col-md-6"><a href="${pageContext.request.contextPath}/jobs/category/MARKETING" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/assets/images/categories/marketing.png" alt="Marketing"></div><h3>Marketing Services</h3></a></div>
      <div class="col-lg-3 col-md-6"><a href="${pageContext.request.contextPath}/jobs/category/IT_SOFTWARE" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/assets/images/categories/it_software.png" alt="IT Software"></div><h3>IT & Software</h3></a></div>
      <div class="col-lg-3 col-md-6"><a href="${pageContext.request.contextPath}/jobs/category/LOCAL_JOBS" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/assets/images/categories/local_jobs.png" alt="Local Jobs"></div><h3>Local Jobs</h3></a></div>
      <div class="col-lg-3 col-md-6"><a href="${pageContext.request.contextPath}/jobs/category/LEGAL" class="single-cat"><div class="icon"><img src="${pageContext.request.contextPath}/assets/images/categories/legal.png" alt="Legal"></div><h3>Legal & Defense</h3></a></div>
    </div>
  </div>
</section>

<!-- Login Modal -->
<div class="modal fade form-modal" id="login" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog max-width-px-840 position-relative">
    <button type="button" class="circle-32 btn-reset bg-white pos-abs-tr mt-md-n6 mr-lg-n6 focus-reset z-index-supper" data-dismiss="modal"><i class="lni lni-close"></i></button>
    <div class="login-modal-main">
      <div class="row no-gutters"><div class="col-12"><div class="row"><div class="heading"><h3>JobSeeker Login</h3><p>Access your JobSeeker account<br> to find and apply for your dream jobs.</p></div><div class="social-login"><ul></ul></div><div class="or-devider"><span>Or</span></div>
      <form action="${pageContext.request.contextPath}/jobSeekers/authenticate" method="post">
        <div class="form-group"><label for="email" class="label">E-mail</label><input type="email" class="form-control" name="email" placeholder="example@gmail.com" id="email"></div>
        <div class="form-group"><label for="password" class="label">Password</label><div class="position-relative"><input type="password" class="form-control" name="password" id="password" placeholder="Enter password"></div></div>
        <div class="form-group d-flex flex-wrap justify-content-between"><div class="form-check"><input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" /><label class="form-check-label" for="flexCheckDefault">Remember password</label></div><a href="${pageContext.request.contextPath}/jobSeekers/forgot-password" class="font-size-3 text-dodger line-height-reset">Forget Password</a></div>
        <div class="form-group mb-8 button"><button class="btn">Log in</button></div>
        <p class="text-center create-new-account">Don't have an account? <a href="javascript:void(0)" data-toggle="modal" data-target="#signup" data-dismiss="modal">Create a free account</a></p>
      </form>
      </div></div></div>
    </div>
  </div>
</div>

<!-- Signup Modal -->
<div class="modal fade form-modal" id="signup" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog max-width-px-840 position-relative">
    <button type="button" class="circle-32 btn-reset bg-white pos-abs-tr mt-md-n6 mr-lg-n6 focus-reset z-index-supper" data-dismiss="modal"><i class="lni lni-close"></i></button>
    <div class="login-modal-main">
      <div class="row no-gutters"><div class="col-12"><div class="row"><div class="heading"><h3>Create Your JobSeeker Account<br> Today</h3><p>Sign up to start your job search,<br> apply for roles, and grow your career.</p></div><div class="social-login"><ul></ul></div><div class="or-devider"></div>
      <form action="${pageContext.request.contextPath}/jobSeekers/signup" method="post" id="jobSeekerSignupForm">
        <div class="form-group"><label for="email" class="label">E-mail</label><input type="email" class="form-control" name="email" placeholder="example@gmail.com" required></div>
        <div class="form-group"><label for="password" class="label">Password</label><div class="position-relative"><input type="password" class="form-control" name="password" placeholder="Enter password" id="signupPassword" required></div></div>
        <div class="form-group"><label for="confirmPassword" class="label">Confirm Password</label><div class="position-relative"><input type="password" class="form-control" name="confirmPassword" placeholder="Confirm password" id="signupConfirmPassword" required></div></div>
        <div class="form-group d-flex flex-wrap justify-content-between"><div class="form-check"><input class="form-check-input" type="checkbox" value="" id="termsCheckbox" required><label class="form-check-label" for="termsCheckbox">Agree to the <a href="${pageContext.request.contextPath}/terms-conditions.html">Terms & Conditions</a></label></div></div>
        <div class="form-group mb-8 button"><button class="btn" type="submit">Sign Up</button></div>
      </form>
      </div></div></div>
    </div>
  </div>
</div>

<!-- Footer - Premium Design -->
<footer class="footer">
  <div class="container">
    <div class="row">
      <div class="col-lg-4 col-md-6 mb-5 mb-lg-0">
        <div class="single-footer pe-lg-5">
          <a href="${pageContext.request.contextPath}/index.html" style="text-decoration: none;"><span style="font-size: 1.8rem; font-weight: 800; color: #fff; display: block;" class="mb-4">JobU</span></a>
          <p class="mb-4" style="opacity: 0.7; line-height: 1.8;">JobU is the world's leading job search platform, dedicated to connecting ambitious talent with the most innovative companies on the planet.</p>
          <div class="footer-social">
            <ul style="padding-left: 0; list-style: none; display: flex; gap: 16px;">
              <li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
              <li><a href="#"><i class="fab fa-twitter"></i></a></li>
              <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
              <li><a href="#"><i class="fab fa-instagram"></i></a></li>
            </ul>
          </div>
        </div>
      </div>
      <div class="col-lg-2 col-md-6 mb-5 mb-lg-0">
        <div class="single-footer">
          <h3>Platform</h3>
          <ul class="quick-links" style="list-style: none; padding-left: 0;">
            <li class="mb-3"><a href="#">Browse Jobs</a></li>
            <li class="mb-3"><a href="#">Companies</a></li>
            <li class="mb-3"><a href="#">Candidates</a></li>
            <li class="mb-3"><a href="#">Pricing</a></li>
          </ul>
        </div>
      </div>
      <div class="col-lg-2 col-md-6 mb-5 mb-lg-0">
        <div class="single-footer">
          <h3>Support</h3>
          <ul class="quick-links" style="list-style: none; padding-left: 0;">
            <li class="mb-3"><a href="${pageContext.request.contextPath}/about-us.html">About Us</a></li>
            <li class="mb-3"><a href="#">Help Center</a></li>
            <li class="mb-3"><a href="${pageContext.request.contextPath}/terms-conditions.html">Terms & Conditions</a></li>
            <li class="mb-3"><a href="#">Privacy Policy</a></li>
            <li class="mb-3"><a href="#">Contact Us</a></li>
          </ul>
        </div>
      </div>
      <div class="col-lg-4 col-md-6">
        <div class="single-footer">
          <h3>Stay Updated</h3>
          <p class="mb-4" style="opacity: 0.7;">Subscribe to our newsletter for the latest career tips and job alerts.</p>
          <form action="${pageContext.request.contextPath}/subscribe" method="post" class="newsletter-inner">
            <input name="email" type="email" required placeholder="Email address" class="common-input">
            <button class="btn" type="submit">Subscribe Now</button>
          </form>
        </div>
      </div>
    </div>
    <div class="footer-bottom">
      <div class="row">
        <div class="col-md-6 text-center text-md-start">
          <p class="mb-0">&copy; 2026 JobU. Built for the future of work.</p>
        </div>
        <div class="col-md-6 text-center text-md-end mt-3 mt-md-0">
          <p class="mb-0">Designed with <i class="fas fa-heart text-danger"></i> by JobU Platform</p>
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

<script src="${pageContext.request.contextPath}/assets/js/bootstrap.min.js"></script>
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
    const signupForm = document.getElementById('jobSeekerSignupForm');
    if(signupForm){ 
      signupForm.addEventListener('submit', function(e) { 
        const pwd = document.getElementById('signupPassword')?.value; 
        const conf = document.getElementById('signupConfirmPassword')?.value; 
        const terms = document.getElementById('termsCheckbox'); 
        if(pwd !== conf){ e.preventDefault(); alert('Passwords do not match.'); return false; } 
        if(pwd && pwd.length < 6){ e.preventDefault(); alert('Password must be at least 6 characters.'); return false; } 
        if(terms && !terms.checked){ e.preventDefault(); alert('Please agree to Terms & Conditions.'); return false; } 
        return true; 
      }); 
    } 
  });
</script>
</body>
</html>
