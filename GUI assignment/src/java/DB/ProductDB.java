/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

/**
 *
 * @author User
 */

import domain.Product;
import java.sql.*;
import javax.swing.*;

public class ProductDB {
    private String host = "jdbc:derby://localhost:1527/bookLoomDB;create=true";
    private String user = "book";
    private String password = "book";
    private String tableName = "Book";
    private Connection conn;
    private PreparedStatement stmt;
    
    public ProductDB() throws Exception {
        createConnection();  
    }
    
    public void addRecord(Product prd) throws SQLException {
        String insertStr = "INSERT INTO " + tableName + " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            stmt = conn.prepareStatement(insertStr);
            stmt.setString(1, prd.getBookId());
            stmt.setString(2, prd.getBookName());
            stmt.setDouble(3, prd.getPrice());
            stmt.setString(4, prd.getAuthor());
            stmt.setString(5, prd.getPublisher());
            stmt.setInt(6, prd.getNoPages());
            stmt.setString(7, prd.getDescription());
            stmt.setInt(8, prd.getQuantity());
            stmt.setString(9, prd.getType());
            stmt.setString(10, prd.getImage());
            stmt.setString(11, prd.getCategory());
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

   public void updateRecord(Product prd)throws SQLException {
        try {
            String updateStr = "UPDATE " + tableName + 
                    " SET BOOK_NAME = ?, BOOK_PRICE = ?, AUTHOR_NAME = ?, PUBLISHER = ?, "
                    + "NO_OF_PAGES = ?, BOOK_DESC = ?, BOOK_QUANTITY = ?, BOOK_TYPE = ?, "
                    + "BOOK_CATEGORY = ? WHERE BOOK_ID = ?";
            System.out.println("\n***TRACE Line 63: sql string: " + updateStr);
            stmt = conn.prepareStatement(updateStr);
            System.out.println("\n***TRACE Line 65: sql string: " + updateStr);
            stmt.setString(1, prd.getBookName());
            stmt.setDouble(2, prd.getPrice());
            stmt.setString(3, prd.getAuthor());
            stmt.setString(4, prd.getPublisher());
            stmt.setInt(5, prd.getNoPages());
            stmt.setString(6, prd.getDescription());
            stmt.setInt(7, prd.getQuantity());
            stmt.setString(8, prd.getType());
            stmt.setString(9, prd.getCategory());
            stmt.setString(10, prd.getBookId());
            stmt.executeUpdate();
        } catch (SQLException ex) {
            // JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
            throw ex;
        }
    }
   
    public Product getProductById(String id) throws SQLException {
        String queryStr = "SELECT * FROM " + tableName + " WHERE BOOK_ID = ?";
        Product prd = null;

        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                prd = new Product();
                prd.setBookId(rs.getString("BOOK_ID"));
                prd.setBookName(rs.getString("BOOK_NAME"));
                prd.setPrice(rs.getDouble("BOOK_PRICE"));
                prd.setAuthor(rs.getString("AUTHOR_NAME"));
                prd.setPublisher(rs.getString("PUBLISHER"));
                prd.setNoPages(rs.getInt("NO_OF_PAGES"));
                prd.setDescription(rs.getString("BOOK_DESC"));
                prd.setQuantity(rs.getInt("BOOK_QUANTITY"));
                prd.setImage(rs.getString("BOOK_IMAGE"));
                prd.setType(rs.getString("BOOK_TYPE"));
                prd.setCategory(rs.getString("BOOK_CATEGORY"));
                
            }
        } catch (SQLException ex) {
            throw ex;
        }

        return prd;
    }
   
   public boolean deleteRecord(String id)throws SQLException {
        try {
            String deleteStr = "DELETE FROM " + tableName + " WHERE BOOK_ID = ?";
            stmt = conn.prepareStatement(deleteStr);
            stmt.setString(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
         //   JOptionPane.showMessageDialog(null, ex.getMessage(), "ERROR", JOptionPane.ERROR_MESSAGE);
          throw ex;
        
        }
   
    }
   
    public int countOrder() throws SQLException {
        String countStr = "SELECT COUNT(order_id) FROM ORDERS";
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
    
    public double sumTotalAmount() throws SQLException {
        String sumStr = "SELECT SUM(AMOUNT) FROM PAYMENT";
        double total = 0.0;
        ResultSet rs = null;

        try {
            stmt = conn.prepareStatement(sumStr);
            rs = stmt.executeQuery();

            if (rs.next()) {
                total = rs.getDouble(1); // get the SUM result
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return total;
    }
    
    public double avgTotalAmount() throws SQLException {
        String avgStr = "SELECT AVG(AMOUNT) FROM PAYMENT";
        double avg = 0.0;
        ResultSet rs = null;

        try {
            stmt = conn.prepareStatement(avgStr);
            rs = stmt.executeQuery();

            if (rs.next()) {
                avg = rs.getDouble(1); // get the AVG result
            }
        } catch (SQLException ex) {
            throw ex;
        }
        return avg;
    }
    
    public String[] mostOrderedBookWithQuantity() throws SQLException {
        String[] result = new String[2]; // result[0] = book name, result[1] = total quantity

        String sql = "SELECT BOOK_NAME, SUM(QUANTITY) AS total_quantity " +
                     "FROM ORDER_ITEMS " +
                     "GROUP BY BOOK_NAME " +
                     "ORDER BY total_quantity DESC " +
                     "FETCH FIRST 1 ROWS ONLY"; // Use LIMIT 1 if not Derby/Oracle
        ResultSet rs = null;
        try {
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                result[0] = rs.getString("BOOK_NAME");
                result[1] = String.valueOf(rs.getInt("total_quantity"));
            }
        } catch (SQLException ex) {
            throw ex;
        }

        return result;
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
        ProductDB prd = new ProductDB();
    }
    
}
