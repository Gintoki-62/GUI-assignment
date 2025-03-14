<%-- 
    Document   : Product page
    Created on : 13 Mar 2025, 2:43:36 pm
    Author     : tanan
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="Product.css"/>
        <title>Book Loom</title>
    </head>
    <body>
        <!-- Search Bar -->
        <div style="text-align: center; position: relative;">
            <form action="SearchServlet" method="GET">
                <input class="search-bar" type="text" name="search" placeholder="Search Book" 
                       style="width: 400px; height: 40px; border: 3px solid black; border-radius: 50px; padding:0px 30px 0px 30px">
                &nbsp;&nbsp;
                <input type="image" src="image/search.png" alt="Search" width="40" height="40" style="position: absolute; bottom: 5px"/>
            </form>
        </div>
        
        <div style="margin-top: 80px; text-align: center;border-bottom: 2px solid black; padding-bottom: 10px">
        <button class="tablink" onclick="openProduct('english')" id="defaultOpen">English Books</button>&nbsp;&nbsp;&nbsp;
        <button class="tablink" onclick="openProduct('melayu')">Buku Bahasa Melayu</button>&nbsp;&nbsp;&nbsp;
        <button class="tablink" onclick="openProduct('chinese')">Chinese Books</button>&nbsp;&nbsp;&nbsp;
        <button class="tablink" onclick="openProduct('revision')">Revision Books</button>&nbsp;&nbsp;&nbsp;
        <button class="tablink" onclick="openProduct('stationery')">Stationery</button>
        </div>
        
        <div id="english" class="bookContent">
          <h3>English Books</h3>
          <p>Home is where the heart is..</p>
        </div>

        <div id="melayu" class="bookContent">
          <h3>melayu</h3>
          <p>Some news this fine day!</p>
        </div>

        <div id="chinese" class="bookContent">
          <h3>Chinese</h3>
          <p>Get in touch, or swing by for a cup of coffee.</p>
        </div>

        <div id="revision" class="bookContent">
          <h3>revision</h3>
          <p>Who we are and what we do.</p>
        </div>
        
        <div id="stationery" class="bookContent">
          <h3>stationery</h3>
          <p>Who we are and what we do.</p>
        </div>

        <script>
            function openProduct(productName) {
              var i, bookContent, tablink;
              bookContent = document.getElementsByClassName("bookContent");
              for (i = 0; i < bookContent.length; i++) {
                bookContent[i].style.display = "none";
              }
              tablink = document.getElementsByClassName("tablink");
              for (i = 0; i < tablink.length; i++) {
                tablink[i].style.backgroundColor = "";
              }
              document.getElementById(productName).style.display = "block";
              
            }

            // Get the element with id="defaultOpen" and click on it
            document.getElementById("defaultOpen").click();
        </script>

    </body>
</html>


