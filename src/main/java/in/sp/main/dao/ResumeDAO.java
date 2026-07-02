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
public class ResumeDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Resume> resumeRowMapper = new RowMapper<Resume>() {
        @Override
        public Resume mapRow(ResultSet rs, int rowNum) throws SQLException {
            Resume r = new Resume();
            r.setId(rs.getLong("id"));
            r.setStudentId(rs.getLong("student_id"));
            r.setFileName(rs.getString("file_name"));
            r.setFilePath(rs.getString("file_path"));
            r.setFileSize(rs.getLong("file_size"));
            r.setAiFeedback(rs.getString("ai_feedback"));
            r.setAiScore(rs.getInt("ai_score"));
            r.setUploadedAt(rs.getTimestamp("uploaded_at"));
            try {
                r.setStudentName(rs.getString("student_name"));
            } catch (SQLException e) {
            }
            return r;
        }
    };

    public List<Resume> findByStudentId(Long studentId) {
        return jdbcTemplate.query(
                "SELECT r.*, js.name as student_name FROM resumes r LEFT JOIN job_seeker js ON r.student_id = js.id WHERE r.student_id = ? ORDER BY r.uploaded_at DESC",
                resumeRowMapper, studentId);
    }

    public List<Resume> findAll() {
        return jdbcTemplate.query(
                "SELECT r.*, js.name as student_name FROM resumes r LEFT JOIN job_seeker js ON r.student_id = js.id ORDER BY r.uploaded_at DESC",
                resumeRowMapper);
    }

    public Resume findById(Long id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT r.*, js.name as student_name FROM resumes r LEFT JOIN job_seeker js ON r.student_id = js.id WHERE r.id = ?",
                    resumeRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public int save(Resume resume) {
        return jdbcTemplate.update(
                "INSERT INTO resumes (student_id, file_name, file_path, file_size) VALUES (?, ?, ?, ?)",
                resume.getStudentId(), resume.getFileName(), resume.getFilePath(), resume.getFileSize());
    }

    public int updateAiFeedback(Long id, String feedback, int score) {
        return jdbcTemplate.update(
                "UPDATE resumes SET ai_feedback = ?, ai_score = ? WHERE id = ?",
                feedback, score, id);
    }

    public int delete(Long id) {
        return jdbcTemplate.update("DELETE FROM resumes WHERE id = ?", id);
    }
}
