package kompix.product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteProduct")
public class DeleteProduct extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userID = request.getParameter("id");
        int status = 0;

        String DELETE_PRODUCT_SQL = "DELETE FROM products WHERE id_products=?";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(DELETE_PRODUCT_SQL);
            preparedStatement.setInt(1, Integer.parseInt(userID));

            System.out.println(preparedStatement);

            status = preparedStatement.executeUpdate();


            response.sendRedirect("/cpanel/products.jsp");
            conn.close();


        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }
    }
}
