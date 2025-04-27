import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(urlPatterns= {"/staffLogoutServlet"})
public class staffLogoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Get current session
        if (session != null) {
            session.invalidate(); // End session
        }
        response.sendRedirect("about.jsp"); // Redirect to main page aka about page
    }
}