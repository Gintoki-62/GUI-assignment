<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background-color: #080710;
            color: #fff;
        }

        .background {
            width: 430px;
            height: 520px;
            position: absolute;
            transform: translate(-50%,-50%);
            left: 50%;
            top: 50%;
        }

        .background .shape {
            height: 200px;
            width: 200px;
            position: absolute;
            border-radius: 50%;
        }

        .shape:first-child {
            background: linear-gradient(#1845ad, #23a2f6);
            left: -80px;
            top: -80px;
        }

        .shape:last-child {
            background: linear-gradient(to right, #ff512f, #f09819);
            right: -30px;
            bottom: -80px;
        }

        .profile-container {
            height: 520px;
            width: 400px;
            background-color: rgba(255,255,255,0.13);
            position: absolute;
            transform: translate(-50%,-50%);
            top: 50%;
            left: 50%;
            border-radius: 10px;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255,255,255,0.1);
            box-shadow: 0 0 40px rgba(8,7,16,0.6);
            padding: 50px 35px;
        }

        h2 {
            font-size: 32px;
            font-weight: 500;
            text-align: center;
            margin-bottom: 20px;
        }

        .profile-item {
            margin: 15px 0;
            font-size: 16px;
        }

        .label {
            font-weight: 600;
            color: #fff;
        }

        .logout-btn {
            margin-top: 30px;
            text-align: center;
        }

        .logout-btn input {
            background-color: #ffffff;
            color: #080710;
            padding: 12px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
        }

        .logout-btn input:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>

<%
    
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

<div class="background">
    <div class="shape"></div>
    <div class="shape"></div>
</div>

<div class="profile-container">
    <h2>Welcome, <%= name %></h2>

    <div class="profile-item"><span class="label">Username:</span> <%= username %></div>
    <div class="profile-item"><span class="label">Email:</span> <%= email %></div>
    <div class="profile-item"><span class="label">Phone:</span> <%= phone %></div>
    <div class="profile-item"><span class="label">Address:</span> <%= address %></div>
    <div class="profile-item"><span class="label">Gender:</span> <%= gender %></div>

    <div class="logout-btn">
        <form action="logoutServlet" method="post">
            <input type="submit" value="Logout" />
        </form>
    </div>
    
    <div class="logout-btn">
        <a href="about.jsp" style="color: white">Back</a>
    </div>
    
</div>

</body>
</html>
