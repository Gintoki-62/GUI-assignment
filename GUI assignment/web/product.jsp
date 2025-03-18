<!DOCTYPE html>
<html lang="en">
<head>
	<title>Product</title>
        <%@page import="java.util.List, DB.bookDB, domain.Book"%>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/favicon.png"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/iconic/css/material-design-iconic-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="fonts/linearicons-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/slick/slick.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/MagnificPopup/magnific-popup.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="vendor/perfect-scrollbar/perfect-scrollbar.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="css/util.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">
<!--===============================================================================================-->
</head>
<body class="animsition">
    <!-- Header -->
    <header class="header-v4">
        <div class="container-menu-desktop">
            <div class="top-bar">
                <div class="content-topbar flex-sb-m h-full container">
                    <div class="left-top-bar">Free shipping for standard order over $100</div>

                    <div class="right-top-bar flex-w h-full">
                        <a href="#" class="flex-c-m trans-04 p-lr-25">Help & FAQs</a>
                        <a href="#" class="flex-c-m trans-04 p-lr-25">My Account</a>
                        <a href="#" class="flex-c-m trans-04 p-lr-25">EN</a>
                        <a href="#" class="flex-c-m trans-04 p-lr-25">USD</a>
                    </div>
                </div>
            </div>

            <div class="wrap-menu-desktop how-shadow1">
                <nav class="limiter-menu-desktop container">		
                    <a href="#" class="logo"><img src="images/icons/logo-01.png" alt="IMG-LOGO"></a>
                    <div class="menu-desktop">
                        <ul class="main-menu">
                            <li><a href="index.jsp">Home</a></li>
                            <li class="active-menu"><a href="product.jsp">Shop</a></li>
                            <li class="label1" data-label1="hot"><a href="shoping-cart.jsp">Features</a></li>
                            <li><a href="blog.jsp">Blog</a></li>
                            <li><a href="about.jsp">About</a></li>
                            <li><a href="contact.jsp">Contact</a></li>
                        </ul>
                    </div>	

                    <!-- Icon header -->
                    <div class="wrap-icon-header flex-w flex-r-m">
                        <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 js-show-modal-search">
                            <i class="zmdi zmdi-search"></i>
                        </div>
                        <div class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart" data-notify="2">
                            <i class="zmdi zmdi-shopping-cart"></i>
                        </div>
                        <a href="#" class="icon-header-item cl2 hov-cl1 trans-04 p-l-22 p-r-11 icon-header-noti" data-notify="0">
                            <i class="zmdi zmdi-favorite-outline"></i>
                        </a>
                    </div>
                </nav>
            </div>	
        </div>

    <!-- Header Mobile -->
    <div class="wrap-header-mobile">		
        <div class="logo-mobile"><a href="index.jsp"><img src="images/icons/logo-01.png" alt="IMG-LOGO"></a></div>
            <!-- Icon header -->
            <div class="wrap-icon-header flex-w flex-r-m m-r-15">
                <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 js-show-modal-search"><i class="zmdi zmdi-search"></i></div>
                <div class="icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti js-show-cart" data-notify="2"><i class="zmdi zmdi-shopping-cart"></i></div>
                <a href="#" class="dis-block icon-header-item cl2 hov-cl1 trans-04 p-r-11 p-l-10 icon-header-noti" data-notify="0"><i class="zmdi zmdi-favorite-outline"></i></a>
            </div>

            <!-- Button show menu -->
            <div class="btn-show-menu-mobile hamburger hamburger--squeeze">
                <span class="hamburger-box">
                    <span class="hamburger-inner"></span>
                </span>
            </div>
    </div>

    <!-- Menu Mobile -->
    <div class="menu-mobile">
        <ul class="topbar-mobile">
            <li><div class="left-top-bar">Free shipping for standard order over $100</div></li>
            <li><div class="right-top-bar flex-w h-full">
                <a href="#" class="flex-c-m p-lr-10 trans-04">Help & FAQs</a>
                <a href="#" class="flex-c-m p-lr-10 trans-04">My Account</a>
                <a href="#" class="flex-c-m p-lr-10 trans-04">EN</a>
                <a href="#" class="flex-c-m p-lr-10 trans-04">USD</a></div>
            </li>
        </ul>

        <ul class="main-menu-m">
            <li><a href="index.jsp">Home</a>
                <ul class="sub-menu-m">
                    <li><a href="index.jsp">Homepage 1</a></li>
                    <li><a href="home-02.jsp">Homepage 2</a></li>
                    <li><a href="home-03.jsp">Homepage 3</a></li>
                </ul>
                <span class="arrow-main-menu-m"><i class="fa fa-angle-right" aria-hidden="true"></i></span>
            </li>
            <li><a href="product.jsp">Shop</a></li>
            <li><a href="shoping-cart.jsp" class="label1 rs1" data-label1="hot">Features</a></li>
            <li><a href="blog.jsp">Blog</a></li>
            <li><a href="about.jsp">About</a></li>
            <li><a href="contact.jsp">Contact</a></li>
        </ul>
    </div>

    <!-- Modal Search -->
    <div class="modal-search-header flex-c-m trans-04 js-hide-modal-search">
        <div class="container-search-header">
            <button class="flex-c-m btn-hide-modal-search trans-04 js-hide-modal-search">
                <img src="images/icons/icon-close2.png" alt="CLOSE">
            </button>

                <form class="wrap-search-header flex-w p-l-15">
                    <button class="flex-c-m trans-04"><i class="zmdi zmdi-search"></i></button>
                    <input class="plh3" type="text" name="search" placeholder="Search...">
                </form>
            </div>
    </div>
    </header>

    <!-- Cart -->
    <div class="wrap-header-cart js-panel-cart">
        <div class="s-full js-hide-cart"></div>
            <div class="header-cart flex-col-l p-l-65 p-r-25">
                <div class="header-cart-title flex-w flex-sb-m p-b-8">
                    <span class="mtext-103 cl2">Your Cart</span>
                        <div class="fs-35 lh-10 cl2 p-lr-5 pointer hov-cl1 trans-04 js-hide-cart"><i class="zmdi zmdi-close"></i></div>
                </div>

                <div class="header-cart-content flex-w js-pscroll">
                    <ul class="header-cart-wrapitem w-full">
                        <li class="header-cart-item flex-w flex-t m-b-12">
                            <div class="header-cart-item-img"><img src="images/item-cart-01.jpg" alt="IMG"></div>
                            <div class="header-cart-item-txt p-t-8">
                                <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">White Shirt Pleat</a>
                                <span class="header-cart-item-info">1 x $19.00</span>
                            </div>
                        </li>

                        <li class="header-cart-item flex-w flex-t m-b-12">
                            <div class="header-cart-item-img"><img src="images/item-cart-02.jpg" alt="IMG"></div>
                            <div class="header-cart-item-txt p-t-8">
                                <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">Converse All Star</a>
                                <span class="header-cart-item-info">1 x $39.00</span>
                            </div>
                        </li>

                        <li class="header-cart-item flex-w flex-t m-b-12">
                            <div class="header-cart-item-img"><img src="images/item-cart-03.jpg" alt="IMG"></div>
                            <div class="header-cart-item-txt p-t-8">
                                <a href="#" class="header-cart-item-name m-b-18 hov-cl1 trans-04">Nixon Porter Leather</a>
                                <span class="header-cart-item-info">1 x $17.00</span>
                            </div>
                        </li>
                    </ul>

                <div class="w-full">
                    <div class="header-cart-total w-full p-tb-40">Total: $75.00</div>
                    <div class="header-cart-buttons flex-w w-full">
                        <a href="shoping-cart.jsp" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-r-8 m-b-10">
                            View Cart</a>
                        <a href="shoping-cart.jsp" class="flex-c-m stext-101 cl0 size-107 bg3 bor2 hov-btn3 p-lr-15 trans-04 m-b-10">
                            Check Out</a>
                    </div>
                </div>
                </div>
            </div>
    </div>


    <%
    // Fetch all books from the database
    bookDB db = new bookDB();
    List<Book> books = db.getRecord();
    
