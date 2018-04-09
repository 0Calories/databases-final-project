
<meta http-equiv="Cache-Control" content="no-cache" />
<%@page import="java.sql.*"%>
<%@page import="dbbeans.*"%>


<% 
	session = request.getSession(false);
   ResultSet resultSet = (ResultSet) session.getAttribute("ArrayQueryD");

if(resultSet != null){ %>

<html>
    <head><title>JDBC</title></head>
    <BODY>
        <TABLE BORDER="1">
            <TR>
		                <TH>menu.name</TH>
		                <TH>menu.price</TH>
		                <TH>loc.manager_name</TH>
		                <TH>loc.hour_open</TH>
		                <TH>rest.url</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
            <% System.out.println(resultSet.getString(1)); %>
                <TD> <%= resultSet.getString(1) %></td>
                <TD> <%= resultSet.getString(2) %></TD>
                <TD> <%= resultSet.getString(3) %></TD>
                <TD> <%= resultSet.getString(4) %></TD>
                <TD> <%= resultSet.getString(5) %></TD>
            </TR>
            <% } %>
        </TABLE>
  </body>
</html>


<%}else{
     response.sendRedirect("error.jsp");
}%>


