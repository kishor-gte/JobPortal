package in.sp.main.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import in.sp.main.Entities.JobSeeker;
import in.sp.main.Entities.ReportedJob;
import in.sp.main.Repositories.ReportedJobRepository;

@Service
public class ReportedJobService {

    @Autowired
    private ReportedJobRepository reportedJobRepository;

    public List<ReportedJob> getReportsBySeeker(JobSeeker seeker) {
        return reportedJobRepository.findByReporterWithJobAndCompany(seeker);
    }
}
