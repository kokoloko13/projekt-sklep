package kompix.GenerateOrderPDF;

import com.itextpdf.html2pdf.HtmlConverter;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class GeneratePDF {
    private String path;
    private long orderID;

    public GeneratePDF(long orderID, String path){
        this.path = path;
        this.orderID = orderID;
    }

    public boolean gen(){
        String SELECT_USERORDER_SQL = "SELECT u.first_name, u.last_name, u.user_phone, a.street, a.city, a.zipcode,"
        +" o.order_num, o.total_price, s.ship_method_long, s.ship_price"
        +" FROM users AS u, address AS a, orders AS o INNER JOIN ship AS s ON"
        +" o.id_ship = s.id_ship WHERE u.id_user = o.id_user AND o.id_order=?;";

        String SELECT_ORDER_PRODUCTS_SQL = "SELECT p.product_name, op.qty, op.final_price"
        +" FROM orderproduct AS op INNER JOIN products AS p ON op.id_product = p.id_products"
        +" WHERE op.id_order=?;";



        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement1 = conn.prepareStatement(SELECT_USERORDER_SQL);
            preparedStatement1.setLong(1, orderID);

            PreparedStatement preparedStatement2 = conn.prepareStatement(SELECT_ORDER_PRODUCTS_SQL);
            preparedStatement2.setLong(1, orderID);


            System.out.println(preparedStatement1);
            System.out.println(preparedStatement2);

            ResultSet userOrder = preparedStatement1.executeQuery();
            ResultSet productsOrder = preparedStatement2.executeQuery();

            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd.MM.yyyy");
            LocalDateTime now = LocalDateTime.now();

            if(userOrder.next() != false){

                String pdfContentStart =   "   <!DOCTYPE html>  "  +
                        "   <html lang=\"en\">  "  +
                        "     <head>  "  +
                        "       <meta charset=\"UTF-8\" />  "  +
                        "       <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />  "  +
                        "       <title>Zamówienie-"+ userOrder.getString("o.order_num") +"</title>  "  +
                        "     </head>  "  +
                        "     <body>  "  +
                        "       <table style=\"width: 100%; padding: 2rem 0 1rem 0;\">  "  +
                        "         <tr>  "  +
                        "           <td style=\"width: 50%; text-align: center;\">"+ dtf.format(now) +"r.</td>  "  +
                        "           <td colspan=\"2\" style=\"width: 50%; text-align: center;\">Zielona Góra</td>  "  +
                        "         </tr>  "  +
                        "         <tr>  "  +
                        "           <td style=\"width: 50%; text-align: center;\">  "  +
                        "             <p style=\"padding: 2rem 0 1rem 0;\">Kompix Sp. z o.o.</br>Zielona Góra</br>tel. 123456789</p>  "  +
                        "           </td>  "  +
                        "           <td style=\"width: 50%; text-align: center;\">  "  +
                        "             <p style=\"padding: 2rem 0 1rem 0;\">"+ userOrder.getString("u.first_name") +" "+ userOrder.getString("u.last_name") +"</br>"+ userOrder.getString("a.street") +"</br>"+ userOrder.getString("a.city") +", "+ userOrder.getString("a.zipcode") +"</br>tel. "+ userOrder.getString("u.user_phone") +"</p>  "  +
                        "           </td>  "  +
                        "         </tr>  "  +
                        "       </table>  "  +
                        "       <table style=\"width: 70%; border-collapse: collapse; margin: 0 auto;\">  "  +
                        "         <tr>  "  +
                        "           <th colspan=\"3\" style=\"padding: 2rem 0 3rem 0; font-size: 1.3rem;\">Zamówienie nr: "+ userOrder.getString("o.order_num") +"</th>  "  +
                        "         </tr>  "  +
                        "         <tr style=\"text-align: center;\"></tr>  "  +
                "           <th style=\"padding: 1rem 0; width: 33%;\">Nazwa:</th>  "  +
                        "           <th style=\"padding: 1rem 0; width: 33%;\">Ilość:</th>  "  +
                        "           <th style=\"padding: 1rem 0; width: 33%;\">Cena:</th>  "  +
                        "        </tr>  " ;

                if(productsOrder.next() != false){
                            do{
                                pdfContentStart +=   "         <tr style=\"border-top: 1px solid; text-align: center;\">  "  +
                                        "           <td style=\"padding: 1rem 0;\">"+ productsOrder.getString("p.product_name") +"</td>  "  +
                                        "           <td style=\"padding: 1rem 0;\">"+ productsOrder.getInt("op.qty") +"</td>  "  +
                                        "           <td style=\"padding: 1rem 0;\">"+ productsOrder.getDouble("op.final_price") +"</td>  "  +
                                        "        </tr>  " ;
                            }while(productsOrder.next());
                        }

                        String pdfContentEnd =   "     <tr style=\"border-top: 1px solid; text-align: center; padding-top: 2rem;\">  "  +
                                "           <th style=\"padding-top: 2rem;\">Dostawa:</th>  "  +
                                "           <th style=\"padding-top: 2rem;\">"+ userOrder.getString("s.ship_method_long") +"</th>  "  +
                                "           <th style=\"padding-top: 2rem;\">"+ userOrder.getDouble("s.ship_price") +"</th>  "  +
                                "         </tr>  "  +
                                "         <tr>  "  +
                                "           <th style=\"padding: 1rem 0 5rem 0; width: 33%;\">Łącznie:</th>  "  +
                                "           <th style=\"width: 33%;\"></th> "+
                                "           <th colspan=\"2\" style=\"width: 33%; padding: 1rem 0 5rem 0; text-align: right;\">"+ userOrder.getDouble("o.total_price") +" PLN</th>  "  +
                                "         </tr>  "  +
                                "       </table>  "  +
                                "     </body>  "  +
                                "   </html>  "  +
                                "    " ;

                String pdfContent = pdfContentStart + pdfContentEnd;

                try {
                    HtmlConverter.convertToPdf(pdfContent, new FileOutputStream(path+"/"+userOrder.getString("o.order_num")+".pdf"));
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                }

                System.out.println( "PDF Created!" );

                String INSERT_VAT_SQL = "INSERT INTO vat(vat) VALUES(?);";

                String UPDATE_ORDER_SQL = "UPDATE orders SET id_vat=? WHERE id_order=?;";

                PreparedStatement preparedInsertVat = conn.prepareStatement(INSERT_VAT_SQL, Statement.RETURN_GENERATED_KEYS);
                preparedInsertVat.setString(1, "ordersPDF/"+userOrder.getString("o.order_num")+".pdf");

                int affectedRows = preparedInsertVat.executeUpdate();

                if (affectedRows == 0) {
                    throw new SQLException("Creating vat failed, no rows affected.");
                }

                try (ResultSet generatedKeys = preparedInsertVat.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        long vatID = generatedKeys.getLong(1);
                        PreparedStatement preparedUpdateOrder = conn.prepareStatement(UPDATE_ORDER_SQL);
                        preparedUpdateOrder.setLong(1, vatID);
                        preparedUpdateOrder.setLong(2, orderID);

                        int affectedRows2 = preparedUpdateOrder.executeUpdate();

                        if (affectedRows2 == 0) {
                            throw new SQLException("Updating order failed, no rows affected.");
                        }
                    }
                    else {
                        throw new SQLException("Creating vat failed, no ID obtained.");
                    }
                }




                conn.close();
                        return true;
            }else{
                conn.close();
                return false;
            }

        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }
        return false;
    }

}
