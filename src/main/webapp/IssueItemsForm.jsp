<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/OrgGlobal.css">
    <link rel="stylesheet" href="CSS/IssuedItemsForm.css">
    <title>SvvvInvento</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
    <div class="hero-wrapper">
        <div class="hero">
            
            <%@include file="SideBar.jsp"%>
            
            <div class="hero-right">
                <div class="heading">
                    <h1>Issue Item To Faculty</h1>
                </div>
                <div class="form-wrapper">
                    <div class="form-container">
                    
                      <form class="form" action="IssueItemChecker" method="POST">
                      <%
				        String username = (String)session.getAttribute("username");
				        String Imsg = (String)session.getAttribute("Imsg");
				        String INmsg = (String)session.getAttribute("INmsg");
				        String NImsg = (String)session.getAttribute("NImsg");
				        String Ex = (String)session.getAttribute("Ex");
				        String discard = (String)session.getAttribute("discard");
				        
				        HttpSession session1 = request.getSession(true);
				        
				        if(Imsg != null)
				        {
				          out.println("<h2 style='text-align:center; color:dodgerblue;'>"+Imsg+"</h2>"); 
				          session1.removeAttribute("Imsg");
				        }
				        
				        if(NImsg != null)
				        {
				          out.println("<h2 style='text-align:center; color:red;'>"+NImsg+"</h2>");
				          session1.removeAttribute("NImsg");
				        }
				        
				        if(INmsg != null)
				        {
				          out.println("<h2 style='text-align:center; color:red;'>"+INmsg+"</h2>");
				          session1.removeAttribute("INmsg");
				        }
				        
				        if(Ex != null)
				        {
				          out.println("<h2 style='text-align:center; color:red;'>"+Ex+"</h2>");
				          session1.removeAttribute("INmsg");
				        }
				        
				        if(discard != null)
				        {
				          out.println("<h2 style='text-align:center; color:red;'>"+discard+"</h2>");
				          session1.removeAttribute("discard");
				        }
				     %>
                        <label for="name">Faculty Name:</label>
                        <input type="text" id="name" name="FacultyName" placeholder="Enter Faculty Name" required>
                        
                        <label for="program">Faculty Enrollment Number :</label>
                        <input type="text" id="enrollmentno" name="FacultyEnrollmentNumber" placeholder="Enter Faculty Enrollment Number" required>
                        
                        <label for="phoneNumber">Faculty Contact Number :</label>
                        <input type="number" id="phoneNumber" name="FacultyContact" placeholder="Enter Faculty Contact Number" required>
                        
                        <label for="details">Faculty Email:</label>
                        <input type="email" id="email" name="FacultyEmail" placeholder="Enter Faculty Email Id" required>
                        
                        <label for="password">Faculty Branch Name:</label>
                        <input type="text" id="facultybranchname" name="FacultyBranchName" placeholder="Enter Faculty Branch Name" required>
                        
                        <label for="password">Faculty Department name:</label>
                        <input type="text" id="facultydepartmentname" name="FacultyDepartmentName" placeholder="Enter Faculty Department Name" required>
                        
                        <label for="password">Faculty Institute Name:</label>
                        <input type="text" id="facultyinstitutename" name="FacultyInstituteName" placeholder="Enter Faculty Institute Name" required>
                        
                        <label for="password">Issue Date:</label>
                        <input type="date" id="issuedate" name="IssueDate" placeholder="Enter Item Issue Date" required>
                        
                        <label for="password">Return Date:</label>
                        <input type="text" id="returndate" name="ReturnDate" placeholder="Enter Item Return Date" required>
                        
                        <label for="password">Item Name:</label>
                        <input type="text" id="itemname" name="ItemName" placeholder="Enter Item Name" required>
                        
                        <label for="password">Item Company Name:</label>
                        <input type="text" id="itemcompanyname" name="ItemCompanyName" placeholder="Enter Item Company Name" required>
                        
                        <label for="password">Item Svvv Number :</label>
                        <input type="text" id="itemsvvvno." name="ItemSvvvNumber" placeholder="Enter Item SVVV Number" required>
                        
                        <label for="password">Item Serial Number :</label>
                        <input type="text" id="itemserialno." name="ItemSerialNumber" placeholder="Enter Item Serial Number" required>
                        
                        <label for="password">Item Generation :</label>
                        <input type="text" id="gen" name="Gen" placeholder="Enter Item Generation" required>
                        
                        <div id="remark" style="display:none;">
                          <label for="password">Remark:</label>
                          <input type="text" readonly style="outline: none;" id="remark" name="Remark" value="valid" required>
                        </div>
                        
                        <div id="confirm-item" style="display:none;">
                 		     <button id="confirm-item-btn">Confirm</button>
              			</div>
                       </form>
                       
                    <form id="otpForm">
                    <hr style="background-color: #ddd; border: none; height: 1px;">
                    <label style="font-size: 16px; color: red"><b>* Without mail verification you cannot issue the item directly *</b></label><br>
                       <%
                          int intOtp = (int)(Math.random()*9000)+1000;
               		      String otp = String.valueOf(intOtp);
               		      System.out.println("jsp otp"+otp);
                       %>
                       <input type="text" name="emailid" id="emailid" class="inputmail" placeholder="Enter Mail Id for OTP" required="required">
                       <input type="hidden" name="otpGen" id="otpGen" value="<%=otp%>">

                       <br>
                       <button type="button" id="issue-item-btn" onclick="sendOTP()">Issue</button>
              		</form>
              		
              		<form>
		               <div id="otpField" style="display:none;">
		               
		                 <label for="otp">Enter OTP:</label><br>
		                 <input type="text" id="otpCheck" name="otp" placeholder="Enter OTP"><br><br>
		                 
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
	                  <label for="pressconfirm" style="color:green;">Press confirm to issue the Item to faculty.</label>
	             </div>
                 
                 <div id="pleaseq" style="display:none;">
                            <label for="invalidotp" style="color:red;">Please enter OTP!</label>
                 </div>
                    </div>
                </div>

                
            </div>
        </div>

