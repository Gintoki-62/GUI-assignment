/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.bookDB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author tanan
 */
public class ProcessPaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form inputs
        String method = request.getParameter("method");
        String bank = request.getParameter("bank");
        String wallet = request.getParameter("e-wallet");
        String amount = request.getParameter("amount");
        String userId = request.getParameter("user_id");

        // Call DB insert logic
        boolean success = bookDB.insertPayment(userId, method, bank, wallet, amount);

        if (success) {
            response.sendRedirect("shoping-cart.jsp");
        } else {
            response.getWriter().println("Failed to insert payment.");
        }
    }
}