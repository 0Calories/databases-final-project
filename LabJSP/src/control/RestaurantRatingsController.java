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
			if (request.getParameter("cmdM") != null) {
				System.out.println("cmdM function selected");
				selectedCommand = "cmdM";
				String restaurantID = request.getParameter("restaurantID");
				query = "SELECT Rater.name, Rater.reputation, comment, items.name, items.price FROM " +
						"(SELECT * FROM RatingItem LEFT JOIN MenuItem ON RatingItem.item_id = MenuItem.item_id) items " +
						"JOIN " +
						"	(SELECT user_id AS most_frequent_userid, COUNT(user_id) AS num_ratings " +
						"	FROM RatingItem LEFT JOIN MenuItem ON RatingItem.item_id = MenuItem.item_id " +
						"	WHERE restaurant_id = '" + restaurantID + "' " +
						"	GROUP BY user_id " +
						"	ORDER BY num_ratings DESC " +
						"	LIMIT 1) most_frequent_rater " +
						"ON  items.user_id = most_frequent_rater.most_frequent_userid " +
						"LEFT JOIN Rater ON Rater.user_id = most_frequent_rater.most_frequent_userid";
				
			} else if (request.getParameter("cmdN") != null) {
				System.out.println("cmdN function selected");
				selectedCommand = "cmdN";
				String raterName = request.getParameter("raterName");
				System.out.println(raterName);
				query = "SELECT rter.name, rter.email " +
						"FROM rater rter " +
						"WHERE (SELECT AVG(price+food+mood+staff)/4 FROM rating WHERE user_id=rter.user_id) < (SELECT AVG(price+food+mood+staff)/4 FROM rating WHERE user_id=(SELECT DISTINCT user_id FROM rater WHERE name=\'" + raterName +"\'))";
				
				
			} 
			
			resultSet = statement.executeQuery(query);
			
			// Store the resultSet so the jsp page can access it later
			request.getSession().setAttribute("resultSet", resultSet);
			request.getSession().setMaxInactiveInterval(5000);
			db.closeConsult();

			RequestDispatcher rd = null;
			
			// Query N is not implemented yet :(
			if (selectedCommand.equals("cmdM")) {
				rd = this.getServletContext().getRequestDispatcher("/QueryResultPages/QueryMResults.jsp");
			} 
			
			else if (selectedCommand.equals("cmdN")) {
				rd = this.getServletContext().getRequestDispatcher("/QueryResultPages/QueryNResults.jsp");
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