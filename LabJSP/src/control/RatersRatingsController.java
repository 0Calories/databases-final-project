package control;

import dbbeans.*;
import java.sql.*;

import connection.DataAccess;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RatersRatingsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private DataAccess db;

	public RatersRatingsController() {

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
			
			String selectedCommand = null;
			String query = null;
			
			// Check which button was selected
			if (request.getParameter("cmdH") != null) {
				System.out.println("cmdH function selected");
				selectedCommand = "cmdH";
				String userID = request.getParameter("userID");
				query = "SELECT Rest.Name, RL.first_open_date AS date " + 
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
				
			} else if (request.getParameter("cmdI") != null) {
				System.out.println("cmdI function selected");
				selectedCommand = "cmdI";
				String restaurantType = request.getParameter("restaurantType");
				query = "SELECT Rater.name " + 
								"FROM Rater " +
								"INNER JOIN " +
								"  (SELECT Rating.food, Rating.user_id " +
								"  FROM Rating, Restaurant " +
								"  WHERE Restaurant.type = '" + restaurantType + "' AND Rating.restaurant_id = Restaurant.restaurant_id AND Rating.food IN " +
								"  	(SELECT MAX(Rating.food) FROM Rating, Restaurant " +
								"  	 WHERE Restaurant.type = 'Indian' AND Rating.restaurant_id = Restaurant.restaurant_id) " +
								"  GROUP BY Rating.user_id, Rating.food) MaxRating ON MaxRating.user_id = Rater.user_id";
			} else if (request.getParameter("cmdJ") != null) {
				System.out.println("cmdJ function selected");
				selectedCommand = "cmdJ";
				String restaurantType = request.getParameter("restaurantType");
				query = "SELECT T.restaurant_id, T.name , T.total_rating " +
								"FROM " +
								"	(SELECT AVG(Rating.price + Rating.Food + Rating.mood + Rating.staff) as total_rating, Restaurant.restaurant_id, Restaurant.name " +
								"	FROM Rater, Rating, Restaurant " +
								"	WHERE Rater.user_id = Rating.user_id AND Restaurant.restaurant_id = Rating.restaurant_id " +
								"	GROUP BY Restaurant.restaurant_id) AS T " +
								"WHERE T.total_rating < " +
								"	(SELECT AVG(Rating.price + Rating.Food + Rating.mood + Rating.staff) as total_rating " +
								"	FROM Rater " +
								"	INNER JOIN Rating ON Rater.user_id = Rating.user_id " +
								"	INNER JOIN Restaurant ON Restaurant.restaurant_id = Rating.restaurant_id AND Restaurant.type = '" + restaurantType + "' " +
								"	GROUP BY Restaurant.restaurant_id)";
			}
			
			resultSet = statement.executeQuery(query);
			
			// Store the resultSet so the jsp page can access it later
			request.getSession().setAttribute("resultSet", resultSet);
			request.getSession().setMaxInactiveInterval(5000);
			db.closeConsult();

			RequestDispatcher rd = null;
			if (selectedCommand.equals("cmdH")) {
				rd = this.getServletContext().getRequestDispatcher("/QueryResultPages/QueryHResults.jsp");
			} else if (selectedCommand.equals("cmdI")) {
				rd = this.getServletContext().getRequestDispatcher("/QueryResultPages/QueryIResults.jsp");
			} else if (selectedCommand.equals("cmdJ")) {
				rd = this.getServletContext().getRequestDispatcher("/QueryResultPages/QueryJResults.jsp");
			}
			
			rd.forward(request, response);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void destroy() {
		super.destroy();
	}
}