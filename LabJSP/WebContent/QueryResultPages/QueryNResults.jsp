
<meta http-equiv="Cache-Control" content="no-cache" />
<%@page import="java.sql.*"%>
<%@page import="dbbeans.*"%>


<% session = request.getSession(false);
   ResultSet resultSet = (ResultSet) session.getAttribute("resultSet");

if(resultSet != null){ %>

<html>
    <head><title>Query M Results</title></head>
    <BODY>
        <TABLE BORDER="1">
            <TR>
                <TH>name</TH>
                <TH>email</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
                <TD> <%= resultSet.getString(1) %></td>
                <TD> <%= resultSet.getString(2) %></td>
            </TR>
            <% } %>
        </TABLE>
  </body>
</html>


<%}else{
     response.sendRedirect("error.jsp");
}%>


