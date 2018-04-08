
package dbbeans;

import connection.DataAccess;
import java.sql.*;

public class RestaurantBean {
    private Connection connection;
    private Statement st;
    private ResultSet rs;
    private String name;
    private String restaurantID;


   public RestaurantBean() {
    }

    public void setName(String value)
    {
        name = value;
    }

    public String getName()
    {
        return name;
    }
    
    public void setRestaurantID(String value) {
    	restaurantID = value;
    }
    
    public String getRestaurantID() {
    	return restaurantID;
    }

   
    public int existsRestaurant(String name, DataAccess db) {
        int id = -1;
        String temp;
        connection = db.getConnection();

        try{
            st = connection.createStatement();
            rs  = st.executeQuery("SELECT * FROM Restaurant");
            while (rs.next())
            {
                temp = rs.getString("name");
                temp = temp.trim();
                if (temp.compareTo(name.trim())==0)
                    id = rs.getInt("restaurantID");
            }
            rs.close();
            st.close();
            }catch(Exception e){
                System.out.println("Cant read from customers table");
            }
            return id;
    }
//
//    public int insertCustomer(String name, DataAccess db)
//    {
//        connection = db.getConnection();
//        int id = 0;        
//
//        try {
//            st = connection.createStatement();
//
//            rs  = st.executeQuery("SELECT max(restaurantID) as id FROM laboratories.customer");
//            rs.next();
//
//            int max_id = rs.getInt(1);
//            id = max_id + 1;
//
//            System.out.println("ID: "+id);
//
//            st.executeUpdate("INSERT INTO laboratories.customer "
//                            + " (restaurantID,name) VALUES ("+id+",'" + name + "')");
//
//            rs.close();
//            st.close();
//        }catch(Exception e){
//            System.out.println("Cant insert into customer table");
//        }
//        return id;
//    }
}
