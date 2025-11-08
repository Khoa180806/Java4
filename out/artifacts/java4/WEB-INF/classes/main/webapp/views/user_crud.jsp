<%@ page pageEncoding="utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>User CRUD</title>
  </head>
  <body>
    <i>${message}</i>
    <form method="post">
      <input name="id" value="${user.id}" /><br />
      <input name="password" type="password" value="${user.password}" /><br />
      <input name="fullname" value="${user.fullname}" /><br />
      <input name="email" value="${user.email}" /><br />
      <input name="gender" type="radio" value="true" ${user.admin?'checked':''}>
      Male <input name="gender" type="radio" value="false"
      ${user.admin?'':'checked'}> Female
      <hr />
      <button formaction="${pageContext.request.contextPath}/user/crud/create">Create</button>
      <button formaction="${pageContext.request.contextPath}/user/crud/update">Update</button>
      <button formaction="${pageContext.request.contextPath}/user/crud/delete">Delete</button>
      <button formaction="${pageContext.request.contextPath}/user/crud/reset">Reset</button>
    </form>
    <table>
      <thead>
        <tr>
          <th>Id</th>
          <th>Password</th>
          <th>Fullname</th>
          <th>Email</th>
          <th>Role</th>
          <th></th>
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
          </tr></c:forEach
        >
      </tbody>
    </table>
  </body>
</html>
