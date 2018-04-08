
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    	<center><H1>Query Restaurants and menus</H1></center>
        <p align="center">
          <font color="#002424" size="7">
             <u>Become a FAN</u>
          </font>
        </p>
        <p align="center">
           <font color="#002424" size="7">
               <u>From your favorite artists</u>
           </font>
        </p>
        
        <form action="Control" method="GET">
            <p align="left">Restaurant Name
               <input type="text" size="20" name="restName">
            </p>
            
            <p align="left">
                <input type="submit" name="cmdRest" value="Get Restaurant">
            </p>
        </form>

       <form action="Control" method="POST">
            <p align="left">Your name:
               <input type="text" size="20" name="txtName">
            </p>
            <p align="left">
                 <input type="radio" name="rdArtist" value="Caravaggio" checked>Caravaggio
            </p>
            <p align="left">
             <input type="radio" name="rdArtist" value="Picasso">Picasso
            </p>
            <p align="left">
               <input type="radio" name="rdArtist" value="Leonardo">Leonardo
            </p>
            <p align="left">
               <input type="radio" name="rdArtist" value="Michelangelo">Michelangelo
            </p>
            <p align="left">
              <input type="radio" name="rdArtist" value="Josefa">Josefa
            </p>
            <p align="left">
              <input type="radio" name="rdArtist" value="Hans Hofmann">Hans Hofmann
            </p>
            <p align="left">
              <input type="radio" name="rdArtist" value="John">John
            </p>

            <p align="left">
                <input type="submit" name="cmdFan" value="Become a Fan">
            </p>
        </form>
    
       <form action="ActionName" method="POST">
       		<input type="submit" value="Login"/>
       </form>
    </body>
</html>
