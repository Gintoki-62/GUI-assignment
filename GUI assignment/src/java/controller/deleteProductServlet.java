/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.ProductDB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class deleteProductServlet extends HttpServlet {

     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        
        try {
            ProductDB db = new ProductDB();
            boolean success = db.deleteRecord(id);
            
            if (success) {
                request.setAttribute("bookName", name);
                request.getRequestDispatcher("productAdmin.jsp").forward(request, response);
            } else {
                response.sendRedirect("productAdmin.jsp?deleteError=true");
            }
        } catch (Exception e) {
            response.sendRedirect("productAdmin.jsp?deleteError=true&message=" + e.getMessage());
        }
    }
}