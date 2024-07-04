<%@page import="Pojo.IssueItems"%>
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
  <link rel="stylesheet" href="CSS/navbar.css">
  <link rel="stylesheet" href="CSS/issued_item_info.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <title>SvvvInvento</title>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>
.item-info-wrapper
{
  padding: 10px 0px;
}
.input-row label{
    width: 11vw;
    font-size: 18px;
  }
</style>  
</head>

<body>
       <%
          String username = (String)session.getAttribute("username");
          String serial = request.getParameter("s");
       %>
  <div class="hero-wrapper">
    <div class="hero">
      
      <%@include file="SideBar.jsp"%>
      
      <div class="hero-right">
        <div class="item-info-heading">
            <a href="IssuedItemCount.jsp">
                <i class='bx bx-arrow-back'></i>
            </a>
            <h1>Issued Item Information</h1>
          </div>
     <%
         Session ss = SSConnector.getSession();
      
         String hql = "FROM IssueItems WHERE ItemSerialNumber = '"+serial+"'";
         Query q = ss.createQuery(hql);
      
         List<IssueItems> l1 = q.list();
      
         if(l1 != null)
         {
       	   for(IssueItems ii : l1)
    	   {
      %>
         <div class="item-info-wrapper">
           <div class="item-info-container">
             <div class="input-group">
              <form action="ReturnItemChecker" method="POST" id="return-form">
                  
                <div class="input-row">
                  <label>Faculty Name:</label>
                  <input type="text" name="faculty" value="<%=ii.getFacultyName()%>" readonly>
                </div>
                
                <div class="input-row">
                  <label>Faculty Enrollment Number:</label>
                  <input type="text" name="fec" value="<%=ii.getFacultyEnrollmentNumber()%>" readonly>
                </div>
                
                <div class="input-row">
                  <label>Faculty Email:</label>
                  <input type="email" name="fe" id="email" value="<%=ii.getFacultyEmail()%>" readonly>
                </div>
                
                <div class="input-row">
                  <label>Faculty Contact Number:</label>
                  <input type="number" name="fc" value="<%=ii.getFacultyContact()%>" readonly>
                </div>
                
                <div class="input-row">
                  <label>Faculty Department Name:</label>
                  <input type="text" name="fdn" value="<%=ii.getFacultyDeptName()%>" readonly>
                </div>
                
                <div class="input-row">
                  <label>Faculty Branch Name:</label>
                  <input type="text" name="fbn" value="<%=ii.getFacultyBranchName()%>" readonly>
                </div>
                
                <div class="input-row">
                  <label>Faculty Institute Name:</label>
                  <input type="text" name="fin" value="<%=ii.getFacultyInstituteName()%>" readonly>
                </div>
                
                <div class="input-row">
                  <label>Issue Date:</label>
                  <input type="date" name="fid" value="<%=ii.getIssueDate()%>" readonly>
                </div>
                
                <div class="input-row">
                  <label>Return Date:</label>
                  <input type="date" required="required" name="return" placeholder="Enter Return Date">
                </div>
                
                <div class="input-row">
                  <label>Time Stamp:</label>
                  <input type="time" required="required" name="time" placeholder="Enter Current Time">
                </div>
                
                <div class="input-row">
                  <label>Item Name:</label>
                  <input type="text" name="in" value="<%=ii.getItemName()%>" readonly>
                </div>
                
                <div class="input-row">
                  <label>Item Company Name:</label>
                  <input type="text" name="icn" value="<%=ii.getItemCompanyName()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Item Serial Number:</label>
                  <input type="text" name="serial" value="<%=ii.getItemSerialNumber()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Item Svvv No.:</label>
                  <input type="text" name="isn" value="<%=ii.getItemSvvvNumber()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Item Generation :</label>
                  <input type="text" name="Gen" value="<%=ii.getGeneration()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Remark:</label>
                  <input type="text" name="remark" value="<%=ii.getRemark()%>" readonly>
                </div>
                
              </div>
              <div id="confirm-item" style="display:none;">
                 <button id="return-issued-item-btn">Confirm</button>
              </div>   
              </form>
              
              <form id="otpForm">
                       <%
                          int intOtp = (int)(Math.random()*9000)+1000;
               		      String otp = String.valueOf(intOtp);
                       %>
                       <input type="hidden" name="email" id="email" value="<%=ii.getFacultyEmail()%>">
                       <input type="hidden" name="otpGen" id="otpGen" value="<%=otp%>">
                       <hr style="background-color: #ddd; border: none; height: 1px;">
                       <label style="font-size: 14px; color: red;"><b>* Without mail verification you cannot return the item directly *</b></label>
                       <br>
                       <button type="button" id="return-issued-item-btn" onclick="sendOTP()">Return</button>
              </form>
              
             <form>
               <div id="otpField" style="display:none;">
               
                 <label for="otp">Enter OTP:</label><br>
                 <input type="text" id="otpCheck" name="otp"><br><br>
                 
                 <input type="hidden" name="email" id="email" value="<%=ii.getFacultyEmail()%>">
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
                  <label for="pressconfirm" style="color:green;">Press confirm to return the Item.</label>
             </div>
             
             <div id="please" style="display:none;">
                            <label for="invalidotp" style="color:red;">Please enter OTP!</label>
             </div>
             
            </div>
          </div>
   <% 	  
      }
     }
   %>        
      </div>
    </div>
  </div>
  
