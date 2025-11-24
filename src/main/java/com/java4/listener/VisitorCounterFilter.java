package com.java4.listener;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter để đếm số lượng visitor duy nhất
 * Mỗi session chỉ được đếm 1 lần duy nhất
 */
@WebFilter("/*")
public class VisitorCounterFilter implements Filter {
    
    private static final String VISITOR_COUNTED = "visitorCounted";
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        if (request instanceof HttpServletRequest) {
            HttpServletRequest httpRequest = (HttpServletRequest) request;
            String requestURI = httpRequest.getRequestURI();
            String userAgent = httpRequest.getHeader("User-Agent");
            
            // Bỏ qua các request đến static resources và favicon
            if (!isStaticResource(requestURI) && isValidUserRequest(userAgent)) {
                HttpSession session = httpRequest.getSession(false);
                
                // Chỉ tạo session và đếm khi có request thực sự từ user
                if (session == null) {
                    session = httpRequest.getSession(true);
                    System.out.println("[VISITOR FILTER] New session created for URI: " + requestURI + " | User-Agent: " + userAgent);
                }
                
                // Kiểm tra xem session này đã được đếm chưa
                Boolean counted = (Boolean) session.getAttribute(VISITOR_COUNTED);
                
                if (counted == null || !counted) {
                    // Đánh dấu session này đã được đếm
                    session.setAttribute(VISITOR_COUNTED, true);
                    
                    // Tăng bộ đếm visitor
                    ServletContext context = request.getServletContext();
                    VisitorCounterListener.incrementVisitorCount(context);
                    System.out.println("[VISITOR FILTER] Visitor counted for URI: " + requestURI + " | Session ID: " + session.getId());
                }
            } else {
                if (isStaticResource(requestURI)) {
                    System.out.println("[VISITOR FILTER] Skipped static resource: " + requestURI);
                } else {
                    System.out.println("[VISITOR FILTER] Skipped non-browser request: " + requestURI + " | User-Agent: " + userAgent);
                }
            }
        }
        
        // Tiếp tục xử lý request
        chain.doFilter(request, response);
    }
    
    /**
     * Kiểm tra xem request có phải là static resource không
     */
    private boolean isStaticResource(String uri) {
        return uri.endsWith(".css") || 
               uri.endsWith(".js") || 
               uri.endsWith(".png") || 
               uri.endsWith(".jpg") || 
               uri.endsWith(".jpeg") || 
               uri.endsWith(".gif") || 
               uri.endsWith(".ico") ||
               uri.endsWith(".svg") ||
               uri.endsWith(".woff") ||
               uri.endsWith(".woff2") ||
               uri.endsWith(".ttf") ||
               uri.contains("/favicon");
    }
    
    /**
     * Kiểm tra xem request có phải từ browser thực sự không
     * Chỉ đếm requests từ các browsers phổ biến
     */
    private boolean isValidUserRequest(String userAgent) {
        if (userAgent == null || userAgent.isEmpty()) {
            return false;
        }
        
        // Chỉ chấp nhận requests từ browsers phổ biến
        return userAgent.contains("Mozilla") || 
               userAgent.contains("Chrome") || 
               userAgent.contains("Safari") || 
               userAgent.contains("Firefox") || 
               userAgent.contains("Edge") || 
               userAgent.contains("Opera");
    }
}
