<%@ page import="java.util.Calendar" %>
<%@ page import="java.sql.*" %>
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
  if(user_email == null){
    response.sendRedirect("logowanie.jsp");
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
    <title>Sklep komputerowy Kompix | Konto</title>
  </head>
  <body>
    <div class="container">
      <!-- Navbar -->
      <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                         url="jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                         user="root"  password=""/>

      <sql:query dataSource="${db}" var="data">
        SELECT * FROM users, address WHERE user_email='<% out.print(user_email); %>';
      </sql:query>
      <nav>
        <div class="navbar">
          <div class="navbar_toggle">
            <i class="fas fa-bars"></i>
          </div>
          <div class="logo">
            <a href="/index.jsp"><p>Kompix</p></a>
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
            <div class="profile-signed">
              <i class="fas fa-user"></i>
              <c:forEach var="dataRow" items="${data.rows}">
                <c:set var = "name" scope = "session" value = "${dataRow.user_email.substring(0, dataRow.user_email.indexOf('@'))}"/>
                <c:choose>
                  <c:when test="${name.equals('None')}">
                    <p>Witaj, <br /><c:out value="${'name'}"/></p>
                  </c:when>
                  <c:when test="${!name.equals('None')}">
                    <p>Witaj, <br /><c:out value="${dataRow.first_name}"/></p>
                  </c:when>
                </c:choose>
              </c:forEach>
            </div>
            <div class="shopping_cart">
              <a href="/koszyk.jsp"><i class="fas fa-shopping-cart"><span class="cart_badge">0</span></i></a>
            </div>
          </div>
          <div class="nav_categories">
            <i class="fas fa-times nav_exit_mobile_menu"></i>
            <ul>
              <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                                 url="jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                                 user="root"  password=""/>

              <sql:query dataSource="${db}" var="rs">
                SELECT * from categories;
              </sql:query>
              <c:forEach var="categories" items="${rs.rows}">
                <li>
                  <a href="#">
                    <div class="nav_category_item">
                      <i class="${categories.category_icon}"></i>
                      <p>${categories.category_name}</p>
                    </div>
                  </a>
                </li>
              </c:forEach>
            </ul>
          </div>
        </div>
      </nav>



      <!-- Login / Register -->
      <div class="account">
        <div class="account_category">
          <ul>
            <li class="account_category_element active">
              <button onclick="window.location.hash = '#konto';">Konto</button>
            </li>
            <li class="account_category_element">
              <button onclick="window.location.hash = '#zmiana-danych';">
                Zmiana danych
              </button>
            </li>
            <li class="account_category_element">
              <button onclick="window.location.hash = '#zamowienia';">
                Twoje zamówienia
              </button>
            </li>
            <li class="account_category_element">
              <button onclick="window.location.hash = '#zmiana-hasla';">
                Zmień hasło
              </button>
            </li>
          </ul>
        </div>
        <c:forEach var="dataRow" items="${data.rows}">
        <div class="account_content">

          <div class="account_content_personal_data" style="display: none;">
            <div class="account_content_personal_data_element">
              <h2>Imię i nazwisko:</h2>
              <p>${dataRow.first_name} ${dataRow.last_name}</p>
            </div>
            <div class="account_content_personal_data_element">
              <h2>Adres / ulica:</h2>
              <p>${dataRow.street}</p>
            </div>
            <div class="account_content_personal_data_element">
              <div>
                <h2>Kod pocztowy:</h2>
                <p>${dataRow.zipcode}</p>
              </div>
              <div>
                <h2>Miasto:</h2>
                <p>${dataRow.city}</p>
              </div>
            </div>
            <div class="account_content_personal_data_element">
              <h2>Telefon kontaktowy:</h2>
              <p>${dataRow.user_phone}</p>
            </div>
            <div class="account_content_personal_data_element">
              <h2>Adres e-mail:</h2>
              <p>${dataRow.user_email}</p>
            </div>
          </div>
          <div
            class="account_content_personal_data_change"
            style="display: none;"
          >
            <form action="/ChangeData" method="post">
              <div class="input">
                <p>Imię</p>
                <input type="text" name="clientName" placeholder="${dataRow.first_name}"/>
              </div>
              <div class="input">
                <p>Nazwisko</p>
                <input type="text" name="clientLastname" placeholder="${dataRow.last_name}"/>
              </div>
              <div class="input">
                <p>Adres / ulica</p>
                <input type="text" name="clientStreet" placeholder="${dataRow.street}"/>
              </div>
              <div class="input_zip">
                <p>Kod pocztowy:</p>
                <input type="text" name="clientZip" placeholder="${dataRow.zipcode}"/>
              </div>
              <div class="input_city">
                <p>Miasto</p>
                <input type="text" name="clientCity" placeholder="${dataRow.city}"/>
              </div>
              <div class="input">
                <p>Telefon kontaktowy:</p>
                <input type="tel" name="clientPhone" placeholder="${dataRow.user_phone}"/>
              </div>
              <div class="input">
                <p>Adres e-mail:</p>
                <input type="email" name="clientEmail" placeholder="${dataRow.user_email}"/>
              </div>
              <button type="submit">Zmień dane</button>
            </form>
          </div>
          <div class="account_content_password_change" style="display: none;">
            <form action="/ChangePasswd" method="post">
              <div class="input">
                <p>Aktualne hasło:</p>
                <input type="password" name="clientCurrPasswd" />
              </div>
              <div class="input">
                <p>Nowe hasło:</p>
                <input type="password" name="clientNewPasswd1" />
              </div>
              <div class="input">
                <p>Powtórz nowe hasło:</p>
                <input type="password" name="clientNewPasswd2" />
              </div>
              <button type="submit">Zmień hasło</button>
            </form>
          </div>
          <div class="account_content_orders">
            <div class="account_content_orders_header">
              <div class="account_content_orders_header_number">
                <p>Numer<br />zamówienia</p>
              </div>
              <div class="account_content_orders_header_date">
                <p>Data<br />zamówienia</p>
              </div>
              <div class="account_content_orders_header_status">
                <p>Status<br />zamówienia</p>
              </div>
              <div class="account_content_orders_header_delivery-payment">
                <p>
                  Dostawa
                </p>
              </div>
              <div class="account_content_orders_header_tracking">
                <p>Śledzenie<br />zamówienia</p>
              </div>
              <div class="account_content_orders_header_cost">
                <p>Wartość</p>
              </div>
              <div class="account_content_orders_header_document">
                <p>Faktura</p>
              </div>
            </div>
            <div class="account_content_orders_list">
              <sql:setDataSource var="db2" driver="com.mysql.jdbc.Driver"
                                 url="jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                                 user="root"  password=""/>

              <sql:query dataSource="${db2}" var="rs2">
                SELECT
                *
                FROM
                orders AS o
                INNER JOIN
                users AS u
                ON
                o.id_user = u.id_user
                INNER JOIN
                ship AS s
                ON
                o.id_ship = s.id_ship
                INNER JOIN
                status AS st
                ON o.order_status = st.id_status
                WHERE
                u.user_email = '<% out.print(user_email); %>';
              </sql:query>

              <c:forEach var="orders" items="${rs2.rows}">
                <div class="account_content_orders_list_order">
                  <div class="account_content_orders_list_order_header">
                    <p class="header">Numer<br />zamówienia</p>
                    <p>${orders.order_num}</p>
                    <i class="fas fa-chevron-down"></i>
                  </div>
                  <div class="account_content_orders_list_order_element">
                    <p class="header">Data<br />zamówienia</p>
                    <c:set var = "orderDate" scope = "session" value = "${orders.order_date.toString().substring(0, 10)}"/>
                    <p>${orderDate}</p>
                  </div>
                  <div class="account_content_orders_list_order_element">
                    <p class="header">Status</p>
                    <p>${orders.status_name}</p>
                  </div>
                  <div class="account_content_orders_list_order_element">
                    <p class="header">Dostawa</p>
                    <p>${orders.ship_method_long}</p>
                  </div>
                  <div class="account_content_orders_list_order_element">
                    <p class="header">Śledzenie</p>
                    <p><a href="${orders.tracking}"><i class="fas fa-search-location"></i></a></p>
                  </div>
                  <div class="account_content_orders_list_order_element">
                    <p class="header">Wartość</p>
                    <p>
                      <span class="price">${orders.total_price}</span>
                      <span class="currency">PLN</span>
                    </p>
                  </div>
                  <div class="account_content_orders_list_order_element">
                    <p class="header">Faktura</p>
                    <p><a href="${orders.vat}"><i class="fas fa-file-invoice-dollar"></i></a></p>
                  </div>
                </div>
              </c:forEach>
            </div>
          </div>
        </div>
        </c:forEach>
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
    <script src="js/animate.js"></script>
    <script src="js/acc.js"></script>
    <script src="js/script.js"></script>
  </body>
</html>