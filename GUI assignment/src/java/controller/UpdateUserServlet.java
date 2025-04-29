package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class UpdateUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String uname = request.getParameter("uname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String Id = request.getParameter("ID");
        
        try {
            Connection con = DriverManager.getConnection("jdbc:derby://localhost:1527/userdb", "nbuser", "nbuser");

            String sql = "UPDATE REGISTER SET USERNAME = ?, PHONE = ?, ADDRESS = ? WHERE NAME = ?";
            PreparedStatement stmts = con.prepareStatement(sql);

            stmts.setString(1, uname);     
            stmts.setString(2, phone);       
            stmts.setString(3, address);
            stmts.setString(4, Id);

            int rowsUpdated = stmts.executeUpdate();

            if (rowsUpdated > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("username", uname);
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);

                response.sendRedirect("payCheckOut.jsp");
            } else {
                response.getWriter().println("Update failed: User not found or no changes made.");
            }

        } catch (Exception e) {
            response.getWriter().println("Update failed: " + e.getMessage());
        }
    }
}
