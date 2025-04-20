<!DOCTYPE html>
<html lang="en">
<head>
    <style>
    .error { color: red; font-size: 13px; }
    input:disabled { background: #eee; }
  </style>
	<%@ page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ include file="header.jsp"%>
        <%@page import="java.sql.*, DB.bookDB, domain.Book"%>
</head>
<body class="animsition">
    
    <% 
        String username = (String) session.getAttribute("username");
        String phone = (String) session.getAttribute("phone");
        String address = (String) session.getAttribute("address");
        
        Double grandtotal = (Double) session.getAttribute("grandtotal");
        if (grandtotal == null) {
            grandtotal = 0.0;
        }
        
    %>
	<!-- Content page -->
	<section class="bg0 p-t-52 p-b-20">
		<div class="container">
                    <a href="payCheckOut.jsp" style="color:black"><img src="images/icons/replay.png" title="Back"/>Back</a><br/><br/>
                    <div>
                        <h4 class="mtext-113 cl2 p-b-12">Make a Payment</h4>
                        <br/><br/>
                        <h2>Grand Total: &nbsp;&nbsp; <b>RM <%= String.format("%.2f", grandtotal) %></b></h2><br/>
                        
                        <form action="" method="" id="creditForm">
                            <div class="p-t-30 p-b-40 m-lr-0-xl p-lr-15-sm">
                                <label for="payMethod">Payment Method:</label>
                                <select name="method" id="method" onchange="showFields()" class="bor19 size-218 m-b-20" style="padding:10px; width:600px" required><br/>
                                      <option value="">-- Choose a Payment Method --</option><br/>
                                      <option value="Cash">Cash</option><br/>
                                      <option value="CreditCard">Credit Card</option><br/>
                                      <option value="OnlineBanking">Online Banking</option><br/>
                                      <option value="E-Wallet">E-Wallet</option><br/>
                                    </select>
                                <br/><br/>
                                
                    <!--=============== credit card ==================-->
                                <div id="creditFields" style="display:none;">
                                    <table style="width: 100%">
                                        <tr>
                                            <td rowspan="4">
                                                <img src="images/icons/creditcard.png" alt="Credit Card"/>
                                            </td>
                                            <td>
                                                <label id="username">Card Holder Name:</label> 
                                                <input type="text" id="cardName" name="card_name" class="bor19 m-b-20" style="padding: 10px; width:500px" required/>
                                                <span class="error" id="cardNameError" style="color:red;"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label id="username">Card Number:</label> 
                                                <input type="text" id="cardNumber" name="card_number" class="bor19 m-b-20" style="padding: 10px; width:500px" required/>
                                                <span class="error" id="cardNumberError" style="color:red;"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label id="username">Expiration Date:</label> 
                                                <input type="month" id="expDate" name="exp_date" class="bor19 m-b-20" style="padding: 10px; width:500px" required/>
                                                <span class="error" id="expDateError" style="color:red;"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label id="username">Card Verification Value (CVV):</label> 
                                                <input type="text" id="cvv" name="cvv" class="bor19 m-b-20" style="padding: 10px; width:500px" required/>
                                                <span class="error" id="cvvError" style="color:red;"></span>
                                            </td>
                                        </tr>
                                    </table>
                                    <br/>
                                </div>
                    
                    <!--=============== online banking ==================-->
                                <div id="bankingFields" style="display:none;">
                                    <table style="width: 100%">
                                        <tr>
                                            <td rowspan="3">
                                                <img src="images/icons/bankcard.png" alt="Credit Card" width='550px' style='border-radius: 50px'/>
                                            </td>
                                            <td>
                                                <label>Bank Name:</label>
                                                <select name="bank" id="bank" class="bor19 size-218 m-b-20" style="padding:10px; width:600px" required>
                                                  <option value="">-- Choose a Online Banking --</option>
                                                  <option value="Cash">Am Bank</option>
                                                  <option value="CreditCard">CIMB Bank</option>
                                                  <option value="OnlineBanking">Hong Leong Bank</option>
                                                  <option value="E-Wallet">MayBank</option>
                                                  <option value="E-Wallet">OCBC Bank</option>
                                                  <option value="E-Wallet">Public Bank</option>
                                                  <option value="E-Wallet">RHB Bank</option>
                                                  <option value="E-Wallet">UOB Bank</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label id="username">Account Name:</label> 
                                                <input type="text" name="acc_name" class="bor19 m-b-20" style="padding: 10px; width:500px" required/>
                                                <span id="errorMsg" style="color:red;"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label id="username">Account Number:</label> 
                                                <input type="text" name="acc_number" class="bor19 m-b-20" style="padding: 10px; width:500px" required/>
                                                <span id="errorMsg" style="color:red;"></span>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                    
                    <!--=============== E-wallet ==================-->
                                <div id="ewalletFields" style="display:none;">
                                    <table style="width: 100%">
                                        <tr>
                                            <td rowspan="2">
                                                <img src="images/icons/e-wallet.png" alt="Credit Card" width='200px'/>
                                            </td>
                                            <td>
                                                <label>Wallet Type: </label>
                                                <select name="e-wallet" id="e-wallet" class="bor19 size-218 m-b-20" style="padding:10px; width:600px" required><br/>
                                                  <option value="">-- Choose a E-Wallet --</option><br/>
                                                  <option value="Cash">Boost</option><br/>
                                                  <option value="CreditCard">GrabPay</option><br/>
                                                  <option value="OnlineBanking">Touch'n Go</option><br/>
                                                  <option value="CreditCard">ShopeePay</option><br/>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <label id="username">Phone Number:</label> 
                                                <input type="text" name="pho_number" class="bor19 m-b-20" style="padding: 10px; width:500px" required/>
                                                <span id="errorMsg" style="color:red;"></span>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <input type="hidden" name="amount" value="<%= String.format("%.2f", grandtotal) %>" />
                                <input type="hidden" name="order_id" value="101" />
                                <input type="hidden" name="user_id" value="<%= username%>" />

                                <br/><br/>
                                   <button class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer">
                                           Pay
                                   </button>
                                <br/><br/>   
                            </div> 
                        </form>
                    </div>
                </div>
        </section>	
	
     <%@ include file="footer.jsp"%>
     <script src="js/formValidation.js"></script>
     <script>
        function showFields() {
            document.getElementById("creditFields").style.display = "none";
            document.getElementById("bankingFields").style.display = "none";
            document.getElementById("ewalletFields").style.display = "none";

            var method = document.getElementById("method").value;
            if (method === "CreditCard") document.getElementById("creditFields").style.display = "block";
            else if (method === "OnlineBanking") document.getElementById("bankingFields").style.display = "block";
            else if (method === "E-Wallet") document.getElementById("ewalletFields").style.display = "block";
        }
    </script>
 <script>
  const cardName = document.getElementById("cardName");
  const cardNumber = document.getElementById("cardNumber");
  const expDate = document.getElementById("expDate");
  const cvv = document.getElementById("cvv");

  const nameError = document.getElementById("nameError");
  const cardError = document.getElementById("cardError");
  const dateError = document.getElementById("dateError");
  const cvvError = document.getElementById("cvvError");

  // Step 1: Name validation
  cardName.addEventListener("input", () => {
    const value = cardName.value.trim();
    if (/^[A-Za-z ]+$/.test(value)) {
      nameError.textContent = "";
      cardNumber.disabled = false;
    } else {
      nameError.textContent = "Only letters and spaces allowed.";
      cardNumber.disabled = true;
      expDate.disabled = true;
      cvv.disabled = true;
    }
  });

  // Step 2: Card number validation and formatting
  cardNumber.addEventListener("input", () => {
    let raw = cardNumber.value.replace(/\D/g, "").slice(0, 16);
    cardNumber.value = raw.replace(/(.{4})/g, "$1 ").trim();

    if (raw.length === 16) {
      cardError.textContent = "";
      expDate.disabled = false;
    } else {
      cardError.textContent = "Enter 16 digits.";
      expDate.disabled = true;
      cvv.disabled = true;
    }
  });

  // Step 3: Expiration date
  expDate.addEventListener("input", () => {
    const selectedDate = new Date(expDate.value + "-01");
    const today = new Date("2025-01-01");

    if (selectedDate > today) {
      dateError.textContent = "";
      cvv.disabled = false;
    } else {
      dateError.textContent = "Must be after Jan 2025.";
      cvv.disabled = true;
    }
  });

  // Step 4: CVV validation
  cvv.addEventListener("input", () => {
    if (/^\d{3}$/.test(cvv.value)) {
      cvvError.textContent = "";
    } else {
      cvvError.textContent = "Enter 3-digit CVV.";
    }
  });

  // Final validation on submit
  document.getElementById("creditForm").addEventListener("submit", function (e) {
    if (
      !cardName.value ||
      !cardNumber.value ||
      !expDate.value ||
      !cvv.value ||
      nameError.textContent ||
      cardError.textContent ||
      dateError.textContent ||
      cvvError.textContent
    ) {
      e.preventDefault();
      alert("Please fix all errors before submitting.");
    }
  });
</script>
    

</body>
</html>
