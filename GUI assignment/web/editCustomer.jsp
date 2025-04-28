<%-- 
    Document   : EditCustomer
    Created on : 28 Apr 2025, 4:37:39 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DB.CustomerDB, domain.Customer" %>
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
  </head>
  <style>
      .container1{
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 25px;
            min-height: 100vh;
            background-color: whitesmoke;
            padding-bottom: 70px;
         }

         .container1 form{
            padding: 20px;
            width: 700px;
            background-color: #1A2035;
            box-shadow: 0 5px 10px rgba(0,0,0,.1);
            border-radius: 20px;
            box-shadow: 0px 2px 3px 3px grey;
         }

         .container1 form .row1 .col1 .title{
            font-size: 25px;
            color: white;
            font-weight: bold;
            padding-bottom: 5px;
            text-transform: uppercase;
            text-align: center;
         }

         .container1 form .row1 .inputBox{
            margin: 15px 0;
         }

         .container1 form .row1 .inputBox input{
            width: 100px;
            border: 2px solid #ffffff;width: 625px;
            padding: 10px 15px;
            font-size: 15px;
            text-transform: none;
            border-radius: 20px;
         }

         .container1 form .row1 .inputBox span{
            margin: 15px 0;
            font-size: 16px;
            color: white;
         }

         .button {
            font-weight: bold;
            color: white;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #212529;
            cursor: pointer;
            font-size: 16px;
            padding:9px 25px;
            border: none;
            border-radius: 50px;
            cursor: pointer;
            float: right;
	    margin: 10px;
         }

         .button:hover {
            color: black;
            background-color: #9BB0C1;
            transition-duration: 0.6s;
         }
  </style>
  <body>
      <%@ include file="adminHeader.jsp" %>
      
        <div class="container">
          <div class="page-inner">
              
            <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
            <!--------------------------------------------------------Page Header------------------------------------------------------->
              <div class="page-header">
                <h3 class="fw-bold mb-3">Customer Accounts</h3>
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
                    <a href="#">Customer Accounts</a>
                  </li>
                  <li class="separator">
                    <i class="icon-arrow-right"></i>
                  </li>
                  <li class="nav-item">
                    <a href="#">Customer Account Management</a>
                  </li>
                </ul>
              </div>
            </div>
            
            <!-------------------------------------------------------------Content---------------------------------------------------------->  
            <div class="row">
            <div class="col-md-12">
                <div class="card">
                  <div class="card-header">
                    <div class="d-flex align-items-center">
                      <h4 class="card-title">Customer Account Management</h4>
                    </div>
                  </div>
                   <%
                    String customerId = request.getParameter("id");
                    Customer customer = null;
                    try {
                        CustomerDB db = new CustomerDB();
                        customer = db.getCustomerById(customerId);
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                %>
                  <div class="card-body">
                    <%
                        String customerName = (String) request.getAttribute("CustomerName");
                        boolean isSuccess = customerName != null;
                        if (customerName != null) {
                    %>
                        <div style="padding-left: 20px; padding-top: 20px; color: green; font-weight: bold; background-color: whitesmoke;">
                            Customer "<%= customerName %>" has been updated successfully.
                            <a href="ViewCustomer.jsp">[Back to List Customer]</a>
                        </div>
                    <%
                        }
                    %>


                 <!------------------------------------------------ Form------------------------------------------------------------>        
                      <div class="container1">
                          <form action="editCustomerServlet" method="POST" class="" name="editCustomerForm">
                           <div class="row1">
                              <div class="col1">
                                 <p class="title">Edit Customer Account</p>
                                 
                                    <input type="hidden" name="id" value="<%= customer.getCusID() %>" />
                                    
                                    <div class="inputBox">
                                       <label><span>Name :</span></label>
                                       <input type="text" name="name" value="<%= isSuccess ? "" : customer.getCusName() %>" required />
                                    </div>

                                    <div class="inputBox">
                                       <label><span>User Name :</span></label>
                                       <input type="text" name="UserName" value="<%= isSuccess ? "" : customer.getCusUserName() %>" required />
                                    </div>
                                 
                                    <div class="inputBox">
                                       <label><span>Gender :</span></label>
                                       <input type="text" name="gender" value="<%= isSuccess ? "" : customer.getCusGender() %>" required />
                                    </div>
                                    
                                    <div class="inputBox">
                                       <label><span>Password :</span></label>
                                       <input type="text" name="psw" value="<%= isSuccess ? "" : customer.getCusPsw() %>" required />
                                    </div>
                                 
                                    <div class="inputBox">
                                       <label><span>E-mail :</span></label>
                                       <input type="text" name="email" value="<%= isSuccess ? "" : customer.getCusEmail() %>" required />
                                    </div>
                                    
                                    <div class="inputBox">
                                       <label><span>Phone Number :</span></label>
                                       <input type="text" name="phone" value="<%= isSuccess ? "" : customer.getCusPhone() %>" required />
                                    </div>
                                    
                                    <div class="inputBox">
                                       <label><span>Address :</span></label>
                                       <textarea style="height:90px; 
                                                 width: 95%; 
                                                 padding:6px 8px; 
                                                 box-sizing:border-box; 
                                                 resize:vertical;" type="text" name="address" required><%= isSuccess ? "" : customer.getAddress() %></textarea>
                                    </div>
                                    
                                    <input type="reset" value="Cancel" name="cancel" class="button" onclick="window.location.href='ViewCustomer.jsp'"/>
                                    <input type="submit" value="Update" name="Confirm" class="button"/>
                              </div>
                           </div>
                        </form>
                     </div>   
                <!------------------------------------------------End Form------------------------------------------------------------>   
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!--------------------------------------------------------Footer------------------------------------------------------->
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
    <script>
    // This runs only if the page loaded with staffName (successfully added)
    window.onload = function() {
        <% if (request.getAttribute("CustomerName") != null) { %>
            // Clear form fields except profile
            let form = document.getElementById("editCustomerfForm");
            form.reset();
        <% } %>
    }
</script>
  </body>
</html>

