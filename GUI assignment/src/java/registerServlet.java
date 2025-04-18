import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class registerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        try {
            // Load Derby JDBC driver (optional but good practice)
            Class.forName("org.apache.derby.jdbc.ClientDriver");

            // Fixed typo in JDBC URL (jjdbc -> jdbc)
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/userdb", "nbuser", "nbuser");

            String sql = "INSERT INTO NBUSER.REGISTER (username, password, email) VALUES (?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, username);
            pst.setString(2, password);
            pst.setString(3, email);

            int result = pst.executeUpdate();
            if (result > 0) {
                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect("register.jsp?error=failed");
            }

            // Optional: close resources
            pst.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
