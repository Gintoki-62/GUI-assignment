<!DOCTYPE html>
<html lang="en">
<head>
        <%@ page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ include file="header.jsp"%>
        <%@page import="java.util.List, DB.bookDB, domain.Book"%>
</head>

<body class="animsition" style="transition: none !important;">
    <% request.setCharacterEncoding("UTF-8"); %>

    <%
    // Get search term from request parameter
    String searchTerm = request.getParameter("search-product");
    bookDB db = new bookDB();
    List<Book> books;
    
    // If search term exists, perform search; otherwise get all books
    if (searchTerm != null && !searchTerm.trim().isEmpty()) {
        books = db.searchBooks(searchTerm);
    } else {
        books = db.getRecord();
    }
    %>
    
    <!-- Product -->
    <div class="bg0 m-t-23 p-b-140">
        <div class="container">
            <div class="flex-w flex-sb-m p-b-52">
                <div class="flex-w flex-l-m filter-tope-group m-tb-10">
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 how-active1" data-filter="*">All Book</button>
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".English">English Book</button>
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".Bahasa_Melayu">Bahasa Melayu</button>
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".中文图书">中文图书</button>
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".Revision">Revision Book</button>
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".Stationery">Stationery</button>
                </div>

                <div class="flex-w flex-c-m m-tb-10">
                    <div class="flex-c-m stext-106 cl6 size-104 bor4 pointer hov-btn3 trans-04 m-r-8 m-tb-4 js-show-filter">
                        <i class="icon-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-filter-list"></i>
                        <i class="icon-close-filter cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
                            Types
                    </div>

                    <div class="flex-c-m stext-106 cl6 size-105 bor4 pointer hov-btn3 trans-04 m-tb-4 js-show-search">
                        <i class="icon-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-search"></i>
                        <i class="icon-close-search cl2 m-r-6 fs-15 trans-04 zmdi zmdi-close dis-none"></i>
                            Search
                    </div>
                </div>
            </div>

<!--------------------------- Search Product ------------------------------------------------->
            <div class="dis-none panel-search w-full p-t-10 p-b-15">
                <form method="GET" action="product.jsp">
                    <div class="bor8 dis-flex p-l-15">
                        <button type="submit" class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
                            <i class="zmdi zmdi-search"></i>
                        </button>
                        <input class="mtext-107 cl2 size-114 plh2 p-r-15" type="text" name="search-product" placeholder="Search Book" value="<%= searchTerm != null ? searchTerm : "" %>">
                    </div>
                </form>	
            </div>
<!--------------------------- End Search Product -------------------------------------------->

<!--------------------------- Search Results Message ---------------------------------------->
            <% if (searchTerm != null && !searchTerm.trim().isEmpty()) { %>
                <div class="row p-b-20">
                    <div class="col-12">
                        <h4 class="mtext-105 cl2">
                            Search results for:   " <%= searchTerm %> " 
                        </h4>
                        <a href="product.jsp" class="stext-106 cl6 hov1 trans-04 m-r-32 m-tb-5">
                            <i class="zmdi zmdi-close"></i> Clear search
                        </a>
                    </div>
                </div>
            <% } %>
<!--------------------------- End Search Results Message ------------------------------------>

<!--------------------------- Filter ------------------------------------------------->
            <div class="dis-none panel-filter w-full p-t-10 filter-tope-group">
                <div class="wrap-filter flex-w bg6 w-full p-lr-40 p-t-27 p-lr-15-sm">
                    <div class="filter-col1 p-r-15 p-b-27">
                        <div class="mtext-102 cl2 p-b-15">English Book</div>
                            <ul>    
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Comics">Comics</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Cook">Cook</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Hobby">Hobby</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Travel">Travel</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Business">Business</button></li>
                            </ul>
                    </div>
                    <div class="filter-col2 p-r-15 p-b-27">
                        <div class="mtext-102 cl2 p-b-15">Bahasa Melayu</div>
                            <ul>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Komik">Komik</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Kesihatan">Kesihatan</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Remaja">Remaja</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Seni">Seni</button></li>
                            </ul>
                        </div>
                    <div class="filter-col3 p-r-15 p-b-27">
                        <div class="mtext-102 cl2 p-b-15">中文图书</div>
                            <ul>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".轻小说">轻小说</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".图文漫画">图文漫画</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".休闲生活">休闲生活</button></li>
                            </ul>
                        </div>
                    <div class="filter-col4 p-b-27">
                        <div class="mtext-102 cl2 p-b-15">Revision Book</div>
                            <ul>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".SPM">SPM</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".STPM">STPM</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Secondary_School">Secondary School</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Primary_School">Primary School</button></li>
                            </ul>
                    </div>
                    <div class="filter-col4 p-b-27">
                        <div class="mtext-102 cl2 p-b-15">Stationery</div>
                            <ul>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Accessories">Accessories</button></li>
                                <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".Paper">Paper</button></li>
                            </ul>
                    </div>
                </div>
            </div>
<!--------------------------- End Filter ------------------------------------------------->

<!--------------------------- product ---------------------------------------------------->                
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
                        <div class="block2-txt flex-w p-t-14">
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
                     if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            %>
                <div class="col-12">
                    <p class="cl3" style="font-family: Poppins-Regular; font-size: 16px; line-height: 1.7">No books found matching "<%= searchTerm %>".</p>
                    <br/>
                    <a href="product.jsp" class="stext-106 cl6 hov1 trans-04">
                        <i class="zmdi zmdi-arrow-back"></i> Back
                    </a>
                </div>
            <%    } else { %>
                <p>No books available in the database.</p>
            <%  }
                 } %>
            </div>
        </div>
    </div>
<!--------------------------- End Product ------------------------------------------------->
    <%@ include file="footer.jsp"%>
</body>
</html>