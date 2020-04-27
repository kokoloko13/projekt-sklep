package kompix.register.controller;

import kompix.register.dao.CheckUniqueUserDao;
import kompix.register.dao.NewUserDao;
import kompix.register.model.NewUser;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/Register")
public class Register extends HttpServlet {

    private NewUserDao newUserDao = new NewUserDao();
    private CheckUniqueUserDao uniqueUserDao = new CheckUniqueUserDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("login");
        String passwd = request.getParameter("passwd");
        String rules = request.getParameter("rulesAccepted");



        NewUser newbie = new NewUser();

        newbie.setEmail(email);
        newbie.setPasswd(passwd);
        newbie.setRulesAccepted(rules);

        if(request.getParameter("newsletterAccepted") != null){
            String ta = request.getParameter("newsletterAccepted");
            newbie.setNewsletter(ta);
        }

                boolean check = uniqueUserDao.checkUniqueUser(newbie);
            if(check == true){
                newUserDao.reqisterNewUser(newbie);
            }

        response.sendRedirect(request.getContextPath() + "/logowanie.jsp");
    }
}
