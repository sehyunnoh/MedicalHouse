package ca.mercury.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.w3c.dom.stylesheets.MediaList;

import ca.mercury.model.MedicalHistory;

public class MedicalDAO {

	PreparedStatement ps = null;
	ResultSet rs = null;
	int result = 0;

	public ArrayList<MedicalHistory> viewMedicalHistory(Connection conn, String username) {

		ArrayList<MedicalHistory> mhList = new ArrayList<MedicalHistory>();
		
		try {

			String sql = "SELECT  p.FirstName, p.LastName, v.DateTimeOfVisit, v.BloodPressureSystolic, v.Temperature, v.BloodPressureDiastolic,\r\n"
					+ "        v.IsVisitComplete, a.ReasonForVisit, v.PhysicianNotes\r\n"
					+ "  FROM visit v, practitioners p, appointments a, patients pt\r\n"
					+ "  WHERE v.Physician = p.CPSO\r\n" + "    AND v.Appointment = a.ApptNumber\r\n"
					+ "    AND a.Patient = pt.OHIPNumber\r\n" + "    AND pt.Login = ?";

			ps = conn.prepareStatement(sql);
			ps.setString(1, username);

			rs = ps.executeQuery();

			while (rs.next()) {
				String fName = rs.getString(1);
				String lName = rs.getString(2);
				String date = rs.getString(3);
				int bps = rs.getInt(4);
				double temper = rs.getDouble(5);
				int bpd = rs.getInt(6);
				int isVisit = rs.getInt(7);
				String reason = rs.getString(8);
				String notes = rs.getString(9);

				MedicalHistory mh = new MedicalHistory(fName, lName, date, bps, temper, bpd, isVisit, reason, notes);

				mhList.add(mh);
			}

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}

		return mhList;

	}

}
