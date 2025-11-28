package com.java4.utils;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

public class RestIO {
    
    private static final ObjectMapper objectMapper = new ObjectMapper();
    
    /**
     * Đọc JSON từ request body và chuyển đổi thành Java Object
     */
    public static <T> T readJson(HttpServletRequest request, Class<T> clazz) throws IOException {
        StringBuilder buffer = new StringBuilder();
        BufferedReader reader = request.getReader();
        String line;
        while ((line = reader.readLine()) != null) {
            buffer.append(line);
        }
        String json = buffer.toString();
        return objectMapper.readValue(json, clazz);
    }
    
    /**
     * Ghi Java Object ra response dưới dạng JSON
     */
    public static void writeJson(HttpServletResponse response, Object object) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String json = objectMapper.writeValueAsString(object);
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
    
    /**
     * Chuyển đổi Java Object thành chuỗi JSON
     */
    public static String toJson(Object object) throws IOException {
        return objectMapper.writeValueAsString(object);
    }
    
    /**
     * Chuyển đổi chuỗi JSON thành Java Object
     */
    public static <T> T fromJson(String json, Class<T> clazz) throws IOException {
        return objectMapper.readValue(json, clazz);
    }
    
    /**
     * Gửi response lỗi dưới dạng JSON
     */
    public static void sendError(HttpServletResponse response, int status, String message) throws IOException {
        response.setStatus(status);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String json = String.format("{\"error\":\"%s\"}", escapeJson(message));
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
    
    /**
     * Gửi response thành công với message và data
     */
    public static void sendSuccess(HttpServletResponse response, String message, Object data) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String dataJson = objectMapper.writeValueAsString(data);
        String json = String.format("{\"message\":\"%s\",\"data\":%s}", escapeJson(message), dataJson);
        
        PrintWriter out = response.getWriter();
        out.print(json);
        out.flush();
    }
    
    /**
     * Escape các ký tự đặc biệt trong JSON string
     */
    private static String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}
