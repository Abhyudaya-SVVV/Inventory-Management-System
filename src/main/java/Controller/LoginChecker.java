package Controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;

import Pojo.Login;
import SessionDB.SSConnector;

@WebServlet("/LoginChecker")
public class LoginChecker extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String maincaptcha = request.getParameter("mainc");
		String inputcaptcha = request.getParameter("inputc");
		 
		if(maincaptcha.equals(inputcaptcha))
		{	
			Session ss = SSConnector.getSession();
			Criteria ct = ss.createCriteria(Login.class);
			  
			ct.add(Restrictions.eq("username", username));
			ct.add(Restrictions.eq("password", password));
			 
			List l = ct.list();
			  
			if(!l.isEmpty())
			{
			  HttpSession session = request.getSession(true);
			  session.setAttribute("username", username);
			  response.sendRedirect("AdminDashboard.jsp");
			}
			else
			{
			  HttpSession session = request.getSession(true);
			  session.setAttribute("Fmsg", "Login Failed");
			  response.sendRedirect("login.jsp");	  
			}
		}
		else
		{
		   HttpSession session = request.getSession(true);
		   session.setAttribute("Cmsg", "Invalid Captcha");
		   response.sendRedirect("login.jsp");
		}
	}

}
