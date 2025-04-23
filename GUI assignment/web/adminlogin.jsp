<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Login</title>
    <style>
        :root {
            --background: #000000;
            --color: #f1f1f1;
            --primary-color: #ff3c00;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            background: var(--background);
            color: var(--color);
        }

        .admin-container {
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .admin-box {
            background: rgba(30, 30, 30, 0.9);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 0 25px rgba(255, 60, 0, 0.3);
            width: 360px;
            position: relative;
        }

        .admin-box h1 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.2em;
            color: var(--primary-color);
        }

        .admin-box .admin-icon {
            display: block;
            margin: 0 auto 15px;
            width: 60px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 15px;
            margin: 10px 0 20px;
            border: none;
            border-radius: 8px;
            background-color: #1c1c1c;
            color: var(--color);
            font-size: 15px;
        }

        input:focus {
            outline: none;
            box-shadow: 0 0 10px var(--primary-color);
        }

        button {
            width: 100%;
            padding: 15px;
            border: none;
            border-radius: 8px;
            background-color: var(--primary-color);
            color: white;
            font-weight: bold;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        button:hover {
            background-color: #e63b00;
        }

        .error-msg {
            color: red;
            text-align: center;
            margin-top: -10px;
            margin-bottom: 15px;
        }

        .back-link {
            text-align: center;
            margin-top: 15px;
        }

        .back-link a {
            color: var(--color);
            font-size: 14px;
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="admin-container">
    <div class="admin-box">
        <img src="https://cdn-icons-png.flaticon.com/512/3063/3063825.png" class="admin-icon" alt="Admin Icon">
        <h1>ADMIN LOGIN</h1>

        <form action="adminLoginServlet" method="post">
            <input type="text" name="username" placeholder="Admin ID" required />
            <input type="password" name="password" placeholder="Admin Password" required />
            <button type="submit">Login</button>
        </form>

        <% String error = request.getParameter("error");
           if ("invalid".equals(error)) {
        %>
        <p class="error-msg">Invalid admin credentials!</p>
        <% } %>

        <div class="back-link">
            <a href="login.jsp">Back to User Login</a>
        </div>
    </div>
</div>
</body>
</html>
