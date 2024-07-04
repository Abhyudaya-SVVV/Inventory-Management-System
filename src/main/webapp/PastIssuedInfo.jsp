<%@page import="Pojo.PastIssuedHistory"%>
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
    <link rel="stylesheet" href="CSS/past_issued_info.css">
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
    <title>SvvvInvento</title>
<style>
.item-info-wrapper
{
  padding: 10px 0px;
}
.input-row label
{
    width: 11vw;
    font-size: 18px;
}
</style>    
</head>
<body>
      <%
          String username = (String)session.getAttribute("username"); 
          String stamp = request.getParameter("s");
       %> 
    <div class="hero-wrapper">
        <div class="hero">
            <%@include file="SideBar.jsp"%>
            
            <div class="hero-right">
                <div class="item-info-heading">
                    <a href="PastIssuedHistory.jsp">
                        <i class='bx bx-arrow-back'></i>
                    </a>
                    <h1>Faculty Information</h1>
                  </div>
   <%
      Session ss = SSConnector.getSession();
      
      String hql = "FROM PastIssuedHistory WHERE TimeStamp = '"+stamp+"'";
      Query q = ss.createQuery(hql);
      
      List<PastIssuedHistory> l1 = q.list();
      
      if(l1 != null)
      {
    	for(PastIssuedHistory p1 : l1)
    	{ 
   %>
      <div class="item-info-wrapper">
       <div class="item-info-container">
      <form class="contact-form row" action="PastIssuedHistory.jsp">
                      <div class="input-group">
                      
                        <div class="input-row">
                          <label>Faculty Name:</label>
                          <input type="text" readonly="readonly" value="<%=p1.getFacultyName()%>">
                        </div>
                        
                        <div class="input-row">
                          <label>Faculty Enrollment Number:</label>
                          <input type="text" value="<%=p1.getFacultyEnrollmentNumber()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Faculty Contact Number:</label>
                          <input type="number" value="<%=p1.getFacultyContact()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Faculty Email:</label>
                          <input type="email" value="<%=p1.getFacultyEmail()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Faculty Branch Name:</label>
                          <input type="text" value="<%=p1.getFacultyBranchName()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Faculty Department Name:</label>
                          <input type="text" value="<%=p1.getFacultyDeptName()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Faculty Institute Name:</label>
                          <input type="text" value="<%=p1.getFacultyInstituteName()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Issue Date:</label>
                          <input type="date" value="<%=p1.getIssueDate()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Return Date:</label>
                          <input type="date" value="<%=p1.getReturnDate()%>" readonly>
                        </div>
                        <div class="input-row">
                          <label>Time Stamp:</label>
                          <input type="text" value="<%=p1.getTimeStamp()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Item Name:</label>
                          <input type="text" value="<%=p1.getItemName()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Item Company Name:</label>
                          <input type="text" value="<%=p1.getItemCompanyName()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Item SVVV Code Number:</label>
                          <input type="text" value="<%=p1.getItemSvvvNumber()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Item Serial Number:</label>
                          <input type="text" value="<%=p1.getItemSerialNumber()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Item Generation :</label>
                          <input type="text" value="<%=p1.getGeneration()%>" readonly>
                        </div>
                        
                        <div class="input-row">
                          <label>Remark:</label>
                          <input type="text" value="<%=p1.getRemark()%>" readonly>
                        </div>
                        
                      </div>
                    </div>
                  </div>
            </div>
        </div>
</form>
   <% 		
    	}
      }
   %>        
<script>
//Get all the links in the sidebar menu
const sidebarLinks = document.querySelectorAll(".sidebar-menu a");
const dashboardLink = document.querySelector('.sidebar-menu a[href="PastIssuedHistory.jsp"]');

//Add event listeners to each link
sidebarLinks.forEach((link) => 
{
link.addEventListener("click", handleLinkClick);
});

//Function to handle link clicks
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

//Set the dashboard link to be active by default
dashboardLink.classList.add("active");
</script>         
        <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</body>

</html>