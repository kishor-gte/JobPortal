<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <title>Upload Culture Video | JobU - Showcase Your Company Culture</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:opsz,wght@14..32,300;14..32,400;14..32,500;14..32,600;14..32,700;14..32,800;14..32,900&display=swap" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <!-- AOS Animation -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    
    <style>
        :root {
            --primary: #19A77B;
            --primary-dark: #148F69;
            --primary-light: #3BC49A;
            --primary-glow: rgba(25,167,123,0.15);
            --accent: #3BC49A;
            --bg-dark: #2E3E41;
            --bg-light: #f4fbf9;
            --text-dark: #1a2c2f;
            --text-muted: #5a6e66;
            --white: #ffffff;
            --border: #e2e8f0;
            --gradient: linear-gradient(135deg, #19A77B 0%, #3BC49A 100%);
            --gradient-dark: linear-gradient(135deg, #1e2f32 0%, #2E3E41 100%);
            --shadow-sm: 0 10px 25px -5px rgba(0,0,0,0.05);
            --shadow-md: 0 20px 35px -12px rgba(25,167,123,0.15);
            --shadow-lg: 0 30px 50px -15px rgba(0,0,0,0.12);
            --radius: 24px;
            --radius-sm: 16px;
            --transition: all 0.4s cubic-bezier(0.2, 0.95, 0.4, 1);
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
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar { width: 8px; }
        ::-webkit-scrollbar-track { background: #e6f4ef; border-radius: 10px; }
        ::-webkit-scrollbar-thumb { background: var(--primary); border-radius: 10px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--primary-dark); }

        /* ========== PAGE HEADER ========== */
        .page-header {
            background: var(--gradient-dark);
            color: white;
            padding: 60px 0 50px;
            position: relative;
            overflow: hidden;
            margin-bottom: 40px;
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
        .page-header h2 {
            font-size: 2rem;
            font-weight: 800;
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
            font-size: 1rem;
            opacity: 0.9;
        }

        /* Back Button */
        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: var(--white);
            color: var(--primary);
            border: 1px solid rgba(25,167,123,0.2);
            border-radius: 50px;
            padding: 10px 24px;
            font-weight: 600;
            font-size: 0.85rem;
            text-decoration: none;
            transition: var(--transition);
            margin-bottom: 24px;
        }
        .back-btn:hover {
            background: var(--primary);
            color: white;
            transform: translateX(-4px);
            border-color: transparent;
        }

        /* ========== UPLOAD CARD ========== */
        .upload-card {
            max-width: 700px;
            margin: 0 auto;
            background: var(--white);
            border-radius: var(--radius);
            padding: 40px;
            box-shadow: var(--shadow-sm);
            border: 1px solid rgba(25,167,123,0.1);
            transition: var(--transition);
        }
        .upload-card:hover {
            box-shadow: var(--shadow-md);
        }

        .upload-icon {
            width: 80px;
            height: 80px;
            background: linear-gradient(135deg, rgba(25,167,123,0.12), rgba(59,196,154,0.08));
            border-radius: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 24px;
        }
        .upload-icon i {
            font-size: 36px;
            color: var(--primary);
        }

        .company-name {
            text-align: center;
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 28px;
            padding-bottom: 16px;
            border-bottom: 2px solid var(--border);
        }

        /* Form Styles */
        .form-group {
            margin-bottom: 24px;
        }
        .form-label {
            font-weight: 600;
            font-size: 0.85rem;
            color: var(--text-dark);
            display: block;
            margin-bottom: 8px;
        }
        .form-label i {
            color: var(--primary);
            margin-right: 8px;
        }
        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--border);
            border-radius: 12px;
            font-size: 0.9rem;
            transition: var(--transition);
            background: var(--bg-light);
            font-family: inherit;
        }
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(25,167,123,0.1);
            background: var(--white);
        }
        textarea.form-control {
            resize: vertical;
            min-height: 100px;
        }

        /* File Upload Area */
        .file-upload-area {
            border: 2px dashed var(--border);
            border-radius: 20px;
            padding: 30px 20px;
            text-align: center;
            cursor: pointer;
            transition: var(--transition);
            background: var(--bg-light);
        }
        .file-upload-area:hover {
            border-color: var(--primary);
            background: rgba(25,167,123,0.05);
        }
        .file-upload-area.has-file {
            border-color: var(--primary);
            background: rgba(25,167,123,0.05);
        }
        .file-upload-icon {
            font-size: 48px;
            color: var(--primary);
            margin-bottom: 12px;
        }
        .file-upload-text {
            color: var(--text-muted);
            font-size: 0.85rem;
        }
        .file-name {
            margin-top: 10px;
            font-weight: 600;
            color: var(--primary-dark);
            font-size: 0.85rem;
        }

        /* Video Preview */
        .video-preview {
            margin-top: 20px;
            display: none;
        }
        .video-preview video {
            width: 100%;
            border-radius: 16px;
            border: 1px solid var(--border);
        }

        /* Submit Button */
        .btn-submit {
            background: var(--gradient);
            color: white;
            border: none;
            border-radius: 60px;
            padding: 14px 28px;
            font-size: 1rem;
            font-weight: 700;
            width: 100%;
            transition: var(--transition);
            box-shadow: 0 4px 12px rgba(25,167,123,0.3);
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            cursor: pointer;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(25,167,123,0.4);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header { padding: 40px 0 30px; }
            .page-header h2 { font-size: 1.5rem; }
            .upload-card { padding: 28px; margin: 0 20px; }
        }
    </style>
