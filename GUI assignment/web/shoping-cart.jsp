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
            <span class="stext-109 cl4">Shoping Cart</span>
        </div>
    </div>
		
    <% 
        String userId = "user123";

        bookDB db = new bookDB();
        ResultSet rs = db.getCart("user123");
    
    %>
    
    <!-- Shoping Cart -->
    <form class="bg0 p-b-85" style="padding-top: 20px">
        <div class="container">
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
        while (rs.next()) {
            String id = rs.getString("BOOK_ID");
            String name = rs.getString("BOOK_NAME");
            double price = rs.getDouble("BOOK_PRICE");
            String image = rs.getString("BOOK_IMAGE");
            String type = rs.getString("BOOK_TYPE");
            String category = rs.getString("BOOK_CATEGORY");
            int qty = rs.getInt("QUANTITY");
            double subtotal = price * qty;
    %>
                            
                            <tr class="table_row">
                                <td class="column-1">
                                    <div ><img src="<%= image %>" alt="IMG" width="100px" height="100px"></div>
                                </td>
                                <td class="column-2" style="padding-left: 15px; width: 250px">
                                    <a href="product-detail.jsp?BOOK_ID=<%= id %>&CATEGORY=<%= category %>&TYPE=<%= type %>">
                                       <%= name %>
                                    </a> 
                                </td>
                                <td class="column-4" style="text-align: center">RM <%= price %></td>

                                <td class="column-5">
                                    <div class="wrap-num-product flex-w m-l-auto m-r-0">
                                            <div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
                                                    <i class="fs-16 zmdi zmdi-minus"></i>
                                            </div>

                                            <input class="mtext-104 cl3 txt-center num-product" type="number" name="num-product1" value="1">

                                            <div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
                                                    <i class="fs-16 zmdi zmdi-plus"></i>
                                            </div>
                                    </div>
                                </td>
                                <td class="column-3" style="text-align: center">RM <%= subtotal %></td>
                                
                                <td class="column-3" style="text-align: center"><img src="images/icons/edit.png" alt="Edit" title="Edit"/></td>
                                <td class="column-3" style="text-align: center"><img src="images/icons/delete.png" alt="Delete" title="Delete"/></td>
                            </tr>
                            <%}%>
                        </table>
                    </div>
                </div>
            </div>
        </div>
       
        
        <div style="display: flex; justify-content: flex-end;">
            <div class="col-sm-10 col-lg-7 col-xl-5 m-b-50" style="margin-top: 50px; margin-right: 75px">
                <div class="bor10 p-lr-40 p-t-30 p-b-40 m-l-63 m-r-40 m-lr-0-xl p-lr-15-sm">

                    <h4 class="mtext-109 cl2 p-b-30">Cart Totals</h4>
                        <div class="flex-w flex-t bor12 p-b-13">
                            <div class="size-208">
                                <span class="stext-110 cl2">Subtotal:</span>
                            </div>
                            <div class="size-209">
                                <span class="mtext-110 cl2">$79.65</span>
                            </div>
                        </div>

                        <div class="flex-w flex-t bor12 p-t-15 p-b-30">
                            <div class="size-208 w-full-ssm">
                                <span class="stext-110 cl2">Shipping:</span>
                            </div>
                            <div class="size-209">
                                <span class="mtext-110 cl2">$79.65</span>
                            </div>
                        </div>

                        <div class="flex-w flex-t p-t-27 p-b-33">
                            <div class="size-208">
                                <span class="mtext-101 cl2">Total:</span>
                            </div>
                            <div class="size-209 p-t-1">
                                <span class="mtext-110 cl2">$79.65</span>
                            </div>
                        </div>

                        <button class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer">
                                Proceed to Checkout
                        </button>
                    </div>
            </div>
        </div>
    </form>
		 
	<%@ include file="footer.jsp"%>
</body>
</html>