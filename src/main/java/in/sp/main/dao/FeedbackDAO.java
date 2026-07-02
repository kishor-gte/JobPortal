package in.sp.main.dao;

import in.sp.main.Entities.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class FeedbackDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Feedback> feedbackRowMapper = new RowMapper<Feedback>() {
        @Override
        public Feedback mapRow(ResultSet rs, int rowNum) throws SQLException {
            Feedback f = new Feedback();
            f.setId(rs.getLong("id"));
            f.setInterviewId(rs.getLong("interview_id"));
            f.setInterviewerId(rs.getLong("interviewer_id"));
            f.setStudentId(rs.getLong("student_id"));
            f.setTechnicalRating(rs.getInt("technical_rating"));
            f.setCommunicationRating(rs.getInt("communication_rating"));
            f.setProblemSolvingRating(rs.getInt("problem_solving_rating"));
            f.setOverallRating(rs.getInt("overall_rating"));
            f.setComments(rs.getString("comments"));
            f.setRecommendation(rs.getString("recommendation"));
            f.setCreatedAt(rs.getTimestamp("created_at"));
            try {
                f.setInterviewerName(rs.getString("interviewer_name"));
            } catch (SQLException e) {
            }
            try {
                f.setStudentName(rs.getString("student_name"));
            } catch (SQLException e) {
            }
            return f;
        }
    };

    public List<Feedback> findAll() {
        return jdbcTemplate.query(
                "SELECT f.*, c.name as interviewer_name, js.name as student_name " +
                        "FROM feedbacks f LEFT JOIN company c ON f.interviewer_id = c.id LEFT JOIN job_seeker js ON f.student_id = js.id "
                        +
                        "ORDER BY f.created_at DESC",
                feedbackRowMapper);
    }

    public List<Feedback> findByInterviewId(Long interviewId) {
        return jdbcTemplate.query(
                "SELECT f.*, c.name as interviewer_name, js.name as student_name " +
                        "FROM feedbacks f LEFT JOIN company c ON f.interviewer_id = c.id LEFT JOIN job_seeker js ON f.student_id = js.id "
                        +
                        "WHERE f.interview_id = ?",
                feedbackRowMapper, interviewId);
    }

    public List<Feedback> findByStudentId(Long studentId) {
        return jdbcTemplate.query(
                "SELECT f.*, c.name as interviewer_name, js.name as student_name " +
                        "FROM feedbacks f LEFT JOIN company c ON f.interviewer_id = c.id LEFT JOIN job_seeker js ON f.student_id = js.id "
                        +
                        "WHERE f.student_id = ?",
                feedbackRowMapper, studentId);
    }

    public int save(Feedback f) {
        return jdbcTemplate.update(
                "INSERT INTO feedbacks (interview_id, interviewer_id, student_id, technical_rating, communication_rating, problem_solving_rating, overall_rating, comments, recommendation) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                f.getInterviewId(), f.getInterviewerId(), f.getStudentId(),
                f.getTechnicalRating(), f.getCommunicationRating(), f.getProblemSolvingRating(),
                f.getOverallRating(), f.getComments(), f.getRecommendation());
    }

    public int delete(Long id) {
        return jdbcTemplate.update("DELETE FROM feedbacks WHERE id = ?", id);
    }
}
