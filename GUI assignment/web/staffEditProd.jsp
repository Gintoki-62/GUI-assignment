<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DB.bookDB, domain.Book, java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BOOKLOOM(STAFF) - Edit Products</title>
    <style>
        .content body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 20px;
            background-color: #f8f9fa;
            color: #333;
            line-height: 1.6;
        }

        .content h2 {
            color: #007bff;
            margin-bottom: 30px;
            text-align: center;
        }

        .content .error-message {
            color: #dc3545;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            font-weight: bold;
        }

        .content form {
            width: 60%;
            margin: 30px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .content label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #495057;
        }

        .content input[type="text"],
        .content input[type="number"],
        .content input[type="file"],
        .content textarea,
        .content select {
            width: calc(100% - 16px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        .content textarea {
            resize: vertical;
        }

        .content select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="#495057" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px top 50%;
            background-size: 16px;
            padding-right: 30px;
        }

        .content button[type="submit"] {
            background-color: #28a745;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s ease;
        }

        .content button[type="submit"]:hover {
            background-color: #218838;
        }

        .content .error {
            color: #dc3545;
            margin-top: 8px;
            font-style: italic;
        }

        .content img {
            display: block;
            margin-bottom: 10px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        @media (max-width: 768px) {
            .content form {
                width: 90%;
                margin: 20px auto;
                padding: 20px;
            }
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

        <%
            String bookId = request.getParameter("BOOK_ID");
            if (bookId == null || bookId.trim().isEmpty()) {
        %>
            <p class="error">ERROR: Book ID not provided.</p>
        <%
            } else {
                bookDB bookDb = new bookDB();
                Book book = bookDb.getBookById(bookId);

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