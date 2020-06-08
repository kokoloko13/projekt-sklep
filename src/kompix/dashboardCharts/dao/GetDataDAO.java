package kompix.dashboardCharts.dao;

import kompix.dashboardCharts.model.Counter;
import kompix.dashboardCharts.model.DashboardJSON;

import java.sql.*;

public class GetDataDAO {

  static public DashboardJSON fillDashboardJSON(DashboardJSON obj){
        DashboardJSON tempObj = obj;


       String USER_COUNT_QUERY = "SELECT COUNT(id_user) userCounter FROM users WHERE admin = 0 AND isactive=1;";
       String ORDER_COUNT_QUERY = "SELECT COUNT(id_order) orderCounter FROM orders WHERE order_status IN (1,4,5,6);";
       String NEWS_COUNT_QUERY = "SELECT COUNT(id_news) newsCounter FROM newsletter;";


       String INCOMEMNTH_COUNT_QUERY = "SELECT mth.name month, IFNULL(SUM(total_price),0) incomeValue FROM"
                +" months mth LEFT JOIN orders ON mth.id = MONTH(orders.order_date) "
                +"GROUP BY mth.name ORDER BY mth.id;";

       String ORDERSMNTH_COUNT_QUERY = "SELECT mth.name month, IFNULL(COUNT(id_order),0) ordersValue FROM"
                +" months mth LEFT JOIN orders ON mth.id = MONTH(orders.order_date) "
                +"GROUP BY mth.name ORDER BY mth.id;";

       String PRODUCTS_SUMMARY_QUERY = "SELECT cat.category_name category, IFNULL(COUNT(prod.id_products),0) productQty FROM"
                +" categories cat LEFT JOIN products prod ON cat.id_category = prod.id_category "
                +"GROUP BY category ORDER BY cat.id_category;";



        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement userCountPrepared = conn.prepareStatement(USER_COUNT_QUERY);
            PreparedStatement orderCountStatement = conn.prepareStatement(ORDER_COUNT_QUERY);
            PreparedStatement newsCountStatement = conn.prepareStatement(NEWS_COUNT_QUERY);

            PreparedStatement incomeMonthStatement = conn.prepareStatement(INCOMEMNTH_COUNT_QUERY);
            PreparedStatement ordersMonthStatement = conn.prepareStatement(ORDERSMNTH_COUNT_QUERY);
            PreparedStatement productsSummaryStatement = conn.prepareStatement(PRODUCTS_SUMMARY_QUERY);

            ResultSet userCount = userCountPrepared.executeQuery();
            ResultSet orderCount = orderCountStatement.executeQuery();
            ResultSet newsCount = newsCountStatement.executeQuery();

            ResultSet income = incomeMonthStatement.executeQuery();
            ResultSet orders = ordersMonthStatement.executeQuery();
            ResultSet products = productsSummaryStatement.executeQuery();


            if(userCount.next() != false){
                obj.counters.add(new Counter("clients", userCount.getInt("userCounter")));
            }
            if(orderCount.next() != false){
                obj.counters.add(new Counter("orders", orderCount.getInt("orderCounter")));
            }
            if(newsCount.next() != false){
                obj.counters.add(new Counter("newsletter", newsCount.getInt("newsCounter")));
            }

            while(income.next() != false){
                obj.months.add(income.getString("month"));
                obj.incomePerMonth.add(income.getDouble("incomeValue"));
            }
            while(orders.next() != false){
                obj.ordersPerMonth.add(orders.getInt("ordersValue"));
            }
            while(products.next() != false){
                obj.categories.add(products.getString("category"));
                obj.productsQty.add(products.getInt("productQty"));
            }

        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }finally {
            return tempObj;
        }
    }
}
