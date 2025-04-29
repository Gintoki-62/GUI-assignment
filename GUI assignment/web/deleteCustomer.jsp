<%-- 
    Document   : DeleteCustomer
    Created on : 28 Apr 2025, 4:38:35 pm
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
       width: 20%;
    }

    td {
        background-color: #C7C8CC;
        color: black;
        text-align: center;
        font-weight: bold;
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
                 <!------------------------------------------------ Form------------------------------------------------------------>        
                       <p class="confirm">Are You Sure You Want To Delete The Following Customer?</p>
                <table border="1" cellpadding="10" cellspacing="10">
                    <tr style="border: 2px solid #272c30;">
                    <th>UserID :</th>
                    <td><%= customer.getCusID() %></td>
                    </tr>

                    <tr style="border: 2px solid #272c30;">
                    <th>UserName :</th>
                    <td><%= customer.getCusUserName() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Name :</th>
                    <td><%= customer.getCusName() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Phone Number :</th>
                    <td><%= customer.getCusPhone() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>E-mail :</th>
                    <td><%= customer.getCusEmail() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Gender :</th>
                    <td><%= customer.getCusGender() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Password :</th>
                    <td><%= customer.getCusPsw() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Address :</th>
                    <td><%= customer.getAddress() %></td>
                    </tr>
                   
                </table>

                <form action="deleteCustomerServlet" method="POST">
                <input type="hidden" name="id" value="<%= customer.getCusID() %>" />
                <input type="hidden" name="name" value="<%= customer.getCusName() %>" />
                <a href="ViewCustomer.jsp" "><input type="button" class="button" value="Cancel" name="cancel" /></a>
                <input type="submit" class="button" value="Yes" name="yes" />
                </form>   
                <!------------------------------------------------End Form------------------------------------------------------------>   
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
