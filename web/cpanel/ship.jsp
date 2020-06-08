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
    <title>Kompix cPanel | Dostawy</title>
  </head>
  <body>
    <div class="container">
      <div class="top-bar">
        <div class="logo"><a href="../index.jsp">Kompix</a></div>
        <div class="user">
          <p>Użytkownik: <%if(admin_email != null){out.print(admin_email.substring(0, admin_email.indexOf('@')));}%></p>
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
            <li>
              <a href="products.jsp" class="nav-item">
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
            <li class="active">
              <a href="#" class="nav-item">
                <i class="fas fa-truck"></i>
                Dostawa
              </a>
            </li>
          </ul>
        </div>
        <div class="right">
          <div class="ships">
            <div class="ships_header">
              <div class="ships_header_id">Nr.</div>
              <div class="ships_header_name">Nazwa sposobu dostawy</div>
              <div class="ships_header_name">Cena</div>
              <div class="ships_header_mng">Opcje</div>
            </div>

            <div class="ships_items">
<sql:setDataSource var="db2" driver="com.mysql.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"
                   user="root"  password=""/>

<sql:query dataSource="${db2}" var="rs2">
  SELECT * FROM ship;
</sql:query>

<c:forEach var="ship" items="${rs2.rows}">

              <div class="ship">
                <div class="ship_id">${ship.id_ship}</div>
                <div class="ship_name">${ship.ship_method_long}</div>
                <div class="ship_shortship">${ship.ship_method_short}</div>
                <div class="ship_price">${ship.ship_price}</div>
                <div class="ship_mng">
                  <i class="fas fa-edit edit_Flag" title="Edytuj sposób dostawy"></i>
                  <i class="fas fa-trash-alt remove_Flag" title="Usuń sposób dostawy"></i>
                </div>
              </div>
  </c:forEach>

            </div>
            <div class="addShip">
              <p>Dodaj nowy sposób dostawy</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Remove ship Modal -->
      <div id="removeModal">
        <div class="modalBody">
          <p>
            Czy chcesz usunąć </br><span class="removeShipName"
              >X</span
            > ?
          </p>
        </div>
        <div class="removeModalChoice">
          <p id="removeCancel">Nie</p>
          <p id="removeYes">Tak</p>
        </div>
      </div>

      <!-- Change ship Modal -->
      <div id="editModal">
          <div class="modalHeader">
            <p>Nr.</p>
            <p>Nazwa</p>
            <p>Skrót</p>
            <p>Cena</p>
          </div>
          <div class="modalBody">
            <form action="/EditShip" method="POST">
                   <div class="inputs">
                    <input type="text" value="2" name="shipID" readonly>
                    <input type="text" value="Kurier DHL" name="shipLong" required>
                    <input type="text" value="DHL" name="shipShort" required>
                    <input type="text" value="10.00" name="shipPrice" required>
                   </div>
                <div class="buttons">
                    <p class="editCancel">Anuluj</p>
                    <p class="editCommit">Zapisz</p>
                </div>
                </form>
          </div>
      </div>

      <!-- Add New ship Modal -->
      <div id="addShipModal">
        <div class="modalHeader">
            <p>Nazwa</p>
            <p>Skrót</p>
            <p>Cena</p>
          </div>
          <div class="modalBody">
          <form action="/AddShip" method="POST">
            <div class="inputs">
                <input
            type="text"
            name="productShip"
            placeholder="Nazwa sposobu dostawy"
            required
            />
            <input type="text" name="shipShort" placeholder="Skrót nazwy" required>
            <div>
                <input type="text" name="shipPrice" placeholder="00.00" style="width: 60%;">
            </div>
        </div>
            <div class="buttons">
                <p class="addShipCancel">Anuluj</p>
                <p class="addShipSubmit">Dodaj</p>
            </div>
        </form>
      </div>
      </div>
    </div>
    <script src="../js/ships.js"></script>
    <script src="../js/logoutAdmin.js"></script>
  </body>
</html>
