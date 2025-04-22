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
        double subtotal = 0.0, grandtotal=0.0;
        
        while (rs.next()) {
            hasItem = true;
            String id = rs.getString("BOOK_ID");
            String name = rs.getString("BOOK_NAME");
            double price = rs.getDouble("BOOK_PRICE");
            String image = rs.getString("BOOK_IMAGE");
            int qty = rs.getInt("QUANTITY");
            double totals = rs.getDouble("TOTAL_AMOUNT");
            double ttotal = price * qty;
            subtotal += ttotal;
    %>
                        
                        <!--====== show Form ======-->    
                            <tr class="table_row">
                                <form action="UpdateQuantityServlet" method="post">
                                    <input type="hidden" name="id" value="<%= id %>" />
                        <!--===== show image ======-->
                                    <td class="column-1">
                                        <div><img src="<%= image %>" alt="IMG" width="100px" height="100px"></div>
                                    </td>
                        <!--===== show name ======-->
                                    <td class="column-2" style="padding-left: 15px; width: 250px">
                                        <a href="product-detail.jsp" 
                                           style="color: #5B65F3;">
                                           <%= name %>
                                        </a> 
                                    </td>
                        <!--===== show price ======-->
                                    <td class="column-4" style="text-align: center">RM <%= String.format("%.2f", price) %></td>
                        <!--===== show quantity ======-->
                                    <td class="column-5">
                                        <div class="quantity-display" style="text-align: center">
                                            <span class="quantity-text"><%= qty %></span>
                                        </div>
                                        <div class="wrap-num-product quantity-edit d-none flex-w m-l-auto m-r-0">
                                            <div class="btn-num-product-down btn-num-down cl8 hov-btn3 trans-04 flex-c-m" >
                                                    <i class="fs-16 zmdi zmdi-minus"></i>
                                            </div>
                                            <input class="mtext-104 cl3 txt-center num-product qty-input" type="number" name="quantity"  
                                                   value="<%= qty %>" data-price="<%= price %>" readonly>
                                            <div class="btn-num-product-up btn-num-up cl8 hov-btn3 trans-04 flex-c-m">
                                                    <i class="fs-16 zmdi zmdi-plus"></i>
                                            </div>
                                        </div>
                                    </td>
                        <!--===== show total ======-->
                                    <td class="column-3" style="text-align: center">RM <%= String.format("%.2f", totals) %></td>
                        <!--===== show edit & save button ======-->
                                    <td class="column-3" style="text-align: center">
                                        <img src="images/icons/edit.png" title="Edit" style="cursor: pointer;" class="update-btn" />
                                        
                                        <button class="save-btn d-none" data-id="<%= id %>" type="submit" name="action" value="update">
                                            <img src="images/icons/yes.png" title="Save" />
                                        </button>
                                    </td>
                        <!--===== show delete button ======-->
                                    <td class="column-3" style="text-align: center">
                                        <button type="submit" name="action" value="delete">
                                            <img src="images/icons/delete.png" alt="Delete" title="Delete"/>
                                        </button>
                                    </td>
                                </form>
                         <!--===== end Form ======-->
                            </tr>
        <%}
            if (!hasItem) { 
        %>
                            <tr>
                                <td colspan="7" style="text-align:center; padding: 40px 0;">
                                    <strong>Your cart is looking lonely… &nbsp; Start shopping to fill it up !</strong>
                                </td>
                            </tr>
        <%
            }
        %>
                        </table>
                    </div>
                </div>
            </div>
        </div>
       
        <%
        // Calculate shipping (example: free over RM1000)
        double shipping = (subtotal >= 1000) ? 0.00 : 25.00;
        double sst = subtotal * 0.06;
        grandtotal = subtotal + shipping + sst;
        %>

        <div style="display: flex; justify-content: flex-end;">
            <div class="col-sm-10 col-lg-7 col-xl-5 m-b-50" style="margin-top: 50px;">
                <div class="bor10 p-lr-40 p-t-30 p-b-40 m-r-40 m-lr-0-xl p-lr-15-sm">
                        <div class="flex-w flex-t bor12 p-b-13"  style="text-align: left">
                            <div style="width: 55.5%;">
                                <span class="stext-110 cl2">SUBTOTAL:</span>
                            </div>
                            <div style="width: 44.5%;">
                                <span class="mtext-110 cl2">RM &nbsp;<%= String.format("%.2f", subtotal) %></span>
                            </div>
                        </div>
                            
                        <div class="flex-w flex-t bor12 p-t-15 p-b-30"  style="text-align: left">
                            <div class="w-full-ssm" style="width: 55.5%;">
                                <span class="stext-110 cl2">DELIVERY FEES:</span>
                            </div>
                            <div style="width: 44.5%;">
                                <span class="mtext-110 cl2">RM &nbsp;<%= String.format("%.2f", shipping) %></span>
                            </div>
                        </div>

                        <div class="flex-w flex-t bor12 p-t-15 p-b-30"  style="text-align: left">
                            <div class="w-full-ssm" style="width: 55.5%;">
                                <span class="stext-110 cl2">SST (6%):</span>
                            </div>
                            <div style="width: 44.5%;">
                                <span class="mtext-110 cl2">RM &nbsp;<%= String.format("%.2f", sst) %></span>
                            </div>
                        </div>

                        <div class="flex-w flex-t"  style="text-align: left; padding-top: 35px">
                            <div style="width: 55.5%;">
                                <h4 class="mtext-109 cl2 p-b-30">GRAND TOTAL :</h4>
                            </div>
                            <div class="p-t-1" style="width: 44.5%;">
                                <span class="mtext-110 cl2"><b>RM &nbsp;<%= String.format("%.2f", grandtotal) %></b></span>
                            </div>
                        </div>

                        <a href="payCheckOut.jsp"><button class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer">
                             Proceed to Checkout 
                        </button></a>
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