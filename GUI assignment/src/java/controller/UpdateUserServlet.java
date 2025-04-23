package controller;

import DB.bookDB;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class UpdateUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
//        int Id = Integer.parseInt(request.getParameter("ID"));
        String uname = request.getParameter("uname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        try{
//            bookDB DB = new bookDB();
//            DB.updateUser(Id, uname, phone, address);
            
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/userdb", "nbuser", "nbuser");
            String sql = "UPDATE REGISTER SET PHONE = ?, ADDRESS = ? WHERE username = ? ";
            PreparedStatement stmts = con.prepareStatement(sql);
//            stmts.setString(1, uname);
            stmts.setString(1, phone);
            stmts.setString(2, address);
            stmts.setString(3, uname);
//            stmts.setInt(4, Id);
            stmts.executeUpdate();

            response.sendRedirect("payCheckOut.jsp");
            
        }catch(Exception e){
           response.getWriter().println("Update failed: " + e.getMessage()); 
        }
        
        
        
    }
}
