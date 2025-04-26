<%-- 
    Document   : report
    Created on : 23 Apr 2025
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, DB.ProductDB"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>BOOKLOOM Admin Page</title>
    <meta content="width=device-width, initial-scale=1.0, shrink-to-fit=no" name="viewport" />
    <link rel="icon" href="images/tablogo.png" type="image/x-icon" />

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

    <!-- CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/plugins.min.css" />
    <link rel="stylesheet" href="assets/css/kaiadmin.min.css" />
    <link rel="stylesheet" href="assets/css/demo.css" />

    <style>
      .button_container {
        display: flex;
        justify-content: center;
        gap: 10px;
        margin-bottom: 10px;
      }

      .edit_button {
        font-weight: bold;
        color: darkslategray;
        flex: 1;
        max-width: 98%;
        margin: auto;
        justify-content: center;
        align-items: center;
        background-color: whitesmoke;
        cursor: pointer;
        font-size: 14px;
        height: 40px;
        border: 2px solid whitesmoke;
        box-shadow: 0px 1px 1px 1px grey;
        border-radius: 10px;
        transform: translate(1%, 0%);
      }
      .edit_button:hover {
        color: black;
        font-weight: bold;
        background-color: #9bb0c1;
        transition-duration: 0.6s;
      }

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
        float: right;
        margin: 10px;
      }
      .create_button:hover {
        color: white;
        background-color: #00224d;
        transition-duration: 0.6s;
      }

      .heading_section p, .heading_section h6 {
        color: white;
        text-align: center;
      }

      .hidden {
        display: none;
      }
    </style>
  </head>

  <body>
    <%@ include file="adminHeader.jsp" %>

    <div class="container">
      <div class="page-inner">
        <div class="d-flex align-items-left align-items-md-center flex-column flex-md-row pt-2 pb-4">
          <div class="page-header">
            <h3 class="fw-bold mb-3">Documentation</h3>
            <ul class="breadcrumbs mb-3">
              <li class="nav-home">
                <a href="#"><i class="icon-home"></i></a>
              </li>
              <li class="separator">
                <i class="icon-arrow-right"></i>
              </li>
              <li class="nav-item">
                <a href="#">Documentation</a>
              </li>
              <li class="separator">
                <i class="icon-arrow-right"></i>
              </li>
              <li class="nav-item">
                <a href="#">Reports</a>
              </li>
            </ul>
          </div>
        </div>

        <!------------------------ Choose Report Type ------------------------>
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

        <!------------------------ Top 10 Sales Section ------------------------>
        <div id="top10Section" class="hidden">
          <div class="card p-4">
            <h5 class="fw-bold">Top 10 Best-Selling Books</h5>
            <!-- Later: Put Top 10 Sales Report Here -->
            <p>Top 10 Sales report here...</p>
          </div>
        </div>

        <!------------------------ Day/Month/Year Section ------------------------>
        <div id="dayMonthYearSection" class="hidden">
          <div class="row mb-4">
            <div class="col-md-4">
              <label for="yearSelect" class="form-label fw-bold">Select Year:</label>
              <select id="yearSelect" class="form-select">
                   <option value="2024">2024</option>
                   <option value="2025">2025</option>
              </select>
            </div>

            <div class="col-md-4">
              <label for="monthSelect" class="form-label fw-bold">Select Month:</label>
              <select id="monthSelect" class="form-select">
                <% 
                  for (int m = 1; m <= 12; m++) {
                %>
                  <option value="<%= m %>"><%= String.format("%02d", m) %></option>
                <% } %>
              </select>
            </div>

            <div class="col-md-4">
              <label for="daySelect" class="form-label fw-bold">Select Day:</label>
              <select id="daySelect" class="form-select">
                <% 
                  for (int d = 1; d <= 31; d++) {
                %>
                  <option value="<%= d %>"><%= String.format("%02d", d) %></option>
                <% } %>
              </select>
            </div>
          </div>

          <div class="text-center">
            <button class="create_button" onclick="viewReport()">View Report</button>
          </div>
        </div>
      </div>
    </div>

    <!-------------------------------------------------------- Footer ---------------------------------------------------------->
    <footer class="footer">
      <div class="container-fluid d-flex justify-content-between">
        <nav class="pull-left">
          <ul class="nav">
            <li class="nav-item">
              <a class="nav-link" href="#">Help</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Licenses</a>
            </li>
          </ul>
        </nav>
        <div class="copyright">
          2025, made with <i class="fa fa-heart heart text-danger"></i> by BOOKLOOM
        </div>
      </div>
    </footer>

    <!-- Core JS Files -->
    <script src="assets/js/core/jquery-3.7.1.min.js"></script>
    <script src="assets/js/core/popper.min.js"></script>
    <script src="assets/js/core/bootstrap.min.js"></script>

    <!-- Other Plugins -->
    <script src="assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>
    <script src="assets/js/plugin/jquery.sparkline/jquery.sparkline.min.js"></script>
    <script src="assets/js/plugin/chart.js/chart.min.js"></script>
    <script src="assets/js/plugin/datatables/datatables.min.js"></script>
    <script src="assets/js/plugin/sweetalert/sweetalert.min.js"></script>
    <script src="assets/js/plugin/bootstrap-notify/bootstrap-notify.min.js"></script>
    <script src="assets/js/kaiadmin.min.js"></script>

    <!-- Custom Script -->
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

      function viewReport() {
        var year = document.getElementById("yearSelect").value;
        var month = document.getElementById("monthSelect").value;
        var day = document.getElementById("daySelect").value;
        alert("Viewing report for: " + day + "/" + month + "/" + year);
        // Later you can redirect or display results here
      }
    </script>

  </body>
</html>
