<%@ page import="DB.ProductDB, DB.StfAccDB, DB.CustomerDB"%>
<%@ page import="java.sql.*" %>
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
  
  <body>
      <%@ include file="adminHeader.jsp" %>
      
        <div class="container">
          <div class="page-inner">
            <div
              class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4"
            >
              <div>
                <h3 class="fw-bold mb-3">Dashboard</h3>
                <h6 class="op-7 mb-2">Welcome to Manager Page.</h6>
              </div>
            </div>
            <div class="row">
            <%
                    int customerCount = 0;
                    try {
                        CustomerDB dao = new CustomerDB(); // create object
                        customerCount = dao.countCustomer(); // call  method
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
              <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div
                          class="icon-big text-center icon-primary bubble-shadow-small"
                        >
                          <i class="fas fa-users"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div class="numbers">
                          <p class="card-category">Customers</p>
                          <h4 class="card-title"><%= customerCount %></h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            
                <%
                    int staffCount = 0;
                    try {
                        StfAccDB dao = new StfAccDB(); // create object
                        staffCount = dao.countStaff(); // call  method
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
              <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div
                          class="icon-big text-center icon-info bubble-shadow-small"
                        >
                          <i class="fas fa-user-check"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div class="numbers">
                          <p class="card-category">Staffs</p>
                          <h4 class="card-title"><%= staffCount %></h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            
                <% 
                    double TotalAmount = 0;
                    try {
                        ProductDB dao = new ProductDB(); // create object
                        TotalAmount = dao.sumTotalAmount(); // call  method
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
              <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div
                          class="icon-big text-center icon-success bubble-shadow-small"
                        >
                          <i class="fas fa-luggage-cart"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div class="numbers">
                          <p class="card-category">Sales</p>
                          <h4 class="card-title">RM <%= TotalAmount %></h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              
                <%
                    int orderCount = 0;
                    try {
                        ProductDB dao = new ProductDB(); // create object
                        orderCount = dao.countOrder(); // call  method
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
              <div class="col-sm-6 col-md-3">
                <div class="card card-stats card-round">
                  <div class="card-body">
                    <div class="row align-items-center">
                      <div class="col-icon">
                        <div
                          class="icon-big text-center icon-secondary bubble-shadow-small"
                        >
                          <i class="far fa-check-circle"></i>
                        </div>
                      </div>
                      <div class="col col-stats ms-3 ms-sm-0">
                        <div class="numbers">
                          <p class="card-category">Order</p>
                          <h4 class="card-title"><%= orderCount %></h4>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
             <%
                    StfAccDB staffDB = new StfAccDB();
                    ResultSet rs = null;
                    try {
                        rs = staffDB.getAllRecords();
            %>
            <div class="row">
              <div class="col-md-8">
                 <!------------------------------------ StaffTable ----------------------------------------->
                  <div class="card">
                  <div class="card-header">
                    <div class="card-title">Staffs</div>
                  </div>
                  <div class="card-body">
                    <div class="table-responsive" style="max-height: 300px; overflow-y: auto; width: 10%">
                        <table class="table mt-3">
                          <thead>
                            <tr>
                              <th scope="col">Profile</th>
                              <th scope="col">StaffID</th>
                              <th scope="col">StaffName</th>
                            </tr>
                          </thead>
                          <tbody>
                            <% while (rs != null && rs.next()) { %>
                              <tr>
                                <td><img src="images/<%= rs.getString("Profile") %>"
                                         alt="Profile Image"
                                         style="width:50px; height:50px; border-radius:50%; object-fit:cover;"></td>
                                <td><%= rs.getString("UserId") %></td>
                                <td><%= rs.getString("UserName") %></td>
                              </tr>
                            <% } %>
                          </tbody>
                      <%
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (rs != null) {
                                    try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                                }
                                if (staffDB != null) {
                                    try { staffDB.shutDown(); } catch (SQLException e) { e.printStackTrace(); }
                                }
                            }
                        %>
                    </table>
                  </div>
                </div>
              </div>
            <!------------------------------------ End StaffTable ----------------------------------------->
            </div>
            <!------------------------------------ Average ----------------------------------------->       
              <%
                    double averageSales = 0;
                    try {
                        ProductDB dao = new ProductDB(); // create object
                        averageSales = dao.avgTotalAmount(); // call  method
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>  
              <div class="col-md-4">
                  <div class="card card-primary card-round" >
                  <div class="card-header">
                    <div class="card-head-row">
                      <div class="card-title">Average Sales</div>
                    </div>
                    <div class="card-category"> 1 Jan 2024 - 31 Dec 2025 </div>
                  </div>
                  <div class="card-body pb-0">
                    <div class="mb-4 mt-2">
                      <h1>RM <%= String.format("%.2f", averageSales) %></h1>
                    </div>
                  </div>
                </div>
              </div>
              <!------------------------------------ ENd Average ----------------------------------------->      
            </div>     
        </div>
    <!------------------------------------ Footeer ----------------------------------------->
     <%@ include file="adminFooter.jsp" %>
    
  </body>
</html>
