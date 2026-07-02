package in.sp.main.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.Tag;
import in.sp.main.Repositories.TagRepository;

@Service
public class TagService {

    @Autowired
    private TagRepository tagRepository;

    // Fetch all tags from the database
    public List<Tag> getAllTags() {
        return tagRepository.findAll();
    }

    // Fetch tags by their IDs (for updating a job)
    public List<Tag> getTagsByIds(List<Long> tagIds) {
        return tagRepository.findAllById(tagIds);  // Assuming you have a method to find tags by IDs
    }

    // Save or update a tag (in case of a new tag creation or edit)
    public Tag saveTag(Tag tag) {
        return tagRepository.save(tag);  // Saves the tag in the database
    }

    // Optionally, delete a tag if needed
    public void deleteTag(Long id) {
        tagRepository.deleteById(id);  // Deletes a tag by its ID
    }
}
