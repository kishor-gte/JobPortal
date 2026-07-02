package in.sp.main.dao;

import in.sp.main.Entities.Job;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class JobDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Job> jobRowMapper = new RowMapper<Job>() {
        @Override
        public Job mapRow(ResultSet rs, int rowNum) throws SQLException {
            Job job = new Job();
            job.setId(rs.getLong("id"));
            job.setCompanyId(rs.getLong("company_id"));
            job.setTitle(rs.getString("title"));
            job.setDescription(rs.getString("description"));
            job.setSalary(rs.getString("salary"));
            job.setExperienceLevel(rs.getString("experience_level"));
            job.setSkills(rs.getString("skills"));
            job.setJobType(rs.getString("job_type"));
            job.setStatus(rs.getString("status"));
            job.setCreatedAt(rs.getTimestamp("created_at"));
            job.setUpdatedAt(rs.getTimestamp("updated_at"));
            try {
                job.setCompanyName(rs.getString("company_name"));
            } catch (SQLException e) {
            }
            try {
                job.setApplicantCount(rs.getInt("applicant_count"));
            } catch (SQLException e) {
            }
            return job;
        }
    };

    public List<Job> findAll() {
        return jdbcTemplate.query(
                "SELECT j.*, c.name as company_name, " +
                "(SELECT COUNT(*) FROM job_applications WHERE job_id = j.id) as applicant_count " +
                "FROM jobs j LEFT JOIN company c ON j.company_id = c.id " +
                "WHERE j.status = 'ACTIVE' ORDER BY j.created_at DESC",
                jobRowMapper);
    }

    public List<Job> findAllIncludingInactive() {
        return jdbcTemplate.query(
                "SELECT j.*, c.name as company_name, " +
                "(SELECT COUNT(*) FROM job_applications WHERE job_id = j.id) as applicant_count " +
                "FROM jobs j LEFT JOIN company c ON j.company_id = c.id ORDER BY j.created_at DESC",
                jobRowMapper);
    }

    public List<Job> findByCompanyId(Long companyId) {
        return jdbcTemplate.query(
                "SELECT j.*, c.name as company_name, " +
                "(SELECT COUNT(*) FROM job_applications WHERE job_id = j.id) as applicant_count " +
                "FROM jobs j LEFT JOIN company c ON j.company_id = c.id " +
                "WHERE j.company_id = ? ORDER BY j.created_at DESC",
                jobRowMapper, companyId);
    }

    public Job findById(Long id) {
        try {
            return jdbcTemplate.queryForObject(
                    "SELECT j.*, c.name as company_name, " +
                    "(SELECT COUNT(*) FROM job_applications WHERE job_id = j.id) as applicant_count " +
                    "FROM jobs j LEFT JOIN company c ON j.company_id = c.id WHERE j.id = ?",
                    jobRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public List<Job> search(String keyword, String location, String experienceLevel, String skills) {
        StringBuilder sql = new StringBuilder(
                "SELECT j.*, c.name as company_name, " +
                "(SELECT COUNT(*) FROM job_applications WHERE job_id = j.id) as applicant_count " +
                "FROM jobs j LEFT JOIN company c ON j.company_id = c.id WHERE j.status = 'ACTIVE'");

        java.util.List<Object> params = new java.util.ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (j.title LIKE ? OR j.description LIKE ? OR c.name LIKE ?)");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
            params.add(like);
        }
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND j.location LIKE ?");
            params.add("%" + location.trim() + "%");
        }
        if (experienceLevel != null && !experienceLevel.trim().isEmpty()) {
            sql.append(" AND j.experience_level = ?");
            params.add(experienceLevel.trim());
        }
        if (skills != null && !skills.trim().isEmpty()) {
            sql.append(" AND j.skills LIKE ?");
            params.add("%" + skills.trim() + "%");
        }

        sql.append(" ORDER BY j.created_at DESC");
        return jdbcTemplate.query(sql.toString(), jobRowMapper, params.toArray());
    }

    public int save(Job job) {
        return jdbcTemplate.update(
                "INSERT INTO jobs (company_id, title, description, location, salary, experience_level, skills, job_type, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                job.getCompanyId(), job.getTitle(), job.getDescription(), job.getLocation(),
                job.getSalary(), job.getExperienceLevel(), job.getSkills(), job.getJobType(),
                job.getStatus() != null ? job.getStatus() : "ACTIVE");
    }

    public int update(Job job) {
        return jdbcTemplate.update(
                "UPDATE jobs SET title = ?, description = ?, location = ?, salary = ?, " +
                "experience_level = ?, skills = ?, job_type = ?, status = ? WHERE id = ? AND company_id = ?",
                job.getTitle(), job.getDescription(), job.getLocation(), job.getSalary(),
                job.getExperienceLevel(), job.getSkills(), job.getJobType(), job.getStatus(),
                job.getId(), job.getCompanyId());
    }

    public int updateStatus(Long id, String status, Long companyId) {
        return jdbcTemplate.update("UPDATE jobs SET status = ? WHERE id = ? AND company_id = ?",
                status, id, companyId);
    }

    public int delete(Long id, Long companyId) {
        jdbcTemplate.update("DELETE FROM job_applications WHERE job_id = ?", id);
        return jdbcTemplate.update("DELETE FROM jobs WHERE id = ? AND company_id = ?", id, companyId);
    }

    public int countByCompanyId(Long companyId) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM jobs WHERE company_id = ?", Integer.class, companyId);
        return count != null ? count : 0;
    }

    public int countActiveByCompanyId(Long companyId) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM jobs WHERE company_id = ? AND status = 'ACTIVE'", Integer.class, companyId);
        return count != null ? count : 0;
    }

    public int countAll() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM jobs", Integer.class);
        return count != null ? count : 0;
    }
}
