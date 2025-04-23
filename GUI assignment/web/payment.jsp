<!DOCTYPE html>
<html lang="en">
<head>
	<%@ page contentType="text/html" pageEncoding="UTF-8" %>
        <%@ include file="header.jsp"%>
        <%@page import="java.sql.*, DB.bookDB, domain.Book"%>
</head>
<body class="animsition">
    
    <% 
        String username = (String) session.getAttribute("username");
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
                        
                        <form action="ProcessPaymentServlet" method="POST" onsubmit="return validateAll();">
                            <div class="p-t-30 p-b-40 m-lr-0-xl p-lr-15-sm">
                                <label>Payment Method:</label>
                                <select name="method" id="method" onchange="showFields()" class="bor19 size-218 m-b-20" style="padding:10px; width:600px" required>
                                      <option value="">-- Choose a Payment Method --</option>
                                      <option value="Cash">Cash On Delivery</option>
                                      <option value="CreditCard">Credit Card</option>
                                      <option value="OnlineBanking">Online Banking</option>
                                      <option value="E-Wallet">E-Wallet</option>
                                    </select>
                                <br/><br/>
                                
                                <div id="cashFields" style="display:none;">
                                    <ul>
                                        <li>RULES OF COD :</LI><br/>
                                        <li>1. Will never ask for any down payment before processing your order.</li>
                                        <li>2. Never send or deposit money through wire transfers or personal bank accounts.</li>
                                        <li>3. Full payment must only be given to the delivery agent upon the delivery of your item.</li>
                                        <li>4. Only pay the amount specified in the Air Waybill stuck in the pouch or box of the item</li>
                                    </ul>
                                </div>
                                
                    <!--=============== credit card ==================-->
                                <div id="creditFields" style="display:none;">
                                    <table style="width: 100%">
                                        <tr>
                                            <td rowspan="4">
                                                <img id="creditCardImage" src="images/icons/creditcard.png" alt="Credit Card"/>
                                            </td>
                                            <td>
                                                <label>Card Holder Name:</label> 
                                                <input type="text" id="cardName" name="card_name" maxlength="20" class="bor19" style="padding: 10px; width:500px"/>
                                                <span class="error" id="nameError" style="color:red;"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><br/>
                                                <label>Card Number:</label> 
                                                <input type="text" id="cardNumber" name="card_number" maxlength="19" readonly class="bor19" style="padding: 10px; width:500px"/>
                                                <span class="error" id="cardError" style="color:red;"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><br/>
                                                <label>Expiration Date:</label> 
                                                <input type="month" id="expDate" name="exp_date" readonly class="bor19" style="padding: 10px; width:500px" />
                                                <span class="error" id="dateError" style="color:red;"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><br/>
                                                <label>Card Verification Value (CVV):</label> 
                                                <input type="text" id="cvv" name="cvv" maxlength="3" readonly class="bor19" style="padding: 10px; width:500px" />
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
                                                <img src="images/icons/bankcard.png" id="creditCardImage" alt="Credit Card" width='550px' style='border-radius: 50px'/>
                                            </td>
                                            <td>
                                                <label>Bank Name:</label>
                                                <select name="bank" id="bank" class="bor19 size-218" style="padding:10px; width:600px">
                                                  <option value="">-- Choose a Online Banking --</option>
                                                  <option value="AmBank">Am Bank</option>
                                                  <option value="CIMB">CIMB Bank</option>
                                                  <option value="HongLeong">Hong Leong Bank</option>
                                                  <option value="MayBank">MayBank</option>
                                                  <option value="OCBC">OCBC Bank</option>
                                                  <option value="Public">Public Bank</option>
                                                  <option value="RHB">RHB Bank</option>
                                                  <option value="UOB">UOB Bank</option>
                                                </select><br/>
                                                <span id="bankSelectError" class="error"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><br/>
                                                <label>Account Name:</label> 
                                                <input type="text" name="acc_name" id="bankAccName" readonly maxlength="20" class="bor19" style="padding: 10px; width:500px" />
                                                <span class="error" id="bankNameError" style="color:red;"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><br/>
                                                <label>Account Number:</label> 
                                                <input type="text" name="acc_number" id="bankAccNumber" readonly maxlength="12" class="bor19" style="padding: 10px; width:500px"/>
                                                <span class="error" id="bankNumberError" style="color:red;"></span>
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
                                                <select name="e-wallet" id="e-wallet" class="bor19 size-218" style="padding:10px; width:600px">
                                                    <option value="">-- Choose a E-Wallet --</option>
                                                    <option value="Boost">Boost</option>
                                                    <option value="GrabPay">GrabPay</option>
                                                    <option value="TouchNGo">Touch'n Go</option>
                                                    <option value="ShopeePay">ShopeePay</option>
                                                </select><br/>
                                                <span id="walletSelectError" class="error"></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td><br/>
                                                <label>Phone Number:</label> 
                                                <input type="text" name="pho_number" id="phoneInput" readonly maxlength="11" class="bor19" style="padding: 10px; width:500px"/>
                                                <span class="error" id="phoneError" style="color:red;"></span>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <input type="hidden" name="amount" value="<%= String.format("%.2f", grandtotal) %>" />
                                <input type="hidden" name="user_id" value="<%= username %>" />

                                <br/><br/>
                                <div id="finalError" class="error" style="margin-top:10px; color: red"></div><br/>
                                <div id="successMessage" style="color:green; font-weight:bold; margin-top:10px;"></div>
                                <button type="submit" class="flex-c-m stext-101 cl0 size-116 bg3 bor14 hov-btn3 p-lr-15 trans-04 pointer">
                                    Pay
                                </button>
                                
                                <br/><br/>   
                            </div> 
                        </form>
                    </div>
                </div>
        </section>	
	
     <%@ include file="footer.jsp"%>
        
    <script>
        function showFields() {
            // Hide all initially
            document.getElementById("cashFields").style.display = "none";
            document.getElementById("creditFields").style.display = "none";
            document.getElementById("bankingFields").style.display = "none";
            document.getElementById("ewalletFields").style.display = "none";

            // Disable all inputs first
            cardNumber.readOnly = true;
            expDate.readOnly = true;
            cvv.readOnly = true;
            bankAccName.readOnly = true;
            bankAccNumber.readOnly = true;
            phoneInput.readOnly = true;

            var method = document.getElementById("method").value;

            // Enable and show only the selected method’s fields
            if (method === "CreditCard") {
                document.getElementById("creditFields").style.display = "block";
                cardNumber.readOnly = false;
                expDate.readOnly = false;
                cvv.readOnly = false;
            } else if (method === "OnlineBanking") {
                document.getElementById("bankingFields").style.display = "block";
                bankAccName.readOnly = false;
                bankAccNumber.readOnly = false;
            } else if (method === "E-Wallet") {
                document.getElementById("ewalletFields").style.display = "block";
                phoneInput.readOnly = false;
            }else{
                document.getElementById("cashFields").style.display = "block";
            }
        }

    </script>

    <script>
     const cardName = document.getElementById("cardName");
     const cardNumber = document.getElementById("cardNumber");
     const expDate = document.getElementById("expDate");
     const cvv = document.getElementById("cvv");
     const bankSelect = document.getElementById("bank");
     const bankAccName = document.getElementById("bankAccName");
     const bankAccNumber = document.getElementById("bankAccNumber");
     const walletSelect = document.getElementById("e-wallet");
     const phoneInput = document.getElementById("phoneInput");

     const nameError = document.getElementById("nameError");
     const cardError = document.getElementById("cardError");
     const dateError = document.getElementById("dateError");
     const cvvError = document.getElementById("cvvError");
     const bankSelectError = document.getElementById("bankSelectError");
     const bankNameError = document.getElementById("bankNameError");
     const bankNumberError = document.getElementById("bankNumberError");
     const walletSelectError = document.getElementById("walletSelectError");
     const phoneError = document.getElementById("phoneError");

     // Step 1: Name validation
     cardName.addEventListener("input", () => {
       const value = cardName.value.trim();
       if (/^[A-Za-z ]+$/.test(value)) {
         nameError.textContent = "";
         cardNumber.readOnly = false;
       } else {
         nameError.textContent = "Only letters and spaces allowed.";
         cardNumber.readOnly = true;
         expDate.readOnly = true;
         cvv.readOnly = true;
       }
     });

     // Step 2: Card number validation and formatting
     cardNumber.addEventListener("input", () => {
       let raw = cardNumber.value.replace(/\D/g, "").slice(0, 16);
       cardNumber.value = raw.replace(/(.{4})/g, "$1 ").trim();

       if (raw.length === 16) {
         cardError.textContent = "";
         expDate.readOnly = false;
       } else {
         cardError.textContent = "Card number must be 16 digits.";
         expDate.readOnly = true;
         cvv.readOnly = true;
       }
     });

     // Step 3: Expiration date
     expDate.addEventListener("input", () => {
       const selectedDate = new Date(expDate.value + "-01");
       const today = new Date();

       if (selectedDate > today) {
         dateError.textContent = "";
         cvv.readOnly = false;
       } else {
         dateError.textContent = "Card is expired.";
         cvv.readOnly = true;
       }
     });

     // Step 4: CVV validation
     cvv.addEventListener("input", () => {
       if (/^\d{3}$/.test(cvv.value)) {
         cvvError.textContent = "";
       } else {
         cvvError.textContent = "Enter a valid 3-digit CVV.";
       }
     });

     bankSelect.addEventListener("change", () => {
       if (bankSelect.value === "") {
         bankSelectError.textContent = "Please select a bank.";
         bankAccName.readOnly = true;
         bankAccName.value = "";
         bankNameError.textContent = "";
         bankAccNumber.value = "";
         bankAccNumber.readOnly = true;
         bankNumberError.textContent = "";
       } else {
         bankSelectError.textContent = "";
         bankAccName.readOnly = false;
       }
     });

     bankAccName.addEventListener("input", () => {
       const val = bankAccName.value.trim();
       if (/^[A-Za-z\s]{1,20}$/.test(val)) {
         bankNameError.textContent = "";
         bankAccNumber.readOnly = false;
       } else {
         bankNameError.textContent = "Only letters and spaces allowed.";
         bankAccNumber.readOnly = true;
         bankAccNumber.value = "";
         bankNumberError.textContent = "";
       }
     });

     bankAccNumber.addEventListener("input", () => {
       const val = bankAccNumber.value.trim();
       if (/^\d{10,12}$/.test(val)) {
         bankNumberError.textContent = "";
       } else {
         bankNumberError.textContent = "Account number must be 10–12 digits.";
       }
     });

     walletSelect.addEventListener("change", () => {
       if (walletSelect.value === "") {
         walletSelectError.textContent = "Please select a wallet type.";
         phoneInput.readOnly = true;
         phoneInput.value = "";
         phoneError.textContent = "";
       } else {
         walletSelectError.textContent = "";
         phoneInput.readOnly = false;
       }
     });

     phoneInput.addEventListener("input", () => {
       const val = phoneInput.value.trim();
       if (/^\d{10,11}$/.test(val)) {
         phoneError.textContent = "";
       } else {
         phoneError.textContent = "Phone number must be 10-11 digits.";
       }
     });
   </script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const cvvInput = document.getElementById("cvv");
            const creditImage = document.getElementById("creditCardImage");

            cvvInput.addEventListener("focus", function () {
                creditImage.src = "images/icons/cvv.png";
            });

            cvvInput.addEventListener("blur", function () {
                creditImage.src = "images/icons/creditcard.png";
            });
        });
    </script>

    <script>
        function validateAll() {
            const finalError = document.getElementById("finalError");
            const successMessage = document.getElementById("successMessage");
            finalError.textContent = "";
            successMessage.textContent = "";

            let isValid = true;

            const selectedMethod = document.getElementById("method").value;

            if (selectedMethod === "CreditCard") {
              if (!/^[A-Za-z ]+$/.test(cardName.value.trim())) isValid = false;
              if (!/^\d{16}$/.test(cardNumber.value.replace(/\s/g, ""))) isValid = false;
              if (new Date(expDate.value + "-01") <= new Date()) isValid = false;
              if (!/^\d{3}$/.test(cvv.value)) isValid = false;
            } 
            else if (selectedMethod === "OnlineBanking") {
              if (bankSelect.value === "") isValid = false;
              if (!/^[A-Za-z ]{1,20}$/.test(bankAccName.value.trim())) isValid = false;
              if (!/^\d{10,12}$/.test(bankAccNumber.value.trim())) isValid = false;
            } 
            else if (selectedMethod === "E-Wallet") {
              if (walletSelect.value === "") isValid = false;
              if (!/^\d{10,11}$/.test(phoneInput.value.trim())) isValid = false;
            } 
            else if (selectedMethod === "Cash") {
              // Cash doesn't require validation
              isValid = true;
            } 
            else {
              isValid = false; // No method selected
            }

            if (!isValid) {
              finalError.textContent = "❌ Please fill in correct info or complete all required fields.";
              return false;
            }

            return true;
          }

    </script>    


</body>
</html>
