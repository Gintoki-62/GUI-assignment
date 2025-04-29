<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, java.util.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BOOKLOOM Admin Page - Sales Reports</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="images/tablogo.png" type="image/x-icon" />

    <!-- CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/plugins.min.css" />
    <link rel="stylesheet" href="assets/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="assets/css/demo.css" />
    
    <!-- Fonts and icons -->
    <script src="assets/js/plugin/webfont/webfont.min.js"></script>
    <script>
      WebFont.load({
        google: { families: ["Public Sans:300,400,500,600,700"] },
        custom: {
          families: [
            "Font Awesome 5 Solid",
            "Font Awesome 5 Regular",
            "Font Awesome 5 Brands",
            "simple-line-icons",
          ],
          urls: ["assets/css/fonts.min.css"],
        },
        active: function () {
          sessionStorage.fonts = true;
        },
      });
    </script>

    <style>
      .hidden { display: none; }
      .create_button {
          font-weight: bold;
          color: black;
          display: flex;
          justify-content: center;
          align-items: center;
          background-color: #9bb0c1;
          cursor: pointer;
          font-size: 16px;
          padding: 9px 25px;
          border: none;
          border-radius: 50px;
          margin: 10px auto;
      }
      .create_button:hover {
          color: white;
          background-color: #00224d;
          transition-duration: 0.6s;
      }
      table {
          width: 100%;
          margin-top: 20px;
          border-collapse: collapse;
      }
      th, td {
          padding: 10px;
          border: 1px solid #ccc;
          text-align: center;
      }
      th {
          background-color: #00224d;
          color: white;
      }
      .error-message {
          color: red;
          font-weight: bold;
          margin: 20px 0;
      }
    </style>
</head>

<body>
<%@ include file="adminHeader.jsp" %>

<div class="container">
    <div class="page-inner">
        <div class="page-header">
            <h3 class="fw-bold mb-3">Sales Reports</h3>
            <ul class="breadcrumbs mb-3">
                <li class="nav-home"><a href="#"><i class="icon-home"></i></a></li>
                <li class="separator"><i class="icon-arrow-right"></i></li>
                <li class="nav-item"><a href="#">Reports</a></li>
            </ul>
        </div>

        <!-- Error Message Display -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <!-- Select Report Type -->
        <div class="row mb-4">
            <div class="col-md-12">
                <label for="reportType" class="form-label fw-bold">Select Report Type:</label>
                <select id="reportType" class="form-select" onchange="toggleReportFields()">
                    <option value="">-- Choose Report Type --</option>
                    <option value="top10">Top 10 Best Sales</option>
                    <option value="daymonthyear">Sales Report by Day/Month/Year</option>
                </select>
            </div>
        </div>

        <!-- Top 10 Section -->
        <div id="top10Section" class="hidden">
            <div class="card p-4">
                <form action="reportServlet" method="get">
                    <input type="hidden" name="action" value="top10">
                    <div class="text-center">
                        <button type="submit" class="create_button">View Top 10 Sales</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Day/Month/Year Section -->
        <div id="dayMonthYearSection" class="hidden">
            <div class="card p-4">
                <form action="reportServlet" method="get">
                    <input type="hidden" name="action" value="daymonthyear">
                    <div class="row mb-4">
                        <div class="col-md-4">
                            <label for="yearSelect" class="form-label fw-bold">Select Year:</label>
                            <select name="year" id="yearSelect" class="form-select" required>
                                <option value="2024">2024</option>
                                <option value="2025">2025</option>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="monthSelect" class="form-label fw-bold">Select Month:</label>
                            <select name="month" id="monthSelect" class="form-select" required>
                                <% for (int m = 1; m <= 12; m++) { %>
                                    <option value="<%= m %>"><%= String.format("%02d", m) %></option>
                                <% } %>
                            </select>
                        </div>
                        <div class="col-md-4">
                            <label for="daySelect" class="form-label fw-bold">Select Day:</label>
                            <select name="day" id="daySelect" class="form-select" required>
                                <% for (int d = 1; d <= 31; d++) { %>
                                    <option value="<%= d %>"><%= String.format("%02d", d) %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>

                    <div class="text-center">
                        <button type="submit" class="create_button">View Sales Report</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Display Results -->
        <div class="report-results mt-5">
            <%-- Top 10 Results --%>
            <%
                List<Map<String, Object>> top10List = (List<Map<String, Object>>) request.getAttribute("top10List");
                if (top10List != null && !top10List.isEmpty()) {
            %>
            <h2 class="fw-bold mb-4">Top 10 Best-Selling Books</h2>
            <table class="table table-bordered table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>Rank</th>
                        <th>Book Name</th>
                        <th>Total Sold</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    int rank = 1;
                    for (Map<String, Object> book : top10List) { 
                    %>
                    <tr>
                        <td><%= rank++ %></td>
                        <td><%= book.get("bookName") %></td>
                        <td><%= book.get("totalSold") %></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } else if (top10List != null && top10List.isEmpty()) { %>
                <div class="alert alert-info">No data found for top 10 sales report.</div>
            <% } %>

            <%-- Day/Month/Year Results --%>
            <%
                List<Map<String, Object>> dayMonthYearList = (List<Map<String, Object>>) request.getAttribute("dayMonthYearList");
                if (dayMonthYearList != null && !dayMonthYearList.isEmpty()) {
            %>
            <h2 class="fw-bold mb-4 mt-5">Sales Report for Selected Date</h2>
            <table class="table table-bordered table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>Order Date</th>
                        <th>Book Name</th>
                        <th>Quantity Sold</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    int totalSold = 0;
                    for (Map<String, Object> record : dayMonthYearList) { 
                        totalSold += (Integer)record.get("quantity");
                    %>
                    <tr>
                        <td>
                            <% 
                                Timestamp timestamp = (Timestamp) record.get("orderDate");
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                                out.print(sdf.format(timestamp));
                            %>
                        </td>
                        <td><%= record.get("bookName") %></td>
                        <td><%= record.get("quantity") %></td>
                    </tr>
                    <% } %>
                    <tr class="table-info">
                        <td colspan="2" class="text-end fw-bold">Total:</td>
                        <td class="fw-bold"><%= totalSold %></td>
                    </tr>
                </tbody>
            </table>
            <% } else if (dayMonthYearList != null && dayMonthYearList.isEmpty()) { %>
                <div class="alert alert-info">No sales found for the selected date.</div>
            <% } %>
        </div>
    </div>
</div>

 <%@ include file="adminFooter.jsp" %>
<script>
    function toggleReportFields() {
        var reportType = document.getElementById("reportType").value;
        document.getElementById("top10Section").classList.add("hidden");
        document.getElementById("dayMonthYearSection").classList.add("hidden");

        if (reportType === "top10") {
            document.getElementById("top10Section").classList.remove("hidden");
        } else if (reportType === "daymonthyear") {
            document.getElementById("dayMonthYearSection").classList.remove("hidden");
        }
    }
    
    // Initialize the correct section if coming back with results
    window.onload = function() {
        <% if (request.getAttribute("top10List") != null) { %>
            document.getElementById("reportType").value = "top10";
            document.getElementById("top10Section").classList.remove("hidden");
        <% } else if (request.getAttribute("dayMonthYearList") != null) { %>
            document.getElementById("reportType").value = "daymonthyear";
            document.getElementById("dayMonthYearSection").classList.remove("hidden");
        <% } %>
    };
</script>

</body>
</html>