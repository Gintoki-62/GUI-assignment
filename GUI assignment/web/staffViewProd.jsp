<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, DB.staffDB, domain.Book"%>
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
            background-color: #e8f5e9;
            color: #388e3c;
            min-height: 100vh;
        }

        .container {
            width: 95%;
            max-width: 1400px;
            margin: 30px auto;
            background-color: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            position: relative;
            z-index: 1;
        }

        .container::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #81c784, #4caf50);
            border-radius: 12px 12px 0 0;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #2e7d32;
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
            background-color: #4caf50;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 25px;
            box-shadow: 0 3px 8px rgba(0, 0, 0, 0.06);
            border-radius: 8px;
            overflow: hidden;
            background-color: #f1f8e9;
        }

        th, td {
            padding: 14px 16px;
            text-align: left;
            font-size: 14px;
            border: none;
            border-bottom: 1px solid #c8e6c9;
        }

        th {
            background: linear-gradient(135deg, #8bc34a, #689f38);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 13px;
            letter-spacing: 0.5px;
        }

        th.actions-header,
        td.actions {
            text-align: center;
            width: 80px;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:nth-child(even) {
            background-color: #e8f5e9;
        }

        tbody tr:hover {
            background-color: #dcedc8;
            transition: background-color 0.2s ease;
        }

        img {
            max-width: 80px;
            height: auto;
            display: block;
            margin: 0 auto;
            border-radius: 6px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s ease;
        }

        img:hover {
            transform: scale(1.05);
        }

        a {
            color: #43a047;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        a:hover {
            color: #388e3c;
        }

        .actions a {
            display: inline-block;
            padding: 5px;
            border-radius: 50%;
            transition: all 0.2s ease;
        }

        .actions a:hover {
            background-color: rgba(76, 175, 80, 0.1);
            transform: translateY(-2px);
        }

        .actions img {
            display: block;
            width: 22px;
            height: auto;
            margin: 0 auto;
            box-shadow: none;
        }

        p {
            text-align: center;
            color: #66bb6a;
            margin-top: 25px;
            font-size: 16px;
            font-style: italic;
        }

        body::after {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%233a5f3a' fill-opacity='0.03'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E"); /* Keep the subtle green pattern */
            pointer-events: none;
            z-index: 0;
        }

        .logo{
            box-shadow: none;
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
                <tr id="book-<%= book.getBOOK_ID() %>"> <td><%= book.getBOOK_ID() %></td>
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