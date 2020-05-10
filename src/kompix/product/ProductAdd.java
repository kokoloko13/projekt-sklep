package kompix.product;

import kompix.UserAddress.model.Address;
import kompix.register.model.NewUser;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/ProductAdd")
public class ProductAdd extends HttpServlet {
    String category;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        category=request.getParameter("category");

            RequestDispatcher rd = getServletContext().getRequestDispatcher("/category.jsp");
            PrintWriter out= response.getWriter();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            Statement st = conn.createStatement();

            st.executeUpdate("insert into categories(category_name)values('" + category + "')");
            conn.close();
        } catch (Exception e) {
            System.out.print(e);
            e.printStackTrace();
        }
            rd.include(request, response);


        }

    }


