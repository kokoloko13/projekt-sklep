package kompix.shipment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

@WebServlet("/AddShip")
public class AddShip extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String shipLong = request.getParameter("productShip");
        String shipShort = request.getParameter("shipShort");
        Double shipPrice = Double.parseDouble(request.getParameter("shipPrice"));

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            Statement st = conn.createStatement();

            st.executeUpdate("insert into ship(ship_method_short, ship_method_long, ship_price) values('" + shipShort + "', '"+ shipLong +"', "+ shipPrice +");");
            response.sendRedirect("/cpanel/ship.jsp");
            conn.close();
        } catch (Exception e) {
            System.out.print(e);
            e.printStackTrace();
        }
    }

}
