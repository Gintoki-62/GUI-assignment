<%-- 
    Document   : deleteProduct
    Created on : 23 Apr 2025, 12:55:42 am
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DB.ProductDB, domain.Product" %>
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
                            <h4 class="card-title">Product Management</h4>
                        </div>
                    </div> 
                 <%
                    String bookId = request.getParameter("id");
                    Product prd = null;
                    try {
                        ProductDB db = new ProductDB();
                        prd = db.getProductById(bookId);
                    } catch (Exception e) {
                        out.println("Error: " + e.getMessage());
                    }
                %>    
                 <div class="card-body">
                     <!------------------------------------------------ Table------------------------------------------------------------>        
                 <p class="confirm">Are You Sure You Want To Delete The Following Product?</p>
                <table border="1" cellpadding="10" cellspacing="10">
                    <tr>
                    <th>Book Image :</th>
                    <td><img src="<%= prd.getImage() %>" alt="Current Profile" style="width:50px; height:50px; display:block; margin-bottom:10px;"></td>
                    </tr>

                    <tr style="border: 2px solid #272c30;">
                    <th>Book Id :</th>
                    <td><%= prd.getBookId() %></td>
                    </tr>

                    <tr style="border: 2px solid #272c30;">
                    <th>Book Name :</th>
                    <td><%= prd.getBookName() %></td>
                    </tr>

                    <tr style="border: 2px solid #272c30;">
                    <th>Author Name :</th>
                    <td><%= prd.getAuthor() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Publisher :</th>
                    <td><%= prd.getPublisher() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Book Descriptions :</th>
                    <td><%= prd.getDescription() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>No of Pages :</th>
                    <td><%= prd.getNoPages() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Book Category :</th>
                    <td><%= prd.getCategory() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Book Type :</th>
                    <td><%= prd.getType() %></td>
                    </tr>
                    
                    <tr style="border: 2px solid #272c30;">
                    <th>Book Price :</th>
                    <td><%= prd.getPrice() %></td>
                    </tr>
                    
                    <tr>
                    <th>Book Quantity :</th>
                    <td><%= prd.getQuantity() %></td>
                    </tr>
                </table>

                <form action="deleteProductServlet" method="POST">
                <input type="hidden" name="id" value="<%= prd.getBookId() %>" />
                <input type="hidden" name="image" value="<%= prd.getImage() %>" />
                <input type="hidden" name="name" value="<%= prd.getBookName()%>" />
                <a href="productAdmin.jsp" "><input type="button" class="button" value="Cancel" name="cancel" /></a>
                <input type="submit" class="button" value="Yes" name="yes" />
                </form>
                <!------------------------------------------------End Table------------------------------------------------------------>   
            </div>
            </div>
            </div>
            </div>
          </div>
        </div>
        
        <!--------------------------------------------------------Footer---------------------------------------------------------->
        <%@ include file="adminFooter.jsp" %>
        
    <script>
    function updateBookTypes() {
        const category = document.getElementById('category').value;
        const typeDropdown = document.getElementById('type');

        // Clear existing options
        typeDropdown.innerHTML = '<option value="">-- Select Type --</option>';

        // Add options based on selected category
        if (category === 'English') {
            addOptions(typeDropdown, ['Comics', 'Cook', 'Hobby', 'Travel', 'Business']);
        } 
        else if (category === 'Bahasa_Melayu') {
            addOptions(typeDropdown, ['Komik', 'Kesihatan', 'Remaja', 'Seni']);
        }
        else if (category === '中文图书') {
            addOptions(typeDropdown, ['轻小说', '图文漫画', '休闲生活']);
        }
        else if (category === 'Revision') {
            addOptions(typeDropdown, ['SPM', 'STPM/Pre-U', 'Secondary_SMK', 'Primary_SJK', 'Primary_SK']);
        }
        else if (category === 'Stationary') {
            addOptions(typeDropdown, ['Bag&Accessories', 'Paper']);
        }
    }

    function addOptions(selectElement, options) {
        options.forEach(option => {
            const opt = document.createElement('option');
            opt.value = option;
            opt.textContent = option;
            selectElement.appendChild(opt);
        });
    }
    </script>
  </body>
</html>


