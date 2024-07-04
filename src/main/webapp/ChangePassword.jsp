<%@page import="Pojo.AdminDetails"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Query"%>
<%@page import="SessionDB.SSConnector"%>
<%@page import="org.hibernate.Session"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/OrgGlobal.css">
    <link rel="stylesheet" href="CSS/ChangePassword.css">
    <title>SvvvInvento</title>
</head>
<body>
    <div class="hero-wrapper">
        <div class="hero">

          <%@include file="SideBar.jsp"%>
<%
           String username = (String)session.getAttribute("username");
           String comp = (String)session.getAttribute("comp");           
           String mismatch = (String)session.getAttribute("mismatch");
           String old = (String)session.getAttribute("old");
          
           HttpSession session1 = request.getSession();
           
           Session ss = SSConnector.getSession();
           
           String hql = "FROM AdminDetails WHERE AdminEnrollmentNumber = '"+username+"'";
           Query q = ss.createQuery(hql);
           
           List<AdminDetails> l1 = q.list();
           
           if(l1 != null)
           {
        	 for(AdminDetails a : l1)
        	 {
%>          
            <div class="hero-right">
                <div class="change-password-container">
                <form action="UpdatePasswordChecker" method="POST">
                <%
                  if(comp != null)
                  {
             	   out.println("<h2 style='text-align:center; color:dodgerblue;'>"+comp+"</h2>");
             	   session1.removeAttribute("comp");
                  }	      
                
                  if(mismatch != null)
                  {
             	   out.println("<h2 style='text-align:center; color:red;'>"+mismatch+"</h2>"); 
             	   session1.removeAttribute("mismatch");
                  }
                
                  if(old != null)
                  {
             	   out.println("<h2 style='text-align:center; color:red;'>"+old+"</h2>");
             	   session1.removeAttribute("old");
                  }
                %>
                    <h1>Change Password</h1>
                    <div class="input-group">
                    
                        <input type="hidden" value="<%=username%>" name="username">
                      
                      <div class="input-row">
                        <label>Email Id: </label>
                        <input type="email" value="<%=a.getAdminEmail()%>" name="email" readonly/>
                      </div>
            
                      <div class="input-row">
                        <label>Old Password : </label>
                        <input type="password" placeholder="Enter your old password" name="opass" required/>
                      </div>
            
                      <div class="input-row">
                        <label>New Password : </label>
                        <input type="password" placeholder="Enter your new password" name="npass" required/>
                      </div>
            
                      <div class="input-row">
                        <label>Confirm Password : </label>
                        <input type="password" placeholder="Re-enter your New Password" name="cpass" required/>
                      </div>
                    </div>
                    <button id="change-update-btn">Update</button>
                  </div>
                  
                 </form>
        <%        	   	 
        	 }
           }   
        %>   
            </div>
        </div>
</body>

</html>