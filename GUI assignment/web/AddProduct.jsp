<%-- 
    Document   : AddProduct
    Created on : 19 Apr 2025, 3:27:47 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder, java.net.URLDecoder"%>
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
         select {
            width: 95%;
            padding: 10px 15px;
            font-size: 15px;
            border: 2px solid #ffffff;
            border-radius: 20px;
            background-color: white;
            color: #333;
            margin-top: 5px;
        }

        select:focus {
            outline: none;
            border-color: #9BB0C1;
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
                            <h4 class="card-title">Create New Product</h4>
                        </div>
                    </div> 
                    
                 <div class="card-body">
                     <%
                        String bookName = (String) request.getAttribute("bookName");
                        if (bookName != null) {
                    %>
                        <div style="padding-left: 20px; padding-top: 20px; color: green; font-weight: bold; background-color: whitesmoke;">
                            Product "<%= bookName %>" has been created successfully.
                            <a href="productAdmin.jsp">[Back to List Product]</a>
                        </div>
                    <%
                        }
                    %>
                     <!------------------------------------------------- Data Table ------------------------------------------------------->
                       <div class="container1">
                        <form action="AddProductServlet" method="POST" class="" enctype="multipart/form-data" <% request.setCharacterEncoding("UTF-8"); %>>
                           <div class="row1">
                              <div class="col1">
                                 <p class="title">New Product</p>
                                 
                                    <div class="inputBox">
                                       <label><span>Book Image :</span></label>
                                       <input style="color: gray" type="file" name="image" value="" required/>
                                    </div>
                                 
                                    <div class="inputBox">
                                        <label><span>Book ID (25BOK00000):</span></label>
                                        <input type="text" name="id" value="25BOK" pattern="^25BOK\d{5}$" title="Must follow format 25BOK followed by 5 digits (e.g., 25BOK12345)" maxlength="10" minlength="10" required />
                                     </div>

                                    <div class="inputBox">
                                       <label><span>Book Name :</span></label>
                                       <input type="text" name="name" value="" required />
                                    </div>
                                 
                                    <div class="inputBox">
                                       <label><span>Author Name :</span></label>
                                       <input type="text" name="author" value="" required />
                                    </div>
                                 
                                    <div class="inputBox">
                                       <label><span>Publisher :</span></label>
                                       <input type="text" name="publisher" value="" required />
                                    </div>
                                    
                                    <div class="inputBox">
                                       <label><span>Book Descriptions :</span></label>
                                       <textarea style="height:90px; 
                                                 width: 95%; 
                                                 padding:6px 8px; 
                                                 box-sizing:border-box; 
                                                 resize:vertical;" type="text" name="desc" value="" required></textarea>
                                    </div>
                                 
                                    <div class="inputBox">
                                       <label><span>No of Pages :</span></label>
                                       <input type="number" name="no_pages" value="" min="0" required />
                                    </div>                                   
                                    
                                    <div class="inputBox">
                                       <label><span>Book Category :</span></label>
                                       <select name="category" id="category" onchange="updateBookTypes()">
                                           <option value="">-- Select Category --</option>
                                           <option value="English">English</option>
                                           <option value="Bahasa_Melayu">Bahasa Melayu</option>
                                           <option value="中文图书">中文图书</option>
                                           <option value="Revision">Revision</option>
                                           <option value="Stationary">Stationary</option>
                                       </select>
                                    </div>
                                 
                                    <div class="inputBox">
                                       <label><span>Book Type :</span></label>
                                       <select name="type" id="type">
                                           <option value=""></option>
                                       </select>
                                    </div>
                                    
                                    <div class="inputBox">
                                       <label><span>Book Price :</span></label>
                                       <input type="text" name="price" value="RM " required />
                                    </div>
                                 
                                    <div class="inputBox">
                                       <label><span>Book Quantity :</span></label>
                                       <input type="number" name="quantity" value="" min="0" required />
                                    </div>

                                    <input type="reset" value="Cancel" name="cancel" class="button" onclick="window.location.href='productAdmin.jsp'"/>
                                    <input type="submit" value="Insert" name="Confirm" class="button"/>
                              </div>
                           </div>
                        </form>
                     </div>   
                <!-------------------------------------------------End of Data Table ---------------------------------->
            
            
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

