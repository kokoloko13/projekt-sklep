package kompix.dashboardCharts.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import kompix.dashboardCharts.dao.GetDataDAO;
import kompix.dashboardCharts.model.DashboardJSON;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/GetDashboardData")
public class GetDashboardData extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        DashboardJSON obj = GetDataDAO.fillDashboardJSON(new DashboardJSON());

        String json = gson.toJson(obj);

       // System.out.println(json);

        PrintWriter out = response.getWriter();
        response.setContentType("application/json; charset=UTF-8");
        out.print(json);
        out.flush();
    }
}
