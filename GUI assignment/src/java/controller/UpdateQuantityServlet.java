/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.bookDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author tanan
 */
public class UpdateQuantityServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        String bookId = request.getParameter("id");
        String action = request.getParameter("action"); // "update" or "delete"
        String userId = "user123"; // Replace with session-based user ID if needed

        try {
            bookDB db = new bookDB();

            if ("update".equals(action)) {
                String quantityStr = request.getParameter("quantity");

                if (bookId != null && quantityStr != null) {
                    int quantity = Integer.parseInt(quantityStr);
                    db.updateQuantity(userId, bookId, quantity);
                }

            } else if ("delete".equals(action)) {
                if (bookId != null) {
                    db.removeFromCart(userId, bookId); // Make sure this method exists in bookDB
                }
            }

            response.sendRedirect("shoping-cart.jsp"); // Back to cart

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

