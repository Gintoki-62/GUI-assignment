<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BookLoom Staff Page</title>
    <link rel="icon" type="image/png" href="images/icons/tablogo.png"/>
    <link rel="stylesheet" href="css/staffSidebar.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f6f8;
            display: flex;
        }

        #sidebar {
            background-color: #f8f9fa;
            color: #212529;
            width: 250px;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            z-index: 100;
        }

        #content {
            flex-grow: 1;
            padding: 20px;
            margin: 20px auto;
            max-width: 1200px;
        }

        .welcome-message {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            text-align: center;
            font-size: 1.5em;
            color: #333;
        }
    </style>
</head>
<body>
    <jsp:include page="staffSidebar.jsp" />

    <div id="content">
        <div class="welcome-message">
            Welcome, Staff Member!
        </div>
            </div>
        </div>
    </div>
</body>
</html>