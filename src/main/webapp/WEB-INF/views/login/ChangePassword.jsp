<%@ page import="com.example.finalproject.vo.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register Page</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.2/css/bootstrap.min.css">
  <style>
    /* 自定义样式 */
    body {
      /*background-image: url('https://w.wallhaven.cc/full/zy/wallhaven-zygeko.jpg');*/
      background-size: cover;
      background-repeat: no-repeat;
    }

    .login-container {
      max-width: 400px;
      margin: 0 auto;
      padding: 40px;
      background-color: rgba(255, 255, 255, 0.8);
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      animation: slide-in 1.5s ease-out;
      position: relative;
    }

    @keyframes slide-in {
      0% {
        transform: translateX(100%);
        opacity: 0;
      }
      100% {
        transform: translateX(0);
        opacity: 1;
      }
    }

    .login-container h2 {
      text-align: center;
      margin-bottom: 30px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-group label {
      font-weight: bold;
    }

    .form-control {
      border-radius: 20px;
    }

    .btn-primary, .btn-secondary {
      border-radius: 50px;
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
      animation: button-slide-in 1.5s ease-out;
    }

    @keyframes button-slide-in {
      0% {
        transform: translateY(100%);
        opacity: 0;
      }
      100% {
        transform: translateY(0);
        opacity: 1;
      }
    }

    .button-container {
      display: flex;
      justify-content: center;
      margin-top: 20px;
    }

    .button-container button {
      flex: 1;
      margin-right: 10px;
    }

    .return-btn {
      position: absolute;
      top: 10px;
      left: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      width: 30px;
      height: 30px;
      background-color: #ffffff;
      border: none;
      border-radius: 50%;
      cursor: pointer;
      transition: background-color 1.5s;
    }

  </style>
</head>
<body>
<div class="container">
  <div class="row justify-content-center align-items-center vh-100">
    <div class="col-md-6">
      <div class="login-container">
        <h2>修改密码</h2>
        <form id="registration-form" action="http://localhost:8080/changePasswordCheck">
          <div class="form-group">
            <label for="id">学号/工号</label>
            <%
              User user = (User) session.getAttribute("user");
            %>
            <input type="text" class="form-control" id="id" name="id" value="<%=user.getId()%>" readonly>
          </div>
          <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="请输入新密码">
          </div>
          <div class="button-container">
            <button type="submit" class="btn btn-primary">提交</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
</body>
</html>