<script>
        function sendOTP() 
        {
            var email = document.getElementById("email").value;
            var otpGen = document.getElementById("otpGen").value;
            $.ajax(
            {
                type: "POST",
                url: "ReturnItemMailVerifier",
                data: { email: email,
                	    otpGen: otpGen},
                success: function(response) 
                {
                    // OTP sent, show OTP field
                    alert("OTP has sent on your mail!");
                    document.getElementById("otpField").style.display = "block";
                    document.getElementById("otpForm").style.display = "none";
                    document.getElementById("please").style.display = "none";
                }
            });
        }
        
        function resendOTP()
        {
        	var email = document.getElementById("email").value;
            var otpGen = document.getElementById("otpGen").value;
            $.ajax(
            {
                type: "POST",
                url: "ReturnItemMailVerifier",
                data: { email: email,
                	    otpGen: otpGen},
                success: function(response) 
                {
                    // OTP sent, show OTP field
                    alert("OTP has re-sent on your mail!");
                    document.getElementById("otpField").style.display = "block";
                    document.getElementById("remsg").style.display = "block";
                    document.getElementById("otpForm").style.display = "none";
                    document.getElementById("invalid").style.display = "none";
                    document.getElementById("please").style.display = "none";
                }
            });
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
                document.getElementById("otpField").style.display = "none";
                document.getElementById("confirm-item").style.display = "block";
                document.getElementById("invalid").style.display = "none";
                document.getElementById("press").style.display = "block";
                document.getElementById("remsg").style.display = "none";
                document.getElementById("please").style.display = "none";
                alert("OTP is valid press confirm..");
            } 
            else if (enteredOTP === "")
            {
            	alert("Please enter OTP!");	
            	document.getElementById("please").style.display = "block";
            	document.getElementById("invalid").style.display = "none";
                document.getElementById("remsg").style.display = "none";
            }	
            else 
            {
            	alert("OTP is invalid!");
            	document.getElementById("invalid").style.display = "block";
            	document.getElementById("remsg").style.display = "none";
            	document.getElementById("please").style.display = "none";
            }
        } 

        
      const sidebarLinks = document.querySelectorAll(".sidebar-menu a");
      const dashboardLink = document.querySelector('.sidebar-menu a[href="IssuedItemCount.jsp"]');

      // Add event listeners to each link
      sidebarLinks.forEach((link) => 
      {
        link.addEventListener("click", handleLinkClick);
      });

      // Function to handle link clicks
      function handleLinkClick(event) 
      {
        event.preventDefault();

        // Remove the active class from all links
        sidebarLinks.forEach((link) => 
        {
          link.classList.remove("active");
        });

        // Add the active class to the clicked link
        event.target.classList.add("active");

        // Navigate to the clicked link
        window.location.href = event.target.getAttribute("href");
      }

      // Set the dashboard link to be active by default
      dashboardLink.classList.add("active");
      </script> 

 </body>
</html>