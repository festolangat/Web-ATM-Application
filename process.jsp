
<%@ page import ="java.sql.*" %>
<%@page import="java.util.Date" %>

<%
    Date date=new Date();
    Timestamp timestamp=new Timestamp(date.getTime());
    String fname=request.getParameter("fname");
    String phone=request.getParameter("phone");
    String email=request.getParameter("email");   
    String password=request.getParameter("password");
    
    int non=0;
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/atm","root", "root");
    Statement st = con.createStatement();
    //ResultSet rs;
    int i = st.executeUpdate("insert into users(fname,phone,email,password,time_stamp) values ('" + fname + "','" + phone + "','" + email + "','" + password + "','" + timestamp + "')");
    
    if (i > 0) {
            session.setAttribute("username",email);
            String site = new String("./success.jsp?successfully"+email);
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", site);
    } else {
             String site = new String("./register.html?Invalid username or password");
            response.setStatus(response.SC_MOVED_TEMPORARILY);
            response.setHeader("Location", site); 
            System.out.print("Technical error occur ");
    }
%>
