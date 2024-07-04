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

import Pojo.AddItems;
import SessionDB.SSConnector;

/**
 * Servlet implementation class StockExcelChecker
 */
@WebServlet("/StockExcelChecker")
public class StockExcelChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	  response.setHeader("Content-Disposition", "attachment; filename = StockItems.xlsx");

	  XSSFWorkbook workbook = new XSSFWorkbook();
	  XSSFSheet sheet = workbook.createSheet("Stock Items");
		  
	  XSSFRow row = sheet.createRow(0);
		  
	  row.createCell(0).setCellValue("Item Name");
	  row.createCell(1).setCellValue("Item Company Name");
	  row.createCell(2).setCellValue("Serial Number");
	  row.createCell(3).setCellValue("SVVV Encoded Number");
	  row.createCell(4).setCellValue("Item Generation");
	  row.createCell(5).setCellValue("Issue Date");
	  row.createCell(6).setCellValue("Admin Name");
      row.createCell(7).setCellValue("Admin Contact");
	  row.createCell(8).setCellValue("Admin Email");
	  row.createCell(9).setCellValue("Admin Department Name");
	  row.createCell(10).setCellValue("Admin Branch Name");
	  row.createCell(11).setCellValue("Item Institute Name");
		  
	  Session ss = SSConnector.getSession();
		  
	  String hql = "FROM AddItems";
	  Query q = ss.createQuery(hql);
		  
	  List<AddItems> l1 = q.list();
		  
	  if(l1 != null)
	  {
			int r=1;  
			for(AddItems a1 : l1)
			{	
			  row = sheet.createRow(r++);
			  
			  row.createCell(0).setCellValue(a1.getItemName());
			  row.createCell(1).setCellValue(a1.getItemCompanyName());
			  row.createCell(2).setCellValue(a1.getSerialNumber());
			  row.createCell(3).setCellValue(a1.getSvvvNumber());
			  row.createCell(4).setCellValue(a1.getGeneration());
			  row.createCell(5).setCellValue(a1.getIssueDate());
			  row.createCell(6).setCellValue(a1.getAdminName());
			  row.createCell(7).setCellValue(a1.getAdminContact());
			  row.createCell(8).setCellValue(a1.getAdminEmail());
			  row.createCell(9).setCellValue(a1.getAdminDeptName());
			  row.createCell(10).setCellValue(a1.getAdminBranchName());
			  row.createCell(11).setCellValue(a1.getAdminInstituteName());
			}
	  }
		workbook.write(response.getOutputStream());  	  
	}

}
