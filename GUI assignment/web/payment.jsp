<!DOCTYPE html>
<html lang="en">
<head>
	<%@ page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ include file="header.jsp"%>
        <%@page import="java.sql.*, DB.bookDB, domain.Book"%>
</head>
<body class="animsition">
    
    <% 
        String username = (String) session.getAttribute("username");
        String phone = (String) session.getAttribute("phone");
        String address = (String) session.getAttribute("address");
        
        bookDB book = new bookDB();
        ResultSet rs = book.getCart("user123");
  
        
    %>
	<!-- Content page -->
	<section class="bg0 p-t-52 p-b-20">
		<div class="container">
                    <a href="shoping_cart.jsp" style="color:black"><img src="images/icons/replay.png" title="Back"/>Back</a><br/><br/>
                    <div>
                        <h1 class="mtext-113 cl2 p-b-12">Proceed to CheckOut</h1>
                        <form action="payment.jsp" method="post" id="userForm">
                            <table rows="2" columns="2" width="100%">
                                <tr>
                                    <td>
                                        <label>Name:</label>
                                        <div id="nmadd" class="m-b-20" style="padding: 10px">
                                            <input type="text" name="userName" value="you" style="width:550px" required readonly>
                                        </div>
                                    </td>
                                    <td>
                                        <label style="margin-left: 25px">Phone Number:</label>
                                        <div id="phadd" class="m-b-20" style="margin-left: 25px; padding: 10px">
                                            <input type="text" name="phone" value="0123456789" required readonly>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>Address:</label>   
                                        <div id="adradd" class="m-b-20" style="padding: 10px">
                                            <input type="textarea" name="address" value="sddssdsdssfdfsf" style="width:550px" required readonly>
                                        </div>
                                    </td>
                                    <td>
                                        <button type="button" id="editBtn" class="flex-c-m stext-101 cl0 size-125 bg3 bor2 hov-btn3 p-lr-15 trans-04" style="float:right">
                                            Edit
                                        </button>
                                    </td>
                                </tr>
                            </table>
                        </form>
                        <br/><br/>  
                        
                        <h1 class="mtext-113 cl2 p-b-12">Order Details</h1>
                        <table class="table-shopping-cart">
                        <tr class="table_head">
                            <th class="column-1" style="text-align: center">Product</th>
                            <th class="column-2" style="text-align: center">Name</th>
                            <th class="column-4" style="text-align: center">Price</th>
                            <th class="column-2" style="text-align: center">Quantity</th>
                            <th class="column-4" style="text-align: center">Total</th>
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
            String type = rs.getString("BOOK_TYPE");
            String category = rs.getString("BOOK_CATEGORY");
            int qty = rs.getInt("QUANTITY");
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
                                <td class="column-2" style="padding-left: 15px; width: 250px; text-align: left">
                                    <a href="product-detail.jsp?BOOK_ID=<%= id %>&CATEGORY=<%= category %>&TYPE=<%= type %>" 
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
                                <td class="column-3" style="text-align: center">RM <%= String.format("%.2f", ttotal) %></td>
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
                    <br/><br/><br/>
                    
                    <%
                    // Calculate shipping (example: free over RM1000)
                    double shipping = (subtotal >= 1000) ? 0.00 : 25.00;
                    double sst = subtotal * 0.06;
                    grandtotal = subtotal + shipping + sst;
                    %>

                    <form>
                   
                            <div class="p-t-30 p-b-40 m-lr-0-xl p-lr-15-sm">
                                <label for="payMethod">Payment Method:</label>
                                <select name="payMethod" id="payMethod" class="bor19 size-218 m-b-20" style="padding:10px; width:600px" required><br/>
                                      <option value="">-- Choose a Payment Method --</option><br/>
                                      <option value="Cash">Cash</option><br/>
                                      <option value="CreditCard">Credit Card</option><br/>
                                      <option value="OnlineBanking">Online Banking</option><br/>
                                      <option value="E-Wallet">E-Wallet</option><br/>
                                    </select>
                                <br/><br/><br/>
                            
                    
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
                                        <br/><br/><br/><br/>
                                        <button class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer">
                                                Make a Payment
                                        </button>
                                        <br/><br/>
                                    </div>
                                </div>
                            </div> 
                    </form>
                    </div>
                </div>
        </section>	
	
     <%@ include file="footer.jsp"%>
     
     <script>
        const editBtn = document.getElementById("editBtn");
        const form = document.getElementById("userForm");
        let isEditing = false;

        // Toggle between Edit and Save
        editBtn.addEventListener("click", function () {
            const inputs = form.querySelectorAll("input");

            if (!isEditing) {
                // Enable editing and add border
                inputs.forEach(input => {
                    input.removeAttribute("readonly");
                    input.classList.add("editable"); // Optional class for styling
                });

                // Add bor19 class dynamically to divs
                document.getElementById("nmadd").classList.add("bor19");
                document.getElementById("phadd").classList.add("bor19");
                document.getElementById("adradd").classList.add("bor19");

                // Change button text to "Save"
                editBtn.textContent = "Save";
                isEditing = true;
                
                document.getElementById("userName").focus();
            } else {
                // Submit the form when the user clicks Save
                form.submit();
            }
        });
    </script>
     
</body>
</html>