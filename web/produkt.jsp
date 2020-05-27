<%@ page import="java.util.Calendar" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>Sklep komputerowy Kompix | ${param['prod']}</title>
</head>
<body>
<div class="container">
    <!-- Navbar -->
    <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                       user="root"  password=""/>

    <sql:query dataSource="${db}" var="rs">
        SELECT * from categories;
    </sql:query>
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
                <div class="profile-signin">
                    <a href="<% if(user_email == null){
                out.print("/logowanie.jsp");
                    }else{
                    out.print("/konto.jsp");
                    }%>"><i class="fas fa-user"></i></a>
                </div>
                <div class="shopping_cart">
                    <a href="/koszyk.jsp"><i class="fas fa-shopping-cart"><span class="cart_badge">0</span></i></a>
                </div>
            </div>
            <div class="nav_categories">
                <i class="fas fa-times nav_exit_mobile_menu"></i>
                <ul>
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

    <!-- Alert -->
    <div class="alert">
        <p class="alertMessage">
            Produkt <span class="productAlertName">Macbook Pro 15"</span> został
            dodany do koszyka.
        </p>
        <i class="fas fa-times"></i>
    </div>

    <!-- product_page-->
    <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                       url="jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                       user="root"  password=""/>

    <sql:query dataSource="${db}" var="prods">
        SELECT
        *
        FROM
        products
        WHERE
        id_products=${param['prod']};
    </sql:query>

    <c:forEach var="product" items="${prods.rows}">
        <div class="breaker">
            <div class="breaker_title"><h2>${product.product_name}</h2></div>
            <div class="breaker_line"></div>
        </div>

                <div class="product_page_instance">
                    <div class="product_thumb">
                        <img src="data:image/jpeg;base64,${Base64.getEncoder().encodeToString(product.photo1)}" alt="${product.product_name} Thumbnail" />
                    </div>
                    <div class="product_title"><a href="#">${product.product_name}</a></div>
                    <div class="product_priceAndControl">
                        <div class="product_price">
                            <span class="price">${product.price}</span>
                            <span class="currency">PLN</span>
                        </div>
                        <div class="product_control">
                            <i class="fas fa-cart-plus"></i>
                        </div>
                    </div>
                </div>

    </c:forEach>

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
