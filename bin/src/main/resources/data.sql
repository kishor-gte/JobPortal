-- Sample Data for Smart Interview Platform

-- Insert Categories
INSERT IGNORE INTO categories (id, name, description, icon, color) VALUES
(1, 'Java', 'Core Java and Advanced Java concepts', 'fab fa-java', '#f89820'),
(2, 'React', 'React.js frontend development', 'fab fa-react', '#61dafb'),
(3, 'Python', 'Python programming language', 'fab fa-python', '#3776ab'),
(4, 'JavaScript', 'JavaScript and ES6+ concepts', 'fab fa-js-square', '#f7df1e'),
(5, 'SQL', 'Database and SQL queries', 'fas fa-database', '#336791'),
(6, 'Spring Boot', 'Spring Boot framework', 'fas fa-leaf', '#6db33f'),
(7, 'Data Structures', 'Arrays, Lists, Trees, Graphs', 'fas fa-project-diagram', '#e74c3c'),
(8, 'System Design', 'System design and architecture', 'fas fa-sitemap', '#9b59b6');

-- Insert Admin User (password: admin123)
INSERT IGNORE INTO users (id, username, password, email, full_name, role, is_active) VALUES
(1, 'ak421237@gmail.com', 'admin123', 'ak421237@gmail.com', 'System Admin', 'ADMIN', TRUE);

-- Insert Interviewer Users
INSERT IGNORE INTO users (id, username, password, email, full_name, role, is_active) VALUES
(2, 'interviewer1@smartinterview.com', 'pass123', 'interviewer1@smartinterview.com', 'Rahul Sharma', 'INTERVIEWER', TRUE),
(3, 'interviewer2@smartinterview.com', 'pass123', 'interviewer2@smartinterview.com', 'Priya Patel', 'INTERVIEWER', TRUE);

-- Insert Student Users
INSERT IGNORE INTO users (id, username, password, email, full_name, role, is_active) VALUES
(4, 'student1@smartinterview.com', 'pass123', 'student1@smartinterview.com', 'Amit Kumar', 'STUDENT', TRUE),
(5, 'student2@smartinterview.com', 'pass123', 'student2@smartinterview.com', 'Sneha Gupta', 'STUDENT', TRUE),
(6, 'student3@smartinterview.com', 'pass123', 'student3@smartinterview.com', 'Ravi Singh', 'STUDENT', TRUE);

-- Migrate existing users: set username = email for login by email
UPDATE users SET username = email WHERE username != email;
-- Update admin email
UPDATE users SET email = 'ak421237@gmail.com', username = 'ak421237@gmail.com' WHERE id = 1;

-- Insert Coding Questions
INSERT IGNORE INTO coding_questions (id, title, description, difficulty, category_id, sample_input, sample_output, solution, created_by) VALUES
(1, 'Two Sum', 'Given an array of integers nums and an integer target, return indices of the two numbers that add up to target.', 'EASY', 7, 'nums = [2,7,11,15], target = 9', '[0,1]', 'Use a HashMap to store complements', 1),
(2, 'Reverse String', 'Write a function that reverses a string.', 'EASY', 4, '"hello"', '"olleh"', 'Use two pointers or StringBuilder', 1),
(3, 'Binary Search', 'Implement binary search algorithm on a sorted array.', 'MEDIUM', 7, '[1,3,5,7,9], target=5', '2', 'Divide array in half repeatedly', 1),
(4, 'Singleton Pattern', 'Implement a thread-safe Singleton pattern in Java.', 'MEDIUM', 1, 'N/A', 'Single instance', 'Use double-checked locking or enum', 1),
(5, 'REST API Design', 'Design a REST API for a library management system.', 'HARD', 6, 'N/A', 'Endpoints list', 'Follow REST conventions with proper HTTP methods', 1),
(6, 'SQL Join Query', 'Write a query to find employees with salary greater than their department average.', 'MEDIUM', 5, 'employees table, departments table', 'List of employees', 'Use subquery or window functions', 1),
(7, 'React State Management', 'Explain and implement state management using Context API in React.', 'MEDIUM', 2, 'N/A', 'Context implementation', 'Create context, provider, and useContext hook', 1),
(8, 'Python List Comprehension', 'Generate a list of squares of even numbers from 1 to 20 using list comprehension.', 'EASY', 3, '1 to 20', '[4, 16, 36, ...]', '[x**2 for x in range(1,21) if x%2==0]', 1);

