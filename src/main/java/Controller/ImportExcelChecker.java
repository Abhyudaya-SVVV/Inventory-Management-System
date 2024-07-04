package Controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import Pojo.AddItems;
import Pojo.IssueItems;
import Pojo.PastItemHistory;
import SessionDB.DBconnector;
import SessionDB.SSConnector;

@MultipartConfig
@WebServlet("/ImportExcelChecker")
public class ImportExcelChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
      response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String sheetName = request.getParameter("sheet");
		String filePath = request.getParameter("path");
		
		Part filePart = request.getPart("file");
        String fileName = getFileName(filePart);	
		
        HttpSession session = request.getSession(true);
		
		List<String> serial = new ArrayList<>();
	    List<String> svvvid = new ArrayList<>();
		
	    List<String> serial1 = new ArrayList<>();
	    List<String> svvvid1 = new ArrayList<>();
	      
        List<String> serial2 = new ArrayList<>();
        List<String> svvvid2 = new ArrayList<>();
	      
		Session ss = SSConnector.getSession();
	  	Transaction tt = ss.beginTransaction();
	      
	  	String hql = "FROM AddItems";
		Query q = ss.createQuery(hql);
		  
		List<AddItems> l1 = q.list();
	      
		if(l1 != null)
	  	{  
	  	  for(AddItems a1 : l1)
	  	  {
	  	    serial.add(a1.getSerialNumber());
	  		svvvid.add(a1.getSvvvNumber()); 
	  	   }
	  	}
		
		String hql1 = "FROM IssueItems";
	      Query  q1 = ss.createQuery(hql1);
	     
	      List<IssueItems> l2 = q1.list();
	      
	         if(l2 != null)
		  	  {  
		  		for(IssueItems i1 : l2)
		  		{
		  		   serial1.add(i1.getItemSerialNumber());
		  		   svvvid1.add(i1.getItemSvvvNumber()); 
		  		}
		  	  }
	       
	       String hql2 = "FROM PastItemHistory";
	       Query  q2 = ss.createQuery(hql2);
	     
	      List<PastItemHistory> l3 = q2.list();
	      
	         if(l3 != null)
		  	  {  
		  		for(PastItemHistory p1 : l3)
		  		{
		  		   serial2.add(p1.getSerialNumber());
		  		   svvvid2.add(p1.getSvvvNumber()); 
		  		}
		  	  }
	  try
	  {
		FileInputStream fis = new FileInputStream(filePath);
		XSSFWorkbook workbook = new XSSFWorkbook(fis);
		XSSFSheet sheet = workbook.getSheet(sheetName);
	   
	   if(sheet != null)
	   {	   
		int rows = sheet.getLastRowNum();
        	
		for(int r=1;r<=rows;r++)
		{
		  XSSFRow row = sheet.getRow(r);
		  
		  String ItemName = row.getCell(0).getStringCellValue();
		  String ItemCompanyName = row.getCell(1).getStringCellValue();
		  String SerialNumber = row.getCell(2).getStringCellValue();
		  String SvvvNumber = row.getCell(3).getStringCellValue();
		  String Generation = row.getCell(4).getStringCellValue();
		  String IssueDate = row.getCell(5).getStringCellValue();
		  String AdminName = row.getCell(6).getStringCellValue();
		  String AdminContact = row.getCell(7).getStringCellValue();
		  String AdminEmail = row.getCell(8).getStringCellValue();
		  String AdminDeptName = row.getCell(9).getStringCellValue();
		  String AdminBranchName = row.getCell(10).getStringCellValue();
		  String AdminInstituteName = row.getCell(11).getStringCellValue();
		  
	 if(!serial2.contains(SerialNumber) && !svvvid2.contains(SvvvNumber))
	 {	 
	  if(!serial.contains(SerialNumber) && !svvvid.contains(SvvvNumber) && !serial1.contains(SerialNumber) && !svvvid1.contains(SvvvNumber))
	  {	  
		 try 
		 {
		  Statement st = DBconnector.getStatement();
		  String qn = "INSERT INTO AddItems VALUES('"+ItemName+"', '"+ItemCompanyName+"', '"+SerialNumber+"', '"+SvvvNumber+"', '"+Generation+"', '"+IssueDate+"', "
	      		     + "'"+AdminName+"', '"+AdminContact+"', '"+AdminEmail+"', '"+AdminDeptName+"', '"+AdminBranchName+"', '"+AdminInstituteName+"')";
		  
		  int i = st.executeUpdate(qn);
		  if(i>0)
		  {
			session.setAttribute("Amsg", "Items of excel sheets are Added in University Store");
		  }
		  else
		  {
		    session.setAttribute("ANmsg", "Error");
		  }
		 }
		 catch(SQLException e)
		 {
			System.out.println(e); 
		 }
	   }
	  else
	  {
		  session.setAttribute("ALmsg", "Serial Number or Svvv Encoded number are already exist");
	  }
	 }
	 else
	 {
	   session.setAttribute("PSTmsg", "This Item is discarded from the SVVV store!");
	 }
	}	
	 	response.sendRedirect("ImportExcel.jsp");
	} 
	else
	{
	  session.setAttribute("SEmsg", "Your sheet name is not Correct");
	  response.sendRedirect("ImportExcel.jsp");	
	}
	  }
	  catch(IOException e)
	  {
		  session.setAttribute("FEmsg", "Your file path is not Correct");
		  response.sendRedirect("ImportExcel.jsp");
	  }
	}
    private String getFileName(final Part part) 
    {
        final String partHeader = part.getHeader("content-disposition");
        for (String content : partHeader.split(";"))
        {
            if (content.trim().startsWith("filename")) 
            {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null; 
	} 
	
}
