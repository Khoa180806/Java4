<%@ page pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Video Share Report</title>
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
            transform: scale(1.005);
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .video-title {
            font-weight: bold;
            color: #333;
            font-size: 15px;
        }

        .share-count {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 16px;
            display: inline-block;
            min-width: 50px;
        }

        .date-info {
            color: #555;
            font-size: 14px;
        }

        .date-icon {
            margin-right: 5px;
            color: #667eea;
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

        .no-data p {
            font-size: 16px;
        }

        .table-wrapper {
            overflow-x: auto;
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
        <h1>
            <span>📊</span> Video Share Report
        </h1>
        <p class="subtitle">Thống kê chia sẻ video tổng hợp</p>

        <c:if test="${not empty reports}">
            <div class="stats-card">
                <h2>${reports.size()}</h2>
                <p>Total Videos Shared</p>
            </div>

            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Tiêu đề Video</th>
                            <th class="text-center">Số lượt chia sẻ</th>
                            <th class="text-center">Ngày chia sẻ đầu tiên</th>
                            <th class="text-center">Ngày chia sẻ cuối cùng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="report" items="${reports}">
                            <tr>
                                <td class="video-title">${report.videoTitle}</td>
                                <td class="text-center">
                                    <span class="share-count">
                                        ${report.shareCount}
                                    </span>
                                </td>
                                <td class="text-center">
                                    <span class="date-info">
                                        <span class="date-icon">📅</span>
                                        <fmt:formatDate value="${report.firstShareDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </span>
                                </td>
                                <td class="text-center">
                                    <span class="date-info">
                                        <span class="date-icon">📅</span>
                                        <fmt:formatDate value="${report.lastShareDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>

        <c:if test="${empty reports}">
            <div class="no-data">
                <div class="no-data-icon">📭</div>
                <h2>No Share Data Available</h2>
                <p>There are currently no video shares to display.</p>
            </div>
        </c:if>
    </div>
</body>
</html>
