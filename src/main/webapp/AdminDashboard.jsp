<%@page import="java.util.Iterator"%>
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
  <link rel="stylesheet" href="CSS/navbar.css">
  <link rel="stylesheet" href="CSS/dashboard_items.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <title>SvvvInvento</title>
</head>
<body>

<%
           String username = (String)session.getAttribute("username");
           long row = 0; 
           long row2 = 0; 
           long row3 = 0;
           long row4 = 0;
           
           Session ss = SSConnector.getSession();
           
           String hql = "SELECT COUNT(*) FROM AddItems";
           String hql1 = "SELECT COUNT(*) FROM IssueItems";
           String hql2 = "SELECT COUNT(*) FROM PastIssuedHistory";
           String hql3 = "SELECT COUNT(*) FROM PastItemHistory";
           
           Query q = ss.createQuery(hql);
           
          for(Iterator it = q.iterate();it.hasNext();)
          {
       	    row = (long)it.next();  
          } 
          
          q = ss.createQuery(hql1);
          
          for(Iterator it = q.iterate();it.hasNext();)
          {
       	    row2 = (long)it.next(); 
          }
          
          long total = row + row2;
          
          q = ss.createQuery(hql2);
          
          for(Iterator it = q.iterate();it.hasNext();)
          {
        	 row3 = (long)it.next(); 
          }
          
          q = ss.createQuery(hql3);
          
          for(Iterator it = q.iterate();it.hasNext();)
          {
        	 row4 = (long)it.next(); 
          }
        %>
  <div class="hero-wrapper">
    <div class="hero">
      
      <%@include file="SideBar.jsp"%>
      <div class="hero-right">
        <div class="nav-heading">
          <h1>Welcome Back, <%=heroname%></h1>
        </div>
        <div class="items-wrapper">
          <div class="item">
            <div class="icon-container">
              <div class="icon-wrapper">
                
                <i class='bx bx-list-ul'></i>
              </div>
            </div>
            <div class="count">
              <h1><%=total%>&nbsp;Items</h1>
            </div>
            <div class="item-name">
              <p>Total Item Count</p>
            </div>
          </div>
          <div class="item">
            <div class="icon-container">
              <div class="icon-wrapper">
                <i class='bx bxs-box'></i>
              </div>
              <h6>
                <a href="StockCountList.jsp">
                  see more
                  <i class='bx bx-chevron-right'></i>
                </a>
              </h6>
            </div>
            <div class="count">
              <h1><%=row%>&nbsp;Items</h1>
            </div>
            <div class="item-name">
              <p>Stock Item Count</p>
            </div>
          </div>
          <div class="item">
            <div class="icon-container">
              <div class="icon-wrapper">
                <i class='bx bx-list-check'></i>
              </div>
              <h6>
                <a href="IssuedItemCount.jsp">
                  see more
                  <i class='bx bx-chevron-right'></i>
                </a>
              </h6>
            </div>
            <div class="count">
              <h1><%=row2%>&nbsp;Items</h1>
            </div>
            <div class="item-name">
              <p>Issued Item Count</p>
            </div>
          </div>
          <div class="item">
            <div class="icon-container">
              <div class="icon-wrapper">
                <i class='bx bx-history'></i>
              </div>
              <h6>
                <a href="PastIssuedHistory.jsp">
                  see more
                  <i class='bx bx-chevron-right'></i>
                </a>
              </h6>
            </div>
            <div class="count">
              <h1><%=row3%>&nbsp;Items</h1>
            </div>
            <div class="item-name">
              <p>Past Issued History</p>
            </div>
          </div>
          <div class="item">
            <div class="icon-container">
              <div class="icon-wrapper">
                <i class='bx bxs-message-alt-x'></i>
              </div>
              <h6>
                <a href="PastItemHistory.jsp">
                  see more
                  <i class='bx bx-chevron-right'></i>
                </a>
              </h6>
            </div>
            <div class="count">
              <h1><%=row4%>&nbsp;Items</h1>
            </div>
            <div class="item-name">
              <p>Past Discontinued Item History</p>
            </div>
          </div>
          <div class="item">
            <div class="icon-container">
              <div class="icon-wrapper">
                <i class='bx bx-food-menu'></i>
              </div>
              <h6>
                <a href="IssueItemsForm.jsp">
                  see more
                  <i class='bx bx-chevron-right'></i>
                </a>
              </h6>
            </div>
            <div class="count">
              <h1>Form</h1>
            </div>
            <div class="item-name">
              <p>Issue Items To Faculty</p>
            </div>
          </div>
          <div class="item">
            <div class="icon-container">
              <div class="icon-wrapper">
                <i class='bx bxs-message-alt-add'></i>
              </div>
              <h6>
                <a href="AddItems.jsp">
                  see more
                  <i class='bx bx-chevron-right'></i>
                </a>
              </h6>
            </div>
            <div class="count">
              <h1>Form</h1>
            </div>
            <div class="item-name">
              <p>Add Item</p>
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
    



    function toggleLinkActive(event) 
    {
  // Get all the links with the 'hover' ID
  const hoverLinks = document.querySelectorAll('#hover');

  // Remove the active state from all links
  hoverLinks.forEach((link) => 
  {
    link.style.backgroundColor = '';
    link.style.color = '';
  });

  // Add the active state to the clicked link
  event.target.style.backgroundColor = '#007bff';
  event.target.style.color = '#fff';
}

  //Get all the links in the sidebar menu
  const sidebarLinks = document.querySelectorAll(".sidebar-menu a");
  const dashboardLink = document.querySelector('.sidebar-menu a[href="AdminDashboard.jsp"]');

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