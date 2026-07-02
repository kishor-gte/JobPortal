package in.sp.main.Services;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.Company;
import in.sp.main.Entities.Media;
import in.sp.main.Repositories.CompanyRepository;
import in.sp.main.Repositories.MediaRepository;

@Service
public class MediaService {

    @Autowired
    private MediaRepository mediaRepository;

    @Autowired
    private CompanyRepository companyRepository;

    public void addMedia(Long companyId, String title, String url, String description) {
        Company company = companyRepository.findById(companyId)
                .orElseThrow(() -> new RuntimeException("Company not found"));

        Media media = new Media();
        media.setTitle(title);
        media.setUrl(url);
        media.setDescription(description);
        media.setCompany(company);

        mediaRepository.save(media);
    }

    public List<Media> getMediaByCompany(Long companyId) {
        return mediaRepository.findByCompany_Id(companyId);
    }

    public void deleteMedia(Long id) {
        mediaRepository.deleteById(id);
    }

    // Add media (video)
    public void addMedia(Media media) {
        mediaRepository.save(media);
    }

}