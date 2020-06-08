package kompix.shipment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteShip")
public class DeleteShip extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String shipID = request.getParameter("id");
        int status = 0;

        String DELETE_SHIP_SQL = "DELETE FROM ship WHERE id_ship=?";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(DELETE_SHIP_SQL);
            preparedStatement.setInt(1, Integer.parseInt(shipID));

            System.out.println(preparedStatement);

            status = preparedStatement.executeUpdate();



            response.sendRedirect("/cpanel/ship.jsp");
            conn.close();


        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }
    }
}
