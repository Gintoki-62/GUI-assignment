import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class staffCheckStatusServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String orderId = request.getParameter("orderId");
        String newStatus = request.getParameter("status");
        
        Connection conn = null;
        PreparedStatement ps = null;
        
        try {

            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/bookLoomDB", "book", "book");
            
            // Update order status
            String sql = "UPDATE ORDERS SET STATUS = ? WHERE ORDER_ID = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, newStatus);
            ps.setString(2, orderId);
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                request.setAttribute("message", "Order #" + orderId + " status updated successfully to " + newStatus);
                request.setAttribute("messageType", "success");
            } else {
                request.setAttribute("message", "Failed to update order #" + orderId);
                request.setAttribute("messageType", "error");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error updating order status: " + e.getMessage());
            request.setAttribute("messageType", "error");
        } finally {
            // Close resources
            try { if (ps != null) ps.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
        
        
        request.setAttribute("message", "Order status updated successfully.");
        request.getRequestDispatcher("staffCheckStatus.jsp").forward(request, response);
    }
}