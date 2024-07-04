<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/OrgGlobal.css">
    <link rel="stylesheet" href="CSS/AddItems.css">
    <title>SvvvInvento</title>   
</head>
<body>
    <div class="hero-wrapper">
        <div class="hero">
            
            <%@include file="SideBar.jsp"%>
            
            <div class="hero-right">
                <div class="heading">
                    <h1>Add Item</h1>
                  
                    <%--<form action="ImportExcel.jsp">  
                         <button type="submit" id="add-detail-btn">Import Excel File</button>
                    </form>--%>
                    
                </div>
                <div class="form-wrapper">
                    <div id="form-container">
                    
                    <form class="form" action="AddItemChecker" method="POST">
                    <%
                       String username = (String)session.getAttribute("username");
                       String Amsg = (String)session.getAttribute("Amsg");
                       String ANmsg = (String)session.getAttribute("ANmsg"); 
                       String ALmsg = (String)session.getAttribute("ALmsg");
                       String PSTmsg = (String)session.getAttribute("PSTmsg");
                       
                       HttpSession session1 = request.getSession(true);
                       
                       if(Amsg != null)
                       {
                         out.println("<h2 style='text-align:center; color:dodgerblue;'>"+Amsg+"</h2>");
                         session1.removeAttribute("Amsg");
                       }
            
                       if(ANmsg != null)
                       {
                         out.println("<h2 style='text-align:center; color:red;'>"+ANmsg+"</h2>");
                         session1.removeAttribute("ANmsg");
                       }
            
                       if(ALmsg != null)
                       {
                         out.println("<h2 style='text-align:center; color:red;'>"+ALmsg+"</h2>");
                         session1.removeAttribute("ALmsg");
                       }
                       
                       if(PSTmsg != null)
                       {
                         out.println("<h2 style='text-align:center; color:red;'>"+PSTmsg+"</h2>");
                         session1.removeAttribute("PSTmsg");
                       }
                    %>
                        <label for="password">Item Name:</label>
                        <input type="text" id="itemname" name="ItemName" placeholder="Enter Item Name" required>
                        
                        <label for="password">Item Company Name:</label>
                        <input type="text" id="itemcompanyname" name="ItemCompanyName" placeholder="Enter Item Company Name" required>
                        
                        <label for="password">Item Serial Number:</label>
                        <input type="text" id="itemserialno." name="SerialNumber" placeholder="Enter Item Serial Number" required>
                        
                        <label for="password">Item Svvv Number:</label>
                        <input type="text" id="itemsvvvno." name="SvvvNumber" placeholder="Enter Item SVVV Number" required>
                        
                        <label for="password">Item Generation:</label>
                        <input type="text" id="gen" name="Gen" placeholder="Enter Item Generation" required>
                        
                        <label for="password" class="date">Issue Date:</label>
                        <input type="date" id="issuedate" name="IssueDate" placeholder="Enter Issue Date" required>
                        
                        <label for="name">Admin Name:</label>
                        <input type="text" id="name" name="AdminName" placeholder="Enter Admin Name" required>
                        
                        <label for="phoneNumber">Admin Contact Number:</label>
                        <input type="number" id="phoneNumber" name="AdminContact" placeholder="Enter Admin Contact Number" required>
                        
                        <label for="details">Admin Email:</label>
                        <input type="email" id="email" name="AdminEmail"placeholder="Enter Admin Email Id"  required>
                        
                        <label for="password">Admin Department name:</label>
                        <input type="text" id="facultydepartmentname" name="AdminDeptName" placeholder="Enter Admin Department Name" required>
                        
                        <label for="password">Admin Branch Name:</label>
                        <input type="text" id="facultybranchname" name="AdminBranchName" placeholder="Enter Admin Branch Name" required>
                        
                        <label for="password">Admin Institute Name:</label>
                        <input type="text" id="facultyinstitutename" name="AdminInstituteName" placeholder="Enter Admin Institute Name" required>
                        <br>
                        
                        <button type="submit" id="add-detail-btn">Add</button>
                        
                       </form> 
                    </div>
                </div>
            </div>
        </div>


<script>
//Get all the links in the sidebar menu
const sidebarLinks = document.querySelectorAll(".sidebar-menu a");
const dashboardLink = document.querySelector('.sidebar-menu a[href="AddItems.jsp"]');

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