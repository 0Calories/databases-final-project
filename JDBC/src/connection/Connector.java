package connection;
import java.sql.*;

public class Connector {
	
	public static String URL = "jdbc:postgresql://localhost/";
	public static String USERNAME = "postgres";
	public static String PASSWORD = "password";

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		try {
			Class.forName("org.postgresql.Driver");
			Connection db = DriverManager.getConnection(URL, 
					USERNAME, PASSWORD);
			Statement st = db.createStatement();
			st.executeUpdate("set search_path = 'project'");
			ResultSet rs = st.executeQuery("SELECT * FROM Restaurant");
			while(rs.next()) {
				System.out.printf("Column 1 returned: %s \n", rs.getString(1));
			}
			rs.close();
			st.close();
			
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
