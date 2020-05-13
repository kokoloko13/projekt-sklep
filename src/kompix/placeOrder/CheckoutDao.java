package kompix.placeOrder;

import java.sql.*;
import java.util.ArrayList;
import java.util.Random;

public class CheckoutDao {
    public long createOrder(String price, IDs ids){

        Random rand = new Random();

        long obtainedID = 0;

        int order_num = rand.nextInt((Integer.MAX_VALUE - 1111111111) + 1) + 1111111111;

        String INSERT_ORDER_SQL = "INSERT INTO orders(`order_num`, `id_user`, `order_status`, `total_price`, `id_ship`) "+
                    "VALUES(?,?,?,?,?);";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");



            PreparedStatement preparedStatement = conn.prepareStatement(INSERT_ORDER_SQL, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setInt(1, order_num);
            preparedStatement.setInt(2, ids.userID);
            preparedStatement.setInt(3,1);
            preparedStatement.setDouble(4, Double.parseDouble(price));
            preparedStatement.setInt(5, ids.shipID);


            System.out.println(preparedStatement);

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    obtainedID = generatedKeys.getLong(1);
                }
                else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }

            conn.close();
        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }

        return obtainedID;
    } // 2

    public IDs getIDs(String email, String ship){

        IDs ids = new IDs();

        String GET_USER_ID_SQL = "SELECT id_user FROM users WHERE user_email=?;";
        String GET_SHIP_ID_SQL = "SELECT id_ship FROM ship WHERE ship_method_short=?;";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            Connection conn2 = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");


            PreparedStatement preparedStatement = conn.prepareStatement(GET_USER_ID_SQL);
            preparedStatement.setString(1, email);

            PreparedStatement preparedStatement2 = conn2.prepareStatement(GET_SHIP_ID_SQL);
            preparedStatement2.setString(1, ship);



            ResultSet rs1 = preparedStatement.executeQuery();
            ResultSet rs2 = preparedStatement2.executeQuery();
            System.out.println(preparedStatement);
            System.out.println(preparedStatement2);



            if(rs1.next() != false){
                ids.userID = rs1.getInt("id_user");
                conn.close();
            }

            if(rs2.next() != false){
                ids.shipID = rs2.getInt("id_ship");
                conn2.close();
            }

            System.out.println("ids.user = " +ids.userID);
            System.out.println("ids.ship = " +ids.shipID);


        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }
        return ids;
    } // 1

    public boolean createOrderProducts(Order order, long orderID, long productID){
        String INSERT_ORDERPRODUCT_SQL = "INSERT INTO orderproduct(`id_order`, `id_product`, `qty`, `final_price`) "+
                "VALUES(?,?,?,?);";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");


                    PreparedStatement preparedStatement = conn.prepareStatement(INSERT_ORDERPRODUCT_SQL);
                    preparedStatement.setInt(1, (int)orderID);
                    preparedStatement.setInt(2, (int)productID);
                    preparedStatement.setInt(3,order.qty);
                    preparedStatement.setDouble(4, order.finalPrice);


                    System.out.println(preparedStatement);

                    int affectedRows = preparedStatement.executeUpdate();

                    if (affectedRows == 0) {
                        throw new SQLException("Creating orderproduct failed, no rows affected.");
                    }



            conn.close();
        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }

        return false;


    } // 4

    public long getProductID(String productName){
        String GET_PROD_ID_SQL = "SELECT id_products FROM products WHERE product_name=?;";
        long prodID = -20;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");


            PreparedStatement preparedStatement = conn.prepareStatement(GET_PROD_ID_SQL);
            preparedStatement.setString(1, productName);

            System.out.println(preparedStatement);

            ResultSet rs = preparedStatement.executeQuery();



            if(rs.next() != false){
                prodID = rs.getInt("id_products");
                System.out.println("prod_id: " +prodID);
                conn.close();
                return prodID;
            }


        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }
        return prodID;
    } // 3
}
