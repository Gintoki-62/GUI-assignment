<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DB.staffDB, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BookLoom Staff Page</title>
    <link rel="icon" type="image/png" href="images/icons/tablogo.png"/>
    <style>
        body {
            font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f6f3f9;
            background-image: linear-gradient(135deg, #f8f5fa 0%, #efe7f5 100%);
            background-attachment: fixed;
            color: #333;
            min-height: 100vh;
        }

        /* Subtle pattern overlay for background */
        body::after {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23663399' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 0;
        }

        .staff-add-product-content {
            position: relative;
            z-index: 1;
            padding: 30px;
            flex-grow: 1;
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            position: relative;
            padding-bottom: 10px;
        }

        h2:after {
            content: '';
            position: absolute;
            width: 60px;
            height: 3px;
            background-color: #9b59b6;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }

        .staff-add-product-form {
            width: 65%;
            margin: 30px auto;
            padding: 35px;
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            position: relative;
        }

        .staff-add-product-form::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #9b59b6, #8e44ad);
            border-radius: 12px 12px 0 0;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #3c4858;
            font-size: 15px;
        }

        .staff-add-product-input[type="text"],
        .staff-add-product-input[type="number"],
        .staff-add-product-textarea,
        .staff-add-product-select {
            width: 100%;
            padding: 12px 14px;
            margin-bottom: 20px;
            border: 1px solid #dce1e9;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 15px;
            transition: all 0.3s ease;
            background-color: #fbfbfc;
        }

        .staff-add-product-input[type="file"] {
            width: 100%;
            padding: 10px 0;
            margin-bottom: 20px;
            font-size: 15px;
        }

        .staff-add-product-input:focus,
        .staff-add-product-textarea:focus,
        .staff-add-product-select:focus {
            outline: none;
            border-color: #9b59b6;
            box-shadow: 0 0 0 3px rgba(155, 89, 182, 0.1);
            background-color: #fff;
        }

        .staff-add-product-textarea {
            resize: vertical;
            min-height: 120px;
        }

        .staff-add-product-select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%239b59b6" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 14px top 50%;
            background-size: 16px;
            padding-right: 40px;
        }

        .staff-add-product-button[type="submit"] {
            background-color: #9b59b6;
            color: white;
            padding: 14px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            display: block;
            margin: 30px auto 10px;
            min-width: 180px;
        }

        .staff-add-product-button[type="submit"]:hover {
            background-color: #8e44ad;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .error-message {
            color: #dc3545;
            background-color: #fff;
            border-left: 4px solid #dc3545;
            padding: 15px;
            margin: 20px auto 0;
            border-radius: 5px;
            font-weight: 500;
            max-width: 600px;
            text-align: left; /* Align errors to the left for better readability */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .error-message ul {
            padding-left: 20px;
            margin-top: 5px;
            margin-bottom: 0;
        }

        .error-message li {
            margin-bottom: 3px;
        }

        .success-message {
            color: #28a745;
            background-color: #fff;
            border-left: 4px solid #28a745;
            padding: 18px;
            margin: 0 auto 25px;
            border-radius: 5px;
            max-width: 600px;
            font-weight: 500;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .success-message button {
            background-color: #9b59b6;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
            margin-top: 12px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .success-message button:hover {
            background-color: #8e44ad;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body class="staff-add-product-body">
    <jsp:include page="staffSidebar.jsp" />

    <div class="staff-add-product-content">
        <h2>Add New Book Product</h2>
        <form action="addBook" method="post" enctype="multipart/form-data" class="staff-add-product-form">
            <%-- Success Message Display --%>
            <% String successMessage = (String) request.getAttribute("successMessage"); %>
            <% String newBookId = (String) request.getAttribute("bookId"); %>
            <% if (successMessage != null && !successMessage.isEmpty() && newBookId != null && !newBookId.isEmpty()) { %>
                <div class="success-message">
                    <%= successMessage %>
                    <button onclick="window.location.href='staffViewProd.jsp#book-<%= newBookId %>'">Click to View</button>
                </div>
            <% } %>

            <%-- Multiple Error Message Display --%>
            <% List<String> errorMessages = (List<String>) request.getAttribute("errorMessages"); %>
            <% if (errorMessages != null && !errorMessages.isEmpty()) { %>
                <div class="error-message">
                    <strong>Please correct the following errors:</strong>
                    <ul>
                        <% for (String error : errorMessages) { %>
                            <li><%= error %></li>
                        <% } %>
                    </ul>
                </div>
            <% } %>

            <label for="bookId">Book ID:</label>
            <input type="text" id="bookId" name="bookId" value="<%= new staffDB().generateNextBookId() %>" class="staff-add-product-input"><br>

            <label for="bookName">Book Name:</label>
            <input type="text" id="bookName" name="bookName" required class="staff-add-product-input"><br>

            <label for="bookPrice">Price:</label>
            <input type="number" id="bookPrice" name="bookPrice" step="0.01" required class="staff-add-product-input"><br>

            <label for="authorName">Author Name:</label>
            <input type="text" id="authorName" name="authorName" required class="staff-add-product-input"><br>

            <label for="publisher">Publisher:</label>
            <input type="text" id="publisher" name="publisher" class="staff-add-product-input"><br>

            <label for="noOfPages">Number of Pages:</label>
            <input type="number" id="noOfPages" name="noOfPages" min="0" class="staff-add-product-input"><br>

            <label for="bookDesc">Description:</label>
            <textarea id="bookDesc" name="bookDesc" rows="4" class="staff-add-product-textarea"></textarea><br>

            <label for="bookQuantity">Quantity:</label>
            <input type="number" id="bookQuantity" name="bookQuantity" min="0" required class="staff-add-product-input"><br>

            <label for="bookType">Book Type:</label>
            <input type="text" id="bookType" name="bookType" class="staff-add-product-input"><br>

            <label for="bookImage">Book Image:</label>
            <input type="file" id="bookImage" name="bookImage" class="staff-add-product-input"><br>

            <label for="bookCategory">Category:</label>
            <select id="bookCategory" name="bookCategory" class="staff-add-product-select">
                <option value="English">English</option>
                <option value="Bahasa_Melayu">Bahasa_Melayu</option>
                <option value="中文图书">中文图书</option>
                <option value="Revision">Revision</option>
                <option value="Stationary">Stationary</option>
            </select><br>

            <button type="submit" class="staff-add-product-button">Add Product</button>
        </form>
    </div>
</body>
</html>