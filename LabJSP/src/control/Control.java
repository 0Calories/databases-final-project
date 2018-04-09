package control;

import java.sql.*;
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
	
	// Restaurant
	private void processRestAction(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession s = request.getSession(true);
		RestaurantBean restaurantbean = new RestaurantBean();
		
		db = new DataAccess();
		db.openConnection();
		
		if(request.getParameter("cmdRest").equals("Query a")) {
			String restaurant_name = request.getParameter("Query a Dropdown");
			
			String restaurant_id = restaurantbean.getRestaurantID(restaurant_name, db);
			String[] restaurantInfo = restaurantbean.getRestaurantInfo(restaurant_id, db);
			
			request.getSession(true).setAttribute("ArrayQueryA", restaurantInfo);
			request.getRequestDispatcher("RestaurantsAndMenus.jsp").forward(request, response);
		}
		
		else if(request.getParameter("cmdRest").equals("Query b")) {
			String restaurant_name = request.getParameter("Query b Dropdown");
			
			String restaurant_id = restaurantbean.getRestaurantID(restaurant_name, db);
			String[][] menuInfo = restaurantbean.getMenuItems(restaurant_id, db);
			
			for(int i=0;i<menuInfo.length;i++){
				for(int j=0;j<menuInfo[i].length;j++) {
					if(menuInfo[i][j]!=null) {
						System.out.println(menuInfo[i][j]);
					}
				}
			}
			
			request.getSession(true).setAttribute("ArrayQueryB", menuInfo);
			request.getRequestDispatcher("RestaurantsAndMenus.jsp").forward(request, response);
		}
		
		else if(request.getParameter("cmdRest").equals("Query c")) {
			System.out.println(request.getParameter("Query c Dropdown"));
		}
		
		else if(request.getParameter("cmdRest").equals("Query d")) {
			System.out.println(request.getParameter("Query d Dropdown"));
		}
		
		else if(request.getParameter("cmdRest").equals("Query e")) {
			System.out.println("HERE");
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
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//processAction(request, response);
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(request.getParameter("cmdRest")!=null) {
			processRestAction(request, response);
		}
		else if(request.getParameter("cmdRating")!=null) {
			//processAction(request, response);
		}
		else if(request.getParameter("cmdRate")!=null) {
			//processAction(request, response);
		}
		else {
			System.out.println("Error, check doGet method in control.java");
		}
		
		
	}

	public void destroy() {
		super.destroy();
	}
}