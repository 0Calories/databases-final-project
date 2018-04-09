<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remove</title>

</head>
<body>
	<center><H1>Choose an option</H1></center>
		<div>
	        <div>
	       	<h2>Remove Restaurant</h2>
	        <form action="ActionName" method="POST">
	            <p>Restaurant ID
	               <input type="text" size="20" name="restaurantID">
	            </p>            
	            <p>
	                <input type="submit" name="cmdRest" value="Remove Restaurant">
	            </p>
	        </form>
        </div>
        <div>
        	<h2>Remove Rater</h2>
	        <form action="ActionName" method="POST">
	            <p>Rater ID
	               <input type="text" size="20" name="raterID">
	            </p>
	            
	            <p>
	                <input type="submit" name="cmdRest" value="Remove Rater">
	            </p>
	        </form>
        </div>
        <div>
        	<h2>Remove Menu Item</h2>
	        <form action="ActionName" method="POST">
	            <p>Menu Item ID
	               <input type="text" size="20" name="menuItemID">
	            </p>
	            <p>
	                <input type="submit" name="cmdRest" value="Remove Menu Item">
	            </p>
	        </form>
        </div>
      </div>
</body>
</html>