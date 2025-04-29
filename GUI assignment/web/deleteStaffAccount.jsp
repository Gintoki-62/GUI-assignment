<%-- 
    Document   : deleteStaffAccount
    Created on : 21 Apr 2025, 12:20:29 am
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DB.StfAccDB, domain.StaffAccount" %>
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
    .button {
        font-weight: bold;
        color: white;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: #212529;
        cursor: pointer;
        font-size: 16px;
        padding: 6px 20px;
        border: none;
        border-radius: 50px;
        margin: 10px;
        float: right;
    }

    .button:hover {
        color: black;
        background-color: #9BB0C1;
        transition-duration: 0.6s;
    }

    table {
        width: 80%;
        margin: 20px auto;
        border: 2px solid #272c30;
        border-collapse: collapse;
        box-shadow: 0 5px 10px grey;
    }
    
    .confirm{
        color: red;
        font-weight: bold;
    }
    th, td {
        padding: 10px;
    }

    th {
       background-color: #484f54;
       color: whitesmoke;
    }

    td {
        background-color: #C7C8CC;
        color: black;
        text-align: center;
        font-weight: bold;
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
                      <h4 class="card-title">Staff Account Management</h4>
                    </div>
                  </div>
                  <%
                    String userId = request.getParameter("id");
                    StaffAccount staff = null;
                    try {
                        StfAccDB db = new StfAccDB();
                        staff = db.getStaffById(userId);
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                %>  
                  <div class="card-body">
                 <!------------------------------------------------ Table------------------------------------------------------------>        
                 <p class="confirm">Are You Sure You Want To Delete The Following Account?</p>
                <table border="1" cellpadding="10" cellspacing="10">
                    <tr>
                    <th>Profile Image :</th>
                    <td><img src="images/<%= staff.getProfile() %>" alt="Current Profile" style="width:50px; height:50px; display:block; margin-bottom:10px;"></td>
                    </tr>

                    <tr style="border: 2px solid #272c30;">
                    <th>User Id :</th>
                    <td><%= staff.getId() %></td>
                    </tr>

                    <tr style="border: 2px solid #272c30;">
                    <th>User Name :</th>
                    <td><%= staff.getName() %></td>
                    </tr>

                    <tr style="border: 2px solid #272c30;">
                    <th>Email :</th>
                    <td><%= staff.getEmail() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Password :</th>
                    <td><%= staff.getPsw() %></td>
                    </tr>
                    
                    <tr>
                    <th>Gender (F/M) :</th>
                    <td><%= staff.getGender() %></td>
                    </tr>
                </table>

                <form action="deleteStaff" method="POST">
                <input type="hidden" name="id" value="<%= staff.getId() %>" />
                <input type="hidden" name="image" value="<%= staff.getProfile() %>" />
                <input type="hidden" name="name" value="<%= staff.getName() %>" />
                <a href="staffAcc.jsp" "><input type="button" class="button" value="Cancel" name="cancel" /></a>
                <input type="submit" class="button" value="Yes" name="yes" />
                </form>
                <!------------------------------------------------End Table------------------------------------------------------------>   
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!--------------------------------------------------------Footer------------------------------------------------------->
        <%@ include file="adminFooter.jsp" %>
  </body>
</html>

