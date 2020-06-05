<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%
  String admin_email = null;
  Cookie[] cookies = request.getCookies();

  if(cookies != null){
    for(Cookie cookie : cookies){
      if(cookie.getName().equals("admin_email")) admin_email = cookie.getValue();
    }
  }
  if(admin_email == null){
    response.sendRedirect("/cpanel/admin-login.jsp");
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
    <!-- Font Awesome -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.0-2/css/all.min.css"
    />
    <!-- CSS -->
    <link rel="stylesheet" href="../css/cpanel.css" />
    <title>Kompix cPanel | Produkty</title>
  </head>
  <body>
    <div class="container">
      <div class="top-bar">
        <div class="logo"><a href="../index.jsp">Kompix</a></div>
        <div class="user">
          <p>Użytkownik: Admin</p>
          <p id="logout">Wyloguj</p>
        </div>
      </div>
      <div class="mainContent">
        <div class="left">
          <ul class="nav">
            <li>
              <a href="dashboard.jsp" class="nav-item">
                <i class="fas fa-tachometer-alt"></i>
                Dashboard
              </a>
            </li>
            <li>
              <a href="categories.jsp" class="nav-item">
                <i class="fas fa-folder-open"></i>
                Kategorie
              </a>
            </li>
            <li class="active">
              <a href="#" class="nav-item">
                <i class="fas fa-barcode"></i>
                Produkty
              </a>
            </li>
            <li>
              <a href="orders.jsp" class="nav-item">
                <i class="fas fa-dollar-sign"></i>
                Zamówienia
              </a>
            </li>
            <li>
              <a href="ship.jsp" class="nav-item">
                <i class="fas fa-truck"></i>
                Dostawa
              </a>
            </li>
          </ul>
        </div>
        <div class="right">
          <div class="products">
            <div class="products_filters">
              <label for="1">
                <input type="checkbox" name="Komputery stacjonarne" id="1" />
                Komputery stacjonarne
              </label>
              <label for="2">
                <input type="checkbox" name="Telefony" id="2" />
                Telefony
              </label>
              <label for="3">
                <input type="checkbox" name="Laptopy i tablety" id="3" />
                Laptopy i tablety
              </label>
              <label for="4">
                <input type="checkbox" name="Urządzenia peryferyjne" id="4" />
                Urządzenia peryferyjne
              </label>
              <label for="5">
                <input type="checkbox" name="Gaming" id="5" />
                Gaming
              </label>
              <label for="6">
                <input type="checkbox" name="Podzespoły komputerowy" id="6" />
                Podzespoły komputerowy
              </label>
            </div>

            <div class="products_header">
              <div class="products_header_id">Nr.</div>
              <div class="products_header_name">Nazwa</div>
              <div class="products_header_category">Kategoria</div>
              <div class="products_header_qty">Ilość</div>
              <div class="products_header_price">Cena</div>
              <div class="products_header_mng">Opcje</div>
            </div>

            <div class="products_items">
              <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
                                 url="jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                                 user="root"  password=""/>

              <sql:query dataSource="${db}" var="rs">
                SELECT * FROM products, categories WHERE products.id_category = categories.id_category;
              </sql:query>
              <c:forEach var="product" items="${rs.rows}">
                <div class="product">
                  <div class="product_id">${product.id_products}</div>
                  <div class="product_name">${product.product_name}</div>
                  <div class="product_category">${product.category_name}</div>
                  <div class="product_qty">${product.amount}</div>
                  <div class="product_price">${product.price}</div>
                  <div class="product_mng">
                    <i class="fas fa-trash-alt remove_Flag" title="Usuń produkt"></i>
                  </div>
                </div>
              </c:forEach>

            </div>
            <div class="addProduct">
              <p>Dodaj nowy produkt</p>
            </div>
          </div>
        </div>
      </div>


      <!-- Remove ship Modal -->
      <div id="removeModal">
        <div class="modalBody">
          <p>
            Czy chcesz usunąć produkt</br> <span class="removeProductName">X</span> ?</p>
        </div>
        <div class="removeModalChoice">
          <p id="removeCancel">Nie</p>
          <p id="removeYes">Tak</p>
        </div>
      </div>

<!-- Add New ship Modal -->
      <div id="addProductModal">
          <div class="modalBody">
            <form action="/ProductAdd" method="post" enctype="multipart/form-data">
                <div class="files_container">
                    <div class="fileContainer big">
                        <input type="file" name="file1" required />
                        <i class="fas fa-plus"></i>
                        <span class="uploadMessage">Kliknij aby dodać zdjęcie</span>
                        <img src="" alt="Image1 Priview" class="file1_preview" />
                    </div>
                </div>
                <div class="inputs_container">
                    <input
                            type="text"
                            name="productName"
                            placeholder="Nazwa produktu"
                            required
                    />
                    <input
                            type="text"
                            name="productAmount"
                            placeholder="Ilość"
                            required
                    />
                            <select name="productCategory">
                              <sql:query dataSource="${db}" var="cat">
                                SELECT * FROM categories;
                              </sql:query>
                              <c:forEach var="category" items="${cat.rows}">
                                <option value="${category.id_category}">${category.category_name}</option>>
                              </c:forEach>
                            </select>
                    <div class="productPrice_container">
                        <input
                                type="text"
                                name="productPrice"
                                placeholder="Cena"
                                required
                        />
                        <span class="addCurrency">PLN</span>
                    </div>
                </div>
                <textarea
                name="productDesc"
                cols="30"
                rows="10"
                placeholder="Opis produktu"
                required
        ></textarea>
                <div class="modalButtons">
                    <p>Dodaj produkt</p>
                    <p>Anuluj</p>
                </div>
            </form>
      </div>
      </div>
    </div>
    <script src="../js/products.js"></script>
    <script src="../js/addProduct.js"></script>
    <script src="../js/logout.js"></script>
  </body>
</html>
