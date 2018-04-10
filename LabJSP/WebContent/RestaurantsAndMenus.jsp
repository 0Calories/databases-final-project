<%@ page language="java" contentType="text/html;"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
String [] allRestaurants = new String[999];
String [] allRestaurantTypes = new String[999];

connection.DataAccess db = new connection.DataAccess();
db.openConnection();

Connection connection = db.getConnection();
Statement st = connection.createStatement();

//Get List of Restaurants, Restaurant Types
try{
	ResultSet rs = st.executeQuery("SELECT name FROM Restaurant");
	int c=0;
	while(rs.next()){
		allRestaurants[c] = rs.getString("name");
		c++;
	}
	
	rs = st.executeQuery("SELECT DISTINCT type FROM Restaurant");
	c=0;
	while(rs.next()){
		allRestaurantTypes[c] = rs.getString("type");
		c++;
	}
	
	
}
catch(Exception e){
	System.out.println("Error, caught exception");
}

st.close();

%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Restaurants And Menus queries</title>
</head>
<body>
    	<center><H1>Query Restaurants and menus</H1></center>
        
        <form action="Control" method="GET">
        	<p align="left"><i><strong>a)</strong> Display all the information about a user‐specified restaurant. That is, the user should select the name of the restaurant from a list, and the information as contained in the restaurant and location tables should then displayed on the screen.
            </i></p>
            <p align="left">Specify the restaurant:
				<select name="Query a Dropdown">
					<%
				        for(String val: allRestaurants) {
				        	if(val!=null){
				        		%>
				        		<option value="<%=val%>" SELECTED><%=val %><%}}%>
				</select>
            </p>
            <p>
				<TABLE BORDER="1">
		            <TR>
		                <TH>name</TH>
		                <TH>restaurantID</TH>
		                <TH>type</TH>
		                <TH>url</TH>
		                <TH>location_id</TH>
		                <TH>first_open_date</TH>
		                <TH>manager_name</TH>
		                <TH>phone_number</TH>
		                <TH>street_address</TH>
		                <TH>hour_open</TH>
		                <TH>hour_close</TH>
		            </TR>
		    <% 
		    	String[] res = (String[]) session.getAttribute("ArrayQueryA");
		        
		        if(res!=null){
		            %>
		            <% System.out.println("res is not null"); %>
		            <% System.out.println(res[1]); %>
		            <TR>
		                <td> <%= res[0] %></td>
		                <TD> <%= res[1] %></TD>
		                <TD> <%= res[2] %></TD>
		                <TD> <%= res[3] %></TD>
		                <TD> <%= res[4] %></TD>
		                <TD> <%= res[5] %></TD>
		                <TD> <%= res[6] %></TD>
		                <TD> <%= res[7] %></TD>
		                <TD> <%= res[8] %></TD>
		                <TD> <%= res[9] %></TD>
		                <TD> <%= res[10] %></TD>
		            </TR>
		            <% } %>
		        </TABLE>
                <input type="submit" name="cmdRest" value="Query a">
            </p>
        </form>
        
        <form action="Control" method="GET">
        	<p align="left"><i><strong>b)</strong>  Display the full menu of a specific restaurant. That is, the user should select the name of the restaurant from a list, and all menu items, together with their prices, should be displayed on the screen. The menu should be displayed based on menu item categories.</i></p>
			<p align="left">Specify the restaurant:
				<select name="Query b Dropdown">
					<%
				        for(String val: allRestaurants) {
				        	if(val!=null){
				        		%>
				        		<option value="<%=val%>" SELECTED><%=val %><%}}%>
				</select>
			</p>
			
            <p>
            <!--
				<TABLE BORDER="1">
		            <TR>
		                <TH>item_id</TH>
		                <TH>name</TH>
		                <TH>type</TH>
		                <TH>category</TH>
		                <TH>description</TH>
		                <TH>price</TH>
		            </TR>
				<%
			    	//String[][] QueryBResult = (String[][]) session.getAttribute("ArrayQueryB");
		            //System.out.println("HERE");
		            //System.out.println(QueryBResult);
		            //int c=0;
		            //if(QueryBResult!=null){
		            	
		            %>
		            
					<c:forEach var="row" begin="0" end=something here>
						<TR>
							<%
								//row = %> <c:out value = "${row}"/> <% 
								//for(int i=0;i<QueryBResult.length;i++){
									//	if(QueryBResult[i][c]!=null) {
										//	%><td>somethinghere </td> <%
										//}
								//}
		            //}
							%>
						</TR>
					</c:forEach>
		        </TABLE>
		        -->
                <input type="submit" name="cmdRest" value="Query b">
            </p>
        </form>
        
        <form action="Control" method="GET">
        	<p align="left"><i><strong>c)</strong> For each user‐specified category of restaurant, list the manager names together with the date that the locations have opened. The user should be able to select the category (e.g. Italian or Thai) from a list.</i></p>
			<p align="left">Specify the category of restaurant:
				<select name="Query c Dropdown">
					<%
				        for(String val: allRestaurantTypes) {
				        	if(val!=null){
				        		%>
				        		<option value="<%=val%>" SELECTED><%=val %><%}}%>
				</select>
			</p>
            <p>      
                <input type="submit" name="cmdRest" value="Query c">
            </p>
        </form>
        
        <form action="Control" method="GET">
        	<p align="left"><i><strong>d)</strong>
        	Given a user‐specified restaurant, find the name of the most expensive menu item. List this information together with the name of manager, the opening hours, and the URL of the restaurant. The user should be able to select the restaurant name (e.g. El Camino) from a list.
        	 </i></p>
        	<p align="left">Specify the restaurant: 
				<select name="Query d Dropdown">
					<%
				        for(String val: allRestaurants) {
				        	if(val!=null){
				        		%>
				        		<option value="<%=val%>" SELECTED><%=val %><%}}%>
				</select>
			</p>
            <p>
                <input type="submit" name="cmdRest" value="Query d">
            </p>
        </form>
        
        
        <!-- ========= QUERY E) ========= -->
        
        <form action="Control" method="GET">
        	<p align="left"><i><strong>e)</strong>
			For each type of restaurant (e.g. Indian or Irish) and the category of menu item (appetiser, main or desert), list the average prices of menu items for each category.
        	 </i></p>
        	 
        <%
        	Statement statement = connection.createStatement();
        	String queryE = "SELECT ROUND(AVG(menu.price),2), rest.type, menu.category FROM Restaurant rest LEFT JOIN MenuItem menu ON rest.restaurant_id=menu.restaurant_id WHERE rest.type!='' GROUP BY rest.type, menu.category ORDER BY rest.type;";
        	ResultSet resultSet = statement.executeQuery(queryE);
        %>
        
        <TABLE BORDER="1">
            <TR>
                <TH>average menu price</TH>
                <TH>restaurant type</TH>
                <TH>menu category</TH>
            </TR>
            <% while(resultSet.next()){ %>
            <TR>
                <TD> <%= resultSet.getString(1) %></td>
                <TD> <%= resultSet.getString(2) %></TD>
                <TD> <%= resultSet.getString(3) %></TD>
            </TR>
            <% } %>
        </TABLE>
        </form>
        
        
        
</body>
<script type="text/javascript">
	
	
	
</script>
</html>