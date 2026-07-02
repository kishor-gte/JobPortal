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
public class AIEvaluationDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<AIEvaluation> evaluationRowMapper = new RowMapper<AIEvaluation>() {
        @Override
        public AIEvaluation mapRow(ResultSet rs, int rowNum) throws SQLException {
            AIEvaluation ae = new AIEvaluation();
            ae.setId(rs.getLong("id"));
            ae.setStudentId(rs.getLong("student_id"));
            ae.setInterviewId(rs.getLong("interview_id"));
            ae.setAnswerAnalysis(rs.getString("answer_analysis"));
            ae.setCommunicationScore(rs.getDouble("communication_score"));
            ae.setTechnicalScore(rs.getDouble("technical_score"));
            ae.setConfidenceScore(rs.getDouble("confidence_score"));
            ae.setOverallScore(rs.getDouble("overall_score"));
            ae.setStrengths(rs.getString("strengths"));
            ae.setWeaknesses(rs.getString("weaknesses"));
            ae.setImprovementSuggestions(rs.getString("improvement_suggestions"));
            ae.setEvaluatedAt(rs.getTimestamp("evaluated_at"));
            try {
                ae.setStudentName(rs.getString("student_name"));
            } catch (SQLException e) {
            }
            return ae;
        }
    };

    public List<AIEvaluation> findAll() {
        return jdbcTemplate.query(
                "SELECT ae.*, js.name as student_name FROM ai_evaluations ae LEFT JOIN job_seeker js ON ae.student_id = js.id ORDER BY ae.evaluated_at DESC",
                evaluationRowMapper);
    }

    public List<AIEvaluation> findByStudentId(Long studentId) {
        return jdbcTemplate.query(
                "SELECT ae.*, js.name as student_name FROM ai_evaluations ae LEFT JOIN job_seeker js ON ae.student_id = js.id WHERE ae.student_id = ? ORDER BY ae.evaluated_at DESC",
                evaluationRowMapper, studentId);
    }

    public AIEvaluation findById(Long id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT ae.*, js.name as student_name FROM ai_evaluations ae LEFT JOIN job_seeker js ON ae.student_id = js.id WHERE ae.id = ?",
                    evaluationRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public int save(AIEvaluation ae) {
        return jdbcTemplate.update(
                "INSERT INTO ai_evaluations (student_id, interview_id, answer_analysis, communication_score, technical_score, confidence_score, overall_score, strengths, weaknesses, improvement_suggestions) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                ae.getStudentId(), ae.getInterviewId(), ae.getAnswerAnalysis(),
                ae.getCommunicationScore(), ae.getTechnicalScore(), ae.getConfidenceScore(), ae.getOverallScore(),
                ae.getStrengths(), ae.getWeaknesses(), ae.getImprovementSuggestions());
    }

    public int update(AIEvaluation ae) {
        return jdbcTemplate.update(
                "UPDATE ai_evaluations SET answer_analysis=?, communication_score=?, technical_score=?, confidence_score=?, overall_score=?, strengths=?, weaknesses=?, improvement_suggestions=? WHERE id=?",
                ae.getAnswerAnalysis(), ae.getCommunicationScore(), ae.getTechnicalScore(), ae.getConfidenceScore(),
                ae.getOverallScore(), ae.getStrengths(), ae.getWeaknesses(), ae.getImprovementSuggestions(),
                ae.getId());
    }

    public int delete(Long id) {
        return jdbcTemplate.update("DELETE FROM ai_evaluations WHERE id = ?", id);
    }
}
