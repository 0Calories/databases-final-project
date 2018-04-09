package dbbeans;

import connection.DataAccess;
import java.sql.*;

public class RaterBean {
	private Connection connection;
	private Statement st;
	private Integer raterID;
	private ResultSet rs;
	private String email;
	private String name;
	private String join_date;
	private String type;
	private Integer reputation;
	
	public RaterBean(){
	}
	
	public Integer getRaterID() {
		return raterID;
	}

	public void setRaterID(Integer raterID) {
		this.raterID = raterID;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getJoin_date() {
		return join_date;
	}
	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public Integer getReputation() {
		return reputation;
	}
	public void setReputation(Integer reputation) {
		this.reputation = reputation;
	}
	
	public String[] getRaterInfo(String name, DataAccess db) {
		String tempName;
		connection = db.getConnection();

		try {
			st = connection.createStatement();
			rs = st.executeQuery("SELECT * FROM Rater");
			while (rs.next()) {
				tempName = rs.getString("name").trim();
				if (tempName.compareTo(name.trim()) == 0) {
					this.name = tempName;
					raterID = rs.getInt("user_id");
					type = rs.getString("type");
					join_date = rs.getString("join_date");
					email = rs.getString("email");
					reputation = rs.getInt("reputation");
				}
					
			}
			rs.close();
			st.close();
		} catch (Exception e) {
			System.out.println("Cant read from customers table");
			e.printStackTrace();
		}
		String[] results = {this.name, String.valueOf(raterID), email, join_date, type, String.valueOf(reputation)};
		return results;
	}
	
	 public Integer insertRater (String name, String type, String email, String join_date, Integer reputation, DataAccess db)
	 {
	 connection = db.getConnection();
	 int id = 0;
	 try {
		 st = connection.createStatement();
		 
		 rs  = st.executeQuery("SELECT max(user_id) as id FROM Rater");
		 rs.next();
		 int max_id = rs.getInt(1);
		 id = max_id + 1;
		
		 System.out.println("ID: "+id);
		
		 st.executeUpdate("INSERT INTO Rater "
		 + "(user_id, email, name, join_date, type, reputation) VALUES (" +id + ",'" + email + "','" + name + "','" + join_date + "','" + type + "'," + reputation + ")");
		
		 rs.close();
		 st.close();
		 
	 } catch(Exception e){
		 System.out.println(e);
		 System.out.println("Cant insert into customer table");
	 }
	 
	 return id;
	 }
	 
	 public void removeRater(String raterID, DataAccess db) {
		 connection = db.getConnection();
		 
		 try {
			 st = connection.createStatement();
			
			 st.executeUpdate("DELETE FROM Rater "
			 + "WHERE user_id = '" + raterID + "'");
			
			 rs.close();
			 st.close();
			 
		 } catch(Exception e){
			 System.out.println(e);
		 }
	 }
	
}
