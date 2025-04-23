<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="DB.staffDB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>BOOKLOOM(STAFF) - ADD NEW PRODUCT</title>
    <style>
        .staff-add-product-body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: row;
            min-height: 100vh;
        }

        .staff-add-product-content {
            flex-grow: 1;
            padding: 20px;
        }

        .staff-add-product-h2 {
            color: #333;
            text-align: center;
        }

        .staff-add-product-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 70%;
            margin: 20px auto;
        }

        .staff-add-product-label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        .staff-add-product-input[type="text"],
        .staff-add-product-input[type="number"],
        .staff-add-product-input[type="file"],
        .staff-add-product-textarea,
        .staff-add-product-select {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .staff-add-product-textarea {
            resize: vertical;
        }

        .staff-add-product-button[type="submit"] {
            background-color: #5cb85c;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .staff-add-product-button[type="submit"]:hover {
            background-color: #4cae4c;
        }

        .error-message {
            color: red;
            margin-top: 10px;
            text-align: center;
        }

        .success-message {
            color: green;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body class="staff-add-product-body">
    <jsp:include page="staffSidebar.jsp" />
    
    <div class="staff-add-product-content">
        <h2>Add New Book Product</h2>
        <form action="addBook" method="post" enctype="multipart/form-data" class="staff-add-product-form">
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
            <div class="error-message" id="errorMessage">${errorMessage}</div>
            <div class="success-message" id="successMessage">${successMessage}</div>
        </form>
    </div>
</body>
</html>