<script>
        function sendOTP() 
        {
            var emailid = document.getElementById("emailid").value;
            var otpGen = document.getElementById("otpGen").value;
            if(emailid === "")
            {
            	alert("Please enter mailid to recieve OTP!");
            }	
            else
            {
            	$.ajax(
                        {
                            type: "POST",
                            url: "IssueItemMailVerifier",
                            data: { emailid: emailid,
                            	    otpGen: otpGen},
                            success: function(response) 
                            {
                                // OTP sent, show OTP field
                                alert("OTP has sent on your mail!");
                                document.getElementById("otpField").style.display = "block";
                                document.getElementById("otpForm").style.display = "none";
                                document.getElementById("pleaseq").style.display = "none";
                            }
                        });	
            }	
        }
        
        function resendOTP()
        {
           document.getElementById("remsg").style.display = "block";
           document.getElementById("invalid").style.display = "none";
           document.getElementById("pleaseq").style.display = "none";
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
            	document.getElementById("pleaseq").style.display = "none";
            	document.getElementById("confirm-item").style.display = "block";
                document.getElementById("otpField").style.display = "none";
                document.getElementById("invalid").style.display = "none";
                document.getElementById("press").style.display = "block";
                document.getElementById("remsg").style.display = "none";
                document.getElementById("remark").style.display = "block";
                document.getElementById("send").style.display = "none";
                
            } 	
            else if (enteredOTP === "")
            {	
              alert("Please enter OTP!");
              document.getElementById("pleaseq").style.display = "block";
              document.getElementById("invalid").style.display = "none";
              document.getElementById("remsg").style.display = "none";
            }	
            else 
            {
            	alert("OTP in invalid!");
            	document.getElementById("invalid").style.display = "block";
            	document.getElementById("remsg").style.display = "none";
            	document.getElementById("pleaseq").style.display = "none";
            }
        } 
        
      //Get all the links in the sidebar menu
      const sidebarLinks = document.querySelectorAll(".sidebar-menu a");
      const dashboardLink = document.querySelector('.sidebar-menu a[href="IssueItemsForm.jsp"]');

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