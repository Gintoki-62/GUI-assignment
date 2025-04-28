<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <!-- Footer -->
    <footer class="bg3 p-t-75 p-b-32">
        <div class="container">
            <div class="row">
                
                <div class="col-sm-6 col-lg-3 p-b-50">
                   
                        <ul><li class="p-b-10"><a href="about.jsp" class="stext-107 cl7 hov-cl1 trans-04">Home</a></li>
                            <li class="p-b-10"><a href="product.jsp" class="stext-107 cl7 hov-cl1 trans-04">Book</a></li>
                            <li class="p-b-10"><a href="shoping-cart.jsp" class="stext-107 cl7 hov-cl1 trans-04">Shopping Cart</a></li>
                            <li class="p-b-10"><a href="OrderInfo.jsp" class="stext-107 cl7 hov-cl1 trans-04">OrderInfo</a></li>
                        </ul>
                </div>

                <div class="col-sm-6 col-lg-3 p-b-50">
                    <h4 class="stext-301 cl0 p-b-30">OUR LOCATION</h4>
                        <p class="stext-107 cl7 size-201">Any questions? Came to meet us in store at 77, Lorong Lembah Permai 3, 11200 Tanjung Bungah, Pulau Pinang </p>
                        
                </div>

                <div class="col-sm-6 col-lg-3 p-b-50">
                    
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3594.236828446695!2d100.28229957498445!3d5.45320519452633!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x304ac2c0305a5483%3A0xfeb1c7560c785259!2sTAR%20UMT%20Penang%20Branch!5e1!3m2!1sen!2smy!4v1745418880928!5m2!1sen!2smy" width="600" height="150" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
            </div>

            

                <p class="stext-107 cl6 txt-center">
                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                <%= application.getInitParameter("companyName") %>
                <%= application.getInitParameter("companyEmail") %>
                Copyright &copy; <%= application.getInitParameter("copyright") %> 
                    <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a> &amp; distributed by <a href="https://themewagon.com" target="_blank">ThemeWagon</a>
                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                </p>
            </div>
        </div>
    </footer>

    <!-- Back to top -->
    <div class="btn-back-to-top" id="myBtn">
        <span class="symbol-btn-back-to-top"><i class="zmdi zmdi-chevron-up"></i></span>
    </div>


<!--===============================================================================================-->	
	<script src="vendor/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/animsition/js/animsition.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/bootstrap/js/popper.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/select2/select2.min.js"></script>
	<script>
		$(".js-select2").each(function(){
			$(this).select2({
				minimumResultsForSearch: 20,
				dropdownParent: $(this).next('.dropDownSelect2')
			});
		})
	</script>
<!--===============================================================================================-->
	<script src="vendor/daterangepicker/moment.min.js"></script>
	<script src="vendor/daterangepicker/daterangepicker.js"></script>
<!--===============================================================================================-->
	<script src="vendor/slick/slick.min.js"></script>
	<script src="js/slick-custom.js"></script>
<!--===============================================================================================-->
	<script src="vendor/parallax100/parallax100.js"></script>
	<script>
        $('.parallax100').parallax100();
	</script>
<!--===============================================================================================-->
	<script src="vendor/MagnificPopup/jquery.magnific-popup.min.js"></script>
	<script>
		$('.gallery-lb').each(function() { // the containers for all your galleries
			$(this).magnificPopup({
		        delegate: 'a', // the selector for gallery item
		        type: 'image',
		        gallery: {
		        	enabled:true
		        },
		        mainClass: 'mfp-fade'
		    });
		});
	</script>
<!--===============================================================================================-->
	<script src="vendor/isotope/isotope.pkgd.min.js"></script>
<!--===============================================================================================-->
	<script src="vendor/sweetalert/sweetalert.min.js"></script>
	<script>
		$('.js-addwish-b2, .js-addwish-detail').on('click', function(e){
			e.preventDefault();
		});

		$('.js-addwish-b2').each(function(){
			var nameProduct = $(this).parent().parent().find('.js-name-b2').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to wishlist !", "success");
				$(this).addClass('js-addedwish-b2');
				$(this).off('click');
			});
		});

		$('.js-addwish-detail').each(function(){
			var nameProduct = $(this).parent().parent().parent().find('.js-name-detail').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to wishlist !", "success");
				$(this).addClass('js-addedwish-detail');
				$(this).off('click');
                            });
		});

		/*---------------------------------------------*/

		$('.js-addcart-detail').each(function(){
			var nameProduct = $(this).parent().parent().parent().parent().find('.js-name-detail').html();
			$(this).on('click', function(){
				swal(nameProduct, "is added to cart !", "success");
			});
		});
	
	</script>
<!--===============================================================================================-->
	<script src="vendor/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script>
		$('.js-pscroll').each(function(){
			$(this).css('position','relative');
			$(this).css('overflow','hidden');
			var ps = new PerfectScrollbar(this, {
				wheelSpeed: 1,
				scrollingThreshold: 1000,
				wheelPropagation: false,
			});

			$(window).on('resize', function(){
				ps.update();
			})
		});
	</script>
<!--===============================================================================================-->
	<script src="js/main.js"></script>
 <!--===============================================================================================-->       
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Loop through all quantity blocks
                document.querySelectorAll('.wrap-num-product').forEach(wrapper => {
                    const input = wrapper.querySelector('.num-product');
                    const btnMinus = wrapper.querySelector('.btn-num-down');
                    const btnPlus = wrapper.querySelector('.btn-num-up');

                    const min = parseInt(input.min) || 1;
                    const max = parseInt(input.max) || 100;

                    // - button
                    btnMinus.addEventListener("click", function () {
                        let val = parseInt(input.value) || min;
                        if (val > min) {
                            input.value = val - 1;
                        }
                    });

                    // + button
                    btnPlus.addEventListener("click", function () {
                        let val = parseInt(input.value) || min;
                        if (val < max) {
                            input.value = val + 1;
                        }
                    });

                    // Manual input
                    input.addEventListener("input", function () {
                        let val = parseInt(this.value);
                        if (isNaN(val) || val < min) this.value = min;
                        if (val > max) this.value = max;
                    });
                });
            });
            </script>
<!--===============================================================================================-->    
        
        <%
            String added = request.getParameter("added");
            String bookname = request.getParameter("bookname");
            if ("true".equals(added) && bookname != null) {
        %>
            <script>
                window.onload = function() {
                    swal("<%= bookname %>", "is added to cart!", "success");
                };
            </script>
        <%
            }
        %>
<!--===============================================================================================-->  

        <%
            String success = request.getParameter("success");
            String amount = request.getParameter("amount"); // assuming you passed amount in URL or as request attribute
            if ("true".equals(success)) {
        %>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
            <script>
                window.onload = function() {
                    const currentDate = new Date().toLocaleString(); // Get current date/time
                         Swal.fire({
                                title: '<b>RM <%= amount %></b><br><br><span style="color: #8BD442;">Payment Successful&nbsp;!</span>',
                                html: '<br><br><a href="OrderInfo.jsp" style="color:black; text-decoration: underline;">Show Order</a><br><br>Thank you for your order!',
                                icon: 'success'
                            });
                        };
            </script>
        <%
            }
        %>
       
        
    </body>
</html>
