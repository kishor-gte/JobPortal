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
public class InterviewDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<MockInterview> interviewRowMapper = new RowMapper<MockInterview>() {
        @Override
        public MockInterview mapRow(ResultSet rs, int rowNum) throws SQLException {
            MockInterview mi = new MockInterview();
            mi.setId(rs.getLong("id"));
            mi.setStudentId(rs.getLong("student_id"));
            mi.setInterviewerId(rs.getLong("interviewer_id"));
            mi.setScheduledAt(rs.getString("scheduled_at"));
            mi.setDurationMinutes(rs.getInt("duration_minutes"));
            mi.setStatus(rs.getString("status"));
            mi.setMeetingLink(rs.getString("meeting_link"));
            mi.setNotes(rs.getString("notes"));
            mi.setCreatedAt(rs.getTimestamp("created_at"));
            mi.setFeedback(rs.getString("feedback"));
            mi.setScore((Integer) rs.getObject("score"));
            mi.setTechnicalScore((Integer) rs.getObject("technical_score"));
            mi.setCommunicationScore((Integer) rs.getObject("communication_score"));
            mi.setConfidenceScore((Integer) rs.getObject("confidence_score"));
            mi.setAiAnalysis(rs.getString("ai_analysis"));
            try {
                mi.setStudentName(rs.getString("student_name"));
            } catch (SQLException e) {
            }
            try {
                mi.setInterviewerName(rs.getString("interviewer_name"));
            } catch (SQLException e) {
            }
            return mi;
        }
    };

    public List<MockInterview> findAll() {
        return jdbcTemplate.query(
                "SELECT mi.*, s.name as student_name, i.name as interviewer_name " +
                        "FROM mock_interviews mi " +
                        "LEFT JOIN job_seeker s ON mi.student_id = s.id " +
                        "LEFT JOIN company i ON mi.interviewer_id = i.id " +
                        "ORDER BY mi.scheduled_at DESC",
                interviewRowMapper);
    }

    public List<MockInterview> findByStudentId(Long studentId) {
        return jdbcTemplate.query(
                "SELECT mi.*, s.name as student_name, i.name as interviewer_name " +
                        "FROM mock_interviews mi " +
                        "LEFT JOIN job_seeker s ON mi.student_id = s.id " +
                        "LEFT JOIN company i ON mi.interviewer_id = i.id " +
                        "WHERE mi.student_id = ? ORDER BY mi.scheduled_at DESC",
                interviewRowMapper, studentId);
    }

    public List<MockInterview> findByInterviewerId(Long interviewerId) {
        return jdbcTemplate.query(
                "SELECT mi.*, s.name as student_name, i.name as interviewer_name " +
                        "FROM mock_interviews mi " +
                        "LEFT JOIN job_seeker s ON mi.student_id = s.id " +
                        "LEFT JOIN company i ON mi.interviewer_id = i.id " +
                        "WHERE mi.interviewer_id = ? ORDER BY mi.scheduled_at DESC",
                interviewRowMapper, interviewerId);
    }

    public MockInterview findById(Long id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT mi.*, s.name as student_name, i.name as interviewer_name " +
                            "FROM mock_interviews mi " +
                            "LEFT JOIN job_seeker s ON mi.student_id = s.id " +
                            "LEFT JOIN company i ON mi.interviewer_id = i.id " +
                            "WHERE mi.id = ?",
                    interviewRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public int save(MockInterview mi) {
        return jdbcTemplate.update(
                "INSERT INTO mock_interviews (student_id, interviewer_id, scheduled_at, duration_minutes, status, meeting_link, notes) VALUES (?, ?, ?, ?, ?, ?, ?)",
                mi.getStudentId(), mi.getInterviewerId(), mi.getScheduledAt(),
                mi.getDurationMinutes(), mi.getStatus(), mi.getMeetingLink(), mi.getNotes());
    }

    public int updateStatus(Long id, String status) {
        return jdbcTemplate.update("UPDATE mock_interviews SET status = ? WHERE id = ?", status, id);
    }

    public int update(MockInterview mi) {
        return jdbcTemplate.update(
                "UPDATE mock_interviews SET scheduled_at=?, duration_minutes=?, status=?, meeting_link=?, notes=? WHERE id=?",
                mi.getScheduledAt(), mi.getDurationMinutes(), mi.getStatus(), mi.getMeetingLink(), mi.getNotes(),
                mi.getId());
    }

    public int submitFeedback(Long id, String feedback, Integer score, Integer tech, Integer comm, Integer conf) {
        return jdbcTemplate.update(
                "UPDATE mock_interviews SET feedback = ?, score = ?, status = 'COMPLETED', technical_score = ?, communication_score = ?, confidence_score = ? WHERE id = ?",
                feedback, score, tech, comm, conf, id);
    }

    public int delete(Long id) {
        return jdbcTemplate.update("DELETE FROM mock_interviews WHERE id = ?", id);
    }

    public int countAll() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM mock_interviews", Integer.class);
        return count != null ? count : 0;
    }

    public int countByStatus(String status) {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM mock_interviews WHERE status = ?",
                Integer.class, status);
        return count != null ? count : 0;
    }
}
