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
    <link rel="stylesheet" href="CSS/issued_item_count.css">
    <title>SvvvInvento</title>
<style>
.button 
{
width: 6rem;
    height: 1.4rem;
    font-size: 18px;
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
   font-size: 16px;
   }
</style>
</head>

<body>
    <div class="hero-wrapper">
        <div class="hero">
            
            <%@include file="SideBar.jsp"%>
            
            <div class="hero-right">
                <div class="heading">
                    <h1>Issued Item Count</h1>
                  </div>
                  <div class="search-download-btn-container">
                    <div class="search-field">
                      <input type="text" placeholder="Search" name="text" class="input">
                      <button class="search-btn">Search</button>
                    </div>
                   <form action="IssuedExcelChecker" method="POST">
                       <button class="download-btn">Download Data</button>   
                  </form>
                  </div>
                  <div class="table-wrapper">
                  <%
			         String username = (String)session.getAttribute("username");
			         String Rmsg = (String)session.getAttribute("Rmsg");
			         String RNmsg = (String)session.getAttribute("RNmsg");
			         
			         HttpSession session1 = request.getSession(true);
			         
			         if(Rmsg != null)
			         {
			           out.println("<h2 style='text-align:center; color:dodgerblue;'>"+Rmsg+"</h2>");
			           session1.removeAttribute("Rmsg");
			         }
			         
			         if(RNmsg != null)
			         {
			           out.println("<h2 style='text-align:center; color:red;'>"+RNmsg+"</h2>");	
			           session1.removeAttribute("RNmsg");
			         }
			      %>
                    <table>
                      <thead>
                        <tr>
                          <th>Faculty Name</th>
                          <th>Item Serial No.</th>
                          <th>SVVV Encoded No</th>
                          <th>Item Generation</th>
                          <th>Action</th>
                        </tr>
                      </thead>
     <%
         Session ss = SSConnector.getSession();
         
         String hql = "FROM IssueItems";
         Query q = ss.createQuery(hql);
         
         List<IssueItems> l1 = q.list();
         
         if(l1 != null)
         {
           for(IssueItems ii : l1)
           {
      %>
         <form>  
        <tbody>
            <tr>
              <td><%=ii.getFacultyName()%></td>
              <td><%=ii.getItemSerialNumber()%></td>
              <td><%=ii.getItemSvvvNumber()%></td>
              <td><%=ii.getGeneration()%></td>
              <td><a href="IssuedMoreInfo.jsp?s=<%=ii.getItemSerialNumber()%>" class="button">more info..</a>
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

function handleSearch() 
{
  // Get the search query from the input field
  const searchQuery = searchInput.value.toLowerCase();

  // Get all the rows in the table (excluding the header row)
  const rows = table.getElementsByTagName('tr');

  // Loop through the rows and hide/show them based on the search query
  for (let i = 1; i < rows.length; i++) 
  {
    const row = rows[i];
    let found = false;

    // Check if any cell in the row contains the search query
    for (let j = 0; j < row.cells.length; j++) 
    {
      const cell = row.cells[j];
      if (cell.textContent.toLowerCase().includes(searchQuery)) 
      {
        found = true;
        break;
      }
    }

    // Show the row if the search query is found, hide it otherwise
    if (found) 
    {
      row.style.display = '';
    } else {
      row.style.display = 'none';
    }
  }
}

// // Get all the links in the sidebar menu
// const sidebarLinks = document.querySelectorAll('.sidebar-menu a');

// // Add event listeners to each link
// sidebarLinks.forEach((link) => {
//   link.addEventListener('click', handleLinkClick);
// });

// // Function to handle link clicks
// function handleLinkClick(event) {
//   // Remove the active class from all links
//   sidebarLinks.forEach((link) => {
//     link.classList.remove('active');
//   });

//   // Add the active class to the clicked link
//   event.target.classList.add('active');
// }

//Get all the links in the sidebar menu
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