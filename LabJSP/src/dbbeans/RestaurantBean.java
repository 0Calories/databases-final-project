package dbbeans;

import connection.DataAccess;
import java.sql.*;
import java.util.Random;

public class RestaurantBean {
	private Connection connection;
	private Statement st;
	private ResultSet rs;
	private String name;
	private String restaurantID;
	private String type;
	private String url;
	String tempName;
	String location_id;
	String first_open_date;
	String manager_name;
	String phone_number;
	String street_address;
	String hour_open;
	String hour_close;
	
	String[] getMenuItems_name = new String[999];
	String[] getMenuItems_type = new String[999];
	String[] getMenuItems_item_id = new String[999];
	String[] getMenuItems_category = new String[999];
	String[] getMenuItems_description = new String[999];
	String[] getMenuItems_price = new String[999];

	public RestaurantBean() {
	}

	public void setName(String value) {
		name = value;
	}

	public String getName() {
		return name;
	}

	public void setRestaurantID(String value) {
		restaurantID = value;
	}

	public String getRestaurantID() {
		return restaurantID;
	}
	
	public void setType(String value) {
		type = value;
	}

	public String getType() {
		return type;
	}
	
	public void setUrl(String value) {
		url = value;
	}

	public String setUrl() {
		return url;
	}

	public String[] getRestaurantInfo(String restaurant_id, DataAccess db) {
		
		connection = db.getConnection();

		try {
			st = connection.createStatement();
			String qry = "SELECT * FROM Restaurant rest LEFT JOIN Location loc ON rest.restaurant_id=loc.restaurant_id WHERE rest.restaurant_id=\'" + restaurant_id + "\';";
			rs = st.executeQuery(qry);
			while (rs.next()) {
					name = rs.getString("name");
					restaurantID = rs.getString("restaurant_id");
					type = rs.getString("type");
					url = rs.getString("url");
					location_id = rs.getString("location_id");
					first_open_date = rs.getString("first_open_date");
					manager_name = rs.getString("manager_name");
					phone_number = rs.getString("phone_number");
					street_address = rs.getString("street_address");
					hour_open = rs.getString("hour_open");
					hour_close = rs.getString("hour_close");
				}
		} catch (Exception e) {
			System.out.println("Cant read from customers table");
			e.printStackTrace();
		}
		String[] results = {name, restaurantID, type, url, location_id, first_open_date, manager_name, phone_number, street_address, hour_open, hour_close};
		return results;
	}
	
	public ResultSet getMenuItems(String restaurant_id, DataAccess db) {
		
		connection = db.getConnection();
		try {
			st = connection.createStatement();
			String qry = "SELECT * FROM MenuItem WHERE restaurant_id=\'" + restaurant_id + "\' ORDER BY category;";
			rs = st.executeQuery(qry);
			
			int c=0;
			/*while (rs.next()) {
				getMenuItems_item_id[c] = rs.getString("item_id");
				getMenuItems_name[c] = rs.getString("name");
				getMenuItems_type[c] = rs.getString("type");
				getMenuItems_category[c] = rs.getString("category");
				getMenuItems_description[c] = rs.getString("description");
				getMenuItems_price[c] = rs.getString("price");
				c++;
			}*/
		} catch (Exception e) {
			System.out.println("Cant read from customers table");
			e.printStackTrace();
		}
		String[][] results = {getMenuItems_item_id, getMenuItems_name, getMenuItems_type, getMenuItems_category, getMenuItems_description, getMenuItems_price};
		return rs;
	}
	
