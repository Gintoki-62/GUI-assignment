package controller;

import DB.bookDB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class UpdateUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String Id = request.getParameter("ID");
        String uname = request.getParameter("uname");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        try{
            bookDB DB = new bookDB();
            DB.updateUser(Id, uname, phone, address);

            response.sendRedirect("payCheckOut.jsp");
            
        }catch(Exception e){
           response.getWriter().println("Update failed: " + e.getMessage()); 
        }
        
        
        
    }
}
