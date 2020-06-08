package kompix.register.controller;

import kompix.register.dao.Newsletter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AddNewsletter")
public class AddNewsletter extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("newsletter_email");

        if((new Newsletter()).registerNewsletter(email) > 0){
            response.sendRedirect("/");
        }

    }
}
