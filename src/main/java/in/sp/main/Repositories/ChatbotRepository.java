package in.sp.main.Repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.ChatbotResponse;

public interface ChatbotRepository extends JpaRepository<ChatbotResponse, Long> {
    List<ChatbotResponse> findAll();
}
