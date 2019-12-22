package ca.mercury.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ca.mercury.dao.DBConnection;
import ca.mercury.dao.MedicalDAO;
import ca.mercury.model.MedicalHistory;
import ca.mercury.model.Patient;

/**
 * The medical controller will manage functionality related to the doctor-patient relationship: 
 * registering/checking in for a scheduled appointment, 
 * starting a doctor’s visit, 
 * completing a diagnosis, 
 * prescribing medication, 
 * recommending tests, 
 * reviewing past visits.  
 * The medical controller uses the Patient, Doctor, and Visit models
 *
 */
@WebServlet("/MedicalController")
public class MedicalController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	DBConnection db = null;
	
	public MedicalController() {
		db = new DBConnection();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		MedicalDAO mDao = new MedicalDAO();
		String type = request.getParameter("type");
		
		if(type.equals("view")) {
			
			HttpSession session = request.getSession();
			Patient sudInfo = (Patient)session.getAttribute("sudInfo");			
			
			ArrayList<MedicalHistory> mhList  = mDao.viewMedicalHistory(db.getConnection(), sudInfo.getLogin());
			request.setAttribute("mh", mhList);
			
			request.getRequestDispatcher("pages/historyPage.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
