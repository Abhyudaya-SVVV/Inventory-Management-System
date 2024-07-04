<%@page import="Pojo.ItemDeleteDate"%>
<%@page import="Pojo.PastItemHistory"%>
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
    <link rel="stylesheet" href="CSS/past_discontinued_item_history.css">
    <title>SvvvInvento</title>
<style>
table 
{
    margin: auto;
    margin-top: 30px;
    width: 99%;
    border: 1px solid rgba(0, 0, 0, 0.166); 
    border-collapse: collapse;
    font-family: Arial, sans-serif;
  }
  tr td:nth-child(5)
  {
	  width: 30px;
  }
th, td 
{
    font-size: 17px;
    padding: 10px 13px;
    text-align: center;
    border-bottom: 1px solid #ddd;
  }
.button 
{
width: 6rem;
    height: 1.4rem;
    font-size: 14px;
    padding: 0.5em 1em;
    border: transparent;
    box-shadow: 2px 2px 4px rgba(0,0,0,0.4);
    background: #0065FF;
    color: white;
    border-radius: 4px;
   }
   
   .button:hover 
   {
    background: rgb(2,0,36);
    background: linear-gradient(90deg, #0065FF 0%, rgb(0, 140, 255) 100%);
   }
   
   .button:active 
   {
    transform: translate(0em, 0.2em);
   }
   a{
   text-decoration: none;
   font-size: 17px;
   }
</style>
</head>

<body>
     <%
         String username = (String)session.getAttribute("username");
      %>
    <div class="hero-wrapper">
        <div class="hero">
            <%@include file="SideBar.jsp"%>
            
            <div class="hero-right">
                <div class="heading">
                    <h1>Past Discontinued Item History</h1>
                  </div>
                  <div class="search-download-btn-container">
                    <div class="search-field">
                      <input type="text" placeholder="Search" name="text" class="input">
                      <button class="search-btn">Search</button>
                    </div>   
                <form action="PastItemExcelChecker" method="POST">
                     <button class="download-btn">Download Data</button>   
                </form>
                  </div>
                  <div class="table-wrapper">
                    <table>
                      <thead class="table-dark">
          <tr>
            <th scope="col">Item Name</th>
            <th scope="col">Item Company Name</th>
            <th scope="col">Item Serial Number</th>
            <th scope="col">SVVV Encoded Number</th>
            <th scope="col">Item Generation</th>
            <th scope="col">Item Delete Date</th>
            <th scope="col">Options</th>
          </tr>
        </thead>
      <% 
         Session ss = SSConnector.getSession();
         
         String hql = "FROM PastItemHistory";
         String DeleteDate = "";

         Query q = ss.createQuery(hql);
         
         List<PastItemHistory> l1 = q.list();
         
         if(l1 != null)
         {
           for(PastItemHistory p1 : l1)
           {
        	   String hql1 = "FROM ItemDeleteDate WHERE SerialNumber = '"+p1.getSerialNumber()+"'"; 
                         q = ss.createQuery(hql1);
               List<ItemDeleteDate> l = q.list();
     
               if(l != null)
               {
      	         for(ItemDeleteDate idd : l)
      	         {
      	        	DeleteDate = idd.getItemDeleteDate(); 
      	         }
               }
      %>
      <form>  
        <tbody>
            <tr>
              <td><%=p1.getItemName()%></td>
              <td><%=p1.getItemCompanyName()%></td>
              <td><%=p1.getSerialNumber()%></td>
              <td><%=p1.getSvvvNumber()%></td>
              <td><%=p1.getGeneration()%></td> 
              <td><%=DeleteDate%></td> 
              <td><a href="PastItemInfo.jsp?s=<%=p1.getSerialNumber()%>" class="button">more info..</a></td>
            </tr>
        </tbody>
      </form>
      <%  	   
           }
         }
      %>   
                    </table>
                  </div>
            </div>
        </div>


        <script>
// Get the table, input, and search button elements
const table = document.querySelector('.table-wrapper table');
const searchInput = document.querySelector('.search-field .input');
const searchBtn = document.querySelector('.search-field .search-btn');

// Add an event listener to the search button
searchBtn.addEventListener('click', handleSearch);

function handleSearch() {
  // Get the search query from the input field
  const searchQuery = searchInput.value.toLowerCase();

  // Get all the rows in the table (excluding the header row)
  const rows = table.getElementsByTagName('tr');

  // Loop through the rows and hide/show them based on the search query
  for (let i = 1; i < rows.length; i++) {
    const row = rows[i];
    let found = false;

    // Check if any cell in the row contains the search query
    for (let j = 0; j < row.cells.length; j++) {
      const cell = row.cells[j];
      if (cell.textContent.toLowerCase().includes(searchQuery)) {
        found = true;
        break;
      }
    }

    // Show the row if the search query is found, hide it otherwise
    if (found) {
      row.style.display = '';
    } else {
      row.style.display = 'none';
    }
  }
}

//Get all the links in the sidebar menu
const sidebarLinks = document.querySelectorAll(".sidebar-menu a");
const dashboardLink = document.querySelector('.sidebar-menu a[href="PastItemHistory.jsp"]');

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
</body>

</html>