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
                
            <!-------------------------------------------------------------button---------------------------------------------------------->
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
                    <div class="gallery_container">
                        <% while (rs != null && rs.next()) { %>
                        <div class="gallery_item">
                            <a data-fancybox="gallery" href="<%= rs.getString("BOOK_IMAGE") %>">
                              <img class="img-responsive" width="250" height="250"src="<%= rs.getString("BOOK_IMAGE") %>" alt="#" />
                            </a>
                          
                            <div class="heading_section">
                            <div class="button_container"> 
                                <a href="editProduct.jsp?id=<%= rs.getString("BOOK_ID") %>"><button type="submit" class="edit_button">Edit</button></a>
                                <a href="deleteProduct.jsp?id=<%= rs.getString("BOOK_ID") %>"><button type="submit" class="edit_button">Delete</button></a>
                              </div>
                              <h6 style="color: black">Current Stock: <%= rs.getInt("BOOK_QUANTITY") %></h6>
                              <h6 style="color: black">Price: RM <%= rs.getDouble("BOOK_PRICE") %></h6>
                              <p style="color: black"><%= rs.getString("BOOK_NAME") %></p>
                            </div>
                        </div>
                        <% } %>
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
        <footer class="footer">
          <div class="container-fluid d-flex justify-content-between">
            <nav class="pull-left">
              <ul class="nav">
                <li class="nav-item">
                  <a class="nav-link" href="http://www.themekita.com">
                    ThemeKita
                  </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#"> Help </a>
                </li>
                <li class="nav-item">
                  <a class="nav-link" href="#"> Licenses </a>
                </li>
              </ul>
            </nav>
            <div class="copyright">
              2024, made with <i class="fa fa-heart heart text-danger"></i> by
              <a href="http://www.themekita.com">ThemeKita</a>
            </div>
            <div>
              Distributed by
              <a target="_blank" href="https://themewagon.com/">ThemeWagon</a>.
            </div>
          </div>
        </footer>
      </div>
    </div>
      
      
   
      
    <!--   Core JS Files   -->
    <script src="assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="assets/js/core/popper.min.js"></script>
    <script src="assets/js/core/bootstrap.min.js"></script>

    <!-- jQuery Scrollbar -->
    <script src="assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

    <!-- Chart JS -->
    <script src="assets/js/plugin/chart.js/chart.min.js"></script>

    <!-- jQuery Sparkline -->
    <script src="assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>

    <!-- Chart Circle -->
    <script src="assets/js/plugin/chart-circle/circles.min.js"></script>

    <!-- Datatables -->
    <script src="assets/js/plugin/datatables/datatables.min.js"></script>

    <!-- Bootstrap Notify -->
    <script src="assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>

    <!-- jQuery Vector Maps -->
    <script src="assets/js/plugin/jsvectormap/jsvectormap.min.js"></script>
    <script src="assets/js/plugin/jsvectormap/world.js"></script>

    <!-- Google Maps Plugin -->
    <script src="assets/js/plugin/gmaps/gmaps.js"></script>

    <!-- Sweet Alert -->
    <script src="assets/js/plugin/sweetalert/sweetalert.min.js"></script>

    <!-- Kaiadmin JS -->
    <script src="assets/js/kaiadmin.min.js"></script>
    
    <!-- Kaiadmin DEMO methods, don't include it in your project! -->
    <script src="assets/js/setting-demo.js"></script>
    <script src="assets/js/demo.js"></script>
    <script>
      $("#lineChart").sparkline([102, 109, 120, 99, 110, 105, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#177dff",
        fillColor: "rgba(23, 125, 255, 0.14)",
      });

      $("#lineChart2").sparkline([99, 125, 122, 105, 110, 124, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#f3545d",
        fillColor: "rgba(243, 84, 93, .14)",
      });

      $("#lineChart3").sparkline([105, 103, 123, 100, 95, 105, 115], {
        type: "line",
        height: "70",
        width: "100%",
        lineWidth: "2",
        lineColor: "#ffa534",
        fillColor: "rgba(255, 165, 52, .14)",
      });
    </script>
  </body>
</html>
