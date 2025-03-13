<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BookLoom - Home</title>
    <link rel="stylesheet" href="MainPage.css">
</head>
<body>
    <!-- Header Section -->
    <header>
        <div class="top-bar">
            <!--<img src="Logo.png" alt="BookLoom Logo" class="logo">-->
            <nav>
                <a href="index.jsp">Home</a>
                <a href="books.jsp">Books</a>
                <a href="stationery.jsp">Stationery</a>
                <a href="promotions.jsp">Promotions</a>
                <a href="contact.jsp">Contact</a>
            </nav>
            <a href="login.jsp">
                <!--<img src="login.png" alt="Login" class="login-logo">-->
            </a>
        </div>
    </header>

    <!-- About Section -->
    <section class="about-section">
        <div class="about-image">
            <img src="about-us.png" alt="About Us">
        </div>
        <div class="about-text">
            <h2>About Us</h2>
            <p>BookLoom is your one-stop shop for books and stationery. Discover our latest collections and exclusive deals.</p>
        </div>
    </section>

    <!-- Product Showcase -->
    <section class="product-section">
        <h2>Show Products</h2>
        <div class="product-row">
            <div class="product-item"><img src="images/product1.jpg" alt="Product 1"></div>
            <div class="product-item"><img src="images/product2.jpg" alt="Product 2"></div>
            <div class="product-item"><img src="images/product3.jpg" alt="Product 3"></div>
            <div class="product-item"><img src="images/product4.jpg" alt="Product 4"></div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        &copy; 2025 BookLoom. All Rights Reserved.
    </footer>
</body>
</html>
