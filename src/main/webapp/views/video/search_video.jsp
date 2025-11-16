<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Search Video</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .search-box {
            background-color: #f8f9fa;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .search-form {
            display: flex;
            gap: 10px;
        }

        .search-input {
            flex: 1;
            padding: 12px 20px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 10px rgba(102, 126, 234, 0.2);
        }

        .btn-search {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-search:active {
            transform: translateY(0);
        }

        .message {
            padding: 15px 20px;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            border-radius: 6px;
            margin-bottom: 20px;
            font-weight: bold;
            text-align: center;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        table thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        table th {
            padding: 15px;
            text-align: left;
            font-weight: bold;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        table td {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
        }

        table tbody tr {
            transition: all 0.2s ease;
        }

        table tbody tr:hover {
            background-color: #f8f9fa;
            transform: scale(1.01);
        }

        .video-title {
            font-weight: bold;
            color: #333;
            font-size: 15px;
        }

        .likes-count {
            color: #e74c3c;
            font-weight: bold;
            font-size: 16px;
        }

        .badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
            text-transform: uppercase;
        }

        .badge-active {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .badge-inactive {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .no-results {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            font-size: 18px;
        }

        .no-results-icon {
            font-size: 48px;
            margin-bottom: 15px;
        }

        .text-center {
            text-align: center;
        }

        .like-icon {
            color: #e74c3c;
            margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>
            <span>🔍</span> Search Videos
        </h1>

        <div class="search-box">
            <form method="get" action="${pageContext.request.contextPath}/video/search" class="search-form">
                <input type="text" 
                       name="keyword" 
                       class="search-input" 
                       placeholder="Enter keyword to search videos..." 
                       value="${keyword}"
                       required />
                <button type="submit" class="btn-search">🔍 Search</button>
            </form>
        </div>

        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty videos}">
                <table>
                    <thead>
                        <tr>
                            <th>Tiêu đề Video</th>
                            <th class="text-center">Số lượt thích</th>
                            <th class="text-center">Còn hiệu lực</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="video" items="${videos}">
                            <tr>
                                <td class="video-title">${video.title}</td>
                                <td class="text-center">
                                    <span class="likes-count">
                                        <span class="like-icon">❤️</span>
                                        ${fn:length(video.favorites)}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${video.active}">
                                            <span class="badge badge-active">✓ Active</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-inactive">✗ Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:when test="${not empty keyword}">
                <div class="no-results">
                    <div class="no-results-icon">🔍</div>
                    <div>No videos found for keyword: "<strong>${keyword}</strong>"</div>
                    <div style="margin-top: 10px; font-size: 14px;">Try searching with different keywords.</div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-results">
                    <div class="no-results-icon">🎬</div>
                    <div>Enter a keyword to search for videos</div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
