package kompix.product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteCategory")
public class DeleteCategory extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryID = request.getParameter("id");
        int status = 0;

        String DELETE_CATEGORY_SQL = "DELETE FROM categories WHERE id_category=?";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(DELETE_CATEGORY_SQL);
            preparedStatement.setInt(1, Integer.parseInt(categoryID));

            System.out.println(preparedStatement);

            status = preparedStatement.executeUpdate();



            response.sendRedirect("/cpanel/categories.jsp");
            conn.close();


        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }
    }
}
