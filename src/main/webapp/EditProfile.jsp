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
  <link rel="stylesheet" href="CSS/EditProfile.css">
  <title>SvvvInvento</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
  <div class="hero-wrapper">
    <div class="hero">
     
      <%@include file="SideBar.jsp"%>
      <% 
         String username = (String)session.getAttribute("username");
         
         String Umsg = (String)request.getAttribute("Umsg");
         
         if(Umsg != null)
         {
        	 //out.println("<h2 style='text-align:center; color:red;'>"+Umsg+"</h2>"); 
        %>
           <div class="popup-overlay" style="display: none;">
                    <div class="popup">
                        <h2>Profile Updated Successfully!</h2>
                        <button id="back-btn">Back</button>
                    </div>
                </div>
        <%	 
         }
         Session ss = SSConnector.getSession();
         
         String hql = "FROM AdminDetails WHERE AdminEnrollmentNumber = '"+username+"'";
         Query q = ss.createQuery(hql);
         
         List<AdminDetails> l1 = q.list();
         
         if(l1 != null)
         {
        	for(AdminDetails a1 : l1)
        	{
      %>
      <div class="hero-right">
        <div class="admin-profile-container" style="overflow-y:scroll;">
          <h1>Admin Profile</h1>
          
          <form action="UpdateProfileChecker" method="POST">
          
          <div class="input-group"> 
            <div class="input-row"> 
              <label>Admin Name : </label>
              <input type="text" style="border: 1px solid grey;" name="name" value="<%=a1.getAdminName()%>" style="outline: none;" readonly id="name-input" />
            </div>
            
            <div class="input-row">
              <label>Admin Id : </label>
              <input type="text" style="border: 1px solid grey;" name="enrollment" value="<%=a1.getAdminEnrollmentNumber()%>" style="outline: none;" readonly id="admin-id-input" />
            </div>
            
            <div class="input-row">
              <label>Admin Email : </label>
              <input type="email" style="border: 1px solid grey;" name="email" value="<%=a1.getAdminEmail()%>" style="outline: none;" readonly id="email-input" />
            </div>
            
            <div class="input-row">
              <label>Admin Contact : </label>
              <input type="tel" style="border: 1px solid grey;" name="contact" value="<%=a1.getAdminContact()%>" style="outline: none;" readonly id="contact-input" />
            </div>
            <div class="input-row">
              <label>Admin Branch : </label>
              <input type="text"style="border: 1px solid grey;"  name="branch" value="<%=a1.getAdminBranchName()%>" style="outline: none;" readonly id="branch-input" />
            </div>
            
            <div class="input-row">
              <label>Admin Department : </label>
              <input type="text" style="border: 1px solid grey;" name="dept" value="<%=a1.getAdminDeptName()%>" style="outline: none;" readonly id="department-input" />
            </div>
            
            <div class="input-row">
              <label>Admin Institute : </label>
              <input type="text" style="border: 1px solid grey;" name="institute" value="<%=a1.getAdminInstituteName()%>" readonly id="institute-input" style="outline: none;" />
            </div>
            
            <div id="confirm-item" style="display:none;">
                  <button id="confirm-item-btn">Save</button>
            </div>
            </form>        
          </div>
          
          <button id="change-update-btn" onclick="showUpdateModal()">Edit</button>
          
          <%
	          int intOtp = (int)(Math.random()*9000)+1000;
		      String otp = String.valueOf(intOtp);
          %>
          
          <form id="generate" style="display:none;">
           <div>
              <input type="hidden" name="email" id="email" value="<%=a1.getAdminEmail()%>">
              <input type="hidden" name="otpGen" id="otpGen" value="<%=otp%>">
              
              <button type="button" onclick="sendOTP()">Generate OTP</button>
           </div>
          </form>
          <br>
          
          <div id="cancel-btn"  style="display: none;">
              <button onclick="cancel()">Cancel</button>
          </div>
          
          <form>
               <div id="otpField" style="display:none;">
               
                 <label for="otp">Enter OTP:</label><br>
                 <input type="text" id="otpCheck" name="otp"><br><br>
                 
                 <input type="hidden" name="email" id="email" value="<%=a1.getAdminEmail()%>">
                 <input type="hidden" name="otpGen" id="otpGen" value="<%=otp%>">
                 
                 <button type="button" id="verify-btn" onclick="validateOTP()">Verify OTP</button>
                 <button type="button" id="resend-btn" onclick="resendOTP()">Re-send OTP</button>
               </div>
          </form>
             
           <div id="remsg" style="display:none;">
                 <label for="reotp" style="color:green;">OTP has been re-send on your mail successfully.</label>
           </div>
             
           <div id="invalid" style="display:none;">
                <label for="invalidotp" style="color:red;">OTP in invalid!</label>
           </div>
             
           <div id="press" style="display:none;">
                <label for="pressconfirm" style="color:green;">Click on save.</label>
           </div>
           
           <div id="please" style="display:none;">
                            <label for="invalidotp" style="color:red;">Please enter OTP!</label>
           </div>
          <br>
      <%  		
        	}
         }
      %>     
        </div>
      </div>

