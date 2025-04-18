import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class loginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Load JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Connect to Derby database
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/userdb", "nbuser", "nbuser");

            // SQL query to check user
            String sql = "SELECT * FROM NBUSER.REGISTER WHERE username = ? AND password = ?";

            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Login success - set session
                HttpSession session = request.getSession();
                session.setAttribute("username", username);

                // Redirect to homepage (or welcome.jsp if you prefer)
                response.sendRedirect("about.jsp");
            } else {
                // Login failed - show error message
                response.sendRedirect("login.jsp?error=invalid");
            }

            // Close database resources
            rs.close();
            pst.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
