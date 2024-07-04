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
<style>
#form-container
{
  height: 60vh;
  width: 80%;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 20px;
  border: 1px solid #ddd;
  border-radius: 20px;
}
form
{
  width: 90%;
  height: 90%;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  justify-content: space-evenly;
}  
a
{
  text-decoration: none;
}
.heading h1
{
  margin-left: 340px; 
}
.button 
{
    width: 9.2rem;
    height: 2.4rem;
    font-size: 18px;
    display: flex;
    align-items: center;
    justify-content: center;
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
.form-wrapper
{
  display: flex;
  flex-direction: column;
  width: 85%;
}
marquee
{
  margin: 30px 100px;
}
</style>
</head>

<body>
    <div class="hero-wrapper">
        <div class="hero">
            
            <%@include file="SideBar.jsp"%>
            
            <div class="hero-right">
                <div class="heading">
                    <h1>Add Item using Excel Sheet</h1>

                </div>
                <div class="form-wrapper">
                <marquee behavior="scroll" direction="left" scrollamount="5" loop="infinite" style="color: red;">
                            <b>* Only Excel sheets are allow to import the data *</b>
                 </marquee>
                    <div id="form-container">
                    
                    <form action="ImportExcelChecker" method="POST" enctype="multipart/form-data">  
                    <%
                       String username = (String)session.getAttribute("username");
                       String Amsg = (String)session.getAttribute("Amsg");
                       String ANmsg = (String)session.getAttribute("ANmsg"); 
                       String ALmsg = (String)session.getAttribute("ALmsg");
                       String FEmsg = (String)session.getAttribute("FEmsg");
                       String SEmsg = (String)session.getAttribute("SEmsg");
                       
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
                       if(FEmsg != null)
                       {
                    	 out.println("<h2 style='text-align:center; color:red;'>"+FEmsg+"</h2>");
                         session1.removeAttribute("FEmsg");  
                       }
                       if(SEmsg != null)
                       {
                    	 out.println("<h2 style='text-align:center; color:red;'>"+SEmsg+"</h2>");
                         session1.removeAttribute("SEmsg");  
                       }
                     %>     
                       <label>Choose Your Excel File : </label>
                       <input type="file" name="file" required="required">
                       <label>Enter Sheet Name : </label>
                       <input type="text" name="sheet" required="required" placeholder="Enter sheet name">
                       <label>Enter File Path : </label>
                       <input type="text" name="path" required="required" placeholder="Enter file path">
                       <button style="margin-top: 20px;" >Import File</button>&nbsp;&nbsp;
                       <a class="button" href="AddItems.jsp">Back</a>  
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