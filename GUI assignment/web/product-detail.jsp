<!DOCTYPE html>
<html lang="en">
<head>
	<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
        <%@ include file="header.jsp"%>
        <%@page import="java.util.List, DB.bookDB, domain.Book"%>
</head>

<body class="animsition">

    <%
        request.setCharacterEncoding("UTF-8");
        String category = request.getParameter("CATEGORY");  
        String type = request.getParameter("TYPE");   
    %>
	<!-- breadcrumb -->
	<div class="container">
		<div class="bread-crumb flex-w p-l-25 p-r-15 p-t-30 p-lr-0-lg">
			<a href="index.jsp" class="stext-109 cl8 hov-cl1 trans-04">
				Home
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>

			<a href="product.jsp?type=<%= category %>" class="stext-109 cl8 hov-cl1 trans-04">
				<%= category %>
				<i class="fa fa-angle-right m-l-9 m-r-10" aria-hidden="true"></i>
			</a>

			<span class="stext-109 cl4">
				<%= type %>
			</span>
		</div>
	</div>
		
            <%
    // Get the BOOK_ID from the URL
    String bookID = request.getParameter("BOOK_ID");
//    String userID = "user123";
    
    // Fetch all books from the database
    bookDB dbl = new bookDB();
    List<Book> books = dbl.getRecord();

    // Check if BOOK_ID exists and matches a book in the list
    Book selectedBook = null;
    if (bookID != null && !bookID.isEmpty()) {
        for (Book book : books) {
            if (book.getBOOK_ID().equals(bookID)) { 
                selectedBook = book;
                break; // Stop the loop when the book is found
            }
        }
    }
    %>

	<!-- Product Detail -->
<section class="sec-product-detail bg0 p-t-65 p-b-60">
    <div class="container">
        <div class="row">
    <% if (selectedBook != null) { %>
                        <div class="col-md-6 col-lg-7 p-b-30">
                            <div class="p-l-25 p-r-30 p-lr-0-lg">
                                <div class="wrap-slick3 flex-sb flex-w">
                                    <div class="wrap-slick3-dots"></div>
                                    <div class="wrap-slick3-arrows flex-sb-m flex-w"></div>
                                    <div class="slick3 gallery-lb">
                                    <div class="item-slick3" data-thumb="<%= selectedBook.getBOOK_IMAGE() %>">
                                        <div class="wrap-pic-w pos-relative">
                                            <img src="<%= selectedBook.getBOOK_IMAGE() %>" alt="IMG-PRODUCT">
                                                <a class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04" href="<%= selectedBook.getBOOK_IMAGE() %>">
                                                <i class="fa fa-expand"></i></a>
                                        </div>
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-5 p-b-30">
                            <div class="p-r-50 p-t-5 p-lr-0-lg">
                                <h4 class="mtext-105 cl2 js-name-detail p-b-14"><%= selectedBook.getBOOK_NAME() %></h4>
                                <span class="mtext-106 cl2">RM <%= String.format("%.2f", selectedBook.getBOOK_PRICE()) %></span>
                                <br/><br/><hr/>
                                <ul>
                                    <li>Author     : <%= selectedBook.getAUTHOR_NAME() %></li><br/>
                                    <li>Publisher  : <%= selectedBook.getPUBLISHER() %></li><br/>
                                    <li>No.of Pages: <%= selectedBook.getNO_OF_PAGES() %></li>
                                    <br/>
                                </ul>

                            <!--  -->
                            <div class="p-t-33">
                            <div class="flex-w flex-r-m p-b-10">
                               <div class="size-204 flex-w flex-m respon6-next">
                                    <form action="AddToCartServlet" method="post">
                                        <div class="wrap-num-product flex-w m-r-20 m-tb-10">
                                            <div class="btn-nm-down cl8 hov-btn3 trans-04 flex-c-m" style="width: 45px;height: 100%; cursor: pointer;">
                                                <i class="fs-16 zmdi zmdi-minus"></i>
                                            </div>
                                            <input class="mtext-104 cl3 txt-center num-product" type="number"
                                                   name="quantity" value="1" min="1" max="100">
                                            <div class="btn-nm-up cl8 hov-btn3 trans-04 flex-c-m" style="width: 45px;height: 100%; cursor: pointer;">
                                                <i class="fs-16 zmdi zmdi-plus"></i>
                                            </div>
                                        </div>
                               
                                        <input type="hidden" name="bookId" value="<%= bookID %>">
                                        <input type="hidden" name="userId" value="<%= userId %>">
                                        <input type="hidden" name="name" value="<%= selectedBook.getBOOK_NAME() %>">
                                        <button type="submit" class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04 js-addcart-detail">
                                            Add to Cart</button>
                                    </form>
                                </div>
                            </div>	
                            </div>
                            </div>
                        </div>
                    </div>
                        <h4>Description: </h4>
                        <br/>
                        <p><%= selectedBook.getBOOK_DESC() %></p>
    <%  } else { %>
        <p>No books available.</p>
    <%  } %>
    </div>
</section>
    
    <script>
    document.addEventListener("DOMContentLoaded", function () {
        // Loop through all quantity blocks
        document.querySelectorAll('.wrap-num-product').forEach(wrapper => {
            const input = wrapper.querySelector('.num-product');
            const btnMinus = wrapper.querySelector('.btn-nm-down');
            const btnPlus = wrapper.querySelector('.btn-nm-up');

            const min = parseInt(input.min) || 1;
            const max = parseInt(input.max) || 100;

            // - button
            btnMinus.addEventListener("click", function () {
                let val = parseInt(input.value) || min;
                if (val > min) {
                    input.value = val - 1;
                }
            });

            // + button
            btnPlus.addEventListener("click", function () {
                let val = parseInt(input.value) || min;
                if (val < max) {
                    input.value = val + 1;
                }
            });

            // Manual input
            input.addEventListener("input", function () {
                let val = parseInt(this.value);
                if (isNaN(val) || val < min) this.value = min;
                if (val > max) this.value = max;
            });
        });
    });
    </script>

<%@ include file="footer.jsp"%>
</body>
</html>