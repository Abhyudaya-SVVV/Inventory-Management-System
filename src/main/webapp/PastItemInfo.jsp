<%@page import="Pojo.PastItemHistory"%>
<%@page import="Pojo.ItemDeleteDate"%>
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
  <link rel="stylesheet" href="CSS/past_discontinued_more_info.css">
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
         String serial = request.getParameter("s");
       %>
  <div class="hero-wrapper">
    <div class="hero">
      <%@include file="SideBar.jsp"%>
      
      <div class="hero-right">
        <div class="item-info-heading">
            <a href="PastItemHistory.jsp">
                <i class='bx bx-arrow-back'></i>
            </a>
            <h1>Past Discontinued Item Information</h1>
          </div>
          <div class="item-info-wrapper">
            <div class="item-info-container">
<%
      Session ss = SSConnector.getSession();
   
      String DeleteDate = "";
      String hql = "FROM PastItemHistory WHERE SerialNumber = '"+serial+"'";
      String hql1 = "FROM ItemDeleteDate WHERE SerialNumber = '"+serial+"'"; 
         
      Query q = ss.createQuery(hql1);
      List<ItemDeleteDate> l = q.list();
      
      if(l != null)
      {
	    for(ItemDeleteDate idd : l)
	    {
	      DeleteDate = idd.getItemDeleteDate(); 
	    }
      }
      
      q = ss.createQuery(hql);
      List<PastItemHistory> l1 = q.list();
      
      if(l1 != null)
      {
    	for(PastItemHistory p1 : l1)
    	{
%>
         <form action="PastItemHistory.jsp">
         
              <div class="input-group">
                <div class="input-row">
                  <label>Item Name:</label>
                  <input type="text" value="<%=p1.getItemName()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Item Company Name:</label>
                  <input type="text" value="<%=p1.getItemCompanyName()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Serial Number:</label>
                  <input type="text" value="<%=p1.getSerialNumber()%>" readonly>
                </div>
                <div class="input-row">
                  <label>SVVV Code Number:</label>
                  <input type="text" value="<%=p1.getSvvvNumber()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Item Generation :</label>
                  <input type="text" value="<%=p1.getGeneration()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Issue Date:</label>
                  <input type="date" value="<%=p1.getIssueDate()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Discard Date:</label>
                  <input type="date" value="<%=DeleteDate%>" readonly>
                </div>
                <div class="input-row">
                  <label>Admin Name:</label>
                  <input type="text" value="<%=p1.getAdminName()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Admin Email:</label>
                  <input type="email" value="<%=p1.getAdminEmail()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Admin Contact Number:</label>
                  <input type="number" value="<%=p1.getAdminContact()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Admin Department Name:</label>
                  <input type="text" value="<%=p1.getAdminDeptName()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Admin Branch Name:</label>
                  <input type="text" value="<%=p1.getAdminBranchName()%>" readonly>
                </div>
                <div class="input-row">
                  <label>Admin Institute Name:</label>
                  <input type="text" value="<%=p1.getAdminInstituteName()%>" readonly>
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
    document.addEventListener("DOMContentLoaded", function () 
    {
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
        item.addEventListener("mouseenter", function () 
        {
          this.classList.add("hover-effect");
        });
        item.addEventListener("mouseleave", function () 
        {
          this.classList.remove("hover-effect");
        });
      });
    });

  //Get all the links in the sidebar menu
  const sidebarLinks = document.querySelectorAll(".sidebar-menu a");
  const dashboardLink = document.querySelector('.sidebar-menu a[href="PastItemHistory.jsp"]');

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