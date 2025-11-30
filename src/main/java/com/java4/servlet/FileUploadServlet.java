package com.java4.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/api/upload")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class FileUploadServlet extends HttpServlet {
    
    private static final String UPLOAD_DIR = "uploads";
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        PrintWriter out = resp.getWriter();
        
        try {
            System.out.println("FileUploadServlet: Received upload request");
            
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
                System.out.println("Created upload directory: " + uploadPath);
            }
            
            Part filePart = req.getPart("file");
            
            if (filePart == null || filePart.getSize() == 0) {
                System.out.println("No file uploaded");
                out.print("{\"error\": \"No file uploaded\"}");
                resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
            
            String fileName = getFileName(filePart);
            String filePath = uploadPath + File.separator + fileName;
            
            System.out.println("Uploading file: " + fileName + " (" + filePart.getSize() + " bytes)");
            
            filePart.write(filePath);
            
            String contentType = filePart.getContentType();
            long fileSize = filePart.getSize();
            
            String jsonResponse = String.format(
                "{\n" +
                "    \"name\": \"%s\",\n" +
                "    \"type\": \"%s\",\n" +
                "    \"size\": %d\n" +
                "}",
                escapeJson(fileName),
                escapeJson(contentType != null ? contentType : "unknown"),
                fileSize
            );
            
            System.out.println("Sending response: " + jsonResponse);
            
            resp.setStatus(HttpServletResponse.SC_OK);
            out.print(jsonResponse);
            
        } catch (Exception e) {
            System.err.println("Error uploading file: " + e.getMessage());
            e.printStackTrace();
            out.print("{\"error\": \"" + escapeJson(e.getMessage()) + "\"}");
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        } finally {
            out.flush();
        }
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
    
    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}

