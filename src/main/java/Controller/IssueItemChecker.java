package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import Pojo.AddItems;
import Pojo.IssueItems;
import Pojo.PastItemHistory;
import SessionDB.SSConnector;

@WebServlet("/IssueItemChecker")
public class IssueItemChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		  String FacultyName = request.getParameter("FacultyName");
	      String FacultyEnrollmentNumber = request.getParameter("FacultyEnrollmentNumber");
	      String FacultyContact = request.getParameter("FacultyContact");
	      String FacultyEmail = request.getParameter("FacultyEmail");
	      String FacultyBranchName = request.getParameter("FacultyBranchName");
	      String FacultyDepartmentName = request.getParameter("FacultyDepartmentName");
	      String FacultyInstituteName = request.getParameter("FacultyInstituteName");
	      String IssueDate = request.getParameter("IssueDate");
	      String ReturnDate = request.getParameter("ReturnDate");
	      String ItemName = request.getParameter("ItemName");
	      String ItemCompanyName = request.getParameter("ItemCompanyName");
	      String ItemSvvvNumber = request.getParameter("ItemSvvvNumber");
	      String ItemSerialNumber = request.getParameter("ItemSerialNumber");
	      String Generation = request.getParameter("Gen");
	      String Remark = request.getParameter("Remark");
	      
	      HttpSession session = request.getSession(true);
	      
	      ArrayList<String> serial = new ArrayList<String>();
	      ArrayList<String> svvvid = new ArrayList<String>();
	      
	      List<String> serial1 = new ArrayList<>();
	      List<String> svvvid1 = new ArrayList<>();
	      
	      List<String> serial2 = new ArrayList<>();
	      List<String> svvvid2 = new ArrayList<>();
	      
	      IssueItems it = new IssueItems(FacultyName, FacultyEnrollmentNumber, FacultyContact, FacultyEmail, FacultyBranchName,
	      FacultyDepartmentName, FacultyInstituteName, IssueDate, ReturnDate, ItemName, ItemCompanyName, ItemSvvvNumber, ItemSerialNumber, Generation, Remark);
	      
	      Session ss = SSConnector.getSession();
	      Transaction tt = ss.beginTransaction();
	      
	      String get = "FROM IssueItems";
	      Query q1 = ss.createQuery(get);
	      
	      List<IssueItems> l1 = q1.list();
	      
	      if(l1 != null)
	      {
	    	for(IssueItems ii : l1)
	    	{
	    	   serial.add(ii.getItemSerialNumber());
	    	   svvvid.add(ii.getItemSvvvNumber());
	    	}
	      }
	      
	      String hql5 = "FROM AddItems";
		  Query q6 = ss.createQuery(hql5);
		  
		  List<AddItems> l2 = q6.list();
	      
		  if(l2 != null)
	  	  {  
	  		for(AddItems a1 : l2)
	  		{
	  		   serial1.add(a1.getSerialNumber());
	  		   svvvid1.add(a1.getSvvvNumber()); 
	  		}
	  	  }
		  
		  String hql2 = "FROM PastItemHistory";
	      Query  q7 = ss.createQuery(hql2);
	       
		  List<PastItemHistory> l3 = q7.list();
	      
	         if(l3 != null)
		  	  {  
		  		for(PastItemHistory p1 : l3)
		  		{
		  		   serial2.add(p1.getSerialNumber());
		  		   svvvid2.add(p1.getSvvvNumber()); 
		  		}
		  	  }
	         
	      if(!it.equals(""))
	      { 
	       if(!serial2.contains(ItemSerialNumber) && !svvvid2.contains(ItemSvvvNumber))	
		   {	  
	    	if(!serial.contains(ItemSerialNumber) && !svvvid.contains(ItemSvvvNumber) && serial1.contains(ItemSerialNumber) && svvvid1.contains(ItemSvvvNumber))  
	    	{
	         try
	         { 
	    	  ss.save(it);
	        	
	          String hql = "INSERT INTO StockIssued(ItemName, ItemCompanyName, SerialNumber, SvvvNumber, Generation, IssueDate, AdminName, AdminContact, AdminEmail, AdminDeptName, AdminBranchName, AdminInstituteName)"+
	                       "SELECT ItemName, ItemCompanyName, SerialNumber, SvvvNumber, Generation, IssueDate, AdminName, AdminContact, AdminEmail, AdminDeptName, AdminBranchName, AdminInstituteName FROM AddItems WHERE SerialNumber = '"+ItemSerialNumber+"'";
	        	
	          String hql1 = "DELETE FROM AddItems WHERE SerialNumber = '"+ItemSerialNumber+"'";
	        	
	          Query q = ss.createQuery(hql);
	        	    q.executeUpdate();
	        	
	          Query q2 = ss.createQuery(hql1);
	        	    q2.executeUpdate();
	        	      
	        	    tt.commit();	

	          session.setAttribute("Imsg", "Item Issued Successfully");
	         }
	         catch(Exception e)
	         {
	           System.out.println(e);
	           session.setAttribute("Ex", "Unknown Item Entry");
	         }
	    	}
	    	else
	    	{
	    	  session.setAttribute("NImsg", "Serial Number or Svvv Encoded number are already issued by a faculty");
	    	}
	       }
	       else
	       {
	    	 session.setAttribute("discard", "This Item is discarded!"); 
	       }
	      }
	      else
	      { 
	    	session.setAttribute("INmsg", "Error");
	      }
	      response.sendRedirect("IssueItemsForm.jsp");
	}

}
