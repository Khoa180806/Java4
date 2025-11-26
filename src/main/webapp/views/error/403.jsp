<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>403 - Access Denied</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .error-container {
            background-color: white;
            padding: 60px 40px;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            text-align: center;
            max-width: 600px;
        }

        .error-icon {
            font-size: 100px;
            margin-bottom: 20px;
        }

        .error-code {
            font-size: 72px;
            font-weight: bold;
            color: #f44336;
            margin-bottom: 20px;
        }

        .error-title {
            font-size: 32px;
            color: #333;
            margin-bottom: 15px;
        }

        .error-message {
            font-size: 18px;
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .user-info {
            background-color: #fff3cd;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 30px;
            color: #856404;
            font-weight: bold;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 30px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-secondary {
            background-color: #f5f5f5;
            color: #333;
        }

        .btn-secondary:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">🚫</div>
        <div class="error-code">403</div>
        <h1 class="error-title">Truy cập bị từ chối</h1>
        <p class="error-message">
            Xin lỗi, bạn không có quyền truy cập vào trang này.<br>
            Trang này chỉ dành cho người dùng có vai trò <strong>Quản trị viên (Admin)</strong>.
        </p>
        
        <% if (session.getAttribute("user") != null) { %>
            <div class="user-info">
                👤 Bạn đang đăng nhập với tài khoản không có quyền Admin
            </div>
        <% } %>
        
        <div class="btn-group">
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                🏠 Về trang chủ
            </a>
            <a href="javascript:history.back()" class="btn btn-secondary">
                ← Quay lại
            </a>
        </div>
    </div>
</body>
</html>
