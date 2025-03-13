<%-- 
    Document   : Product page
    Created on : 13 Mar 2025, 2:43:36 pm
    Author     : tanan
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="Product.css"/>
        <title>Book Loom</title>
    </head>
    <body>
        <div style="text-align: center; position: relative;">
            <form action="SearchServlet" method="GET">
                <input class="search" type="text" name="search" placeholder="Search Book" 
                       style="width: 400px; height: 40px; border: 3px solid black; border-radius: 50px; padding:0px 30px 0px 30px">
                &nbsp;&nbsp;
                <input type="image" src="image/search.png" alt="Search" width="40" height="40" style="position: absolute; bottom: 5px"/>
            </form>
        </div>



    </body>
</html>


