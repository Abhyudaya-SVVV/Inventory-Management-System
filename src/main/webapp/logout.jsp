<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SvvvInvento</title>
</head>
<body>
      <%
         response.setHeader("Cache-Control","no-store");
         String username = (String)session.getAttribute("username");
         session.invalidate();
         response.sendRedirect("login.jsp");
      %>
</body>
</html>