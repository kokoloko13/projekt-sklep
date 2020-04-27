<%@ page import="java.util.Calendar" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
      <nav>
        <div class="navbar">
          <div class="navbar_toggle">
            <i class="fas fa-bars"></i>
          </div>
          <div class="logo">
            <a href="/index.html"><p>Kompix</p></a>
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
              <p>Witaj, imię</p>
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
        <div class="account_content">
          <div class="account_content_personal_data" style="display: none;">
            <div class="account_content_personal_data_element">
              <h2>Imię i nazwisko:</h2>
              <p>Jan Nowak</p>
            </div>
            <div class="account_content_personal_data_element">
              <h2>Adres / ulica:</h2>
              <p>Przykładowa 24/2</p>
            </div>
            <div class="account_content_personal_data_element">
              <div>
                <h2>Kod pocztowy:</h2>
                <p>00-000</p>
              </div>
              <div>
                <h2>Miasto:</h2>
                <p>Przykładno</p>
              </div>
            </div>
            <div class="account_content_personal_data_element">
              <h2>Telefon kontaktowy:</h2>
              <p>123456789</p>
            </div>
            <div class="account_content_personal_data_element">
              <h2>Adres e-mail:</h2>
              <p>jan.nowak@email.pl</p>
            </div>
          </div>
          <div
            class="account_content_personal_data_change"
            style="display: none;"
          >
            <form action="/ChangeData" method="post">
              <div class="input">
                <p>Imię</p>
                <input type="text" name="clientName" />
              </div>
              <div class="input">
                <p>Nazwisko</p>
                <input type="text" name="clientLastname" />
              </div>
              <div class="input">
                <p>Adres / ulica</p>
                <input type="text" name="clientStreet" />
              </div>
              <div class="input_zip">
                <p>Kod pocztowy:</p>
                <input type="text" name="clientZip" />
              </div>
              <div class="input_city">
                <p>Miasto</p>
                <input type="text" name="clientStreet" />
              </div>
              <div class="input">
                <p>Telefon kontaktowy:</p>
                <input type="tel" name="clientPhone" />
              </div>
              <div class="input">
                <p>Adres e-mail:</p>
                <input type="email" name="clientEmail" />
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
                  Dostawa,<br />
                  płatność
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
              <div class="account_content_orders_list_order">
                <div class="account_content_orders_list_order_header">
                  <p class="header">Numer<br />zamówienia</p>
                  <p>901811042815</p>
                  <i class="fas fa-chevron-down"></i>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Data<br />zamówienia</p>
                  <p>2020-04-15 17:43</p>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Status</p>
                  <p>Zakończone</p>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Dostawa,<br />płatność</p>
                  <p>Paczkomaty 24/7,<br />PayPal</p>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Śledzenie</p>
                  <p><i class="fas fa-search-location"></i></p>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Wartość</p>
                  <p>
                    <span class="price">43.92</span>
                    <span class="currency">PLN</span>
                  </p>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Faktura</p>
                  <p><i class="fas fa-file-invoice-dollar"></i></p>
                </div>
              </div>
              <div class="account_content_orders_list_order">
                <div class="account_content_orders_list_order_header">
                  <p class="header">Numer<br />zamówienia</p>
                  <p>901811042815</p>
                  <i class="fas fa-chevron-down"></i>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Data<br />zamówienia</p>
                  <p>2020-04-15 17:43</p>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Status</p>
                  <p>Zakończone</p>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Dostawa,<br />płatność</p>
                  <p>Paczkomaty 24/7,<br />PayPal</p>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Śledzenie</p>
                  <p><i class="fas fa-search-location"></i></p>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Wartość</p>
                  <p>
                    <span class="price">43.92</span>
                    <span class="currency">PLN</span>
                  </p>
                </div>
                <div class="account_content_orders_list_order_element">
                  <p class="header">Faktura</p>
                  <p><i class="fas fa-file-invoice-dollar"></i></p>
                </div>
              </div>
            </div>
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
    <script src="js/animate.js"></script>
    <script src="js/acc.js"></script>
    <script src="js/script.js"></script>
  </body>
</html>
