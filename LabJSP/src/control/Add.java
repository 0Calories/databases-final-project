package control;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import connection.DataAccess;
import dbbeans.RestaurantBean;

public class Add extends HttpServlet{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1148361766640581316L;
	private DataAccess db;
	
	public void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException
    {
		HttpSession s = request.getSession(true);
		String submit = request.getParameter("cmdRest");
		
        db= new DataAccess();
        db.openConnection();
		
		switch (submit) {
		
		case "Add Restaurant" :
			String restaurantName = (String)request.getParameter("restaurantName");
			String restaurantType = (String)request.getParameter("restaurantType");
			String restaurantURL = (String)request.getParameter("restaurantURL");
			String restaurantID;
			
			RestaurantBean restaurantBean = new RestaurantBean();
			if (restaurantBean.getRestaurantInfo(restaurantName, db)[1] == null) {
				restaurantID = restaurantBean.insertRestaurant(restaurantName, restaurantType, restaurantURL, db);
			} else {
				restaurantID = restaurantBean.getRestaurantInfo(restaurantName, db)[1];
			}
			
			restaurantBean.setName(restaurantName);
			restaurantBean.setType(restaurantType);
			restaurantBean.setUrl(restaurantURL);
			restaurantBean.setRestaurantID(restaurantID);
			s.setAttribute("restaurantBean", restaurantBean);
		}
		
		s.setAttribute("key","000");
        s.setMaxInactiveInterval(1000);


        db.closeConsult();
        
        RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/index.jsp");
        rd.forward(request,response);
		
    }
	
	public void destroy()
    {       
        super.destroy();
    }

}