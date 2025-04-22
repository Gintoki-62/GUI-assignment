<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DB.bookDB, domain.Book"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BOOKLOOM(STAFF) - Edit Products</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
            color: #333;
            line-height: 1.6;
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 30px;
            text-align: center;
        }

        form {
            width: 60%;
            margin: 30px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #555;
        }

        input[type="text"],
        input[type="number"],
        input[type="file"],
        textarea,
        select {
            width: calc(100% - 16px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        textarea {
            resize: vertical;
        }

        select {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="currentColor" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/><path d="M0 0h24v24H0z" fill="none"/></svg>');
            background-repeat: no-repeat;
            background-position: right 10px top 50%;
            background-size: 16px;
            padding-right: 30px;
        }

        button[type="submit"] {
            background-color: #5cb85c;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s ease;
        }

        button[type="submit"]:hover {
            background-color: #4cae4c;
        }

        .error {
            color: #d9534f;
            margin-top: 8px;
            font-style: italic;
        }

        img {
            display: block;
            margin-bottom: 10px;
            border: 1px solid #eee;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }

        @media (max-width: 768px) {
            form {
                width: 90%;
                margin: 20px auto;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <%@ include file="staffSidebar.jsp" %>

    <div style="padding: 20px;">
        <h2>Edit Product</h2>

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
                <input type="text" id="AUTHOR_NAME" name="AUTHOR_NAME" value="<%= book.getAUTHOR_NAME() %>">

                <label for="PUBLISHER">Publisher:</label>
                <input type="text" id="PUBLISHER" name="PUBLISHER" value="<%= book.getPUBLISHER() %>">

                <label for="NO_OF_PAGES">Number of Pages:</label>
                <input type="number" id="NO_OF_PAGES" name="NO_OF_PAGES" value="<%= book.getNO_OF_PAGES() %>">

                <label for="BOOK_DESC">Description:</label>
                <textarea id="BOOK_DESC" name="BOOK_DESC"><%= book.getBOOK_DESC() %></textarea>

                <label for="BOOK_QUANTITY">Quantity:</label>
                <input type="number" id="BOOK_QUANTITY" name="BOOK_QUANTITY" value="<%= book.getBOOK_QUANTITY() %>" required>

                <label for="BOOK_TYPE">Type:</label>
                <select id="BOOK_TYPE" name="BOOK_TYPE">
                    <option value="<%= book.getBOOK_TYPE() %>"><%= book.getBOOK_TYPE() %></option>
                    <option value=""></option>
                    <option value=""></option>
                    <option value=""></option>
                </select>

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