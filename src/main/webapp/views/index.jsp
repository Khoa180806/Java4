<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Java4 Web Application - Home</title>
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
            font-size: 42px;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .header p {
            color: #666;
            font-size: 18px;
        }

        .visitor-counter {
            background-color: #fff3cd;
            padding: 12px 20px;
            margin-top: 20px;
            border-radius: 8px;
            border: 1px solid #ffc107;
            text-align: center;
            color: #856404;
            font-weight: bold;
            font-size: 16px;
        }

        .user-info-header {
            background-color: #e8f5e9;
            padding: 15px 20px;
            margin-top: 15px;
            border-radius: 8px;
            border: 1px solid #4CAF50;
            color: #2e7d32;
            font-weight: bold;
            font-size: 16px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .user-info-header a {
            color: #f44336;
            text-decoration: none;
            padding: 8px 16px;
            background-color: white;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .user-info-header a:hover {
            background-color: #f44336;
            color: white;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }

        .feature-card {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            display: block;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.25);
        }

        .feature-card:hover::before {
            transform: scaleX(1);
        }

        .feature-icon {
            font-size: 48px;
            margin-bottom: 15px;
            display: block;
        }

        .feature-card h3 {
            color: #333;
            font-size: 22px;
            margin-bottom: 10px;
        }

        .feature-card p {
            color: #666;
            font-size: 14px;
            line-height: 1.6;
        }

        .category {
            margin-top: 40px;
        }

        .category-title {
            color: white;
            font-size: 28px;
            margin-bottom: 20px;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
        }

        .login-notice {
            background-color: #fff3cd;
            padding: 15px 20px;
            margin-top: 15px;
            border-radius: 8px;
            border: 1px solid #ffc107;
            color: #856404;
            text-align: center;
            font-size: 14px;
        }

        .login-notice a {
            color: #667eea;
            font-weight: bold;
            text-decoration: none;
        }

        .login-notice a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 28px;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 Java4 Web Application</h1>
            <p>Chào mừng bạn đến với ứng dụng quản lý Video và User</p>
            
            <div class="visitor-counter">
                👥 Số lượt khách viếng thăm: ${applicationScope.visitors}
            </div>

            <c:choose>
                <c:when test="${!empty sessionScope.user}">
                    <div class="user-info-header">
                        <span>👋 Xin chào: ${sessionScope.user.fullname} (${sessionScope.user.admin ? 'Admin' : 'User'})</span>
                        <a href="${pageContext.request.contextPath}/user/logout">Đăng xuất</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="login-notice">
                        ℹ️ Bạn chưa đăng nhập. <a href="${pageContext.request.contextPath}/user/login">Đăng nhập ngay</a> để trải nghiệm đầy đủ tính năng!
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- User Management Section -->
        <div class="category">
            <h2 class="category-title">👤 Quản lý người dùng</h2>
            <div class="features-grid">
                <a href="${pageContext.request.contextPath}/user/login" class="feature-card">
                    <span class="feature-icon">🔐</span>
                    <h3>Đăng nhập</h3>
                    <p>Đăng nhập vào hệ thống với username và password. Hỗ trợ session để duy trì đăng nhập.</p>
                </a>

                <a href="${pageContext.request.contextPath}/user/crud/index" class="feature-card">
                    <span class="feature-icon">👥</span>
                    <h3>Quản lý User (CRUD)</h3>
                    <p>Thêm, sửa, xóa và xem danh sách người dùng. Quản lý thông tin cá nhân và quyền Admin.</p>
                </a>
            </div>
        </div>

        <!-- Video Management Section -->
        <div class="category">
            <h2 class="category-title">🎬 Quản lý Video</h2>
            <div class="features-grid">
                <a href="${pageContext.request.contextPath}/video/search" class="feature-card">
                    <span class="feature-icon">🔍</span>
                    <h3>Tìm kiếm Video</h3>
                    <p>Tìm kiếm video theo từ khóa. Xem số lượt thích và trạng thái của từng video.</p>
                </a>
            </div>
        </div>

        <!-- Favorites Section -->
        <div class="category">
            <h2 class="category-title">❤️ Video yêu thích</h2>
            <div class="features-grid">
                <a href="${pageContext.request.contextPath}/favorite/list" class="feature-card">
                    <span class="feature-icon">⭐</span>
                    <h3>Danh sách Yêu thích</h3>
                    <p>Xem danh sách video yêu thích của một người dùng cụ thể.</p>
                </a>

                <a href="${pageContext.request.contextPath}/favorite/all" class="feature-card">
                    <span class="feature-icon">💝</span>
                    <h3>Tất cả Yêu thích</h3>
                    <p>Xem tổng hợp tất cả video đã được yêu thích bởi các người dùng.</p>
                </a>
            </div>
        </div>

        <!-- Share & Reports Section -->
        <div class="category">
            <h2 class="category-title">📊 Báo cáo & Thống kê</h2>
            <div class="features-grid">
                <a href="${pageContext.request.contextPath}/share/report" class="feature-card">
                    <span class="feature-icon">📈</span>
                    <h3>Báo cáo Chia sẻ</h3>
                    <p>Thống kê số lượt chia sẻ video. Xem ngày chia sẻ đầu tiên và cuối cùng của mỗi video.</p>
                </a>

                <a href="${pageContext.request.contextPath}/logs" class="feature-card">
                    <span class="feature-icon">📋</span>
                    <h3>Lịch sử Truy cập</h3>
                    <p>Xem lịch sử truy cập website của người dùng đã đăng nhập. Filter theo username.</p>
                </a>

                <a href="${pageContext.request.contextPath}/filter-test" class="feature-card">
                    <span class="feature-icon">🔍</span>
                    <h3>Filter Demo</h3>
                    <p>Demo hoạt động của Filter1 và Filter2. Kiểm tra thứ tự thực thi của các filter.</p>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
