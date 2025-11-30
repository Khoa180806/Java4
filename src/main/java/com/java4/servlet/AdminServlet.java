package com.java4.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet({
    "/admin/video",
    "/admin/user",
    "/admin/like",
    "/admin/share"
})
public class AdminServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        String message = "";
        
        if (path.contains("video")) {
            message = "Admin Video Management";
        } else if (path.contains("user")) {
            message = "Admin User Management";
        } else if (path.contains("like")) {
            message = "Admin Like Management";
        } else if (path.contains("share")) {
            message = "Admin Share Management";
        }
        
        req.setAttribute("message", message);
        req.getRequestDispatcher("/views/page.jsp").forward(req, resp);
    }
}

