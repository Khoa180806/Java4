<%@ page pageEncoding="utf-8" %>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ page isELIgnored="false" %>
      <!DOCTYPE html>
      <html>

      <head>
        <meta charset="utf-8" />
        <title>User CRUD</title>
        <style>
          * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
          }

          body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
          }

          .container {
            max-width: 1000px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
          }

          .message {
            padding: 12px 15px;
            margin-bottom: 20px;
            border-radius: 4px;
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
            font-weight: bold;
          }

          form {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 6px;
            border: 1px solid #e0e0e0;
          }

          form input[type="text"],
          form input[type="password"],
          form input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
          }

          form input[type="text"]:focus,
          form input[type="password"]:focus,
          form input[type="email"]:focus {
            outline: none;
            border-color: #4CAF50;
            box-shadow: 0 0 5px rgba(76, 175, 80, 0.3);
          }

          .radio-group {
            margin-bottom: 12px;
          }

          form input[type="radio"] {
            margin-right: 5px;
          }

          form input[type="radio"]+label {
            margin-right: 20px;
            cursor: pointer;
          }

          hr {
            margin: 20px 0;
            border: none;
            border-top: 1px solid #ddd;
          }

          .button-group {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
          }

          button {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: all 0.3s ease;
          }

          button[formaction*="create"] {
            background-color: #4CAF50;
            color: white;
          }

          button[formaction*="create"]:hover {
            background-color: #45a049;
          }

          button[formaction*="update"] {
            background-color: #2196F3;
            color: white;
          }

          button[formaction*="update"]:hover {
            background-color: #0b7dda;
          }

          button[formaction*="delete"] {
            background-color: #f44336;
            color: white;
          }

          button[formaction*="delete"]:hover {
            background-color: #da190b;
          }

          button[formaction*="reset"] {
            background-color: #ff9800;
            color: white;
          }

          button[formaction*="reset"]:hover {
            background-color: #e68900;
          }

          table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
          }

          table thead {
            background-color: #333;
            color: white;
          }

          table th {
            padding: 12px;
            text-align: left;
            font-weight: bold;
          }

          table td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
          }

          table tbody tr:hover {
            background-color: #f5f5f5;
          }

          table a {
            color: #2196F3;
            text-decoration: none;
            font-weight: bold;
          }

          table a:hover {
            text-decoration: underline;
          }
        </style>
      </head>

      <body>
        <div class="container">
          <c:if test="${not empty message}">
            <div class="message">${message}</div>
          </c:if>

          <form method="post">
            <input type="text" name="id" placeholder="ID" value="${user.id}" ${not empty user.id ? 'readonly' : '' } />
            <input type="password" name="password" placeholder="Password" value="${user.password}" />
            <input type="text" name="fullname" placeholder="Full Name" value="${user.fullname}" />
            <input type="email" name="email" placeholder="Email" value="${user.email}" />

            <div class="radio-group">
              <input type="radio" id="admin-true" name="admin" value="true" ${user.admin?'checked':''}>
              <label for="admin-true">Admin</label>
              <input type="radio" id="admin-false" name="admin" value="false" ${user.admin?'':'checked'}>
              <label for="admin-false">User</label>
            </div>

            <hr />

            <div class="button-group">
              <button type="submit" formaction="${pageContext.request.contextPath}/user/crud/create">Create</button>
              <button type="submit" formaction="${pageContext.request.contextPath}/user/crud/update">Update</button>
              <button type="submit" formaction="${pageContext.request.contextPath}/user/crud/delete">Delete</button>
              <button type="submit" formaction="${pageContext.request.contextPath}/user/crud/reset">Reset</button>
            </div>
          </form>
          <table>
            <thead>
              <tr>
                <th>Id</th>
                <th>Password</th>
                <th>Fullname</th>
                <th>Email</th>
                <th>Role</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="u" items="${users}">
                <tr>
                  <td>${u.id}</td>
                  <td>${u.password}</td>
                  <td>${u.fullname}</td>
                  <td>${u.email}</td>
                  <td>${u.admin?'Admin':'User'}</td>
                  <td><a href="${pageContext.request.contextPath}/user/crud/edit/${u.id}">Edit</a></td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </body>

      </html>