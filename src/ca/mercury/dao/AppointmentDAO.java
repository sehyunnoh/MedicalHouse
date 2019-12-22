package ca.mercury.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import ca.mercury.common.DateCommon;
import ca.mercury.model.Appointment;

public class AppointmentDAO {

	PreparedStatement ps = null;
	ResultSet rs = null;
	int result = 0;
	
	public ArrayList<Appointment> getAppointInfo(Connection conn, String id){
		
		ArrayList<Appointment> list = new ArrayList<Appointment>();
		
		try {
			String sql = "SELECT a.apptnumber, a.Patient, a.reasonforvisit, DATE_FORMAT(a.datetime, '%Y%m%d') date, DATE_FORMAT(a.datetime, '%H:%i:%s') time, a.IsPatientCheckedIn\r\n" + 
					"  FROM USERs u, patients p, appointments a\r\n" + 
					" WHERE u.username = p.login\r\n" + 
					"   AND p.OHIPNumber = a.patient\r\n" + 
					"   AND u.username = ?;";

			ps = conn.prepareStatement(sql);
			ps.setString(1, id);

			rs = ps.executeQuery();
			
			while (rs.next()) {
				long appnumber = rs.getLong(1);
				long patient = rs.getLong(2);
				String reason = rs.getString(3);
				String date = rs.getString(4);
				String time = rs.getString(5);
				int checkedIn = rs.getInt(6);
								
				Appointment ap = new Appointment(appnumber, patient, reason, date, time, checkedIn);
				list.add(ap);
			}

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}
		return list;
	}
	
	// create appointment
	public int createAppointment(Connection conn, Appointment apt) {
		int result = 0;
		try {
			String sql = "INSERT INTO appointments (Patient, ReasonForVisit, DateTime, IsPatientCheckedIn) VALUES " + 
				     "	(?, ?, ?, ?);";
			ps = conn.prepareStatement(sql);
			ps.setLong(1, apt.getPatient());
			ps.setString(2, apt.getReasonForVisit());
			ps.setString(3, apt.getDate()+" "+apt.getTime());
			ps.setInt(4, apt.getIsPatientCheckedIn());
			result = ps.executeUpdate();
		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}
		return result;
	}
	
	// edit appointment
	public int editAppointment(Connection conn, Appointment apt) {
		int result = 0;
		try {
			String sql = "UPDATE appointments SET ReasonForVisit = ?, DateTime = ? WHERE apptnumber = ?";
			ps = conn.prepareStatement(sql);
			
			ps.setString(1, apt.getReasonForVisit());
			ps.setString(2, DateCommon.addDash(apt.getDate())+" "+apt.getTime());
			ps.setLong(3, apt.getAppNumber());
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}
		return result;
	}	
	
	// delete appointment
	public int deleteAppointment(Connection conn, Appointment apt) {
		int result = 0;
		try {
			String sql = "DELETE from appointments WHERE apptnumber = ?";
			ps = conn.prepareStatement(sql);
			
			ps.setLong(1, apt.getAppNumber());
			
			result = ps.executeUpdate();
		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}
		return result;
	}		
	
}
