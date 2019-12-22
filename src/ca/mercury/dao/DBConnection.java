/*
 * A class used to establish JDBC Connections.
 */

package ca.mercury.dao;

import java.sql.*;


public class DBConnection {
    private String url = "jdbc:mysql://localhost:3306/mercury";
    private String username = "root";
    private String password = "";
    
    public DBConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch(ClassNotFoundException e) {
            System.out.println("ERROR: Exception loading driver class");
        }
    }

    public Connection getConnection() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            System.err.println("Exception creating Connection object");
        } finally {
            return conn;
        }
        
    }
    
    public static void closeJDBC(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
            
            if (stmt != null) {
                stmt.close();
            }
            
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException ignored) {
        }
    }
    
    public static void closeJDBC(Connection conn, Statement stmt) {
    	closeJDBC(conn, stmt, null);
    }
}
