package kompix.product;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

@WebServlet("/CategoryAdd")
public class CategoryAdd extends HttpServlet {
    private String category;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.category=request.getParameter("productCategory");
        String icon = request.getParameter("categoryIcon");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            Statement st = conn.createStatement();

            st.executeUpdate("insert into categories(category_name, category_icon)values('" + this.category + "', '"+ icon +"');");
            response.sendRedirect("/cpanel/categories.jsp");
            conn.close();
        } catch (Exception e) {
            System.out.print(e);
            e.printStackTrace();
        }


        }

    }


