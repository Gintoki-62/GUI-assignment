<%-- 
    Document   : search_book
    Created on : 18 Mar 2025, 5:32:01 pm
    Author     : tanan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
 <%@page import="java.sql.*, DB.bookDB, domain.Book"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
        <%
    // Get search query from the request
    String searchQuery = request.getParameter("search-product");
    Book book = null;
    
    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
        bookDB db = new bookDB();
//        book = db.getRecord(searchQuery);
    }
    %>
    <body>
          <div class="row isotope-grid">
            <% if (books != null && !books.isEmpty()) {
                    for (Book book : books) {
            %>
            <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item <%= book.getBOOK_CATEGORY() %> <%= book.getBOOK_TYPE() %>">
                    <!-- Block2 -->
                    <div class="block2">
                        <div class="block2-pic hov-img0"> <img src="<%= book.getBOOK_IMAGE() %>" alt="IMG-PRODUCT">
                            <a href="product-popup.jsp?BOOK_ID=<%= book.getBOOK_ID() %>" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 ">
                                Quick View</a>
                        </div>
                                <div class="block2-txt flex-w flex-t p-t-14">
                            <div class="block2-txt-child1 flex-col-l ">
                                <a href="product-detail.jsp?BOOK_ID=<%= book.getBOOK_ID() %>&CATEGORY=<%= book.getBOOK_CATEGORY() %>&TYPE=<%= book.getBOOK_TYPE() %>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                                    <%= book.getBOOK_NAME() %></a>
                                <span class="stext-105 cl3">RM <%= String.format("%.2f", book.getBOOK_PRICE()) %></span>

                            </div>
                        </div>
                    </div>
                </div>
            <%  }
                 } else {
            %>
                <p>No books available in the database.</p>
            <%  } %>
            </div>
    </body>
</html>
