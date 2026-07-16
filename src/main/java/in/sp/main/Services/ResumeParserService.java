package in.sp.main.Services;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileInputStream;

@Service
public class ResumeParserService {

    public String extractText(File file, String fileName) throws Exception {
        String resumeText = "";
        
        if (fileName.toLowerCase().endsWith(".pdf")) {
            try (PDDocument document = PDDocument.load(file)) {
                PDFTextStripper stripper = new PDFTextStripper();
                resumeText = stripper.getText(document);
            }
        } else if (fileName.toLowerCase().endsWith(".docx")) {
            try (FileInputStream fis = new FileInputStream(file);
                 XWPFDocument doc = new XWPFDocument(fis);
                 XWPFWordExtractor extractor = new XWPFWordExtractor(doc)) {
                resumeText = extractor.getText();
            }
        } else {
            throw new IllegalArgumentException("Unsupported file format for analysis. Only PDF and DOCX are supported.");
        }
        
        if (resumeText == null || resumeText.trim().isEmpty()) {
            throw new Exception("Could not extract any text from the document. The file might be an image-based PDF or empty.");
        }

        return resumeText;
    }
}
