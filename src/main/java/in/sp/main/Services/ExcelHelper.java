package in.sp.main.Services;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import in.sp.main.Entities.AssessmentQuestion;

public class ExcelHelper {

    public static List<AssessmentQuestion> convertExcelToList(InputStream is, String skill) throws IOException {
        List<AssessmentQuestion> questions = new ArrayList<>();
        try (Workbook workbook = new XSSFWorkbook(is)) {
            Sheet sheet = workbook.getSheetAt(0);
            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue; // skip header
                
                // Skip empty rows
                if (row.getCell(0) == null || getCellValue(row.getCell(0)).isEmpty()) {
                    continue;
                }
                
                AssessmentQuestion q = new AssessmentQuestion();
                q.setSkill(skill);
                q.setQuestion(getCellValue(row.getCell(0)));
                q.setOptionA(getCellValue(row.getCell(1)));
                q.setOptionB(getCellValue(row.getCell(2)));
                q.setOptionC(getCellValue(row.getCell(3)));
                q.setOptionD(getCellValue(row.getCell(4)));
                q.setCorrectOption(getCellValue(row.getCell(5)));
                questions.add(q);
            }
        }
        return questions;
    }
    
    private static String getCellValue(org.apache.poi.ss.usermodel.Cell cell) {
        if (cell == null) {
            return "";
        }
        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().trim();
            case NUMERIC:
                return String.valueOf((int) cell.getNumericCellValue());
            case BOOLEAN:
                return String.valueOf(cell.getBooleanCellValue());
            default:
                return "";
        }
    }
}
