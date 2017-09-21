
<%@page import="java.util.Date;" %>
<%@ include file="/config.jsp"%>
<!DOCTYPE html>
<html>
    <head>
       <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <title>Home</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href = "css/bootstrap.min.css" rel = "stylesheet">
        <link href = "css/style.css" rel = "stylesheet">
        <link href = "js/bootstrap.min.js" rel = "stylesheet">
    </head>
    <body>
 
 
<!---Jumbotron--->
    <div class="container">
        <div class="jumbotron">            
            <div class="modal-content">                      
                 <div class="modal-header">
                 <h4>Welcome 
                <strong><%
                String username=(String)session.getAttribute("email");  
                out.print(""+username);
                         %>
                <a href="logout.jsp" class="btn btn-info pull-right" >click to Logout</a>
                </strong>
                </h4>
                </div>
                    <% 
                String sql ="select * from transaction where email='"+username+"'";
                try{
                st = con.createStatement();
                ResultSet rs = st.executeQuery(sql);                
                while( rs.next() ){
                  %>
                <center><label  for="exampleInputEmail1"><span style="color:blue;">Account balance:Ksh:</span> <%=rs.getString("balance")%>/=</label></center>

                <%
                String bal=rs.getString("balance"); 
                String id=rs.getString("trans_id");
                int idx=Integer.parseInt(id);
                int x = Integer.parseInt(bal);                                
                //Minimum amount to accept withdrwal is 100 plus 10 for transaction charges                
                %>

                <form class="form-horizontal" method="post" action="deposit.jsp">
                 <div class="modal-body">
                <div class="form-group">
                    <label for="contact-email" class="col-lg-2 control-label">Deposit<span style="color:blue;">*</span></label>
                    <div class="col-lg-10">
                    <input type="number" class="form-control" name="amount" id="contact-email" placeholder="Enter Amount" />
                    <input type="hidden" class="form-control" name="deposit" id="contact-email"  />
                    </div>
                </div>

                </div>
                    <div class="modal-footer">								
                    <a href="#"><input type="submit" value="Deposit "name="deposit" class="btn btn-primary pull-left" ></a> <br /> <br /> 
                    <a href="transfer.jsp" class="btn btn-info pull-left" >Transfer</a><br /> <br />
                    <a href="index.jsp" class="btn btn-info pull-left">Withdraw</a>
                    </div>

                </form>

                <%
                 Date date=new Date();
                    Timestamp timestamp=new Timestamp(date.getTime());
                   String amnt=request.getParameter("amount");
                   String type=request.getParameter("deposit");
                    if(request.getParameter("deposit")!=null){
                    int i = Integer.parseInt(amnt); 
                    int charge=0;
                    int newbal=x+i;
                     out.println(" <center>Transaction Summarize receipt</center>");out.println("<br />");
                     out.println(" <center><a href=''>Amount Deposit:</a>"+i+"</center>");out.println("<br />");
                     out.println(" <center><a href=''>Transaction charges </a>"+charge+"</center>");out.println("<br />");
                     out.println(" <center><a href=''>Account New balance</a>"+newbal+"</center>");out.println("<br />"); 
                     out.println(" <center>Date of Transaction"+timestamp+"</center>");out.println("<br />");
                     out.println(" <center>End*********Thank you</center>");out.println("<br />");
                    //Update transaction
                     String sqli ="UPDATE transaction "+"SET balance="+newbal+" WHERE trans_id="+idx+"";
                     st.executeUpdate(sqli);
                     //Create transaction history                                                                 
                   st.executeUpdate("insert into trans_history(email,trans_type,amount,balance,charges,date_time)values('"+username+"','"+type+"','"+charge+"','"+amnt+"','"+newbal+"','"+timestamp+"')");
                    }
                  
                    out.println("<br />");
                    out.println(" <center><a href='index.jsp'>Go Home A/C </a></center>");  
                    out.println("<br />");
                    out.println(" <center><a href='logout.jsp'>Logout </a></center>"); 
                }}
                catch(Exception e){e.printStackTrace();}
                finally{   

                if(st!=null) st.close();
                if(con!=null) con.close();
                }

                %>
            </div>           
        </div>
    </div>
<!---End of Jumbotron--->


    <script src = "js/jquery-1.11.2.min.js"></script>
                    <script src = "js/jquery.min.js"></script>
    <script src = "js/bootstrap.js"></script>
               
  </body>
</html>
        