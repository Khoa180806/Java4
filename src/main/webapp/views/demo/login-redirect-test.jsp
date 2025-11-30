<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test Login Redirect</title>
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
            max-width: 900px;
            margin: 0 auto;
        }

        .header {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            margin-bottom: 30px;
            text-align: center;
        }

        .header h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 10px;
        }

        .header p {
            color: #666;
            font-size: 16px;
            line-height: 1.6;
        }

        .info-box {
            background-color: #e8f5e9;
            padding: 20px;
            margin-top: 20px;
            border-radius: 8px;
            border: 1px solid #4CAF50;
        }

        .info-box h3 {
            color: #2e7d32;
            margin-bottom: 10px;
        }

        .info-box p {
            color: #1b5e20;
            margin: 5px 0;
        }

        .test-section {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
            margin-bottom: 20px;
        }

        .test-section h2 {
            color: #333;
            margin-bottom: 20px;
            border-bottom: 2px solid #667eea;
            padding-bottom: 10px;
        }

        .test-list {
            list-style: none;
        }

        .test-list li {
            margin-bottom: 15px;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }

        .test-list li strong {
            color: #667eea;
            display: block;
            margin-bottom: 5px;
        }

        .test-list a {
            display: inline-block;
            margin-top: 8px;
            padding: 8px 16px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
            transition: all 0.3s ease;
        }

        .test-list a:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #f5f5f5;
            color: #333;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .back-link:hover {
            background-color: #e0e0e0;
        }

        .success-badge {
            display: inline-block;
            padding: 6px 12px;
            background-color: #4CAF50;
            color: white;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            margin-left: 10px;
        }

        .step-box {
            background-color: #fff3cd;
            padding: 15px;
            margin: 15px 0;
            border-radius: 8px;
            border: 1px solid #ffc107;
        }

        .step-box ol {
            margin-left: 20px;
            color: #856404;
        }

        .step-box ol li {
            margin: 8px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🧪 Test Chức Năng Login Redirect</h1>
            <p>Trang này giúp bạn kiểm tra chức năng đăng nhập và tự động quay lại trang được yêu cầu</p>
            
            <c:choose>
                <c:when test="${!empty sessionScope.user}">
                    <div class="info-box">
                        <h3>✅ Bạn đã đăng nhập</h3>
                        <p>👤 <strong>Username:</strong> ${sessionScope.user.id}</p>
                        <p>📧 <strong>Email:</strong> ${sessionScope.user.email}</p>
                        <p>🏷️ <strong>Role:</strong> ${sessionScope.user.admin ? 'Admin' : 'User'}</p>
                        <a href="${pageContext.request.contextPath}/user/logout" class="back-link">Đăng xuất</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="step-box">
                        <h3>📋 Hướng dẫn test:</h3>
                        <ol>
                            <li>Nhấn vào một link test bên dưới (chưa cần đăng nhập)</li>
                            <li>Hệ thống sẽ chuyển bạn đến trang đăng nhập</li>
                            <li>Đăng nhập thành công</li>
                            <li>Hệ thống sẽ TỰ ĐỘNG đưa bạn về trang bạn đã yêu cầu trước đó</li>
                        </ol>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <div class="test-section">
            <h2>🔐 Test Account Management (Yêu cầu đăng nhập)</h2>
            <ul class="test-list">
                <li>
                    <strong>Đổi mật khẩu</strong>
                    <p>URL: /account/change-password</p>
                    <a href="${pageContext.request.contextPath}/account/change-password">Thử nghiệm →</a>
                </li>
                <li>
                    <strong>Chỉnh sửa hồ sơ</strong>
                    <p>URL: /account/edit-profile</p>
                    <a href="${pageContext.request.contextPath}/account/edit-profile">Thử nghiệm →</a>
                </li>
            </ul>
        </div>

        <div class="test-section">
            <h2>🎬 Test Video Actions (Yêu cầu đăng nhập)</h2>
            <ul class="test-list">
                <li>
                    <strong>Thích video #123</strong>
                    <p>URL: /video/like/123</p>
                    <a href="${pageContext.request.contextPath}/video/like/123">Thử nghiệm →</a>
                </li>
                <li>
                    <strong>Chia sẻ video #456</strong>
                    <p>URL: /video/share/456</p>
                    <a href="${pageContext.request.contextPath}/video/share/456">Thử nghiệm →</a>
                </li>
                <li>
                    <strong>Thích video với query string</strong>
                    <p>URL: /video/like/789?ref=home&source=recommend</p>
                    <a href="${pageContext.request.contextPath}/video/like/789?ref=home&source=recommend">Thử nghiệm →</a>
                </li>
            </ul>
        </div>

        <div class="test-section">
            <h2>🛡️ Test Admin Pages (Yêu cầu đăng nhập + Admin)</h2>
            <ul class="test-list">
                <li>
                    <strong>Quản trị Video</strong>
                    <p>URL: /admin/video</p>
                    <a href="${pageContext.request.contextPath}/admin/video">Thử nghiệm →</a>
                </li>
                <li>
                    <strong>Quản trị User</strong>
                    <p>URL: /admin/user</p>
                    <a href="${pageContext.request.contextPath}/admin/user">Thử nghiệm →</a>
                </li>
                <li>
                    <strong>Quản trị Like</strong>
                    <p>URL: /admin/like</p>
                    <a href="${pageContext.request.contextPath}/admin/like">Thử nghiệm →</a>
                </li>
                <li>
                    <strong>Quản trị Share với query string</strong>
                    <p>URL: /admin/share?page=2&filter=active</p>
                    <a href="${pageContext.request.contextPath}/admin/share?page=2&filter=active">Thử nghiệm →</a>
                </li>
            </ul>
        </div>

        <div class="test-section">
            <h2>📝 Kết quả mong đợi:</h2>
            <ul class="test-list">
                <li style="border-left-color: #4CAF50;">
                    <strong>✅ Trường hợp 1: Chưa đăng nhập</strong>
                    <p>→ Chuyển đến trang login với thông báo "Bạn cần đăng nhập..."</p>
                    <p>→ Sau khi đăng nhập thành công → Tự động quay lại trang đã yêu cầu</p>
                </li>
                <li style="border-left-color: #FF9800;">
                    <strong>⚠️ Trường hợp 2: Đăng nhập User thường + truy cập Admin</strong>
                    <p>→ Hiển thị trang 403 Forbidden</p>
                </li>
                <li style="border-left-color: #4CAF50;">
                    <strong>✅ Trường hợp 3: Đăng nhập Admin</strong>
                    <p>→ Truy cập tất cả trang thành công</p>
                </li>
            </ul>
        </div>

        <a href="${pageContext.request.contextPath}/" class="back-link">← Về trang chủ</a>
    </div>
</body>
</html>
