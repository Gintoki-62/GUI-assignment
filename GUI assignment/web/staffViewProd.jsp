<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, DB.staffDB, domain.Book"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BOOKLOOM(STAFF)-View Products</title>
    <style>
        body {
            font-family: sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 20px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
            font-size: 14px;
        }
        th {
            text-align: center;
            background-color: #5cb85c;
            color: white;
            font-weight: bold;
            text-transform: uppercase;
            font-size: 15px;
        }
        th.actions-header,
        td.actions {
            text-align: center;
            padding-right: 15px;
        }
        tbody tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tbody tr:hover {
            background-color: #e0f7fa;
        }
        img {
            max-width: 80px;
            height: auto;
            display: block;
            margin: 0 auto;
            border-radius: 4px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }
        a {
            color: #007bff;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        a:hover {
            color: #0056b3;
            text-decoration: underline;
        }
        .actions a {
            text-decoration: none;
        }
        .actions img {
            display: block;
            width: 24px;
            height: auto;
            margin: 0 auto;
        }
        p {
            text-align: center;
            color: #777;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="staffSidebar.jsp" %>

    <div class="container">
        <h2>View Products</h2>

        <%
            staffDB staffDb = new staffDB();
            List<Book> bookList = staffDb.getRecord();

            if (bookList != null && !bookList.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>Book ID</th>
                    <th>Name</th>
                    <th>Price (RM)</th>
                    <th>Author</th>
                    <th>Publisher</th>
                    <th>Pages</th>
                    <th>Quantity</th>
                    <th>Type</th>
                    <th>Image</th>
                    <th>Category</th>
                    <th class="actions-header">Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (Book book : bookList) { %>
                <tr>
                    <td><%= book.getBOOK_ID() %></td>
                    <td><%= book.getBOOK_NAME() %></td>
                    <td><%= String.format("%.2f", book.getBOOK_PRICE()) %></td>
                    <td><%= book.getAUTHOR_NAME() %></td>
                    <td><%= book.getPUBLISHER() %></td>
                    <td><%= book.getNO_OF_PAGES() %></td>
                    <td><%= book.getBOOK_QUANTITY() %></td>
                    <td><%= book.getBOOK_TYPE() %></td>
                    <td><img src="<%= book.getBOOK_IMAGE() %>" alt="<%= book.getBOOK_NAME() %>" width="80"></td>
                    <td><%= book.getBOOK_CATEGORY() %></td>
                    <td class="actions">
                        <a href="staffEditProd.jsp?BOOK_ID=<%= book.getBOOK_ID() %>">
                            <img src="images/icons/staff_edit.png" alt="Edit" >
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <%
            } else {
        %>
        <p>No products available.</p>
        <%
            }
        %>
    </div>
</body>
</html>