<script>
  const updateBtn = document.getElementById('change-update-btn');
  const generateOTPBtn = document.getElementById("generate");
  const emailInput = document.getElementById('email-input');
  const contactInput = document.getElementById('contact-input');
  const cancelBtn = document.getElementById('cancel-btn');
  
  updateBtn.addEventListener('click', showUpdateModal);

  function showUpdateModal() 
  {
          emailInput.readOnly = false;
          emailInput.style.border = "1px solid red";
          emailInput.style.outline = "0px solid red";
          contactInput.readOnly = false;
          contactInput.style.border = "1px solid red";
          contactInput.style.outline = "0px solid red";
          updateBtn.style.display = "none";
          generateOTPBtn.style.display = "block";
          cancelBtn.style.display = "inline-block";
  }
  
  function cancel()
  {
	  emailInput.readOnly = true;
      emailInput.style.border = "1px solid grey";
      emailInput.style.outline = "0px solid";
      contactInput.readOnly = true;
      contactInput.style.border = "1px solid grey";
      contactInput.style.outline = "0px solid";
      updateBtn.style.display = "block";
      generateOTPBtn.style.display = "none";
      cancelBtn.style.display = "none"; 
  }
  
  function sendOTP() 
  {
      var email = document.getElementById("email").value;
      var otpGen = document.getElementById("otpGen").value;
      $.ajax(
      {
          type: "POST",
          url: "EditProfileMailVerifier",
          data: { email: email,
          	    otpGen: otpGen},
          success: function(response) 
          {
              // OTP sent, show OTP field
              alert("OTP has sent on your mail!");
              document.getElementById("otpField").style.display = "block";
              document.getElementById("generate").style.display = "none";
              document.getElementById("cancel-btn").style.display = "none";
          }
      });
  }
  
  function resendOTP()
  {
     document.getElementById("remsg").style.display = "block";
     document.getElementById("invalid").style.display = "none";
     document.getElementById("please").style.display = "none";
     sendOTP();
  }
  
  function validateOTP() 
  {
  	var userInput = document.getElementById("otpCheck");
  	var otpGen = document.getElementById("otpGen");
  	
  	const enteredOTP = userInput.value;
  	const mailOTP = otpGen.value;
  	
      // Implement OTP verification logic
      if (enteredOTP === mailOTP) 
      {
      	alert("OTP is valid press confirm..");
      	document.getElementById("please").style.display = "none";
      	document.getElementById("confirm-item").style.display = "block";
        document.getElementById("otpField").style.display = "none";
        document.getElementById("invalid").style.display = "none";
        document.getElementById("press").style.display = "block";
        document.getElementById("remsg").style.display = "none";
      } 	
      else if (enteredOTP === "")
      {
        alert("Please enter OTP!");	
        document.getElementById("please").style.display = "block";
        document.getElementById("remsg").style.display = "none";
        document.getElementById("invalid").style.display = "none";
      }	
      else 
      {
      	alert("OTP in invalid!");
      	document.getElementById("invalid").style.display = "block";
      	document.getElementById("remsg").style.display = "none";
      	document.getElementById("please").style.display = "none";
      }
  }
</script>
</body>

</html>