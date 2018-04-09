<%@ page import="java.sql.*" %>
<%@ page import="connection.DataAccess" %>

<%@ page language="java" contentType="text/html;"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Restaurants And Menus Queries</title>
</head>
<body>
    	<center><H1>Query Ratings of Restaurants</H1></center>
        
        <p align="left"><i><strong>f)</strong>Find the total number of rating for each restaurant, for each rater. That is, the data should be grouped by the restaurant, the specific raters and the numeric ratings they have received.
            </i></p>
            
        <!-- ========= QUERY F) ========= -->
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
        
        <!-- ========= QUERY G) ========= -->
        <%
        	String queryG = "SELECT Restaurant.name, Restaurant.type, Location.phone_number " +
        					"FROM Restaurant, Location " +
        					"WHERE Restaurant.restaurant_id = Location.restaurant_id AND Restaurant.restaurant_id NOT IN " +
        					"    (SELECT Rating.restaurant_id " +
        					"    FROM Rating " +
        					"    WHERE Rating.rating_date BETWEEN'2015/01/01' AND '2015/01/31')";
        	resultSet = statement.executeQuery(queryG);
        %>
        
        <p align="left"><i><strong>g)</strong>Display the details of the restaurants that have not been rated in January 2015. That is, you should display the name of the restaurant together with the phone number and the type of food.
        </i></p>
        
        <TABLE BORDER="1">
            <TR>
                <TH>name</TH>
                <TH>type</TH>
                <TH>phone_number</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
                <TD> <%= resultSet.getString(1) %></td>
                <TD> <%= resultSet.getString(2) %></TD>
                <TD> <%= resultSet.getString(3) %></TD>
            </TR>
            <% } %>
        </TABLE>
        
        <!-- ========= QUERY H) ========= -->        
        <p align="left"><i><strong>h)</strong>Find the names and opening dates of the restaurants that obtained Staff rating that is lower than any rating given by rater X. Order your results by the dates of the ratings. (Here, X refers to any rater of your choice.)
        </i></p>
        
        <form action="RestaurantRatingsController" method="GET">
        	
            <p>Enter User ID <input type="text" size="20" name="userID"></p>
            <p><input type="submit" name="cmdH" value="Get Restaurant Data"></p>
            
        </form>
        
        
        <!-- ========= QUERY I) ========= -->   
        <p align="left"><i><strong>h)</strong>List the details of the Type Y restaurants that obtained the highest Food rating. Display the restaurant name together with the name(s) of the rater(s) who gave these ratings. (Here, Type Y refers to any restaurant type of your choice, e.g. Indian or Burger.)
        </i></p>  
        <form action="RestaurantRatingsController" method="GET">
        	
            <p>Enter Restaurant Type <input type="text" size="20" name="restaurantType"></p>
            <p><input type="submit" name="cmdI" value="Get Restaurant Data"></p>
            
        </form>        
        
        <!-- ========= QUERY J) ========= -->     
        <p align="left"><i><strong>j)</strong>Provide a query to determine whether Type Y restaurants are “more popular” than other restaurants. (Here, Type Y refers to any restaurant type of your choice, e.g. Indian or Burger.) 
        </i></p>
        <form action="RestaurantRatingsController" method="GET">
        	
            <p><input type="text" size="20" name="restaurantType"></p>
            <p><input type="submit" name="cmdJ" value="Get Restaurant Type Popularity"></p>
            
        </form>
</body>
</html>