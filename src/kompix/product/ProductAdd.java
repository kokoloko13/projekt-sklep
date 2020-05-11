package kompix.product;

import kompix.UserAddress.model.Address;
import kompix.register.model.NewUser;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/ProductAdd")
@MultipartConfig(maxFileSize = 16177215)
public class ProductAdd extends HttpServlet {
    private String name;
    private int amount;
    private float price;
    private String describe;
    private String category="1";
    private InputStream photo1;
    private InputStream photo2;
    private InputStream photo3;
    private InputStream photo4;
    private String dbURL = "jdbc:mysql://localhost:3306/shop?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    private String dbUser = "root";
    private String dbPass = "";


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        name=request.getParameter("productName");
        String amount_tmp=request.getParameter("productAmount");
        String price_tmp=request.getParameter("productPrice");
        describe=request.getParameter("productDesc");
        //category=request.getParameter("productCategory");
        Part photopart1=request.getPart("file1");
        if(photopart1!=null){
            System.out.println(photopart1.getName());
            System.out.println(photopart1.getSize());
            System.out.println(photopart1.getContentType());
            photo1 = photopart1.getInputStream();

        }
        Part photopart2=request.getPart("file2");
        if(photopart2!=null){
            photo2 = photopart2.getInputStream();
        }
        Part photopart3=request.getPart("file3");
        if(photopart3!=null){
            photo3 = photopart3.getInputStream();
        }
        Part photopart4=request.getPart("file4");
        if(photopart4!=null){
            System.out.println(photopart1.getName());
            System.out.println(photopart1.getSize());
            System.out.println(photopart1.getContentType());
            photo4 = photopart4.getInputStream();
        }
        amount=Integer.parseInt(amount_tmp);
        price=Float.parseFloat(price_tmp);


            RequestDispatcher rd = getServletContext().getRequestDispatcher("/cpanel/dodaj-produkt.html");
            PrintWriter out= response.getWriter();
        Connection conn = null; // connection to the database
        String message = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            String sql = "INSERT INTO products (product_name, amount, price, product_desc,id_category,photo1,photo2,photo3,photo4) values (?, ?, ?,?,?,?,?,?,?)";
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setString(1, name);
            statement.setInt(2, amount);
            statement.setFloat(3, price);
            statement.setString(4, describe);
            statement.setString(5, category);
            if (photo1 != null) {
                // fetches input stream of the upload file for the blob column
                statement.setBlob(6, photo1);
            }
            if (photo2 != null) {
                // fetches input stream of the upload file for the blob column
                statement.setBlob(7, photo2);
            }
            if (photo3 != null) {
                // fetches input stream of the upload file for the blob column
                statement.setBlob(8, photo3);
            }
            if (photo4 != null) {
                // fetches input stream of the upload file for the blob column
                statement.setBlob(9, photo4);
            }
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "File uploaded and saved into database";
            }

        } catch (Exception e) {
            System.out.print(e);
            e.printStackTrace();
        }
            rd.include(request, response);


        }

    }


