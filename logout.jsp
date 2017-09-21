

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Atm</title>
    </head>
    <body>
        <h1>Logout</h1>
        <%
         session.removeAttribute("user");
        session.removeAttribute("username");
        session.removeAttribute("password");
        session.invalidate();
        response.sendRedirect("./index.html");
        %>
        
    </body>
</html>
