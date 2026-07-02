package in.sp.main.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.Answer;

public interface AnswerRepository extends JpaRepository<Answer, Long> {

	Answer findByQuestion_Id(Long questionId);
}
