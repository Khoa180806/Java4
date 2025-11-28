package com.java4.ajax.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/api/employee")
public class EmployeeServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        
        String jsonData = "{\n" +
                "    \"manv\": \"TeoNV\",\n" +
                "    \"hoTen\": \"Nguyễn Văn Tèo\",\n" +
                "    \"gioiTinh\": true,\n" +
                "    \"luong\": 950.5\n" +
                "}";
        
        PrintWriter out = resp.getWriter();
        out.print(jsonData);
        out.flush();
    }
}
