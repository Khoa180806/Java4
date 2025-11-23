package com.java4.log.servlet;

import com.java4.log.dao.LogDAO;
import com.java4.log.dao.LogDAOImpl;
import com.java4.log.entity.Log;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/logs")
public class LogServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        LogDAO logDAO = new LogDAOImpl();
        
        String username = req.getParameter("username");
        
        List<Log> logs;
        if (username != null && !username.trim().isEmpty()) {
            logs = logDAO.findByUsername(username);
            req.setAttribute("filterUsername", username);
        } else {
            logs = logDAO.findAll();
        }
        
        req.setAttribute("logs", logs);
        req.getRequestDispatcher("/views/log/log_list.jsp").forward(req, resp);
    }
}
