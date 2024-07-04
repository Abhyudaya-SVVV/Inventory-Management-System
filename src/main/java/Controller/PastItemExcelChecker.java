package Controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import SessionDB.DBconnector;

@WebServlet("/PastItemExcelChecker")
public class PastItemExcelChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	   response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
	   response.setHeader("Content-Disposition", "attachment; filename = PastDiscardItems.xlsx");
	      
	   XSSFWorkbook workbook = new XSSFWorkbook();
	   XSSFSheet sheet = workbook.createSheet("Dump Items");
		  
	   XSSFRow row = sheet.createRow(0);
		  
	   row.createCell(0).setCellValue("Item Name");
	   row.createCell(1).setCellValue("Item Company Name");
	   row.createCell(2).setCellValue("Serial Number");
	   row.createCell(3).setCellValue("SVVV Encoded Number");
	   row.createCell(4).setCellValue("Item Generation");
	   row.createCell(5).setCellValue("Issue Date");
	   row.createCell(6).setCellValue("Delete Date");
	   row.createCell(7).setCellValue("Admin Name");
	   row.createCell(8).setCellValue("Admin Contact");
	   row.createCell(9).setCellValue("Admin Email");
	   row.createCell(10).setCellValue("Admin Department Name");
	   row.createCell(11).setCellValue("Admin Branch Name");
	   row.createCell(12).setCellValue("Item Institute Name");
	
	   int r = 1;
	   
       try
       {
         Statement st = DBconnector.getStatement();
	    
	     String q = "SELECT * FROM PastItemHistory JOIN ItemDeleteDate ON PastItemHistory.SerialNumber = ItemDeleteDate.SerialNumber";
		
	     ResultSet rs = st.executeQuery(q);
	    
	     while(rs.next())
		 {
           row = sheet.createRow(r++);
			  
		   row.createCell(0).setCellValue(rs.getString("ItemName"));
		   row.createCell(1).setCellValue(rs.getString("ItemCompanyName"));
		   row.createCell(2).setCellValue(rs.getString("SerialNumber"));
		   row.createCell(3).setCellValue(rs.getString("SvvvNumber"));
		   row.createCell(4).setCellValue(rs.getString("Generation"));
	   	   row.createCell(5).setCellValue(rs.getString("IssueDate"));
		   row.createCell(6).setCellValue(rs.getString("ItemDeleteDate"));
	   	   row.createCell(7).setCellValue(rs.getString("AdminName"));
		   row.createCell(8).setCellValue(rs.getString("AdminContact"));
		   row.createCell(9).setCellValue(rs.getString("AdminEmail"));
		   row.createCell(10).setCellValue(rs.getString("AdminDeptName"));
		   row.createCell(11).setCellValue(rs.getString("AdminBranchName"));
		   row.createCell(12).setCellValue(rs.getString("AdminInstituteName"));	
		 }
	     workbook.write(response.getOutputStream());
       }
       catch(SQLException e)
       {
    	 System.out.println(e);  
       }
	  }

}

