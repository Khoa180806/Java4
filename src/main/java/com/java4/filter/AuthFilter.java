package com.java4.filter;

import com.java4.user.entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {
    "/admin/*",
    "/account/change-password",
    "/account/edit-profile",
    "/video/like/*",
    "/video/share/*"
})
public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("AuthFilter initialized");
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        HttpSession session = httpRequest.getSession(false);
        User user = null;
        
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
        
        String uri = httpRequest.getRequestURI();
        String queryString = httpRequest.getQueryString();
        String contextPath = httpRequest.getContextPath();
        
        // Kiểm tra đăng nhập: tất cả các URL đều yêu cầu đăng nhập
        if (user == null) {
            // Chưa đăng nhập - chuyển về trang login
            session = httpRequest.getSession();
            
            // Lưu URL đầy đủ (bao gồm cả query string nếu có)
            String fullUrl = uri;
            if (queryString != null && !queryString.isEmpty()) {
                fullUrl = uri + "?" + queryString;
            }
            
            session.setAttribute("previousUrl", fullUrl);
            session.setAttribute("message", "Bạn cần đăng nhập để truy cập chức năng này!");
            httpResponse.sendRedirect(contextPath + "/user/login");
            return;
        }
        
        // Kiểm tra quyền admin cho các URL /admin/*
        if (uri.startsWith(contextPath + "/admin/")) {
            if (user.getAdmin() == null || !user.getAdmin()) {
                // Không có quyền admin
                httpResponse.sendRedirect(contextPath + "/views/error/403.jsp");
                return;
            }
        }
        
        // Cho phép tiếp tục request
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        System.out.println("AuthFilter destroyed");
    }
}
