<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AJAX File Upload Demo</title>
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
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .container {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            max-width: 600px;
            width: 100%;
        }

        h1 {
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
            margin-bottom: 30px;
            padding: 15px;
            background-color: #f0f0f0;
            border-radius: 8px;
            border-left: 4px solid #667eea;
        }

        .upload-form {
            margin-bottom: 30px;
        }

        .file-input-wrapper {
            position: relative;
            margin-bottom: 20px;
        }

        input[type="file"] {
            width: 100%;
            padding: 15px;
            border: 2px dashed #667eea;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
        }

        input[type="file"]:hover {
            border-color: #764ba2;
            background-color: #f9f9f9;
        }

        .upload-btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .upload-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }

        .upload-btn:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }

        #result {
            margin-top: 30px;
        }

        .result-box {
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        .success {
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }

        .info-box {
            background-color: #d1ecf1;
            border: 1px solid #bee5eb;
            color: #0c5460;
        }

        pre {
            background-color: #272822;
            color: #f8f8f2;
            padding: 15px;
            border-radius: 8px;
            overflow-x: auto;
            font-size: 14px;
            line-height: 1.5;
        }

        .file-info {
            margin-top: 10px;
        }

        .file-info-item {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #eee;
        }

        .file-info-item:last-child {
            border-bottom: none;
        }

        .file-info-label {
            font-weight: bold;
            color: #667eea;
        }

        .file-info-value {
            color: #333;
        }

        .progress-bar {
            width: 100%;
            height: 4px;
            background-color: #e0e0e0;
            border-radius: 2px;
            margin-top: 10px;
            overflow: hidden;
            display: none;
        }

        .progress-bar-fill {
            height: 100%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            width: 0%;
            transition: width 0.3s ease;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📤 AJAX File Upload Demo</h1>
        <div class="info">
            <strong>📝 Hướng dẫn:</strong><br>
            1. Chọn file để upload (tối đa 10MB)<br>
            2. Click nút "Upload File"<br>
            3. Mở Console (F12) để xem JSON response
        </div>

        <form id="uploadForm" class="upload-form">
            <div class="file-input-wrapper">
                <input type="file" id="fileInput" name="file" required>
            </div>
            <button type="submit" class="upload-btn">Upload File</button>
            <div class="progress-bar" id="progressBar">
                <div class="progress-bar-fill" id="progressBarFill"></div>
            </div>
        </form>

        <div id="result"></div>

        <a href="${pageContext.request.contextPath}/" class="back-link">← Quay lại trang chủ</a>
    </div>

    <script>
        const contextPath = '<%= request.getContextPath() %>';
        const uploadForm = document.getElementById('uploadForm');
        const fileInput = document.getElementById('fileInput');
        const resultDiv = document.getElementById('result');
        const uploadBtn = uploadForm.querySelector('.upload-btn');
        const progressBar = document.getElementById('progressBar');
        const progressBarFill = document.getElementById('progressBarFill');

        uploadForm.addEventListener('submit', function(e) {
            e.preventDefault();

            const file = fileInput.files[0];
            if (!file) {
                alert('Vui lòng chọn file!');
                return;
            }

            const formData = new FormData();
            formData.append('file', file);

            uploadBtn.disabled = true;
            uploadBtn.textContent = 'Đang upload...';
            progressBar.style.display = 'block';
            progressBarFill.style.width = '0%';

            console.log('Bắt đầu upload file:', file.name);

            fetch(contextPath + '/api/upload', {
                method: 'POST',
                body: formData
            })
            .then(response => {
                progressBarFill.style.width = '100%';
                console.log('Response status:', response.status);
                console.log('Response headers:', response.headers.get('content-type'));
                return response.text().then(text => {
                    console.log('Raw response:', text);
                    try {
                        return JSON.parse(text);
                    } catch (e) {
                        throw new Error('Invalid JSON response: ' + text);
                    }
                });
            })
            .then(data => {
                console.log('Parsed JSON Response:', data);
                console.log('resultDiv element:', resultDiv);

                if (data.error) {
                    const errorHTML = '<div class="result-box error">' +
                        '<h3>❌ Lỗi upload</h3>' +
                        '<p>' + data.error + '</p>' +
                        '</div>';
                    console.log('Setting error HTML');
                    resultDiv.innerHTML = errorHTML;
                } else {
                    const fileSizeKB = (data.size / 1024).toFixed(2);
                    const fileSizeMB = (data.size / (1024 * 1024)).toFixed(2);
                    const displaySize = fileSizeMB > 0.01 ? fileSizeMB + ' MB' : fileSizeKB + ' KB';

                    const successHTML = '<div class="result-box success">' +
                        '<h3>✅ Upload thành công!</h3>' +
                        '<div class="file-info">' +
                        '<div class="file-info-item">' +
                        '<span class="file-info-label">Tên file:</span>' +
                        '<span class="file-info-value">' + data.name + '</span>' +
                        '</div>' +
                        '<div class="file-info-item">' +
                        '<span class="file-info-label">Loại file:</span>' +
                        '<span class="file-info-value">' + data.type + '</span>' +
                        '</div>' +
                        '<div class="file-info-item">' +
                        '<span class="file-info-label">Kích thước:</span>' +
                        '<span class="file-info-value">' + displaySize + ' (' + data.size + ' bytes)</span>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="result-box info-box">' +
                        '<h4>📋 JSON Response từ Servlet:</h4>' +
                        '<pre>' + JSON.stringify(data, null, 2) + '</pre>' +
                        '</div>';
                    
                    console.log('Setting success HTML');
                    console.log('HTML length:', successHTML.length);
                    resultDiv.innerHTML = successHTML;
                    console.log('resultDiv.innerHTML set, new content:', resultDiv.innerHTML.substring(0, 100));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                resultDiv.innerHTML = `
                    <div class="result-box error">
                        <h3>❌ Lỗi kết nối</h3>
                        <p>${error.message}</p>
                    </div>
                `;
            })
            .finally(() => {
                uploadBtn.disabled = false;
                uploadBtn.textContent = 'Upload File';
                setTimeout(() => {
                    progressBar.style.display = 'none';
                }, 1000);
            });
        });

        fileInput.addEventListener('change', function() {
            if (this.files.length > 0) {
                const file = this.files[0];
                const fileSize = (file.size / 1024).toFixed(2);
                console.log('File đã chọn:', {
                    name: file.name,
                    type: file.type,
                    size: fileSize + ' KB'
                });
            }
        });
    </script>
</body>
</html>
