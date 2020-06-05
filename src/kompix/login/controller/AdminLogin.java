package kompix.login.controller;

import com.itextpdf.html2pdf.HtmlConverter;
import kompix.login.dao.LoginDao;
import kompix.login.model.LoginUser;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
    LoginDao loginDao = new LoginDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adminEmail = request.getParameter("adminLogin");
        String adminPasswd = request.getParameter("adminPass");

        LoginUser loginUser = new LoginUser(adminEmail, adminPasswd);

        if(loginDao.loginUser(loginUser) == true){
            Cookie adminCookie = new Cookie("admin_email", adminEmail);
            adminCookie.setMaxAge(30*60);
            response.addCookie(adminCookie);


            response.sendRedirect("/cpanel/dashboard.jsp");
        }else{
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/cpanel/admin-login.html");
            rd.include(request, response);
        }

    }
}
