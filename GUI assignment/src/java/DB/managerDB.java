/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import domain.Manager;
import java.sql.*;

public class managerDB {
    private String host = "jdbc:derby://localhost:1527/bookloom";
    private String user = "ckj";
    private String password = "ckj";
    private String tableName = "Manager";
    private Connection conn;
    private PreparedStatement stmt;
    
    public managerDB() throws Exception {
        createConnection();  
    }
    
    public ResultSet getAllRecords() throws SQLException {
        String queryStr = "SELECT * FROM " + tableName;
        stmt = conn.prepareStatement(queryStr);
        return stmt.executeQuery();
    }
    
    public Manager getMangagerById(String id) throws SQLException {
        String queryStr = "SELECT * FROM " + tableName + " WHERE ManagerId = ?";
        Manager manager = null;

        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                manager = new Manager();
                manager.setProfile(rs.getString("Profile"));
                manager.setId(rs.getString("UserId"));
                manager.setName(rs.getString("UserName"));
                manager.setEmail(rs.getString("Email"));
                manager.setPsw(rs.getString("Password"));
            }
        } catch (SQLException ex) {
            throw ex;
        }

        return manager;
    }
    
    public void shutDown() throws SQLException{
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
               // JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
               throw ex;
            }
        }
    }
    
    private void createConnection() throws Exception {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
        } catch (ClassNotFoundException | SQLException ex) {
          //  JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
          throw ex;
        }
    }
    
    public static void main(String[] args) throws Exception {
        managerDB manager = new managerDB();
    }
}
