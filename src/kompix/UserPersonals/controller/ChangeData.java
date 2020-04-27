package kompix.UserPersonals.controller;

import kompix.UserPersonals.dao.PersonalsDao;
import kompix.UserPersonals.model.Personals;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ChangeData")
public class ChangeData extends HttpServlet {
    private PersonalsDao personalsDao = new PersonalsDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newName = request.getParameter("clientName");
        String newLastName = request.getParameter("clientLastname");
        String newStreet = request.getParameter("clientStreet");
        String newZip = request.getParameter("clientZip");
        String newCity = request.getParameter("clientCity");
        String newPhoneNr = request.getParameter("clientPhone");
        String newEmail = request.getParameter("clientEmail");

        Personals data = new Personals(newName,newLastName,newPhoneNr,newEmail,newZip,newCity,newStreet);

        String emailBeforeChange = "";

        Cookie[] cookies = request.getCookies();
        if(cookies != null){
            for(Cookie cookie : cookies){
                if(cookie.getName().equals("user_email")) emailBeforeChange = cookie.getValue();
            }
        }

        personalsDao.change(data, emailBeforeChange);

        response.sendRedirect("/konto.jsp");
    }
}
