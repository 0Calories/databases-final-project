
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    	<center><H1>Databases Final Project</H1></center>
    	<center><H3>Presented By Ashwin Anand, Quang-Tri Do, and Taewan Kang</H3></center>
        
        <!-- 
        <form action="Control" method="GET">
            <p align="left">Restaurant Name
               <input type="text" size="20" name="restaurantInfo">
            </p>
            
            <p align="left">
                <input type="submit" name="cmdRest" value="Get Restaurant">
            </p>
        </form>
        
         -->
        </br>
        </br>
        </br>
        </br>
        </br>
        </br>
        </br>
        </br>
        </br>
        </br>
        </br>
        </br>
        
        <center>
		<input type="button" value="Restaurants and Menus Queries" onclick="openPage('RestaurantsAndMenus.jsp')" />
		<input type="button" value="Ratings of Restaurants Queries" onclick="openPage('RatingsOfRestaurants.jsp')" />
		
	    <input type="button" value="Add to DB" name="Add Restaurants" onclick="openPage('AddRestaurant.jsp')" />
	    <input type="button" value="Remove from DB" name="Add Restaurants" onclick="openPage('Remove.jsp')" />
	   	</center>
	   	
   		<script type="text/javascript">
		 function openPage(pageURL)
		 {
		 	window.location.href = pageURL;
		 }
		</script>
    </body>
</html>