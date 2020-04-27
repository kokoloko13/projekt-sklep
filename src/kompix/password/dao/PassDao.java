package kompix.password.dao;

import kompix.cipher.CipherKompix;

import java.sql.*;

public class PassDao {
    private CipherKompix aes = new CipherKompix();

    public void change(String newPass, String email){
            String UPDATE_USERPASSWD_SQL = "UPDATE users SET user_passwd=? WHERE user_mail=?;";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(UPDATE_USERPASSWD_SQL);
            preparedStatement.setString(1, aes.encrypt(newPass));
            preparedStatement.setString(2, email);


            preparedStatement.executeUpdate();

            conn.close();

        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }
    }
}
