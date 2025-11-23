# Filter1 và Filter2 - Hướng dẫn

## Mô tả
Dự án này demo cách sắp xếp thứ tự thực thi của các Filter trong Java Servlet sử dụng web.xml.

## Các thành phần

### 1. Filter1.java
- **Chức năng**: Set attribute "hello" với giá trị "Tôi là filter 1"
- **Location**: `com.java4.filter.Filter1`
- **Code**:
```java
@Override
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    
    request.setAttribute("hello", "Tôi là filter 1");
    System.out.println("Filter1: Set attribute 'hello' = 'Tôi là filter 1'");
    
    chain.doFilter(request, response);
}
```

### 2. Filter2.java
- **Chức năng**: Lấy và in ra attribute "hello" 
- **Location**: `com.java4.filter.Filter2`
- **Code**:
```java
@Override
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
        throws IOException, ServletException {
    
    String hello = (String) request.getAttribute("hello");
    System.out.println("Filter2: " + hello);
    
    chain.doFilter(request, response);
}
```

### 3. web.xml
- **Location**: `WEB-INF/web.xml`
- **Mục đích**: Cấu hình thứ tự thực thi của các filter

## Cách hoạt động

### Thứ tự thực thi
```
Client Request
    ↓
Filter1 (set attribute)
    ↓
Filter2 (print attribute)
    ↓
AppFilter (UTF-8 + Logging)
    ↓
Servlet/JSP
```

### Cấu hình trong web.xml
```xml
<!-- Filter Definitions -->
<filter>
  <filter-name>Filter1</filter-name>
  <filter-class>com.java4.filter.Filter1</filter-class>
</filter>

<filter>
  <filter-name>Filter2</filter-name>
  <filter-class>com.java4.filter.Filter2</filter-class>
</filter>

<!-- Filter Mappings - Thứ tự khai báo quyết định thứ tự thực thi -->
<filter-mapping>
  <filter-name>Filter1</filter-name>
  <url-pattern>/*</url-pattern>
</filter-mapping>

<filter-mapping>
  <filter-name>Filter2</filter-name>
  <url-pattern>/*</url-pattern>
</filter-mapping>
```

## Quy tắc sắp xếp thứ tự Filter

### Sử dụng web.xml (như trong project này)
- Thứ tự khai báo `<filter-mapping>` trong web.xml quyết định thứ tự thực thi
- Filter được khai báo trước sẽ chạy trước
- Đây là cách **chính thống** và **đáng tin cậy nhất**

### Sử dụng @WebFilter annotation
- Nếu dùng annotation `@WebFilter`, thứ tự không được đảm bảo
- Servlet container có thể chạy các filter theo thứ tự bất kỳ
- **Không nên dùng** khi cần kiểm soát thứ tự

## Kiểm tra

### Cách 1: Xem console
Khi truy cập bất kỳ trang nào, trong console sẽ thấy:
```
Filter1: Set attribute 'hello' = 'Tôi là filter 1'
Filter2: Tôi là filter 1
```

### Cách 2: Truy cập trang demo
URL: `http://localhost:8080/filter-test`

Trang này sẽ hiển thị:
- Giá trị của attribute "hello" 
- Luồng xử lý request
- Cấu hình web.xml
- Hướng dẫn kiểm tra

## Output mẫu

### Console output
```
Filter1 initialized
Filter2 initialized
Filter1: Set attribute 'hello' = 'Tôi là filter 1'
Filter2: Tôi là filter 1
```

### JSP output
```
Tôi là filter 1
```

## Lưu ý quan trọng

1. **Thứ tự trong web.xml**: 
   - `<filter-mapping>` của Filter1 phải được khai báo TRƯỚC Filter2
   - Thay đổi thứ tự sẽ thay đổi kết quả

2. **URL Pattern**:
   - `/*` = áp dụng cho tất cả các request
   - Có thể thay đổi thành pattern cụ thể như `/user/*`, `/api/*`

3. **chain.doFilter()**:
   - Phải gọi để tiếp tục chuỗi xử lý
   - Nếu không gọi, request sẽ bị dừng lại

4. **AppFilter**:
   - AppFilter (UTF-8 + Logging) vẫn hoạt động song song
   - AppFilter dùng @WebFilter nên thứ tự với Filter1, Filter2 không được đảm bảo
   - Nếu cần, có thể thêm AppFilter vào web.xml để kiểm soát thứ tự

## Tài liệu tham khảo

- Jakarta Servlet Specification
- Java EE Filter API
- web.xml Configuration Guide
