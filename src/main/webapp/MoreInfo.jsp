<%@page import="Pojo.AddItems"%>
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
  <link rel="stylesheet" href="CSS/StockItemInfo.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <title>SvvvInvento</title>
<style>
.item-info-container label
{
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
          <a href="StockCountList.jsp">
            <i class='bx bx-arrow-back'></i>
          </a>
          <h1>Stock Item Information</h1>
        </div>
         <%
            Session ss = SSConnector.getSession();
      
            String hql = "FROM AddItems WHERE SerialNumber = '"+serial+"'";
            Query q = ss.createQuery(hql);
      
            List<AddItems> l1 = q.list();
      
            if(l1 != null)
            {
    	      for(AddItems a1 : l1)
    	      {
          %>  
           <div class="item-info-wrapper">
           <div class="item-info-container">
            <div class="input-group">
             <form action="StockCountList.jsp">
             
             <div class="input-row">
                <label>Item Name:</label>
                <input type="text" value="<%=a1.getItemName()%>" readonly >
              </div>
              <div class="input-row">
                <label>Item Company Name:</label>
                <input type="text" value="<%=a1.getItemCompanyName()%>" readonly>
              </div>
              <div class="input-row">
                <label>Serial Number:</label>
                <input type="text" value="<%=a1.getSerialNumber()%>" readonly>
              </div>
              <div class="input-row">
                <label>SVVV Code Number:</label>
                <input type="text" value="<%=a1.getSvvvNumber()%>" readonly>
              </div>
              <div class="input-row">
                <label>Item Generation :</label>
                <input type="text" value="<%=a1.getGeneration()%>" readonly>
              </div>
              <div class="input-row">
                <label>Issue Date:</label>
                <input type="date" value="<%=a1.getIssueDate()%>" readonly>
              </div>
              <div class="input-row">
                <label>Admin Name:</label>
                <input type="text" value="<%=a1.getAdminName()%>" readonly>
              </div>
              <div class="input-row">
                <label>Admin Email:</label>
                <input type="email" value="<%=a1.getAdminEmail()%>" readonly>
              </div>
              <div class="input-row">
                <label>Admin Contact Number:</label>
                <input type="number"  value="<%=a1.getAdminContact()%>" readonly>
              </div>
              <div class="input-row">
                <label>Admin Department Name:</label>
                <input type="text" value="<%=a1.getAdminDeptName()%>" readonly>
              </div>
              <div class="input-row">
                <label>Admin Branch Name:</label>
                <input type="text" value="<%=a1.getAdminBranchName()%>" readonly>
              </div>
              <div class="input-row">
                <label>Admin Institute Name:</label>
                <input type="text" value="<%=a1.getAdminInstituteName()%>" readonly>
             
              </div>
             </form> 
   <% 		
    	}
      }
   %>             
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>


  <script>
    // sidebar.js
    document.addEventListener("DOMContentLoaded", function () {
      // Logic to handle active links
      const links = document.querySelectorAll(".sidebar-menu a");
      links.forEach(a => {
        if (link.href === window.location.href) {
          link.classList.add("active");
        }
      });

      // Logic to handle hover effect
      const hoverItems = document.querySelectorAll("#hover");
      hoverItems.forEach(item => {
        item.addEventListener("mouseenter", function () {
          this.classList.add("hover-effect");
        });
        item.addEventListener("mouseleave", function () {
          this.classList.remove("hover-effect");
        });
      });
    });

  //Get all the links in the sidebar menu
  const sidebarLinks = document.querySelectorAll(".sidebar-menu a");
  const dashboardLink = document.querySelector('.sidebar-menu a[href="StockCountList.jsp"]');

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
    <script src="https://unpkg.com/boxicons@2.1.4/dist/boxicons.js"></script>
</body>

</html>