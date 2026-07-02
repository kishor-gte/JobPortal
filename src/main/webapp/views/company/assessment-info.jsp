<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>How Assessments Work | JobU - Smart Recruitment Platform</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --primary-light: #3BC49A;
            --primary-glow: rgba(25,167,123,0.2);
            --secondary: #2E3E41;
            --bg-light: #f4fbf9;
            --bg-white: #ffffff;
            --text-dark: #1a2c2f;
            --text-muted: #5a6e66;
            --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
            --shadow-sm: 0 10px 30px -8px rgba(0,0,0,0.05);
            --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
            --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
            --shadow-xl: 0 40px 60px -20px rgba(25,167,123,0.25);
            --transition: all 0.5s cubic-bezier(0.2, 0.95, 0.4, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            color: var(--text-dark);
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #e6f4ef; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--primary-dark); }

        /* ========== PREMIUM PAGE HEADER ========== */
        .page-header {
            background: var(--gradient-dark);
            color: white;
            padding: 60px 0 50px;
            position: relative;
            overflow: hidden;
            margin-bottom: 50px;
        }
        .page-header::before {
            content: '';
            position: absolute;
            top: -30%;
            right: -10%;
            width: 500px;
            height: 500px;
            background: radial-gradient(circle, rgba(59,196,154,0.15) 0%, transparent 70%);
            border-radius: 50%;
            animation: floatGlow 20s infinite alternate;
        }
        .page-header::after {
            content: '';
            position: absolute;
            bottom: -20%;
            left: -5%;
            width: 400px;
            height: 400px;
            background: radial-gradient(circle, rgba(25,167,123,0.1) 0%, transparent 70%);
            border-radius: 50%;
            animation: floatGlow2 18s infinite alternate;
        }
        @keyframes floatGlow {
            0% { transform: translate(0,0) scale(1); opacity: 0.3; }
            100% { transform: translate(-60px, 50px) scale(1.3); opacity: 0.6; }
        }
        @keyframes floatGlow2 {
            0% { transform: translate(0,0) scale(1); opacity: 0.2; }
            100% { transform: translate(60px, -40px) scale(1.2); opacity: 0.5; }
        }
        .page-header h1 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 15px;
            background: linear-gradient(135deg, #ffffff, #3BC49A);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            animation: textShine 3s infinite;
        }
        @keyframes textShine {
            0%, 100% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
        }
        .page-header p {
            font-size: 1.2rem;
            opacity: 0.92;
            max-width: 600px;
            margin: 0 auto;
        }

        /* ========== FLOW CONTAINER ========== */
        .flow-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px 60px;
        }

        /* ========== PREMIUM FLOW STEPS ========== */
        .flow-step {
            background: var(--bg-white);
            border-radius: 32px;
            padding: 2.5rem;
            margin-bottom: 2.5rem;
            box-shadow: var(--shadow-sm);
            position: relative;
            transition: var(--transition);
            border: 1px solid rgba(25,167,123,0.08);
            overflow: hidden;
        }
        .flow-step:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-lg);
            border-color: rgba(25,167,123,0.2);
        }
        .flow-step::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 4px;
            background: var(--gradient);
            transform: scaleX(0);
            transition: transform 0.5s ease;
            transform-origin: left;
        }
        .flow-step:hover::before {
            transform: scaleX(1);
        }

        /* Step Number Badge */
        .step-number {
            width: 65px;
            height: 65px;
            border-radius: 50%;
            background: var(--gradient);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            font-weight: 800;
            position: absolute;
            top: -30px;
            left: 35px;
            box-shadow: var(--shadow-md);
            transition: var(--transition);
        }
        .flow-step:hover .step-number {
            transform: scale(1.05);
            box-shadow: var(--shadow-xl);
        }

        /* Role Badges */
        .role-badge {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 6px 16px;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 700;
            margin-bottom: 1.2rem;
            margin-left: 50px;
        }
        .role-badge.company {
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            color: var(--primary);
            border: 1px solid rgba(25,167,123,0.2);
        }
        .role-badge.jobseeker {
            background: linear-gradient(135deg, rgba(59,130,246,0.12), rgba(59,130,246,0.08));
            color: #3b82f6;
            border: 1px solid rgba(59,130,246,0.2);
        }

        .step-title {
            font-size: 1.6rem;
            font-weight: 800;
            margin-bottom: 1rem;
            margin-top: 0.5rem;
            background: linear-gradient(135deg, var(--text-dark), var(--primary));
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .step-description {
            font-size: 1rem;
            line-height: 1.7;
            color: var(--text-muted);
            margin-bottom: 1.5rem;
        }

        /* Custom List Styling */
        .custom-list {
            list-style: none;
            padding-left: 0;
        }
        .custom-list li {
            padding: 8px 0 8px 28px;
            position: relative;
            color: var(--text-muted);
            line-height: 1.6;
        }
        .custom-list li::before {
            content: '✓';
            position: absolute;
            left: 0;
            color: var(--primary);
            font-weight: 700;
        }
        .nested-list {
            list-style: none;
            padding-left: 30px;
        }
        .nested-list li {
            padding: 4px 0 4px 24px;
            position: relative;
        }
        .nested-list li::before {
            content: '→';
            position: absolute;
            left: 0;
            color: var(--primary-light);
        }

        /* Highlight Box */
        .highlight-box {
            background: linear-gradient(135deg, rgba(25,167,123,0.08), rgba(59,196,154,0.05));
            border-left: 4px solid var(--primary);
            padding: 1rem 1.5rem;
            border-radius: 16px;
            margin: 1.5rem 0;
            transition: var(--transition);
        }
        .highlight-box:hover {
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            transform: translateX(5px);
        }
        .highlight-box i {
            color: var(--primary);
            margin-right: 10px;
        }
        .highlight-box code {
            background: rgba(25,167,123,0.1);
            padding: 3px 8px;
            border-radius: 8px;
            font-size: 0.85rem;
            color: var(--primary-dark);
        }

        /* Screenshot Mockup */
        .step-screenshot {
            background: linear-gradient(135deg, #f8fafc, #ffffff);
            border: 1px solid rgba(25,167,123,0.15);
            border-radius: 20px;
            padding: 1.8rem;
            text-align: center;
            margin-top: 1.5rem;
            transition: var(--transition);
        }
        .step-screenshot:hover {
            border-color: var(--primary-light);
            box-shadow: var(--shadow-sm);
        }
        .step-screenshot i {
            font-size: 3rem;
            color: var(--primary);
            margin-bottom: 1rem;
            display: inline-block;
            animation: iconFloat 3s infinite ease-in-out;
        }
        @keyframes iconFloat {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }
        .step-screenshot p {
            font-weight: 700;
            color: var(--text-dark);
            margin: 0;
        }
        .step-screenshot small {
            color: var(--text-muted);
            font-size: 0.8rem;
        }

        /* Data Flow Diagram */
        .data-flow-diagram {
            background: white;
            padding: 1.8rem;
            border-radius: 20px;
            line-height: 2;
            border: 1px solid rgba(25,167,123,0.15);
        }
        .flow-line {
            margin-bottom: 1.2rem;
            padding: 0.8rem;
            background: var(--bg-light);
            border-radius: 12px;
            transition: var(--transition);
        }
        .flow-line:hover {
            background: rgba(25,167,123,0.05);
            transform: translateX(5px);
        }
        .flow-line strong {
            color: var(--primary);
            display: block;
            margin-bottom: 6px;
        }
        .flow-line code {
            background: rgba(25,167,123,0.08);
            padding: 4px 10px;
            border-radius: 8px;
            font-size: 0.85rem;
            color: var(--primary-dark);
        }
        .flow-line small {
            color: var(--text-muted);
            font-size: 0.75rem;
            display: block;
            margin-top: 5px;
        }

        /* Back Button */
        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 14px 36px;
            border-radius: 60px;
            font-weight: 700;
            font-size: 1rem;
            color: white;
            background: var(--gradient);
            text-decoration: none;
            transition: var(--transition);
            box-shadow: 0 8px 20px rgba(25,167,123,0.35);
            margin-top: 30px;
        }
        .btn-back:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(25,167,123,0.45);
            color: white;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header h1 { font-size: 2rem; }
            .page-header p { font-size: 1rem; }
            .flow-step { padding: 1.8rem; }
            .step-number { width: 50px; height: 50px; font-size: 1.4rem; top: -22px; left: 20px; }
            .role-badge { margin-left: 35px; }
            .step-title { font-size: 1.3rem; }
        }
    </style>
