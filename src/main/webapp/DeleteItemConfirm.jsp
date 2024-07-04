<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/OrgGlobal.css">
    <link rel="stylesheet" href="CSS/DeleteItemConfirm.css">
    <title>SvvvInvento</title>  
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
                <div class="heading">
                <h1>Delete Item</h1>
                </div>
                <div class="form-wrapper">
                    <div id="form-container">
                    
						 <form action="DeleteItemChecker" method="POST">
						    <input type="hidden" name="serial" value="<%=serial%>">
						       
						       <label class="label" for="message">Item Delete Date</label>
						       <input id="message" type="date" style="width: 70%;"  name="ItemDeleteDate" required="required">
						       <button type="submit" class="submit-btn">Delete</button>
						       <a class="button" href="StockCountList.jsp">Back</a>
						 </form>
                </div>
               </div> 
            </div>
        </div>
      </div>
<script>
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
</body>
</html>