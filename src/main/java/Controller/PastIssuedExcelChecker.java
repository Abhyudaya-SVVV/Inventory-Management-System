package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Query;
import org.hibernate.Session;

import Pojo.PastIssuedHistory;
import SessionDB.SSConnector;

@WebServlet("/PastIssuedExcelChecker")
public class PastIssuedExcelChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename = PastIssuedItems.xlsx");
		  
		XSSFWorkbook workbook = new XSSFWorkbook();
		XSSFSheet sheet = workbook.createSheet("Past Issued Items");
		  
		XSSFRow row = sheet.createRow(0);
		  
		row.createCell(0).setCellValue("Faculty Name");
	    row.createCell(1).setCellValue("Faculty Enrollment Number");
	    row.createCell(2).setCellValue("Faculty Contact");
	    row.createCell(3).setCellValue("Faculty Email");
		row.createCell(4).setCellValue("Faculty Branch Name");
		row.createCell(5).setCellValue("Faculty Department Name");
		row.createCell(6).setCellValue("Faculty Institute Name");
		row.createCell(7).setCellValue("Issue Date");
		row.createCell(8).setCellValue("Return Date");
		row.createCell(9).setCellValue("Time Stamp");
		row.createCell(10).setCellValue("Item Name");
		row.createCell(11).setCellValue("Item Company Name");
		row.createCell(12).setCellValue("Item Svvv Number");
		row.createCell(13).setCellValue("Item Serial Number");
		row.createCell(14).setCellValue("Item Generation");
		row.createCell(15).setCellValue("Remark");
		  
		Session ss = SSConnector.getSession();
		  
		String hql = "FROM PastIssuedHistory";
		Query q = ss.createQuery(hql);
		  
		List<PastIssuedHistory> l1 = q.list();
		  
		if(l1 != null)
		{
		  int r = 1;
		  for(PastIssuedHistory pp : l1)
		  {
			  row = sheet.createRow(r++);
			  	
			  row.createCell(0).setCellValue(pp.getFacultyName());
			  row.createCell(1).setCellValue(pp.getFacultyEnrollmentNumber());
		      row.createCell(2).setCellValue(pp.getFacultyContact());
			  row.createCell(3).setCellValue(pp.getFacultyEmail());
			  row.createCell(4).setCellValue(pp.getFacultyBranchName());
			  row.createCell(5).setCellValue(pp.getFacultyDeptName());
			  row.createCell(6).setCellValue(pp.getFacultyInstituteName());
			  row.createCell(7).setCellValue(pp.getIssueDate());
			  row.createCell(8).setCellValue(pp.getReturnDate());
			  row.createCell(9).setCellValue(pp.getTimeStamp());
			  row.createCell(10).setCellValue(pp.getItemName());
			  row.createCell(11).setCellValue(pp.getItemCompanyName());
			  row.createCell(12).setCellValue(pp.getItemSvvvNumber());
			  row.createCell(13).setCellValue(pp.getItemSerialNumber());
			  row.createCell(14).setCellValue(pp.getGeneration());
			  row.createCell(15).setCellValue(pp.getRemark());	
			}
		  }
		 workbook.write(response.getOutputStream());
	}
}
