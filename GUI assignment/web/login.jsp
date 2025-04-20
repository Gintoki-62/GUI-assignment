<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login</title>
    <style>
        :root {
            --background: #1a1a2e;
            --color: #ffffff;
            --primary-color: #0f3460;
        }

        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;
            font-family: "Poppins", sans-serif;
            background: var(--background);
            color: var(--color);
            letter-spacing: 1px;
            transition: background 0.2s ease;
        }

        a {
            text-decoration: none;
            color: var(--color);
        }

        h1 {
            font-size: 2.5rem;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .login-container {
            position: relative;
            width: 22.2rem;
        }

        .form-container {
            border: 1px solid hsla(0, 0%, 65%, 0.158);
            box-shadow: 0 0 36px 1px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            backdrop-filter: blur(20px);
            z-index: 99;
            padding: 2rem;
        }

        .login-container form input {
            display: block;
            padding: 14.5px;
            width: 100%;
            margin: 1rem 0;
            color: var(--color);
            background-color: #9191911f;
            border: none;
            border-radius: 5px;
            font-weight: 500;
            letter-spacing: 0.8px;
            font-size: 15px;
            backdrop-filter: blur(15px);
        }

        .login-container form input:focus {
            box-shadow: 0 0 16px 1px rgba(0, 0, 0, 0.2);
            animation: wobble 0.3s ease-in;
        }

        .login-container form button {
            background-color: var(--primary-color);
            color: var(--color);
            padding: 13px;
            border-radius: 5px;
            font-size: 18px;
            font-weight: bold;
            width: 100%;
            cursor: pointer;
            margin-bottom: 1.5rem;
            border: none;
            transition: 0.2s;
        }

        .login-container form button:hover {
            transform: scale(1.02);
            box-shadow: 0 0 10px 1px rgba(0, 0, 0, 0.15);
        }

        .circle {
            width: 8rem;
            height: 8rem;
            background: var(--primary-color);
            border-radius: 50%;
            position: absolute;
            z-index: -1;
        }

        .circle-one {
            top: 0;
            left: 0;
            transform: translate(-45%, -45%);
        }

        .circle-two {
            bottom: 0;
            right: 0;
            transform: translate(45%, 45%);
        }

        .illustration {
            position: absolute;
            top: -14%;
            right: -2px;
            width: 90%;
        }

        .register-forget {
            margin: 1rem 0;
            display: flex;
            justify-content:center;
        }

        .opacity {
            opacity: 0.6;
        }

        .theme-btn-container {
            position: absolute;
            left: 0;
            bottom: 2rem;
        }

        .theme-btn {
            cursor: pointer;
        }

        .error-msg {
            color: red;
            text-align: center;
            margin-top: -10px;
            margin-bottom: 15px;
        }

        @keyframes wobble {
            0%, 100% { transform: scale(1.025); }
            25%, 75% { transform: scale(1); }
        }
    </style>
</head>
<body>
<section class="container">
    <div class="login-container">
        <div class="circle circle-one"></div>

        <div class="form-container">
            <img src="https://raw.githubusercontent.com/hicodersofficial/glassmorphism-login-form/master/assets/illustration.png"
                 alt="illustration" class="illustration"/>
            <h1 class="opacity">LOGIN</h1>

            <form action="loginServlet" method="post">
                <input type="text" name="username" placeholder="USERNAME" required />
                <input type="password" name="password" placeholder="PASSWORD" required />
                <button class="opacity">SUBMIT</button>
            </form>

            <% String error = request.getParameter("error");
               if ("invalid".equals(error)) {
            %>
                <p class="error-msg">Invalid username or password!</p>
            <% } %>

            <div class="register-forget opacity">
                <a href="register.jsp">REGISTER</a>
            </div>
        </div>

        <div class="circle circle-two"></div>
    </div>

    <div class="theme-btn-container"></div>
</section>

<script>
    const themes = [
        { background: "#1A1A2E", color: "#FFFFFF", primaryColor: "#0F3460" },
        { background: "#461220", color: "#FFFFFF", primaryColor: "#E94560" },
        { background: "#192A51", color: "#FFFFFF", primaryColor: "#967AA1" },
        { background: "#F7B267", color: "#000000", primaryColor: "#F4845F" },
        { background: "#F25F5C", color: "#000000", primaryColor: "#642B36" },
        { background: "#231F20", color: "#FFF", primaryColor: "#BB4430" }
    ];

    const setTheme = (theme) => {
        const root = document.documentElement;
        root.style.setProperty("--background", theme.background);
        root.style.setProperty("--color", theme.color);
        root.style.setProperty("--primary-color", theme.primaryColor);
    };

    const displayThemeButtons = () => {
        const btnContainer = document.querySelector(".theme-btn-container");
        themes.forEach(theme => {
            const div = document.createElement("div");
            div.className = "theme-btn";
            div.style.cssText = `background: ${theme.background}; width: 25px; height: 25px; margin: 5px; border-radius: 50%`;
            btnContainer.appendChild(div);
            div.addEventListener("click", () => setTheme(theme));
        });
    };

    displayThemeButtons();
</script>
</body>
</html>
