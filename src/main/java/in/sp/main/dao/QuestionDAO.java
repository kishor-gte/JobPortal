package in.sp.main.dao;

import in.sp.main.Entities.*;
import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

@Repository
public class QuestionDAO {

    private static final Logger logger = LoggerFactory.getLogger(QuestionDAO.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    private boolean tablesInitialized = false;
    
    @PostConstruct
    public void init() {
        try {
            // Create tables if they don't exist
            jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS categories (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "name VARCHAR(100) NOT NULL," +
                "description VARCHAR(255)," +
                "color VARCHAR(20)," +
                "icon VARCHAR(50)," +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
            
            jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS coding_questions (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "title VARCHAR(255) NOT NULL," +
                "description TEXT," +
                "difficulty VARCHAR(20)," +
                "category_id BIGINT," +
                "sample_input TEXT," +
                "sample_output TEXT," +
                "solution TEXT," +
                "constraints_info TEXT," +
                "created_by BIGINT," +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
            
            jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS interview_questions (" +
                "id BIGINT AUTO_INCREMENT PRIMARY KEY," +
                "question TEXT NOT NULL," +
                "category_id BIGINT," +
                "difficulty VARCHAR(20)," +
                "expected_answer TEXT," +
                "question_type VARCHAR(50)," +
                "created_by BIGINT," +
                "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
            
            // Insert default categories
            jdbcTemplate.execute("INSERT IGNORE INTO categories (id, name, description, color) VALUES " +
                "(1, 'Java', 'Java programming questions', '#007396')," +
                "(2, 'Python', 'Python programming questions', '#3776AB')," +
                "(3, 'JavaScript', 'JavaScript programming questions', '#F7DF1E')," +
                "(4, 'Data Structures', 'Data structures concepts', '#FF6B6B')," +
                "(5, 'Algorithms', 'Algorithm problems', '#4ECDC4')," +
                "(6, 'SQL', 'SQL and database questions', '#336791')");
            
            tablesInitialized = true;
        } catch (Exception e) {
            logger.error("Could not initialize tables: {}", e.getMessage(), e);
        }
    }

    private final RowMapper<CodingQuestion> codingQuestionRowMapper = new RowMapper<CodingQuestion>() {
        @Override
        public CodingQuestion mapRow(ResultSet rs, int rowNum) throws SQLException {
            CodingQuestion q = new CodingQuestion();
            q.setId(rs.getLong("id"));
            q.setTitle(rs.getString("title"));
            q.setDescription(rs.getString("description"));
            q.setDifficulty(rs.getString("difficulty"));
            q.setCategoryId(rs.getLong("category_id"));
            q.setSampleInput(rs.getString("sample_input"));
            q.setSampleOutput(rs.getString("sample_output"));
            q.setSolution(rs.getString("solution"));
            q.setConstraintsInfo(rs.getString("constraints_info"));
            q.setCreatedBy(rs.getLong("created_by"));
            q.setCreatedAt(rs.getTimestamp("created_at"));
            try {
                q.setCategoryName(rs.getString("category_name"));
            } catch (SQLException e) {
                /* column not in result set */ }
            return q;
        }
    };

    private final RowMapper<InterviewQuestion> interviewQuestionRowMapper = new RowMapper<InterviewQuestion>() {
        @Override
        public InterviewQuestion mapRow(ResultSet rs, int rowNum) throws SQLException {
            InterviewQuestion q = new InterviewQuestion();
            q.setId(rs.getLong("id"));
            q.setQuestion(rs.getString("question"));
            q.setCategoryId(rs.getLong("category_id"));
            q.setDifficulty(rs.getString("difficulty"));
            q.setExpectedAnswer(rs.getString("expected_answer"));
            q.setQuestionType(rs.getString("question_type"));
            q.setCreatedBy(rs.getLong("created_by"));
            q.setCreatedAt(rs.getTimestamp("created_at"));
            try {
                q.setCategoryName(rs.getString("category_name"));
            } catch (SQLException e) {
                /* column not in result set */ }
            return q;
        }
    };

    // Coding Questions
    public List<CodingQuestion> findAllCodingQuestions() {
        try {
            return jdbcTemplate.query(
                    "SELECT cq.*, c.name as category_name FROM coding_questions cq LEFT JOIN categories c ON cq.category_id = c.id ORDER BY cq.created_at DESC",
                    codingQuestionRowMapper);
        } catch (Exception e) {
            logger.error("Error fetching coding questions: {}", e.getMessage(), e);
            return Collections.emptyList();
        }
    }

    public List<CodingQuestion> findCodingByCategory(Long categoryId) {
        return jdbcTemplate.query(
                "SELECT cq.*, c.name as category_name FROM coding_questions cq LEFT JOIN categories c ON cq.category_id = c.id WHERE cq.category_id = ? ORDER BY cq.difficulty",
                codingQuestionRowMapper, categoryId);
    }

    public List<CodingQuestion> findCodingByDifficulty(String difficulty) {
        return jdbcTemplate.query(
                "SELECT cq.*, c.name as category_name FROM coding_questions cq LEFT JOIN categories c ON cq.category_id = c.id WHERE cq.difficulty = ?",
                codingQuestionRowMapper, difficulty);
    }

    public CodingQuestion findCodingById(Long id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT cq.*, c.name as category_name FROM coding_questions cq LEFT JOIN categories c ON cq.category_id = c.id WHERE cq.id = ?",
                    codingQuestionRowMapper, id);
        } catch (Exception e) {
            logger.error("Error fetching coding question by id: {}", id, e);
            return null;
        }
    }

    public int saveCodingQuestion(CodingQuestion q) {
        try {
            return jdbcTemplate.update(
                    "INSERT INTO coding_questions (title, description, difficulty, category_id, sample_input, sample_output, solution, constraints_info, created_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                    q.getTitle(), q.getDescription(), q.getDifficulty(), q.getCategoryId(),
                    q.getSampleInput(), q.getSampleOutput(), q.getSolution(), q.getConstraintsInfo(), q.getCreatedBy());
        } catch (Exception e) {
            logger.error("Error saving coding question: {}", e.getMessage(), e);
            return 0;
        }
    }

    public int updateCodingQuestion(CodingQuestion q) {
        try {
            return jdbcTemplate.update(
                    "UPDATE coding_questions SET title=?, description=?, difficulty=?, category_id=?, sample_input=?, sample_output=?, solution=?, constraints_info=? WHERE id=?",
                    q.getTitle(), q.getDescription(), q.getDifficulty(), q.getCategoryId(),
                    q.getSampleInput(), q.getSampleOutput(), q.getSolution(), q.getConstraintsInfo(), q.getId());
        } catch (Exception e) {
            logger.error("Error updating coding question: {}", e.getMessage(), e);
            return 0;
        }
    }

    public int deleteCodingQuestion(Long id) {
        try {
            return jdbcTemplate.update("DELETE FROM coding_questions WHERE id = ?", id);
        } catch (Exception e) {
            logger.error("Error deleting coding question: {}", e.getMessage(), e);
            return 0;
        }
    }

    public int countCodingQuestions() {
        try {
            Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM coding_questions", Integer.class);
            return count != null ? count : 0;
        } catch (Exception e) {
            logger.error("Error counting coding questions: {}", e.getMessage(), e);
            return 0;
        }
    }

    // Interview Questions
    public List<InterviewQuestion> findAllInterviewQuestions() {
        try {
            return jdbcTemplate.query(
                    "SELECT iq.*, c.name as category_name FROM interview_questions iq LEFT JOIN categories c ON iq.category_id = c.id ORDER BY iq.created_at DESC",
                    interviewQuestionRowMapper);
        } catch (Exception e) {
            logger.error("Error fetching interview questions: {}", e.getMessage(), e);
            return Collections.emptyList();
        }
    }

    public List<InterviewQuestion> findInterviewByCategory(Long categoryId) {
        return jdbcTemplate.query(
                "SELECT iq.*, c.name as category_name FROM interview_questions iq LEFT JOIN categories c ON iq.category_id = c.id WHERE iq.category_id = ?",
                interviewQuestionRowMapper, categoryId);
    }

    public List<InterviewQuestion> findInterviewByType(String type) {
        return jdbcTemplate.query(
                "SELECT iq.*, c.name as category_name FROM interview_questions iq LEFT JOIN categories c ON iq.category_id = c.id WHERE iq.question_type = ?",
                interviewQuestionRowMapper, type);
    }

    public InterviewQuestion findInterviewById(Long id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT iq.*, c.name as category_name FROM interview_questions iq LEFT JOIN categories c ON iq.category_id = c.id WHERE iq.id = ?",
                    interviewQuestionRowMapper, id);
        } catch (Exception e) {
            logger.error("Error fetching interview question by id: {}", id, e);
            return null;
        }
    }

