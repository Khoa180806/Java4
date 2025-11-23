package com.java4.filter;

import com.java4.log.dao.LogDAO;
import com.java4.log.dao.LogDAOImpl;
import com.java4.log.entity.Log;
import com.java4.user.entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

@WebFilter(urlPatterns = "/*")
public class AppFilter implements Filter {
    
    private LogDAO logDAO;
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        logDAO = new LogDAOImpl();
        System.out.println("AppFilter initialized");
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        if (request instanceof HttpServletRequest) {
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            HttpSession session = httpRequest.getSession(false);
            
            if (session != null) {
                User user = (User) session.getAttribute("user");
                
                if (user != null) {
                    String uri = httpRequest.getRequestURI();
                    String queryString = httpRequest.getQueryString();
                    String fullUrl = uri + (queryString != null ? "?" + queryString : "");
                    
                    Log log = new Log();
                    log.setUrl(fullUrl);
                    log.setTime(new Date());
                    log.setUsername(user.getId());
                    
                    try {
                        logDAO.create(log);
                    } catch (Exception e) {
                        System.err.println("Error logging access: " + e.getMessage());
                    }
                }
            }
        }
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        System.out.println("AppFilter destroyed");
    }
}
