package com.codegym.customermanager.controller;

import com.codegym.customermanager.model.Product;
import com.codegym.customermanager.service.ProductService;
import com.codegym.customermanager.service.ProductServiceMySQL;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ProductServlet", value = "/product")
public class ProductServlet extends HttpServlet {
    public ProductService productService;

    public void init() throws ServletException {
        productService = new ProductServiceMySQL();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showFormCreate(request, response);
                break;
            case "edit":
                showFormEdit(request, response);
                break;
            case "delete":
                showFormDelete(request, response);
                break;
            default:
                showList(request, response);
                break;
        }
    }

    private void showFormDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long idProducts = Long.parseLong(req.getParameter("id"));
        Product product = productService.findById(idProducts);

        req.setAttribute("product", product);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/product/delete.jsp");
        requestDispatcher.forward(req, resp);
    }


    private void showFormEdit(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long idProducts = Long.parseLong(req.getParameter("id"));
        Product product = productService.findById(idProducts);

        req.setAttribute("product", product);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/product/edit.jsp");
        requestDispatcher.forward(req, resp);

    }

    private void showFormCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/product/create.jsp");
        requestDispatcher.forward(req, resp);
    }

    private void showList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = productService.findAll();
        req.setAttribute("products", products);
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/product/products.jsp");
        requestDispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                createProduct(request, response);
                break;
            case "edit":
                editProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                showList(request, response);
                break;
        }
    }

    private void createProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String name = req.getParameter("name");
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        double price = Double.parseDouble(req.getParameter("price"));
        String description = req.getParameter("description");

        Product product = new Product(productService.maxId() + 1, name, quantity, price, description);
        productService.save(product);

        req.setAttribute("message", "Thêm sản phẩm thành công!");
        RequestDispatcher requestDispatcher = req.getRequestDispatcher("/product/create.jsp");
        requestDispatcher.forward(req, resp);
    }

    private void editProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("txtName");
        int quantity = Integer.parseInt(req.getParameter("txtQuantity"));
        double price = Double.parseDouble(req.getParameter("txtPrice"));
        String description = req.getParameter("txtDescription");

        long idProduct = Long.parseLong(req.getParameter("id"));

        Product product = productService.findById(idProduct);
        product.setName(name);
        product.setQuantity(quantity);
        product.setPrice(price);
        product.setDescription(description);

        productService.update(idProduct, product);

//        showList(req, resp);


        resp.sendRedirect("/product");
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        long idProduct = Long.parseLong(req.getParameter("id"));

        productService.remove(idProduct);
        resp.sendRedirect("/product");
    }
}
