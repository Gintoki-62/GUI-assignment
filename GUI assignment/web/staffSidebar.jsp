<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>BookLoom Staff Sidebar</title>
    <link rel="stylesheet" href="css/staffSidebar.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <style>
        .logout-button {
            border: none;
            background: none;
            cursor: pointer;
            color: inherit;
            text-align: left;
            font-size: inherit;
            display: flex;
            align-items: center;
            width: 100%;
            text-decoration: none;
        }

        .logout-button i {
            margin-right: 0.5rem;
        }
    </style>
</head>
<body>
    <aside id="sidebar" class="active">
        <div class="sidebar-wrapper">
            <div class="sidebar-header">
                <a href="staffIndex.jsp" target="_blank"><img src="images/icons/Logo.png" alt="Logo" class="logo"/></a>
            </div>
            <nav class="sidebar-menu">
                <ul class="menu">
                    <li class="sidebar-item title">
                        <span>Dashboard</span>
                    </li>
                    <li class="sidebar-item">
                        <a href="staffViewProd.jsp" class="sidebar-link">
                            <i class="bi bi-box-seam"></i>
                            <span>View Products</span>
                        </a>
                    </li>
                    <li class="sidebar-item">
                        <a href="staffAddProd.jsp" class="sidebar-link">
                            <i class="bi bi-plus-circle"></i>
                            <span>Add Product</span>
                        </a>
                    </li>
                     <li class="sidebar-item">
                        <a href="staffCustRecord.jsp" class="sidebar-link">
                            <i class="bi bi-people"></i>
                            <span>View Customers</span>
                        </a>
                    </li>
                    <li class="sidebar-item">
                        <a href="staffCheckStatus.jsp" class="sidebar-link">
                            <i class="bi bi-truck"></i>
                            <span>Order Status</span>
                        </a>
                    </li>
                </ul>
                <hr class="sidebar-item separator">
                <ul class="menu">
                    <li class="sidebar-item title">
                        <span>Account</span>
                    </li>
                    <li class="sidebar-item">
                        <a href="staffProfile.jsp" class="sidebar-link">
                            <i class="bi bi-person-circle"></i>
                            <span>Profile</span>
                        </a>
                    </li>
                    <li class="sidebar-item">
                        <form action="staffLogoutServlet" method="post">
                            <button type="submit" class="sidebar-link logout-button">
                                <i class="bi bi-box-arrow-left"></i>
                                <span>Logout</span>
                            </button>
                        </form>
                    </li>
                </ul>
            </nav>
        </div>
    </aside>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const links = document.querySelectorAll('.sidebar-link');
            const currentPage = window.location.pathname.split('/').pop();

            links.forEach(link => {
                const linkPage = link.getAttribute('href') ? link.getAttribute('href').split('/').pop() : '';
                if (linkPage === currentPage) {
                    link.parentElement.classList.add('active');
                }
            });
        });
    </script>
</body>
</html>