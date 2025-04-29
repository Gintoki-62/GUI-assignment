<%-- 
    Document   : ViewCustomer
    Created on : 27 Apr 2025, 10:05:33 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DB.CustomerDB"%>
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
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.4/css/jquery.dataTables.min.css"/>

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="assets/css/demo.css" />
  </head>
  
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
                      <h4 class="card-title">Customer Accounts</h4>
                      
                      <!-------------------------------------------- Button------------------------------------------------------ -->
                      <button
                        onclick="window.location.href='AddCustomer.jsp';"
                        class="btn btn-primary btn-round ms-auto" style="font-weight:bold"
                      >
                        <i class="fa fa-plus"></i>
                         New Customer account
                      </button>
                    </div>
                  </div>
                    <%
                    CustomerDB cusDB = new CustomerDB();
                    ResultSet rs = null;
                    try {
                        rs = cusDB.getAllRecords();
                  %>
                     <div class="card-body">
                        
                         <%
                        String customerName = (String) request.getAttribute("CustomerName");
                        if (customerName != null) {
                    %>
                       <div class="success-msg" style="padding-left: 20px; padding-bottom: 20px; padding-top: 20px; color: green; font-weight: bold; background-color: whitesmoke;">
                            Staff "<%= customerName %>" has been deleted successfully.
                        </div>
                    <%
                        }
                    %>
                    <!------------------------------------------------- Data Table ------------------------------------------------------->
                    <div class="row">
                    <div class="col-sm-12">    
                    <div class="table-responsive">
                      <table
                        id="add-row"
                        class="display table table-striped table-hover"
                      >
                        <thead>
                          <tr>                          
                            <th>UserID</th>
                            <th>Name</th>
                            <th>UserName</th>
                            <th>Phone Number</th>
                            <th>E-mail</th>
                            <th>Password</th>
                            <th style="width: 10%">Action</th>
                          </tr>
                        </thead>
                        <tfoot>
                          <tr>
                            <th>UserID</th>
                            <th>Name</th>
                            <th>UserName</th>
                            <th>Phone Number</th>
                            <th>E-mail</th>
                            <th>Password</th>
                            <th>Action</th>
                          </tr>
                        </tfoot>
                        <tbody>
                            <% while (rs != null && rs.next()) { %>
                            <tr>
                                <td><%= rs.getString("ID") %></td>
                                <td><%= rs.getString("NAME") %></td>
                                <td><%= rs.getString("USERNAME") %></td>
                                <td><%= rs.getString("PHONE") %></td>
                                <td><%= rs.getString("EMAIL") %></td>
                                <td><%= rs.getString("PASSWORD") %></td>
                                <td>
                                    <div class="form-button-action">
                                        <button
                                            type="button"
                                            data-bs-toggle="tooltip"
                                            title=""
                                            class="btn btn-link btn-primary btn-lg"
                                            data-original-title="Edit Task"
                                            onclick="window.location.href='editCustomer.jsp?id=<%= rs.getString("ID") %>';"
                                        >
                                            <i class="fa fa-edit"></i>
                                        </button>
                                        <button
                                            type="button"
                                            data-bs-toggle="tooltip"
                                            title=""
                                            class="btn btn-link btn-danger"
                                            data-original-title="Remove"
                                            onclick="window.location.href='deleteCustomer.jsp?id=<%= rs.getString("ID") %>'; "
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
                                if (cusDB != null) {
                                    try { cusDB.shutDown(); } catch (SQLException e) { e.printStackTrace(); }
                                }
                            }
                        %>

                      </table>
                    </div>
                   </div>
                 </div>
                <!------------------------------------------------End Table------------------------------------------------------------>   
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- Footer -->
         <%@ include file="adminFooter.jsp" %>
         <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
         <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>

    <script>
        $(document).ready(function () {
          $('#add-row').DataTable({
            "pageLength": 5,
            "lengthMenu": [5, 10, 15, 20],
            "language": {
              "search": "Search:"
            }
          });
        });
    </script>
  </body>
</html>
