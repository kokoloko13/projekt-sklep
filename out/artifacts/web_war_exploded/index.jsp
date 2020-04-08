<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="pl">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>Sklep komputerowy | Kompix</title>
    <!--<style type="text/css">@import url("css/style.css");</style>-->
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css">
  </head>
  <body>
    <div class="container">
      <!-- NAVBAR -->
      <div class="navbar">
        <div class="logo">
          <p>Kompix</p>
        </div>
        <div class="search">
          <form action="/search">
            <input type="text" placeholder="Podaj szukaną frazę">
            <button type="submit"><i class="fas fa-search"></i></button>
          </form>
        </div>
        <div class="profile_cart">
          <i class="fas fa-user-alt"></i>
          <i class="fas fa-shopping-cart"></i>
        </div>
      </div>
    </div>
  </body>
</html>