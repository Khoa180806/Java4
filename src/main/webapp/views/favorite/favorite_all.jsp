<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách Video Yêu thích</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1000px;
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
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background-color: #4CAF50;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
        }
        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .no-data {
            text-align: center;
            color: #888;
            padding: 20px;
            font-style: italic;
        }
        .video-title {
            font-weight: bold;
            color: #333;
        }
        .user-name {
            color: #666;
        }
        .date {
            color: #888;
            font-size: 14px;
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

        <h1>Danh sách Video đã được Yêu thích</h1>
        
        <c:choose>
            <c:when test="${not empty favorites}">
                <table>
                    <thead>
                        <tr>
                            <th>Video Title</th>
                            <th>Người thích</th>
                            <th>Ngày thích</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="favorite" items="${favorites}">
                            <tr>
                                <td class="video-title">${favorite.video.title}</td>
                                <td class="user-name">${favorite.user.fullname}</td>
                                <td class="date">
                                    <fmt:formatDate value="${favorite.likeDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="no-data">Chưa có video nào được yêu thích</div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
