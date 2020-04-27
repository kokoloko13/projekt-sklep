<%@ page import="java.util.Calendar" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Sklep komputerowy Kompix | Strona Główna</title>
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

      <!-- Alert -->
      <div class="alert">
        <p class="alertMessage">
          Produkt <span class="productAlertName">Macbook Pro 15"</span> został
          dodany do koszyka.
        </p>
        <i class="fas fa-times"></i>
      </div>

      <!-- Steals-->
      <div class="steals">
        <div class="breaker">
          <div class="breaker_title"><h2>Okazje</h2></div>
          <div class="breaker_line"></div>
        </div>
        <div class="products">
          <i class="fas fa-chevron-left"></i>

          <% for(int i=0; i < 5; i++){ %>

          <div class="product">
            <div class="product_thumb">
              <img src="images/thumb.png" alt="Product Thumbnail" />
            </div>
            <div class="product_title"><a href="#">Macbook Pro 15"</a></div>
            <div class="product_priceAndControl">
              <div class="product_price">
                <span class="price">7399.00</span>
                <span class="currency">PLN</span>
              </div>
              <div class="product_control">
                <i class="fas fa-cart-plus"></i>
              </div>
            </div>
          </div>

          <% } %>

          <i class="fas fa-chevron-right"></i>
          <div class="showMore">
            <a href="#"><button>Pokaż więcej</button></a>
          </div>
        </div>
      </div>

      <!-- News -->
      <div class="new_products">
        <div class="breaker">
          <div class="breaker_title"><h2>Nowości</h2></div>
          <div class="breaker_line"></div>
        </div>
        <div class="products">
          <i class="fas fa-chevron-left"></i>

          <% for(int i=0; i < 5; i++){ %>

          <div class="product">
            <div class="product_thumb">
              <img src="images/thumb.png" alt="Product Thumbnail" />
            </div>
            <div class="product_title"><a href="#">Macbook Pro 15"</a></div>
            <div class="product_priceAndControl">
              <div class="product_price">
                <span class="price">7399.00</span>
                <span class="currency">PLN</span>
              </div>
              <div class="product_control">
                <i class="fas fa-cart-plus"></i>
              </div>
            </div>
          </div>

          <% } %>

          <i class="fas fa-chevron-right"></i>
          <div class="showMore">
            <a href="#"><button>Pokaż więcej</button></a>
          </div>
        </div>
      </div>

      <!-- Newsletter -->
      <div class="newsletter">
        <div class="newsletter_left">
          <div class="newsletter_left_img">
            <i class="far fa-envelope-open"></i>
          </div>
          <div class="newsletter_left_title">
            <h2>Newsletter</h2>
          </div>
        </div>
        <div class="newsletter_right">
          <div class="newsletter_right_info">
            <p>Nie przegap żadnej promocji, zdobywaj dodatkowe rabaty.</p>
          </div>
          <form action="/Newsletter" method="post">
            <input
              type="email"
              name="newsletter_email"
              id="newsletter_email"
              placeholder="Twój e-mail"
            />
            <button type="submit">Zapisz się</button>
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
    <script src="js/alert.js"></script>
    <script src="js/script.js"></script>
    <script src="js/addCart.js"></script>
  </body>
</html>
