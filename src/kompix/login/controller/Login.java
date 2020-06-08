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

@WebServlet("/Login")
public class Login extends HttpServlet {
    LoginDao loginDao = new LoginDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("login");
        String passwd = request.getParameter("passwd");
        String stayLogged = request.getParameter("stayLogged");

        LoginUser loginUser = new LoginUser(email, passwd);

        if(loginDao.loginUser(loginUser) == true){
            Cookie loginCookie = new Cookie("user_email", email);

                loginCookie.setMaxAge(30*60);

            response.addCookie(loginCookie);


            response.sendRedirect("/konto.jsp");
        }else{
            Cookie badCredentialsCookie = new Cookie("bad_credentials", "true");
            badCredentialsCookie.setMaxAge(5);
            response.addCookie(badCredentialsCookie);

            response.sendRedirect("/logowanie.jsp");
        }

    }
}
