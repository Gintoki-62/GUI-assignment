<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DB.bookDB, domain.Book"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BOOKLOOM(STAFF) - Edit Products</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            h2 {
                margin-bottom: 20px;
            }
            form {
                width: 50%;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #f9f9f9;
            }
            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }
            input[type="text"], input[type="number"], input[type="file"], textarea {
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 3px;
                box-sizing: border-box;
            }
            button[type="submit"] {
                background-color: #4CAF50;
                color: white;
                padding: 10px 15px;
                border: none;
                border-radius: 3px;
                cursor: pointer;
                font-size: 16px;
            }
            button[type="submit"]:hover {
                background-color: #45a049;
            }
            .error {
                color: red;
                margin-top: 5px;
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
                <p class="error">Error: Book ID not provided.</p>
            <%
                } else {
                    bookDB bookDb = new bookDB();
                    Book book = bookDb.getBookById(bookId);

                    if (book == null) {
            %>
                <p class="error">Error: Book not found with ID: <%= bookId %></p>
            <%
                    } else {
            %>
                <form action="updateProduct.jsp" method="post" enctype="multipart/form-data">
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
                    <input type="text" id="BOOK_TYPE" name="BOOK_TYPE" value="<%= book.getBOOK_TYPE() %>">

                    <label for="BOOK_IMAGE">Current Image:</label>
                    <img src="<%= book.getBOOK_IMAGE() %>" alt="<%= book.getBOOK_NAME() %>" width="100"><br>
                    <label for="BOOK_IMAGE">Upload New Image (optional):</label>
                    <input type="file" id="BOOK_IMAGE" name="BOOK_IMAGE">

                    <label for="BOOK_CATEGORY">Category:</label>
                    <input type="text" id="BOOK_CATEGORY" name="BOOK_CATEGORY" value="<%= book.getBOOK_CATEGORY() %>">

                    <button type="submit">Update Product</button>
                </form>
            <%
                    }
                }
            %>
        </div>
    </body>
</html>