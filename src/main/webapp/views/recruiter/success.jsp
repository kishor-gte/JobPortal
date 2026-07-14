<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Status | SmartInterview</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-darker: #1a2a2c;
            --bg-lighter: #3a4e51;
            --text-primary: #1e293b;
            --text-secondary: #64748b;
            --white: #ffffff;
            --success: #10b981;
            --danger: #ef4444;
            --warning: #f59e0b;
            --gradient-primary: linear-gradient(135deg, var(--primary) 0%, var(--accent) 100%);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.04);
            --shadow-md: 0 4px 16px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.12);
            --glow-primary: 0 0 20px rgba(25, 167, 123, 0.15);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
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

        .status-container {
            background: var(--white);
            border-radius: 24px;
            box-shadow: var(--shadow-lg);
            padding: 48px 40px;
            max-width: 520px;
            width: 100%;
            text-align: center;
            position: relative;
            z-index: 1;
            border: 1px solid rgba(25, 167, 123, 0.1);
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .status-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 24px;
            font-size: 40px;
        }

        .status-icon.success {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border: 2px solid rgba(16, 185, 129, 0.3);
            animation: successPulse 2s ease-in-out infinite;
        }

        .status-icon.error {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border: 2px solid rgba(239, 68, 68, 0.3);
        }

        @keyframes successPulse {
            0%, 100% {
                box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.3);
            }
            50% {
                box-shadow: 0 0 0 15px rgba(16, 185, 129, 0);
            }
        }

        .status-title {
            font-size: 28px;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 12px;
        }

        .status-message {
            font-size: 16px;
            color: var(--text-secondary);
            margin-bottom: 32px;
            line-height: 1.6;
        }

        .alert-custom {
            border-radius: 16px;
            padding: 16px 20px;
            margin-bottom: 24px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 12px;
            text-align: left;
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: var(--success);
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.08);
            border: 1px solid rgba(239, 68, 68, 0.2);
            color: var(--danger);
        }

        .btn-primary {
            background: var(--gradient-primary);
            color: white;
            border: none;
            padding: 14px 32px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 16px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 16px rgba(25, 167, 123, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
            color: white;
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
        }

        .btn-secondary {
            background: transparent;
            color: var(--text-secondary);
            border: 2px solid var(--border-color, #e0e6ed);
            padding: 14px 32px;
            border-radius: 30px;
            font-weight: 600;
            font-size: 16px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
        }

        .btn-secondary:hover {
            border-color: var(--primary);
            color: var(--primary);
            background: rgba(25, 167, 123, 0.05);
            transform: translateY(-2px);
        }

        .action-buttons {
            display: flex;
            gap: 16px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .brand-logo {
            margin-bottom: 24px;
        }

        .brand-logo img {
            max-height: 50px;
        }

        @media (max-width: 576px) {
            .status-container {
                padding: 36px 24px;
            }

            .status-icon {
                width: 64px;
                height: 64px;
                font-size: 32px;
            }

            .status-title {
                font-size: 24px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn-primary, .btn-secondary {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>

    <div class="status-container">
        <!-- Brand Logo -->
        <div class="brand-logo">
            <c:choose>
                <c:when test="${not empty message}">
                    <i class="fas fa-check-circle" style="font-size: 48px; color: var(--success);"></i>
                </c:when>
                <c:when test="${not empty error}">
                    <i class="fas fa-exclamation-circle" style="font-size: 48px; color: var(--danger);"></i>
                </c:when>
                <c:otherwise>
                    <i class="fas fa-building" style="font-size: 48px; color: var(--primary);"></i>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Status Icon -->
        <c:choose>
            <c:when test="${not empty message}">
                <div class="status-icon success">
                    <i class="fas fa-check-circle"></i>
                </div>
                <h2 class="status-title">Registration Successful!</h2>
                <p class="status-message">Your recruiter account has been created successfully. You can now log in to manage your job postings.</p>
                
                <div class="alert alert-success alert-custom">
                    <i class="fas fa-check-circle"></i> ${message}
                </div>
            </c:when>
            <c:when test="${not empty error}">
                <div class="status-icon error">
                    <i class="fas fa-times-circle"></i>
                </div>
                <h2 class="status-title">Registration Failed</h2>
                <p class="status-message">There was an issue with your registration. Please try again or contact support.</p>
                
                <div class="alert alert-danger alert-custom">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:when>
            <c:otherwise>
                <div class="status-icon success">
                    <i class="fas fa-info-circle"></i>
                </div>
                <h2 class="status-title">Status</h2>
                <p class="status-message">No status information available.</p>
            </c:otherwise>
        </c:choose>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/recruiter/login" class="btn btn-primary">
                <i class="fas fa-sign-in-alt"></i> Go to Login
            </a>
            <c:if test="${not empty error}">
                <a href="javascript:history.back()" class="btn-secondary">
                    <i class="fas fa-arrow-left"></i> Go Back
                </a>
            </c:if>
            <a href="${pageContext.request.contextPath}/" class="btn-secondary">
                <i class="fas fa-home"></i> Home
            </a>
        </div>
    </div>

    <script>
        // Auto-redirect on success after 5 seconds
        <c:if test="${not empty message}">
            setTimeout(function() {
                window.location.href = '${pageContext.request.contextPath}/recruiter/login';
            }, 5000);
        </c:if>

        // Keyboard shortcuts
        document.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                const loginLink = document.querySelector('a[href*="/recruiter/login"]');
                if (loginLink) {
                    window.location.href = loginLink.href;
                }
            }
        });
    </script>
</body>
</html>
