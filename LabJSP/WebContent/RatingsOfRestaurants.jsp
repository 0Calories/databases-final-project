<%@ page import="java.sql.*" %>


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
        
        <form action="Control" method="POST">
        	<p align="left"><i><strong>f)</strong>Find the total number of rating for each restaurant, for each rater. That is, the data should be grouped by the restaurant, the specific raters and the numeric ratings they have received.
            </i></p>
               <input type="text" size="20" name="txtName">
            </p>
                <input type="submit" name="cmdFan" value="Become a Fan">
            </p>
        </form>
</body>
</html>