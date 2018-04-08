package dbbeans;

import connection.DataAccess;
import java.sql.*;

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
	
	//
	// public int insertCustomer(String name, DataAccess db)
	// {
	// connection = db.getConnection();
	// int id = 0;
	//
	// try {
	// st = connection.createStatement();
	//
	// rs = st.executeQuery("SELECT max(restaurantID) as id FROM
	// laboratories.customer");
	// rs.next();
	//
	// int max_id = rs.getInt(1);
	// id = max_id + 1;
	//
	// System.out.println("ID: "+id);
	//
	// st.executeUpdate("INSERT INTO laboratories.customer "
	// + " (restaurantID,name) VALUES ("+id+",'" + name + "')");
	//
	// rs.close();
	// st.close();
	// }catch(Exception e){
	// System.out.println("Cant insert into customer table");
	// }
	// return id;
	// }
}
