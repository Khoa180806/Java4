package com.java4.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;

import java.io.IOException;

public class Filter1 implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("Filter1 initialized");
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        request.setAttribute("hello", "Tôi là filter 1");
        System.out.println("Filter1: Set attribute 'hello' = 'Tôi là filter 1'");
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        System.out.println("Filter1 destroyed");
    }
}
