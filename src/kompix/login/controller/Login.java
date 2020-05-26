package kompix.login.controller;

import com.itextpdf.html2pdf.HtmlConverter;
import com.sun.net.httpserver.HttpPrincipal;
import kompix.login.dao.LoginDao;
import kompix.login.model.LoginData;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
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



            String html = "<h1>Hello</h1>"
                    + "<p>This was created using iText</p>"
                    + "<a href='hmkcode.com'>hmkcode.com</a>";
            HtmlConverter.convertToPdf(html, new FileOutputStream(getServletContext().getRealPath("/ordersPDF/")+"/new-order.pdf"));
            System.out.println( "PDF Created!" );

            response.sendRedirect("/konto.jsp");
        }else{
            RequestDispatcher rd = getServletContext().getRequestDispatcher("/logowanie.jsp");
            PrintWriter out= response.getWriter();
            out.println("<font color=red>Either user name or password is wrong.</font>");
            rd.include(request, response);
        }

    }
}
