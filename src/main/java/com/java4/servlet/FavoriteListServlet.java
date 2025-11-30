package com.java4.servlet;

import com.java4.dao.FavoriteDAO;
import com.java4.dao.FavoriteDAOImpl;
import com.java4.entity.Favorite;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/favorite/all")
public class FavoriteListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        FavoriteDAO favoriteDAO = new FavoriteDAOImpl();
        
        List<Favorite> favorites = favoriteDAO.findAll();
        
        req.setAttribute("favorites", favorites);
        req.getRequestDispatcher("/views/favorite/favorite_all.jsp").forward(req, resp);
    }
}

