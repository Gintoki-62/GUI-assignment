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
        .logout-btn {
            text-align: center;
            margin-top: 20px;
        }
        .logout-btn input {
            background-color: #f44336;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
        }
    </style>
</head>
<body>

<%
    // Session protection
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

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

    <div class="logout-btn">
        <form action="LogoutServlet" method="post">
            <input type="submit" value="Logout" />
        </form>
    </div>
</div>

</body>
</html>
