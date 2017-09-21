

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Success</title>
    </head>
    <body>
       
<%@ page import ="java.sql.*" %>
<%@page import="java.util.Date" %>
<%    String user=(String)session.getAttribute("username");
         
%>
<%
   
    Date date=new Date();
    Timestamp timestamp=new Timestamp(date.getTime());                   
    int non=0;
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/atm","root", "root");
    Statement st = con.createStatement();
    //ResultSet rs;
    int i = st.executeUpdate("insert into transaction(email,balance,date_time) values ('" +user+ "','" + non + "','" + timestamp + "')");
    
    if (i > 0) {
             
            String site = new String("./logout.jsp?Login successfully"+user);
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", site);
    } else {
             String site = new String("./register.html?Invalid username or password");
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", site); 
            System.out.print("Technical error occur ");
    }
%>

    </body>
</html>
