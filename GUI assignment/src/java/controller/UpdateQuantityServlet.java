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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author tanan
 */
@WebServlet(urlPatterns = {"/UpdateQuantityServlet"})

public class UpdateQuantityServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
        throws ServletException, IOException {

        String bookId = request.getParameter("id");
        String action = request.getParameter("action"); 
        String userId = (String) request.getSession().getAttribute("name");

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
                    db.removeFromCart(userId, bookId);
                }
            }

            response.sendRedirect("shoping-cart.jsp"); 

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}

