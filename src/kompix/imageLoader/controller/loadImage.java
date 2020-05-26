package kompix.imageLoader.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;


@WebServlet("/loadImage")
public class loadImage extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int imageID = Integer.parseInt(request.getParameter("id"));

        String SELECT_IMAGE_SQL = "SELECT photo1 FROM products WHERE id_products=?;";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(SELECT_IMAGE_SQL);
            preparedStatement.setInt(1, imageID);


            System.out.println(preparedStatement);

            ResultSet rs = preparedStatement.executeQuery();


            if(rs.next() != false){
                conn.close();
            }else{
                conn.close();
            }

        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }

    }
    }
