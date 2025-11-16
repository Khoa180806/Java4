package com.java4.user.servlet;

import com.java4.user.dao.UserDAO;
import com.java4.user.dao.UserDAOImpl;
import com.java4.user.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/user/login")
public class UserLoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/user/login.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        UserDAO userDAO = new UserDAOImpl();
        User user = userDAO.findByIdOrEmail(username);
        
        if (user != null && user.getPassword().equals(password)) {
            req.setAttribute("message", "Login successfully! Welcome " + user.getFullname());
            req.setAttribute("messageType", "success");
            req.setAttribute("user", user);
        } else {
            req.setAttribute("message", "Invalid username or password!");
            req.setAttribute("messageType", "error");
            req.setAttribute("username", username);
        }
        
        req.getRequestDispatcher("/views/user/login.jsp").forward(req, resp);
    }
}
