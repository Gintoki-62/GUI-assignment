<!DOCTYPE html>
<html lang="en">
<head>
        <%@ page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ include file="header.jsp"%>
        <%@page import="java.sql.*, DB.bookDB, domain.Book"%>
</head>

<body class="animsition">
    <!-- breadcrumb -->
    <div class="container">
        <div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
            <a href="MainPage.jsp" class="stext-109 cl8 hov-cl1 trans-04">
                Home <i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
            </a>
            <span class="stext-109 cl4">Shopping Cart</span>
        </div>
    </div>
		
   <%
    // Fetch order details
    bookDB boook = new bookDB();
    ResultSet rs = boook.getOrderInfo(userId);
%>

<!-- Shoping Cart -->
<div class="container" style="padding-top: 20px">
    <div class="row">
        <div class="m-l-25 m-r--38 m-lr-0-xl">
            <div class="wrap-table-shopping-cart">
                <table class="table-shopping-cart">
                    <tr class="table_head">
                        <th class="column-1" style="text-align: center">Product</th>
                        <th class="column-2" style="text-align: center">Name</th>
                        <th class="column-4" style="text-align: center">Price</th>
                        <th class="column-2" style="text-align: center">Quantity</th>
                        <th class="column-4" style="text-align: center">Total</th>
                        <th class="column-1" style="text-align: center"></th>
                        <th class="column-1" style="text-align: center"></th>
                    </tr>

<%
    boolean hasItem = false;
    double subtotal = 0.0;
    String currentOrderId = ""; // Track the current order ID dynamically

    // Loop through the result set to display orders dynamically
    while (rs.next()) {
        hasItem = true;
        String orderId = rs.getString("ORDER_ID"); // Ensure ORDER_ID is fetched correctly
        String bookId = rs.getString("BOOK_ID");
        String bookName = rs.getString("BOOK_NAME");
        double bookPrice = rs.getDouble("BOOK_PRICE");
        String bookImage = rs.getString("BOOK_IMAGE");
        int quantity = rs.getInt("QUANTITY");
        double totalAmount = rs.getDouble("TOTAL_AMOUNT");
        double ttotal = bookPrice * quantity;
        subtotal += ttotal;

        // Display a header for each new order ID (differentiates orders dynamically)
        if (!orderId.equals(currentOrderId)) {
            // When the order ID changes, print the new header for the order section
            if (!currentOrderId.isEmpty()) {
%>
            <tr>
                <td colspan="5"><b>Subtotal for Order ID: <%= currentOrderId %></b></td>
                <td colspan="2"><%= subtotal %></td>
            </tr>
<%
            }
            currentOrderId = orderId; // Update the current order ID
            subtotal = 0; // Reset subtotal for the new order
%>
            <tr class="order_section">
                <td colspan="7" style="text-align: center; font-weight: bold;">Order ID: <%= orderId %></td>
            </tr>
<%
        }

        // Now print the individual items for the current order
%>
        <tr>
            <td class="column-1" style="text-align: center"><img src="<%= bookImage %>" alt="<%= bookName %>" /></td>
            <td class="column-2" style="text-align: center"><%= bookName %></td>
            <td class="column-4" style="text-align: center">RM <%= bookPrice %></td>
            <td class="column-2" style="text-align: center"><%= quantity %></td>
            <td class="column-4" style="text-align: center">RM <%= ttotal %></td>
            <td class="column-1" style="text-align: center">RM <%= totalAmount %></td>
        </tr>
<%
    }

    // Optionally, show a final total for the last order (if any)
    if (hasItem) {
%>
    <tr>
        <td colspan="5"><b>Total for Order ID: <%= currentOrderId %></b></td>
        <td colspan="2"><%= subtotal %></td>
    </tr>
<%
    }
%>

                </table>
            </div>
        </div>
    </div>
</div>


		 
	<%@ include file="footer.jsp"%>
     
            <script>
   document.addEventListener('DOMContentLoaded', function() {
	// Edit button click
	document.addEventListener('click', function(e) {
		if (e.target.closest('.update-btn')) {
			const row = e.target.closest('tr');
			row.querySelector('.quantity-display').classList.add('d-none');
			row.querySelector('.quantity-edit').classList.remove('d-none');
			row.querySelector('.update-btn').classList.add('d-none');
			row.querySelector('.save-btn').classList.remove('d-none');
		}
	});

	// Save button click
	document.addEventListener('click', function(e) {
		if (e.target.closest('.save-btn')) {
			const row = e.target.closest('tr');
			const prodId = e.target.dataset.id;
			const input = row.querySelector('.qty-input');
			const newQty = parseInt(input.value);
			const price = parseFloat(input.dataset.price);

			// Update UI immediately
			row.querySelector('.quantity-text').textContent = newQty;
			row.querySelector('.product-total').textContent = 'RM ' + (price * newQty).toFixed(2);

			// Switch back to view mode
			row.querySelector('.quantity-display').classList.remove('d-none');
			row.querySelector('.quantity-edit').classList.add('d-none');
			row.querySelector('.update-btn').classList.remove('d-none');
			row.querySelector('.save-btn').classList.add('d-none');
		}
	});
});


</script>




</body>
</html>