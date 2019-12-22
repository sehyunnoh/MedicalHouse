package ca.mercury.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ca.mercury.dao.DBConnection;
import ca.mercury.dao.UserDAO;
import ca.mercury.model.Patient;
import ca.mercury.model.SessionUserInfo;

/**
 * The system controller will manage the overall functionality of the
 * application: rendering views, deciding the menu functions, relating the other
 * controllers together
 * 
 *
 */
@WebServlet("/SystemController")
public class SystemController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public SystemController() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String type = request.getParameter("type");

		if (type.equals("login")) {

			String id = request.getParameter("id");
			String pw = request.getParameter("password");

			DBConnection db = new DBConnection();
			UserDAO userDao = new UserDAO();
			
					
			// role check 
			int role = userDao.checkRole(db.getConnection(), id, pw);

			if (role != 0) {
				SessionUserInfo suInfo = userDao.getSessionUserInfo(db.getConnection(), id, role);
				
				
				HttpSession session=request.getSession();  
				session.setAttribute("suInfo", suInfo);
				request.setAttribute("type", "view");
				request.setAttribute("db", db);
				request.setAttribute("id", id);

				if( role == 2) {
					Patient sudInfo = userDao.getSessionUserDetailInfo(db.getConnection(), id);
					session.setAttribute("sudInfo", sudInfo);
				}
				
				request.getRequestDispatcher("CalendarController").forward(request, response);
				
			} else {
				// return to login page with error message.
				request.setAttribute("message", "It is not available");
				request.getRequestDispatcher("loginPage.jsp").forward(request, response);
				
			}
		} 

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
