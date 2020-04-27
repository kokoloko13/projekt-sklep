package kompix.login.controller;

import kompix.login.dao.LoginDao;
import kompix.login.model.LoginData;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/Login")
public class Login extends HttpServlet {
    LoginDao loginDao = new LoginDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("login");
        String passwd = request.getParameter("passwd");

        LoginData loginData = new LoginData(email, passwd);

        if(loginDao.loginUser(loginData) == true){
            Cookie loginCookie = new Cookie("user_email", email);
            loginCookie.setMaxAge(30*60);
            response.addCookie(loginCookie);
            response.sendRedirect("/konto.jsp");
        }else{
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/logowanie.jsp");
            PrintWriter out= response.getWriter();
            out.println("<font color=red>Either user name or password is wrong.</font>");
            rd.include(request, response);
        }

    }
}
