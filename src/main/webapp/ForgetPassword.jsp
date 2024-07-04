<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/ForgotPassword.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>SvvvInvento</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <div class="forgot-page">
        <div class="forgot">
            <div class="forgot-left">
                <div class="forgot-heading">
                    <h1>Forget Your Password</h1>
                </div>
                <div class="img-wrapper">
                    <img src="assets/forgotpasswd.svg" alt="" />
                </div>
            </div>
            <div class="forgot-right">
                <%  
                String pass = (String)session.getAttribute("pass");
                String unpass = (String)session.getAttribute("unpass");
                String failed = (String)session.getAttribute("failed");
               
                HttpSession session1 = request.getSession(true);
                
                response.setHeader("Cache-Control","no-store");
                
                if(pass != null)
                {
          	     out.println("<h2 style='text-align:center; color:dodgerblue;'>"+pass+"</h2>");
          	     session1.removeAttribute("pass");
                }	      
             
                if(unpass != null)
                {
          	     out.println("<h2 style='text-align:center; color:red;'>"+unpass+"</h2>"); 
          	     session1.removeAttribute("unpass");
                }
                if(failed != null)
                {
          	     out.println("<h2 style='text-align:center; color:red;'>"+failed+"</h2>");
          	     session1.removeAttribute("failed");
                }
                session.invalidate();
                %>
                <div class="forgot-container">
                    <h2>Forgot Password</h2>
                    <%
	                  int intOtp = (int)(Math.random()*9000)+1000;
	       		      String otp = String.valueOf(intOtp);
	         		  System.out.println("jsp otp : "+otp);
                    %>
                    <form id="forgotPasswordForm" action="ForgetPasswordMailVerifier" method="POST">
                        <div class="form-group"> 
                            <label>Username:</label>
                            <input type="text" class="form-control" id="uname" name="uname" placeholder="Enter username" required="required"/>
                            <label>Email:</label>
                            <input type="email" class="form-control" id="emailInput" name="emailInput" placeholder="Enter email" required="required"/>
                            <input type="hidden" name="otpGen" id="otpGen" value="<%=otp%>">
                        </div>
                        <button type="submit" class="forgot-pg-btn" id="otpButton">Generate OTP</button>
                    </form>    
                        
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <a href="login.jsp" style="color: #007bff; text-decoration: none;">sign in</a>
                </div>
            </div>
        </div>
    </div>    
</body>
</html>