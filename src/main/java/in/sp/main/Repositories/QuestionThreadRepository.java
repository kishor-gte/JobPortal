package in.sp.main.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.QuestionThread;

public interface QuestionThreadRepository extends JpaRepository<QuestionThread, Long> {}
