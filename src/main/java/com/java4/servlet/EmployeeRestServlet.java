package com.java4.servlet;

import com.java4.entity.Employee;
import com.java4.utils.RestIO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/api/employees/*")
public class EmployeeRestServlet extends HttpServlet {
    
    private static final Map<String, Employee> employees = new LinkedHashMap<>();
    
    static {
        employees.put("TeoNV", new Employee("TeoNV", "Nguyễn Văn Tèo", true, 950.5));
        employees.put("TyNV", new Employee("TyNV", "Nguyễn Văn Tý", true, 850.0));
        employees.put("BinhNV", new Employee("BinhNV", "Nguyễn Văn Bình", true, 1050.75));
        employees.put("HoaNTK", new Employee("HoaNTK", "Nguyễn Thị Khánh Hoa", false, 1200.0));
        employees.put("LanPTH", new Employee("LanPTH", "Phạm Thị Hồng Lan", false, 980.5));
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                List<Employee> employeeList = new ArrayList<>(employees.values());
                RestIO.writeJson(resp, employeeList);
            } else {
                String id = pathInfo.substring(1);
                Employee employee = employees.get(id);
                
                if (employee == null) {
                    RestIO.sendError(resp, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy nhân viên");
                } else {
                    RestIO.writeJson(resp, employee);
                }
            }
        } catch (Exception e) {
            RestIO.sendError(resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Employee employee = RestIO.readJson(req, Employee.class);
            
            if (employee.getManv() == null || employee.getManv().isEmpty()) {
                RestIO.sendError(resp, HttpServletResponse.SC_BAD_REQUEST, "Mã nhân viên không được để trống");
                return;
            }
            
            if (employees.containsKey(employee.getManv())) {
                RestIO.sendError(resp, HttpServletResponse.SC_CONFLICT, "Nhân viên đã tồn tại");
                return;
            }
            
            employees.put(employee.getManv(), employee);
            
            resp.setStatus(HttpServletResponse.SC_CREATED);
            RestIO.sendSuccess(resp, "Thêm nhân viên thành công", employee);
            
        } catch (Exception e) {
            RestIO.sendError(resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
    
    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                RestIO.sendError(resp, HttpServletResponse.SC_BAD_REQUEST, "Thiếu mã nhân viên trong URL");
                return;
            }
            
            String id = pathInfo.substring(1);
            
            if (!employees.containsKey(id)) {
                RestIO.sendError(resp, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy nhân viên");
                return;
            }
            
            Employee employee = RestIO.readJson(req, Employee.class);
            employee.setManv(id);
            
            employees.put(id, employee);
            
            RestIO.sendSuccess(resp, "Cập nhật nhân viên thành công", employee);
            
        } catch (Exception e) {
            RestIO.sendError(resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                RestIO.sendError(resp, HttpServletResponse.SC_BAD_REQUEST, "Thiếu mã nhân viên trong URL");
                return;
            }
            
            String id = pathInfo.substring(1);
            
            if (!employees.containsKey(id)) {
                RestIO.sendError(resp, HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy nhân viên");
                return;
            }
            
            Employee removed = employees.remove(id);
            
            RestIO.sendSuccess(resp, "Xóa nhân viên thành công", removed);
            
        } catch (Exception e) {
            RestIO.sendError(resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}

