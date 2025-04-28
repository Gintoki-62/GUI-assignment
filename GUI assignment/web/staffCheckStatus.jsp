
<!DOCTYPE html>
<html>
<head>
    <%@ page contentType="text/html" pageEncoding="UTF-8" language="java" %>
    <%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
    <%@ include file="staffSidebar.jsp" %>
    <title>BookLoom Staff Page</title>
    <link rel="icon" type="image/png" href="images/icons/tablogo.png"/>
    <style>
       
        body {
            margin: 0;
            padding: 0;
            background-color: #f9f7f5;
            color: #333;
        }

        .container {
            margin-left: 250px;
            padding: 25px;
            transition: all 0.3s ease;
        }

        h2 {
            text-align: center;
            margin: 10px 0 30px;
            color: #4a4a4a;
            font-size: 28px;
            font-weight: 600;
            position: relative;
            padding-bottom: 15px;
        }

        h2:after {
            content: '';
            position: absolute;
            width: 80px;
            height: 3px;
            background: linear-gradient(90deg, #ff7043, #ffab40);
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .message {
            text-align: center;
            padding: 12px 15px;
            margin: 15px auto;
            width: 90%;
            border-radius: 6px;
            font-size: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.08);
        }

        .success {
            background-color: #fff3e0;
            color: #a76100;
            border-left: 4px solid #ff9800;
        }

        .error {
            background-color: #ffebee;
            color: #b71c1c;
            border-left: 4px solid #f44336;
        }

        table {
            width: 95%;
            margin: 25px auto;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 14px 12px;
            border: none;
            text-align: center;
        }

        th {
            background: linear-gradient(135deg, #ff7043, #ff9800);
            color: white;
            font-weight: 600;
            position: sticky;
            top: 0;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
        }

        tr:nth-child(even) {
            background-color: #fff8f0;
        }

        tr:not(:last-child) td {
            border-bottom: 1px solid #f0e6dd;
        }

        tr:hover {
            background-color: #fff1e4;
            transition: background-color 0.2s ease;
        }

        select {
            padding: 8px 10px;
            font-size: 14px;
            border: 1px solid #e8d6c6;
            border-radius: 5px;
            width: 100%;
            background-color: white;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
            transition: border-color 0.2s ease, box-shadow 0.2s ease;
        }

        select:focus {
            border-color: #ff9800;
            outline: none;
            box-shadow: 0 0 0 3px rgba(255, 152, 0, 0.2);
        }

        button {
            padding: 8px 16px;
            font-weight: 600;
            background: linear-gradient(to right, #ff7043, #ff9800);
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            transition: all 0.3s ease;
            font-size: 14px;
            width: 100%;
            max-width: 120px;
        }

        button:active {
            transform: translateY(0);
        }

        td:nth-child(3) {
            font-family: 'Courier New', monospace;
            font-weight: 500;
            color: #795548;
        }

        td:nth-child(4) {
            color: #e65100;
            font-weight: bold;
        }

        select[name="status"] option[value="packaging"] {
            color: #ff7043;
        }

        select[name="status"] option[value="shipping"] {
            color: #ff9800;
        }

        select[name="status"] option[value="delivered"] {
            color: #8d6e63;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Product Order Status</h2>
    
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