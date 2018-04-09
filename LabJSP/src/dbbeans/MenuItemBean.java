package dbbeans;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

import connection.DataAccess;

public class MenuItemBean {
	private Connection connection;
	private Statement st;
	private ResultSet rs;
	private String itemID;
	private String name;
	private String type;
	private String category;
	private String description;
	private double price;
	private String restaurantID;
	
	public String getItemID() {
		return itemID;
	}
	public void setItemID(String itemID) {
		this.itemID = itemID;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getRestaurantID() {
		return restaurantID;
	}
	public void setRestaurantID(String restaurantID) {
		this.restaurantID = restaurantID;
	}
	
	public String[] getMenuItemInfo(String name, DataAccess db) {
		String tempName;
		connection = db.getConnection();

		try {
			st = connection.createStatement();
			rs = st.executeQuery("SELECT * FROM MenuItem");
			while (rs.next()) {
				tempName = rs.getString("name").trim();
				if (tempName.compareTo(name.trim()) == 0) {
					this.name = tempName;
					itemID = rs.getString("item_id");
					type = rs.getString("type");
					name = rs.getString("name");
					category = rs.getString("category");
					description = rs.getString("description");
					price = rs.getDouble("price");
					restaurantID = rs.getString("restaurant_id");
				}
			}
			rs.close();
			st.close();
		} catch (Exception e) {
			System.out.println("Cant read from customers table");
			e.printStackTrace();
		}
		String[] results = {this.name, itemID, category, description, type, String.valueOf(price), restaurantID};
		return results;
	}
	public String insertMenuItem (String name, String type, String category, String description, double price, String restaurant_id, DataAccess db)
	 {
	 connection = db.getConnection();
	 
	 String id = getRandomString(5);
	 try {
		 st = connection.createStatement();
		
		 System.out.println("ID: "+id);
		
		 st.executeUpdate("INSERT INTO MenuItem "
		 + "(item_id, name, type, category, description, price, restaurant_id) VALUES ('" +id + "','" + name + "','" + type + "','" + category+ "','" + description + "'," + String.format("%.2g%n", price) + ",'" + restaurant_id + "')");
		
		 rs.close();
		 st.close();
		 
	 } catch(Exception e){
		 System.out.println(e);
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
