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
            response.setHeader("Cache-Control","no-store");
            %>
                <div class="forgot-container">
                    <h2>Forgot Password</h2>
                    <%
	                  int intOtp = (int)(Math.random()*9000)+1000;
	       		      String otp = String.valueOf(intOtp);
	         		  System.out.println("jsp otp : "+otp);
	         		  
	         		  String email = (String)session.getAttribute("emailid");
	         		  String fotp = (String)session.getAttribute("fotp");
	         		  
	         		  if(email == null)
	         		  {
	         			response.sendRedirect("ForgetPassword.jsp");  
	         		  }
                    %>
                    <form id="otpContainer">
                            <div class="form-group">
                                <label>Enter OTP:</label>
                                <input type="text" class="form-control" placeholder="Enter OTP" id="otpCheck"/>
                                <input type="hidden" name="otpGen" id="otpGen" value="<%=otp%>"/>
                                <input type="hidden" name="fotp" id="fotp" value="<%=fotp%>"/>
                                <input type="hidden" name="email" id="email" value="<%=email%>"/>
                            </div>
                            <button type="button" id="verifyButton" class="btn btn-primary" onclick="validateOTP()">Verify</button>
                            <button type="button" id="verifyButton" class="btn btn-link" onclick="resendOTP()">resend OTP</button>
                    </form> 
                    
                    <form action="ForgotPasswordChecker" method="POST" id="password-item" style="display: none;">    
                    
                            <div class="form-group">
                                <label>New Password:</label>
                                <input type="password" name="npass" class="form-control" placeholder="Enter new password" id="newPasswordInput" />
                            </div>
                            <div class="form-group">
                                <label>Confirm Password:</label>
                                <input type="password" name="cpass" class="form-control" placeholder="Confirm new password" id="confirmPasswordInput" />
                            </div>
                            <div>
                                <button type="submit" class="forgot-pg-btn">Submit</button>
                            </div>
                    </form>
                        
                        <div id="remsg" style="display:none;">
                            <label for="reotp" style="color:green;">OTP has been re-send on your mail successfully.</label>
                        </div>
             
                        <div id="invalid" style="display:none;">
                            <label for="invalidotp" style="color:red;">OTP in invalid!</label>
                        </div>
             
                        <div id="please" style="display:none;">
                            <label for="invalidotp" style="color:red;">Please enter OTP!</label>
                        </div>
                        
                        <div id="press" style="display:none;">
                            <label for="pressconfirm" style="color:green;">Enter your new password.</label>
                        </div> 
                        
                        <div id="default">
                            <label for="pressconfirm" style="color:green;">OTP has sent on your mail.</label>
                        </div>   
                </div>
            </div>
        </div>
    </div>  
<script>
function resendOTP() 
{
    var email = document.getElementById("email").value;
    var otpGen = document.getElementById("otpGen").value;	
    
    	$.ajax(
    	        {
    	            type: "POST",
    	            url: "ForgetResentMailVerifier",
    	            data: { email: email,
    	            	    otpGen: otpGen},
    	            success: function(response) 
    	            {
    	                // OTP sent, show OTP field
    	                alert("OTP has re-sent on your mail!");
    	                document.getElementById("otpContainer").style.display = "block";
    	                document.getElementById("remsg").style.display = "block";
    	                document.getElementById("invalid").style.display = "none";
    	                document.getElementById("please").style.display = "none";
    	                document.getElementById("default").style.display = "none";
    	                
    	            } 	    
    	        });		
}
    
    function validateOTP() 
    {
    	var userInput = document.getElementById("otpCheck");
    	var otpGen = document.getElementById("otpGen");
    	var fotp = document.getElementById("fotp");
    	
    	const enteredOTP = userInput.value;
    	const mailOTP = otpGen.value;
    	const oldOTP = fotp.value;
    	
        // Implement OTP verification logic
        if (enteredOTP === mailOTP || enteredOTP === oldOTP) 
        {
        	alert("OTP is valid press confirm..");
            document.getElementById("otpContainer").style.display = "none";
            document.getElementById("password-item").style.display = "block";
            document.getElementById("invalid").style.display = "none";
            document.getElementById("press").style.display = "block";
            document.getElementById("remsg").style.display = "none";
            document.getElementById("please").style.display = "none";
            document.getElementById("default").style.display = "none";
        } 
        else if (enteredOTP === "")
        {
          alert("Please enter OTP!");	
          document.getElementById("please").style.display = "block";
          document.getElementById("default").style.display = "none";
        }
        else 
        {
        	alert("OTP in invalid!");
        	document.getElementById("invalid").style.display = "block";
        	document.getElementById("remsg").style.display = "none";
        	document.getElementById("please").style.display = "none";
        	document.getElementById("default").style.display = "none";
        }
    }   
    
    document.addEventListener("DOMContentLoaded", (event) => 
    {
        if (performance.navigation.type === performance.navigation.TYPE_RELOAD) 
        {
          fetch("RemoveSessionAttributeOTP", 
          {
            method: "POST",
            credentials: "same-origin",
            headers: 
            {
              "Content-Type": "application/x-www-form-urlencoded"
            }
          }).then(response => 
          {
            if (response.ok) 
            {
              console.log("Session attribute removed successfully.");
              window.location.href = "ForgetPassword.jsp";
            } 
            else 
            {
              console.error("Failed to remove session attribute.");
            }
          }).catch(error => 
          {
            console.error("Error:", error);
          });
        }
      });
</script>  
</body>
</html>