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
    <title>Kompix cPanel | Kategorie</title>
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
            <li class="active">
              <a href="#" class="nav-item">
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
            <li>
              <a href="ship.jsp" class="nav-item">
                <i class="fas fa-truck"></i>
                Dostawa
              </a>
            </li>
          </ul>
        </div>
        <div class="right">
          <div class="categories">
            <div class="categories_header">
              <div class="categories_header_id">Nr.</div>
              <div class="categories_header_name">Nazwa kategorii</div>
              <div class="categories_header_mng">Opcje</div>
            </div>

            <div class="categories_items">
              <div class="category">
                <div class="category_id">1</div>
                <div class="category_name">Komputery stacjonarne</div>
                <div class="category_icon">fa fas-icon</div>
                <div class="category_mng">
                  <i class="fas fa-edit edit_Flag" title="Edytuj Kategorię"></i>
                  <i class="fas fa-trash-alt remove_Flag" title="Usuń Kategorię"></i>
                </div>
              </div>

              <div class="category">
                <div class="category_id">2</div>
                <div class="category_name">Telefony</div>
                <div class="category_icon">fa fas-icon</div>
                <div class="category_mng">
                  <i class="fas fa-edit edit_Flag" title="Edytuj Kategorię"></i>
                  <i class="fas fa-trash-alt remove_Flag" title="Usuń Kategorię"></i>
                </div>
              </div>

              <div class="category">
                <div class="category_id">3</div>
                <div class="category_name">Laptopy i tablety</div>
                <div class="category_icon">fa fas-icon</div>
                <div class="category_mng">
                  <i class="fas fa-edit edit_Flag" title="Edytuj Kategorię"></i>
                  <i class="fas fa-trash-alt remove_Flag" title="Usuń Kategorię"></i>
                </div>
              </div>

              <div class="category">
                <div class="category_id">4</div>
                <div class="category_name">Urządzenia peryferyjne</div>
                <div class="category_icon">fa fas-icon</div>
                <div class="category_mng">
                  <i class="fas fa-edit edit_Flag" title="Edytuj Kategorię"></i>
                  <i class="fas fa-trash-alt remove_Flag" title="Usuń Kategorię"></i>
                </div>
              </div>

              <div class="category">
                <div class="category_id">5</div>
                <div class="category_name">Podzespoły komputerowy</div>
                <div class="category_icon">fa fas-icon</div>
                <div class="category_mng">
                  <i class="fas fa-edit edit_Flag" title="Edytuj Kategorię"></i>
                  <i class="fas fa-trash-alt remove_Flag" title="Usuń Kategorię"></i>
                </div>
              </div>

              <div class="category">
                <div class="category_id">6</div>
                <div class="category_name">Gaming</div>
                <div class="category_icon">fa fas-icon</div>
                <div class="category_mng">
                  <i class="fas fa-edit edit_Flag" title="Edytuj Kategorię"></i>
                  <i class="fas fa-trash-alt remove_Flag" title="Usuń Kategorię"></i>
                </div>
              </div>
            </div>
            <div class="addCategory">
              <p>Dodaj nową kategorię</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Remove Category Modal -->
      <div id="removeModal">
        <div class="modalBody">
          <p>
            Czy chcesz usunąć kategorię</br> <span class="removeCategoryName"
              >X</span
            > ?
          </p>
        </div>
        <div class="removeModalChoice">
          <p id="removeCancel">Nie</p>
          <p id="removeYes">Tak</p>
        </div>
      </div>

      <!-- Change Category Modal -->
      <div id="editModal">
          <div class="modalHeader">
            <p>Nr.</p>
            <p>Nazwa</p>
            <p>Ikona</p>
          </div>
          <div class="modalBody">
            <form action="/editCategory" method="POST">
                   <div class="inputs">
                    <input type="text" value="2" disabled>
                    <input type="text" value="Telefony" required>
                    <input type="text" value="fas fa-mobile" required>
                   </div>
                <div class="buttons">
                    <p class="editCancel">Anuluj</p>
                    <p class="editCommit">Zapisz</p>
                </div>
                </form>
          </div>
      </div>

      <!-- Add New Category Modal -->
      <div id="addCategoryModal">
        <div class="modalHeader">
            <p>Nazwa</p>
            <p>Ikona</p>
          </div>
          <div class="modalBody">
          <form action="/CategoryAdd" method="POST">
            <div class="inputs">
                <input
            type="text"
            name="productCategory"
            placeholder="Nazwa Kategorii"
            required
            />
            <input type="text" name="categoryIcon" placeholder="Ikona kategorii" required>
            </div>
            <div class="buttons">
                <p class="addCategoryCancel">Anuluj</p>
                <p class="addCategorySubmit">Dodaj</p>
            </div>
        </form>
      </div>
      </div>
    </div>
    <script src="../js/categories.js"></script>
    <script src="../js/logout.js"></script>
  </body>
</html>
