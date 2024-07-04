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

@WebServlet("/AddItemChecker")
public class AddItemChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		  String ItemName = request.getParameter("ItemName");
	      String ItemCompanyName = request.getParameter("ItemCompanyName");
	      String SerialNumber = request.getParameter("SerialNumber");
	      String SvvvNumber = request.getParameter("SvvvNumber");
	      String Generation = request.getParameter("Gen");
	      String IssueDate = request.getParameter("IssueDate");
	      String AdminName = request.getParameter("AdminName");
	      String AdminContact = request.getParameter("AdminContact");
	      String AdminEmail = request.getParameter("AdminEmail");
	      String AdminDeptName = request.getParameter("AdminDeptName");
	      String AdminBranchName = request.getParameter("AdminBranchName");
	      String AdminInstituteName = request.getParameter("AdminInstituteName");
	      
	      HttpSession session = request.getSession(true);
	      
	      List<String> serial = new ArrayList<>();
	      List<String> svvvid = new ArrayList<>();
	      
	      List<String> serial1 = new ArrayList<>();
	      List<String> svvvid1 = new ArrayList<>();
	      
	      List<String> serial2 = new ArrayList<>();
	      List<String> svvvid2 = new ArrayList<>();
	      
	      AddItems ai = new AddItems(ItemName, ItemCompanyName, SerialNumber, SvvvNumber, Generation, IssueDate, AdminName, AdminContact, 
	    		                     AdminEmail, AdminDeptName, AdminBranchName, AdminInstituteName);
	      
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
	         
	  	  if(!ai.equals(""))
	  	  {
	  		if(!serial2.contains(SerialNumber) && !svvvid2.contains(SvvvNumber))
	  		{ 
		  	   if(!serial.contains(SerialNumber) && !svvvid.contains(SvvvNumber) && !serial1.contains(SerialNumber) && !svvvid1.contains(SvvvNumber))
		  	   {	   
		   		  ss.save(ai);
		          tt.commit();
		          session.setAttribute("Amsg", "Item Added in University Store");
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
	  	  else
	      {
	    	 session.setAttribute("ANmsg", "Error");
	      }
	      response.sendRedirect("AddItems.jsp");
	}

}
