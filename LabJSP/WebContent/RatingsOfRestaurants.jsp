<%@ page import="java.sql.*" %>
<%@ page import="connection.DataAccess" %>

<%@ page language="java" contentType="text/html;"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Restaurants And Menus queries</title>
</head>
<body>
    	<center><H1>Query Ratings of Restaurants</H1></center>
        
        <p align="left"><i><strong>f)</strong>Find the total number of rating for each restaurant, for each rater. That is, the data should be grouped by the restaurant, the specific raters and the numeric ratings they have received.
            </i></p>
            
        <%
	        DataAccess db = new DataAccess();
			db.openConnection();
        	Connection connection = db.getConnection();
        	Statement statement = connection.createStatement();
        	String queryF = "SELECT Rater.user_id, Rater.name, Rating.price + Rating.Food + Rating.mood + Rating.staff as total_rating, Restaurant.restaurant_id FROM Rater INNER JOIN Rating ON Rater.user_id = Rating.user_id INNER JOIN Restaurant ON Restaurant.restaurant_id = Rating.restaurant_id";
        	ResultSet resultSet = statement.executeQuery(queryF);
        %>
        
        <TABLE BORDER="1">
            <TR>
                <TH>user_id</TH>
                <TH>name</TH>
                <TH>total_rating</TH>
                <TH>restaurant_id</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
                <TD> <%= resultSet.getString(1) %></td>
                <TD> <%= resultSet.getString(2) %></TD>
                <TD> <%= resultSet.getString(3) %></TD>
                <TD> <%= resultSet.getString(4) %></TD>
            </TR>
            <% } %>
        </TABLE>
        
        <form action="Control" method="POST">
        	
               <input type="text" size="20" name="txtName">
            </p>
                <input type="submit" name="cmdFan" value="Become a Fan">
            </p>
        </form>
</body>
</html>