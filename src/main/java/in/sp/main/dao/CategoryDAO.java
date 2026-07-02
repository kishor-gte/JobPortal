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
public class CategoryDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private final RowMapper<Category> categoryRowMapper = new RowMapper<Category>() {
        @Override
        public Category mapRow(ResultSet rs, int rowNum) throws SQLException {
            Category cat = new Category();
            cat.setId(rs.getLong("id"));
            cat.setName(rs.getString("name"));
            cat.setDescription(rs.getString("description"));
            cat.setIcon(rs.getString("icon"));
            cat.setColor(rs.getString("color"));
            cat.setCreatedAt(rs.getTimestamp("created_at"));
            return cat;
        }
    };

    public List<Category> findAll() {
        return jdbcTemplate.query("SELECT * FROM categories ORDER BY name", categoryRowMapper);
    }

    public Category findById(Long id) {
        try {
            return jdbcTemplate.queryForObject("SELECT * FROM categories WHERE id = ?", categoryRowMapper, id);
        } catch (Exception e) {
            return null;
        }
    }

    public int save(Category category) {
        return jdbcTemplate.update(
                "INSERT INTO categories (name, description, icon, color) VALUES (?, ?, ?, ?)",
                category.getName(), category.getDescription(), category.getIcon(), category.getColor());
    }

    public int update(Category category) {
        return jdbcTemplate.update(
                "UPDATE categories SET name = ?, description = ?, icon = ?, color = ? WHERE id = ?",
                category.getName(), category.getDescription(), category.getIcon(), category.getColor(),
                category.getId());
    }

    public int delete(Long id) {
        return jdbcTemplate.update("DELETE FROM categories WHERE id = ?", id);
    }

    public int countAll() {
        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM categories", Integer.class);
        return count != null ? count : 0;
    }
}
