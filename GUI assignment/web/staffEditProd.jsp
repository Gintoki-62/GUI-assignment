<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DB.staffDB, domain.Book, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BookLoom Staff Page</title>
    <link rel="icon" type="image/png" href="images/icons/tablogo.png"/>
    <style>
        body {
            font-family: 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f4f8;
            background-image: linear-gradient(135deg, #f5f7fa 0%, #e4eaf5 100%);
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
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%233a5075' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 0;
        }

        .content {
            position: relative;
            z-index: 1;
            padding: 30px;
        }

        .content h2 {
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
            font-size: 28px;
            font-weight: 600;
            position: relative;
            padding-bottom: 10px;
        }

        .content h2:after {
            content: '';
            position: absolute;
            width: 60px;
            height: 3px;
            background-color: #3498db;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }

        .content .error-message {
            color: #dc3545;
            background-color: #fff;
            border-left: 4px solid #dc3545;
            padding: 15px;
            margin-bottom: 25px;
            border-radius: 5px;
            font-weight: 500;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .content .error-message ul {
            margin: 5px 0 0 0;
            padding-left: 20px;
        }

        .content .error-message li {
            margin-bottom: 5px;
        }

        .content .success-message {
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

        .content .success-message button {
            background-color: #3498db;
            color: white;
            padding: 10px 18px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 15px;
            margin-top: 12px;
            margin-left: 5px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .content .success-message button:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .content form {
            width: 65%;
            margin: 30px auto;
            padding: 35px;
            border-radius: 12px;
            background-color: #fff;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            position: relative;
        }

        .content form::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #3498db, #2980b9);
            border-radius: 12px 12px 0 0;
        }

        .content label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #3c4858;
            font-size: 15px;
        }

        .content input[type="text"],
        .content input[type="number"],
        .content textarea,
        .content select {
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

        .content input[type="file"] {
            width: 100%;
            padding: 10px 0;
            margin-bottom: 20px;
            font-size: 15px;
        }

        .content input:focus,
        .content textarea:focus,
        .content select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            background-color: #fff;
        }

        .content textarea {
            resize: vertical;
            min-height: 120px;
        }

        .content select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%233498db" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 14px top 50%;
            background-size: 16px;
            padding-right: 40px;
        }

        .content button[type="submit"] {
            background-color: #3498db;
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

        .content button[type="submit"]:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .content .error {
            color: #dc3545;
            background-color: #fff;
            border-left: 4px solid #dc3545;
            padding: 15px;
            margin: 20px auto;
            border-radius: 5px;
            font-weight: 500;
            max-width: 600px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .content img {
            display: block;
            margin-bottom: 15px;
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            max-width: 150px;
            height: auto;
        }

        .form-group {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <%@ include file="staffSidebar.jsp" %>

    <div style="padding: 20px;" class="content">
        <h2>Edit Product</h2>

        <% List<String> errorMessages = (List<String>) request.getAttribute("errorMessages"); %>
        <% if (errorMessages != null && !errorMessages.isEmpty()) { %>
            <div class="error-message">
                <ul>
                    <% for (String error : errorMessages) { %>
                        <li><%= error %></li>
                    <% } %>
                </ul>
            </div>
        <% } %>

        <% String successMessage = (String) request.getAttribute("successMessage"); %>
        <% String updatedBookId = (String) request.getAttribute("bookId"); %>
        <% if (successMessage != null && !successMessage.isEmpty() && updatedBookId != null && !updatedBookId.isEmpty()) { %>
            <div class="success-message">
                <%= successMessage %>
                
                <button onclick="window.location.href='staffViewProd.jsp#book-<%= updatedBookId %>'">Click to View</button>
            </div>
        <% } %>

        <%
            String bookId = request.getParameter("BOOK_ID");
            if (bookId == null || bookId.trim().isEmpty()) {
        %>
            <p class="error">ERROR: Book ID not provided.</p>
        <%
            } else {
                staffDB staffDb = new staffDB();
                Book book = staffDb.getBookById(bookId);

                if (book == null) {
        %>
            <p class="error">ERROR: Book not found with ID: <%= bookId %></p>
        <%
                } else {
        %>
            <form action="staffUpdateProdServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="BOOK_ID" value="<%= book.getBOOK_ID() %>">

                <label for="BOOK_NAME">Book Name:</label>
                <input type="text" id="BOOK_NAME" name="BOOK_NAME" value="<%= book.getBOOK_NAME() %>" required>

                <label for="BOOK_PRICE">Price (RM):</label>
                <input type="number" id="BOOK_PRICE" name="BOOK_PRICE" value="<%= book.getBOOK_PRICE() %>" step="0.01" required>

                <label for="AUTHOR_NAME">Author:</label>
                <input type="text" id="AUTHOR_NAME" name="AUTHOR_NAME" value="<%= book.getAUTHOR_NAME() %>" required>

                <label for="PUBLISHER">Publisher:</label>
                <input type="text" id="PUBLISHER" name="PUBLISHER" value="<%= book.getPUBLISHER() %>" required>

                <label for="NO_OF_PAGES">Number of Pages:</label>
                <input type="number" id="NO_OF_PAGES" name="NO_OF_PAGES" value="<%= book.getNO_OF_PAGES() %>" required>

                <label for="BOOK_DESC">Description:</label>
                <textarea id="BOOK_DESC" name="BOOK_DESC"><%= book.getBOOK_DESC() %></textarea>

                <label for="BOOK_QUANTITY">Quantity:</label>
                <input type="number" id="BOOK_QUANTITY" name="BOOK_QUANTITY" value="<%= book.getBOOK_QUANTITY() %>" required>

                <label for="BOOK_TYPE">Type:</label>
                <input type="text" id="BOOK_TYPE" name="BOOK_TYPE" value="<%= book.getBOOK_TYPE() %>" list="bookTypes">
                <datalist id="bookTypes">
                    <option value="Comics"></option>
                    <option value="Business"></option>
                    <option value="Cook"></option>
                    <option value="Travel"></option>
                    <option value="Hobby"></option>
                </datalist>

                <label for="BOOK_IMAGE">Current Image:</label>
                <img src="<%= book.getBOOK_IMAGE() %>" alt="<%= book.getBOOK_NAME() %>" width="100"><br>
                <label for="BOOK_IMAGE">Upload New Image (optional):</label>
                <input type="file" id="BOOK_IMAGE" name="BOOK_IMAGE">

                <label for="BOOK_CATEGORY">Category:</label>
                <select id="BOOK_CATEGORY" name="BOOK_CATEGORY">
                    <option value="<%= book.getBOOK_CATEGORY() %>"><%= book.getBOOK_CATEGORY() %></option>
                    <option value="English">English</option>
                    <option value="Bahasa_Melayu">Bahasa_Melayu</option>
                    <option value="中文图书">中文图书</option>
                    <option value="Revision">Revision</option>
                    <option value="Stationary">Stationary</option>
                </select>

                <button type="submit">Update Product</button>
            </form>
        <%
                }
            }
        %>
    </div>
</body>
</html>