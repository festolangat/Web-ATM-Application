

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@ include file="/config.jsp"%>
<%
        try{

        String username = request.getParameter("email");   
        String password = request.getParameter("password");       
        PreparedStatement pst = con.prepareStatement("Select email,password from users where email=? and password=?");
        pst.setString(1, username);
        pst.setString(2, password);
        ResultSet rs = pst.executeQuery();                        
        if(rs.next())           
           {
        session.setAttribute("email", username);      
        response.sendRedirect("./index.jsp?Welcome"+username);
    } else {
        response.sendRedirect("./index.html?Invalid password or Username try again");
       
    }            
   }
   catch(Exception e){       
        response.sendRedirect("./index.html?Something terrible wrong happen");       
   }    
%>