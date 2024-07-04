package Controller;

import java.io.IOException;
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

import Pojo.Login;
import SessionDB.SSConnector;

@WebServlet("/UpdatePasswordChecker")
public class UpdatePasswordChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{ 	
		  String username = request.getParameter("username");
		  String opass = request.getParameter("opass");
		  String npass = request.getParameter("npass");
		  String cpass = request.getParameter("cpass");
		  String tablepassword = "";
		  
		  HttpSession session = request.getSession(true);
	        
		  Session ss = SSConnector.getSession();
		  Transaction tt = ss.beginTransaction();
		  
		  String hql = "FROM Login WHERE username = '"+username+"'";
		  Query q = ss.createQuery(hql);
		  
		  List<Login> l1 = q.list();
		
			if(l1 != null)
			  {
				for(Login l : l1)
				{
				  tablepassword = l.getPassword();	
				}
			  }
			  if(opass.equals(tablepassword))
			  {
				if(npass.equals(cpass))
				{
				   String hql1 = "UPDATE Login SET password = '"+cpass+"' WHERE username = '"+username+"'";	
				   q = ss.createQuery(hql1);
				   q.executeUpdate();
				   tt.commit();

				   session.setAttribute("comp", "Password Updated Successfully!");
				}
				else
				{
				   session.setAttribute("mismatch", "New and Confirm password are not matched");
				}
			  }
			  else
			  {
				  session.setAttribute("old", "Old Password is not correct");  
			  }
			  response.sendRedirect("ChangePassword.jsp");
	}
}
