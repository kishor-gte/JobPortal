package in.sp.main.dao;

import in.sp.main.Entities.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class PerformanceDAO {

    private static final Logger logger = LoggerFactory.getLogger(PerformanceDAO.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<PerformanceScore> performanceRowMapper = new RowMapper<PerformanceScore>() {
        @Override
        public PerformanceScore mapRow(ResultSet rs, int rowNum) throws SQLException {
            PerformanceScore ps = new PerformanceScore();
            ps.setId(rs.getLong("id"));
            ps.setStudentId(rs.getLong("student_id"));
            ps.setCategoryId(rs.getLong("category_id"));
            ps.setTotalQuestions(rs.getInt("total_questions"));
            ps.setCorrectAnswers(rs.getInt("correct_answers"));
            ps.setAvgScore(rs.getDouble("avg_score"));
            ps.setCodingScore(rs.getDouble("coding_score"));
            ps.setInterviewScore(rs.getDouble("interview_score"));
            ps.setOverallScore(rs.getDouble("overall_score"));
            ps.setLastUpdated(rs.getTimestamp("last_updated"));
            try {
                ps.setStudentName(rs.getString("student_name"));
            } catch (SQLException e) {
            }
            try {
                ps.setCategoryName(rs.getString("category_name"));
            } catch (SQLException e) {
            }
            return ps;
        }
    };

    private final RowMapper<ProgressTracking> progressRowMapper = new RowMapper<ProgressTracking>() {
        @Override
        public ProgressTracking mapRow(ResultSet rs, int rowNum) throws SQLException {
            ProgressTracking pt = new ProgressTracking();
            pt.setId(rs.getLong("id"));
            pt.setStudentId(rs.getLong("student_id"));
            pt.setDate(rs.getDate("date"));
            pt.setQuestionsAttempted(rs.getInt("questions_attempted"));
            pt.setQuestionsCorrect(rs.getInt("questions_correct"));
            pt.setTimeSpentMinutes(rs.getInt("time_spent_minutes"));
            pt.setScore(rs.getDouble("score"));
            return pt;
        }
    };

    private final RowMapper<StudentAnswer> answerRowMapper = new RowMapper<StudentAnswer>() {
        @Override
        public StudentAnswer mapRow(ResultSet rs, int rowNum) throws SQLException {
            StudentAnswer sa = new StudentAnswer();
            sa.setId(rs.getLong("id"));
            sa.setStudentId(rs.getLong("student_id"));
            sa.setQuestionId(rs.getLong("question_id"));
            sa.setQuestionType(rs.getString("question_type"));
            sa.setAnswer(rs.getString("answer"));
            sa.setIsCorrect(rs.getBoolean("is_correct"));
            sa.setScore(rs.getInt("score"));
            sa.setTimeTaken(rs.getInt("time_taken"));
            sa.setSubmittedAt(rs.getTimestamp("submitted_at"));
            try { sa.setStudentName(rs.getString("student_name")); } catch(SQLException e) {}
            try { sa.setQuestionText(rs.getString("question_text")); } catch(SQLException e) {}
            return sa;
        }
    };

    // Performance Scores
    public List<PerformanceScore> findByStudentId(Long studentId) {
        return jdbcTemplate.query(
                "SELECT ps.*, js.name as student_name, c.name as category_name " +
                        "FROM performance_scores ps " +
                        "LEFT JOIN job_seeker js ON ps.student_id = js.id " +
                        "LEFT JOIN categories c ON ps.category_id = c.id " +
                        "WHERE ps.student_id = ?",
                performanceRowMapper, studentId);
    }

    public List<PerformanceScore> findAllPerformances() {
        return jdbcTemplate.query(
                "SELECT ps.*, js.name as student_name, c.name as category_name " +
                        "FROM performance_scores ps " +
                        "LEFT JOIN job_seeker js ON ps.student_id = js.id " +
                        "LEFT JOIN categories c ON ps.category_id = c.id " +
                        "ORDER BY ps.overall_score DESC",
                performanceRowMapper);
    }

    // Progress Tracking
    public List<ProgressTracking> findProgressByStudentId(Long studentId) {
        return jdbcTemplate.query(
                "SELECT * FROM progress_tracking WHERE student_id = ? ORDER BY date DESC LIMIT 30",
                progressRowMapper, studentId);
    }

    public int saveProgress(ProgressTracking pt) {
        return jdbcTemplate.update(
                "INSERT INTO progress_tracking (student_id, date, questions_attempted, questions_correct, time_spent_minutes, score) VALUES (?, ?, ?, ?, ?, ?)",
                pt.getStudentId(), pt.getDate(), pt.getQuestionsAttempted(), pt.getQuestionsCorrect(),
                pt.getTimeSpentMinutes(), pt.getScore());
    }

    /**
     * Updates today's daily progress for a student. If no record exists for today,
     * inserts a new one. Otherwise, increments the counts and recalculates the score.
     */
    public void updateDailyProgress(Long studentId, boolean isCorrect, int timeTaken) {
        try {
            java.sql.Date today = new java.sql.Date(System.currentTimeMillis());

            // Check if a record for today already exists
            Integer existing = jdbcTemplate.queryForObject(
                    "SELECT COUNT(*) FROM progress_tracking WHERE student_id = ? AND date = ?",
                    Integer.class, studentId, today);

            if (existing != null && existing > 0) {
                // Update existing record: increment counts and recalculate score
                if (isCorrect) {
                    jdbcTemplate.update(
                            "UPDATE progress_tracking SET questions_attempted = questions_attempted + 1, " +
                                    "questions_correct = questions_correct + 1, " +
                                    "time_spent_minutes = time_spent_minutes + ?, " +
                                    "score = ROUND((questions_correct + 1) * 100.0 / (questions_attempted + 1), 2) " +
                                    "WHERE student_id = ? AND date = ?",
                            timeTaken, studentId, today);
                } else {
                    jdbcTemplate.update(
                            "UPDATE progress_tracking SET questions_attempted = questions_attempted + 1, " +
                                    "time_spent_minutes = time_spent_minutes + ?, " +
                                    "score = ROUND(questions_correct * 100.0 / (questions_attempted + 1), 2) " +
                                    "WHERE student_id = ? AND date = ?",
                            timeTaken, studentId, today);
                }
            } else {
                // Insert new record for today
                double score = isCorrect ? 100.0 : 0.0;
                int correct = isCorrect ? 1 : 0;
                jdbcTemplate.update(
                        "INSERT INTO progress_tracking (student_id, date, questions_attempted, questions_correct, time_spent_minutes, score) " +
                                "VALUES (?, ?, 1, ?, ?, ?)",
                        studentId, today, correct, timeTaken, score);
            }
        } catch (Exception e) {
            logger.error("Error updating daily progress for student {}", studentId, e);
        }
    }

    // Student Answers
    public int saveAnswer(StudentAnswer sa) {
        try {
            return jdbcTemplate.update(
                    "INSERT INTO student_answers (student_id, question_id, question_type, answer, is_correct, score, time_taken) VALUES (?, ?, ?, ?, ?, ?, ?)",
                    sa.getStudentId(), sa.getQuestionId(), sa.getQuestionType(), sa.getAnswer(), sa.getIsCorrect(),
                    sa.getScore(), sa.getTimeTaken());
        } catch (Exception e) {
            logger.error("Error saving quiz result for student {}", sa.getStudentId(), e);
            return 0;
        }
    }

    public List<StudentAnswer> findAnswersByStudentId(Long studentId) {
        return jdbcTemplate.query(
                "SELECT * FROM student_answers WHERE student_id = ? ORDER BY submitted_at DESC",
                answerRowMapper, studentId);
    }
    
    public List<StudentAnswer> findAllStudentAnswers() {
        return jdbcTemplate.query(
                "SELECT sa.*, js.name as student_name, " +
                "COALESCE(iq.question, cq.title) as question_text " +
                "FROM student_answers sa " +
                "LEFT JOIN job_seeker js ON sa.student_id = js.id " +
                "LEFT JOIN interview_questions iq ON sa.question_id = iq.id AND sa.question_type = 'INTERVIEW' " +
                "LEFT JOIN coding_questions cq ON sa.question_id = cq.id AND sa.question_type = 'CODING' " +
                "ORDER BY sa.submitted_at DESC",
                answerRowMapper);
    }

    /**
     * Returns the most recent saved answer for a given student and coding question.
     * Returns null if no answer has been submitted yet.
     */
    public StudentAnswer findAnswerByStudentAndQuestion(Long studentId, Long questionId) {
        try {
            List<StudentAnswer> results = jdbcTemplate.query(
                    "SELECT * FROM student_answers WHERE student_id = ? AND question_id = ? " +
                    "AND question_type = 'CODING' ORDER BY submitted_at DESC LIMIT 1",
                    answerRowMapper, studentId, questionId);
            return results.isEmpty() ? null : results.get(0);
        } catch (Exception e) {
            logger.error("Error fetching answer for student {} question {}", studentId, questionId, e);
            return null;
        }
    }


    public int countAnswersByStudent(Long studentId) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM student_answers WHERE student_id = ?", Integer.class, studentId);
        return count != null ? count : 0;
    }

    public int countCorrectAnswersByStudent(Long studentId) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM student_answers WHERE student_id = ? AND is_correct = TRUE", Integer.class,
                studentId);
        return count != null ? count : 0;
    }

    /**
     * Returns the number of distinct coding questions that a student has solved
     * (i.e., submitted at least one correct answer for).
     */
    public int countSolvedCodingQuestionsByStudent(Long studentId) {
        try {
            Integer count = jdbcTemplate.queryForObject(
                    "SELECT COUNT(DISTINCT question_id) FROM student_answers " +
                    "WHERE student_id = ? AND question_type = 'CODING' AND is_correct = TRUE",
                    Integer.class, studentId);
            return count != null ? count : 0;
        } catch (Exception e) {
            logger.error("Error counting solved coding questions for student {}", studentId, e);
            return 0;
        }
    }

    // Update or create performance score
    public void updatePerformanceScore(Long studentId, Long categoryId) {
        // calculate from student_answers
        try {
            Integer total = jdbcTemplate.queryForObject(
                    "SELECT COUNT(*) FROM student_answers WHERE student_id = ?", Integer.class, studentId);
            Integer correct = jdbcTemplate.queryForObject(
                    "SELECT COUNT(*) FROM student_answers WHERE student_id = ? AND is_correct = TRUE", Integer.class,
                    studentId);
            double avg = (total != null && total > 0) ? ((correct != null ? correct : 0) * 100.0 / total) : 0;

            // Check if record exists
            Integer existing = jdbcTemplate.queryForObject(
                    "SELECT COUNT(*) FROM performance_scores WHERE student_id = ? AND (category_id = ? OR (category_id IS NULL AND ? IS NULL))",
                    Integer.class, studentId, categoryId, categoryId);

            if (existing != null && existing > 0) {
                jdbcTemplate.update(
                        "UPDATE performance_scores SET total_questions=?, correct_answers=?, avg_score=?, overall_score=? WHERE student_id=? AND (category_id=? OR (category_id IS NULL AND ? IS NULL))",
                        total, correct, avg, avg, studentId, categoryId, categoryId);
            } else {
                jdbcTemplate.update(
                        "INSERT INTO performance_scores (student_id, category_id, total_questions, correct_answers, avg_score, overall_score) VALUES (?, ?, ?, ?, ?, ?)",
                        studentId, categoryId, total, correct, avg, avg);
            }
        } catch (Exception e) {
            logger.error("Error updating performance score for student {} category {}", studentId, categoryId, e);
        }
    }
}
