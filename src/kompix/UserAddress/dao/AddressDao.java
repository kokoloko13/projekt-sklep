package kompix.UserAddress.dao;

import kompix.UserAddress.model.Address;

import java.sql.*;

public class AddressDao {
    public long createAddressInstance(Address address){
            String INSERT_NEWADDRESS_SQL = "INSERT INTO address (zipcode, city, street) VALUES"+
                    " (?, ?, ?);";

            int result = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection conn = DriverManager
                    .getConnection("jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "");

            PreparedStatement preparedStatement = conn.prepareStatement(INSERT_NEWADDRESS_SQL, Statement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, address.getZip());
            preparedStatement.setString(2, address.getCity());
            preparedStatement.setString(3, address.getStreet());

            System.out.println(preparedStatement);

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getLong(1);
                }
                else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }

        }catch(ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }


        return result;
    }
}
