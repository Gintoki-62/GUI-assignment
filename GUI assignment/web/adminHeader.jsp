<!DOCTYPE html>
<html lang="en">
  <head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>BOOKLOOM Admin Page</title>
    <meta
      content="width=device-width, initial-scale=1.0, shrink-to-fit=no"
      name="viewport"
    />
    <link
      rel="icon"
      href="images/tablogo.png"
      type="image/x-icon"
    />

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

    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link rel="stylesheet" href="assets/css/demo.css" />
    
    <style>
        .fa-user:before{
            content:"\f007";
        }
    </style>
  </head>
  <body>
    <div class="wrapper">
      <!----------------------------------------------------------- Sidebar ------------------------------------------------------------>
      <div class="sidebar" data-background-color="dark">
        <div class="sidebar-logo">
          <!----------------------------------------------------- Logo Header ---------------------------------------------------------->
          <div class="logo-header" data-background-color="white" style="padding-left:0px">
            <a href="Index2.jsp" class="logo">
              <img
                src="images/icons/Logo.png"
                alt="navbar brand"
                class="navbar-brand"
                height="70" weight="20"
              />
            </a>
            <div class="nav-toggle">
              <button class="btn btn-toggle toggle-sidebar">
                <i class="gg-menu-right"></i>
              </button>
              <button class="btn btn-toggle sidenav-toggler">
                <i class="gg-menu-left"></i>
              </button>
            </div>
            <button class="topbar-toggler more">
              <i class="gg-more-vertical-alt"></i>
            </button>
          </div>
          <!-------------------------------------------------------- End Logo Header ----------------------------------------------->
        </div>
        <div class="sidebar-wrapper scrollbar scrollbar-inner">
          <div class="sidebar-content">
            <ul class="nav nav-secondary">
                <li class="nav-section">
                    <span class="sidebar-mini-icon">
                      <i class="fa fa-ellipsis-h"></i>
                    </span>
                    <h4 class="text-section">Components</h4>
                </li>
            
              <li class="nav-item">
                <a
                  data-bs-toggle="collapse"
                  href="#dashboard"
                  class="collapsed"
                  aria-expanded="false"
                >
                  <i class="fas fa-home"></i>
                  <p>Dashboard</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="dashboard">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="Index2.jsp">
                        <span class="sub-item">Dashboard 1</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#staff">
                  <i class="fas fa-user"></i>
                  <p>Staff Accounts</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="staff">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="staffAcc.jsp">
                        <span class="sub-item">Staff Accounts Management</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#customer">
                  <i class="fas fa-user"></i>
                  <p>Customer Accounts</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="customer">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="ViewCustomer.jsp">
                        <span class="sub-item">Customer Accounts Management</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              
              <li class="nav-item">
                <a data-bs-toggle="collapse" href="#products">
                  <i class="fas fa-book"></i>
                  <p>Products</p>
                  <span class="caret"></span>
                </a>
                <div class="collapse" id="products">
                  <ul class="nav nav-collapse">
                    <li>
                      <a href="productAdmin.jsp">
                        <span class="sub-item">Products Management</span>
                      </a>
                    </li>
                  </ul>
                </div>
              </li>
              
              <li class="nav-item">
                <a href="report.jsp">
                  <i class="fas fa-file"></i>
                  <p>Reports</p>
                </a>
              </li>

            </ul>
          </div>
        </div>
      </div>
      <!--------------------------------------------------------- End Sidebar ---------------------------------------------------------------->
      <div class="main-panel">
        <div class="main-header">
          <div class="main-header-logo">
            <!-- Logo Header -->
            <div class="logo-header" data-background-color="white">
              <a href="Index2.jsp" class="logo">
                <img
                  src="assets/img/kaiadmin/logo_light.svg"
                  alt="navbar brand"
                  class="navbar-brand"
                  height="20"
                />
              </a>
              <div class="nav-toggle">
                <button class="btn btn-toggle toggle-sidebar">
                  <i class="gg-menu-right"></i>
                </button>
                <button class="btn btn-toggle sidenav-toggler">
                  <i class="gg-menu-left"></i>
                </button>
              </div>
              <button class="topbar-toggler more">
                <i class="gg-more-vertical-alt"></i>
              </button>
            </div>
            <!--------------------------------------------------------- End Logo Header ------------------------------------------------->
          </div>
            
          <!------------------------------------------------------- Navbar Header ---------------------------------------------->
          <nav
            class="navbar navbar-header navbar-header-transparent navbar-expand-lg border-bottom"
          >
            <div class="container-fluid">
              <ul class="navbar-nav topbar-nav ms-md-auto align-items-center">
                <!--------------------------------------- View Profile ------------------------------------------------>
                <li class="nav-item topbar-user dropdown hidden-caret">
                  <a
                    class="dropdown-toggle profile-pic"
                    data-bs-toggle="dropdown"
                    href="#"
                    aria-expanded="false"
                  >
                    <div class="avatar-sm">
                      <% 
                        String profileImage = (String) session.getAttribute("profileImage");
                        if (profileImage == null || profileImage.isEmpty()) {
                            profileImage = "assets/img/profile.jpg"; // Default image
                        }
                      %> 
                      <img
                        src="images/<%= profileImage %>"
                        alt="..."
                        class="avatar-img rounded-circle"
                      />
                    </div>
                    <span class="profile-username">
                      <span class="op-7">Hi,</span>
                      <span class="fw-bold">
                        <% 
                          String stfName = (String) session.getAttribute("ManagerName");
                          out.print(stfName != null ? stfName : "Admin");
                        %>
                      </span>
                    </span>
                  </a>
                  <ul class="dropdown-menu dropdown-user animated fadeIn">
                    <div class="dropdown-user-scroll scrollbar-outer">
                      <li>
                        <div class="user-box">
                          <div class="avatar-lg">
                            <img
                              src="images/<%= profileImage %>"
                              alt="image profile"
                              class="avatar-img rounded"
                            />
                          </div>
                          <div class="u-text">
                            <h4><%= stfName != null ? stfName : "Admin" %></h4>
                            <p class="text-muted"> 
                              <% 
                                String email = (String) session.getAttribute("Email");
                                out.print(email != null ? email : "");
                              %>
                            </p>
                            <a
                              href="profileManager.jsp"
                              class="btn btn-xs btn-secondary btn-sm"
                              >View Profile</a
                            >
                          </div>
                        </div>
                      </li>
                      
                      <li>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="managerLogoutServlet">Logout</a>
                      </li>
                    </div>
                  </ul>
                </li>
                <!--------------------------------------- End View Profile ------------------------------------------------>
              </ul>
            </div>
          </nav>
          <!---------------------------------------------------------- End Navbar ------------------------------------------------------------>
        </div>
        <!-- Main Content Area (This is where Index2.jsp content will be inserted) -->