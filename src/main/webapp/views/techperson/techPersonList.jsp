<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Tech Persons | SmartInterview</title>
    
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
            --border-color: #e0e6ed;
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
            color: var(--text-primary);
            min-height: 100vh;
            padding-bottom: 2rem;
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
            position: relative;
            z-index: 1;
        }

        /* Page Header */
        .page-header {
            background: var(--gradient-primary);
            color: white;
            padding: 2.5rem 0;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-md);
            position: relative;
            overflow: hidden;
        }

        .page-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 100" preserveAspectRatio="none"><path d="M0,0 L1000,0 L1000,100 L0,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
            opacity: 0.1;
        }

        .page-header .container {
            position: relative;
            z-index: 2;
        }

        .page-header h1 {
            font-size: 2.2rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .page-header p {
            font-size: 1rem;
            opacity: 0.95;
            text-align: center;
        }

        /* Action Bar */
        .action-bar {
            background: var(--white);
            border-radius: 20px;
            padding: 1.5rem 2rem;
            box-shadow: var(--shadow-md);
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
            border: 1px solid rgba(25, 167, 123, 0.1);
            animation: fadeInUp 0.5s ease-out;
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .btn-add-techperson {
            background: var(--gradient-primary);
            color: white;
            border: none;
            border-radius: 30px;
            padding: 0.85rem 1.75rem;
            font-weight: 600;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            box-shadow: 0 4px 12px rgba(25, 167, 123, 0.3);
        }

        .btn-add-techperson:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(25, 167, 123, 0.4);
            color: white;
            background: linear-gradient(135deg, var(--primary-dark) 0%, var(--primary) 100%);
        }

        /* Tech Person Count Badge */
        .techperson-count {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: rgba(25, 167, 123, 0.08);
            color: var(--primary);
            padding: 0.6rem 1.2rem;
            border-radius: 30px;
            font-weight: 600;
            font-size: 0.9rem;
            border: 1px solid rgba(25, 167, 123, 0.15);
        }

        /* Tech Person Cards Grid */
        .techperson-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .techperson-card {
            background: var(--white);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            transition: all 0.3s ease;
            border: 1px solid rgba(25, 167, 123, 0.1);
            position: relative;
            overflow: hidden;
            animation: cardAppear 0.4s ease-out;
        }

        @keyframes cardAppear {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .techperson-card::before {
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

        .techperson-card:hover {
            transform: translateY(-6px);
            box-shadow: var(--shadow-lg), var(--glow-primary);
            border-color: var(--primary);
        }

        .techperson-card:hover::before {
            opacity: 1;
        }

        .techperson-icon {
            width: 64px;
            height: 64px;
            background: rgba(25, 167, 123, 0.1);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 1.5rem;
            margin-bottom: 1.25rem;
            border: 1px solid rgba(25, 167, 123, 0.15);
            transition: all 0.3s ease;
        }

        .techperson-card:hover .techperson-icon {
            background: var(--primary);
            color: white;
            box-shadow: var(--glow-primary);
        }

        .techperson-name {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .techperson-email {
            color: var(--text-secondary);
            font-size: 0.9rem;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .techperson-email i {
            color: var(--primary);
            font-size: 0.85rem;
        }

        .card-actions {
            display: flex;
            gap: 0.75rem;
            padding-top: 1.25rem;
            border-top: 1px solid var(--border-color);
        }

        .btn-action {
            flex: 1;
            padding: 0.7rem 1rem;
            border-radius: 12px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .btn-edit {
            background: rgba(25, 167, 123, 0.08);
            color: var(--primary);
            border: 1px solid rgba(25, 167, 123, 0.2);
        }

        .btn-edit:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--glow-primary);
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.08);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .btn-delete:hover {
            background: var(--danger);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 5rem 2rem;
            background: var(--white);
            border-radius: 24px;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25, 167, 123, 0.1);
        }

        .empty-state i {
            font-size: 4.5rem;
            color: var(--primary);
            margin-bottom: 1.5rem;
            opacity: 0.3;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
        }

        .empty-state h3 {
            color: var(--text-primary);
            font-weight: 700;
            margin-bottom: 0.5rem;
            font-size: 1.5rem;
        }

        .empty-state p {
            color: var(--text-secondary);
            font-size: 1rem;
            margin-bottom: 1.5rem;
        }

        /* Success/Error Messages */
        .alert-custom {
            border-radius: 16px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success-custom {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .alert-danger-custom {
            background: rgba(239, 68, 68, 0.08);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        /* Responsive Design */
        @media (max-width: 991.98px) {
            .techperson-grid {
                grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
                gap: 1.25rem;
            }
        }

        @media (max-width: 768px) {
            body {
                padding-bottom: 1rem;
            }

            .page-header {
                padding: 2rem 0;
            }

            .page-header h1 {
                font-size: 1.6rem;
            }

            .action-bar {
                flex-direction: column;
                align-items: stretch;
                padding: 1.25rem;
            }

            .btn-add-techperson {
                width: 100%;
                justify-content: center;
            }

            .techperson-count {
                width: 100%;
                justify-content: center;
            }

            .techperson-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .techperson-card {
                padding: 1.5rem;
            }
        }

        @media (max-width: 576px) {
            .page-header {
                padding: 1.5rem 0;
            }

            .page-header h1 {
                font-size: 1.4rem;
            }

            .techperson-icon {
                width: 52px;
                height: 52px;
                font-size: 1.25rem;
            }

            .techperson-name {
                font-size: 1.15rem;
            }

            .card-actions {
                flex-direction: column;
            }

            .btn-action {
                width: 100%;
            }

            .empty-state {
                padding: 3rem 1.5rem;
            }

            .empty-state i {
                font-size: 3.5rem;
            }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header">
        <div class="container">
            <h1>
                <i class="fas fa-user-tie"></i>
                Manage Tech Persons
            </h1>
            <p>${company.name}</p>
        </div>
    </div>

    <div class="container">
        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success-custom alert-custom">
                <i class="fas fa-check-circle"></i> ${message}
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="alert alert-danger-custom alert-custom">
                <i class="fas fa-exclamation-circle"></i> ${error}
            </div>
        </c:if>

        <!-- Action Bar -->
        <div class="action-bar">
            <div class="d-flex gap-3 flex-wrap">
                <a href="${pageContext.request.contextPath}/company/dashboard" class="btn btn-secondary" style="border-radius: 30px; padding: 0.85rem 1.75rem; font-weight: 600; display: inline-flex; align-items: center; gap: 0.5rem; text-decoration: none;">
                    <i class="fas fa-arrow-left"></i>
                    Back to Dashboard
                </a>
                <a href="${pageContext.request.contextPath}/techperson/register/${company.id}" class="btn-add-techperson">
                    <i class="fas fa-user-plus"></i>
                    Add New Tech Person
                </a>
            </div>
            <div class="techperson-count">
                <i class="fas fa-users"></i>
                <span>${fn:length(techpersons)} Tech Person${fn:length(techpersons) != 1 ? 's' : ''}</span>
            </div>
        </div>

        <!-- Tech Persons List -->
        <c:choose>
            <c:when test="${empty techpersons}">
                <div class="empty-state">
                    <i class="fas fa-user-tie"></i>
                    <h3>No Tech Persons Found</h3>
                    <p>Get started by adding your first techperson to manage job postings.</p>
                    <a href="${pageContext.request.contextPath}/techperson/register/${company.id}" class="btn-add-techperson">
                        <i class="fas fa-user-plus"></i>
                        Add First Tech Person
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="techperson-grid">
                    <c:forEach var="techperson" items="${techpersons}" varStatus="status">
                        <div class="techperson-card" style="animation-delay: ${status.index * 0.05}s;">
                            <div class="techperson-icon">
                                <i class="fas fa-user-tie"></i>
                            </div>
                            <h3 class="techperson-name">${techperson.name}</h3>
                            <div class="techperson-email">
                                <i class="fas fa-envelope"></i>
                                <span>${techperson.email}</span>
                            </div>
                            <div class="card-actions">
                                <a href="${pageContext.request.contextPath}/techperson/edit/${techperson.id}" class="btn-action btn-edit">
                                    <i class="fas fa-edit"></i>
                                    Edit
                                </a>
                                <a href="${pageContext.request.contextPath}/techperson/delete/${techperson.id}" 
                                   class="btn-action btn-delete"
                                   onclick="return confirm('Are you sure you want to delete this techperson? This action cannot be undone.');">
                                    <i class="fas fa-trash-alt"></i>
                                    Delete
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>