%>
    
    <!-- Product -->
    <div class="bg0 m-t-23 p-b-140">
        <div class="container">
            <div class="flex-w flex-sb-m p-b-52">
                <div class="flex-w flex-l-m filter-tope-group m-tb-10">
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5 how-active1" data-filter="*">All Book</button>
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".EngBook">English Book</button>
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".men">Buku Bahasa Melayu</button>
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".bag">Chinese Book</button>
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".shoes">Revision Book</button>
                    <button class="stext-106 cl6 hov1 bor3 trans-04 m-r-32 m-tb-5" data-filter=".shoes">Stationery</button>
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
                <!-- Search product -->
                <div class="dis-none panel-search w-full p-t-10 p-b-15">
                    <form method="GET" action="search-book.jsp">
        <div class="bor8 dis-flex p-l-15">
            <button type="submit" class="size-113 flex-c-m fs-16 cl2 hov-cl1 trans-04">
                <i class="zmdi zmdi-search"></i>
            </button>
            <input class="mtext-107 cl2 size-114 plh2 p-r-15" 
                   type="text" 
                   name="search-product" 
                   placeholder="Search Book">
        </div>
    </form>	
                </div>

                <!-- Filter -->
                <div class="dis-none panel-filter w-full p-t-10 filter-tope-group">
                    <div class="wrap-filter flex-w bg6 w-full p-lr-40 p-t-27 p-lr-15-sm">
                        <div class="filter-col1 p-r-15 p-b-27">
                            <div class="mtext-102 cl2 p-b-15">English Book</div>
                                <ul>    
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04 filter-link-active">New Arrivals</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".comics">Comics</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".comics">Cook Book</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".comics">Hobby & Interest</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".comics">Travel</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04" data-filter=".comics">Young Adult</button></li>
                                </ul>
                        </div>
                        <div class="filter-col2 p-r-15 p-b-27">
                            <div class="mtext-102 cl2 p-b-15">Buku Bahasa Melayu</div>
                                <ul>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04 filter-link-active">New Arrivals</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Kanak-kanak</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Kesihatan</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Remaja</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Seni & Kraf(DIY)</button></li>
                                </ul>
                            </div>
                        <div class="filter-col3 p-r-15 p-b-27">
                            <div class="mtext-102 cl2 p-b-15">Chinese Book</div>
                                <ul>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04 filter-link-active">New Arravals</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Novel</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Magazine</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Children Books</button></li>
                                </ul>
                            </div>
                        <div class="filter-col4 p-b-27">
                            <div class="mtext-102 cl2 p-b-15">Revision Book</div>
                                <ul>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04 filter-link-active">SPM</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">STPM /Pre-U</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Secondary SMK</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Primary SJK</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Primary SK</button></li>
                                </ul>
                        </div>
                        <div class="filter-col4 p-b-27">
                            <div class="mtext-102 cl2 p-b-15">Revision Book</div>
                                <ul>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04 filter-link-active">Art & Craft</button></li>
                                    <li class="p-b-6"><button class="filter-link stext-106 trans-04">Bag & Accessories</button></li>
                                </ul>
                        </div>
                    </div>
                </div>
                
    <div class="row isotope-grid">
            <%
        if (books != null && !books.isEmpty()) {
            for (Book book : books) {
    %>
    <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item EngBook comics">
            <!-- Block2 -->
            <div class="block2">
                <div class="block2-pic hov-img0"> <img src="<%= book.getBOOK_IMAGE() %>" alt="IMG-PRODUCT">
                    <a href="product-detail.jsp??BOOK_ID=<%= book.getBOOK_ID() %>" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 js-show-modal1">
                        Quick View</a>
                </div>
                <div class="block2-txt flex-w flex-t p-t-14">
                    <div class="block2-txt-child1 flex-col-l ">
                        <a href="product-detail.jsp??BOOK_ID=<%= book.getBOOK_ID() %>" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                            <%= book.getBOOK_NAME() %></a>
                        <span class="stext-105 cl3">RM <%= String.format("%.2f", book.getBOOK_PRICE()) %></span>
  
                    </div>
                </div>
            </div>
        </div>
                     <%
            }
        } else {
    %>
        <p>No books available in the database.</p>
    <%
        }
    %>
