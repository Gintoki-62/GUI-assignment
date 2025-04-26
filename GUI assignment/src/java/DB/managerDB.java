/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import domain.Manager;
import domain.Manager_1;
import java.sql.*;
import javax.persistence.EntityManager;

public class managerDB {
    private String host = "jdbc:derby://localhost:1527/userdb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "Manager";
    private Connection conn;
    private PreparedStatement stmt;
    EntityManager em;
    
    public managerDB() throws Exception {
        createConnection();  
    }
    
    public ResultSet getAllRecords() throws SQLException {
        String queryStr = "SELECT * FROM " + tableName;
        stmt = conn.prepareStatement(queryStr);
        return stmt.executeQuery();
    }
    
    public Manager_1 getManagerById(String id) throws SQLException {
        Manager_1 manager = em.find(Manager_1.class, id);
        String queryStr = "SELECT * FROM " + tableName + " WHERE ManagerId = ?";

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
