import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class adminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean isAuthenticated = false;
        String role = "";
        String name = "";
        String id = "";
        String psw = "";
        String email = "";
        String profile = "null";
        String userid = "";
        String gender = "";
        
        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/userdb", "nbuser", "nbuser");

            
            PreparedStatement psManager = conn.prepareStatement("SELECT * FROM manager WHERE managerid=? AND password=?");
            psManager.setString(1, username);
            psManager.setString(2, password);
            ResultSet rsManager = psManager.executeQuery();

            if (rsManager.next()) {
                isAuthenticated = true;
                role = "manager";
                profile = rsManager.getString("Profile"); 
                name = rsManager.getString("ManagerName"); 
                id = rsManager.getString("ManagerId");
                psw = rsManager.getString("Password");
                email = rsManager.getString("Email");
    
                
            } else {
                
                PreparedStatement psStaff = conn.prepareStatement("SELECT * FROM ACCOUNT WHERE USERID=? AND PASSWORD=?");
                psStaff.setString(1, username);
                psStaff.setString(2, password);
                ResultSet rsStaff = psStaff.executeQuery();

                if (rsStaff.next()) {
                    isAuthenticated = true;
                    role = "staff";
                    userid = rsStaff.getString("USERID");
                    name = rsStaff.getString("USERNAME");
                    email = rsStaff.getString("EMAIL");
                    gender = rsStaff.getString("GENDER");
                    profile = rsStaff.getString("PROFILE");
                }
            }

            if (isAuthenticated) {
            HttpSession session = request.getSession();

            if ("staff".equals(role)) {
                session.setAttribute("userid", userid);
                session.setAttribute("name", name);
                session.setAttribute("email", email);
                session.setAttribute("gender", gender);
                session.setAttribute("role", role);
                session.setAttribute("profileImage", profile);
                response.sendRedirect("staffIndex.jsp");
                
            } else if ("manager".equals(role)) {
                session.setAttribute("adminUser", username);
                session.setAttribute("Email", email);
                session.setAttribute("role", role);
                session.setAttribute("ManagerName", name);
                session.setAttribute("profileImage", profile);
                session.setAttribute("Password", password);

                response.sendRedirect("Index2.jsp");
            }
        } else {
            response.sendRedirect("adminlogin.jsp?error=invalid");
        }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminlogin.jsp?error=invalid");
        }
    }
}
