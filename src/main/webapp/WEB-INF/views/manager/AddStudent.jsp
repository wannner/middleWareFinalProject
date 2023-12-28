<%@ page import="java.util.List" %>
<%@ page import="com.example.finalproject.vo.Class" %>
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
    <title>新增同学信息</title>
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

        .form-row {
            margin-bottom: 20px;
            display: flex; /* 使用 Flex 布局 */
            align-items: center; /* 在交叉轴上居中对齐 */
        }

        .form-row input {
            flex: 1; /* 自动分配宽度 */
            border-radius: 10px;
            padding: 8px;
            border: none;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            margin-right: 10px;
        }

        .form-row select {
            flex: 1; /* 自动分配宽度 */
            border-radius: 10px;
            padding: 8px;
            border: none;
            outline: none;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            margin-right: 10px;
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
            transition: background-color 1s ease-in-out; /* 添加过渡效果 */
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

        .form-container {
            background-color: rgba(196, 221, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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
            transition: background-color 1s ease-in-out; /* 添加过渡效果 */
        }

        .form-actions button:hover {
            background-color: rgba(0, 123, 255, 0.8);
        }

        .form-actions button:focus {
            outline: none;
        }

        .form-title {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }

        @keyframes slideInFromLeft {
            0% {
                transform: translateX(-100%);
                opacity: 0;
            }
            100% {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideInFromBottom {
            0% {
                transform: translateY(100%);
                opacity: 0;
            }
            100% {
                transform: translateY(0);
                opacity: 1;
            }
        }

        .form-row, .form-actions {
            animation: slideInFromLeft 1s ease-in-out forwards;
        }

        #student-table {
            animation: slideInFromBottom 1s ease-in-out forwards;
        }
    </style>
</head>
<body>
<form id="student-form" onsubmit="return false;">
    <div class="form-container">
        <h2 class="form-title">新增同学信息</h2>
        <div class="form-row">
            <input type="text" name="studentId" placeholder="请输入学号" style="opacity: 0;">
            <input type="text" name="studentName" placeholder="请输入姓名" style="opacity: 0;">
            <input type="text" name="admission_year" placeholder="请输入入学年份" style="opacity: 0;">
            <select name="classId" style="opacity: 0;">
                <option value="" selected disabled>请选择班级</option>
                <option value="1"></option>
                <option value="2">2班</option>
                <option value="3">3班</option>
                <option value="4">4班</option>
            </select>
            <button type="submit" style="opacity: 0;">移除</button>
        </div>
        <hr>
        <div id="student-table"></div>
        <div class="form-actions">
            <button type="button" onclick="addRow()">添加</button>
            <button type="submit" onclick="submitForm()">提交</button>
        </div>
    </div>
</form>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function submitForm() {
        const studentTable = document.getElementById('student-table');
        const formRows = studentTable.getElementsByClassName('form-row');
        const studentArray = [];

        for (let i = 0; i < formRows.length; i++) {
            const formRow = formRows[i];
            const inputs = formRow.getElementsByTagName('input');
            const select = formRow.getElementsByTagName('select')[0];

            const studentId = inputs[0].value;
            const studentName = inputs[1].value;
            const admission_year = inputs[2].value;
            const className = select.value;

            const studentData = {
                studentId: studentId,
                studentName: studentName,
                admission_year: admission_year,
                className: className
            };
            studentArray.push(studentData);
        }

        $.ajax({
            url: 'http://localhost:8080/manager/addStudentCheck',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(studentArray),
            success: function (response) {
                alert('学生创建成功');
                window.location.href = 'http://localhost:8080/manager/addStudent';//创建成功，放回创建页面
            },
            error: function (error) {
                console.error(error);
                alert('学生创建失败');
            }
        });
    }

    function addRow() {
        var table = document.getElementById('student-table');
        var row = document.createElement('div');
        row.className = 'form-row';

        var inputId = document.createElement('input');
        inputId.type = 'text';
        inputId.name = 'studentId';
        inputId.required = true;
        inputId.placeholder = "请输入学生学号"

        var inputName = document.createElement('input');
        inputName.type = 'text';
        inputName.name = 'studentName';
        inputName.required = true;
        inputName.placeholder = "请输入学生姓名"

        var inputYear = document.createElement('input');
        inputYear.type = 'number';
        inputYear.name = 'admission_year';
        inputYear.required = true;
        inputYear.placeholder = "请输入入学年份"

        var selectClass = document.createElement('select');
        selectClass.name = 'className';
        selectClass.required = true;


        var optionDefault = document.createElement('option');
        optionDefault.value = '';
        optionDefault.selected = true;
        optionDefault.disabled = true;
        optionDefault.textContent = '请选择班级';
        selectClass.appendChild(optionDefault);

        <% List<Class> classes1 = (List<Class>) request.getAttribute("class");
        for (Class aClass : classes1) { %>
        var option = document.createElement('option');
        option.value = '<%= aClass.getClassName() %>';
        option.textContent = '<%= aClass.getClassName() %>';
        selectClass.appendChild(option);
        <% } %>

        var button = document.createElement('button');
        button.type = 'button';
        button.textContent = '移除';
        button.onclick = function () {
            removeRow(this);
        };

        row.appendChild(inputId);
        row.appendChild(inputName);
        row.appendChild(inputYear);
        row.appendChild(selectClass);
        row.appendChild(button);

        table.appendChild(row);
    }

    function removeRow(button) {
        var row = button.parentNode;
        row.parentNode.removeChild(row);
    }
</script>
</body>
</html>
