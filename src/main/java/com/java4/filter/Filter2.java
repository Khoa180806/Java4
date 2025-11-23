package com.java4.filter;

import jakarta.servlet.*;

import java.io.IOException;

public class Filter2 implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("Filter2 initialized");
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        String hello = (String) request.getAttribute("hello");
        System.out.println("Filter2: " + hello);
        
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        System.out.println("Filter2 destroyed");
    }
}
