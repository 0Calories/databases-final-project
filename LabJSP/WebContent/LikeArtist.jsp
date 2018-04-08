
<meta http-equiv="Cache-Control" content="no-cache" />
<%@page import="java.sql.*"%>
<%@page import="dbbeans.*"%>


<% session = request.getSession(false);
   String key=(String) session.getAttribute("key");

if(key !=null){%>

<jsp:useBean id="customerbean"  class="dbbeans.RestaurantBean" scope="session" />
<jsp:useBean id="likeartistbean"  class="dbbeans.LikeArtistBean" scope="session" />

<html>
    <head><title>JDBC</title></head>
    <BODY>
        <center>
            <h1>Artists Fans</h1>
            <table border=1>
                <tr>
                    <td>
                        <b>Customer</b>
                    </td>
                    <td>
                        <b>Artist</b>
                    </td>
                </tr>
                <jsp:getProperty name="likeartistbean" property="likeArtistList" />
            </table>
            <h3>Thank you very much
            <font color="blue">
                <jsp:getProperty name="customerbean" property="name" />
            </font> por su visita
            </h3>
            <a href="closesession.jsp">Log Out</a>
        </center>
  </body>
</html>


<%}else{
     response.sendRedirect("error.jsp");
}%>


