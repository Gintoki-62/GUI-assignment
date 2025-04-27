/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import domain.Manager_1;
import java.sql.*;
import javax.annotation.Resource;
import javax.persistence.*;
import javax.transaction.Transactional;
import javax.transaction.UserTransaction;

public class managerDB {
    private String host = "jdbc:derby://localhost:1527/userdb";
    private String user = "nbuser";
    private String password = "nbuser";
    private String tableName = "MANAGER";
    private Connection conn;
    private PreparedStatement stmt;

    private EntityManager em;

    public managerDB() throws Exception {
        createConnection();
    }

    public ResultSet getAllRecords() throws SQLException {
        String sql = "SELECT * FROM " + tableName;
        PreparedStatement ps = conn.prepareStatement(sql);
        return ps.executeQuery();
    }

    public Manager_1 getManagerById(String id) throws SQLException {
        String sql = "SELECT PROFILE, MANAGERID, MANAGERNAME, PASSWORD, EMAIL "
                   + "FROM " + tableName + " WHERE MANAGERID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }
                Manager_1 m = new Manager_1(rs.getString("MANAGERID"),
                                            rs.getString("MANAGERNAME"));
                m.setProfile(rs.getString("PROFILE"));
                m.setPassword(rs.getString("PASSWORD"));
                m.setEmail(rs.getString("EMAIL"));
                return m;
            }
        }
    }

    public void updateRecord(Manager_1 manager) throws SQLException {
        String sql = "UPDATE MANAGER SET MANAGERNAME = ?, EMAIL = ?, PASSWORD = ? WHERE MANAGERID = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, manager.getName());
            ps.setString(2, manager.getEmail());
            ps.setString(3, manager.getPassword());
            ps.setString(4, manager.getId());
            int rows = ps.executeUpdate();
            if (rows == 0) {
                throw new SQLException("No manager found with ID " + manager.getId());
            }
        }
    }


    public void shutDown() throws SQLException {
        if (conn != null && !conn.isClosed()) {
            conn.close();
        }
    }

    private void createConnection() throws Exception {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
        } catch (ClassNotFoundException | SQLException ex) {
            throw ex;
        }
    }

    public static void main(String[] args) throws Exception {
        managerDB manager = new managerDB();
        // Example usage (testing)
        Manager_1 m = manager.getManagerById("someID");
        if (m != null) {
            System.out.println("Manager found: " + m.getName());  // assuming you have getName() method
        }
        manager.shutDown();
    }
}
