/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DB.StfAccDB;
import domain.StaffAccount;
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
public class AddStaff extends HttpServlet {
    
    private StfAccDB stf;
    
    @Override
    public void init() throws ServletException {
        try {
            stf = new StfAccDB();
        } catch (Exception ex) {
            Logger.getLogger(AddStaff.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String profile = request.getParameter("profile");
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String psw = request.getParameter("psw");
        char gender = request.getParameter("gender").charAt(0);
        
        try{
            StaffAccount s = new StaffAccount(profile, id, name, email, psw ,gender);
            stf.addRecord(s);
            response.sendRedirect("staffAcc.jsp");
            
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
