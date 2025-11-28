<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Nhân viên</title>
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
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
        }

        h1 {
            color: #333;
            font-size: 32px;
            margin-bottom: 30px;
            text-align: center;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .form-section {
            background-color: #f8f9fa;
            padding: 25px;
            border-radius: 8px;
            margin-bottom: 30px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-weight: bold;
            font-size: 14px;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 12px;
            border: 2px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #667eea;
        }

        .radio-group {
            display: flex;
            gap: 20px;
            margin-top: 8px;
        }

        .radio-item {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        input[type="radio"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .button-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 25px;
        }

        button {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
            color: white;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
        }

        button:active {
            transform: translateY(0);
        }

        .btn-new {
            background-color: #6c757d;
        }

        .btn-create {
            background-color: #28a745;
        }

        .btn-update {
            background-color: #ffc107;
            color: #333;
        }

        .btn-delete {
            background-color: #dc3545;
        }

        .btn-find {
            background-color: #17a2b8;
        }

        .btn-load-all {
            background-color: #667eea;
        }

        .table-section {
            margin-top: 30px;
        }

        .table-section h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: white;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        thead {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        th {
            padding: 15px;
            text-align: left;
            font-weight: bold;
            font-size: 14px;
        }

        td {
            padding: 12px 15px;
            border-bottom: 1px solid #f0f0f0;
            font-size: 14px;
        }

        tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        tbody tr:hover {
            background-color: #f8f9fa;
        }

        tbody tr.selected {
            background-color: #e7f3ff;
        }

        .status-message {
            padding: 12px 20px;
            border-radius: 6px;
            margin-bottom: 20px;
            font-weight: bold;
            display: none;
        }

        .status-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .status-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .status-info {
            background-color: #d1ecf1;
            color: #0c5460;
            border: 1px solid #bee5eb;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #667eea;
            color: white;
            text-decoration: none;
            font-weight: bold;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background-color: #764ba2;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #999;
            font-style: italic;
        }

        @media (max-width: 768px) {
            .button-group {
                flex-direction: column;
            }

            button {
                width: 100%;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 8px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>👥 Quản lý Nhân viên</h1>

        <div id="statusMessage" class="status-message"></div>

        <div class="form-section">
            <form id="employeeForm">
                <div class="form-group">
                    <label for="manv">Mã nhân viên:</label>
                    <input type="text" id="manv" name="manv" placeholder="Nhập mã nhân viên" required>
                </div>

                <div class="form-group">
                    <label for="hoTen">Họ và tên:</label>
                    <input type="text" id="hoTen" name="hoTen" placeholder="Nhập họ và tên" required>
                </div>

                <div class="form-group">
                    <label>Giới tính:</label>
                    <div class="radio-group">
                        <div class="radio-item">
                            <input type="radio" id="gioiTinhNam" name="gioiTinh" value="true" checked>
                            <label for="gioiTinhNam" style="margin: 0; font-weight: normal;">Nam</label>
                        </div>
                        <div class="radio-item">
                            <input type="radio" id="gioiTinhNu" name="gioiTinh" value="false">
                            <label for="gioiTinhNu" style="margin: 0; font-weight: normal;">Nữ</label>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label for="luong">Lương:</label>
                    <input type="number" id="luong" name="luong" placeholder="Nhập lương" step="0.01" required>
                </div>

                <div class="button-group">
                    <button type="button" class="btn-new" onclick="resetForm()">New</button>
                    <button type="button" class="btn-create" onclick="createEmployee()">Create</button>
                    <button type="button" class="btn-update" onclick="updateEmployee()">Update</button>
                    <button type="button" class="btn-delete" onclick="deleteEmployee()">Delete</button>
                    <button type="button" class="btn-find" onclick="findEmployee()">Find</button>
                    <button type="button" class="btn-load-all" onclick="loadAllEmployees()">Load All</button>
                </div>
            </form>
        </div>

        <div class="table-section">
            <h2>📋 Danh sách nhân viên</h2>
            <table>
                <thead>
                    <tr>
                        <th>Mã NV</th>
                        <th>Họ và tên</th>
                        <th>Giới tính</th>
                        <th>Lương</th>
                    </tr>
                </thead>
                <tbody id="employeeTableBody">
                    <tr>
                        <td colspan="4" class="empty-state">Click "Load All" để tải danh sách nhân viên</td>
                    </tr>
                </tbody>
            </table>
        </div>

        <a href="<%= request.getContextPath() %>/" class="back-link">← Quay lại trang chủ</a>
    </div>

    <script>
        const contextPath = '<%= request.getContextPath() %>';
        const apiBase = contextPath + '/api/employees';
        let currentSelectedRow = null;

        function showStatus(message, type) {
            const statusDiv = document.getElementById('statusMessage');
            statusDiv.textContent = message;
            statusDiv.className = 'status-message status-' + type;
            statusDiv.style.display = 'block';

            setTimeout(() => {
                statusDiv.style.display = 'none';
            }, 5000);
        }

        function getFormData() {
            return {
                manv: document.getElementById('manv').value.trim(),
                hoTen: document.getElementById('hoTen').value.trim(),
                gioiTinh: document.querySelector('input[name="gioiTinh"]:checked').value === 'true',
                luong: parseFloat(document.getElementById('luong').value)
            };
        }

        function setFormData(employee) {
            document.getElementById('manv').value = employee.manv;
            document.getElementById('manv').readOnly = true;
            document.getElementById('hoTen').value = employee.hoTen;
            
            if (employee.gioiTinh) {
                document.getElementById('gioiTinhNam').checked = true;
            } else {
                document.getElementById('gioiTinhNu').checked = true;
            }
            
            document.getElementById('luong').value = employee.luong;
        }

        function resetForm() {
            document.getElementById('employeeForm').reset();
            document.getElementById('manv').readOnly = false;
            document.getElementById('gioiTinhNam').checked = true;
            
            if (currentSelectedRow) {
                currentSelectedRow.classList.remove('selected');
                currentSelectedRow = null;
            }
            
            showStatus('Form đã được reset', 'info');
        }

        function createEmployee() {
            const data = getFormData();
            
            if (!data.manv || !data.hoTen || isNaN(data.luong)) {
                showStatus('Vui lòng điền đầy đủ thông tin!', 'error');
                return;
            }

            console.log('Creating employee:', data);

            fetch(apiBase, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                console.log('Response:', result);
                if (result.error) {
                    showStatus('Lỗi: ' + result.error, 'error');
                } else {
                    showStatus('Thêm nhân viên thành công!', 'success');
                    resetForm();
                    loadAllEmployees();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showStatus('Lỗi kết nối: ' + error.message, 'error');
            });
        }

        function updateEmployee() {
            const data = getFormData();
            
            if (!data.manv || !data.hoTen || isNaN(data.luong)) {
                showStatus('Vui lòng điền đầy đủ thông tin!', 'error');
                return;
            }

            console.log('Updating employee:', data);

            fetch(apiBase + '/' + data.manv, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(data)
            })
            .then(response => response.json())
            .then(result => {
                console.log('Response:', result);
                if (result.error) {
                    showStatus('Lỗi: ' + result.error, 'error');
                } else {
                    showStatus('Cập nhật nhân viên thành công!', 'success');
                    loadAllEmployees();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showStatus('Lỗi kết nối: ' + error.message, 'error');
            });
        }

        function deleteEmployee() {
            const manv = document.getElementById('manv').value.trim();
            
            if (!manv) {
                showStatus('Vui lòng nhập mã nhân viên cần xóa!', 'error');
                return;
            }

            if (!confirm('Bạn có chắc muốn xóa nhân viên ' + manv + '?')) {
                return;
            }

            console.log('Deleting employee:', manv);

            fetch(apiBase + '/' + manv, {
                method: 'DELETE'
            })
            .then(response => response.json())
            .then(result => {
                console.log('Response:', result);
                if (result.error) {
                    showStatus('Lỗi: ' + result.error, 'error');
                } else {
                    showStatus('Xóa nhân viên thành công!', 'success');
                    resetForm();
                    loadAllEmployees();
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showStatus('Lỗi kết nối: ' + error.message, 'error');
            });
        }

        function findEmployee() {
            const manv = document.getElementById('manv').value.trim();
            
            if (!manv) {
                showStatus('Vui lòng nhập mã nhân viên cần tìm!', 'error');
                return;
            }

            console.log('Finding employee:', manv);

            fetch(apiBase + '/' + manv)
            .then(response => response.json())
            .then(employee => {
                console.log('Response:', employee);
                if (employee.error) {
                    showStatus('Không tìm thấy nhân viên!', 'error');
                } else {
                    setFormData(employee);
                    showStatus('Đã tìm thấy nhân viên!', 'success');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showStatus('Lỗi kết nối: ' + error.message, 'error');
            });
        }

        function loadAllEmployees() {
            console.log('Loading all employees...');

            fetch(apiBase)
            .then(response => response.json())
            .then(employees => {
                console.log('Response:', employees);
                displayEmployees(employees);
                showStatus('Đã tải ' + employees.length + ' nhân viên', 'success');
            })
            .catch(error => {
                console.error('Error:', error);
                showStatus('Lỗi kết nối: ' + error.message, 'error');
            });
        }

        function displayEmployees(employees) {
            const tbody = document.getElementById('employeeTableBody');
            
            if (employees.length === 0) {
                tbody.innerHTML = '<tr><td colspan="4" class="empty-state">Không có nhân viên nào</td></tr>';
                return;
            }

            let html = '';
            employees.forEach(emp => {
                html += '<tr onclick="selectEmployee(this, \'' + emp.manv + '\')">' +
                    '<td>' + emp.manv + '</td>' +
                    '<td>' + emp.hoTen + '</td>' +
                    '<td>' + (emp.gioiTinh ? 'Nam' : 'Nữ') + '</td>' +
                    '<td>' + emp.luong.toFixed(2) + '</td>' +
                    '</tr>';
            });
            
            tbody.innerHTML = html;
        }

        function selectEmployee(row, manv) {
            if (currentSelectedRow) {
                currentSelectedRow.classList.remove('selected');
            }
            
            row.classList.add('selected');
            currentSelectedRow = row;

            console.log('Selected employee:', manv);

            fetch(apiBase + '/' + manv)
            .then(response => response.json())
            .then(employee => {
                setFormData(employee);
            })
            .catch(error => {
                console.error('Error:', error);
                showStatus('Lỗi khi tải thông tin nhân viên', 'error');
            });
        }

        window.addEventListener('load', function() {
            loadAllEmployees();
        });
    </script>
</body>
</html>
