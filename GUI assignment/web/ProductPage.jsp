<%-- 
    Document   : Product page
    Created on : 13 Mar 2025, 2:43:36 pm
    Author     : tanan
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="UTF-8">
        <link rel="stylesheet" href="Product.css"/>
        <title>Book Loom</title>
    </head>
    <body>
        <!-- Search Bar -->
        <div style="text-align: center; position: relative;">
            <form action="SearchServlet" method="GET">
                <input class="search-bar" type="text" name="search" placeholder="Search Book" 
                       style="width: 400px; height: 40px; border: 3px solid black; border-radius: 50px; padding:0px 30px 0px 30px">
                &nbsp;&nbsp;
                <input type="image" src="image/search.png" alt="Search" width="40" height="40" style="position: absolute; bottom: 5px"/>
            </form>
        </div>
        
        <div style="margin-top: 60px; text-align: center;border-bottom: 2px solid black; padding-bottom: 10px">
        <button class="tablink" onclick="openProduct('english')" id="defaultOpen">English Books</button>&nbsp;&nbsp;&nbsp;
        <button class="tablink" onclick="openProduct('melayu')">Buku Bahasa Melayu</button>&nbsp;&nbsp;&nbsp;
        <button class="tablink" onclick="openProduct('chinese')">Chinese Books</button>&nbsp;&nbsp;&nbsp;
        <button class="tablink" onclick="openProduct('revision')">Revision Books</button>&nbsp;&nbsp;&nbsp;
        <button class="tablink" onclick="openProduct('stationery')">Stationery</button>
        </div>
        
        <section style="text-align: center; margin: 0px 200px 100px 200px; ">
<!---------------------------------------------------------English Book---------------------------------------------------------------->
        <div id="english" class="bookContent" >
            <div>
                <img src="image/engbook1.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">LEAVING 9 TO 5</button><br/>
                <p>Price : <b>RM 25.00</b></p>
            </div>
            <div>
                <img src="image/engbook2.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">THE RAINFALL MARKET</button><br/>
                <p>Price : <b>RM 97.50</b></p>
            </div>
            <div>
                <img src="image/engbook6.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">LISTEN FOR THE LIE</button><br/>
                <p>Price : <b>RM 62.50</b></p>
            </div>
            <div>
                <img src="image/engbook4.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">STRANGE PICTURES</button><br/>
                <p>Price : <b>RM 69.95</b></p>
            </div>
            <div>
                <img src="image/engbook7.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">MY LIFE AS A MEME</button><br/>
                <p>Price : <b>RM 49.50</b></p>
            </div>
            <div>
                <img src="image/engbook5.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">THE DEBUTANTES</button><br/>
                <p>Price : <b>RM 75.50</b></p>
            </div>
            <div>
                <img src="image/engbook3.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">FINDING BEAUTY IN THE STORM</button><br/>
                <p>Price : <b>RM 28.00</b></p>
            </div>
            <div>
                <img src="image/engbook8.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">KOKKO AND MAY COMICS COLLECTION 19</button><br/>
                <p>Price : <b>RM 17.50</b></p>
            </div>
        </div>
<!---------------------------------------------------------Malay Book---------------------------------------------------------------->
        <div id="melayu" class="bookContent">
          <div>
                <img src="image/malaybook1.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">SISAKAN AKU WAKTU</button><br/>
                <p>Price : <b>RM 37.00</b></p>
            </div>
            <div>
                <img src="image/malaybook2.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">50 KISAH MISTIK - KUTUKAN ROH</button><br/>
                <p>Price : <b>RM 12.90</b></p>
            </div>
            <div>
                <img src="image/malaybook3.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">HIKAYAT CINTA DUA DUNIA</button><br/>
                <p>Price : <b>RM 30.00</b></p>
            </div>
            <div>
                <img src="image/malaybook4.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">LOST IN REVENGE</button><br/>
                <p>Price : <b>RM 30.00</b></p>
            </div>
            <div>
                <img src="image/malaybook5.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">HEAD WITH SERBAN (EDISI KEMAS KINI)</button><br/>
                <p>Price : <b>RM 18.00</b></p>
            </div>
            <div>
                <img src="image/malaybook6.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">SPY X FAMILY 12 (EKSKLUSIF DI POPULAR)</button><br/>
                <p>Price : <b>RM 14.40</b></p>
            </div>
            <div>
                <img src="image/malaybook7.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">DVS02 : CHOIR DIVA</button><br/>
                <p>Price : <b>RM 12.60</b></p>
            </div>
            <div>
                <img src="image/malaybook8.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">BUKU HAIWAN & ALAM SEMULA JADI SOALAN & JAWAPAN</button><br/>
                <p>Price : <b>RM 34.90</b></p>
            </div>
        </div>

<!---------------------------------------------------------Chinese Book---------------------------------------------------------------->
        <div id="chinese" class="bookContent">
            <div>
                <img src="image/chibook1.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">特殊傳說Ⅲ vol.10</button><br/>
                <p>Price : <b>RM 42.00</b></p>
            </div>
            <div>
                <img src="image/chibook2.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">心境，决定的处境（畅销10周年纪念版）</button><br/>
                <p>Price : <b>RM 36.00</b></p>
            </div>
            <div>
                <img src="image/chibook3.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">你想為誰賺錢？：破解3大金錢謎團，怎麼思考錢，決定怎樣的未來</button><br/>
                <p>Price : <b>RM 63.00</b></p>
            </div>
            <div>
                <img src="image/chibook4.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">X探险特工队 万兽之王系列 IV：怒海冲袭</button><br/>
                <p>Price : <b>RM 16.00</b></p>
            </div>
            <div>
                <img src="image/chibook5.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">愛學習的孩子最喜歡看的世界童話(新版)</button><br/>
                <p>Price : <b>RM 29.90</b></p>
            </div>
            <div>
                <img src="image/chibook6.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">沉默的艦隊 新裝版(11)</button><br/>
                <p>Price : <b>RM 54.00</b></p>
            </div>
            <div>
                <img src="image/chibook7.jpg" width="200" height="200"/><br/>
                <button class="bookContentBtn" onclick="openPopup()">【漫畫版】別再勉強自己！不必節食的瘦身哲學</button><br/>
                <p>Price : <b>RM 58.00</b></p>
            </div>
        </div>
<!---------------------------------------------------------Revision Book---------------------------------------------------------------->
        <div id="revision" class="bookContent">
          <h3>revision</h3>
          <p>Who we are and what we do.</p>
        </div>
        
        <div id="stationery" class="bookContent">
          <h3>stationery</h3>
          <p>Who we are and what we do.</p>
        </div>
        </section>
            
    <script>
        function openProduct(productName) {
          var i, bookContent, tablink;
          bookContent = document.getElementsByClassName("bookContent");
          for (i = 0; i < bookContent.length; i++) {
            bookContent[i].style.display = "none";
          }
          tablink = document.getElementsByClassName("tablink");
          for (i = 0; i < tablink.length; i++) {
            tablink[i].style.backgroundColor = "";
          }
          document.getElementById(productName).style.display = "block";

        }

        // Get the element with id="defaultOpen" and click on it
        document.getElementById("defaultOpen").click();
    </script>
    <script>
        function openPopup() {
            // Open a Java Swing JFrame by running the Java program using a servlet
            window.open("engBook1", "_blank", "width=400,height=300");
}   </script>


    </body>
</html>


