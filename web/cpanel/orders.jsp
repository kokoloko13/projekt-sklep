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
    <title>Kompix cPanel | Zamówienia</title>
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
            <li>
              <a href="products.jsp" class="nav-item">
                <i class="fas fa-barcode"></i>
                Produkty
              </a>
            </li>
            <li class="active">
              <a href="#" class="nav-item">
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
          <div class="orders">
            <div class="orders_header">
              <div class="orders_header_id">Numer:</div>
              <div class="orders_header_name">Data:</div>
              <div class="orders_header_name">Status:</div>
              <div class="orders_header_mng">Opcje</div>
            </div>

            <div class="orders_items">
              <div class="order">
                <div class="order_id">22</div>
                <div class="order_num">1590809686</div>
                <div class="order_date">2020-05-27</div>
                <div class="order_status">Oczekiwanie na zapłatę</div>
                <div class="order_vat">ordersPDF/1590809686.pdf</div>
                <div class="order_ship">Kurier DPD</div>
                <div class="order_tracking">tracking_url</div>
                <div class="order_mng">
                  <i
                    class="fas fa-edit edit_Flag"
                    title="Edytuj zamówienie"
                  ></i>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Change ship Modal -->
      <div id="editOrderModal">
        <div class="modalBody">
          <form action="/EditOrder" method="POST">
            <div class="inputs">
              <div>
                <p>ID:</p>
                <input type="text" value="22" disabled />
              </div>
              <div>
                <p>Numer zamówienia:</p>
                <input type="text" value="1590809686" disabled />
              </div>
              <div>
                <p>Klient:</p>
                <input type="text" value="Imie Nazwisko" disabled />
              </div>
              <div>
                <p>Data złożenia:</p>
                <input type="text" value="2020-05-27" disabled />
              </div>
              <div>
                <p>Status:</p>
                <select id="stats" name="status" required>
                  <option value="1" selected>Oczekiwanie na zapłatę</option>
                  <option value="2">Przesyłka nieodebrana</option>
                  <option value="3">Anulowane</option>
                  <option value="4">W trakcie realizacji</option>
                  <option value="5">Wysłane</option>
                  <option value="6">Odebrane</option>
                </select>
              </div>
              <div>
                <p>Wartość:</p>
                <input type="text" value="13335.00" disabled />
              </div>
              <div>
                <p>Faktura:</p>
                <input type="text" value="VAT" disabled />
              </div>
              <div>
                <p>Metoda dostawy:</p>
                <input type="text" value="SHIP" disabled />
              </div>
              <div>
                <p>Tracking:</p>
                <input type="text" value="TRACKING" required />
              </div>
            </div>
            <div class="buttons">
              <p class="editCancel">Anuluj</p>
              <p class="editCommit">Zapisz</p>
            </div>
          </form>
        </div>
      </div>
    </div>
    <script src="../js/orders.js"></script>
    <script src="../js/logout.js"></script>
  </body>
</html>
