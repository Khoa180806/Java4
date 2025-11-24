package com.java4.listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.*;

/**
 * Listener theo dõi số lượng người truy cập ứng dụng
 * Lưu trữ số lượng visitor vào file để duy trì giữa các lần khởi động lại ứng dụng
 */
@WebListener
public class VisitorCounterListener implements ServletContextListener {
    
    // Tên file lưu trữ số lượng visitor
    private static final String VISITORS_FILE = "visitors.txt";
    // Tên thuộc tính lưu trong ServletContext
    private static final String VISITORS_ATTR = "visitors";
    
    /**
     * Được gọi khi ứng dụng được khởi tạo
     * Tải số lượng visitor từ file và lưu vào ServletContext
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        // Lấy đối tượng ServletContext
        ServletContext context = sce.getServletContext();
        
        // Tải số lượng visitor từ file
        long visitors = loadVisitorCount(context);
        
        // Lưu số lượng visitor vào ServletContext
        context.setAttribute(VISITORS_ATTR, visitors);
        
        System.out.println("Application started. Current visitor count: " + visitors);
    }
    
    /**
     * Được gọi khi ứng dụng bị hủy
     * Lưu số lượng visitor hiện tại vào file
     */
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        
        // Lấy số lượng visitor từ ServletContext
        Long visitors = (Long) context.getAttribute(VISITORS_ATTR);
        if (visitors != null) {
            // Lưu số lượng visitor vào file
            saveVisitorCount(context, visitors);
            System.out.println("Application stopped. Visitor count saved: " + visitors);
        }
    }
    
    /**
     * Tăng số lượng visitor
     * Method này được gọi từ Filter khi có visitor mới
     */
    public static void incrementVisitorCount(ServletContext context) {
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
    
    /**
     * Đọc số lượng visitor từ file
     * 
     * @param context Đối tượng ServletContext
     * @return Số lượng visitor đã lưu, hoặc 0 nếu có lỗi hoặc file không tồn tại
     */
    private long loadVisitorCount(ServletContext context) {
        // Lấy đường dẫn thực tế đến file lưu trữ
        String filePath = context.getRealPath("/WEB-INF/" + VISITORS_FILE);
        File file = new File(filePath);
        
        // Nếu file không tồn tại, trả về 0
        if (!file.exists()) {
            return 0L;
        }
        
        // Đọc số lượng visitor từ file
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line = reader.readLine();
            if (line != null && !line.trim().isEmpty()) {
                return Long.parseLong(line.trim());
            }
        } catch (IOException | NumberFormatException e) {
            System.err.println("Error reading visitor count: " + e.getMessage());
        }
        
        // Trả về 0 nếu có lỗi xảy ra
        return 0L;
    }
    
    /**
     * Lưu số lượng visitor vào file
     * 
     * @param context Đối tượng ServletContext
     * @param visitors Số lượng visitor cần lưu
     */
    private void saveVisitorCount(ServletContext context, long visitors) {
        // Lấy đường dẫn thực tế đến file lưu trữ
        String filePath = context.getRealPath("/WEB-INF/" + VISITORS_FILE);
        File file = new File(filePath);
        
        // Đảm bảo thư mục cha tồn tại
        File parentDir = file.getParentFile();
        if (!parentDir.exists()) {
            parentDir.mkdirs();
        }
        
        // Ghi số lượng visitor vào file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(file))) {
            writer.write(String.valueOf(visitors));
            System.out.println("Visitor count saved to: " + filePath);
        } catch (IOException e) {
            System.err.println("Error saving visitor count: " + e.getMessage());
        }
    }
}
