<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>User Login</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .login-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .message {
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-weight: bold;
            text-align: center;
        }

        .message.success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #555;
            font-weight: bold;
            font-size: 14px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 8px rgba(102, 126, 234, 0.3);
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .helper-text {
            text-align: center;
            margin-top: 15px;
            color: #666;
            font-size: 13px;
        }

        .user-info {
            background-color: #f0f4ff;
            padding: 15px;
            border-radius: 4px;
            margin-bottom: 20px;
        }

        .user-info p {
            margin: 5px 0;
            color: #333;
        }

        .user-info strong {
            color: #667eea;
        }

        .logout-btn {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 16px;
            background-color: #f44336;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #da190b;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>🔐 User Login</h2>

        <c:if test="${not empty message}">
            <div class="message ${messageType}">${message}</div>
        </c:if>

        <c:if test="${not empty user}">
            <div class="user-info">
                <p><strong>User ID:</strong> ${user.id}</p>
                <p><strong>Fullname:</strong> ${user.fullname}</p>
                <p><strong>Email:</strong> ${user.email}</p>
                <p><strong>Role:</strong> ${user.admin ? 'Admin' : 'User'}</p>
            </div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/user/login">
            <div class="form-group">
                <label for="username">Username or Email</label>
                <input type="text" id="username" name="username" 
                       placeholder="Enter your username or email" 
                       value="${username}" 
                       required />
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" 
                       placeholder="Enter your password" 
                       required />
            </div>

            <button type="submit" class="btn-login">Login</button>

            <p class="helper-text">
                You can login with your <strong>Username (ID)</strong> or <strong>Email</strong>
            </p>
        </form>
    </div>
</body>
</html>
