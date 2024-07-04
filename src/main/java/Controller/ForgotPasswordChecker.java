package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import Pojo.AdminDetails;
import SessionDB.SSConnector;

@WebServlet("/ForgotPasswordChecker")
public class ForgotPasswordChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  String npass = request.getParameter("npass");
	  String cpass = request.getParameter("cpass");
	  
	  HttpSession session = request.getSession(true);
	  String username = (String)session.getAttribute("username");
	  
	  if(npass.equals(cpass))
	  {
		Session ss = SSConnector.getSession();  
		String hql = "UPDATE Login SET password = '"+cpass+"' WHERE username = '"+username+"'";
		Query q = ss.createQuery(hql);
		Transaction tt = ss.beginTransaction();
		q.executeUpdate();
		tt.commit();
		
		session.setAttribute("pass", "Your password is set now.");
	  }
	  else
	  {
	    session.setAttribute("unpass", "your new password and confirm password are not matched please try again");  
	  }
	  response.setHeader("Cache-Control","no-store");
	  response.sendRedirect("ForgetPassword.jsp");
   }
}