<!--    <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item women">
         Block2 
        <div class="block2">
            <div class="block2-pic hov-img0"> <img src="images/product-02.jpg" alt="IMG-PRODUCT">
                <a href="#" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 js-show-modal1">
                    Quick View</a>
                </div>
            <div class="block2-txt flex-w flex-t p-t-14">
                <div class="block2-txt-child1 flex-col-l ">
                    <a href="product-detail.jsp" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                        Herschel supply</a>
                    <span class="stext-105 cl3"> $35.31</span>
                </div>
                <div class="block2-txt-child2 flex-r p-t-3">
                    <a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
                        <img class="icon-heart1 dis-block trans-04" src="images/icons/icon-heart-01.png" alt="ICON">
                        <img class="icon-heart2 dis-block trans-04 ab-t-l" src="images/icons/icon-heart-02.png" alt="ICON">
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item men">
         Block2 
        <div class="block2">
            <div class="block2-pic hov-img0"><img src="images/product-03.jpg" alt="IMG-PRODUCT">
                <a href="#" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 js-show-modal1">
                    Quick View</a>
            </div>
            <div class="block2-txt flex-w flex-t p-t-14">
                <div class="block2-txt-child1 flex-col-l ">
                    <a href="product-detail.jsp" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                        Only Check Trouser</a>
                    <span class="stext-105 cl3">$25.50</span>
                </div>
                <div class="block2-txt-child2 flex-r p-t-3">
                    <a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
                        <img class="icon-heart1 dis-block trans-04" src="images/icons/icon-heart-01.png" alt="ICON">
                        <img class="icon-heart2 dis-block trans-04 ab-t-l" src="images/icons/icon-heart-02.png" alt="ICON">
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item watches">
         Block2 
        <div class="block2">
            <div class="block2-pic hov-img0"><img src="images/product-06.jpg" alt="IMG-PRODUCT">
                <a href="#" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 js-show-modal1">
                    Quick View</a>
            </div>
            <div class="block2-txt flex-w flex-t p-t-14">
                <div class="block2-txt-child1 flex-col-l ">
                    <a href="product-detail.jsp" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                        Vintage Inspired Classic </a>
                    <span class="stext-105 cl3">$93.20</span>
                </div>
                <div class="block2-txt-child2 flex-r p-t-3">
                    <a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
                        <img class="icon-heart1 dis-block trans-04" src="images/icons/icon-heart-01.png" alt="ICON">
                        <img class="icon-heart2 dis-block trans-04 ab-t-l" src="images/icons/icon-heart-02.png" alt="ICON">
                    </a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item shoes">
         Block2 
        <div class="block2">
        <div class="block2-pic hov-img0">
            <img src="images/product-09.jpg" alt="IMG-PRODUCT">
                <a href="#" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 js-show-modal1">
                    Quick View</a>
                </div>
                <div class="block2-txt flex-w flex-t p-t-14">
                    <div class="block2-txt-child1 flex-col-l ">
                        <a href="product-detail.jsp" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                            Converse All Star Hi Plimsolls
                        </a>
                        <span class="stext-105 cl3">$75.00</span>
                    </div>
                    <div class="block2-txt-child2 flex-r p-t-3">
                        <a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
                            <img class="icon-heart1 dis-block trans-04" src="images/icons/icon-heart-01.png" alt="ICON">
                            <img class="icon-heart2 dis-block trans-04 ab-t-l" src="images/icons/icon-heart-02.png" alt="ICON">
                        </a>
                    </div>
                </div>
            </div>
        </div>
    <div class="col-sm-6 col-md-4 col-lg-3 p-b-35 isotope-item men">
             Block2 
            <div class="block2">
                <div class="block2-pic hov-img0"><img src="images/product-12.jpg" alt="IMG-PRODUCT">
                    <a href="#" class="block2-btn flex-c-m stext-103 cl2 size-102 bg0 bor2 hov-btn1 p-lr-15 trans-04 js-show-modal1">
                        Quick View
                    </a>
                </div>
                <div class="block2-txt flex-w flex-t p-t-14">
                    <div class="block2-txt-child1 flex-col-l ">
                        <a href="product-detail.jsp" class="stext-104 cl4 hov-cl1 trans-04 js-name-b2 p-b-6">
                            Herschel supply
                        </a>
                        <span class="stext-105 cl3">$63.15</span>
                    </div>
                    <div class="block2-txt-child2 flex-r p-t-3">
                        <a href="#" class="btn-addwish-b2 dis-block pos-relative js-addwish-b2">
                            <img class="icon-heart1 dis-block trans-04" src="images/icons/icon-heart-01.png" alt="ICON">
                            <img class="icon-heart2 dis-block trans-04 ab-t-l" src="images/icons/icon-heart-02.png" alt="ICON">
                        </a>
                    </div>
                </div>
            </div>
        </div>-->
    </div>
        </div>
    </div>
		
