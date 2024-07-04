package Controller;

import java.io.IOException;

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
import SessionDB.SSConnector;

@WebServlet("/DeleteItemChecker")
public class DeleteItemChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  String serial = request.getParameter("serial");
	  String ItemDeleteDate = request.getParameter("ItemDeleteDate");
	  
	  HttpSession session = request.getSession(true);

	  if(serial != null)
	  {
	    Session ss = SSConnector.getSession();
	    Transaction tt = ss.beginTransaction();
	    
	   AddItems ai = new AddItems();
	   ai.setSerialNumber(serial);
	   
	   Pojo.ItemDeleteDate dd = new Pojo.ItemDeleteDate(ItemDeleteDate, serial);
	   
	   String hql = "INSERT INTO PastItemHistory(ItemName, ItemCompanyName, SerialNumber, SvvvNumber, Generation, IssueDate, AdminName, AdminContact, AdminEmail, AdminDeptName, AdminBranchName, AdminInstituteName)"+
	                "SELECT ItemName, ItemCompanyName, SerialNumber, SvvvNumber, Generation, IssueDate, AdminName, AdminContact, AdminEmail, AdminDeptName, AdminBranchName, AdminInstituteName FROM AddItems WHERE SerialNumber = '"+serial+"'";
	   
	   String hql1 = "DELETE FROM AddItems WHERE SerialNumber = '"+serial+"'";
	   
	   Query q = ss.createQuery(hql);
	         q.executeUpdate();
          
	    ss.save(dd);    
	         
	   Query q1 = ss.createQuery(hql1);
	         q1.executeUpdate();
	         tt.commit(); 	 
	   
	   //request.setAttribute("Dmsg", "This Item '"+serial+"' is permanently deleted from the SVVV inventory");
	   session.setAttribute("Dmsg", "This Item '"+serial+"' is permanently deleted from the SVVV inventory");
	  }
	  else
	  {
		//request.setAttribute("Emsg", "error");  
		session.setAttribute("Emsg", "error");
	  }
	  
	  response.sendRedirect("StockCountList.jsp");
	}

}