-- Insert Interview Questions
INSERT IGNORE INTO interview_questions (id, question, category_id, difficulty, expected_answer, question_type, created_by) VALUES
(1, 'Explain the difference between HashMap and TreeMap in Java.', 1, 'MEDIUM', 'HashMap is unordered O(1) operations, TreeMap is sorted O(log n) operations.', 'TECHNICAL', 1),
(2, 'What is Virtual DOM in React?', 2, 'EASY', 'Virtual DOM is an in-memory representation of the real DOM that React uses for efficient updates.', 'TECHNICAL', 1),
(3, 'Describe a challenging project you worked on.', NULL, 'MEDIUM', 'Open ended - evaluate communication and problem-solving.', 'BEHAVIORAL', 1),
(4, 'Where do you see yourself in 5 years?', NULL, 'EASY', 'Evaluate career goals and ambition.', 'HR', 1),
(5, 'Explain dependency injection in Spring Boot.', 6, 'MEDIUM', 'DI is a design pattern where objects receive dependencies instead of creating them.', 'TECHNICAL', 1),
(6, 'What are Python decorators?', 3, 'MEDIUM', 'Decorators modify the behavior of functions/classes using the @decorator syntax.', 'TECHNICAL', 1);

-- Insert Sample Performance Scores
INSERT IGNORE INTO performance_scores (id, student_id, category_id, total_questions, correct_answers, avg_score, coding_score, interview_score, overall_score) VALUES
(1, 4, 1, 10, 7, 70.00, 72.50, 68.00, 70.25),
(2, 4, 7, 8, 5, 62.50, 65.00, 60.00, 62.50),
(3, 5, 2, 12, 10, 83.33, 85.00, 80.00, 82.50),
(4, 6, 3, 6, 4, 66.67, 70.00, 63.00, 66.50);

-- Insert Sample Mock Interviews
INSERT IGNORE INTO mock_interviews (id, student_id, interviewer_id, scheduled_at, duration_minutes, status, meeting_link) VALUES
(1, 4, 2, '2026-03-15 10:00:00', 45, 'SCHEDULED', 'https://meet.smartinterview.com/room-001'),
(2, 5, 3, '2026-03-16 14:00:00', 30, 'SCHEDULED', 'https://meet.smartinterview.com/room-002'),
(3, 4, 3, '2026-03-10 09:00:00', 45, 'COMPLETED', 'https://meet.smartinterview.com/room-003'),
(4, 6, 2, '2026-03-12 11:00:00', 30, 'SCHEDULED', 'https://meet.smartinterview.com/room-004');

-- Insert Sample AI Evaluations
INSERT IGNORE INTO ai_evaluations (id, student_id, interview_id, answer_analysis, communication_score, technical_score, confidence_score, overall_score, strengths, weaknesses, improvement_suggestions) VALUES
(1, 4, 3, 'Student demonstrated good understanding of core concepts but struggled with advanced topics.', 7.50, 6.80, 7.00, 7.10, 'Good communication skills, Clear explanations, Strong fundamentals', 'Needs improvement in system design, Should practice more complex algorithms', 'Practice system design problems daily, Study design patterns, Work on time management during coding rounds'),
(2, 5, NULL, 'Excellent technical skills with strong problem-solving approach.', 8.50, 9.00, 8.00, 8.50, 'Strong coding skills, Excellent problem solving, Good time management', 'Could improve behavioral answers, Need more domain knowledge', 'Prepare STAR method answers for behavioral questions, Study domain-specific concepts');

-- Insert Sample Progress Tracking
INSERT IGNORE INTO progress_tracking (id, student_id, date, questions_attempted, questions_correct, time_spent_minutes, score) VALUES
(1, 4, '2026-03-01', 5, 3, 45, 60.00),
(2, 4, '2026-03-02', 8, 6, 60, 75.00),
(3, 4, '2026-03-03', 6, 5, 50, 83.33),
(4, 4, '2026-03-04', 10, 7, 80, 70.00),
(5, 4, '2026-03-05', 7, 6, 55, 85.71),
(6, 5, '2026-03-01', 10, 8, 70, 80.00),
(7, 5, '2026-03-02', 12, 10, 90, 83.33),
(8, 5, '2026-03-03', 8, 7, 60, 87.50);

-- Insert Sample Feedbacks
INSERT IGNORE INTO feedbacks (id, interview_id, interviewer_id, student_id, technical_rating, communication_rating, problem_solving_rating, overall_rating, comments, recommendation) VALUES
(1, 3, 3, 4, 7, 8, 6, 7, 'Amit showed good communication skills but needs to work on problem-solving speed. Fundamentals are strong.', 'YES');

-- Clean up any previously inserted jobs that were incorrectly mapped to existing users
DELETE FROM job_applications WHERE job_id IN (1, 2, 3, 4, 5, 6, 7, 8);
DELETE FROM jobs WHERE id IN (1, 2, 3, 4, 5, 6, 7, 8);
DELETE FROM users WHERE id IN (1007, 1008, 1009);

