<%-- 
    Document   : productAdmin
    Created on : 17 Apr 2025, 11:31:17 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DB.ProductDB"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>BOOKLOOM Admin Page</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="images/tablogo.png"
      type="image/x-icon"
    />

    <!-- Fonts and icons -->
    <script src="assets/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["assets/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/plugins.min.css" />
    <link rel="stylesheet" href="assets/css/kaiadmin.min.css" />

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="assets/css/demo.css" />
    
    <style>
        .button_container {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-bottom: 10px;
        
        }
        
        .edit_button {
            font-weight: bold;
            color: darkslategray;
            -webkit-box-flex: 0;
            -ms-flex: 0 0 100%;
            flex: 1; /* Make buttons share space equally */
            max-width: 98%;
            margin: auto;
            justify-content: center;
            align-items: center;
            background-color: whitesmoke;
            cursor: pointer;
            font-size: 14px; /* Smaller font */
            width: 105px; /* Remove fixed width */
            height: 40px; /* Smaller height */
            border: 2px solid whitesmoke;
            box-shadow: 0px 1px 1px 1px grey;
            border-radius: 10px;
            transform: translate(1%, 0%);
        }
         
        .edit_button:hover {
           color: black;
           font-weight: bold;
           background-color: #9BB0C1;
           transition-duration: 0.6s;
        }
         
        .create_button {
           font-weight: bold;
           color: black;
           display: flex;
           justify-content: center;
           align-items: center;
           background-color: #9BB0C1;
           cursor: pointer;
           font-size: 16px;
           padding:9px 25px;
           border: none;
           border-radius: 50px;
           cursor: pointer;
           float: right;
           margin: 10px;
        }
        
        .create_button:hover {
            color: white;
            background-color: #00224D;
            transition-duration: 0.6s;
        }
        
        .heading_section p {
           color: white;
           text-align: center;
        }
        .heading_section h6 {
           font-size: large;
           color: white;
           text-align: center;
        }

        .gallery_container {
           display: grid;
           grid-template-columns: repeat(4, 1fr);
           gap: 15px; /* Adjust the gap between items as needed */
           padding: 35px; /* Ensure padding for consistency */
        }

        .gallery_item {
           background: #fff;
           box-shadow: 0 0 13px -10px #000;
           overflow: hidden;
           padding: 20px;
           border-radius: 5px;
           text-align: center;
        }

        .gallery_item img {
           max-width: 100%;
           height: auto;
           display: block;
           margin: 0 auto 10px;
        }
        
        
        .pagination-wrapper {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            font-weight: bold;
            font-size: 16px;
        }

        .page-label {
            color: #333;
        }

        .pagination {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            gap: 6px;
        }

        .pagination li {
            display: inline-block;
        }

        .pagination li a {
            padding: 6px 12px;
            border: 1px solid #007bff;
            border-radius: 5px;
            text-decoration: none;
            color: black;
            font-weight: bold;
            background-color: white;
            transition: background-color 0.3s, color 0.3s;
        }

        .pagination li.active a,
        .pagination li a:hover {
            background-color: lightskyblue;
        }
    </style>
  </head>
  <body>
      <%@ include file="adminHeader.jsp" %>
      
        <div class="container">
          <div class="page-inner">
            <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
                
                <!--------------------------------------------------------Page Header------------------------------------------------------->    
                <div class="page-header">
                    <h3 class="fw-bold mb-3">Products</h3>
                    <ul class="breadcrumbs mb-3">
                      <li class="nav-home">
                        <a href="#">
                          <i class="icon-home"></i>
                        </a>
                      </li>
                      <li class="separator">
                        <i class="icon-arrow-right"></i>
                      </li>
                      <li class="nav-item">
                        <a href="#">Products</a>
                      </li>
                      <li class="separator">
                        <i class="icon-arrow-right"></i>
                      </li>
                      <li class="nav-item">
                        <a href="#">Products Management</a>
                      </li>
                    </ul>
                </div>
            </div>
            
            <!--------------------------------------------------------Content------------------------------------------------------->
            <div class="row">
                <div class="col-md-12">
                    <div class="card">    
                    <div class="card-header">
                        <div class="d-flex align-items-center">
                          <h4 class="card-title">Products</h4>

                          <!-------------------------------------------- Button------------------------------------------------------ -->
                          <button
                            onclick="window.location.href='AddProduct.jsp';"
                            class="btn btn-primary btn-round ms-auto" style="font-weight:bold"
                          >
                            <i class="fa fa-plus"></i>
                             Create New Product
                          </button>
                        </div>
                    </div>
                    <%
                    ProductDB productDB = new ProductDB();
                    ResultSet rs = null;
                    try {
                        rs = productDB.getAllRecords();
                  %>
                  
                 <div class="card-body">
                     
                     <%
                        String bookName = (String) request.getAttribute("bookName");
                        if (bookName != null) {
                    %>
                        <div class="success-msg" style="padding-left: 20px; padding-bottom: 20px; padding-top: 20px; color: green; font-weight: bold; background-color: whitesmoke;">
                            Product "<%= bookName %>" has been deleted successfully.
                        </div>
                    <%
                        }
                    %>
                     <!------------------------------------------------- Data Table ------------------------------------------------------->
                    <div id="productList">
                        <!-- Search & Pagination Controls -->
                        <div class="row" style="margin-bottom: 20px;">
                            <div class="col-md-6">
                               <input class="search form-control" placeholder="Search product..." />
                            </div>
                            <div class="col-md-6 text-right">
                               <div class="pagination-wrapper">
                                 <span class="page-label">Page:</span>
                                 <ul class="pagination pagination-sm"></ul>
                               </div>
                            </div>
                        </div>

                        <!-- Gallery Items Container -->
                        <div class="gallery_container list">
                            <% while (rs != null && rs.next()) { %>
                            <div class="gallery_item">
                                <a data-fancybox="gallery" href="<%= rs.getString("BOOK_IMAGE") %>">
                                  <img class="img-responsive" width="250" height="250" src="<%= rs.getString("BOOK_IMAGE") %>" alt="#" />
                                </a>
                                <div class="heading_section">
                                    <div class="button_container"> 
                                        <a href="editProduct.jsp?id=<%= rs.getString("BOOK_ID") %>">
                                            <button type="submit" class="edit_button">Edit</button>
                                        </a>
                                        <a href="deleteProduct.jsp?id=<%= rs.getString("BOOK_ID") %>">
                                            <button type="submit" class="edit_button">Delete</button>
                                        </a>
                                    </div>
                                    <!-- These span elements help List.js search/filter -->
                                    <h6 class="book-quantity" style="color: black">Current Stock: <%= rs.getInt("BOOK_QUANTITY") %></h6>
                                    <h6 class="book-price" style="color: black">Price: RM <%= rs.getDouble("BOOK_PRICE") %></h6>
                                    <p class="book-name" style="color: black"><%= rs.getString("BOOK_NAME") %></p>
                                </div>
                            </div>
                            <% } %>
                        </div>
                    </div>
                     <%
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) {
                                    try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                }
                                if (productDB != null) {
                                    try { productDB.shutDown(); } catch (SQLException e) { e.printStackTrace(); }
                                }
                            }
                        %>
                <!-------------------------------------------------End of Data Table ---------------------------------->
            </div>
            </div>
            </div>
            </div>
          </div>
        </div>
        
        <!--------------------------------------------------------Footer---------------------------------------------------------->
         <%@ include file="adminFooter.jsp" %>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/list.js/2.3.1/list.min.js"></script>
         <script>
            var options = {
              valueNames: ['book-name', 'book-price', 'book-quantity'],
              page: 8,
              pagination: true
            };

            var productList = new List('productList', options);
        </script>
  </body>
</html>
