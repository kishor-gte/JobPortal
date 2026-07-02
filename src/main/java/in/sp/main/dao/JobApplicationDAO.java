package in.sp.main.dao;

import in.sp.main.Entities.*;
import in.sp.main.Entities.JobApplication;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class JobApplicationDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<JobApplication> applicationRowMapper = new RowMapper<JobApplication>() {
        @Override
        public JobApplication mapRow(ResultSet rs, int rowNum) throws SQLException {
            JobApplication app = new JobApplication();
            app.setId(rs.getLong("id"));
            app.setJobId(rs.getLong("job_id"));
            app.setApplicantId(rs.getLong("applicant_id"));
            app.setResumePath(rs.getString("resume_path"));
            app.setResumeFileName(rs.getString("resume_file_name"));
            app.setResumeScore(rs.getInt("resume_score"));
            app.setScoreSuggestions(rs.getString("score_suggestions"));
            app.setStatus(rs.getString("status"));
            app.setCoverLetter(rs.getString("cover_letter"));
            try {
                app.setAptitudeLink(rs.getString("aptitude_link"));
            } catch (SQLException e) {}
            try {
                app.setCodingLink(rs.getString("coding_link"));
            } catch (SQLException e) {}
            try {
                app.setHrLink(rs.getString("hr_link"));
            } catch (SQLException e) {}
            app.setAppliedAt(rs.getTimestamp("applied_at"));
            app.setUpdatedAt(rs.getTimestamp("updated_at"));
            try {
                app.setApplicantName(rs.getString("applicant_name"));
            } catch (SQLException e) {
            }
            try {
                app.setApplicantEmail(rs.getString("applicant_email"));
            } catch (SQLException e) {
            }
            try {
                app.setJobTitle(rs.getString("job_title"));
            } catch (SQLException e) {
            }
            try {
                app.setCompanyName(rs.getString("company_name"));
            } catch (SQLException e) {
            }
            return app;
        }
    };

    public List<JobApplication> findByJobId(Long jobId) {
        return jdbcTemplate.query(
                "SELECT ja.*, js.name as applicant_name, js.email as applicant_email, " +
                "j.title as job_title, c.name as company_name " +
                "FROM job_applications ja " +
                "LEFT JOIN job_seeker js ON ja.applicant_id = js.id " +
                "LEFT JOIN jobs j ON ja.job_id = j.id " +
                "LEFT JOIN company c ON j.company_id = c.id " +
                "WHERE ja.job_id = ? ORDER BY ja.applied_at DESC",
                applicationRowMapper, jobId);
    }

    public List<JobApplication> findByApplicantId(Long applicantId) {
        return jdbcTemplate.query(
                "SELECT ja.*, js.name as applicant_name, js.email as applicant_email, " +
                "j.title as job_title, c.name as company_name " +
                "FROM job_applications ja " +
                "LEFT JOIN job_seeker js ON ja.applicant_id = js.id " +
                "LEFT JOIN jobs j ON ja.job_id = j.id " +
                "LEFT JOIN company c ON j.company_id = c.id " +
                "WHERE ja.applicant_id = ? ORDER BY ja.applied_at DESC",
                applicationRowMapper, applicantId);
    }

    public List<JobApplication> findByCompanyId(Long companyId) {
        return jdbcTemplate.query(
                "SELECT ja.*, js.name as applicant_name, js.email as applicant_email, " +
                "j.title as job_title, c.name as company_name " +
                "FROM job_applications ja " +
                "LEFT JOIN job_seeker js ON ja.applicant_id = js.id " +
                "LEFT JOIN jobs j ON ja.job_id = j.id " +
                "LEFT JOIN company c ON j.company_id = c.id " +
                "WHERE j.company_id = ? ORDER BY ja.applied_at DESC",
                applicationRowMapper, companyId);
    }

    public JobApplication findById(Long id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT ja.*, js.name as applicant_name, js.email as applicant_email, " +
                    "j.title as job_title, c.name as company_name " +
                    "FROM job_applications ja " +
                    "LEFT JOIN job_seeker js ON ja.applicant_id = js.id " +
                    "LEFT JOIN jobs j ON ja.job_id = j.id " +
                    "LEFT JOIN company c ON j.company_id = c.id " +
                    "WHERE ja.id = ?",
                    applicationRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public boolean hasApplied(Long jobId, Long applicantId) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM job_applications WHERE job_id = ? AND applicant_id = ?",
                Integer.class, jobId, applicantId);
        return count != null && count > 0;
    }

    public int save(JobApplication app) {
        return jdbcTemplate.update(
                "INSERT INTO job_applications (job_id, applicant_id, resume_path, resume_file_name, " +
                "resume_score, score_suggestions, status, cover_letter) VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
                app.getJobId(), app.getApplicantId(), app.getResumePath(), app.getResumeFileName(),
                app.getResumeScore(), app.getScoreSuggestions(),
                app.getStatus() != null ? app.getStatus() : "APPLIED",
                app.getCoverLetter());
    }

    public int updateStatus(Long id, String status) {
        return jdbcTemplate.update(
                "UPDATE job_applications SET status = ? WHERE id = ?", status, id);
    }

    public int scheduleInterview(Long id, String aptitudeLink, String codingLink, String hrLink) {
        return jdbcTemplate.update(
                "UPDATE job_applications SET aptitude_link = ?, coding_link = ?, hr_link = ? WHERE id = ?",
                aptitudeLink.isEmpty() ? null : aptitudeLink, 
                codingLink.isEmpty() ? null : codingLink, 
                hrLink.isEmpty() ? null : hrLink, 
                id);
    }

    public int updateResumeScore(Long id, int score, String suggestions) {
        return jdbcTemplate.update(
                "UPDATE job_applications SET resume_score = ?, score_suggestions = ? WHERE id = ?",
                score, suggestions, id);
    }

    public int countByJobId(Long jobId) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM job_applications WHERE job_id = ?", Integer.class, jobId);
        return count != null ? count : 0;
    }

    public int countByCompanyId(Long companyId) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM job_applications ja " +
                "JOIN jobs j ON ja.job_id = j.id WHERE j.company_id = ?",
                Integer.class, companyId);
        return count != null ? count : 0;
    }

    public int countByStatusAndCompanyId(String status, Long companyId) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM job_applications ja " +
                "JOIN jobs j ON ja.job_id = j.id WHERE ja.status = ? AND j.company_id = ?",
                Integer.class, status, companyId);
        return count != null ? count : 0;
    }

    public int delete(Long id) {
        return jdbcTemplate.update("DELETE FROM job_applications WHERE id = ?", id);
    }

    public List<JobApplication> findAll() {
        return jdbcTemplate.query(
                "SELECT ja.*, js.name as applicant_name, js.email as applicant_email, " +
                "j.title as job_title, c.name as company_name " +
                "FROM job_applications ja " +
                "LEFT JOIN job_seeker js ON ja.applicant_id = js.id " +
                "LEFT JOIN jobs j ON ja.job_id = j.id " +
                "LEFT JOIN company c ON j.company_id = c.id " +
                "ORDER BY ja.applied_at DESC",
                applicationRowMapper);
    }

    public int countAll() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM job_applications", Integer.class);
        return count != null ? count : 0;
    }
}
