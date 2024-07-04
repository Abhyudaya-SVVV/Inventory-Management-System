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

import Pojo.PastIssuedHistory;
import SessionDB.SSConnector;

@WebServlet("/ReturnItemChecker")
public class ReturnItemChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
      String FacultyName = request.getParameter("faculty"); 
	  String FacultyEnrollmentNumber = request.getParameter("fec");
	  String FacultyContact= request.getParameter("fc"); 
	  String FacultyEmail = request.getParameter("fe"); 
	  String FacultyBranchName = request.getParameter("fbn"); 
	  String FacultyDeptName = request.getParameter("fdn"); 
	  String FacultyInstituteName = request.getParameter("fin"); 
	  String IssueDate = request.getParameter("fid");
	  String ReturnDate = request.getParameter("return");
	  String TimeStamp = request.getParameter("time");
	  String ItemName = request.getParameter("in");
	  String ItemCompanyName = request.getParameter("icn");
	  String ItemSvvvNumber = request.getParameter("isn");
	  String ItemSerialNumber = request.getParameter("serial");
	  String Generation = request.getParameter("Gen");
	  String Remark = request.getParameter("remark");
	  
	  HttpSession session = request.getSession(true);
	  
	  if(!FacultyEnrollmentNumber.equals("") && !ReturnDate.equals("") && !ItemSerialNumber.equals(""))
	  {
		Session ss = SSConnector.getSession();
		Transaction tt = ss.beginTransaction();
		
		PastIssuedHistory pi = new PastIssuedHistory(FacultyName, FacultyEnrollmentNumber, 
				FacultyContact, FacultyEmail, FacultyBranchName, FacultyDeptName, FacultyInstituteName,
				IssueDate, ReturnDate, TimeStamp, ItemName, ItemCompanyName, ItemSvvvNumber, ItemSerialNumber, Generation, Remark);
		
		ss.save(pi);
		
		String hql2 = "DELETE FROM IssueItems WHERE FacultyEnrollmentNumber = '"+FacultyEnrollmentNumber+"'";
		
		String hql3 = "INSERT INTO AddItems(ItemName, ItemCompanyName, SerialNumber, SvvvNumber, Generation, IssueDate, AdminName, AdminContact, AdminEmail, AdminDeptName, AdminBranchName, AdminInstituteName)"
				       +"SELECT ItemName, ItemCompanyName, SerialNumber, SvvvNumber, Generation, IssueDate, AdminName, AdminContact, AdminEmail, AdminDeptName, AdminBranchName, AdminInstituteName FROM StockIssued WHERE SerialNumber = '"+ItemSerialNumber+"'";
		
		String hql4 = "DELETE FROM StockIssued WHERE SerialNumber = '"+ItemSerialNumber+"'";
		           
		Query q2 = ss.createQuery(hql2);
		           q2.executeUpdate();  
		           
		Query q3 = ss.createQuery(hql3);
		           q3.executeUpdate();
		           
		Query q4 = ss.createQuery(hql4);
		           q4.executeUpdate();         
		           
		           tt.commit();

		           session.setAttribute("Rmsg", "Item return successfully to the inventory");
	  }
	  else
	  {
		 session.setAttribute("RNmsg", "error");
	  }
	  response.sendRedirect("IssuedItemCount.jsp");
    }

}
