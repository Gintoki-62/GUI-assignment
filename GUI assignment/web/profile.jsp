<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f0f2f5;
        }
        .profile-container {
            width: 400px;
            margin: 100px auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #aaa;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
        }
        .profile-item {
            margin-bottom: 15px;
        }
        .label {
            font-weight: bold;
            color: #333;
        }
    </style>
</head>
<body>

<%
    String name = (String) session.getAttribute("name");
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");
    String address = (String) session.getAttribute("address");
    String gender = (String) session.getAttribute("gender");
%>

<div class="profile-container">
    <h2>My Profile</h2>

    <div class="profile-item"><span class="label">Name:</span> <%= name %></div>
    <div class="profile-item"><span class="label">Username:</span> <%= username %></div>
    <div class="profile-item"><span class="label">Email:</span> <%= email %></div>
    <div class="profile-item"><span class="label">Phone:</span> <%= phone %></div>
    <div class="profile-item"><span class="label">Address:</span> <%= address %></div>
    <div class="profile-item"><span class="label">Gender:</span> <%= gender %></div>
</div>

</body>
</html>
