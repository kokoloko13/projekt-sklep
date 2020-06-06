package kompix.dashboardCharts.model;

import java.util.ArrayList;
import java.util.List;

public class DashboardJSON {
    public List<Counter> counters = new ArrayList<Counter>();
    public List<String> months = new ArrayList<String>();
    public List<Double> incomePerMonth = new ArrayList<Double>();
    public List<Integer> ordersPerMonth = new ArrayList<Integer>();
    public List<String> categories = new ArrayList<String>();
    public List<Integer> productsQty = new ArrayList<Integer>();
}
