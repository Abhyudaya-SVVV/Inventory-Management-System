<%@page import="Pojo.AdminDetails"%>
<%@page import="java.util.List"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="SessionDB.SSConnector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="CSS/OrgGlobal.css">
  <link rel="stylesheet" href="CSS/navbar.css">
  <link rel="stylesheet" href="CSS/dashboard_items.css">
  <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
  <title>SvvvInvento</title>
<style>
.sidebar 
{
  width: 18vw;
  background-color: #ffffff;
  height: 94%;
  position: relative;
  padding: 20px;
  box-sizing: border-box;
  border-right: 1px solid #ddd;
}      
</style>  
</head>

<body>
      <%
         response.setHeader("Cache-Control","no-store");
         
         String heroname = null;
         String username1 = (String)session.getAttribute("username");
         
         if(username1 == null || username1.equals(""))
         {
           response.sendRedirect("login.jsp");	 
         }
         
         Session ss1 = SSConnector.getSession();
         
         String hql5 = "FROM AdminDetails WHERE AdminEnrollmentNumber = '"+username1+"'";
         Query q5 = ss1.createQuery(hql5);
         
         List<AdminDetails> l11 = q5.list();
         
         if(l11 != null)
         {
            for(AdminDetails a1 : l11)
            {
              heroname = a1.getAdminName();
            }
         }
      %>
      <div class="hero-left">
        <div class="sidebar">
          <div class="sidebar-header">
            <img src="assets/logo.jpg" alt="">
            <h2>SvvvInvento</h2>
          </div>
          <div class="sidebar-menu">
            <ul>
              <li>
                <a href="AdminDashboard.jsp" id="hover">Dashboard</a>
              </li>
              <li>
                <a href="StockCountList.jsp" id="hover">Stock Item Count</a>
              </li>
              <li>
                <a href="IssuedItemCount.jsp" id="hover">Issued Item Count</a>
              </li>
              <li>
                <a href="PastIssuedHistory.jsp" id="hover">Past Issued History</a>
              </li>
              <li>
                <a href="PastItemHistory.jsp" id="hover">Past Discontinued Item History</a>
              </li>
              <li>
                <a href="IssueItemsForm.jsp" id="hover">Issue Item Form</a>
              </li>
              <li>
                <a href="AddItems.jsp" id="hover">Add Item</a>
              </li>
            </ul>
          </div>
          <div class="sidebar-profile">
            <div class="profile-section">
              <img src="assets/iconinvento.jpeg" alt="Profile">
              <span><%=heroname%></span>
              <div class="profile-dropdown">
                <ul>
                  <li>
                    <a href="logout.jsp">logout</a>
                  </li>
                  <li>
                    <a href="AboutUs.jsp">About Us</a>
                  </li>
                  <li>
                    <a href="#">Support</a>
                  </li>
                  <li>
                    <a href="ChangePassword.jsp">Change Password</a>
                  </li>
                  <li>
                    <a href="EditProfile.jsp">Admin Profile</a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>            