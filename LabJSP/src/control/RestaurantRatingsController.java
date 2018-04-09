package control;

import dbbeans.*;

import connection.DataAccess;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class RestaurantRatingsController extends HttpServlet {
	private DataAccess db;
	private static final long serialVersionUID = 1L;
	
	public RestaurantRatingsController() {
		
	}
	
	private void processAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession s = request.getSession(true);
		String restaurant_name = (String) request.getParameter("restaurantInfo");

		// Restaurant
		RestaurantBean restaurantbean = new RestaurantBean();

		db = new DataAccess();
		db.openConnection();

		String[] restaurantInfo = restaurantbean.getRestaurantInfo(restaurant_name, db);
		for (int i = 0; i < restaurantInfo.length; i++)
			System.out.println(restaurantInfo[i]);

		if (restaurantInfo[0].equals("")) {
			System.out.println("No results found");
		}

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