<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AJAX Employee Demo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
        }
        button:hover {
            background-color: #45a049;
        }
        #result {
            margin-top: 20px;
            padding: 15px;
            background-color: #f4f4f4;
            border-radius: 4px;
        }
        pre {
            background-color: #272822;
            color: #f8f8f2;
            padding: 15px;
            border-radius: 4px;
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <h1>AJAX Employee Demo</h1>
    <p>Mở Console (F12) để xem dữ liệu JSON được log ra.</p>
    <button id="fetchBtn">Fetch Employee Data</button>
    <div id="result"></div>

    <script>
        const contextPath = '<%= request.getContextPath() %>';
        
        document.getElementById('fetchBtn').addEventListener('click', function() {
            fetch(contextPath + '/api/employee')
                .then(response => response.json())
                .then(data => {
                    console.log(data);
                    document.getElementById('result').innerHTML = 
                        '<h3>Dữ liệu đã được log ra console</h3>' +
                        '<h4>Nội dung JSON:</h4>' +
                        '<pre>' + JSON.stringify(data, null, 2) + '</pre>';
                })
                .catch(error => {
                    console.error('Error:', error);
                    document.getElementById('result').innerHTML = 
                        '<h3 style="color: red;">Lỗi: ' + error.message + '</h3>';
                });
        });

        window.addEventListener('load', function() {
            console.log('Trang đã load, đang fetch dữ liệu từ servlet...');
            fetch(contextPath + '/api/employee')
                .then(response => response.json())
                .then(data => {
                    console.log('Dữ liệu JSON từ servlet:', data);
                })
                .catch(error => {
                    console.error('Error:', error);
                });
        });
    </script>
</body>
</html>
