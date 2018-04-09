
<meta http-equiv="Cache-Control" content="no-cache" />
<%@page import="java.sql.*"%>
<%@page import="dbbeans.*"%>


<% System.out.println("HERE");
	session = request.getSession(false);
   ResultSet resultSet = (ResultSet) session.getAttribute("ArrayQueryB");

if(resultSet != null){ %>

<html>
    <head><title>JDBC</title></head>
    <BODY>
        <TABLE BORDER="1">
            <TR>
		                <TH>item_id</TH>
		                <TH>name</TH>
		                <TH>type</TH>
		                <TH>category</TH>
		                <TH>description</TH>
		                <TH>price</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
                <TD> <%= resultSet.getString(1) %></td>
                <TD> <%= resultSet.getString(2) %></TD>
                <TD> <%= resultSet.getString(3) %></TD>
                <TD> <%= resultSet.getString(4) %></TD>
                <TD> <%= resultSet.getString(5) %></TD>
                <TD> <%= resultSet.getString(6) %></TD>
            </TR>
            <% } %>
        </TABLE>
  </body>
</html>


<%}else{
     response.sendRedirect("error.jsp");
}%>