<!-- Footer -->
<footer class="bg3 p-t-75 p-b-32">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 col-lg-3 p-b-50">
                <h4 class="stext-301 cl0 p-b-30">Categories</h4>
                <ul><li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04"> Women</a></li>
                    <li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">Men</a></li>
                    <li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">Shoes</a></li>
                    <li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">Watches</a></li>
                </ul>
            </div>

            <div class="col-sm-6 col-lg-3 p-b-50">
                <h4 class="stext-301 cl0 p-b-30">Help</h4>
                    <ul><li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">Track Order</a></li>
                        <li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">Returns</a></li>
                        <li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">Shipping</a></li>
                        <li class="p-b-10"><a href="#" class="stext-107 cl7 hov-cl1 trans-04">FAQs</a></li>
                    </ul>
            </div>

            <div class="col-sm-6 col-lg-3 p-b-50">
                <h4 class="stext-301 cl0 p-b-30">GET IN TOUCH</h4>
                    <p class="stext-107 cl7 size-201">Any questions? Let us know in store at 8th floor, 379 Hudson St, New York, NY 10018 or call us on (+1) 96 716 6879</p>
                    <div class="p-t-27">
                        <a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16"><i class="fa fa-facebook"></i></a>
                        <a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16"><i class="fa fa-instagram"></i></a>
                        <a href="#" class="fs-18 cl7 hov-cl1 trans-04 m-r-16"><i class="fa fa-pinterest-p"></i></a>
                    </div>
            </div>

            <div class="col-sm-6 col-lg-3 p-b-50">
                <h4 class="stext-301 cl0 p-b-30">Newsletter</h4>
                    <form>
                        <div class="wrap-input1 w-full p-b-4">
                            <input class="input1 bg-none plh1 stext-107 cl7" type="text" name="email" placeholder="email@example.com">
                            <div class="focus-input1 trans-04"></div>
                        </div>

                        <div class="p-t-18">
                            <button class="flex-c-m stext-101 cl0 size-103 bg1 bor1 hov-btn2 p-lr-15 trans-04">
                                    Subscribe
                            </button>
                        </div>
                    </form>
            </div>
        </div>

        <div class="p-t-40">
            <div class="flex-c-m flex-w p-b-18">
                <a href="#" class="m-all-1"><img src="images/icons/icon-pay-01.png" alt="ICON-PAY"></a>
                <a href="#" class="m-all-1"><img src="images/icons/icon-pay-02.png" alt="ICON-PAY"></a>
                <a href="#" class="m-all-1"><img src="images/icons/icon-pay-03.png" alt="ICON-PAY"></a>
                <a href="#" class="m-all-1"><img src="images/icons/icon-pay-04.png" alt="ICON-PAY"></a>
                <a href="#" class="m-all-1"><img src="images/icons/icon-pay-05.png" alt="ICON-PAY"></a>
            </div>

            <p class="stext-107 cl6 txt-center">
            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
            Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved |Made with 
                <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a> &amp; distributed by <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
            <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
            </p>
        </div>
    </div>
