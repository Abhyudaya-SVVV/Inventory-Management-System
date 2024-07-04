package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

import SessionDB.SSConnector;

@WebServlet("/UpdateProfileChecker")
public class UpdateProfileChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		   String username = request.getParameter("enrollment");
		   String email = request.getParameter("email");
		   String contact = request.getParameter("contact");
		   
		   Session ss = SSConnector.getSession();
		   Transaction tt = ss.beginTransaction();
		   
		   String hql = "UPDATE AdminDetails SET AdminEmail = '"+email+"', AdminContact = '"+contact+"' WHERE AdminEnrollmentNumber = '"+username+"'";
		   Query q = ss.createQuery(hql);
		   q.executeUpdate();
		   tt.commit();
		   
		   request.setAttribute("Umsg", "Information Updated");
	       RequestDispatcher rd = request.getRequestDispatcher("EditProfile.jsp");
	       rd.forward(request, response);
	}

}
