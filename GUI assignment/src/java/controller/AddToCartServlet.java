/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.bookDB;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author tanan
 */
public class AddToCartServlet extends HttpServlet {

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        request.setCharacterEncoding("UTF-8");
        
        // Get user ID from session
//        String userId = (String) request.getSession().getAttribute("username");
          String userId = "user123";

        // Make sure user is logged in
        if (userId == null) {
            response.sendRedirect("login.jsp"); // or any login page
            return;
        }

        // Get bookId and quantity from form
        String bookId = request.getParameter("bookId");
        String quantityStr = request.getParameter("quantity");
        String bookname = request.getParameter("name");

        // Validate input
        if (bookId == null || quantityStr == null || quantityStr.isEmpty()) {
            response.getWriter().println("Missing bookId or quantity.");
            return;
        }

        try {
            int quantity = Integer.parseInt(quantityStr);

            bookDB bookDB = new bookDB();
            String cartId = bookDB.CreateCartId(userId);
            bookDB.addToCart(userId, bookId, cartId, quantity);

            response.sendRedirect("product.jsp?added=true&bookname=" + URLEncoder.encode(bookname, "UTF-8"));
            // Redirect to cart page
//            response.sendRedirect("product.jsp");

        } catch (NumberFormatException e) {
            response.getWriter().println("Invalid quantity format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error adding to cart: " + e.getMessage());
        }
    }
}
    

