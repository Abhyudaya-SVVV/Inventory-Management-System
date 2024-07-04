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
    <link rel="stylesheet" href="CSS/stock_item_count.css">
    <title>SvvvInvento</title>
    <style>
td .button 
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
   .download-btn{
    margin-right: 2rem;
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
                    <h1>Stock Item Count</h1>
                </div>
                <div class="search-download-btn-container">
                    <div class="search-field">
                        <input type="text" placeholder="Search" name="text" class="input" />
                        <button class="search-btn button" onclick={handleSearch}>Search</button>
                    </div>
              <form action="StockExcelChecker" method="POST">
                    <button class="download-btn button">Download Data</button>   
              </form>
                </div>
                <div class="table-wrapper">
                <% 
			        String username = (String)session.getAttribute("username");
			        String Dmsg = (String)session.getAttribute("Dmsg");
			        String Emsg = (String)session.getAttribute("Emsg");
			        String serial = request.getParameter("s");
			        
			        HttpSession session1 = request.getSession(true);
			        
			        if(Dmsg != null)
			        {
			          out.println("<h2 style='text-align:center; color:dodgerblue;'>"+Dmsg+"</h2>");
			          session1.removeAttribute("Dmsg");
			        }
			        
			        if(Emsg != null)
			        {
			          out.println("<h2 style='text-align:center; color:red;'>"+Emsg+"</h2>");
			          session1.removeAttribute("Emsg");
			        }
                %>
                    <table id="inventory-table" class="table table-bordered">
        <thead class="table-dark">
          <tr>
            <th scope="col">Item</th>
            <th scope="col">Item Company Name</th>
            <th scope="col">Item Serial Number</th>
            <th scope="col">SVVV Encoded Number</th>
            <th scope="col">Item Generation</th>
            <th scope="col">Options</th>
          </tr>
        </thead>
      <% 
         Session ss = SSConnector.getSession();
         
         String hql = "FROM AddItems";
         Query q = ss.createQuery(hql);
         
         List<AddItems> l1 = q.list();
         
         if(l1 != null)
         {
           for(AddItems a1 : l1)
           {
      %>
        <form>  
        <tbody>
            <tr>
              <td><%=a1.getItemName()%></td>
              <td><%=a1.getItemCompanyName()%></td>
              <td><%=a1.getSerialNumber()%></td>
              <td><%=a1.getSvvvNumber()%></td>
              <td><%=a1.getGeneration()%></td>  
              <td><a href="MoreInfo.jsp?s=<%=a1.getSerialNumber()%>" class="button">more info..</a>
                  <a href="DeleteItemConfirm.jsp?s=<%=a1.getSerialNumber()%>" class="button">Delete Item</a></td>
            </tr>
        </tbody>
      </form>
      <%  	   
           }
         }
      %>    
      </table>
                </div>
                <div class="delete-modal" style="display: none;">
                    <div class="modal-content">
                        <h2>
                            Are you sure you want to delete this "ABC123" item permanently from SvvvInvento? then insert
                            date and delete the item
                        </h2>
                        <input type="date" required />
                        <br />
                        <br />
                        <button>Delete</button>
                        <span></span>
                        <button>Cancel</button>
                    </div>
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



// Get the table, delete buttons, and delete modal elements
// const table = document.querySelector('.table-wrapper table');
const deleteBtns = document.querySelectorAll('.table-wrapper button:nth-of-type(2)');
const deleteModal = document.querySelector('.delete-modal');
const deleteInput = deleteModal.querySelector('input[type="date"]');
const deleteBtn = deleteModal.querySelector('.delete-modal button:nth-of-type(1)');
const cancelBtn = deleteModal.querySelector('.delete-modal button:nth-of-type(2)');

// Add event listeners
deleteBtns.forEach((btn) => {
  btn.addEventListener('click', showDeleteModal);
});
deleteBtn.addEventListener('click', handleDelete);
cancelBtn.addEventListener('click', hideDeleteModal);
deleteInput.addEventListener('input', toggleDeleteButton);

let selectedRow = null;

function showDeleteModal(event) {
  const row = event.target.closest('tr');
  const serialNumber = row.cells[3].textContent;
  deleteModal.querySelector('h2').textContent = `Are you sure you want to delete this  "${serialNumber}" item permanently from SvvvInvento? then insert
                            date and delete the item`;
  deleteModal.style.display = 'flex';
  deleteModal.style.justifyContent = 'center';
  deleteModal.style.alignItems = 'center';
  selectedRow = row;
}

function handleDelete() {
  if (deleteInput.value) {
    selectedRow.parentNode.removeChild(selectedRow);
    hideDeleteModal();
  }
}

function hideDeleteModal() {
  deleteModal.style.display = 'none';
  deleteInput.value = '';
  selectedRow = null;
}

function toggleDeleteButton() {
  deleteBtn.disabled = !deleteInput.value;
}









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