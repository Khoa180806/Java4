<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Access Logs</title>
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
            max-width: 1400px;
            margin: 0 auto;
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
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

        .user-info-header {
            background-color: #e8f5e9;
            padding: 12px 20px;
            margin-bottom: 20px;
            border-radius: 6px;
            border: 1px solid #4CAF50;
            color: #2e7d32;
            font-weight: bold;
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 10px;
            font-size: 36px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
        }

        .filter-box {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .filter-form {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .filter-form input {
            flex: 1;
            padding: 12px 20px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
        }

        .filter-form input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 10px rgba(102, 126, 234, 0.2);
        }

        .btn {
            padding: 12px 30px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #6c757d 0%, #495057 100%);
        }

        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 30px;
            text-align: center;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .stats-card h2 {
            font-size: 42px;
            margin-bottom: 5px;
        }

        .stats-card p {
            font-size: 16px;
            opacity: 0.9;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
        }

        table thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        table th {
            padding: 18px 15px;
            text-align: left;
            font-weight: bold;
            font-size: 15px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        table th.text-center {
            text-align: center;
        }

        table td {
            padding: 16px 15px;
            border-bottom: 1px solid #e9ecef;
        }

        table td.text-center {
            text-align: center;
        }

        table tbody tr {
            transition: all 0.2s ease;
        }

        table tbody tr:hover {
            background-color: #f8f9fa;
            transform: scale(1.002);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .log-id {
            font-weight: bold;
            color: #667eea;
            font-size: 16px;
        }

        .log-url {
            color: #333;
            font-size: 14px;
            word-break: break-all;
        }

        .log-username {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 6px 12px;
            border-radius: 15px;
            font-weight: bold;
            font-size: 14px;
            display: inline-block;
        }

        .log-time {
            color: #555;
            font-size: 14px;
        }

        .no-data {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }

        .no-data-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .no-data h2 {
            font-size: 24px;
            margin-bottom: 10px;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
            font-size: 16px;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }

            h1 {
                font-size: 24px;
            }

            table th,
            table td {
                padding: 10px 8px;
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="visitor-counter">
            👥 Số lượt khách viếng thăm: ${applicationScope.visitors}
        </div>

        <c:if test="${!empty sessionScope.user}">
            <div class="user-info-header">
                Xin chào: ${sessionScope.user.fullname}
            </div>
        </c:if>

        <a href="${pageContext.request.contextPath}/" class="back-link">← Về trang chủ</a>

        <h1>
            <span>📋</span> Access Logs
        </h1>
        <p class="subtitle">Lịch sử truy cập website của người dùng đã đăng nhập</p>

        <div class="filter-box">
            <form method="get" action="${pageContext.request.contextPath}/logs" class="filter-form">
                <input type="text" 
                       name="username" 
                       placeholder="Lọc theo username..." 
                       value="${filterUsername}"/>
                <button type="submit" class="btn">🔍 Lọc</button>
                <a href="${pageContext.request.contextPath}/logs" class="btn btn-secondary">🔄 Tất cả</a>
            </form>
        </div>

        <c:if test="${not empty logs}">
            <div class="stats-card">
                <h2>${logs.size()}</h2>
                <p>Tổng số lượt truy cập</p>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th class="text-center">ID</th>
                            <th>URL</th>
                            <th class="text-center">Username</th>
                            <th class="text-center">Thời gian</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="log" items="${logs}">
                            <tr>
                                <td class="text-center">
                                    <span class="log-id">#${log.id}</span>
                                </td>
                                <td>
                                    <div class="log-url">${log.url}</div>
                                </td>
                                <td class="text-center">
                                    <span class="log-username">${log.username}</span>
                                </td>
                                <td class="text-center">
                                    <span class="log-time">
                                        <fmt:formatDate value="${log.time}" pattern="dd/MM/yyyy HH:mm:ss" />
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <c:if test="${empty logs}">
            <div class="no-data">
                <div class="no-data-icon">📭</div>
                <h2>Chưa có dữ liệu log</h2>
                <p>Hiện tại chưa có lượt truy cập nào được ghi nhận</p>
            </div>
        </c:if>
    </div>
</body>
</html>
