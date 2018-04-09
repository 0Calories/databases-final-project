package control;

import dbbeans.*;
import java.sql.*;

import connection.DataAccess;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RestaurantRatingsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DataAccess db;

	public RestaurantRatingsController() {

	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession s = request.getSession(true);
		//RestaurantBean restaurantbean = new RestaurantBean();

		db = new DataAccess();
		db.openConnection();

		Connection connection = db.getConnection();
		Statement statement = null;
		try {
			statement = connection.createStatement();
			
			ResultSet resultSet = null;
			
			// Check which button was selected
			if (request.getParameter("cmdH") != null) {
				System.out.println("cmdH function selected");
				String userID = request.getParameter("userID");
				String query = "SELECT Rest.Name, RL.first_open_date AS date " + 
								"FROM Rating Rat " + 
								"LEFT JOIN Restaurant Rest ON Rat.restaurant_id=Rest.restaurant_id " +
								"LEFT JOIN Location RL ON RL.restaurant_id=Rat.restaurant_id " + 
								"WHERE Rat.user_id = " + userID + " " +
								"      AND ((Rat.price>( SELECT AVG(Rat.staff) " +
								"        FROM Rating Rat, Restaurant Rest " +
								"        WHERE Rat.restaurant_id=Rest.restaurant_id)) " +
								"      OR (Rat.mood>( SELECT AVG(Rat.staff) " +
								"        FROM Rating Rat, Restaurant Rest " + 
								"        WHERE Rat.restaurant_id=Rest.restaurant_id)) " +
								"      OR (Rat.food>( SELECT AVG(Rat.staff) " +
								"        FROM Rating Rat, Restaurant Rest " +
								"        WHERE Rat.restaurant_id=Rest.restaurant_id)) " +
								"      OR (Rat.staff>( SELECT AVG(Rat.staff) " +
								"        FROM Rating Rat, Restaurant Rest " +
								"        WHERE Rat.restaurant_id=Rest.restaurant_id))) " +
								"GROUP BY RL.first_open_date, Rest.name";
				resultSet = statement.executeQuery(query);
			} else if (request.getParameter("cmdI") != null) {
				System.out.println("cmdI function selected");
			}
			
			// Store the resultSet so the jsp page can access it later
			request.getSession().setAttribute("resultSet", resultSet);
			request.getSession().setMaxInactiveInterval(5000);
			db.closeConsult();

			RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/QueryHResults.jsp");
			rd.forward(request, response);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void destroy() {
		super.destroy();
	}
}