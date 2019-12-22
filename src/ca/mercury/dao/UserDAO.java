/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ca.mercury.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import ca.mercury.model.Patient;
import ca.mercury.model.PhoneNumber;
import ca.mercury.model.SessionUserInfo;
import ca.mercury.model.UserProfile;

public class UserDAO {

	PreparedStatement ps = null;
	ResultSet rs = null;
	int result = 0;

	public int checkRole(Connection conn, String id, String pw) {

		try {
			String sql = "SELECT role  FROM users WHERE username = ? AND PASSWORD = ?;";

			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			ps.setString(2, pw);

			rs = ps.executeQuery();

			while (rs.next()) {
				result = rs.getInt("role");
			}

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}
		return result;
	}

	public SessionUserInfo getSessionUserInfo(Connection conn, String id, int role) {

		SessionUserInfo suInfo = null;
		try {

			String sql = "SELECT a.username, a.role, b.FirstName, b.lastname " + "  FROM users a, patients b "
					+ " WHERE a.username = b.login " + "   AND a.username = ? ";

			ps = conn.prepareStatement(sql);
//			ps.setString(1, (role == 1)? "practitioners" : "patients");
			ps.setString(1, id);

			rs = ps.executeQuery();

			while (rs.next()) {
				String fName = rs.getString("FirstName");
				String lName = rs.getString("lastname");

				suInfo = new SessionUserInfo(id, role, fName, lName);
			}

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}
		return suInfo;
	}

	public Patient getSessionUserDetailInfo(Connection conn, String id) {

		Patient sudInfo = null;
		try {

			String sql = "SELECT * FROM patients WHERE login= ?";

			ps = conn.prepareStatement(sql);
			ps.setString(1, id);

			rs = ps.executeQuery();

			while (rs.next()) {
				long ohipNum = rs.getLong(1);
				String ohipVer = rs.getString(2);
				String fName = rs.getString(3);
				String lName = rs.getString(5);
				String gender = rs.getString(7);
				String birth = rs.getString(8);

				sudInfo = new Patient(ohipNum, ohipVer, fName, lName, id, gender, birth);
			}

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}
		return sudInfo;
	}

	public int updateUserProfile(Connection conn, Patient pa, String pw, ArrayList<PhoneNumber> pnList) {

		int result = 0;

		try {
			// patient table
			String sql = "UPDATE patients SET OHIPVersion = ?, FirstName = ?, LastName = ? WHERE OHIPNumber = ?";

			ps = conn.prepareStatement(sql);

			ps.setString(1, pa.getOhipVersion());
			ps.setString(2, pa.getfName());
			ps.setString(3, pa.getlName());
			ps.setLong(4, pa.getOhipNumber());

			result = ps.executeUpdate();

			// users
			sql = "UPDATE users SET PASSWORD = ? WHERE username = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, pw);
			ps.setString(2, pa.getLogin());
			result = ps.executeUpdate();

			// phone number
			sql = "DELETE FROM phonenumbers WHERE username = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, pa.getLogin());
			result = ps.executeUpdate();			

			sql = "INSERT INTO phonenumbers (phonenumber, username, phonetype) VALUES (?,?,?)";

			for (int i = 0; i < pnList.size(); i++) {
				ps = conn.prepareStatement(sql);
				ps.setLong(1, pnList.get(i).getPhoneNumber());
				ps.setString(2, pa.getLogin());
				ps.setString(3, pnList.get(i).getPhoneType());
				result = ps.executeUpdate();
			}			

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}

		return result;
	}

	public int createUserProfile(Connection conn, Patient pa, String pw, ArrayList<PhoneNumber> pnList) {

		int result = 0;

		try {
			// users
			String sql = "INSERT INTO users (username, role, PASSWORD) VALUES (?,2,?);";
			ps = conn.prepareStatement(sql);
			ps.setString(1, pa.getLogin());
			ps.setString(2, pw);
			result = ps.executeUpdate();

			// patient table
			sql = "INSERT INTO patients (OHIPNumber, OHIPVersion, FirstName, LastName, Login, Gender, DateOfBirth) \r\n"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?)";

			ps = conn.prepareStatement(sql);

			ps.setLong(1, pa.getOhipNumber());
			ps.setString(2, pa.getOhipVersion());
			ps.setString(3, pa.getfName());
			ps.setString(4, pa.getlName());
			ps.setString(5, pa.getLogin());
			ps.setString(6, pa.getGender());
			ps.setString(7, pa.getDateOfBirth());

			result = ps.executeUpdate();


			// phone number
			sql = "INSERT INTO phonenumbers (phonenumber, username, phonetype) VALUES (?,?,?)";

			for (int i = 0; i < pnList.size(); i++) {
				ps = conn.prepareStatement(sql);
				ps.setLong(1, pnList.get(i).getPhoneNumber());
				ps.setString(2, pa.getLogin());
				ps.setString(3, pnList.get(i).getPhoneType());
				result = ps.executeUpdate();
			}

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}

		return result;
	}

	public UserProfile viewUserProfile(Connection conn, String username) {

		UserProfile up = null;

		try {
			String sql = "SELECT u.username, u.password, p.OHIPNumber, p.OHIPVersion, p.FirstName, p.LastName, p.Gender, p.DateOfBirth \r\n"
					+ "  FROM users u, patients p\r\n" + " WHERE u.username = p.Login\r\n" + "   AND u.username = ?";

			ps = conn.prepareStatement(sql);
			ps.setString(1, username);

			rs = ps.executeQuery();

			while (rs.next()) {
				up = new UserProfile(rs.getString(1), rs.getString(2), rs.getLong(3), rs.getString(4), rs.getString(5),
						rs.getString(6), rs.getString(7), rs.getString(8));
			}

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}

		return up;
	}

	public ArrayList<PhoneNumber> viewPhoneNumbers(Connection conn, String username) {

		ArrayList<PhoneNumber> phList = new ArrayList<PhoneNumber>();
		PhoneNumber pn = null;

		try {
			String sql = "   SELECT * FROM phonenumbers WHERE phoneType = 'Home' AND username = ?\r\n" + 
					"UNION \r\n" + 
					"SELECT * FROM phonenumbers WHERE phoneType = 'Office' AND username = ?\r\n" + 
					"UNION\r\n" + 
					"SELECT * FROM phonenumbers WHERE phoneType = 'Work' AND username = ?\r\n" + 
					"UNION \r\n" + 
					"SELECT * FROM phonenumbers WHERE phoneType = 'Fax' AND username = ?";

			ps = conn.prepareStatement(sql);
			ps.setString(1, username);
			ps.setString(2, username);
			ps.setString(3, username);
			ps.setString(4, username);

			rs = ps.executeQuery();

			while (rs.next()) {
				pn = new PhoneNumber(rs.getLong(1), rs.getString(2), rs.getString(3));
				phList.add(pn);
			}

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}

		return phList;
	}

	public boolean userDupCheck(Connection conn, String username) {

		boolean result = true;
		try {
			String sql = "   SELECT COUNT(*) cnt FROM users WHERE username = ?";

			ps = conn.prepareStatement(sql);
			ps.setString(1, username);

			rs = ps.executeQuery();

			int num = 0;
			while(rs.next()) {
				num = rs.getInt(1);
			}
			
			if (num > 0) {
				result = false;
			}

		} catch (SQLException e) {
			System.err.println("SQLException: " + e.getMessage());
		} finally {
			DBConnection.closeJDBC(conn, ps, rs);
		}

		return result;
	}

}
