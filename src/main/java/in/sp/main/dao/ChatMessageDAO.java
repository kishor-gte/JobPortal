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
public class ChatMessageDAO {

    private static final Logger logger = LoggerFactory.getLogger(ChatMessageDAO.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @jakarta.annotation.PostConstruct
    public void init() {
        try {
            jdbcTemplate.execute("CREATE TABLE IF NOT EXISTS chat_messages (" +
                    "id BIGINT AUTO_INCREMENT PRIMARY KEY, " +
                    "sender_id BIGINT NOT NULL, " +
                    "sender_type VARCHAR(20) NOT NULL, " +
                    "receiver_id BIGINT NOT NULL, " +
                    "receiver_type VARCHAR(20) NOT NULL, " +
                    "content TEXT NOT NULL, " +
                    "timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "is_read BOOLEAN DEFAULT FALSE" +
                    ")");
            // Add columns if they don't exist (in case table was already there)
            try { jdbcTemplate.execute("ALTER TABLE chat_messages ADD COLUMN sender_type VARCHAR(20)"); } catch (Exception e) {}
            try { jdbcTemplate.execute("ALTER TABLE chat_messages ADD COLUMN receiver_type VARCHAR(20)"); } catch (Exception e) {}
        } catch (Exception e) {
            logger.error("Error creating chat_messages table: {}", e.getMessage(), e);
        }
    }

    private final RowMapper<ChatMessage> messageRowMapper = new RowMapper<ChatMessage>() {
        @Override
        public ChatMessage mapRow(ResultSet rs, int rowNum) throws SQLException {
            ChatMessage message = new ChatMessage();
            message.setId(rs.getLong("id"));
            message.setSenderId(rs.getLong("sender_id"));
            message.setSenderType(rs.getString("sender_type"));
            message.setReceiverId(rs.getLong("receiver_id"));
            message.setReceiverType(rs.getString("receiver_type"));
            message.setContent(rs.getString("content"));
            message.setTimestamp(rs.getTimestamp("timestamp"));
            message.setIsRead(rs.getBoolean("is_read"));
            
            // Populate virtual fields if present in query
            try { message.setSenderName(rs.getString("sender_name")); } catch (Exception e) {}
            try { message.setReceiverName(rs.getString("receiver_name")); } catch (Exception e) {}
            
            return message;
        }
    };

    public int save(ChatMessage message) {
        return jdbcTemplate.update(
                "INSERT INTO chat_messages (sender_id, sender_type, receiver_id, receiver_type, content) VALUES (?, ?, ?, ?, ?)",
                message.getSenderId(), message.getSenderType(), message.getReceiverId(), message.getReceiverType(), message.getContent());
    }

    public List<ChatMessage> getConversation(Long userId1, String type1, Long userId2, String type2) {
        String sql = "SELECT * FROM chat_messages " +
                     "WHERE (sender_id = ? AND sender_type = ? AND receiver_id = ? AND receiver_type = ?) " +
                     "OR (sender_id = ? AND sender_type = ? AND receiver_id = ? AND receiver_type = ?) " +
                     "ORDER BY timestamp ASC";
        return jdbcTemplate.query(sql, messageRowMapper, userId1, type1, userId2, type2, userId2, type2, userId1, type1);
    }

    public int markAsRead(Long senderId, Long receiverId) {
        return jdbcTemplate.update(
                "UPDATE chat_messages SET is_read = TRUE WHERE sender_id = ? AND receiver_id = ?",
                senderId, receiverId);
    }
    
    public int getUnreadCount(Long userId) {
        Integer count = jdbcTemplate.queryForObject(
                "SELECT COUNT(*) FROM chat_messages WHERE receiver_id = ? AND is_read = FALSE",
                Integer.class, userId);
        return count != null ? count : 0;
    }
}
