package com.java4.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet({
    "/video/list",
    "/video/detail/*",
    "/video/like/*",
    "/video/share/*"
})
public class VideoServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        String message = "";
        
        if (path.contains("list")) {
            message = "Video List Page";
        } else if (path.contains("detail")) {
            String videoId = req.getPathInfo() != null ? req.getPathInfo().substring(1) : "";
            message = "Video Detail Page - ID: " + videoId;
        } else if (path.contains("like")) {
            String videoId = req.getPathInfo() != null ? req.getPathInfo().substring(1) : "";
            message = "Video Like Action - ID: " + videoId;
        } else if (path.contains("share")) {
            String videoId = req.getPathInfo() != null ? req.getPathInfo().substring(1) : "";
            message = "Video Share Action - ID: " + videoId;
        }
        
        req.setAttribute("message", message);
        req.getRequestDispatcher("/views/demo/page.jsp").forward(req, resp);
    }
}

