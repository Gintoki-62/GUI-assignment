import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import domain.loginBean;

@WebServlet(urlPatterns = {"/loginServlet"})
public class loginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
        
        // Use JavaBean to store login data
        loginBean login = new loginBean();
        login.setUsername(request.getParameter("username"));
        login.setPassword(request.getParameter("password"));

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/userdb", "nbuser", "nbuser");

            String sql = "SELECT * FROM NBUSER.REGISTER WHERE username = ? AND password = ?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, login.getUsername());
            pst.setString(2, login.getPassword());

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                // Get user details from DB
                String name = rs.getString("name");
                String email = rs.getString("email");
                String gender = rs.getString("gender");
                String phone = rs.getString("phone");
                String address = rs.getString("address");

                // Save to session
                HttpSession session = request.getSession();
                session.setAttribute("username", login.getUsername());
                session.setAttribute("name", name);
                session.setAttribute("email", email);
                session.setAttribute("gender", gender);
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);

                response.sendRedirect("about.jsp");
            } else {
                response.sendRedirect("login.jsp?error=invalid");
            }

            rs.close();
            pst.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=exception");
        }
    }
}
