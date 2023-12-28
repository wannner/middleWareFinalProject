<%--
  Created by IntelliJ IDEA.
  User: wannner
  Date: 2023/6/13
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.2/css/bootstrap.min.css">
    <style>
        /* 自定义样式 */
        body {
            background-image: url('https://w.wallhaven.cc/full/zy/wallhaven-zygeko.jpg');
            background-size: cover;
            background-repeat: no-repeat;
        }

        .login-container {
            max-width: 400px;
            margin: 0 auto;
            padding: 40px;
            background-color: rgba(255, 255, 255, 0.8); /* 半透明的背景色 */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            animation: slide-in 1.5s ease-out;
            position: relative;
            display: none;
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
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            animation: button-slide-in 1.5s ease-out;
        }

        .button-container {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .button-container button {
            flex: 1;
            margin-right: 10px;
        }

        .login-button {
            margin: 0 auto;
            display: block;
            width: 200px;
            background-color: rgba(0, 123, 255, 0.5); /* 半透明的背景色 */
            border-radius: 10px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            animation: button-slide-in 1.5s ease-out;
        }

        .login-button.hidden {
            display: none;
        }

        .return-button {
            position: absolute;
            top: 10px;
            left: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 30px;
            height: 30px;
            background-color: #f8f9fa;
            border: none;
            border-radius: 50%;
            cursor: pointer;
            transition: background-color 1.5s;
        }

        .return-button:hover {
            background-color: #e9ecef;
        }

        .return-button::before {
            content: "\2190";
            font-size: 18px;
        }

        .register-link {
            text-align: center;
            margin-top: 40px;
        }

        .register-link a {
            color: #2E76C1FF;
            text-decoration: none;
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
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center align-items-center vh-100">
        <div class="col-md-6">
            <button class="btn btn-primary login-button" id="loginButton">进入</button>
            <div class="login-container" id="loginContainer">
                <button class="return-button" id="returnButton"></button>
                <h2>学生成绩管理系统</h2>
                <form action="http://localhost:8080/loginCheck">
                    <div class="form-group">
                        <label for="id">学号/工号</label>
                        <input type="text" class="form-control" id="id" name="id" required placeholder="请输入学号或工号">
                    </div>
                    <div class="form-group">
                        <label for="password">密码</label>
                        <input type="password" class="form-control" id="password" name="password" required placeholder="请输入密码">
                    </div>
                    <div class="button-container">
                        <button type="submit" class="btn btn-primary">登录</button>
                    </div>
                    <div class="register-link">
                        <a href="http://localhost:8080/register">注册</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
<script>
    const loginButton = document.querySelector("#loginButton");
    const loginContainer = document.querySelector("#loginContainer");
    const returnButton = document.querySelector("#returnButton");

    loginButton.addEventListener("click", () => {
        loginButton.classList.add("hidden");
        loginContainer.style.display = "block";
    });

    returnButton.addEventListener("click", () => {
        loginButton.classList.remove("hidden");
        loginContainer.style.display = "none";
    });
</script>
</body>
</html>
