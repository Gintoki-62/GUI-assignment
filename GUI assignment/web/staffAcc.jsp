<%-- 
    Document   : staffAcc
    Created on : 17 Apr 2025, 11:22:29 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DB.StfAccDB"%>
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
      href="assets/img/kaiadmin/favicon.ico"
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
      td{
          padding:13px 21px;
      }
  </style>
  <body>
      <%@ include file="adminHeader.jsp" %>
      
        <div class="container">
          <div class="page-inner">
              
            <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
            <!--------------------------------------------------------Page Header------------------------------------------------------->
              <div class="page-header">
                <h3 class="fw-bold mb-3">Staff Accounts</h3>
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
                    <a href="#">Staff Accounts</a>
                  </li>
                  <li class="separator">
                    <i class="icon-arrow-right"></i>
                  </li>
                  <li class="nav-item">
                    <a href="#">Staff Account Management</a>
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
                      <h4 class="card-title">Staff Accounts</h4>
                      
                      <!-------------------------------------------- Button------------------------------------------------------ -->
                      <button
                        onclick="window.location.href='AddStaffAccount.jsp';"
                        class="btn btn-primary btn-round ms-auto" style="font-weight:bold"
                      >
                        <i class="fa fa-plus"></i>
                         Create a new account
                      </button>
                    </div>
                  </div>
                  
                 <%
                    StfAccDB staffDB = new StfAccDB();
                    ResultSet rs = null;
                    try {
                        rs = staffDB.getAllRecords();
                  %>

                  <div class="card-body">
                    <%
                        String staffName = (String) request.getAttribute("staffName");
                        if (staffName != null) {
                    %>
                        <div class="success-msg" style="padding-left: 20px; padding-bottom: 20px; padding-top: 20px; color: green; font-weight: bold; background-color: whitesmoke;">
                            Staff "<%= staffName %>" has been deleted successfully.
                        </div>
                    <%
                        }
                    %>
                    
                    <!------------------------------------------------- Data Table ------------------------------------------------------->
                    <div class="table-responsive">
                      <table
                        id="add-row"
                        class="display table table-striped table-hover"
                      >
                        <thead>
                          <tr>
                            <th>Profile</th>
                            <th>UserID</th>
                            <th>UserName</th>
                            <th>E-mail</th>
                            <th>Password</th>
                            <th>Gender</th>
                            <th style="width: 10%">Action</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>Profile</th>
                            <th>UserID</th>
                            <th>UserName</th>
                            <th>E-mail</th>
                            <th>Password</th>
                            <th>Gender</th>
                            <th>Action</th>
                          </tr>
                        </tfoot>
                        <tbody>
                             <% while (rs != null && rs.next()) { %>
                            <tr>
                                <td><img src="images/<%= rs.getString("Profile") %>"
                                         alt="Profile Image" 
                                        style="width:50px; height:50px; border-radius:50%; object-fit:cover;"></td>
                                <td><%= rs.getString("UserId") %></td>
                                <td><%= rs.getString("UserName") %></td>
                                <td><%= rs.getString("Email") %></td>
                                <td><%= rs.getString("Password") %></td>
                                <td><%= rs.getString("Gender") %></td>
                                <td>
                                    <div class="form-button-action">
                                        <button
                                            type="button"
                                            data-bs-toggle="tooltip"
                                            title=""
                                            class="btn btn-link btn-primary btn-lg"
                                            data-original-title="Edit Task"
                                            onclick="window.location.href='editStaffAccount.jsp?id=<%= rs.getString("UserId") %>';"
                                        >
                                            <i class="fa fa-edit"></i>
                                        </button>
                                        <button
                                            type="button"
                                            data-bs-toggle="tooltip"
                                            title=""
                                            class="btn btn-link btn-danger"
                                            data-original-title="Remove"
                                            onclick="window.location.href='deleteStaffAccount.jsp?id=<%= rs.getString("UserId") %>'; "
                                        >
                                            <i class="fa fa-times"></i>
                                        </button>
                                    </div>
                                </td>
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
                <!------------------------------------------------End Table------------------------------------------------------------>   
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
  </body>
</html>