    public int saveInterviewQuestion(InterviewQuestion q) {
        try {
            return jdbcTemplate.update(
                    "INSERT INTO interview_questions (question, category_id, difficulty, expected_answer, question_type, created_by) VALUES (?, ?, ?, ?, ?, ?)",
                    q.getQuestion(), q.getCategoryId(), q.getDifficulty(), q.getExpectedAnswer(), q.getQuestionType(),
                    q.getCreatedBy());
        } catch (Exception e) {
            logger.error("Error saving interview question: {}", e.getMessage(), e);
            return 0;
        }
    }

    public int updateInterviewQuestion(InterviewQuestion q) {
        return jdbcTemplate.update(
                "UPDATE interview_questions SET question=?, category_id=?, difficulty=?, expected_answer=?, question_type=? WHERE id=?",
                q.getQuestion(), q.getCategoryId(), q.getDifficulty(), q.getExpectedAnswer(), q.getQuestionType(),
                q.getId());
    }

    public int deleteInterviewQuestion(Long id) {
        return jdbcTemplate.update("DELETE FROM interview_questions WHERE id = ?", id);
    }

    public int countInterviewQuestions() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM interview_questions", Integer.class);
        return count != null ? count : 0;
    }

    // Recommended questions for student (questions not yet attempted)
    public List<CodingQuestion> findRecommendedForStudent(Long studentId) {
        return jdbcTemplate.query(
                "SELECT cq.*, c.name as category_name FROM coding_questions cq LEFT JOIN categories c ON cq.category_id = c.id "
                        +
                        "WHERE cq.id NOT IN (SELECT question_id FROM student_answers WHERE student_id = ? AND question_type = 'CODING') "
                        +
                        "ORDER BY cq.difficulty LIMIT 10",
                codingQuestionRowMapper, studentId);
    }
}