</head>
<body>

    <!-- Premium Page Header -->
    <div class="page-header text-center" data-aos="fade-down">
        <div class="container">
            <h1><i class="fas fa-graduation-cap me-3"></i>How Assessment Questions Work</h1>
            <p>Complete flow of how your uploaded questions are used in the assessment process</p>
        </div>
    </div>

    <div class="flow-container">
        
        <!-- Step 1: Company Uploads Questions -->
        <div class="flow-step" data-aos="fade-up" data-aos-delay="100">
            <div class="step-number">1</div>
            <span class="role-badge company"><i class="fas fa-building"></i> Company / Recruiter</span>
            <h3 class="step-title">Upload Assessment Questions</h3>
            <p class="step-description">
                As a company, you upload an Excel file (.xlsx) containing assessment questions for a specific skill (e.g., Java, Python, JavaScript) 
                for a particular job position. The questions include:
            </p>
            <ul class="custom-list">
                <li><strong>Question text</strong> - The actual question</li>
                <li><strong>Four options (A, B, C, D)</strong> - Multiple choice options</li>
                <li><strong>Correct answer</strong> - The correct option (A, B, C, or D)</li>
            </ul>
            <div class="highlight-box">
                <i class="fas fa-lightbulb"></i>
                <strong>Storage:</strong> Questions are saved in the <code>assessment_question</code> table with <code>sourceType='RECRUITER'</code> and linked to your <code>jobId</code>.
            </div>
        </div>

        <!-- Step 2: Company Sends Assessment Invite -->
        <div class="flow-step" data-aos="fade-up" data-aos-delay="150">
            <div class="step-number">2</div>
            <span class="role-badge company"><i class="fas fa-building"></i> Company / Recruiter</span>
            <h3 class="step-title">Invite Job Seeker for Assessment</h3>
            <p class="step-description">
                When reviewing applicants for your job posting, you can select a candidate and choose to 
                <strong>"Schedule Assessment"</strong>. This creates an assessment invitation that is sent to the job seeker.
            </p>
            <div class="highlight-box">
                <i class="fas fa-envelope"></i>
                <strong>Invitation:</strong> An invitation record is created in the <code>assessment_invitation</code> table with type <code>'JOB'</code>, 
                linking the job seeker, skill, and job.
            </div>
        </div>

        <!-- Step 3: Job Seeker Receives Invitation -->
        <div class="flow-step" data-aos="fade-up" data-aos-delay="200">
            <div class="step-number">3</div>
            <span class="role-badge jobseeker"><i class="fas fa-user"></i> Job Seeker</span>
            <h3 class="step-title">Job Seeker Views Assessment Invites</h3>
            <p class="step-description">
                The job seeker logs into their account and navigates to <strong>"Assessments"</strong> section 
                (URL: <code>/assessment/my-invites</code>). They see all pending assessment invitations from companies.
            </p>
            <div class="step-screenshot">
                <i class="fas fa-clipboard-list"></i>
                <p>Job Seeker Dashboard → Assessments → My Assessment Invites</p>
                <small>Shows list of pending assessments with skill name, company, and "Start Assessment" button</small>
            </div>
        </div>

        <!-- Step 4: Job Seeker Takes Test -->
        <div class="flow-step" data-aos="fade-up" data-aos-delay="250">
            <div class="step-number">4</div>
            <span class="role-badge jobseeker"><i class="fas fa-user"></i> Job Seeker</span>
            <h3 class="step-title">Job Seeker Takes the Assessment</h3>
            <p class="step-description">
                When the job seeker clicks <strong>"Start Assessment"</strong>, the system:
            </p>
            <ul class="custom-list">
                <li>Retrieves all questions from the <code>assessment_question</code> table where:</li>
            </ul>
            <ul class="nested-list">
                <li><code>skill</code> matches the invitation skill</li>
                <li><code>sourceType = 'RECRUITER'</code></li>
                <li><code>jobId</code> matches the job</li>
                <li><code>recruiterId</code> matches the recruiter who posted the job</li>
            </ul>
            <ul class="custom-list">
                <li>Questions are randomly shuffled</li>
                <li>Displayed on the assessment page (URL: <code>/assessment/start-test/${inviteId}</code>)</li>
            </ul>
            <div class="step-screenshot">
                <i class="fas fa-question-circle"></i>
                <p>Assessment Test Page</p>
                <small>Shows all questions with radio buttons for options A, B, C, D and a "Submit Test" button</small>
            </div>
        </div>

        <!-- Step 5: Job Seeker Submits Test -->
        <div class="flow-step" data-aos="fade-up" data-aos-delay="300">
            <div class="step-number">5</div>
            <span class="role-badge jobseeker"><i class="fas fa-user"></i> Job Seeker</span>
            <h3 class="step-title">Job Seeker Submits Answers</h3>
            <p class="step-description">
                After answering all questions, the job seeker clicks <strong>"Submit Test"</strong>. The system:
            </p>
            <ul class="custom-list">
                <li>Compares each answer with the correct answer from your uploaded Excel</li>
                <li>Calculates the score (correct answers / total questions)</li>
                <li>Saves the result in <code>assessment_result</code> table</li>
                <li>Updates invitation status to <code>'COMPLETED'</code></li>
            </ul>
            <div class="highlight-box">
                <i class="fas fa-trophy"></i>
                <strong>Scoring:</strong> Gold (≥85%), Silver (70-84%), Bronze (60-69%), Fail (&lt;60%)
            </div>
        </div>

        <!-- Step 6: Company Views Results -->
        <div class="flow-step" data-aos="fade-up" data-aos-delay="350">
            <div class="step-number">6</div>
            <span class="role-badge company"><i class="fas fa-building"></i> Company / Recruiter</span>
            <h3 class="step-title">Company Views Assessment Results</h3>
            <p class="step-description">
                As a company, you can view the assessment results for each applicant in the 
                <strong>Applicants List</strong> page (URL: <code>/recruiter/jobs/${jobId}/applicants</code>).
            </p>
            <ul class="custom-list">
                <li>Shows score: <strong>X/Y</strong> (correct/total)</li>
                <li>Shows badge earned: Gold, Silver, Bronze, or Fail</li>
                <li>Shows submission date and time</li>
                <li>Helps you make informed hiring decisions</li>
            </ul>
            <div class="step-screenshot">
                <i class="fas fa-chart-bar"></i>
                <p>Recruiter Dashboard → Job Applicants → Assessment Results</p>
                <small>Shows applicant name, email, score, badge, and status update options</small>
            </div>
        </div>

        <!-- Summary Box - Data Flow Diagram -->
        <div class="flow-step" data-aos="fade-up" data-aos-delay="400" style="background: linear-gradient(135deg, rgba(25,167,123,0.03), rgba(59,196,154,0.01));">
            <h3 class="step-title"><i class="fas fa-link me-2"></i>Data Flow Summary</h3>
            <p class="step-description">
                Here's how your uploaded questions flow through the system:
            </p>
            <div class="data-flow-diagram">
                <div class="flow-line">
                    <strong>1. Upload:</strong>
                    <code>Excel File</code> → <code>assessment_question</code> table<br>
                    <small>(sourceType='RECRUITER', jobId=your_job_id)</small>
                </div>
                <div class="flow-line">
                    <strong>2. Invite:</strong>
                    <code>assessment_invitation</code> table<br>
                    <small>(type='JOB', skill, jobId, jobSeekerId)</small>
                </div>
                <div class="flow-line">
                    <strong>3. Test:</strong>
                    Questions fetched where <code>skill + jobId + recruiterId</code> match<br>
                    <small>Questions shown to job seeker in random order</small>
                </div>
                <div class="flow-line">
                    <strong>4. Result:</strong>
                    <code>assessment_result</code> table<br>
                    <small>(score, badge, visible to recruiter in applicants list)</small>
                </div>
            </div>
        </div>

        <!-- Back Button -->
        <div style="text-align: center;">
            <a href="${pageContext.request.contextPath}/jobs/by-company/${companyId}" class="btn-back">
                <i class="fas fa-arrow-left"></i>
                Back to Job Listings
            </a>
        </div>

    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        // Initialize AOS for scroll animations
        AOS.init({
            duration: 800,
            once: true,
            offset: 50
        });
    </script>
</body>
</html>