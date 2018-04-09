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

	public String[] getRestaurantInfo(String name, DataAccess db) {
		String tempName;
		connection = db.getConnection();

		try {
			st = connection.createStatement();
			rs = st.executeQuery("SELECT * FROM Restaurant");
			while (rs.next()) {
				tempName = rs.getString("name").trim();
				if (tempName.compareTo(name.trim()) == 0) {
					this.name = tempName;
					restaurantID = rs.getString("restaurant_id");
					type = rs.getString("type");
					url = rs.getString("url");
				}
					
			}
			rs.close();
			st.close();
		} catch (Exception e) {
			System.out.println("Cant read from customers table");
			e.printStackTrace();
		}
		String[] results = {this.name, restaurantID, type, url};
		return results;
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
