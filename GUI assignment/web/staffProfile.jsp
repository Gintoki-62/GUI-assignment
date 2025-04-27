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
                margin-bottom: 30px;
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

            .edit-profile-section {
                background-color: #f8f9fa;
                padding: 20px;
                border-radius: 8px;
                border: 1px solid #eee;
                margin-top: 20px;
            }

            .edit-profile-section h3 {
                color: #2d4361;
                margin-top: 0;
                margin-bottom: 15px;
                font-size: 20px;
                font-weight: 600;
                text-align: center;
            }

            .form-group {
                margin-bottom: 15px;
            }

            .form-group label {
                display: block;
                color: #6c757d;
                font-size: 14px;
                margin-bottom: 5px;
                font-weight: 500;
            }

            .form-group input[type="text"],
            .form-group input[type="email"],
            .form-group input[type="password"],
            .form-group select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 16px;
            }

            .form-group button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 16px;
                transition: background-color 0.2s ease;
            }

            .form-group button:hover {
                background-color: #0056b3;
            }

            .toggle-edit-btn {
                background-color: #28a745;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
                font-size: 14px;
                margin-bottom: 20px;
                transition: background-color 0.2s ease;
                display: block;
                width: fit-content;
                margin: 20px auto;
            }

            .toggle-edit-btn:hover {
                background-color: #1e7e34;
            }

            .hidden {
                display: none;
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
        <script>
            function toggleEditProfile() {
                const viewProfile = document.getElementById('view-profile');
                const editProfile = document.getElementById('edit-profile');
                const toggleButton = document.getElementById('toggle-edit-btn');

                viewProfile.classList.toggle('hidden');
                editProfile.classList.toggle('hidden');

                if (viewProfile.classList.contains('hidden')) {
                    toggleButton.textContent = 'View Profile';
                } else {
                    toggleButton.textContent = 'Edit Profile';
                }
            }
        </script>
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

                <button id="toggle-edit-btn" class="toggle-edit-btn" onclick="toggleEditProfile()">Edit Profile</button>

                <div id="view-profile">
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

                <div id="edit-profile" class="hidden edit-profile-section">
                    <h3>Edit Your Information</h3>
                    <form action="staffEditProfileServlet" method="post">
                        <div class="form-group">
                            <label for="staffName">Name:</label>
                            <input type="text" id="staffName" name="staffName" value="<%= name %>" required>
                        </div>
                        <div class="form-group">
                            <label for="staffEmail">Email:</label>
                            <input type="email" id="staffEmail" name="staffEmail" value="<%= email %>" required>
                        </div>
                        <div class="form-group">
                            <label for="staffGender">Gender:</label>
                            <select id="staffGender" name="staffGender">
                                <option value="">Not Specified</option>
                                <option value="M" <%= "M".equals(gender) ? "selected" : "" %>>Male</option>
                                <option value="F" <%= "F".equals(gender) ? "selected" : "" %>>Female</option>
                                <option value="O" <%= "O".equals(gender) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="staffPassword">New Password:</label>
                            <input type="password" id="staffPassword" name="staffPassword" placeholder="Enter new password">
                        </div>
                        <div class="form-group">
                            <button type="submit">Update Information</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>