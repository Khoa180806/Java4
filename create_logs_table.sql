-- Tạo bảng Logs để lưu thông tin truy cập
-- Chú ý: Nếu đang sử dụng hibernate.hbm2ddl.auto=update, 
-- bảng này sẽ được tạo tự động, không cần chạy script này

CREATE TABLE IF NOT EXISTS Logs (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Url VARCHAR(500),
    Time DATETIME,
    Username VARCHAR(50)
);

-- Xem dữ liệu trong bảng Logs
-- SELECT * FROM Logs ORDER BY Time DESC;

-- Xem logs của một user cụ thể
-- SELECT * FROM Logs WHERE Username = 'ps01' ORDER BY Time DESC;

-- Đếm số lượt truy cập của mỗi user
-- SELECT Username, COUNT(*) as AccessCount 
-- FROM Logs 
-- GROUP BY Username 
-- ORDER BY AccessCount DESC;
