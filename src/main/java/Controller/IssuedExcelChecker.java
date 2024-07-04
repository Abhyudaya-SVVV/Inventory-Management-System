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

import Pojo.IssueItems;
import SessionDB.SSConnector;

@WebServlet("/IssuedExcelChecker")
public class IssuedExcelChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	  response.setHeader("Content-Disposition", "attachment; filename = IssuedItems.xlsx");
	  
	  XSSFWorkbook workbook = new XSSFWorkbook();
	  XSSFSheet sheet = workbook.createSheet("Issued Items");
	  
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
	  row.createCell(9).setCellValue("Item Name");
	  row.createCell(10).setCellValue("Item Company Name");
	  row.createCell(11).setCellValue("Item Svvv Number");
	  row.createCell(12).setCellValue("Item Serial Number");
	  row.createCell(13).setCellValue("Item Generation");
	  row.createCell(14).setCellValue("Remark");
	  
	  Session ss = SSConnector.getSession();
	  
	  String hql = "FROM IssueItems";
	  Query q = ss.createQuery(hql);
	  
	  List<IssueItems> l1 = q.list();
	  
	  if(l1 != null)
	  {
		int r = 1;
		for(IssueItems ii : l1)
		{
		  row = sheet.createRow(r++);
		  
		  row.createCell(0).setCellValue(ii.getFacultyName());
		  row.createCell(1).setCellValue(ii.getFacultyEnrollmentNumber());
		  row.createCell(2).setCellValue(ii.getFacultyContact());
		  row.createCell(3).setCellValue(ii.getFacultyEmail());
		  row.createCell(4).setCellValue(ii.getFacultyBranchName());
		  row.createCell(5).setCellValue(ii.getFacultyDeptName());
		  row.createCell(6).setCellValue(ii.getFacultyInstituteName());
		  row.createCell(7).setCellValue(ii.getIssueDate());
		  row.createCell(8).setCellValue(ii.getReturnDate());
		  row.createCell(9).setCellValue(ii.getItemName());
		  row.createCell(10).setCellValue(ii.getItemCompanyName());
		  row.createCell(11).setCellValue(ii.getItemSvvvNumber());
		  row.createCell(12).setCellValue(ii.getItemSerialNumber());
		  row.createCell(13).setCellValue(ii.getGeneration());
		  row.createCell(14).setCellValue(ii.getRemark());
		}
	  }
	  workbook.write(response.getOutputStream());
	}

}
