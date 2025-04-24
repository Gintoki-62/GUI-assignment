<!DOCTYPE html>
<html lang="en">
<head>
	<%@ page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ include file="header.jsp"%>
        <%@page import="java.sql.*, DB.bookDB, domain.Book"%>
</head>
<body class="animsition">
    
    <% 
        String Id = (String) session.getAttribute("name");
        String username = (String) session.getAttribute("username");
        String phone = (String) session.getAttribute("phone");
        String address = (String) session.getAttribute("address");
        
        bookDB book = new bookDB();
        ResultSet rs = book.getCart(userId);
  
        
    %>
	<!-- Content page -->
	<section class="bg0 p-t-52 p-b-20">
		<div class="container">
                    <a href="shoping-cart.jsp" style="color:black"><img src="images/icons/replay.png" title="Back"/>Back</a><br/><br/>
                    <div>
                        <h1 class="mtext-113 cl2 p-b-12">Proceed to CheckOut</h1>
                        <form action="UpdateUserServlet" method="POST" id="userForm">
                            <table rows="2" columns="2" width="100%">
                                <tr>
                                    <td>
                                        <label>Name:</label>
                                        <div id="nmadd" class="m-b-20" style="padding: 10px">
                                            <input type="text" name="uname" id="uname" value="<%= username %>" style="width:550px" readonly>
                                        </div>
                                    </td>
                                    <td>
                                        <label style="margin-left: 25px">Phone Number:</label>
                                        <div id="phadd" class="m-b-20" style="margin-left: 25px; padding: 10px">
                                            <input type="text" name="phone" id="phone" value="<%= phone %>" readonly>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <label>Address:</label>   
                                        <div id="adradd" class="m-b-20" style="padding: 10px">
                                            <input type="text" name="address" id="address" value="<%= address %>" style="width:550px" readonly>
                                        </div>
                                    </td>
                                    <td>
                                        <input type="hidden" name="ID" id="ID" value="<%= Id %>" >
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
                    double discount = (subtotal > 100) ? subtotal * 0.20 : 0.00;
                    double shipping = (subtotal >= 1000) ? 0.00 : (subtotal > 0 ? 25.00 : 0.00);
                    double subtotalAfterDiscount = subtotal - discount;
                    double sst = subtotalAfterDiscount * 0.06;
                    grandtotal = subtotalAfterDiscount + shipping + sst;
                    session.setAttribute("grandtotal", grandtotal);
                    %>

                    <div style="margin-left: 500px">
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
                        
                    <div class="flex-w flex-t bor12 p-t-15 p-b-30"  style="text-align: left">
                        <div class="w-full-ssm" style="width: 55.5%;">
                            <span class="stext-110 cl2">Discount (20%):</span>
                            <p style="font-size: 12px">Spend more than RM 100, Get 20% discount.</p>
                        </div>
                        <div style="width: 44.5%;">
                            <span class="mtext-110 cl2">RM &nbsp;<%= String.format("%.2f", discount) %></span>
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
                        <br/>
                            <a href="payment.jsp"><button class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer">
                                    Make a Payment
                            </button></a>
                        <br/><br/><br/>
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
                
                document.getElementById("username").focus();
            } else {
                // Submit the form when the user clicks Save
                form.submit();
            }
        });
    </script>
     
</body>
</html>