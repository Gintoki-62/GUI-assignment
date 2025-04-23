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

        try {
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/userdb", "nbuser", "nbuser");

            // First check in manager table
            PreparedStatement psManager = conn.prepareStatement("SELECT * FROM manager WHERE managerid=? AND password=?");
            psManager.setString(1, username);
            psManager.setString(2, password);
            ResultSet rsManager = psManager.executeQuery();

            if (rsManager.next()) {
                isAuthenticated = true;
                role = "manager";
                profile = rsManager.getString("Profile"); // Assuming you have a profile image path column
                name = rsManager.getString("ManagerName"); // Assuming you have a name column
                id = rsManager.getString("ManagerId");
                psw = rsManager.getString("Password");
                email = rsManager.getString("Email");
    
                // Store more details if needed
            } else {
                // Then check in staff table
                PreparedStatement psStaff = conn.prepareStatement("SELECT * FROM ACCOUNT WHERE USERID=? AND PASSWORD=?");
                psStaff.setString(1, username);
                psStaff.setString(2, password);
                ResultSet rsStaff = psStaff.executeQuery();

                if (rsStaff.next()) {
                    isAuthenticated = true;
                    role = "staff";
                }
            }

            if (isAuthenticated) {
                HttpSession session = request.getSession();
                session.setAttribute("adminUser", username);
                session.setAttribute("E-mail", email);
                session.setAttribute("role", role);
                session.setAttribute("staffName", name);
                session.setAttribute("profileImage", profile);

                // Redirect to different dashboards (optional)
                if ("manager".equals(role)) {
                    
                    response.sendRedirect("Index2.jsp");
                } else {
                    response.sendRedirect("staffIndex.jsp");
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
