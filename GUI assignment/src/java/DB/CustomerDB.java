/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

/**
 *
 * @author User
 */
import domain.Customer;
import java.sql.*;
import javax.swing.*;

public class CustomerDB {
    private String host = "jdbc:derby://localhost:1527/userdb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Register";
    private Connection conn;
    private PreparedStatement stmt;
    
     public CustomerDB() throws Exception {
        createConnection();  
    }
    
    public void addRecord(Customer cus) throws SQLException {
        String insertStr = "INSERT INTO " + tableName + " (name, username, password, email, "
                + "gender, phone, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, cus.getCusName());
            stmt.setString(2, cus.getCusUserName());
            stmt.setString(3, cus.getCusPsw());
            stmt.setString(4, cus.getCusEmail());
            stmt.setString(5, cus.getCusGender());
            stmt.setString(6, cus.getCusPhone());
            stmt.setString(7, cus.getAddress());
            
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
    
   public void updateRecord(Customer cus)throws SQLException {
        try {
            String updateStr = "UPDATE " + tableName + 
                    " SET NAME = ?, USERNAME = ?, Password = ?, EMAIL = ?, GENDER = ?, PHONE = ?, ADDRESS = ? WHERE ID = ?";
            System.out.println("\n***TRACE Line 63: sql string: " + updateStr);
            stmt = conn.prepareStatement(updateStr);
            stmt.setString(1, cus.getCusName());
            stmt.setString(2, cus.getCusUserName());
            stmt.setString(3, cus.getCusPsw());
            stmt.setString(4, cus.getCusEmail());
            stmt.setString(5, cus.getCusGender());
            stmt.setString(6, cus.getCusPhone());
            stmt.setString(7, cus.getAddress());
            stmt.setInt(8, cus.getCusID());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            // JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            throw ex;
        }
    }
   
    public Customer getCustomerById(String id) throws SQLException {
        String queryStr = "SELECT * FROM " + tableName + " WHERE id = ?";
        Customer customer = null;

        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                customer = new Customer();
                customer.setCusID(rs.getInt("ID"));
                customer.setCusName(rs.getString("NAME"));
                customer.setCusPhone(rs.getString("PHONE"));
                customer.setCusEmail(rs.getString("EMAIL"));
                customer.setCusUserName(rs.getString("USERNAME"));
                customer.setCusPsw(rs.getString("PASSWORD"));
                customer.setCusGender(rs.getString("GENDER"));
                customer.setAddress(rs.getString("ADDRESS"));
                
            }
        } catch (SQLException ex) {
            throw ex;
        }

        return customer;
    }
   
   public boolean deleteRecord(String id)throws SQLException {
        try {
            String deleteStr = "DELETE FROM " + tableName + " WHERE ID = ?";
            stmt = conn.prepareStatement(deleteStr);
            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
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
        CustomerDB stf = new CustomerDB();
    }
}
