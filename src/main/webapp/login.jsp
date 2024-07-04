<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="CSS/loginpage.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>SvvvInvento</title>
    <script src="https://kit.fontawesome.com/57eeca9c9a.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <style>
.login-page
{
    width: 100%;
    height: 95vh;
    display: flex;
    align-items: center;
    justify-content: space-between;
    background-color: #F5F6F8;
}
.login-left
{
    width: 91vw;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: space-evenly;
    flex-direction: column;
}
.login-left .welcome-heading
{
  width: 100%;
  height: 4rem;
}
.login-left .img-wrapper
{
  width: 113%;
  height: 33rem;
  display: flex;
  align-items: center;
  justify-content: center;
}
.login-right
{
    width: 40vw;
    height: 100%;
    display: flex;
    align-items: center;
    justify-content: space-evenly;
    flex-direction: column;
}
.login-container 
{
    max-width: 400px;
    height: 35rem;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #f9f9f9;
}
</style>
</head>
<body onload="generateCaptcha();">
    <%
       response.setHeader("Cache-Control","no-store");
       String Fmsg = (String)session.getAttribute("Fmsg");
       String Cmsg = (String)session.getAttribute("Cmsg");
    %>
    <div class="login-page">
        <div class="login">
          <div class="login-left">
            <div class="welcome-heading">
              <h1>Welcome To SvvvInvento</h1>
            </div>
            <div class="img-wrapper">
              <img src="assets/svvv.jpeg" alt="" />
            </div>
          </div>
          <div class="login-right">
          <%
            if(Fmsg != null)
            {
 	          out.println("<h2 style='text-align:center; color:red;'>"+Fmsg+"</h2>");
 	          session.invalidate();
            }
            if(Cmsg != null)
            {	
	          out.println("<h2 style='text-align:center; color:red;'>"+Cmsg+"</h2>");
	          session.invalidate();
            }
          %>
            <div class="login-container">
              <h2>Login</h2>
              
              <form action="LoginChecker" method="POST">
              
                <div class="form-group">
                  <label>Username:</label>
                  <input type="text" class="form-control" name="username" placeholder="Enter username" required="required"/>
                </div>
                <div class="form-group">
                  <label>Password:</label>
                  <input type="password" class="form-control" name="password" placeholder="Enter password" required="required"/>
                </div>
                
                <div>
                  <input type = "text" id="mainCaptcha" name="mainc" readonly="readonly" style="background-color: black; color: white; width: 22%; font-size: 23px; border-color: black;"/>                      
                  <button  style="padding: 2px; background-color: dodgerblue; border: 1px solid #ddd; color: white; cursor: pointer;" onclick="generateCaptcha();"><i class="fa-solid fa-rotate"></i></button>
                </div>
                <br>
                <div class="form-group">
                  <input type="text" id="txtinput" name="inputc" class="form-control" placeholder="Enter captcha"/>
                </div>
                <input type="submit" class="login-button" onclick="checkValidCaptcha();" value="Login"/>
                
              </form>
              <p class="forgot-passwd-link"><a href="ForgetPassword.jsp">Forgot Password ?</a></p>
              <span id = "error" style = "color: red;">
              <span id = "success" style = "color: green;">
            </div>
          </div>
        </div>
      </div>
<script type = "text/javascript">
             
       function generateCaptcha()
       {
         var cap = new Array('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');

         var i;

         for(i=0;i<4;i++)
         { 
           var a = cap[Math.floor(Math.random() * cap.length)];
           var b = cap[Math.floor(Math.random() * cap.length)];
           var c = cap[Math.floor(Math.random() * cap.length)];
           var d = cap[Math.floor(Math.random() * cap.length)];
         }  
          
         var code = a + b + c + d;
         document.getElementById("mainCaptcha").value = code  
       } 

       function	checkValidCaptcha()
       {
	     var s1 = removeSpaces(document.getElementById("mainCaptcha").value);
         var s2 = removeSpaces(document.getElementById("txtinput").value);
 
         if(s1 == s2)
         {
		   document.getElementById("success").innerHTML = "Form is validated successfully";
		   return true;
         } 		 
	     else
	     {
           document.getElementById("error").innerHTML = "Please enter valid Captcha";
	       return false;
         }
 	}
	   
	function removeSpaces(string)
	{
	  return string.split(' ').join("");
	}
</script>      
</body>
</html>
    