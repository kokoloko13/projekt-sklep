package kompix.register.dao;

import kompix.UserAddress.model.Address;
import kompix.register.model.NewUser;

import java.sql.*;

public class Newsletter {

    private final String _INSERT_NEWSLETTER_SQL = "INSERT INTO newsletter(email) VALUES(?);";


    private Connection getConnection(){
        try {
            Connection  conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");
            return conn;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public int registerNewsletter(NewUser newbie){
        int result = 0;
        Connection conn = getConnection();


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");



            PreparedStatement preparedStatement = conn.prepareStatement(_INSERT_NEWSLETTER_SQL);
            preparedStatement.setString(1, newbie.getEmail());




            System.out.println(preparedStatement);

            result = preparedStatement.executeUpdate();
            conn.close();

        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }


        return result;
    }
    public int registerNewsletter(String email){
        int result = 0;
        Connection conn = getConnection();


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");



            PreparedStatement preparedStatement = conn.prepareStatement(_INSERT_NEWSLETTER_SQL);
            preparedStatement.setString(1, email);




            System.out.println(preparedStatement);

            result = preparedStatement.executeUpdate();
            conn.close();

        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }


        return result;
    }
}
