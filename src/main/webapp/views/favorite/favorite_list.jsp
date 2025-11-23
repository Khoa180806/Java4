<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Favorite Videos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
        }
        h2 {
            color: #666;
            margin-top: 20px;
        }
        .video-list {
            list-style: none;
            padding: 0;
        }
        .video-item {
            padding: 15px;
            margin: 10px 0;
            background-color: #f9f9f9;
            border-left: 4px solid #4CAF50;
            border-radius: 4px;
        }
        .video-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
        }
        .video-date {
            font-size: 14px;
            color: #888;
            margin-top: 5px;
        }
        .no-favorites {
            text-align: center;
            color: #888;
            padding: 20px;
            font-style: italic;
        }
        .user-info-header {
            background-color: #e8f5e9;
            padding: 12px 20px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #4CAF50;
            color: #2e7d32;
            font-weight: bold;
        }
        .visitor-counter {
            background-color: #fff3cd;
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            border: 1px solid #ffc107;
            text-align: center;
            color: #856404;
            font-weight: bold;
        }
        .back-home {
            display: inline-block;
            margin-bottom: 15px;
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        .back-home:hover {
            color: #764ba2;
            transform: translateX(-5px);
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="back-home">← Về trang chủ</a>

        <div class="visitor-counter">
            👥 Số lượt khách viếng thăm: ${applicationScope.visitors}
        </div>

        <c:if test="${!empty sessionScope.user}">
            <div class="user-info-header">
                Xin chào: ${sessionScope.user.fullname}
            </div>
        </c:if>

        <h1>Tên người dùng: ${user.fullname}</h1>
        <h2>Các video yêu thích</h2>
        
        <c:choose>
            <c:when test="${not empty videos}">
                <ul class="video-list">
                    <c:forEach var="favorite" items="${user.favorites}">
                        <li class="video-item">
                            <div class="video-title">${favorite.video.title}</div>
                        </li>
                    </c:forEach>
                </ul>
            </c:when>
            <c:otherwise>
                <div class="no-favorites">Người dùng chưa có video yêu thích nào</div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
