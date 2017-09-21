
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
                 <a href='deposit.jsp' >Click to Deposit</a>
                <a href="logout.jsp" class="btn btn-info pull-right" >click to Logout</a>
                </strong>
                </h4>
                </div>
                    <% 
                String sql ="select * from transaction where email='"+username+"'";
                try{
                st = con.createStatement();
                ResultSet rs = st.executeQuery(sql);
                %>

                <%
                while( rs.next() ){
                  %>
                <center><label  for="exampleInputEmail1"><span style="color:blue;">Account balance:Ksh:</span> <%=rs.getString("balance")%>/=</label></center>

                <%
                String bal=rs.getString("balance"); 
                String id=rs.getString("trans_id");
                int idx=Integer.parseInt(id);
                int x = Integer.parseInt(bal);                                
                //Minimum amount to accept withdrwal is 100 plus 10 for transaction charges
                if(x>110){
                %>

                <form class="form-horizontal" method="post" action="index.jsp">
                 <div class="modal-body">
                <div class="form-group">
                    <label for="contact-email" class="col-lg-2 control-label">Withdraw:<span style="color:blue;">*</span></label>
                    <div class="col-lg-10">
                    <input type="number" class="form-control" name="amount" id="contact-email" placeholder="Enter Amount" />
                    <input type="hidden" class="form-control" name="withdraw" id="contact-email"  />
                    </div>
                </div>

                </div>
                    <div class="modal-footer">								
                    <a href="#"><input type="submit" value="Withdraw "name="withdrawal" class="btn btn-primary pull-left" ></a> <br /> <br /> 
                    <a href="transfer.jsp" class="btn btn-info pull-left">Transfer</a><br /> <br />
                    <a href="deposit.jsp"class="btn btn-info pull-left">Deposit</a>
                    </div>

                </form>

                <%
                 Date date=new Date();
                    Timestamp timestamp=new Timestamp(date.getTime());
                   String amnt=request.getParameter("amount");
                   String type=request.getParameter("withdraw");
                    if(request.getParameter("withdrawal")!=null){

                  int i = Integer.parseInt(amnt);
                  int y=10;    

                  if(i>110){
                      int newbal=x-(i+y);
                      if(newbal>=110){                     
                     out.println(" <center>Transaction Summarize receipt</center>");out.println("<br />");
                     out.println(" <center><a href=''>Amount Withdraw:</a>"+i+"</center>");out.println("<br />");
                     out.println(" <center><a href=''>Account balance now </a>"+newbal+"</center>");out.println("<br />");
                     out.println(" <center><a href=''>Transaction charges</a>"+y+"</center>");out.println("<br />"); 
                     out.println(" <center>Date of Transaction"+timestamp+"</center>");out.println("<br />");
                     out.println(" <center>End*********Thank you</center>");out.println("<br />");
                    //Update transaction
                     String sqli ="UPDATE transaction "+"SET balance="+newbal+" WHERE trans_id="+idx+"";
                    st.executeUpdate(sqli);
                     //Create transaction history                                                                 
                   st.executeUpdate("insert into trans_history(email,trans_type,amount,balance,charges,date_time)values('"+username+"','"+type+"','"+y+"','"+amnt+"','"+newbal+"','"+timestamp+"')");
                      }
                      else{
                           out.println("Amount is insufficient<a href='deposit.jsp'>Click to Deposit</a>");out.println("<br />");
                      }
                  }
                  else{

                      out.println("amount is insufficient <a href='deposit.jsp'>Click to Deposit</a>");out.println("<br />");
                  }
                }


                   }
                  else{

                out.println("<br />");out.println("<a href='deposit.jsp' >Click to Deposit</a>"); out.println("<br />"); out.println("<a href='transfer.jsp' >Click to Transfer</a>");out.println("<br />");

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
        