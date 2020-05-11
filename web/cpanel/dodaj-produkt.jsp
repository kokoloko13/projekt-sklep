<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
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
    <link rel="stylesheet" href="../css/style.css" />
    <!-- Title -->
    <title>Sklep komputerowy Kompix | Dodawanie produktu</title>
</head>
<body>
<div class="container">
    <!-- Add product -->
    <div class="add_product">
        <form action="/ProductAdd" method="post" enctype="multipart/form-data">
            <div class="files_container">
                <div class="fileContainer big">
                    <input type="file" name="file1" required />
                    <i class="fas fa-plus"></i>
                    <span class="uploadMessage">Kliknij aby dodać zdjęcie</span>
                    <img src="" alt="Image1 Priview" class="file1_preview" />
                </div>
                <div class="fileContainer small">
                    <input type="file" name="file2" />
                    <i class="fas fa-plus"></i>
                    <img src="" alt="Image2 Priview" class="file2_preview" />
                </div>
                <div class="fileContainer small">
                    <input type="file" name="file3" />
                    <i class="fas fa-plus"></i>
                    <img src="" alt="Image3 Priview" class="file3_preview" />
                </div>
                <div class="fileContainer small">
                    <input type="file" name="file4" />
                    <i class="fas fa-plus"></i>
                    <img src="" alt="Image4 Priview" class="file4_preview" />
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
                <div class="productPrice_container">
                <%! String driverName = "com.mysql.jdbc.Driver";%>
                <%!String url = "jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";%>
                <%!String user = "root";%>
                <%!String psw = "";%>
                <%
                    Connection con = null;
                    PreparedStatement ps = null;
                    try{
                        Class.forName(driverName);
                        con = DriverManager.getConnection(url,user,psw);
                        String sql = "SELECT * FROM categories";
                        ps = con.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                %>
                    <p>Kategoria:
                        <select name="productCategory">
                            <%
                                while(rs.next())
                                {
                                    String category = rs.getString("category_name");
                                    String id = rs.getString("id_category");
                            %>
                            <option value="<%=id %>"><%=category %></option>
                            <%
                                }
                            %>
                        </select>
                    </p>
                        <%
                        con.close();}
                        catch(SQLException sqe)
                        {
                            out.println(sqe);
                        }
                        %>
            </div>
                <div class="productPrice_container">
                    <input
                            type="text"
                            name="productPrice"
                            placeholder="Cena"
                            required
                    />
                    <span class="addCurrency">PLN</span>
                </div>
                <textarea
                        name="productDesc"
                        cols="30"
                        rows="10"
                        placeholder="Opis produktu"
                        required
                ></textarea>
            </div>
            <button type="submit">Dodaj produkt</button>
        </form>
    </div>
</div>
<script src="../js/addProduct.js"></script>
</body>
</html>
