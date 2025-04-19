<%@ page contentType="text/html" pageEncoding="UTF-8" %>
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
        input[type="text"], input[type="password"], input[type="email"], input[type="tel"] {
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
        .error {
            color: red;
            font-size: 12px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Create Account</h2>

    <!-- Error handling for different conditions -->
    <% 
        String error = request.getParameter("error");
        if ("PasswordMismatch".equals(error)) {
    %>
        <p class="error">Passwords do not match. Please try again.</p>
    <% } else if ("InvalidEmail".equals(error)) { %>
        <p class="error">Invalid email format. Please enter a valid email.</p>
    <% } else if ("failed".equals(error)) { %>
        <p class="error">Registration failed. Please try again later.</p>
    <% } %>

    <form action="registerServlet" method="post" onsubmit="return validateForm()">
        <input type="text" name="name" placeholder="Name" required />
        <input type="text" name="username" placeholder="Username" required />
        <input type="password" id="password" name="password" placeholder="Password" required />
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required />
        <input type="email" name="email" placeholder="Email" required />
        <input type="tel" name="phone" placeholder="Phone Number" required /><br><br>

        Address: <textarea name="address" placeholder="Address" rows="4" required></textarea><br><br>

        Gender:
        <input type="radio" name="gender" value="Male" required /> Male
        <input type="radio" name="gender" value="Female" required /> Female<br><br>

        <input type="submit" value="Register" />
    </form>

    <div class="login-link">
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>

    <script>
    function validateForm() {
        var pw = document.getElementById("password").value;
        var cpw = document.getElementById("confirmPassword").value;
        if (pw !== cpw) {
            alert("Passwords do not match!");
            return false;
        }
        return true;
    }
    </script>
</div>
</body>
</html>
