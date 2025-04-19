import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;

@WebServlet(urlPatterns = {"/registerServlet"})
public class registerServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form inputs
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Set response content type
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Simple validation
        if (!password.equals(confirmPassword)) {
            out.println("<script>alert('Passwords do not match!'); window.history.back();</script>");
            return;
        }

        // Email format check
        if (!email.matches("^\\S+@\\S+\\.\\S+$")) {
            out.println("<script>alert('Invalid email format!'); window.history.back();</script>");
            return;
        }

        // Phone number check (basic 10 digits)
        if (!phone.matches("^\\d{10,}$")) {
            out.println("<script>alert('Invalid phone number!'); window.history.back();</script>");
            return;
        }

        try {
            // Connect to Java DB (Derby)
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/userdb", "nbuser", "nbuser");

            String sql = "INSERT INTO NBUSER.REGISTER (name, username, password, email, gender, phone, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, username);
            pst.setString(3, password);
            pst.setString(4, email);
            pst.setString(5, gender);
            pst.setString(6, phone);
            pst.setString(7, address);

            int result = pst.executeUpdate();

            if (result > 0) {
                // Save details to session
                HttpSession session = request.getSession();
                session.setAttribute("name", name);
                session.setAttribute("username", username);
                session.setAttribute("email", email);
                session.setAttribute("gender", gender);
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);

                response.sendRedirect("login.jsp");
            } else {
                response.sendRedirect("register.jsp?error=InsertFailed");
            }

            pst.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "'); window.history.back();</script>");
        }
    }
}
