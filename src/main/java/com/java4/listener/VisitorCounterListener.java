package com.java4.listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.io.*;

@WebListener
public class VisitorCounterListener implements ServletContextListener, HttpSessionListener {
    
    private static final String VISITORS_FILE = "visitors.txt";
    private static final String VISITORS_ATTR = "visitors";
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        
        long visitors = loadVisitorCount(context);
        
        context.setAttribute(VISITORS_ATTR, visitors);
        
        System.out.println("Application started. Current visitor count: " + visitors);
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        
        Long visitors = (Long) context.getAttribute(VISITORS_ATTR);
        if (visitors != null) {
            saveVisitorCount(context, visitors);
            System.out.println("Application stopped. Visitor count saved: " + visitors);
        }
    }
    
    @Override
    public void sessionCreated(HttpSessionEvent se) {
        ServletContext context = se.getSession().getServletContext();
        
        synchronized (context) {
            Long visitors = (Long) context.getAttribute(VISITORS_ATTR);
            if (visitors == null) {
                visitors = 0L;
            }
            visitors++;
            context.setAttribute(VISITORS_ATTR, visitors);
            
            System.out.println("New visitor! Total count: " + visitors);
        }
    }
    
    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        System.out.println("Session destroyed");
    }
    
    private long loadVisitorCount(ServletContext context) {
        String filePath = context.getRealPath("/WEB-INF/" + VISITORS_FILE);
        File file = new File(filePath);
        
        if (!file.exists()) {
            return 0L;
        }
        
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line = reader.readLine();
            if (line != null && !line.trim().isEmpty()) {
                return Long.parseLong(line.trim());
            }
        } catch (IOException | NumberFormatException e) {
            System.err.println("Error reading visitor count: " + e.getMessage());
        }
        
        return 0L;
    }
    
    private void saveVisitorCount(ServletContext context, long visitors) {
        String filePath = context.getRealPath("/WEB-INF/" + VISITORS_FILE);
        File file = new File(filePath);
        
        File parentDir = file.getParentFile();
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }
        
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            writer.write(String.valueOf(visitors));
            System.out.println("Visitor count saved to: " + filePath);
        } catch (IOException e) {
            System.err.println("Error saving visitor count: " + e.getMessage());
        }
    }
}
