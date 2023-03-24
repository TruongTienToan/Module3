package com.example.displaycustomer;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet(name = "CustomerServlet", value = "/CustomerServlet")
public class CustomerServlet extends HttpServlet {
    private List<Customer> customers;

    @Override
    public void init() throws ServletException {
        customers = new ArrayList<>();
        //long id, String name, Date createAt, String address, String image
        customers.add(new Customer(1L, "Quang Dang", new Date(), "28 NTP", null));
        customers.add(new Customer(2L, "Đình Hâu", new Date(), "28 NTP", null));
        customers.add(new Customer(3L, "Tiến Toàn", new Date(), "28 NTP", null));
        customers.add(new Customer(4L, "Khoa Hâu", new Date(), "28 NTP", null));
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("customers", customers);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/customer.jsp");
        requestDispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