</footer>

<!-- Back to top -->
<div class="btn-back-to-top" id="myBtn">
    <span class="symbol-btn-back-to-top"><i class="zmdi zmdi-chevron-up"></i></span>
</div>

<!-- Modal1 -->
<div class="wrap-modal1 js-modal1 p-t-60 p-b-20">
    <div class="overlay-modal1 js-hide-modal1"></div>
        <div class="container">
            <div class="bg0 p-t-60 p-b-30 p-lr-15-lg how-pos3-parent">
                <button class="how-pos3 hov3 trans-04 js-hide-modal1"><img src="images/icons/icon-close.png" alt="CLOSE"></button>
                    <div class="row">
                                    <%
        if (books != null && !books.isEmpty()) {
            for (Book book : books) {
    %>
                        <div class="col-md-6 col-lg-7 p-b-30">
                            <div class="p-l-25 p-r-30 p-lr-0-lg">
                                <div class="wrap-slick3 flex-sb flex-w">
                                    <div class="wrap-slick3-dots"></div>
                                    <div class="wrap-slick3-arrows flex-sb-m flex-w"></div>
                                    <div class="slick3 gallery-lb">
                                    <div class="item-slick3" data-thumb="<%= book.getBOOK_IMAGE() %>">
                                        <div class="wrap-pic-w pos-relative">
                                            <img src="<%= book.getBOOK_IMAGE() %>" alt="IMG-PRODUCT">
                                                <a class="flex-c-m size-108 how-pos1 bor0 fs-16 cl10 bg0 hov-btn3 trans-04" href="<%= book.getBOOK_IMAGE() %>">
                                                <i class="fa fa-expand"></i></a>
                                        </div>
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-md-6 col-lg-5 p-b-30">
                            <div class="p-r-50 p-t-5 p-lr-0-lg">
                                <h4 class="mtext-105 cl2 js-name-detail p-b-14"><%= book.getBOOK_NAME() %></h4>
                                <span class="mtext-106 cl2">RM <%= String.format("%.2f", book.getBOOK_PRICE()) %></span>
                                <ul>
                                    <li>Description: <%= book.getBOOK_DESC() %></li>
                                    <li>Author Name: <%= book.getAUTHOR_NAME() %></li>
                                    <li>Publisher: <%= book.getPUBLISHER() %></li>
                                    <li>No.of Pages: <%= book.getNO_OF_PAGES() %></li>
                                    <li>Category: <%= book.getBOOK_TYPE() %></li>
                                </ul>

                            <!--  -->
                            <div class="p-t-33">
                            <div class="flex-w flex-r-m p-b-10">
                               <div class="size-204 flex-w flex-m respon6-next">
                                    <div class="wrap-num-product flex-w m-r-20 m-tb-10">
                                        <div class="btn-num-product-down cl8 hov-btn3 trans-04 flex-c-m">
                                            <i class="fs-16 zmdi zmdi-minus"></i>
                                        </div>
                                        <input class="mtext-104 cl3 txt-center num-product" type="number" name="num-product" value="1">
                                        <div class="btn-num-product-up cl8 hov-btn3 trans-04 flex-c-m">
                                            <i class="fs-16 zmdi zmdi-plus"></i>
                                        </div>
                                    </div>
                                    <button class="flex-c-m stext-101 cl0 size-101 bg1 bor1 hov-btn1 p-lr-15 trans-04 js-addcart-detail">Add to cart</button>
                                </div>
                            </div>	
                            </div>
                            </div>
                        </div>
                                <%
            }
        } else {
    %>
        <p>No books available in the database.</p>
    <%
        }
    %>
                    </div>
             </div>
        </div>
