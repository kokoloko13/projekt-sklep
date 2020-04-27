package kompix.register.dao;

import kompix.register.model.NewUser;

import java.sql.*;

public class CheckUniqueUserDao {
    public boolean checkUniqueUser(NewUser newbie){
        String CHECK_UNIQUEUSER_SQL = "SELECT * FROM users WHERE user_email=?";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(CHECK_UNIQUEUSER_SQL);
            preparedStatement.setString(1, newbie.getEmail());

            System.out.println(preparedStatement);

            ResultSet res = preparedStatement.executeQuery();

            if(res.next() == false){
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
