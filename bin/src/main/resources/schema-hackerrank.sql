-- Create categories table
CREATE TABLE IF NOT EXISTS categories (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    color VARCHAR(20),
    icon VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create coding_questions table
CREATE TABLE IF NOT EXISTS coding_questions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    difficulty VARCHAR(20),
    category_id BIGINT,
    sample_input TEXT,
    sample_output TEXT,
    solution TEXT,
    constraints_info TEXT,
    created_by BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Create interview_questions table
CREATE TABLE IF NOT EXISTS interview_questions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    question TEXT NOT NULL,
    category_id BIGINT,
    difficulty VARCHAR(20),
    expected_answer TEXT,
    question_type VARCHAR(50),
    created_by BIGINT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Insert default categories
INSERT INTO categories (name, description, color) VALUES
('Java', 'Java programming questions', '#007396'),
('Python', 'Python programming questions', '#3776AB'),
('JavaScript', 'JavaScript programming questions', '#F7DF1E'),
('Data Structures', 'Data structures concepts', '#FF6B6B'),
('Algorithms', 'Algorithm problems', '#4ECDC4'),
('SQL', 'SQL and database questions', '#336791');
