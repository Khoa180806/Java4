package com.java4.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet({
    "/account/sign-up",
    "/account/change-password",
    "/account/edit-profile"
})
public class AccountServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        String message = "";
        
        if (path.contains("sign-up")) {
            message = "Sign Up Page";
        } else if (path.contains("change-password")) {
            message = "Change Password Page";
        } else if (path.contains("edit-profile")) {
            message = "Edit Profile Page";
        }
        
        req.setAttribute("message", message);
        req.getRequestDispatcher("/views/demo/page.jsp").forward(req, resp);
    }
}

