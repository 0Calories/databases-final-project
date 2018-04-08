<%@ page language="java" contentType="text/html;"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Restaurants And Menus queries</title>
</head>
<body>
    	<center><H1>Query Restaurants and menus</H1></center>
        
        <form action="Control" method="POST">
        	<p align="left"><i><strong>a)</strong> Display all the information about a user‐specified restaurant. That is, the user should select the name of the restaurant from a list, and the information as contained in the restaurant and location tables should then displayed on the screen.
            </i></p>
            <p align="left">Specify the restaurant:
				<select>
					<option value="volvo">Volvo</option>
					<option value="saab">Saab</option>
					<option value="mercedes">Mercedes</option>
					<option value="audi">Audi</option>
				</select>
               <input type="text" size="20" name="txtName">
            </p>
                <input type="submit" name="cmdFan" value="Become a Fan">
            </p>
        </form>
</body>
</html>