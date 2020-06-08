package kompix.product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/EditCategory")
public class EditCategory extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryIDstring = request.getParameter("category_id");
        String categoryNewName = request.getParameter("category_newName");
        String categoryNewIcon = request.getParameter("category_newIcon");
        int status = 0;

        String EDIT_CATEGORY_SQL = "UPDATE categories SET category_name=?, category_icon=? WHERE id_category=?";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(EDIT_CATEGORY_SQL);
            preparedStatement.setString(1, categoryNewName);
            preparedStatement.setString(2, categoryNewIcon);
            preparedStatement.setInt(3, Integer.parseInt(categoryIDstring));

            System.out.println(preparedStatement);

            status = preparedStatement.executeUpdate();


            response.sendRedirect("/cpanel/categories.jsp");
            conn.close();


        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }

    }
}