</head>
<body>

    <!-- Page Header -->
    <div class="page-header" data-aos="fade-down">
        <div class="container text-center">
            <h2><i class="fas fa-video me-2"></i>Upload Culture Video</h2>
            <p>Share your company culture with potential candidates</p>
        </div>
    </div>

    <div class="container">
        <!-- Back Button -->
        <a href="${pageContext.request.contextPath}/company/media/${company.id}" class="back-btn" data-aos="fade-right">
            <i class="fas fa-arrow-left"></i> Back to Videos
        </a>

        <!-- Upload Card -->
        <div class="upload-card" data-aos="fade-up" data-aos-delay="100">
            <div class="upload-icon">
                <i class="fas fa-video"></i>
            </div>
            <div class="company-name">
                <i class="fas fa-building me-2"></i>${company.name}
            </div>

            <!-- Upload Form -->
            <form action="${pageContext.request.contextPath}/company/media/add/${company.id}" method="post" enctype="multipart/form-data" id="uploadForm">
                <div class="form-group">
                    <label class="form-label"><i class="fas fa-heading"></i> Video Title</label>
                    <input type="text" name="title" class="form-control" placeholder="e.g., Team Building 2024, Office Tour, Company Culture" required>
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-file-video"></i> Video File</label>
                    <div class="file-upload-area" id="fileUploadArea" onclick="document.getElementById('videoFile').click()">
                        <i class="fas fa-cloud-upload-alt file-upload-icon"></i>
                        <div class="file-upload-text">Click to select video file or drag and drop</div>
                        <div class="file-upload-text small">MP4, MOV, AVI (Max 50MB)</div>
                        <div class="file-name" id="fileName"></div>
                    </div>
                    <input type="file" name="videoFile" id="videoFile" accept="video/*" style="display: none;" required onchange="handleFileSelect(event)">
                </div>

                <!-- Video Preview -->
                <div class="video-preview" id="videoPreview">
                    <video controls>
                        <source src="" id="videoSource">
                        Your browser does not support the video tag.
                    </video>
                </div>

                <div class="form-group">
                    <label class="form-label"><i class="fas fa-align-left"></i> Description (Optional)</label>
                    <textarea name="description" class="form-control" rows="3" placeholder="Tell us about this video..."></textarea>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-upload"></i> Upload Video
                </button>
            </form>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true, offset: 50 });

        function handleFileSelect(event) {
            const file = event.target.files[0];
            const fileNameSpan = document.getElementById('fileName');
            const fileUploadArea = document.getElementById('fileUploadArea');
            const videoPreview = document.getElementById('videoPreview');
            const videoSource = document.getElementById('videoSource');
            
            if (file) {
                fileNameSpan.textContent = file.name;
                fileUploadArea.classList.add('has-file');
                
                // Preview video
                const url = URL.createObjectURL(file);
                videoSource.src = url;
                videoPreview.style.display = 'block';
                
                // Clean up URL when done
                videoSource.onload = () => URL.revokeObjectURL(url);
            } else {
                fileNameSpan.textContent = '';
                fileUploadArea.classList.remove('has-file');
                videoPreview.style.display = 'none';
                videoSource.src = '';
            }
        }

        // Form validation
        document.getElementById('uploadForm').addEventListener('submit', function(e) {
            const titleInput = document.querySelector('input[name="title"]');
            const fileInput = document.getElementById('videoFile');
            
            if (!titleInput.value.trim()) {
                e.preventDefault();
                alert('Please enter a video title');
                titleInput.focus();
                return false;
            }
            
            if (!fileInput.files || fileInput.files.length === 0) {
                e.preventDefault();
                alert('Please select a video file to upload');
                return false;
            }
            
            const file = fileInput.files[0];
            if (file.size > 50 * 1024 * 1024) {
                e.preventDefault();
                alert('File size must be less than 50MB');
                return false;
            }
        });
    </script>
</body>
</html>