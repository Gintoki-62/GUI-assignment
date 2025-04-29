<%-- 
    Document   : editStaffAccount
    Created on : 19 Apr 2025, 11:03:48 pm
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
                      <%
                        String staffName = (String) request.getAttribute("staffName");
                        boolean isSuccess = staffName != null;
                        if (staffName != null) {
                    %>
                        <div class="success-msg" style="padding-left: 20px; padding-top: 20px; color: green; font-weight: bold; background-color: whitesmoke;">
                            Staff "<%= staffName %>" has been updated successfully.
                            <a href="staffAcc.jsp">[Back to List Staff]</a>
                        </div>
                    <%
                            session.removeAttribute("staffName");
                            
                        }
                    %>
                 <!------------------------------------------------ Form------------------------------------------------------------>        
                      <div class="container1">
                        <form id="editStaffForm" action="editStaff" method="POST" class="">
                           <div class="row1">
                              <div class="col1">
                                 <p class="title">Edit Staff Account Information</p>
                                    <input type="hidden" name="profile" value="<%= staff.getProfile() %>" />

                                    <img src="images/<%= staff.getProfile() %>" alt="Current Profile" style="width:50px; height:50px; display:block; margin-bottom:10px;">
                  
                                    <div class="inputBox">
                                       <label><span>User ID :</span></label>
                                       <input type="hidden" name="id" value="<%= staff.getId() %>" />
                                       <input style="color: white" type="text" name="id" value="<%= staff.getId() %>" disabled />
                                    </div>

                                    <div class="inputBox">
                                       <label><span>User Name :</span></label>
                                       <input type="text" name="name" value="<%= isSuccess ? "" : staff.getName() %>" required />
                                    </div>

                                    <div class="inputBox">
                                       <label><span>Email :</span></label>
                                       <input type="text" name="email" pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" 
                                            title="Enter a valid email address (e.g., user@example.com)" value="<%= isSuccess ? "" : staff.getEmail() %>" required />
                                    </div>
                                 
                                    <div class="inputBox">
                                       <label><span>Password :</span></label>
                                       <input type="text" name="psw" minlength="5" value="<%= isSuccess ? "" : staff.getPsw() %>" title="Password must be at least 5 characters" required />
                                    </div>
                                 
                                    <div class="inputBox">
                                       <label><span>Gender(F/M) :</span></label>
                                       <input type="text" name="gender" pattern="^[FfMm]$" title="Enter 'F' for Female or 'M' for Male" value="<%= isSuccess ? "" : staff.getGender() %>" maxlength="1" minlength="1" required />
                                    </div>

                                    <input type="button" value="Cancel" onclick="window.location.href='staffAcc.jsp'" class="button"/>
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
        <%@ include file="adminFooter.jsp" %>
    
    <script>
    // This runs only if the page loaded with staffName (successfully added)
    window.onload = function() {
        <% if (request.getAttribute("staffName") != null) { %>
            // Clear form fields except profile
            let form = document.getElementById("editStaffForm");
            form.reset();

            // Re-set the profile value manually if needed
            let profile = "<%= request.getParameter("profile") %>";
            if (profile) {
                document.getElementById("profile").value = profile;
            }
        <% } %>
    }
</script>
  </body>
</html>
