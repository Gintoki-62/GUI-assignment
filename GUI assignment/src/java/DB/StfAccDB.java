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
    private String host = "jdbc:derby://localhost:1527/userdb";
    private String user = "nbuser";
    private String password = "nbuser";
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
                    " SET UserName = ?, Email = ?, Password = ?, Gender = ? WHERE UserId = ?";
            System.out.println("\n***TRACE Line 63: sql string: " + updateStr);
            stmt = conn.prepareStatement(updateStr);
            System.out.println("\n***TRACE Line 65: sql string: " + updateStr);
            stmt.setString(1, stf.getName());
            stmt.setString(2, stf.getEmail());
            stmt.setString(3, stf.getPsw());
            System.out.println("\n***TRACE: sql string: " + updateStr);
            stmt.setString(4, String.valueOf(stf.getGender()));
            System.out.println("\n***TRACE: sql string: " + updateStr);
            stmt.setString(5, stf.getId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            // JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
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
   
   public boolean deleteRecord(String id)throws SQLException {
        try {
            String deleteStr = "DELETE FROM " + tableName + " WHERE UserId = ?";
            stmt = conn.prepareStatement(deleteStr);
            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
         //   JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
          throw ex;
        
        }
   
    }
   
   public int countStaff() throws SQLException {
        String countStr = "SELECT COUNT(PROFILE) FROM ACCOUNT";
        int count = 0;
        ResultSet rs = null;
        
        try {
            stmt = conn.prepareStatement(countStr);
            rs = stmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return count;
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
