package kompix.UserPersonals.dao;

import kompix.UserAddress.model.Address;
import kompix.UserPersonals.model.Personals;

import java.sql.*;

public class PersonalsDao {

    public void change(Personals data, String emailBeforChange){

        String SELECT_PERSONALDATA_SQL = "SELECT * FROM users AS u, address AS a WHERE a.id_address=u.id_address"+
                " AND u.user_email=?";

        String UPDATE_PERSONALDATA_SQL = "UPDATE users AS u, address AS a SET "+
                "u.first_name=?, u.last_name=?, u.user_phone=?, u.user_email=?, a.zipcode=?, a.city=?,"+
                " a.street=? WHERE u.user_email=? AND  u.id_address = a.id_address;";

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection selectConn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement selectPS = selectConn.prepareStatement(SELECT_PERSONALDATA_SQL);
            selectPS.setString(1, emailBeforChange);

            ResultSet backupData = selectPS.executeQuery();

            backupData.next();


            Connection updateConn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement updatePS = updateConn.prepareStatement(UPDATE_PERSONALDATA_SQL);
            updatePS.setString(1, data.getName() == "" ? backupData.getString("first_name") : data.getName());
            updatePS.setString(2, data.getLastName() == "" ? backupData.getString("last_name") : data.getLastName());
            updatePS.setString(3, data.getPhoneNr() == "" ? backupData.getString("user_phone") : data.getPhoneNr());
            updatePS.setString(4, data.getEmail() == "" ? backupData.getString("user_email") : data.getEmail());
            updatePS.setString(5, data.getAddress().getZip() == "" ? backupData.getString("zipcode") : data.getAddress().getZip());
            updatePS.setString(6, data.getAddress().getCity() == "" ? backupData.getString("city") : data.getAddress().getCity());
            updatePS.setString(7, data.getAddress().getStreet() == "" ? backupData.getString("street") : data.getAddress().getStreet());
            updatePS.setString(8, emailBeforChange);




            System.out.println(updatePS);

            updatePS.executeUpdate();
            selectConn.close();
            updateConn.close();

        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }

    }
}
