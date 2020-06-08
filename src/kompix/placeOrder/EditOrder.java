package kompix.placeOrder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Enumeration;

@WebServlet("/EditOrder")
public class EditOrder extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {



        int orderID = Integer.parseInt(request.getParameter("orderID"));
        int orderStatus = Integer.parseInt(request.getParameter("status"));
        String tracking = request.getParameter("orderTrack");
        int status = 0;

        String EDIT_ORDER_SQL = "UPDATE orders SET order_status=?, tracking=? WHERE id_order=?";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(EDIT_ORDER_SQL);
            preparedStatement.setInt(1, orderStatus);
            preparedStatement.setString(2, tracking);
            preparedStatement.setInt(3, orderID);

            System.out.println(preparedStatement);

            status = preparedStatement.executeUpdate();


            response.sendRedirect("/cpanel/orders.jsp");
            conn.close();


        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }
    }
}
