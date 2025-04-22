/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.bookDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author tanan
 */
public class ProcessPaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form inputs
        String method = request.getParameter("method");
        String bank = request.getParameter("bank");
        String wallet = request.getParameter("e-wallet");
        String amount = request.getParameter("amount");
        String userId = request.getParameter("user_id");
        
        // Generate UUID for payment_id
        String transactionId = UUID.randomUUID().toString();
        String orderId = UUID.randomUUID().toString();

        bookDB DB = new bookDB();
        try {
            DB.createOrder(orderId, userId, amount);
            DB.addOrder(orderId, userId);
            
        // Call DB insert logic
        boolean success = bookDB.insertPayment(transactionId, orderId, userId, method, bank, wallet, amount);
        
        if (success) {
            // Delete all items from the user's cart
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/bookLoomDB", "book", "book");
            String deleteCartSql = "DELETE FROM CART WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(deleteCartSql);
            stmt.setString(1, userId);
            stmt.executeUpdate();
   
            response.sendRedirect("shoping-cart.jsp");
        } else {
            response.getWriter().println("Failed to insert payment.");
        }
        
        } catch (SQLException ex) {
            Logger.getLogger(ProcessPaymentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        


    }
}