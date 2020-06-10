<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
  int bad_credentials = 0;
  String user_email = null;
  String register_info = null;

  Cookie[] cookies = request.getCookies();
  if(cookies != null){
    for(Cookie cookie : cookies){
      if(cookie.getName().equals("user_email")) user_email = cookie.getValue();
      if(cookie.getName().equals("bad_credentials")) bad_credentials = 1;
      if(cookie.getName().equals("register_info")) register_info = cookie.getValue();
    }
  }
  if(user_email != null){
    response.sendRedirect("/index.jsp");
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
  <title>Sklep komputerowy Kompix | Logowanie</title>
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
        <form action="/szukaj.jsp" class="searchForm" method="GET">
          <input
                  type="text"
                  name="q"
                  id="searchField"
                  placeholder="Czego szukasz?"
          />
          <button type="submit"><i class="fas fa-search"></i></button>
        </form>
      </div>
      <div class="profile_cart">
        <div
                class="profile-signin"
                style="opacity: 0.2; pointer-events: none;"
        >
          <i class="fas fa-user"></i>
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
          <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                             url="jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                             user="root"  password=""/>

          <sql:query dataSource="${db}" var="rs">
            SELECT * from categories;
          </sql:query>
          <c:forEach var="categories" items="${rs.rows}">
            <li>
              <a href="/produkty.jsp?category=${categories.category_name}">
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
  <div class="login_page">
    <div class="login_page_login">
      <form action="/Login" method="post">
        <h2>Klient</h2>
        <div class="input">
          <p>Adres E-mail</p>
          <input
                  type="email"
                  name="login"
                  required
                  oninvalid="this.setCustomValidity('To pole jest wymagane!')"
                  oninput="this.setCustomValidity('')"
          />
        </div>
        <div class="input">
          <p>Hasło</p>
          <input
                  type="password"
                  name="passwd"
                  required
                  oninvalid="this.setCustomValidity('To pole jest wymagane!')"
                  oninput="this.setCustomValidity('')"
                  minlength="8"
          />
          <%
            if(bad_credentials != 0){
              out.write("<p style=\"color: red;\">Nieprawidłowy login lub hasło</p>");
            }
          %>
        </div>
        <div class="checks">
          <label>
            <input type="checkbox" name="stayLogged" />
            <p>
              Nie wylogowuj mnie.
            </p>
          </label>
        </div>
        <button type="submit">Zaloguj się</button>
      </form>
    </div>
    <div class="login_breaker">
      <hr class="hr-text" data-content="Nie masz konta?" />
    </div>
    <div class="login_page_register">
      <form action="/Register" method="post" onsubmit="compareInputs();">
        <h2>Zostań klientem</h2>
        <div class="input">
          <p>Adres E-mail</p>
          <input
                  type="email"
                  name="login"
                  required
                  oninvalid="this.setCustomValidity('To pole jest wymagane!')"
                  oninput="this.setCustomValidity('')"
          />
        </div>
        <div class="input">
          <p>Hasło</p>
          <input
                  type="password"
                  name="passwd"
                  required
                  oninvalid="this.setCustomValidity('To pole jest wymagane!')"
                  oninput="this.setCustomValidity('')"
                  minlength="8"
          />
        </div>
        <div class="input">
          <p>Powtórz hasło</p>
          <input
                  type="password"
                  name="passwordAgain"
                  required
                  oninvalid="this.setCustomValidity('To pole jest wymagane!')"
                  oninput="this.setCustomValidity('')"
                  minlength="8"
          />
        </div>
        <%
            if (register_info != null) {
                if(register_info.equals("true")){
                  out.write("<div><p style=\"color: green;\">Konto zostało utworzone pomyślnie.</p></div>");
                }else if(register_info.equals("false")){
                    out.write("<div><p style=\"color: red;\">Konto nie zostało utworzone. Użytkownik o takim adresie e-mail już istnieje.</p></div>");
                }
            }
        %>
        <div class="checks">
          <label>
            <input
                    type="checkbox"
                    name="rulesAccepted"
                    value="True"
                    required
                    oninvalid="this.setCustomValidity('To pole jest wymagane!')"
                    oninput="this.setCustomValidity('')"
            />
            <p>
              Akceptuje
              <a href="#">regulamin</a> sklepu.
            </p>
          </label>
          <label>
            <input type="checkbox" name="newsletterAccepted" value="True"/>
            <p>
              Chcę otrzymywać newsletter.
            </p>
          </label>
        </div>
        <button type="submit">Załóż konto</button>
      </form>
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
<script src="js/animate.js"></script>
<script src="js/script.js"></script>
<script src="js/comparePass.js"></script>
</body>
</html>