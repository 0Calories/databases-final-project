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
    	<center><H1>Query Raters and their Ratings</H1></center>
        
        <p align="left"><i><strong>k)</strong>Find the names, join‐date and reputations of the raters that give the highest overall rating, in terms of the Food and the Mood of restaurants. Display this information together with the names of the restaurant and the dates the ratings were done.
        </i></p>
            
        <!-- ========= QUERY K) ========= -->
        <%
	        DataAccess db = new DataAccess();
			db.openConnection();
        	Connection connection = db.getConnection();
        	Statement statement = connection.createStatement();
        	String queryK = "SELECT R.name, R.join_date, R.reputation, Rest.name, Rate.rating_date FROM Rater R, Restaurant Rest, Rating Rate WHERE R.user_id IN (SELECT R1.user_id FROM Rater R1 GROUP BY R1.user_id HAVING (SELECT AVG(Rate1.mood + Rate1.food) FROM Rating Rate1 WHERE Rate1.user_id = R1.user_id)>= ALL(SELECT AVG(Rate2.mood + Rate2.food) FROM Rating Rate2, Rater R2 WHERE Rate2.user_id = R2.user_id GROUP BY R2.user_id))AND Rate.user_id = R.user_id AND Rate.restaurant_id = Rest.restaurant_id";
        	ResultSet resultSet = statement.executeQuery(queryK);
        %>
        
        <TABLE BORDER="1">
            <TR>
                <TH>name</TH>
                <TH>join_date</TH>
                <TH>reputation</TH>
                <TH>restaurant_name</TH>
                <TH>rating_date</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
                <TD> <%= resultSet.getString(1) %></td>
                <TD> <%= resultSet.getString(2) %></TD>
                <TD> <%= resultSet.getString(3) %></TD>
                <TD> <%= resultSet.getString(4) %></TD>
                <TD> <%= resultSet.getString(5) %></TD>
            </TR>
            <% } %>
        </TABLE>
        
        <p align="left"><i><strong>l)</strong>Find the names and reputations of the raters that give the highest overall rating, in terms of the Food or the Mood of restaurants. Display this information together with the names of the restaurant and the dates the ratings were done.
        </i></p>
            
        <!-- ========= QUERY L) ========= -->
        <%
	        db = new DataAccess();
			db.openConnection();
        	connection = db.getConnection();
        	statement = connection.createStatement();
        	String queryL = "SELECT R.name, R.reputation, Rest.name, Rate.rating_date FROM Rater R, Restaurant Rest, Rating Rate WHERE R.user_id IN (SELECT R1.user_id FROM Rater R1 WHERE (SELECT AVG(mood) FROM Rating Rate1 WHERE Rate1.user_id = R1.user_id) >= ALL(SELECT AVG(mood) FROM Rating Rate1 GROUP BY Rate1.user_id) OR (SELECT AVG(food) FROM Rating Rate1 WHERE Rate1.user_id = R1.user_id) >= ALL(SELECT AVG(food) FROM Rating Rate1 GROUP BY Rate1.user_id)) AND Rate.user_id = R.user_id AND Rate.restaurant_id = Rest.restaurant_id";
        	resultSet = statement.executeQuery(queryL);
        %>
        
        <TABLE BORDER="1">
            <TR>
                <TH>name</TH>
                <TH>reputation</TH>
                <TH>restaurant_name</TH>
                <TH>rating_date</TH>
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
        
        <!-- ========= QUERY M) ========= -->
        <p align="left"><i><strong>m)</strong>Find the names and reputations of the raters that rated a specific restaurant (say Restaurant Z) the most frequently. Display this information together with their comments and the names and prices of the menu items they discuss. 
        </i></p>
        
        <form action="RestaurantRatingsController" method="GET">
        	
            <p>Enter Restaurant ID <input type="text" size="20" name="restaurantID"></p>
            <p><input type="submit" name="cmdM" value="Get Raters"></p>
            
        </form>
        
        <!-- ========= QUERY N) ========= -->
        <p align="left"><i><strong>n)</strong>Find the names and emails of all raters who gave ratings that are lower than that of a rater with a name called John, in terms of the combined rating of Price, Food, Mood and Staff.
        </i></p>
        
        <form action="RestaurantRatingsController" method="GET">
        	
            <p>Enter Rater Name <input type="text" size="20" name="raterName"></p>
            <p><input type="submit" name="cmdN" value="Get Raters"></p>
            
        </form>
        
        <!-- ========= QUERY O) ========= -->
        <p align="left"><i><strong>o)</strong>Find the names, types and emails of the raters that provide the most diverse ratings. Display this information together with the restaurants names and the ratings. For example, Jane Doe may have rated the Food at the Imperial Palace restaurant as a 1 on 1 January 2015, as a 5 on 15 January 2015, and a 3 on 4 February 2015. Clearly, she changes her mind quite often.
        </i></p>
        <%
	        db = new DataAccess();
			db.openConnection();
        	connection = db.getConnection();
        	statement = connection.createStatement();
        	String queryO = "SELECT  R.name ,R.type , R.email, Res.name, Ra.price , Ra.food, Ra.mood, Ra.staff, Ra.comments FROM Rater R, Rating Ra, Restaurant Res WHERE R.user_id = Ra.user_id AND Ra.restaurant_id = Res.restaurant_id AND R.user_id = any (SELECT jende.uid FROM (SELECT R.user_id uid, Ra.restaurant_id, COUNT(*) AS cnt FROM Rater R , Rating Ra WHERE R.user_id = Ra.user_id GROUP BY Ra.restaurant_id , Ra.user_id , R.user_id HAVING  COUNT(*)  > 2 ORDER BY cnt DESC, Ra.restaurant_id) AS jende ) ORDER BY R.name, Res.name";
        	resultSet = statement.executeQuery(queryO);
        %>
        
        <TABLE BORDER="1">
            <TR>
                <TH>name</TH>
                <TH>type</TH>
                <TH>email</TH>
                <TH>name</TH>
                <TH>price</TH>
                <TH>food</TH>
                <TH>mood</TH>
                <TH>staff</TH>
                <TH>comments</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
                <TD> <%= resultSet.getString(1) %></td>
                <TD> <%= resultSet.getString(2) %></TD>
                <TD> <%= resultSet.getString(3) %></TD>
                <TD> <%= resultSet.getString(4) %></TD>
                <TD> <%= resultSet.getString(5) %></TD>
                <TD> <%= resultSet.getString(6) %></TD>
                <TD> <%= resultSet.getString(7) %></TD>
                <TD> <%= resultSet.getString(8) %></TD>
                <TD> <%= resultSet.getString(9) %></TD>
            </TR>
            <% } %>
        </TABLE>
  
</body>
</html>