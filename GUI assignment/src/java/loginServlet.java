import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/loginServlet"})
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
                // Get user details from DB
                String name = rs.getString("name");
                String email = rs.getString("email");
                String gender = rs.getString("gender");
                String phone = rs.getString("phone");
                String address = rs.getString("address");

                // Login success - set session attributes
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("name", name);
                session.setAttribute("email", email);
                session.setAttribute("gender", gender);
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);

                // Redirect to homepage
                response.sendRedirect("about.jsp");
            } else {
                // Login failed
                response.sendRedirect("login.jsp?error=invalid");
            }

            // Clean up
            rs.close();
            pst.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=exception");
        }
    }
}
