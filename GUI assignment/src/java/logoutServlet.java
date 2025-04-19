import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(urlPatterns= {"/logoutServlet"})
public class logoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get current session
        if (session != null) {
            session.invalidate(); // End the session
        }
        response.sendRedirect("about.jsp"); // Redirect to login page
    }
}
