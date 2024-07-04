package Controller;

import java.io.IOException;
import java.util.List;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;

import Pojo.AdminDetails;
import SessionDB.SSConnector;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@WebServlet("/ForgetResentMailVerifier")
public class ForgetResentMailVerifier extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	  response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String to = request.getParameter("email");
		String from = "mayankmatkar04@gmail.com";
		String subject = "SvvvInvento OTP for verififcation";
		String otp = request.getParameter("otpGen");
		String mailCheck = "";
        
		sendEmail(to, from, subject, otp);
		System.out.println("Mail has been sent...!");	
		
		response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(otp);
	}
    
	private void sendEmail(String to, String from, String subject, String otp) 
	{
		Properties prop = new Properties();
		prop.put("mail.smtp.auth", true);
		prop.put("mail.smtp.starttls.enable", true);
		prop.put("mail.smtp.port", "587");
		prop.put("mail.smtp.host", "smtp.gmail.com");
		
		Session session = Session.getInstance(prop, new Authenticator() 
		{
		    @Override
		   	protected PasswordAuthentication getPasswordAuthentication() 
		    {
		   		return new PasswordAuthentication("mayankmatkar04", "zezu amwy guqa cnkg");
		   	} 	
		});
	  try
	  { 
		Message msg = new MimeMessage(session);
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
		msg.setFrom(new InternetAddress(from));
		msg.setSubject(subject);
		msg.setText("YOUR OTP FROM SvvvInvento FOR FORGOT PASSWORD: "+otp);
		
		Transport.send(msg); 
	  }
	  catch(MessagingException e)
	  {
		 System.out.println(e); 
	  }	
    }

}
