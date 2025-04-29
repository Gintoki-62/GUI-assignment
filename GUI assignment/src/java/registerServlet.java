import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import domain.UserBean;

@WebServlet(urlPatterns = {"/registerServlet"})
public class registerServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Populate bean with request data
        UserBean user = new UserBean();
        user.setName(request.getParameter("name"));
        user.setUsername(request.getParameter("username"));
        user.setPassword(request.getParameter("password"));
        user.setConfirmPassword(request.getParameter("confirmPassword"));
        user.setEmail(request.getParameter("email"));
        user.setGender(request.getParameter("gender"));
        user.setPhone(request.getParameter("phone"));
        user.setAddress(request.getParameter("address"));

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Validation
        if (!user.getPassword().equals(user.getConfirmPassword())) {
            out.println("<script>alert('Passwords do not match!'); window.history.back();</script>");
            return;
        }

        if (!user.getEmail().matches("^\\S+@\\S+\\.\\S+$")) {
            out.println("<script>alert('Invalid email format!'); window.history.back();</script>");
            return;
        }

        if (!user.getPhone().matches("^\\d{10,11}$")) {
            out.println("<script>alert('Invalid phone number!'); window.history.back();</script>");
            return;
        }

        // Database operations
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(
                "jdbc:derby://localhost:1527/userdb", "nbuser", "nbuser");

            String sql = "INSERT INTO NBUSER.REGISTER (name, username, password, email, gender, phone, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, user.getName());
            pst.setString(2, user.getUsername());
            pst.setString(3, user.getPassword());
            pst.setString(4, user.getEmail());
            pst.setString(5, user.getGender());
            pst.setString(6, user.getPhone());
            pst.setString(7, user.getAddress());

            int result = pst.executeUpdate();

            if (result > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("name", user.getName());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("gender", user.getGender());
                session.setAttribute("phone", user.getPhone());
                session.setAttribute("address", user.getAddress());

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
