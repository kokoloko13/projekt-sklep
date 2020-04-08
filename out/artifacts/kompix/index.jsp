<%-- Created by IntelliJ IDEA. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title></title>
  </head>
  <body>
  <iframe name="votar" style="display:none;"></iframe>
  <form action="Adding" method="POST" target="votar">
    1st Number: <input type="text" name="a">
    2nd Number: <input type="text" name="b">
    <input type="submit" value="Sum!">
  </form>
  </body>
</html>