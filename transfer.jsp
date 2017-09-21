
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

                <form class="form-horizontal" method="post" action="transfer.jsp">
                 <div class="modal-body">
                <div class="form-group">
                    <label for="contact-email" class="col-lg-2 control-label">Transfer<span style="color:blue;">*</span></label>
                    <div class="col-lg-10">
                    <input type="number" class="form-control" name="amount" id="contact-email" placeholder="Enter Amount" />
                    <input type="hidden" class="form-control" name="transfer" id="contact-email"  />
                    </div>
                </div>
                <div class="form-group">
                    <label for="contact-email" class="col-lg-2 control-label">Receipient A/c<span style="color:blue;">*</span></label>
                    <div class="col-lg-10">
                    <input type="email" class="form-control" name="receipient" id="contact-email" placeholder="Enter Email address" />                    
                    </div>
                </div>

                </div>
                    <div class="modal-footer">								
                    <a href="#"><input type="submit" value="Transfer "name="transfer" class="btn btn-primary pull-left" ></a> <br /> <br /> 
                    <a href="deposit.jsp" class="btn btn-info pull-left" >Deposit</a><br /> <br />
                    <a href="index.jsp" class="btn btn-info pull-left">Withdraw</a>
                    </div>

                </form>

                <%
                 Date date=new Date();
                    Timestamp timestamp=new Timestamp(date.getTime());
                   String amnt=request.getParameter("amount");
                    String rec=request.getParameter("receipient");
                   String type=new String("receiv_transfer");
                   String xxx=new String("Withdraw_transfer");                                

                    if(request.getParameter("transfer")!=null){

                  int i = Integer.parseInt(amnt);
                  //transfer charges
                  int y=50;
                   if(i>110){                                       
                       int newbal=x+i; 
                        int crbal=x-(y+i);
                        //check if the balance is greater than 110
                           if( newbal>=100 && crbal>110){
                               //if the receipient is available
                               String trans ="select * from transaction where email='"+rec+"'";
                               ResultSet rest = st.executeQuery(trans);
                                 if(rest.next()){
                                 String ididi=rest.getString("trans_id");
                                  String sespnid=(String)session.getAttribute(rest.getString("trans_id"));                                                      
                                   String cr=rest.getString("balance");
                                    String sesbal=(String)session.getAttribute(rest.getString("balance")); 
                                     String emaili=rest.getString("email");
                                    String sesemail=(String)session.getAttribute(rest.getString("email")); 
                                       int crt=Integer.parseInt(cr);
                                       int debabl=crt+i; 
                                       int charge=0;
                                        out.println(" <center>Transaction Summarize receipt</center>");out.println("<br />");
                                        out.println(" <center><a href=''>Amount Transfer</a>"+i+"</center>");out.println("<br />");
                                        out.println(" <center><a href=''>Receipient A/C </a>"+emaili+"</center>");out.println("<br />");
                                        out.println(" <center><a href=''>Sender Name</a>"+username+"</center>");out.println("<br />"); 
                                        out.println(" <center>Date of Transaction"+timestamp+"</center>");out.println("<br />");
                                        out.println(" <center>End*********Thank you</center>");out.println("<br />");
                                        //Update Receiver
                                         String sqli ="UPDATE transaction "+"SET balance="+debabl+" WHERE trans_id="+ididi+"";
                                         st.executeUpdate(sqli);
                                         //Create transaction history                                                                 
                                       st.executeUpdate("insert into trans_history(email,trans_type,amount,balance,charges,date_time)values('"+emaili+"','"+type+"','"+amnt+"','"+debabl+"','"+charge+"','"+timestamp+"')");
                                       
                                        //Update Transfer account
                                        String creditor ="UPDATE transaction "+"SET balance="+crbal+" WHERE trans_id="+idx+"";
                                        st.executeUpdate(creditor);
                                        //Create debitor transaction history                                                                 
                                       st.executeUpdate("insert into trans_history(email,trans_type,amount,balance,charges,date_time)values('"+username+"','"+xxx+"','"+amnt+"','"+crbal+"','"+y+"','"+timestamp+"')");
 
                                 }
                                else{out.println(" <center>Acoount is insufficient<a href='index.jsp'>Go Home A/C </a></center>");out.println("<br />");}
                               }
                            else{out.println(" <center>Acoount is insufficient<a href='index.jsp'>Go Home A/C </a></center>");out.println("<br />");}
                          }
                       else{out.println("Amount is insufficient<a href='index.jsp' >Go to Home</a>");out.println("<br />");}
                    }
                    out.println("<br />");
                    out.println(" <center><a href='index.jsp'>Go Home A/C </a></center>");  
                    out.println("<br />");
                    out.println(" <center><a href='logout.jsp'>Logout </a></center>"); 

                
                }}}
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
        