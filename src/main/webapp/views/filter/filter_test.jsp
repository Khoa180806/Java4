<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Filter Test</title>
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
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
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

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 10px;
            font-size: 36px;
        }

        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
            font-size: 16px;
        }

        .info-box {
            background-color: #e7f3ff;
            padding: 20px;
            border-radius: 8px;
            border-left: 5px solid #2196F3;
            margin-bottom: 20px;
        }

        .info-box h3 {
            color: #1976D2;
            margin-bottom: 10px;
            font-size: 20px;
        }

        .info-box p {
            color: #555;
            line-height: 1.8;
            margin-bottom: 8px;
        }

        .success-box {
            background-color: #e8f5e9;
            padding: 20px;
            border-radius: 8px;
            border-left: 5px solid #4CAF50;
            margin-bottom: 20px;
        }

        .success-box h3 {
            color: #2e7d32;
            margin-bottom: 10px;
            font-size: 20px;
        }

        .attribute-value {
            background-color: #fff;
            padding: 15px 20px;
            border-radius: 6px;
            border: 2px solid #4CAF50;
            font-size: 18px;
            font-weight: bold;
            color: #2e7d32;
            text-align: center;
            margin-top: 10px;
        }

        .code-box {
            background-color: #f5f5f5;
            padding: 15px;
            border-radius: 6px;
            border: 1px solid #ddd;
            margin-top: 10px;
            font-family: 'Courier New', monospace;
            font-size: 14px;
            color: #333;
            overflow-x: auto;
        }

        .warning-box {
            background-color: #fff3cd;
            padding: 15px 20px;
            border-radius: 6px;
            border: 1px solid #ffc107;
            color: #856404;
            margin-top: 20px;
        }

        .flow-diagram {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }

        .flow-step {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 20px;
            border-radius: 6px;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .flow-step .number {
            background-color: white;
            color: #667eea;
            width: 35px;
            height: 35px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 18px;
        }

        .arrow {
            text-align: center;
            color: #667eea;
            font-size: 24px;
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="back-home">← Về trang chủ</a>
        
        <h1>🔍 Filter Test Page</h1>
        <p class="subtitle">Kiểm tra hoạt động của Filter1 và Filter2</p>

        <div class="success-box">
            <h3>✅ Kết quả Filter</h3>
            <p>Giá trị của attribute "hello" được set bởi Filter1:</p>
            <div class="attribute-value">
                ${hello}
            </div>
        </div>

        <div class="info-box">
            <h3>📋 Thông tin Filter</h3>
            <p><strong>Filter1:</strong> Set attribute "hello" = "Tôi là filter 1"</p>
            <p><strong>Filter2:</strong> In ra console giá trị của attribute "hello"</p>
            <p><strong>Thứ tự thực thi:</strong> Filter1 → Filter2 → Servlet</p>
        </div>

        <div class="flow-diagram">
            <h3 style="color: #333; margin-bottom: 15px;">🔄 Luồng xử lý Request</h3>
            
            <div class="flow-step">
                <div class="number">1</div>
                <div>
                    <strong>Client gửi Request</strong><br>
                    <span style="font-size: 13px; opacity: 0.9;">GET /filter-test</span>
                </div>
            </div>
            
            <div class="arrow">↓</div>
            
            <div class="flow-step">
                <div class="number">2</div>
                <div>
                    <strong>Filter1 thực thi</strong><br>
                    <span style="font-size: 13px; opacity: 0.9;">req.setAttribute("hello", "Tôi là filter 1")</span>
                </div>
            </div>
            
            <div class="arrow">↓</div>
            
            <div class="flow-step">
                <div class="number">3</div>
                <div>
                    <strong>Filter2 thực thi</strong><br>
                    <span style="font-size: 13px; opacity: 0.9;">System.out.println(req.getAttribute("hello"))</span>
                </div>
            </div>
            
            <div class="arrow">↓</div>
            
            <div class="flow-step">
                <div class="number">4</div>
                <div>
                    <strong>Servlet xử lý</strong><br>
                    <span style="font-size: 13px; opacity: 0.9;">Forward đến JSP và hiển thị attribute</span>
                </div>
            </div>
        </div>

        <div class="info-box">
            <h3>⚙️ Cấu hình trong web.xml</h3>
            <div class="code-box">
&lt;!-- Filter Definitions --&gt;<br>
&lt;filter&gt;<br>
&nbsp;&nbsp;&lt;filter-name&gt;Filter1&lt;/filter-name&gt;<br>
&nbsp;&nbsp;&lt;filter-class&gt;com.java4.filter.Filter1&lt;/filter-class&gt;<br>
&lt;/filter&gt;<br>
<br>
&lt;filter&gt;<br>
&nbsp;&nbsp;&lt;filter-name&gt;Filter2&lt;/filter-name&gt;<br>
&nbsp;&nbsp;&lt;filter-class&gt;com.java4.filter.Filter2&lt;/filter-class&gt;<br>
&lt;/filter&gt;<br>
<br>
&lt;!-- Filter Mappings - Thứ tự quan trọng! --&gt;<br>
&lt;filter-mapping&gt;<br>
&nbsp;&nbsp;&lt;filter-name&gt;Filter1&lt;/filter-name&gt;<br>
&nbsp;&nbsp;&lt;url-pattern&gt;/*&lt;/url-pattern&gt;<br>
&lt;/filter-mapping&gt;<br>
<br>
&lt;filter-mapping&gt;<br>
&nbsp;&nbsp;&lt;filter-name&gt;Filter2&lt;/filter-name&gt;<br>
&nbsp;&nbsp;&lt;url-pattern&gt;/*&lt;/url-pattern&gt;<br>
&lt;/filter-mapping&gt;
            </div>
        </div>

        <div class="warning-box">
            <strong>💡 Lưu ý:</strong> Kiểm tra console của server để xem output từ Filter2. 
            Bạn sẽ thấy dòng text: "Filter2: Tôi là filter 1"
        </div>
    </div>
</body>
</html>
