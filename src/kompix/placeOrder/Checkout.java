package kompix.placeOrder;

import com.google.gson.Gson;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/Checkout")
public class Checkout extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        JSONParser parser = new JSONParser();

        try {
            Object s = parser.parse(request.getParameter("objarray"));
            JSONArray array = (JSONArray)s;
            Object email = parser.parse(request.getParameter("user_email"));
            Object ship = parser.parse(request.getParameter("ship_method"));
            Object cost = parser.parse(request.getParameter("priceAmount"));

            Gson gson = new Gson();

            Order[] order = new Order[array.size()];

            for(int i=0; i < array.size(); i++){
                order[i] = gson.fromJson(array.get(i).toString(), Order.class);
            }

            String emailValue = email.toString();
            String shipMethod = ship.toString();
            String costValue = cost.toString();

            CheckoutDao check = new CheckoutDao();
            IDs ids = check.getIDs(emailValue, shipMethod);
            long orderID = check.createOrder(costValue, ids);

            for(Order ord : order){
                long prodID = check.getProductID(ord.name);
                check.createOrderProducts(ord, orderID, prodID);
            }


        } catch (ParseException e) {
            e.printStackTrace();
        }


//            Gson gson = new Gson();
//
//            Object shit = request.getParameter("objarray");
//
//
//           // Order order = gson.fromJson(shit, Order.class);
//
//        System.out.println("Shit: "+shit);
//      //      System.out.println("Order name: "+order.name);
    }
}
