package com.java4.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import org.apache.commons.beanutils.BeanUtils;

import com.java4.dao.UserDAO;
import com.java4.dao.UserDAOImpl;
import com.java4.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet({
                "/user/crud/index",
                "/user/crud/edit/*",
                "/user/crud/create",
                "/user/crud/update",
                "/user/crud/delete",
                "/user/crud/reset"
})
public class UserDAOServlet extends HttpServlet {
        static UserDAO user = new UserDAOImpl();

        @Override
        protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
                User form = new User();
                try {
                        BeanUtils.populate(form, req.getParameterMap());
                } catch (IllegalAccessException | InvocationTargetException e) {
                        e.printStackTrace();
                }
                String message = "Enter user information";
                String path = req.getServletPath();
                if (path.contains("edit")) {
                        String id = req.getPathInfo().substring(1);
                        message = "Edit: " + id;
                        form = user.findById(id);
                } else if (path.contains("create")) {
                        message = "Create: " + form.getId();
                        user.create(form);
                } else if (path.contains("update")) {
                        // First get the existing user
                        User existingUser = user.findById(form.getId());
                        if (existingUser != null) {
                                // Update the existing user's fields
                                existingUser.setFullname(form.getFullname());
                                existingUser.setEmail(form.getEmail());
                                existingUser.setPassword(form.getPassword());
                                existingUser.setAdmin(form.getAdmin());

                                // Now update
                                user.update(existingUser);
                                message = "Update: " + form.getId();
                        }
                } else if (path.contains("delete")) {
                        message = "Delete: " + form.getId();
                        user.deleteById(form.getId());
                } else if (path.contains("reset")) {
                        form = new User();
                }
                List<User> list = user.findAll();

                req.setAttribute("message", message);
                req.setAttribute("user", form);
                req.setAttribute("users", list);
                req.getRequestDispatcher("/views/user_crud.jsp").forward(req, resp);
        }
}
