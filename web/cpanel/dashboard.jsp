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
    response.sendRedirect("/cpanel/admin-login.html");
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
    <!-- Chart.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>
    <title>Kompix cPanel | Dashboard</title>
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
            <li class="active">
              <a href="#" class="nav-item">
                <i class="fas fa-tachometer-alt"></i>
                Dashboard
              </a>
            </li>
            <li class="nav-item">
              <a href="categories.jsp">
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
          <div class="counters">
            <div class="counters_clients">
              <h2>Klientów:</h2>
              <h3>204</h3>
            </div>
            <div class="counters_totalOrders">
              <h2>Złożonych zamówień:</h2>
              <h3>351</h3>
            </div>
            <div class="counters_newsletter">
              <h2>Zgód na newsletter:</h2>
              <h3>79</h3>
            </div>
          </div>

          <div class="charts">
            <div class="income_per_month">
              <h2>Przychód w danym miesiącu (2020r.):</h2>
              <canvas id="incomePerMonthChart"></canvas>
            </div>

            <div class="orders_per_month">
              <h2>Zamówień w danym miesiącu (2020r.):</h2>
              <canvas id="ordersPerMonthChart"></canvas>
            </div>

            <div class="products_count">
              <h2>Ilość produktów:</h2>
              <canvas id="productsCountChart"></canvas>
            </div>
          </div>
        </div>
      </div>
    </div>

    <script>
      let incomePerMonthChart = document
        .getElementById("incomePerMonthChart")
        .getContext("2d");
      let ordersPerMonthChart = document
        .getElementById("ordersPerMonthChart")
        .getContext("2d");
      let productsCountChart = document
        .getElementById("productsCountChart")
        .getContext("2d");

      let incomeChart = new Chart(incomePerMonthChart, {
        type: "line",
        data: {
          labels: [
            "Styczeń",
            "Luty",
            "Marzec",
            "Kwiecień",
            "Maj",
            "Czerwiec",
            "Lipiec",
            "Sierpień",
            "Wrzesień",
            "Październik",
            "Listopad",
            "Grudzień",
          ],
          datasets: [
            {
              label: "Przychód w PLN",
              data: [
                202404,
                2040422,
                105995,
                40404,
                133234,
                202404,
                2040422,
                105995,
                40404,
                133234,
                0,
                9999999,
              ],
              backgroundColor: "green",
            },
          ],
        },
        options: {
          scales: {
            yAxes: [
              {
                ticks: {
                  display: false,
                },
              },
            ],
          },
          legend: {
            display: false,
          },
        },
      });

      let ordersChart = new Chart(ordersPerMonthChart, {
        type: "line",
        data: {
          labels: [
            "Styczeń",
            "Luty",
            "Marzec",
            "Kwiecień",
            "Maj",
            "Czerwiec",
            "Lipiec",
            "Sierpień",
            "Wrzesień",
            "Październik",
            "Listopad",
            "Grudzień",
          ],
          datasets: [
            {
              label: "Ilość zamówień",
              data: [
                202,
                2040,
                10599,
                40404,
                133234,
                202404,
                2040422,
                105995,
                40404,
                133234,
                0,
                9999999,
              ],
              backgroundColor: "blue",
            },
          ],
        },
        options: {
          scales: {
            yAxes: [
              {
                ticks: {
                  display: false,
                },
              },
            ],
          },
          legend: {
            display: false,
          },
        },
      });

      let productsChart = new Chart(productsCountChart, {
        type: "pie",
        data: {
          labels: [
            "Komputery stacjonarne",
            "Telefony",
            "Laptopy i tablety",
            "Urządzenia peryferyjne",
            "Podzespoły komputerowy",
            "Gaming",
          ],
          datasets: [
            {
              data: [17, 32, 81, 173, 59, 27],
              backgroundColor: [
                "rgba(26, 188, 156, 1.0)",
                "rgba(39, 174, 96, 1.0)",
                "rgba(52, 152, 219, 1.0)",
                "rgba(155, 89, 182, 1.0)",
                "rgba(52, 73, 94, 1.0)",
                "rgba(231, 76, 60, 1.0)",
              ],
            },
          ],
        },
        options: {
          legend: {
            position: "right",
          },
        },
      });
    </script>
    <script src="../js/logout.js"></script>
  </body>
</html>
