/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

/**
 *
 * @author User
 */

import domain.StaffAccount;
import java.sql.*;
import javax.swing.*;

public class StfAccDB {
    private String host = "jdbc:derby://localhost:1527/bookloom";
    private String user = "ckj";
    private String password = "ckj";
    private String tableName = "Account";
    private Connection conn;
    private PreparedStatement stmt;
    
    public StfAccDB() throws Exception {
        createConnection();  
    }
    
    public void addRecord(StaffAccount stf) throws SQLException {
        String insertStr = "INSERT INTO " + tableName + " VALUES(?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, stf.getProfile());
            stmt.setString(2, stf.getId());
            stmt.setString(3, stf.getName());
            stmt.setString(4, stf.getEmail());
            stmt.setString(5, stf.getPsw());
            stmt.setString(6, String.valueOf(stf.getGender()));
            stmt.executeUpdate();
        } catch (SQLException ex) {
          //  JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
          throw ex;
        }
    }
    
    public ResultSet getAllRecords() throws SQLException {
        String queryStr = "SELECT * FROM " + tableName;
        stmt = conn.prepareStatement(queryStr);
        return stmt.executeQuery();
    }
    
   public void updateRecord(StaffAccount stf)throws SQLException {
        try {
            String updateStr = "UPDATE " + tableName + 
                    " SET Profile = ?, UserName = ?, Email = ?, Password = ?, Gender = ? WHERE UserId = ?";
            System.out.println("\n***TRACE Line 63: sql string: " + updateStr);
            stmt = conn.prepareStatement(updateStr);
            System.out.println("\n***TRACE Line 65: sql string: " + updateStr);
            stmt.setString(1, stf.getProfile());
            stmt.setString(2, stf.getName());
            stmt.setString(3, stf.getEmail());
            stmt.setString(4, stf.getPsw());
            System.out.println("\n***TRACE: sql string: " + updateStr);
            stmt.setString(5, String.valueOf(stf.getGender()));
            System.out.println("\n***TRACE: sql string: " + updateStr);
            stmt.setString(6, stf.getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            // JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            throw ex;
        }
    }
   
   public boolean updateStaffAccount(StaffAccount staff) throws SQLException {
        String updateStr = "UPDATE " + tableName + " SET Profile = ?, UserName = ?, " +
                          "Email = ?, Password = ?, Gender = ? WHERE UserId = ?";

        try {
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, staff.getProfile());
            stmt.setString(2, staff.getName());
            stmt.setString(3, staff.getEmail());
            stmt.setString(4, staff.getPsw());
            stmt.setString(5, String.valueOf(staff.getGender()));
            stmt.setString(7, staff.getId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            throw ex;
        }
    }

    public StaffAccount getStaffById(String id) throws SQLException {
        String queryStr = "SELECT * FROM " + tableName + " WHERE UserId = ?";
        StaffAccount staff = null;

        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                staff = new StaffAccount();
                staff.setProfile(rs.getString("Profile"));
                staff.setId(rs.getString("UserId"));
                staff.setName(rs.getString("UserName"));
                staff.setEmail(rs.getString("Email"));
                staff.setPsw(rs.getString("Password"));
                staff.setGender(rs.getString("Gender").charAt(0));
            }
        } catch (SQLException ex) {
            throw ex;
        }

        return staff;
    }
   
   public void deleteRecord(String id)throws SQLException {
        try {
            String deleteStr = "DELETE FROM " + tableName + " WHERE UserId = ?";
            stmt = conn.prepareStatement(deleteStr);
            stmt.setString(1, id);
            stmt.executeUpdate();

        } catch (SQLException ex) {
         //   JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
          throw ex;
        
        }
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
        StfAccDB stf = new StfAccDB();
    }
    
}
