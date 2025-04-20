<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register</title>

    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            background-color: #080710;
            font-family: 'Poppins', sans-serif;
        }
        .background {
            width: 430px;
            height: 700px;
            position: absolute;
            transform: translate(-50%, -50%);
            top: 50%;
            left: 50%;
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
        form {
            height: 700px;
            width: 400px;
            background-color: rgba(255, 255, 255, 0.13);
            position: absolute;
            transform: translate(-50%, -50%);
            top: 50%;
            left: 50%;
            border-radius: 10px;
            backdrop-filter: blur(10px);
            border: 2px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 0 40px rgba(8, 7, 16, 0.6);
            padding: 50px 35px;
            overflow-y: auto;
        }
        form * {
            color: #ffffff;
            letter-spacing: 0.5px;
            outline: none;
            border: none;
        }
        form h3 {
            font-size: 32px;
            font-weight: 500;
            line-height: 42px;
            text-align: center;
            margin-bottom: 10px;
        }
        label {
            display: block;
            margin-top: 20px;
            font-size: 16px;
            font-weight: 500;
        }
        input, textarea {
            display: block;
            width: 100%;
            height: 45px;
            background-color: rgba(255, 255, 255, 0.07);
            border-radius: 3px;
            padding: 0 10px;
            margin-top: 8px;
            font-size: 14px;
            font-weight: 300;
            color: #ffffff;
        }
        textarea {
            height: 60px;
            resize: none;
        }
        input[type="radio"] {
            width: auto;
            margin-right: 5px;
            height: auto;
        }
        ::placeholder {
            color: #e5e5e5;
        }
        button {
            margin-top: 30px;
            width: 100%;
            background-color: #ffffff;
            color: #080710;
            padding: 15px 0;
            font-size: 18px;
            font-weight: 600;
            border-radius: 5px;
            cursor: pointer;
        }
        .login-link {
            margin-top: 20px;
            text-align: center;
            font-size: 14px;
        }
        .login-link a {
            color: #23a2f6;
            text-decoration: none;
        }
        .error {
            color: #ff6b6b;
            font-size: 14px;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<div class="background">
    <div class="shape"></div>
    <div class="shape"></div>
</div>

<form action="registerServlet" method="post" onsubmit="return validateForm()">
    <h3>Register Here</h3>

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

    <label for="name">Full Name</label>
    <input type="text" id="name" name="name" placeholder="Enter your full name" required>

    <label for="username">Username</label>
    <input type="text" id="username" name="username" placeholder="Enter username" required>

    <label for="password">Password</label>
    <input type="password" id="password" name="password" placeholder="Enter password" required>

    <label for="confirmPassword">Confirm Password</label>
    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm password" required>

    <label for="email">Email</label>
    <input type="email" id="email" name="email" placeholder="Enter email" required>

    <label for="phone">Phone Number</label>
    <input type="tel" id="phone" name="phone" placeholder="Enter phone number" required>

    <label for="address">Address</label>
    <textarea id="address" name="address" placeholder="Enter address" required></textarea>

    <label>Gender</label>
    <input type="radio" name="gender" value="Male" required> Male
    <input type="radio" name="gender" value="Female" required> Female

    <button type="submit">Register</button>

    <div class="login-link">
        <p>Already have an account? <a href="login.jsp">Login here</a></p>
    </div>
</form>

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

</body>
</html>
