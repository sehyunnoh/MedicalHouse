package ca.mercury.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import ca.mercury.dao.DBConnection;
import ca.mercury.dao.UserDAO;
import ca.mercury.model.Patient;
import ca.mercury.model.PhoneNumber;
import ca.mercury.model.UserProfile;

/**
 * creating a profile, changing properties of a user profile, and viewing a user
 * profile
 * 
 */
@WebServlet("/UserController")
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	DBConnection db = null;

	public UserController() {
		db = new DBConnection();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		UserDAO userdao = new UserDAO();
		String type = request.getParameter("type");
		String ptype = ""+request.getAttribute("ptype");

		if (type.equals("view") || ptype.equals("view")) {

			HttpSession session = request.getSession();
			Patient sudInfo = (Patient) session.getAttribute("sudInfo");
			UserProfile up = userdao.viewUserProfile(db.getConnection(), sudInfo.getLogin());
			request.setAttribute("up", up);

			// phonenumber
			ArrayList<PhoneNumber> phList = userdao.viewPhoneNumbers(db.getConnection(), sudInfo.getLogin());
			request.setAttribute("phList", phList);

			request.getRequestDispatcher("pages/userProfile.jsp").forward(request, response);

		} else if (type.equals("update")) {
			
			// patient table
			long ohipNum = Long.parseLong(request.getParameter("ohipNumHidden"));
			String ohipVer = request.getParameter("ohipVer");
			String fName = request.getParameter("fName");
			String lName = request.getParameter("lName");

			Patient pa = new Patient(ohipNum, ohipVer, fName, lName);
			pa.setLogin(request.getParameter("userIDHidden"));

			// users table
			String pw = request.getParameter("password");

			// phonenumber table
			ArrayList<PhoneNumber> pnList = new ArrayList<PhoneNumber>();

			long homeNum = Long.parseLong(request.getParameter("homeNum"));
			PhoneNumber homePn = new PhoneNumber(homeNum, request.getParameter("userIDHidden"), "Home");
			pnList.add(homePn);
			
			if(!request.getParameter("officeNum").equals("")) {
				long officeNum = Long.parseLong(request.getParameter("officeNum"));
				PhoneNumber officePn = new PhoneNumber(officeNum, request.getParameter("userIDHidden"), "Office");
				pnList.add(officePn);
			}
			
			if(!request.getParameter("workNum").equals("")) {
				long workNum = Long.parseLong(request.getParameter("workNum"));
				PhoneNumber workPn = new PhoneNumber(workNum, request.getParameter("userIDHidden"), "Work");
				pnList.add(workPn);
			}

			if(!request.getParameter("faxNum").equals("")) {
				long faxNum = Long.parseLong(request.getParameter("faxNum"));
				PhoneNumber faxPn = new PhoneNumber(faxNum, request.getParameter("userIDHidden"), "Fax");
				pnList.add(faxPn);
			}

			int result = userdao.updateUserProfile(db.getConnection(), pa, pw, pnList);
			
			request.setAttribute("ptype", "view");
			request.getRequestDispatcher("UserController").forward(request, response);

		} else if (type.equals("create")) {

			// patient table
			long ohipNum = Long.parseLong(request.getParameter("ohipNum"));
			String ohipVer = request.getParameter("ohipVer");
			String fName = request.getParameter("fName");
			String lName = request.getParameter("lName");
			String login = request.getParameter("userID");
			String gender = request.getParameter("gender");
			String birth = request.getParameter("birth");

			Patient pa = new Patient(ohipNum, ohipVer, fName, lName, login, gender, birth);

			// users table
			String pw = request.getParameter("password");

			// phonenumber table
			long homeNum = Long.parseLong(request.getParameter("homeNum"));
			PhoneNumber homePn = new PhoneNumber(homeNum, request.getParameter("userID"), "Home");
			ArrayList<PhoneNumber> pnList = new ArrayList<PhoneNumber>();
			pnList.add(homePn);
			
			if(!request.getParameter("officeNum").equals("")) {
				long officeNum = Long.parseLong(request.getParameter("officeNum"));
				PhoneNumber officePn = new PhoneNumber(officeNum, request.getParameter("userID"), "Office");
				pnList.add(officePn);
			}
			
			if(!request.getParameter("workNum").equals("")) {
				long workNum = Long.parseLong(request.getParameter("workNum"));
				PhoneNumber workPn = new PhoneNumber(workNum, request.getParameter("userID"), "Work");
				pnList.add(workPn);
			}

			if(!request.getParameter("faxNum").equals("")) {
				long faxNum = Long.parseLong(request.getParameter("faxNum"));
				PhoneNumber faxPn = new PhoneNumber(faxNum, request.getParameter("userID"), "Fax");
				pnList.add(faxPn);
			}
			

			int result = userdao.createUserProfile(db.getConnection(), pa, pw, pnList);
			request.getRequestDispatcher("loginPage.jsp").forward(request, response);

		} else if (type.equals("logout")) {
			HttpSession session = request.getSession();
			session.removeAttribute("suInfo");
			session.removeAttribute("sudInfo");
			response.sendRedirect("loginPage.jsp");
		} else if (type.equals("dupcheck")) {

			String username = request.getParameter("username");

			boolean check;
			if(username.equals("")) {
				check = false;
			}else {
				check = userdao.userDupCheck(db.getConnection(), username);
			}
			
			request.setAttribute("dupCheck", check);
			request.setAttribute("checkUser", username);
			request.getRequestDispatcher("pages/createProfile.jsp").forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
