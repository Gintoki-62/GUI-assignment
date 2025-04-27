import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(urlPatterns = {"/reportServlet"})
public class reportServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("top10".equals(action)) {
            handleTop10Report(request, response);
        } else if ("daymonthyear".equals(action)) {
            handleDayMonthYearReport(request, response);
        } else {
            response.sendRedirect("report.jsp"); 
        }
    }

    private void handleTop10Report(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        List<Map<String, Object>> top10List = new ArrayList<>();
        
        try {
            Connection conn = getConnection();
            String sql = "SELECT BOOK_NAME, SUM(QUANTITY) AS TOTAL_SOLD " +
                         "FROM ORDER_ITEMS " +
                         "GROUP BY BOOK_NAME " +
                         "ORDER BY TOTAL_SOLD DESC " +
                         "FETCH FIRST 10 ROWS ONLY";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> record = new HashMap<>();
                record.put("bookName", rs.getString("BOOK_NAME"));
                record.put("totalSold", rs.getInt("TOTAL_SOLD"));
                top10List.add(record);
            }
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error generating top 10 report: " + e.getMessage());
        }
        
        request.setAttribute("top10List", top10List);
        RequestDispatcher dispatcher = request.getRequestDispatcher("report.jsp");
        dispatcher.forward(request, response);
    }

    private void handleDayMonthYearReport(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        
        String year = request.getParameter("year");
        String month = request.getParameter("month");
        String day = request.getParameter("day");

        List<Map<String, Object>> salesList = new ArrayList<>();
        
        try {
            Connection conn = getConnection();
            String sql = "SELECT o.ORDER_DATE, oi.BOOK_NAME, oi.QUANTITY " +
                         "FROM ORDERS o " +
                         "JOIN ORDER_ITEMS oi ON o.ORDER_ID = oi.ORDER_ID " +
                         "WHERE YEAR(o.ORDER_DATE) = ? AND MONTH(o.ORDER_DATE) = ? AND DAY(o.ORDER_DATE) = ? " +
                         "ORDER BY o.ORDER_DATE";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(year));
            ps.setInt(2, Integer.parseInt(month));
            ps.setInt(3, Integer.parseInt(day));
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> record = new HashMap<>();
                record.put("orderDate", rs.getTimestamp("ORDER_DATE"));
                record.put("bookName", rs.getString("BOOK_NAME"));
                record.put("quantity", rs.getInt("QUANTITY"));
                salesList.add(record);
            }
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error generating daily report: " + e.getMessage());
        }
        
        request.setAttribute("dayMonthYearList", salesList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("report.jsp");
        dispatcher.forward(request, response);
    }

    private Connection getConnection() throws Exception {
        String url = "jdbc:derby://localhost:1527/bookLoomDB"; 
        String user = "book";
        String pass = "book";
        return DriverManager.getConnection(url, user, pass);
    }
}