package kompix.register.dao;

import kompix.register.model.NewUser;

import java.sql.*;

public class NewUserDao {

    public int reqisterNewUser(NewUser newUser) {

        String INSERT_NEWUSER_SQL = "INSERT INTO users" +
                " (id_user, user_email, user_passwd, first_name, last_name, user_phone, id_address, admin, isactive, rulesAccepted, newsletter) VALUES" +
                " (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

        int result = 0;



        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
            .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(INSERT_NEWUSER_SQL);
            preparedStatement.setNull(1, Types.INTEGER);
            preparedStatement.setString(2, newUser.getEmail());
            preparedStatement.setString(3, newUser.getPasswd());
            preparedStatement.setString(4, newUser.getName());
            preparedStatement.setString(5, newUser.getLastName());
            preparedStatement.setString(6, newUser.getPhoneNr());
            preparedStatement.setNull(7, Types.INTEGER);
            preparedStatement.setInt(8, newUser.getAdmin());
            preparedStatement.setInt(9, newUser.getIsActive());
            preparedStatement.setInt(10, newUser.getRulesAccepted().matches("True") ? 1 : 0);
            preparedStatement.setInt(11, newUser.getNewsletter().matches("True") ? 1 : 0);

            System.out.println(preparedStatement);

            result = preparedStatement.executeUpdate();
            conn.close();

        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }


        return result;
    }
}
