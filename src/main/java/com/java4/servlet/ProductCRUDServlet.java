package com.java4.servlet;

import com.java4.dao.ProductDAO;
import com.java4.dao.ProductDAOImpl;
import com.java4.entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/product/*")
public class ProductCRUDServlet extends HttpServlet {
    private ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/list")) {
            listProducts(req, resp);
        } else if (pathInfo.equals("/form")) {
            showForm(req, resp);
        } else if (pathInfo.equals("/edit")) {
            editProduct(req, resp);
        } else if (pathInfo.equals("/delete")) {
            deleteProduct(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String pathInfo = req.getPathInfo();
        if (pathInfo.equals("/create")) {
            createProduct(req, resp);
        } else if (pathInfo.equals("/update")) {
            updateProduct(req, resp);
        }
    }

    private void listProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = productDAO.findAll();
        req.setAttribute("products", products);
        req.getRequestDispatcher("/views/product/list.jsp").forward(req, resp);
    }

    private void showForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/product/form.jsp").forward(req, resp);
    }

    private void editProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        Product product = productDAO.findById(id);
        req.setAttribute("product", product);
        req.getRequestDispatcher("/views/product/form.jsp").forward(req, resp);
    }

    private void createProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        Integer price = Integer.parseInt(req.getParameter("price"));
        Integer quantity = Integer.parseInt(req.getParameter("quantity"));

        Product product = new Product();
        product.setName(name);
        product.setPrice(price);
        product.setQuantity(quantity);

        productDAO.create(product);
        resp.sendRedirect(req.getContextPath() + "/product/list");
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        Integer price = Integer.parseInt(req.getParameter("price"));
        Integer quantity = Integer.parseInt(req.getParameter("quantity"));

        Product product = new Product();
        product.setId(id);
        product.setName(name);
        product.setPrice(price);
        product.setQuantity(quantity);

        productDAO.update(product);
        resp.sendRedirect(req.getContextPath() + "/product/list");
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        productDAO.deleteById(id);
        resp.sendRedirect(req.getContextPath() + "/product/list");
    }
}
