 <meta http-equiv="Cache-Control" content="no-cache" />


 
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<html>
    <head>
        <title>Add and Delete</title>
    </head>
    <body>
        <center><H1>Choose an option</H1></center>
        <div style = "float : left; width: 50%; overflow: hidden;">
	       	<h2>Add Restaurant</h2>
	        <form action="ActionName" method="POST">
	            <p>Restaurant Name
	               <input type="text" size="20" name="restaurantName">
	            </p>
	            <p>Restaurant Type
	               <input type="text" size="20" name="restaurantType">
	            </p>
	            <p>Restaurant URL
	               <input type="text" size="20" name="restaurantURL">
	            </p>
	            
	            <p align="left">
	                <input type="submit" name="cmdRest" value="Add Restaurant">
	            </p>
	        </form>
        </div>
        <div style = "overflow: hidden; padding-right: 10%">
        	<h2>Add Rater</h2>
	        <form action="ActionName" method="POST">
	            <p>Rater Name
	               <input type="text" size="20" name="raterName">
	            </p>
	            <p>Rater Type
	               <input type="text" size="20" name="raterType">
	            </p>
	            <p>Rater Email
	               <input type="text" size="20" name="raterEmail">
	            </p>
	            <p>Rater Join Date (yyyy-mm-dd)
	               <input type="text" size="20" name="raterJoinDate">
	            </p>
	            <p>Rater Reputation (1-5)
	               <input type="number" name="raterReputation" min="1" max="5">
	            </p>
	            
	            <p>
	                <input type="submit" name="cmdRest" value="Add Rater">
	            </p>
	        </form>
        </div>
        <div style = "overflow: hidden; padding-right: 10%">
        	<h2>Add Menu Item</h2>
	        <form action="ActionName" method="POST">
	            <p>Menu Item Name
	               <input type="text" size="20" name="menuItemName">
	            </p>
	            <p>Menu Item Type
	               <input type="text" size="20" name="menuItemType">
	            </p>
	            <p>Menu Item Category
	               <input type="text" size="20" name="menuItemCategory">
	            </p>
	            <p>Menu Item Description
	               <input type="text" size="50" name="menuItemDescription">
	            </p>
	            <p>Menu Item Price (*.dd)
	               <input type="text" size="20" name="menuItemPrice">
	            </p>
	            <p>Restaurant ID
	               <input type="text" size="20" name="menuItemRestaurantID">
	            </p>
	            <p>
	                <input type="submit" name="cmdRest" value="Add Menu Item">
	            </p>
	        </form>
        </div>
     </body>
</html>
