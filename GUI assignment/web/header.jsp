<!DOCTYPE html>
<html>
    <head>
        <%@page import="java.util.List, DB.bookDB, domain.Book"%>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Book Loom</title>
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="images/icons/tablogo.png"/>
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
    <%
        //String userId = (String) session.getAttribute("userId"); 
        String userId = "user123"; 
        bookDB db = new bookDB();
        int totalBooks = db.getTotalBooksInCart(userId);
    %>
    
    <body>
        <!-- Header -->
    <header class="header-v4">
        <div class="container-menu-desktop">
            <div class="top-bar">
                <div class="content-topbar flex-sb-m h-full container">

                    <div class="right-top-bar flex-w h-full">
                        <a href="#" class="flex-c-m trans-04 p-lr-25">Help & FAQs</a>
                        <a href="#" class="flex-c-m trans-04 p-lr-25">My Account</a>
                    </div>
                </div>
            </div>

            <div class="wrap-menu-desktop how-shadow1">
                <nav class="limiter-menu-desktop container">		
                    <a href="#" class="logo"><img src="Logo.png" alt="IMG-LOGO"></a>
                    <div class="menu-desktop">
                        <ul class="main-menu">
                            <li class="active-menu"><a href="product.jsp">Book</a></li>
                            <li class="label1" data-label1="hot"><a href="shoping-cart.jsp">Shoping Cart</a></li>
                            <li><a href="blog.jsp">Blog</a></li>
                            <li><a href="about.jsp">About</a></li>
                            <li><a href="contact.jsp">Contact</a></li>
                        </ul>
                    </div>	

                    <!-- Icon header -->
                    <div class="wrap-icon-header flex-w flex-r-m">
                        <div class="icon-header-item trans-04 p-l-22 p-r-11 icon-header-noti js-show-cart" data-notify="<%= totalBooks%>">
                            <a href="shoping-cart.jsp" style="color:black; "><i class="zmdi zmdi-shopping-cart"></i></a>
                        </div>
                    </div>
                </nav>
            </div>	
        </div>

    <!-- Header Mobile -->
    <div class="wrap-header-mobile">		
        <div class="logo-mobile"><a href="index.jsp"><img src="images/icons/logo-01.png" alt="IMG-LOGO"></a></div>
            <!-- Icon header -->
            <div class="wrap-icon-header flex-w flex-r-m m-r-15">
                
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
            <li><div class="right-top-bar flex-w h-full">
                <a href="#" class="flex-c-m p-lr-10 trans-04">Help & FAQs</a>
                <a href="#" class="flex-c-m p-lr-10 trans-04">My Account</a>
            </li>
        </ul>

        <ul class="main-menu-m">
            <li><a href="product.jsp">Book</a></li>
            <li><a href="shoping-cart.jsp" class="label1 rs1" data-label1="hot"> Shoping Cart</a></li>
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

    </body>
</html>
