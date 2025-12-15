<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Form sản phẩm</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>${empty product ? 'Thêm sản phẩm' : 'Cập nhật sản phẩm'}</h2>
    <form action="${pageContext.request.contextPath}/product/${empty product ? 'create' : 'update'}" method="post">
        <c:if test="${not empty product}">
            <div class="mb-3">
                <label class="form-label">ID</label>
                <input type="text" class="form-control" name="id" value="${product.id}" readonly>
            </div>
        </c:if>
        <div class="mb-3">
            <label class="form-label">Tên sản phẩm</label>
            <input type="text" class="form-control" name="name" value="${product.name}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Giá</label>
            <input type="number" class="form-control" name="price" value="${product.price}" required>
        </div>
        <div class="mb-3">
            <label class="form-label">Số lượng</label>
            <input type="number" class="form-control" name="quantity" value="${product.quantity}" required>
        </div>
        <button type="submit" class="btn btn-success">${empty product ? 'Thêm' : 'Cập nhật'}</button>
        <a href="${pageContext.request.contextPath}/product/list" class="btn btn-secondary">Quay lại</a>
    </form>
</div>
</body>
</html>
