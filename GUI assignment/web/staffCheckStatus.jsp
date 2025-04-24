
<!DOCTYPE html>
<html>
<head>
    <%@ page contentType="text/html" pageEncoding="UTF-8" language="java" %>
    <%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
    <%@ include file="staffSidebar.jsp" %>
    <title>BOOKLOOM - Staff Order Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f8f9fa;
        }
        
        .container {
            margin-left: 250px; /* Sidebar width */
            padding: 20px;
        }
        
        h2 {
            text-align: center;
            margin-top: 20px;
            color: #333;
            padding-bottom: 20px;
        }
        
        .message {
            text-align: center;
            padding: 10px;
            margin: 10px auto;
            width: 80%;
            border-radius: 5px;
        }
        
        .success {
            background-color: #d4edda;
            color: #155724;
        }
        
        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
        
        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        th, td {
            padding: 12px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #717fe0;
            color: white;
            position: sticky;
            top: 0;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #e9e9e9;
        }

        select {
            padding: 6px;
            font-size: 14px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 100%;
        }

        button {
            padding: 6px 12px;
            font-weight: bold;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            transition: background-color 0.3s;
        }

        button:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Staff Order Status Management</h2>
    
    <%-- Display success/error messages --%>
    <%
    String message = (String) request.getAttribute("message");
    if (message != null) {
    %>
    <div style="width: 90%; margin: 20px auto; padding: 10px; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; border-radius: 5px;">
        <%= message %>
    </div>
    <%
    }
    %>

    <table>
        <tr>
            <th>Order ID</th>
            <th>User ID</th>
            <th>Order Date</th>
            <th>Total Amount</th>
            <th>Status</th>
            <th>Action</th>
        </tr>

    <%
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/bookLoomDB", "book", "book"); 
            ps = conn.prepareStatement("SELECT * FROM ORDERS ORDER BY ORDER_DATE DESC");
            rs = ps.executeQuery();

            while (rs.next()) {
                String orderId = rs.getString("ORDER_ID");
                String userId = rs.getString("USER_ID");
                String orderDate = rs.getString("ORDER_DATE");
                double total = rs.getDouble("TOTAL_AMOUNT");
                String status = rs.getString("STATUS");

                // Format date
                String formattedDate = orderDate;
                try {
                    SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
                    SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy hh:mm a");
                    java.util.Date parsedDate = inputFormat.parse(orderDate);
                    formattedDate = outputFormat.format(parsedDate);
                } catch (Exception e) {
                    out.println("<!-- Date parsing error: " + e.getMessage() + " -->");
                }
    %>
        <form action="staffCheckStatusServlet" method="post">
            <tr>
                <td><%= orderId %></td>
                <td><%= userId %></td>
                <td><%= formattedDate %></td>
                <td>RM <%= String.format("%.2f", total) %></td>
                <td>
                    <select name="status">
                        <option value="packaging" <%= "packaging".equals(status) ? "selected" : "" %>>Packaging</option>
                        <option value="shipping" <%= "shipping".equals(status) ? "selected" : "" %>>Shipping</option>
                        <option value="delivered" <%= "delivered".equals(status) ? "selected" : "" %>>Delivered</option>
                    </select>
                </td>
                <td>
                    <input type="hidden" name="orderId" value="<%= orderId %>" />
                    <button type="submit">Update</button>
                </td>
            </tr>
        </form>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<tr><td colspan='6' class='error'>Error processing orders: " + e.getMessage() + "</td></tr>");
        } finally {
            // Close resources
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    </table>
</div>
</body>
</html>