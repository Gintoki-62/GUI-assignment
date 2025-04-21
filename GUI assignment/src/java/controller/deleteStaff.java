/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.StfAccDB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class deleteStaff extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        
        try {
            StfAccDB db = new StfAccDB();
            boolean success = db.deleteRecord(id);
            
            if (success) {
                request.setAttribute("staffName", name);
                request.getRequestDispatcher("staffAcc.jsp").forward(request, response);
            } else {
                response.sendRedirect("staffAcc.jsp?deleteError=true");
            }
        } catch (Exception e) {
            response.sendRedirect("staffAcc.jsp?deleteError=true&message=" + e.getMessage());
        }
    }
}
