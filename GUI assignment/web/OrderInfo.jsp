<!DOCTYPE html>
<html lang="en">
<head>
    <%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
    <%@ include file="header.jsp"%>
    <%@ page import="java.sql.*, DB.bookDB, domain.Book" %>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        .accordion {
            background-color: #717fe0;
            color: #fff;
            cursor: pointer;
            padding: 18px;
            width: 100%;
            border: none;
            text-align: left;
            outline: none;
            font-size: 15px;
            transition: 0.4s;
            margin-top: 15px;
        }

        .active, .accordion:hover {
            background-color: #222;
        }

        .panel {
            padding: 0 18px;
            display: none;
            background-color: white;
            overflow: hidden;
        }
    </style>
</head>

<body class="animsition">

<%
    // Fetch order details
    bookDB boook = new bookDB();
    ResultSet rs = boook.getOrderInfo(userId);

    boolean hasItem = false;
    double subtotal = 0.0;
    String currentOrderId = "";
    String currentOrderDate = "";
    double currentTotalAmount = 0.0;
%>

<div class="container" style="padding-top: 20px">
    <div class="row">
        <div class="m-l-25 m-r--38 m-lr-0-xl">
            <h4 class="mtext-113 cl2 p-b-12">Order Information</h4>
                <%
                    while (rs.next()) {
                        hasItem = true;
                        String orderId = rs.getString("ORDER_ID");
                        String bookId = rs.getString("BOOK_ID");
                        String bookName = rs.getString("BOOK_NAME");
                        double bookPrice = rs.getDouble("BOOK_PRICE");
                        String bookImage = rs.getString("BOOK_IMAGE");
                        int quantity = rs.getInt("QUANTITY");
                        double totalAmount = rs.getDouble("TOTAL_AMOUNT");
                        String orderdate = rs.getString("ORDER_DATE");
                        String status = rs.getString("STATUS");
                        double ttotal = bookPrice * quantity;

                        if (!orderId.equals(currentOrderId)) {
                            if (!currentOrderId.isEmpty()) {
                %>
                <%
                    // Parse the SQL date string and format it
                    String formattedDate = "";
                    try {
                        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
                        SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy   HH:mm  a");
                        Date date = inputFormat.parse(currentOrderDate);
                        formattedDate = outputFormat.format(date);
                    } catch (Exception e) {
                        formattedDate = currentOrderDate; // fallback
                    }
                %>                
                <!-- Close previous order panel -->
                                <tr>
                                    <td colspan="5">
                                        <br/>
                                        <div style="display: flex; justify-content: space-between; padding: 30px">
                                            <div><strong>Order Date&Time : </strong> <%= formattedDate %></div>
                                            <div><strong>Grand Total : </strong> RM <%= String.format("%.2f", currentTotalAmount) %></div>
                                        </div>
                                    </td>
                                </tr>
                                </table><br/><br/>
                                </div> <!-- end panel -->
                <%
                            }
                            // New order block
                            currentOrderId = orderId;
                            currentOrderDate = orderdate;
                            currentTotalAmount = totalAmount;
                            subtotal = 0.0;
                %>
                <button class="accordion">Order ID: <%= orderId %> <p style='text-align: right'>Status: <%= status %></p></button>
                <div class="panel">
                    <table class="table-shopping-cart">
                        <tr class="table_head">
                            <th class="column-1" style="text-align: center">Product</th>
                            <th style="text-align: center">Name</th>
                            <th class="column-4" style="text-align: center">Price</th>
                            <th class="column-4" style="text-align: center">Quantity</th>
                            <th class="column-4" style="text-align: center">Subtotal</th>
                        </tr>
                <%
                        }
                        subtotal += ttotal;
                %>
                        <tr>
                            <td class="column-1" style="text-align: center">
                                <img src="<%= bookImage %>" alt="<%= bookName %>" width="100px" height="100px" style="padding: 5px"/>
                            </td>
                            <td style="text-align: left"><%= bookName %></td>
                            <td class="column-4" style="text-align: center">RM <%= bookPrice %></td>
                            <td class="column-4" style="text-align: center"><%= quantity %></td>
                            <td class="column-4" style="text-align: center">RM <%= ttotal %></td>
                        </tr>
                <%
                    }

                    if (hasItem) {

                    // Parse the SQL date string and format it
                    String formattedDate = "";
                    try {
                        SimpleDateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
                        SimpleDateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy   HH:mm  a");
                        Date date = inputFormat.parse(currentOrderDate);
                        formattedDate = outputFormat.format(date);
                    } catch (Exception e) {
                        formattedDate = currentOrderDate; // fallback
                    }
              
                %>
                        <!-- Final panel close -->
                        <tr>
                            <td colspan="5">
                                <br/>
                                <div style="display: flex; justify-content: space-between; padding: 30px">
                                    <div><strong>Order Date&Time : </strong> <%= formattedDate %></div>
                                    <div><strong>Grand Total : </strong> RM <%= String.format("%.2f", currentTotalAmount) %></div>
                                </div>
                            </td>
                        </tr>
                        </table><br/><br/>
                        </div> <!-- end final panel -->
                <%
                    } else {
                %>
                    <br/><br/>
                    <div><h5>You don't have any orders.</h5></div><br/>
                <%
                    }
                %>
        </div>
    </div>
    <br/><br/><br/>
</div>

<%@ include file="footer.jsp"%>

<script>
    var acc = document.getElementsByClassName("accordion");
    for (var i = 0; i < acc.length; i++) {
        acc[i].addEventListener("click", function () {
            this.classList.toggle("active");
            var panel = this.nextElementSibling;
            if (panel.style.display === "block") {
                panel.style.display = "none";
            } else {
                panel.style.display = "block";
            }
        });
    }
</script>

</body>
</html>
