package ca.mercury.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ca.mercury.dao.AppointmentDAO;
import ca.mercury.dao.DBConnection;
import ca.mercury.model.Appointment;
import ca.mercury.model.Patient;

/**
 * create, edit, cancel, view appointments
 *
 */
@WebServlet("/CalendarController")
public class CalendarController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public CalendarController() {
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String type = "" + request.getAttribute("type");
        String pType = request.getParameter("ptype");
		
		DBConnection db = (DBConnection) request.getAttribute("db");
		
		if(db == null) {
			db = new DBConnection();
		}
		
		AppointmentDAO appointDAO = new AppointmentDAO();
		HttpSession session=request.getSession();
		Patient pa = (Patient)session.getAttribute("sudInfo");
		
		if (type.equals("view") || pType.equals("view")) {

			String id = pa.getLogin();			
			
			ArrayList<Appointment> list = appointDAO.getAppointInfo(db.getConnection(), id);

			ArrayList<Appointment> day1List = new ArrayList<Appointment>();
			ArrayList<Appointment> day2List = new ArrayList<Appointment>();
			ArrayList<Appointment> day3List = new ArrayList<Appointment>();
			ArrayList<Appointment> day4List = new ArrayList<Appointment>();
			ArrayList<Appointment> day5List = new ArrayList<Appointment>();
			ArrayList<Appointment> day6List = new ArrayList<Appointment>();
			ArrayList<Appointment> day7List = new ArrayList<Appointment>();

			Date date = new Date();
			Calendar c = Calendar.getInstance();
			c.setTime(date);
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMdd");
			String day1 = formatter.format(c.getTime());
			c.add(Calendar.DATE, 1);
			String day2 = formatter.format(c.getTime());
			c.add(Calendar.DATE, 1);
			String day3 = formatter.format(c.getTime());
			c.add(Calendar.DATE, 1);
			String day4 = formatter.format(c.getTime());
			c.add(Calendar.DATE, 1);
			String day5 = formatter.format(c.getTime());
			c.add(Calendar.DATE, 1);
			String day6 = formatter.format(c.getTime());
			c.add(Calendar.DATE, 1);
			String day7 = formatter.format(c.getTime());

			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getDate().equals(day1)) {
					day1List.add(list.get(i));
				} else if (list.get(i).getDate().equals(day2)) {
					day2List.add(list.get(i));
				} else if (list.get(i).getDate().equals(day3)) {
					day3List.add(list.get(i));
				} else if (list.get(i).getDate().equals(day4)) {
					day4List.add(list.get(i));
				} else if (list.get(i).getDate().equals(day5)) {
					day5List.add(list.get(i));
				} else if (list.get(i).getDate().equals(day6)) {
					day6List.add(list.get(i));
				} else if (list.get(i).getDate().equals(day7)) {
					day7List.add(list.get(i));
				}
			}
			request.setAttribute("day1List", day1List);
			request.setAttribute("day2List", day2List);
			request.setAttribute("day3List", day3List);
			request.setAttribute("day4List", day4List);
			request.setAttribute("day5List", day5List);
			request.setAttribute("day6List", day6List);
			request.setAttribute("day7List", day7List);
			request.getRequestDispatcher("pages/appointPage.jsp").forward(request, response);
		} else if (type.equals("create") || pType.equals("create")) {

			Appointment apt = new Appointment();
			
			
			
			apt.setPatient(pa.getOhipNumber()); 
			apt.setDate(request.getParameter("date"));
			apt.setTime(request.getParameter("time")+":00");
			apt.setIsPatientCheckedIn(0);
			apt.setReasonForVisit(request.getParameter("reason"));

			appointDAO.createAppointment(db.getConnection(), apt);
			request.setAttribute("type", "view");
			request.setAttribute("id", pa.getLogin());
			pType = "";
			request.getRequestDispatcher("CalendarController").forward(request, response);
			
		} else if (type.equals("edit") || pType.equals("edit")) {

			Appointment apt = new Appointment();

			apt.setAppNumber(Long.parseLong(request.getParameter("appNumber")));
			apt.setDate(request.getParameter("date"));
			apt.setTime(request.getParameter("time"));
			apt.setReasonForVisit(request.getParameter("reason"));

			appointDAO.editAppointment(db.getConnection(), apt);
			request.setAttribute("type", "view");
			request.setAttribute("id",  pa.getLogin());
			pType = "";
			request.getRequestDispatcher("CalendarController").forward(request, response);

		} else if (type.equals("cancel")  || pType.equals("cancel")) {
			Appointment apt = new Appointment();

			apt.setAppNumber(Long.parseLong(request.getParameter("appNumber")));
			appointDAO.deleteAppointment(db.getConnection(), apt);
			request.setAttribute("type", "view");
			request.setAttribute("id",  pa.getLogin());
			pType = "";
			request.getRequestDispatcher("CalendarController").forward(request, response);
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
