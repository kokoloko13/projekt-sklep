package kompix.password.controller;

import kompix.login.dao.LoginDao;
import kompix.password.dao.PassDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ChangePasswd")
public class ChangePasswd extends HttpServlet {

    private PassDao passDao = new PassDao();
    private LoginDao loginDao = new LoginDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String currentPass = request.getParameter("clientCurrPasswd");
        String newPass = request.getParameter("clientNewPasswd1");
        String email = "";

        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("user_email")) email = cookie.getValue();
            }
        }


        if(loginDao.isPasswdCorrect(currentPass, email)){
            passDao.change(newPass, email);
        }

        response.sendRedirect("/konto.jsp");


    }
}
