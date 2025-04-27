/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.managerDB;
import domain.Manager_1;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class editProfileServlet extends HttpServlet {

    @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("ManagerName");
        String id = request.getParameter("ManagerID");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        Manager_1 mnr = new Manager_1();
        mnr.setId(id);
        mnr.setName(name);
        mnr.setPassword(password);
        mnr.setEmail(email);

        try {
            managerDB db = new managerDB();
            db.updateRecord(mnr);

            // Set all updated values in request
            request.setAttribute("ManagerName", name);
            request.setAttribute("ManagerID", id);
            request.setAttribute("password", password);
            request.setAttribute("email", email);
            
            request.getRequestDispatcher("profileManager.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "Update failed: " + e.getMessage());
            request.getRequestDispatcher("profileManager.jsp").forward(request, response);
        }
    }
}
