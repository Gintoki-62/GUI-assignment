/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.CustomerDB;
import domain.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class editCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String ID = request.getParameter("id");
        String name = request.getParameter("name");
        String username = request.getParameter("UserName");
        String gender = request.getParameter("gender");
        String password = request.getParameter("psw");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        int id = Integer.parseInt(ID);
        
        Customer customer = new Customer();
        customer.setCusID(id);
        customer.setCusName(name);
        customer.setCusUserName(username);
        customer.setCusGender(gender);
        customer.setCusPsw(password);
        customer.setCusEmail(email);
        customer.setCusPhone(phone);
        customer.setAddress(address);
       

        try {
            CustomerDB db = new CustomerDB();
            db.updateRecord(customer);  
            
            // response.sendRedirect("editCustomer.jsp");
            request.setAttribute("CustomerName", name);
            request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            
        } catch (Exception e) {
            response.getWriter().println("Update failed: " + e.getMessage());
        }
    }


}
