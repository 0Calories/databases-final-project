package control;

import dbbeans.*;

import connection.DataAccess;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Control extends HttpServlet {
	private DataAccess db;
	private static final long serialVersionUID = 1L;
	
	public Control() {
		
	}
	
	private void processAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession s = request.getSession(true);
		String restaurant_name = (String) request.getParameter("restaurantInfo");

		// Restaurant
		RestaurantBean restaurantbean = new RestaurantBean();

		db = new DataAccess();
		db.openConnection();

		String restaurantID = restaurantbean.existsRestaurant(restaurant_name, db);
		System.out.println(restaurantID);

		if (restaurantID.equals("")) {
			// restaurantID = restaurantbean.insertCustomer(customer_name, db);
		}

		restaurantbean.setName(restaurant_name);
		restaurantbean.setRestaurantID(String.valueOf(restaurantID));

		s.setAttribute("restaurantbean", restaurantbean);

		// //LIKE ARTIST
		// LikeArtistBean likeartistbean = new LikeArtistBean();
		//
		// if (!likeartistbean.existsLikeArtist(restaurantID, artist_name, db)){
		// likeartistbean.insertLikeArtist(restaurantID, artist_name, db);
		// }
		//
		// likeartistbean.setDataAccess(db);
		//
		// s.setAttribute("likeartistbean", likeartistbean );
		// s.setAttribute("dataaccess",db);
		// s.setAttribute("db",db);

		/// SESION
		s.setAttribute("key", "000");
		s.setMaxInactiveInterval(1000);

		db.closeConsult();

		RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/menu.jsp");
		rd.forward(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processAction(request, response);
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		processAction(request, response);
	}

	public void destroy() {
		super.destroy();
	}
}