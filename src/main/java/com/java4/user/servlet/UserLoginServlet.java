package com.java4.user.servlet;

import com.java4.user.dao.UserDAO;
import com.java4.user.dao.UserDAOImpl;
import com.java4.user.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/user/login")
public class UserLoginServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/user/login.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy thông tin đăng nhập từ form
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        
        // Kiểm tra thông tin đăng nhập
        UserDAO userDAO = new UserDAOImpl();
        User user = userDAO.findById(username);
        
        // Xử lý kết quả đăng nhập
        if (user == null) {
            // Trường hợp không tìm thấy username
            req.setAttribute("message", "Sai username!");
            req.setAttribute("messageType", "error");
            req.setAttribute("username", username);
        } else if (!user.getPassword().equals(password)) {
            // Trường hợp sai mật khẩu
            req.setAttribute("message", "Sai password!");
            req.setAttribute("messageType", "error");
            req.setAttribute("username", username);
        } else {
            // Đăng nhập thành công
            // Lưu thông tin người dùng vào session
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            
            // Thiết lập thông báo thành công
            req.setAttribute("message", "Đăng nhập thành công! Xin chào " + user.getFullname());
            req.setAttribute("messageType", "success");
        }
        
        req.getRequestDispatcher("/views/user/login.jsp").forward(req, resp);
    }
}
