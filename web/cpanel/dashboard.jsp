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

      function random_rgba(i) {
        let temp = [];

        for(let j=0; j < i; j++){
          var o = Math.round, r = Math.random, s = 255;
          temp.push("rgba(" + o(r()*s) + "," + o(r()*s) + "," + o(r()*s) + ",1)");
        }
        return temp;
      }


      let clientsCounter = document.getElementsByClassName("counters_clients")[0].children[1];
      let ordersCounter = document.getElementsByClassName("counters_totalOrders")[0].children[1];
      let newsCounter = document.getElementsByClassName("counters_newsletter")[0].children[1];

      let incomePerMonthChart = document
              .getElementById("incomePerMonthChart")
              .getContext("2d");
      let ordersPerMonthChart = document
              .getElementById("ordersPerMonthChart")
              .getContext("2d");
      let productsCountChart = document
              .getElementById("productsCountChart")
              .getContext("2d");



      let url = '/GetDashboardData';
      let dbData;

      var req = new XMLHttpRequest();
      req.overrideMimeType("application/json");
      req.open('GET', url, false);
      req.onload  = function() {
        var resp = JSON.parse(req.responseText);
          dbData = resp;
          console.log("Inside:");
        console.log(resp);
      };
      req.send(null);

      console.log("Outside: ");
      console.log(dbData);

      clientsCounter.innerHTML = dbData["counters"][0]["value"];
      ordersCounter.innerHTML = dbData["counters"][1]["value"];
      newsCounter.innerHTML = dbData["counters"][2]["value"];

      let incomeChart = new Chart(incomePerMonthChart, {
        type: "line",
        data: {
          labels: dbData["months"],
          datasets: [
            {
              label: "Przychód w PLN",
              data: dbData["incomePerMonth"],
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
          labels: dbData["months"],
          datasets: [
            {
              label: "Ilość zamówień",
              data: dbData["ordersPerMonth"],
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
          labels: dbData["categories"],
          datasets: [
            {
              data: dbData["productsQty"],
              backgroundColor: random_rgba(dbData["categories"].length),
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
