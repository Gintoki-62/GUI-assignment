<%-- 
    Document   : register
    Created on : 2025年4月18日, 15:29:44
    Author     : yenxi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f2f2;
        }
        .container {
            width: 350px;
            margin: 100px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 25px;
        }
        input[type="text"], input[type="password"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            width: 100%;
            background: #2196F3;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .login-link {
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Create Account</h2>
    <form action="registerServlet" method="post">
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" name="password" placeholder="Password" required />
        <input type="email" name="email" placeholder="Email" required />
        <input type="submit" value="Register" />
    </form>

    <div class="login-link">
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</div>
</body>
</html>
