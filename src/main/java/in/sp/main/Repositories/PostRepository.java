package in.sp.main.Repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import in.sp.main.Entities.Post;

public interface PostRepository extends JpaRepository<Post, Long> {}