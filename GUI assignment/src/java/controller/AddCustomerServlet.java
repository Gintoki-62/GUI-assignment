/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.CustomerDB;
import domain.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class AddCustomerServlet extends HttpServlet {

    private CustomerDB customer;
    
    @Override
    public void init() throws ServletException {
        try {
            customer = new CustomerDB();
        } catch (Exception ex) {
            Logger.getLogger(AddCustomerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
        
        String name = request.getParameter("name");
        String username = request.getParameter("UserName");
        String gender = request.getParameter("gender");
        String password = request.getParameter("psw");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        try{
            Customer c = new Customer(name, phone, email, username, 
                    password, gender, address);
            customer.addRecord(c);
        
            // response.sendRedirect("AddStaffAccount.jsp");
            request.setAttribute("CustomerName", name);
            request.getRequestDispatcher("AddCustomer.jsp").forward(request, response);

            
        }catch(Exception ex){
                out.println(ex.getMessage());
            }finally{
            out.close();
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */


}