</div>

<!--===============================================================================================-->	
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
	<script>
		$(".js-select2").each(function(){
			$(this).select2({
				minimumResultsForSearch: 20,
				dropdownParent: $(this).next('.dropDownSelect2')
			});
		})
	</script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/slick/slick.min.js"></script>
	<script src="js/slick-custom.js"></script>
<!--===============================================================================================-->
	<script src="vendor/parallax100/parallax100.js"></script>
	<script>
        $('.parallax100').parallax100();
	</script>
<!--===============================================================================================-->
	<script src="vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
	<script>
		$('.gallery-lb').each(function() { // the containers for all your galleries
			$(this).magnificPopup({
		        delegate: 'a', // the selector for gallery item
		        type: 'image',
		        gallery: {
		        	enabled:true
		        },
		        mainClass: 'mfp-fade'
		    });
		});
	</script>
<!--===============================================================================================-->
	<script src="vendor/isotope/isotope.pkgd.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/sweetalert/sweetalert.min.js"></script>
	<script>
		$('.js-addwish-b2, .js-addwish-detail').on('click', function(e){
			e.preventDefault();
		});

		$('.js-addwish-b2').each(function(){
			var nameProduct = $(this).parent().parent().find('.js-name-b2').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to wishlist !", "success");
				$(this).addClass('js-addedwish-b2');
				$(this).off('click');
			});
		});

		$('.js-addwish-detail').each(function(){
			var nameProduct = $(this).parent().parent().parent().find('.js-name-detail').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to wishlist !", "success");
				$(this).addClass('js-addedwish-detail');
				$(this).off('click');
                            });
		});

		/*---------------------------------------------*/

		$('.js-addcart-detail').each(function(){
			var nameProduct = $(this).parent().parent().parent().parent().find('.js-name-detail').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to cart !", "success");
			});
		});
	
	</script>
<!--===============================================================================================-->
	<script src="vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script>
		$('.js-pscroll').each(function(){
			$(this).css('position','relative');
			$(this).css('overflow','hidden');
			var ps = new PerfectScrollbar(this, {
				wheelSpeed: 1,
				scrollingThreshold: 1000,
				wheelPropagation: false,
			});

			$(window).on('resize', function(){
				ps.update();
			})
		});
	</script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>

</body>
</html>