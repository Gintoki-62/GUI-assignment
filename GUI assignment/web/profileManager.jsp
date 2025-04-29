<%-- 
    Document   : profileManager
    Created on : 24 Apr 2025, 3:34:22 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DB.managerDB, domain.Manager_1"%>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page session="true" %>

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
        .form-control:focus {
            box-shadow: none;
            border-color: #BA68C8
        }

        .profile-button {
            background: rgb(99, 39, 120);
            box-shadow: none;
            border: none
        }

        .profile-button:hover {
            background: #682773
        }

        .profile-button:focus {
            background: #682773;
            box-shadow: none
        }

        .profile-button:active {
            background: #682773;
            box-shadow: none
        }

        .back:hover {
            color: #682773;
            cursor: pointer
        }

        .labels {
            font-size: 11px
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
                    <h3 class="fw-bold mb-3">Profile</h3>
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
                        <a href="#">View Profile</a>
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
                          <h4 class="card-title">Profile Information</h4>
                        </div>
                    </div> 
                <%
                    // Get session attributes
                    String managerId = (String) session.getAttribute("adminUser");
                    if (managerId == null) {
                        response.sendRedirect("adminlogin.jsp?error=session");
                        return;
                    }
                    
                    managerDB mDB = new managerDB();
                    Manager_1 manager = null;

                    try {
                        manager = mDB.getManagerById(managerId);
                        if (manager == null) {
                            response.sendRedirect("adminlogin.jsp?error=notfound");
                            return;
                        }
                    } catch (SQLException e) {
                        out.println("Database error: " + e.getMessage());
                        return;
                    }
                %>       
                 <div class="card-body">
                    <%
                        String ManagerName = (String) request.getAttribute("ManagerName");
                        boolean IsSuccess = ManagerName != null;
                        if (ManagerName != null) {
                    %>
                        <div style="padding-left: 20px; padding-top: 20px; color: green; font-weight: bold; background-color: whitesmoke;">
                            Manager "<%= manager.getName() %>" has been updated successfully.
                            <a href="Index2.jsp">[Back to HomePage]</a>
                        </div>
                    <%
                        }
                    %> 
                    
                    <%
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                    %>
                        <div style="padding-left: 20px; padding-top: 20px; color: red; font-weight: bold; background-color: whitesmoke;">
                            <%= error %>
                        </div>
                    <%
                        }
                    %>
                    <!------------------------------------------------- Profile ------------------------------------------------------->
                 <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                        <input type="hidden" name="image" value="<%= manager.getProfile() %>" />
                        <img class="rounded-circle mt-5" width="150px" src="images/<%= manager.getProfile() %>">
                        <span class="font-weight-bold"><%= manager.getName() %></span>
                        <span class="text-black-50"><%= manager.getEmail() %></span>
                        <span> </span>
                    </div>
                </div>
                    
                <div class="col-md-5 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-right">Profile Settings</h4>
                        </div>
                        
                        <form action="editProfileServlet" method="POST" id="editProfileManager">
                            <div class="row mt-2">
                                <div class="col-md-6">
                                    <label class="labels">Manager Name</label>
                                    <input type="text" class="form-control" name="ManagerName" placeholder="Enter Manager name" value="<%= IsSuccess ? "" : manager.getName() %>">
                                </div>
                                <div class="col-md-6">
                                    <label class="labels">Manager Id</label>
                                    <input type="hidden" name="ManagerID" value="<%= manager.getId() %>" />
                                    <input type="text" class="form-control" name="ManagerID" value="<%= manager.getId() %>" placeholder="Enter Manager ID" disabled>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-md-12">
                                    <label class="labels">Password</label>
                                    <input type="text" class="form-control" name="password" placeholder="Enter Password" value="<%= IsSuccess ? "" : manager.getPassword() %>">
                                </div>
                                <div class="col-md-12">
                                    <label class="labels">E-mail</label>
                                    <input type="text" class="form-control" name="email" placeholder="Enter E-mail" value="<%= IsSuccess ? "" : manager.getEmail() %>">
                                </div>
                            </div>

                            <div class="mt-5 text-center">
                                <input type="submit" name="update" class="btn btn-primary profile-button" value="Update Profile"/>
                            </div>
                        </form>
                    </div>
                </div>   
                <!-------------------------------------------------View Profile ---------------------------------->
            </div>
            </div>
            </div>
            </div>
          </div>
        </div>
        
        <!--------------------------------------------------------Footer---------------------------------------------------------->
        <%@ include file="adminFooter.jsp" %>
  </body>
</html>
