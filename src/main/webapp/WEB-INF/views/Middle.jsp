<%@ page import="com.example.finalproject.vo.User" %><%--
  Created by IntelliJ IDEA.
  User: wannner
  Date: 2023/6/13
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Loading Page</title>
    <style>
        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .loading-container {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .progress-bar {
            width: 300px;
            height: 20px;
            background-color: #f1f1f1;
            border-radius: 10px;
            overflow: hidden;
            position: relative;
        }

        .progress-bar-inner {
            width: 0;
            height: 100%;
            background-color: #007bff;
            position: absolute;
            left: 0;
            top: 0;
            animation: progress 1s linear forwards;
            border-radius: 10px;
        }

        .progress-bar-percentage {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: #000;
            font-weight: bold;
        }

        .security-check {
            margin-top: 20px;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
        }

        .success-message {
            margin-top: 20px;
            text-align: center;
            font-size: 24px;
            color: #28a745;
            display: none;
        }
    </style>
</head>
<body>
<%String url="123";%>
<%
    User user= (User) session.getAttribute("user");
    String message = (String) request.getAttribute("message");
    if (message.equals("登录失败!")) {
        url="http://localhost:8080/login";
    } else if (message.equals("登录成功!")) {
        switch (user.getRole()){
            case "学生":{
                url="http://localhost:8080/studentSpace";
                break;
            }
            case "老师":{
                url="http://localhost:8080/teacherSpace";
                break;
            }
            case "管理员":{
                url="http://localhost:8080/managerSpace";
                break;
            }
        }
    } else if (message.equals("修改密码成功!")) {
        url="http://localhost:8080/blank";
    } else if (message.equals("您还没有注册，请注册!")) {
        url="http://localhost:8080/register";
    } else {
        url="http://localhost:8080/";
    }
%>
<div class="loading-container">
    <div class="progress-bar">
        <div class="progress-bar-inner"></div>
        <div class="progress-bar-percentage">0%</div>
    </div>
    <div class="security-check">加载中...</div>
    <div class="success-message">${message}</div>
</div>

<script>
    const progressBarInner = document.querySelector('.progress-bar-inner');
    const progressBarPercentage = document.querySelector('.progress-bar-percentage');
    const securityCheck = document.querySelector('.security-check');
    const successMessage = document.querySelector('.success-message');

    let progress = 0;
    const increment = 100 / 200; // 2秒内每帧增加的进度值

    const animateProgressBar = () => {
        if (progress < 100) {
            progress += increment;
            progressBarInner.style.width = progress + '%';
            progressBarPercentage.textContent = Math.round(progress) + '%';
            requestAnimationFrame(animateProgressBar);
        } else {
            securityCheck.style.display = 'none';
            successMessage.style.display = 'block';

            // 在此处添加页面跳转的代码
            setTimeout(() => {
                window.location.href ="<%=url%>"; // 替换为目标页面的 URL
            }, 2000); // 2秒后跳转
        }
    };

    animateProgressBar();
</script>
</body>
</html>
