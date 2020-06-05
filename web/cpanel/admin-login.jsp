<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
  String admin_email = null;
  Cookie[] cookies = request.getCookies();

  if(cookies != null){
    for(Cookie cookie : cookies){
      if(cookie.getName().equals("admin_email")) admin_email = cookie.getValue();
    }
  }
  if(admin_email != null){
    response.sendRedirect("/cpanel/dashboard.jsp");
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
    <!-- CSS -->
    <link rel="stylesheet" href="../css/cpanel.css" />
    <title>Kompix cPanel | Logowanie</title>
  </head>
  <body>
    <div class="container">
      <div class="cpanelLogin">
        <div class="cpanelLoginBox">
          <h3>
            Logowanie do cPanelu</br> sklepu <span class="shopName">Kompix</span>
          </h3>
          <form action="/AdminLogin" method="post">
            <input type="email" name="adminLogin" placeholder="Login" required/>
            <input type="password" name="adminPass" placeholder="Hasło" required/>
            <button type="submit" style="cursor: pointer; margin: 0 auto; width: 50%; background: none; padding: .5rem 1rem; color: #34495E; border: 1px solid #34495E; border-radius: 10px">Zaloguj</button>
          </form>
        </div>
      </div>
    </div>
  </body>
</html>
