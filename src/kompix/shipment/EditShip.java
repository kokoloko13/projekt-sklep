package kompix.shipment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/EditShip")
public class EditShip extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String shipID = request.getParameter("shipID");
        String shipLong = request.getParameter("shipLong");
        String shipShort = request.getParameter("shipShort");
        String shipPrice = request.getParameter("shipPrice");
        int status = 0;

        String EDIT_SHIP_SQL = "UPDATE ship SET ship_method_short=?, ship_method_long=?, ship_price=? WHERE id_ship=?";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(EDIT_SHIP_SQL);
            preparedStatement.setString(1, shipShort);
            preparedStatement.setString(2, shipLong);
            preparedStatement.setDouble(3, Double.parseDouble(shipPrice));
            preparedStatement.setInt(4, Integer.parseInt(shipID));

            System.out.println(preparedStatement);

            status = preparedStatement.executeUpdate();


            response.sendRedirect("/cpanel/ship.jsp");
            conn.close();


        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }
    }
}
