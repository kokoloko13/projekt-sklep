<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
  String user_email = null;
  Cookie[] cookies = request.getCookies();
  if(cookies != null){
    for(Cookie cookie : cookies){
      if(cookie.getName().equals("user_email")) user_email = cookie.getValue();
    }
  }
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!-- Fonts -->
    <link
      href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap"
      rel="stylesheet"
    />
    <link
      href="https://fonts.googleapis.com/css2?family=Comic+Neue:ital@1&display=swap"
      rel="stylesheet"
    />
    <!-- Fontawesome -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
    />
    <!-- Animate css -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css"
    />
    <!-- Style -->
    <link rel="stylesheet" href="css/style.css" />
    <!-- Title -->
    <title>Sklep komputerowy Kompix | Koszyk</title>
  </head>
  <body>
    <div class="container">
      <!-- Navbar -->
      <nav>
        <div class="navbar">
          <div class="navbar_toggle">
            <i class="fas fa-bars"></i>
          </div>
          <div class="logo">
            <a href="index.jsp"><p>Kompix</p></a>
          </div>
          <div class="search">
            <form action="/Search" class="searchForm" method="GET">
              <input
                type="text"
                name="search"
                id="searchField"
                placeholder="Czego szukasz?"
              />
              <button type="submit"><i class="fas fa-search"></i></button>
            </form>
          </div>
          <div class="profile_cart">
            <div class="profile-signin">
              <a href="<% if(user_email == null){
                out.print("/logowanie.jsp");
              }else{
                out.print("/konto.jsp");
              }%>"><i class="fas fa-user"></i></a>
            </div>
            <div class="shopping_cart">
              <i class="fas fa-shopping-cart"
                ><span class="cart_badge">0</span></i
              >
            </div>
          </div>
          <div class="nav_categories">
            <i class="fas fa-times nav_exit_mobile_menu"></i>
            <ul>
              <li>
                <a href="#">
                  <div class="nav_category_item">
                    <i class="fas fa-desktop"></i>
                    <p>Komputery stacjonarne</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="#">
                  <div class="nav_category_item">
                    <i class="fas fa-mobile"></i>
                    <p>Telefony</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="#">
                  <div class="nav_category_item">
                    <i class="fas fa-laptop"></i>
                    <p>Laptopy i tablety</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="#">
                  <div class="nav_category_item">
                    <i class="fas fa-keyboard"></i>
                    <p>Urządzenia peryferyjne</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="#">
                  <div class="nav_category_item">
                    <i class="fas fa-microchip"></i>
                    <p>Podzespoły komputerowe</p>
                  </div>
                </a>
              </li>
              <li>
                <a href="#">
                  <div class="nav_category_item">
                    <i class="fas fa-gamepad"></i>
                    <p>Gaming</p>
                  </div>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </nav>

      <!-- Checkout -->
      <div class="cart">
        <div class="cart_step">
          <div class="cart_step_content">
            <div class="cart_step_content_header">
              <h2>Koszyk (<span id="cartCount">0</span>)</h2>
            </div>
            <div class="cart_step_content_list">
              <ul class="product_list"></ul>
            </div>
          </div>
          <div class="cart_step_info">
            <p>Kod rabatowy:</p>
            <div class="cartCode">
              <form action="" method="post">
                <input type="text" id="cartCode" />
                <button>Aktywuj</button>
              </form>
            </div>
            <div class="cartDelivery">

              <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                                 url="jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                                 user="root"  password=""/>

              <sql:query dataSource="${db}" var="rs">
                SELECT * from ship;
              </sql:query>

              <p>Sposób dostawy:</p>
              <select name="delivery" id="delivery">
                <c:forEach var="ship" items="${rs.rows}">
                  <option value="${ship.ship_method_short}">${ship.ship_method_long} | ${ship.ship_price}PLN</option>
                </c:forEach>
              </select>
            </div>
            <hr />
            <div class="cart_summary">
              <div class="cart_summary_code">
                <p>Rabat:</p>
                <p>
                  <span class="cart_summary_code_value">0</span>
                </p>
              </div>
              <div class="cart_summary_delivery">
                <p>Dostawa:</p>
                <p>
                  <span class="cart_summary_delivery_value">0</span>
                  <span class="currency">PLN</span>
                </p>
              </div>
              <div class="cart_summary_cartCost">
                <p>Wartość<br />koszyka</p>
                <p>
                  <span class="cart_summary_cartCost_value">0</span>
                  <span class="currency">PLN</span>
                </p>
              </div>
              <div class="cart_summary_cost">
                <p>Łącznie:</p>
                <p>
                  <span class="cart_summary_cost_value">0</span>
                  <span class="currency">PLN</span>
                </p>
              </div>
            </div>
            <div class="checkoutButton">
              <p>Przejdź do płatności</p>
            </div>
          </div>
        </div>
        <div class="cart_step">
          <div class="cart_step_thankyou">
            <h2>Dziękujemy za dokonanie zakupu.</h2>
            <p>
              Potwierdzenie wraz z fakturą zakupu zostało wysłane na twój adres
              e-mail przypisany do konta.
            </p>
            <p>
              Informacje dotyczące zamówienia możesz sprawdzić także na swoim
              <a href="konto.html#zamowienia">koncie</a>.
            </p>
            <a class="thankyou_back" href="/index.html">Powrót</a>
          </div>
        </div>
      </div>

      <!-- Footer -->
      <footer>
        <div class="footer">
          <div class="footer_links">
            <div class="footer_links_element">
              <p>Zamówienia</p>
              <ul>
                <li><a href="#">Dostawa</a></li>
                <li><a href="#">Płatności</a></li>
                <li><a href="#">Ubezpieczenia</a></li>
                <li><a href="#">Zwroty i reklamacje</a></li>
                <li><a href="#">Najczęsciej zadawane pytania</a></li>
              </ul>
            </div>
            <div class="footer_links_element">
              <p>Kompix</p>
              <ul>
                <li><a href="#">O nas</a></li>
                <li><a href="#">Regulamin</a></li>
                <li><a href="#">Polityka prywatności</a></li>
                <li><a href="#">Kariera</a></li>
                <li><a href="#">Kontakt</a></li>
              </ul>
            </div>
            <div class="footer_links_element">
              <p>Kontakt</p>
              <ul>
                <li>
                  <div class="footer_links_element_item">
                    <i class="fas fa-phone-alt"></i>
                    <p><a href="tel:+48123456789">123 456 789</a></p>
                  </div>
                </li>
                <li>
                  <div class="footer_links_element_hours">
                    <p>pon. - pt. 8:00 - 21:00</p>
                    <p>sob. - nd. 8:00 - 19:00</p>
                  </div>
                </li>
                <li>
                  <div class="footer_links_element_item">
                    <i class="fas fa-envelope"></i>
                    <p><a href="#">biuro@kompix.pl</a></p>
                  </div>
                </li>
                <li>
                  <div class="footer_links_element_social">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                  </div>
                </li>
              </ul>
            </div>
          </div>
          <div class="footer_rights">
            <p>
              Kompix &copy;<%
               int year = Calendar.getInstance().get(Calendar.YEAR);
                  out.print((year == 2020) ? "2020" : "2020-"+year);
                %>.
              Wszelkie prawa zastrzeżone.
            </p>
          </div>
        </div>
      </footer>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="js/animate.js"></script>
    <script src="js/script.js"></script>
    <script src="js/cart.js"></script>
  </body>
</html>
