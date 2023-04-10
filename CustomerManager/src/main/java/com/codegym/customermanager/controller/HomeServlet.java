package com.codegym.customermanager.controller;

import com.codegym.customermanager.service.ProductService;
import com.codegym.customermanager.service.ProductServiceMySQL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "HomeServlet", value = "/home")
public class HomeServlet extends HttpServlet {
    public ProductService productService;

    @Override
    public void init() throws ServletException {
        productService = new ProductServiceMySQL();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("products", productService.findAll());

        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/trash/frontend/index.jsp");
        requestDispatcher.forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
