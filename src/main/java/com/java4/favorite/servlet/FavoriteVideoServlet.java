package com.java4.favorite.servlet;

import com.java4.favorite.entity.Favorite;
import com.java4.user.dao.UserDAO;
import com.java4.user.dao.UserDAOImpl;
import com.java4.user.entity.User;
import com.java4.video.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/favorite/list")
public class FavoriteVideoServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UserDAO userDAO = new UserDAOImpl();
        String userId = req.getParameter("userId");
        
        if (userId == null || userId.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "userId parameter is required");
            return;
        }
        
        User user = userDAO.findById(userId);
        
        if (user != null) {
            List<Video> videos = user.getFavorites().stream()
                    .map(Favorite::getVideo)
                    .collect(Collectors.toList());
            
            req.setAttribute("user", user);
            req.setAttribute("videos", videos);
            req.getRequestDispatcher("/views/favorite/favorite_list.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "User not found");
        }
    }
}