	public ResultSet getMostExpensive(String restaurant_id, DataAccess db) {
		
		connection = db.getConnection();
		try {
			st = connection.createStatement();
			String qry = "SELECT menu.name, menu.price, loc.manager_name, loc.hour_open, rest.url" +
					" FROM MenuItem menu " +
					"LEFT JOIN Restaurant rest ON menu.restaurant_id=rest.restaurant_id " +
					"LEFT JOIN Location loc ON menu.restaurant_id=loc.restaurant_id " +
					"WHERE menu.restaurant_id = \'" + restaurant_id + "\' " +
							"AND price = (SELECT max(price) FROM MenuItem WHERE restaurant_id=\'" + restaurant_id + "\');";
			System.out.println(qry);
			rs = st.executeQuery(qry);
			
			int c=0;
			/*while (rs.next()) {
				getMenuItems_item_id[c] = rs.getString("item_id");
				getMenuItems_name[c] = rs.getString("name");
				getMenuItems_type[c] = rs.getString("type");
				getMenuItems_category[c] = rs.getString("category");
				getMenuItems_description[c] = rs.getString("description");
				getMenuItems_price[c] = rs.getString("price");
				c++;
			}*/
		} catch (Exception e) {
			System.out.println("Cant read from customers table");
			e.printStackTrace();
		}
		String[][] results = {getMenuItems_item_id, getMenuItems_name, getMenuItems_type, getMenuItems_category, getMenuItems_description, getMenuItems_price};
		return rs;
	}
	
	public ResultSet executeQueryC(String restaurant_category, DataAccess db) {
		
		connection = db.getConnection();
		try {
			st = connection.createStatement();
			String qry = "SELECT loc.manager_name, loc.first_open_date" +
					" FROM Location loc " +
					"LEFT JOIN Restaurant rest ON loc.restaurant_id=rest.restaurant_id " +
					"WHERE rest.type = \'" + restaurant_category + "\' ";
			System.out.println(qry);
			rs = st.executeQuery(qry);
			
			int c=0;
			/*while (rs.next()) {
				getMenuItems_item_id[c] = rs.getString("item_id");
				getMenuItems_name[c] = rs.getString("name");
				getMenuItems_type[c] = rs.getString("type");
				getMenuItems_category[c] = rs.getString("category");
				getMenuItems_description[c] = rs.getString("description");
				getMenuItems_price[c] = rs.getString("price");
				c++;
			}*/
		} catch (Exception e) {
			System.out.println("Cant read from customers table");
			e.printStackTrace();
		}
		String[][] results = {getMenuItems_item_id, getMenuItems_name, getMenuItems_type, getMenuItems_category, getMenuItems_description, getMenuItems_price};
		return rs;
	}
	
	 public String insertRestaurant (String name, String type, String URL, DataAccess db)
	 {
	 connection = db.getConnection();
	 String id = getRandomString(8);
	 
	 try {
		 st = connection.createStatement();
		
		 System.out.println("ID: "+id);
		
		 st.executeUpdate("INSERT INTO Restaurant "
		 + "(restaurant_id, name, type, url) VALUES ('"+id+"','" + name + "','" + type + "','" + URL + "')");
		
		 rs.close();
		 st.close();
		 
	 } catch(Exception e){
		 
		 System.out.println("Cant insert into customer table");
	 }
	 
	 return id;
	 }
	 
	 public String getRestaurantID (String restaurant_name, DataAccess db) {
		 connection = db.getConnection();
		 String restaurant_id = null;
		 try {
			st = connection.createStatement();
			String qry = "SELECT restaurant_id FROM Restaurant WHERE \'" + restaurant_name + "\' =name";
			rs = st.executeQuery(qry);
			while(rs.next()) {
				restaurant_id = rs.getString("restaurant_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		 return restaurant_id;
		 
		 
	 }
	 
	 public void removeRestaurant(String restaurantID, DataAccess db) {
		 connection = db.getConnection();
		 
		 try {
			 st = connection.createStatement();
			
			 st.executeUpdate("DELETE FROM Restaurant "
			 + "WHERE restaurant_id = '" + restaurantID + "'");
			
			 rs.close();
			 st.close();
			 
		 } catch(Exception e){
			 System.out.println(e);
		 }
	 }
	 
	 
	 
	 
	 
	 public String getRandomString(int length) {
	        String SALTCHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
	        StringBuilder salt = new StringBuilder();
	        Random rnd = new Random();
	        while (salt.length() < length) { // length of the random string.
	            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
	            salt.append(SALTCHARS.charAt(index));
	        }
	        String saltStr = salt.toString();
	        return saltStr;
	 }
}