-- Insert Company Users (Using high IDs to avoid conflicts with existing users)
INSERT IGNORE INTO users (id, username, password, email, full_name, role, is_active) VALUES
(1007, 'company1@techcorp.com', 'pass123', 'company1@techcorp.com', 'TechCorp Solutions', 'COMPANY', TRUE),
(1008, 'company2@innovate.com', 'pass123', 'company2@innovate.com', 'Innovate Labs', 'COMPANY', TRUE),
(1009, 'company3@dataflow.com', 'pass123', 'company3@dataflow.com', 'DataFlow Systems', 'COMPANY', TRUE);

-- Insert Sample Jobs
INSERT IGNORE INTO jobs (id, company_id, title, description, location, salary, experience_level, skills, job_type, status) VALUES
(1, 1007, 'Java Developer', 'We are looking for an experienced Java Developer to join our backend team. You will design, implement, and maintain high-performance Java applications using Spring Boot and microservices architecture.', 'Bangalore', '12-18 LPA', 'MID', 'Java, Spring Boot, Microservices, REST API, MySQL, Docker', 'FULL_TIME', 'ACTIVE'),
(2, 1007, 'React Developer', 'Seeking a talented React Developer to build modern, responsive web applications. Strong understanding of React ecosystem including Redux, React Router, and hooks is required.', 'Hyderabad', '10-15 LPA', 'JUNIOR', 'React, JavaScript, Redux, HTML, CSS, TypeScript', 'FULL_TIME', 'ACTIVE'),
(3, 1008, 'Full Stack Developer', 'Join our innovative team as a Full Stack Developer. Work on cutting-edge projects using modern technologies across the entire stack.', 'Remote', '15-22 LPA', 'SENIOR', 'Java, Spring Boot, React, Node.js, MongoDB, AWS', 'REMOTE', 'ACTIVE'),
(4, 1008, 'Python Intern', 'Exciting internship opportunity for aspiring Python developers. Learn and grow with our experienced mentoring team while working on real-world projects.', 'Delhi', '15000/month', 'FRESHER', 'Python, Django, SQL, Git', 'INTERNSHIP', 'ACTIVE'),
(5, 1009, 'DevOps Engineer', 'Looking for a DevOps Engineer to automate and streamline our operations and processes. Experience with CI/CD pipelines and cloud infrastructure is essential.', 'Pune', '18-25 LPA', 'SENIOR', 'AWS, Docker, Kubernetes, Jenkins, Terraform, Linux', 'FULL_TIME', 'ACTIVE'),
(6, 1009, 'Data Analyst', 'We need a skilled Data Analyst to transform data into actionable insights. Strong analytical skills and experience with data visualization tools required.', 'Bangalore', '8-12 LPA', 'JUNIOR', 'Python, SQL, Tableau, Power BI, Excel, Statistics', 'FULL_TIME', 'ACTIVE'),
(7, 1007, 'Frontend Developer', 'Join our UI/UX team as a Frontend Developer. Build beautiful, responsive interfaces using modern web technologies.', 'Mumbai', '8-14 LPA', 'MID', 'HTML, CSS, JavaScript, React, Vue.js, Figma', 'FULL_TIME', 'ACTIVE'),
(8, 1008, 'Cloud Architect', 'Seeking an experienced Cloud Architect to design and oversee cloud computing strategies including cloud adoption plans, application design, and management.', 'Bangalore', '25-35 LPA', 'LEAD', 'AWS, Azure, GCP, Microservices, Docker, Kubernetes, Terraform', 'FULL_TIME', 'ACTIVE');

-- Insert Sample Job Applications
INSERT IGNORE INTO job_applications (id, job_id, applicant_id, resume_score, score_suggestions, status, cover_letter) VALUES
(1, 1, 4, 82, 'SUGGESTIONS:\n- Add Spring Boot projects\n- Improve SQL knowledge\n- Include microservices experience', 'APPLIED', 'I am excited to apply for the Java Developer position. With my strong foundation in Java and Spring Boot, I believe I would be a great fit for your team.'),
(2, 2, 5, 75, 'SUGGESTIONS:\n- Add more React projects\n- Include TypeScript experience\n- Show Redux implementation', 'SHORTLISTED', 'I am passionate about frontend development and have been working with React for over a year.'),
(3, 3, 6, 68, 'SUGGESTIONS:\n- Add full stack project experience\n- Include cloud deployment experience\n- Show API design skills', 'APPLIED', 'I am a versatile developer with experience across multiple technologies.');
