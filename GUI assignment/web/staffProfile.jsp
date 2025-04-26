<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Staff Profile</title>
        <link rel="icon" type="image/png" href="images/icons/tablogo.png"/>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                background-color: #f8f9fa;
                color: #333;
            }
            
            .main-content {
                padding: 20px;
                transition: margin-left 0.3s;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                min-height: 100vh;
            }
            
            .profile-container {
                width: 100%;
                max-width: 800px;
                margin: 40px auto;
                background: white;
                border-radius: 12px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.08);
                padding: 40px;
                position: relative;
            }
            
            .profile-header {
                display: flex;
                align-items: center;
                margin-bottom: 40px;
                padding-bottom: 25px;
                border-bottom: 1px solid #eee;
            }
            
            .profile-image {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover;
                background-color: #e9efff;
                border: 5px solid #f0f4ff;
                margin-right: 25px;
            }
            
            .profile-image-placeholder {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                background-color: #e9efff;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 36px;
                color: #6c8cd5;
                margin-right: 25px;
                border: 5px solid #f0f4ff;
            }
            
            .welcome-text {
                color: #2d4361;
                font-size: 28px;
                font-weight: 600;
            }
            
            .profile-details {
                display: grid;
                grid-template-columns: 1fr 1fr;
                column-gap: 20px;
                row-gap: 20px;
            }
            
            .profile-item {
                padding: 20px;
                background-color: #f8f9fa;
                border-radius: 8px;
                transition: all 0.2s ease;
                border: 1px solid #eee;
            }
            
            .label {
                display: block;
                color: #6c757d;
                font-size: 14px;
                margin-bottom: 8px;
                font-weight: 500;
            }
            
            .value {
                font-size: 16px;
                font-weight: 500;
                color: #343a40;
            }
            
            @media screen and (max-width: 768px) {
                .main-content {
                    margin-left: 0;
                    padding: 15px;
                }
                
                .profile-container {
                    margin: 20px auto;
                    padding: 25px;
                }
                
                .profile-header {
                    flex-direction: column;
                    text-align: center;
                    margin-bottom: 30px;
                }
                
                .profile-image, .profile-image-placeholder {
                    margin-right: 0;
                    margin-bottom: 15px;
                }
                
                .profile-details {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="staffSidebar.jsp" %>
        <%
            // Session protection
            if (session.getAttribute("userid") == null) {
                response.sendRedirect("adminlogin.jsp");
                return;
            }
            String name = (String) session.getAttribute("name");
            String userid = (String) session.getAttribute("userid");
            String email = (String) session.getAttribute("email");
            String gender = (String) session.getAttribute("gender");
            String profileImage = (String) session.getAttribute("profileImage");
            
            // Get first letter of name for placeholder
            String firstLetter = name != null && !name.isEmpty() ? name.substring(0, 1).toUpperCase() : "U";
        %>
        
        <div class="main-content">
            <div class="profile-container">
                <div class="profile-header">
                    <% if (profileImage != null && !profileImage.equals("null") && !profileImage.isEmpty()) { %>
                        <img src="images/<%= profileImage %>" alt="Profile Picture" class="profile-image">
                    <% } else { %>
                        <div class="profile-image-placeholder"><%= firstLetter %></div>
                    <% } %>
                    <h2 class="welcome-text">Welcome, <%= name %></h2>
                </div>
                
                <div class="profile-details">
                    <div class="profile-item">
                        <span class="label">Full Name</span>
                        <div class="value"><%= name %></div>
                    </div>
                    
                    <div class="profile-item">
                        <span class="label">Staff ID</span>
                        <div class="value"><%= userid %></div>
                    </div>
                    
                    <div class="profile-item">
                        <span class="label">Email Address</span>
                        <div class="value"><%= email %></div>
                    </div>
                    
                    <div class="profile-item">
                        <span class="label">Gender</span>
                        <div class="value"><%= gender != null && !gender.isEmpty() ? gender : "Not Specified" %></div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>