<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="domain.Customer"%>
<%@page import="DB.CustomerDB"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>BookLoom Staff Page</title>
        <link rel="icon" type="image/png" href="images/icons/tablogo.png"/>
        <style>
            body {
                margin: 0;
                padding: 0;
                background-color: #f5f9fa;
                color: #333;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .container {
                padding: 25px;
                transition: all 0.3s ease;
            }

            h1 {
                text-align: center;
                margin: 10px 0 30px;
                color: #4a4a4a;
                font-size: 28px;
                font-weight: 600;
                position: relative;
                padding-bottom: 15px;
            }

            h1:after {
                content: '';
                position: absolute;
                width: 80px;
                height: 3px;
                background: linear-gradient(90deg, #00b8d4, #4dd0e1);
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                border-radius: 2px;
            }

            h2 {
                text-align: center;
                margin: 20px 0;
                color: #4a4a4a;
                font-size: 22px;
                font-weight: 500;
            }

            .search-bar {
                width: 95%;
                margin: 25px auto;
                padding: 15px;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
            }

            .search-bar form {
                display: flex;
            }

            .search-bar input[type="text"] {
                flex: 1;
                padding: 10px 15px;
                border: 1px solid #b2ebf2;
                border-radius: 5px 0 0 5px;
                font-size: 14px;
                outline: none;
                box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
                transition: border-color 0.2s ease, box-shadow 0.2s ease;
            }

            .search-bar input[type="text"]:focus {
                border-color: #00bcd4;
                box-shadow: 0 0 0 3px rgba(0, 188, 212, 0.2);
            }

            .search-bar button {
                padding: 10px 20px;
                background: linear-gradient(to right, #00b8d4, #4dd0e1);
                color: white;
                border: none;
                border-radius: 0 5px 5px 0;
                cursor: pointer;
                font-size: 14px;
                transition: all 0.3s ease;
            }

            .search-bar button:hover {
                background: linear-gradient(to right, #0097a7, #26c6da);
            }

            table {
                width: 95%;
                margin: 25px auto;
                border-collapse: collapse;
                background-color: white;
                box-shadow: 0 0 15px rgba(0,0,0,0.1);
                border-radius: 8px;
                overflow: hidden;
            }

            th, td {
                padding: 14px 12px;
                border: none;
                text-align: left;
            }

            th {
                background: linear-gradient(135deg, #00b8d4, #4dd0e1);
                color: white;
                font-weight: 600;
                position: sticky;
                top: 0;
                text-transform: uppercase;
                font-size: 14px;
                letter-spacing: 0.5px;
            }

            tr:nth-child(even) {
                background-color: #f0f8ff;
            }

            tr:not(:last-child) td {
                border-bottom: 1px solid #e0f7fa;
            }

            tr:hover {
                background-color: #e0f7fa;
                transition: background-color 0.2s ease;
            }

            .error-message {
                text-align: center;
                padding: 12px 15px;
                margin: 15px auto;
                width: 90%;
                border-radius: 6px;
                font-size: 15px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.08);
                background-color: #ffebee;
                color: #b71c1c;
                border-left: 4px solid #f44336;
            }

            a {
                color: #00acc1;
                text-decoration: none;
                transition: color 0.2s ease;
            }

            a:hover {
                color: #007c91;
                text-decoration: underline;
            }

            p a {
                display: inline-block;
                margin: 10px 0;
                padding: 8px 16px;
                background: linear-gradient(to right, #00b8d4, #4dd0e1);
                color: white;
                border-radius: 5px;
                font-weight: 500;
                text-decoration: none;
            }

            p a:hover {
                background: linear-gradient(to right, #0097a7, #26c6da);
                text-decoration: none;
            }

            @media screen and (max-width: 768px) {
                .container {
                    margin-left: 0;
                    padding: 15px;
                }

                .search-bar form {
                    flex-direction: column;
                }

                .search-bar input[type="text"] {
                    border-radius: 5px;
                    margin-bottom: 10px;
                }

                .search-bar button {
                    border-radius: 5px;
                }
                
                table {
                    display: block;
                    overflow-x: auto;
                }
            }
        </style>
    </head>
    <body>
        <%@ include file="staffSidebar.jsp" %>
        <div class="container">
            <h1>Customer Records</h1>

            <div class="search-bar">
                <form action="staffSearchCustServlet" method="get">
                    <input type="text" name="searchTerm" placeholder="Search by Name, Username, or Email">
                    <button type="submit">Search</button>
                </form>
            </div>

            <%
                List<Customer> searchResults = (List<Customer>) request.getAttribute("searchResults");
                String errorMessage = (String) request.getAttribute("errorMessage");
            %>

            <% if (errorMessage != null) { %>
                <p class="error-message"><%= errorMessage %></p>
            <% } %>

            <% if (searchResults != null && !searchResults.isEmpty()) { %>
                <h2>Search Results</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Customer customer : searchResults) { %>
                            <tr>
                                <td><%= customer.getCusID() %></td>
                                <td><%= customer.getCusName() %></td>
                                <td><%= customer.getCusUserName() %></td>
                                <td><%= customer.getCusEmail() %></td>
                                <td><%= customer.getCusPhone() %></td>
                                <td><%= customer.getCusGender() %></td>
                                <td><%= customer.getAddress() %></td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
                <p><a href="staffCustRecord.jsp">View All Records</a></p>
            <% } else { %>
                <h2>All Customer Records</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Gender</th>
                            <th>Address</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            CustomerDB customerDB = null;
                            ResultSet rsAll = null;
                            try {
                                customerDB = new CustomerDB();
                                rsAll = customerDB.getAllRecords();
                                while (rsAll.next()) {
                                    int cusID = rsAll.getInt("ID");
                                    String cusName = rsAll.getString("Name");
                                    String cusUserName = rsAll.getString("Username");
                                    String cusEmail = rsAll.getString("Email");
                                    String cusPhone = rsAll.getString("Phone");
                                    String cusGender = rsAll.getString("Gender");
                                    String cusAddress = rsAll.getString("Address");
                        %>
                        <tr>
                            <td><%= cusID %></td>
                            <td><%= cusName %></td>
                            <td><%= cusUserName %></td>
                            <td><%= cusEmail %></td>
                            <td><%= cusPhone %></td>
                            <td><%= cusGender %></td>
                            <td><%= cusAddress %></td>
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                out.println("<p class='error-message'>Error retrieving customer records: " + e.getMessage() + "</p>");
                            } finally {
                                if (rsAll != null) {
                                    try {
                                        rsAll.close();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                }
                                if (customerDB != null) {
                                    try {
                                        customerDB.shutDown();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                }
                            }
                        %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </body>
</html>