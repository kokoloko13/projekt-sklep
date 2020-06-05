package kompix.login.controller;

import kompix.login.dao.LoginDao;
import kompix.login.model.LoginUser;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {
    LoginDao loginDao = new LoginDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String adminEmail = request.getParameter("adminLogin");
        String adminPasswd = request.getParameter("adminPass");

        LoginUser loginAdmin = new LoginUser(adminEmail, adminPasswd);

        if(loginDao.loginAdmin(loginAdmin) == true){
            Cookie adminCookie = new Cookie("admin_email", adminEmail);
            adminCookie.setMaxAge(30*60);
            response.addCookie(adminCookie);


            response.sendRedirect("/cpanel/dashboard.jsp");
        }else{
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/cpanel/admin-login.jsp");
            rd.include(request, response);
        }

    }
}
