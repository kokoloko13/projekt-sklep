package kompix.login.dao;

import kompix.cipher.CipherKompix;
import kompix.login.model.LoginData;

import java.sql.*;

public class LoginDao {
    private CipherKompix aes = new CipherKompix();

    public boolean loginUser(LoginData loginData){
        String SELECT_USER_SQL = "SELECT * FROM users WHERE user_email=? AND user_passwd=?;";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(SELECT_USER_SQL);
            preparedStatement.setString(1, loginData.getEmail());
            preparedStatement.setString(2, aes.encrypt(loginData.getPasswd()));

            System.out.println(preparedStatement);

            ResultSet rs = preparedStatement.executeQuery();


            if(rs.next() != false){
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

    public boolean isPasswdCorrect(String passwd, String email){
        String SELECT_USER_SQL = "SELECT user_passwd FROM users WHERE user_email=?;";


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(SELECT_USER_SQL);
            preparedStatement.setString(1, email);


            System.out.println(preparedStatement);

            ResultSet rs = preparedStatement.executeQuery();


            if(rs.next() != false){
                String pass = rs.getString("user_passwd");
                String passwdDecoded = aes.decrypt(pass);

                if(passwdDecoded == passwd)
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
