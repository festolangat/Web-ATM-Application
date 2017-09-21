

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*;" %>

<%
 Connection con=null;
Statement st=null;
PreparedStatement pstatement=null;
String host_name = "localhost"; //server connection
String port = "3306"; //database port
String db_username = "root"; //Database Username
String db_password = "root"; //Database password
String db_name = "atm"; //database name


// Remember to change the next line with your own environment 

try{

Class.forName("com.mysql.jdbc.Driver");
con = java.sql.DriverManager.getConnection("jdbc:mysql://"+host_name+":"+port+"/"+db_name+"",""+db_username+"",""+db_password+"");

}catch(ClassNotFoundException cnfex){
cnfex.printStackTrace();

} 


      
%>