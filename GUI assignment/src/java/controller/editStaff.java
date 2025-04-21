/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.StfAccDB;
import domain.StaffAccount;
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
public class editStaff extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String psw = request.getParameter("psw");
        char gender = request.getParameter("gender").charAt(0);

        StaffAccount staff = new StaffAccount();
        staff.setId(id);
        staff.setName(name);
        staff.setEmail(email);
        staff.setPsw(psw);
        staff.setGender(gender);

        try {
            StfAccDB db = new StfAccDB();
            db.updateRecord(staff);  // you can also use updateStaffAccount()
            
            // response.sendRedirect("AddStaffAccount.jsp");
            request.setAttribute("staffName", name);
            request.getRequestDispatcher("editStaffAccount.jsp").forward(request, response);
            
        } catch (Exception e) {
            response.getWriter().println("Update failed: " + e.getMessage());
        }
    }


}
