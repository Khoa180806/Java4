<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RESTful API - Employee Management</title>
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
            font-size: 32px;
            margin-bottom: 10px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .info {
            color: #666;
            margin-top: 15px;
            padding: 15px;
            background-color: #f0f0f0;
            border-radius: 8px;
            text-align: left;
        }

        .content {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .panel {
            background-color: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
        }

        .panel h2 {
            color: #667eea;
            margin-bottom: 20px;
            font-size: 20px;
            border-bottom: 2px solid #667eea;
            padding-bottom: 10px;
        }

        .api-section {
            margin-bottom: 25px;
        }

        .api-section h3 {
            color: #333;
            font-size: 16px;
            margin-bottom: 10px;
        }

        .api-endpoint {
            background-color: #f5f5f5;
            padding: 8px 12px;
            border-radius: 4px;
            font-family: 'Courier New', monospace;
            font-size: 13px;
            margin-bottom: 10px;
            color: #333;
        }

        .method {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 3px;
            font-weight: bold;
            margin-right: 8px;
        }

        .method.get { background-color: #61affe; color: white; }
        .method.post { background-color: #49cc90; color: white; }
        .method.put { background-color: #fca130; color: white; }
        .method.delete { background-color: #f93e3e; color: white; }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            min-height: 80px;
            font-family: 'Courier New', monospace;
        }

        button {
            padding: 10px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-right: 10px;
            margin-bottom: 10px;
        }

        .btn-get {
            background-color: #61affe;
            color: white;
        }

        .btn-post {
            background-color: #49cc90;
            color: white;
        }

        .btn-put {
            background-color: #fca130;
            color: white;
        }

        .btn-delete {
            background-color: #f93e3e;
            color: white;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        #result {
            background-color: #f5f5f5;
            padding: 20px;
            border-radius: 8px;
            min-height: 200px;
            max-height: 600px;
            overflow-y: auto;
        }

        #result h3 {
            color: #667eea;
            margin-bottom: 10px;
        }

        pre {
            background-color: #272822;
            color: #f8f8f2;
            padding: 15px;
            border-radius: 6px;
            overflow-x: auto;
            font-size: 13px;
            line-height: 1.5;
        }

        .status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 4px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .status.success { background-color: #d4edda; color: #155724; }
        .status.error { background-color: #f8d7da; color: #721c24; }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: white;
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background-color: #667eea;
            color: white;
        }

        @media (max-width: 768px) {
            .content {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🔌 RESTful API - Quản lý Nhân viên</h1>
            <div class="info">
                <strong>📝 Hướng dẫn:</strong><br>
                • Sử dụng các form bên trái để test các API endpoint<br>
                • Mở Console (F12) để xem chi tiết request/response<br>
                • Kết quả sẽ hiển thị bên phải
            </div>
        </div>

        <div class="content">
            <div class="panel">
                <h2>📡 API Testing</h2>

                <div class="api-section">
                    <h3>1. Lấy tất cả nhân viên</h3>
                    <div class="api-endpoint">
                        <span class="method get">GET</span> /api/employees
                    </div>
                    <button class="btn-get" onclick="getAllEmployees()">Thực thi</button>
                </div>

                <div class="api-section">
                    <h3>2. Lấy nhân viên theo ID</h3>
                    <div class="api-endpoint">
                        <span class="method get">GET</span> /api/employees/{id}
                    </div>
                    <div class="form-group">
                        <label>Mã nhân viên:</label>
                        <input type="text" id="getById" placeholder="Ví dụ: TeoNV" value="TeoNV">
                    </div>
                    <button class="btn-get" onclick="getEmployeeById()">Thực thi</button>
                </div>

                <div class="api-section">
                    <h3>3. Thêm nhân viên mới</h3>
                    <div class="api-endpoint">
                        <span class="method post">POST</span> /api/employees
                    </div>
                    <div class="form-group">
                        <label>JSON Data:</label>
                        <textarea id="postData">{"manv":"MinhNV","hoTen":"Nguyễn Văn Minh","gioiTinh":true,"luong":1100.0}</textarea>
                    </div>
                    <button class="btn-post" onclick="createEmployee()">Thực thi</button>
                </div>

                <div class="api-section">
                    <h3>4. Cập nhật nhân viên</h3>
                    <div class="api-endpoint">
                        <span class="method put">PUT</span> /api/employees/{id}
                    </div>
                    <div class="form-group">
                        <label>Mã nhân viên:</label>
                        <input type="text" id="putId" placeholder="Ví dụ: TeoNV" value="TeoNV">
                    </div>
                    <div class="form-group">
                        <label>JSON Data:</label>
                        <textarea id="putData">{"hoTen":"Nguyễn Văn Tèo Updated","gioiTinh":true,"luong":1500.0}</textarea>
                    </div>
                    <button class="btn-put" onclick="updateEmployee()">Thực thi</button>
                </div>

                <div class="api-section">
                    <h3>5. Xóa nhân viên</h3>
                    <div class="api-endpoint">
                        <span class="method delete">DELETE</span> /api/employees/{id}
                    </div>
                    <div class="form-group">
                        <label>Mã nhân viên:</label>
                        <input type="text" id="deleteId" placeholder="Ví dụ: TeoNV">
                    </div>
                    <button class="btn-delete" onclick="deleteEmployee()">Thực thi</button>
                </div>
            </div>

            <div class="panel">
                <h2>📊 Response</h2>
                <div id="result">
                    <p style="color: #999; text-align: center; padding: 50px 0;">
                        Kết quả sẽ hiển thị ở đây sau khi thực thi API...
                    </p>
                </div>
            </div>
        </div>

        <a href="<%= request.getContextPath() %>/" class="back-link">← Quay lại trang chủ</a>
    </div>

    <script>
        const contextPath = '<%= request.getContextPath() %>';
        const apiBase = contextPath + '/api/employees';

        function getAllEmployees() {
            console.log('GET ' + apiBase);
            showLoading();
            
            fetch(apiBase)
                .then(handleResponse)
                .then(data => {
                    console.log('Response:', data);
                    displayResult('GET /api/employees', 200, data);
                })
                .catch(handleError);
        }

        function getEmployeeById() {
            const id = document.getElementById('getById').value.trim();
            if (!id) {
                alert('Vui lòng nhập mã nhân viên!');
                return;
            }

            const url = apiBase + '/' + id;
            console.log('GET ' + url);
            showLoading();

            fetch(url)
                .then(handleResponse)
                .then(data => {
                    console.log('Response:', data);
                    displayResult('GET /api/employees/' + id, 200, data);
                })
                .catch(handleError);
        }

        function createEmployee() {
            const jsonData = document.getElementById('postData').value.trim();
            if (!jsonData) {
                alert('Vui lòng nhập JSON data!');
                return;
            }

            console.log('POST ' + apiBase);
            console.log('Body:', jsonData);
            showLoading();

            fetch(apiBase, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: jsonData
            })
            .then(handleResponse)
            .then(data => {
                console.log('Response:', data);
                displayResult('POST /api/employees', 201, data);
            })
            .catch(handleError);
        }

        function updateEmployee() {
            const id = document.getElementById('putId').value.trim();
            const jsonData = document.getElementById('putData').value.trim();
            
            if (!id || !jsonData) {
                alert('Vui lòng nhập đầy đủ thông tin!');
                return;
            }

            const url = apiBase + '/' + id;
            console.log('PUT ' + url);
            console.log('Body:', jsonData);
            showLoading();

            fetch(url, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: jsonData
            })
            .then(handleResponse)
            .then(data => {
                console.log('Response:', data);
                displayResult('PUT /api/employees/' + id, 200, data);
            })
            .catch(handleError);
        }

        function deleteEmployee() {
            const id = document.getElementById('deleteId').value.trim();
            if (!id) {
                alert('Vui lòng nhập mã nhân viên!');
                return;
            }

            if (!confirm('Bạn có chắc muốn xóa nhân viên ' + id + '?')) {
                return;
            }

            const url = apiBase + '/' + id;
            console.log('DELETE ' + url);
            showLoading();

            fetch(url, {
                method: 'DELETE'
            })
            .then(handleResponse)
            .then(data => {
                console.log('Response:', data);
                displayResult('DELETE /api/employees/' + id, 200, data);
            })
            .catch(handleError);
        }

        function handleResponse(response) {
            console.log('Status:', response.status);
            return response.text().then(text => {
                const data = text ? JSON.parse(text) : {};
                if (!response.ok) {
                    throw { status: response.status, data: data };
                }
                return data;
            });
        }

        function handleError(error) {
            console.error('Error:', error);
            const status = error.status || 500;
            const data = error.data || { error: error.message || 'Network error' };
            displayResult('Error', status, data);
        }

        function displayResult(endpoint, status, data) {
            const isSuccess = status >= 200 && status < 300;
            const statusClass = isSuccess ? 'success' : 'error';
            
            const html = '<h3>' + endpoint + '</h3>' +
                '<span class="status ' + statusClass + '">Status: ' + status + '</span>' +
                '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
            
            document.getElementById('result').innerHTML = html;
        }

        function showLoading() {
            document.getElementById('result').innerHTML = 
                '<p style="color: #999; text-align: center; padding: 50px 0;">Đang xử lý...</p>';
        }
    </script>
</body>
</html>
