package com.java4.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/user/logout")
public class UserLogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy session hiện tại (không tạo mới nếu chưa có)
        HttpSession session = req.getSession(false);
        
        // Nếu session tồn tại, xóa thông tin người dùng khỏi session
        if (session != null) {
            session.removeAttribute("user");
            // Có thể gọi session.invalidate() để hủy toàn bộ session nếu cần
            // session.invalidate();
        }
        resp.sendRedirect(req.getContextPath() + "/user/login");
    }
}

