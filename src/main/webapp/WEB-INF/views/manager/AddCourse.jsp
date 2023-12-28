<!DOCTYPE html>
<html lang="zh-CN">
<%--
  Created by IntelliJ IDEA.
  User: wannner
  Date: 2023/6/13
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>新增班级信息</title>
    <style>
        body {
            /*background-image: url('https://w.wallhaven.cc/full/zy/wallhaven-zygeko.jpg');*/
            background-size: cover;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .card {
            background-color: rgba(224, 236, 255, 0.8);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 40px;
            width: 500px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            display: flex; /* 使用 Flex 布局 */
            flex-direction: column; /* 垂直方向布局 */
            justify-content: center; /* 在主轴上居中对齐 */
            align-items: center; /* 在交叉轴上居中对齐 */
            opacity: 0; /* 初始时设置透明度为0 */
            transform: translateY(-20px); /* 初始时向上偏移20px */
            transition: opacity 0.5s ease-in-out, transform 0.5s ease-in-out; /* 添加过渡效果 */
        }
        .card.loaded {
            opacity: 1; /* 加载入后将透明度设为1 */
            transform: translateY(0); /* 加载入后取消偏移 */
        }
        .card.removed {
            opacity: 0; /* 移除时将透明度设为0 */
            transform: translateY(-20px); /* 移除时向上偏移20px */
        }
        .card h1 {
            margin-bottom: 20px;
        }
        .form-row {
            margin-bottom: 20px;
            display: flex; /* 使用 Flex 布局 */
            align-items: center; /* 在交叉轴上居中对齐 */
            opacity: 0; /* 初始时设置透明度为0 */
            transform: translateY(-20px); /* 初始时向上偏移20px */
            transition: opacity 0.5s ease-in-out, transform 0.5s ease-in-out; /* 添加过渡效果 */
        }
        .form-row.loaded {
            opacity: 1; /* 加载入后将透明度设为1 */
            transform: translateY(0); /* 加载入后取消偏移 */
        }
        .form-row.removed {
            opacity: 0; /* 移除时将透明度设为0 */
            transform: translateY(-20px); /* 移除时向上偏移20px */
        }
        .form-row input {
            border-radius: 10px;
            padding: 8px;
            border: none;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        }
        .form-row button {
            border-radius: 20px;
            padding: 10px 20px;
            border: none;
            outline: none;
            background-color: rgba(0, 123, 255, 0.5);
            color: #fff;
            cursor: pointer;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease-in-out; /* 添加过渡效果 */
        }
        .form-row button:hover {
            background-color: rgba(0, 123, 255, 0.8);
        }
        .form-row button:focus {
            outline: none;
        }
        .form-actions {
            display: flex;
            justify-content: space-between;
            width: 100%;
            margin-top: 20px;
            border-top: 1px solid rgba(0, 0, 0, 0.2);
            padding-top: 20px;
        }
        .form-actions button {
            flex: 1;
            margin-right: 10px;
            background-color: rgba(0, 123, 255, 0.5);
            color: #fff;
            cursor: pointer;
            border: none;
            outline: none;
            border-radius: 20px;
            padding: 8px 16px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease-in-out; /* 添加过渡效果 */
        }
        .form-actions button:hover {
            background-color: rgba(0, 123, 255, 0.8);
        }
        .form-actions button:focus {
            outline: none;
        }
    </style>
</head>
<body>
<div class="card">
    <h1>新增课程信息</h1>
    <form id="class-form" onsubmit="return false;">
        <div class="form-row">
            <input type="text" name="courseName">
            <button type="button" onclick="removeRow(this)">移除</button>
        </div>
        <hr>
        <div id="class-table"></div>
        <div class="form-actions">
            <button type="button" onclick="addRow()">添加</button>
            <button type="submit" onclick="submitForm()">提交</button>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function submitForm() {

        const form = document.getElementById('class-form');
        const formData = new FormData(form);
        const courseArray = [];

        for (let entry of formData.entries()) {
            const courseName = entry[1];
            const classData = {
                courseName: courseName
            };
            courseArray.push(classData);
        }

        $.ajax({
            url: 'http://localhost:8080/manager/addCourseCheck',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(courseArray),
            success: function (response) {
                alert('课程创建成功');
                window.location.href = 'http://localhost:8080/manager/addCourse';//创建成功，放回创建页面
            },
            error: function (error) {
                console.error(error);
                alert('课程创建失败');
            }
        });
    }
    function addRow() {
        var table = document.getElementById('class-table');
        var row = document.createElement('div');
        row.className = 'form-row';

        var input = document.createElement('input');
        input.type = 'text';
        input.name = 'className[]';
        input.required = true;
        input.placeholder = '请输入课程名称';

        var button = document.createElement('button');
        button.type = 'button';
        button.textContent = '移除';
        button.onclick = function() {
            removeRow(this);
        };

        row.appendChild(input);
        row.appendChild(button);

        table.appendChild(row);

        // 添加行后等待一段时间再将行加载入
        setTimeout(function() {
            row.classList.add('loaded');
        }, 100);
    }

    function removeRow(button) {
        var row = button.parentNode;

        // 移除行前先将行设置为移除状态
        row.classList.add('removed');

        // 等待移除动画完成后再真正移除行
        setTimeout(function() {
            row.parentNode.removeChild(row);
        }, 500);
    }


    // 页面加载后将卡片加载入
    window.onload = function() {
        var card = document.querySelector('.card');
        card.classList.add('loaded');
    };
</script>
</body>
</html>
