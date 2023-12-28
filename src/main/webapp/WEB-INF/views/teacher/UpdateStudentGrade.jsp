<%@ page import="com.example.finalproject.vo.Course_Select" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>录入成绩</title>
    <style>
        body {
            padding: 20px;
        }
        .custom-table input {
            width: 60px;
            padding: 5px;
            /* border: 1px solid #b8babe; */
            border-radius: 4px;
            /* box-sizing: border-box; */
            outline: none;
            transition: border-color 0.3s;
        }

        .delete-button {
            display: flex;
            justify-content: center;
            align-items: center;
            display: inline-block;
            padding: 8px 12px;
            border: none;
            background-color: rgb(113, 180, 253);
            color: #ffffff;
            font-size: 14px;
            text-align: center;
            text-decoration: none;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .delete-button:hover {
            background-color: #c82333;
        }

        .delete-button:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(220, 53, 69, 0.5);
        }


        .table-container {
            margin-top: 20px;
            overflow: hidden;
            display: flex;
            justify-content: center;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background-color: rgb(228, 238, 253);
        }

        .custom-table {
            width: 100%;
        }

        .custom-table th,
        .custom-table td {
            border: 1px solid #b8babe;
            padding: 8px;
            text-align: left;
            border-radius: 10px;
        }

        .custom-table th {
            background-color: #f2f2f2;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .custom-table td:first-child {
            border-top-left-radius: 10px;
            border-bottom-left-radius: 10px;
        }

        .custom-table td:last-child {
            border-top-right-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .title-container {
            text-align: center;
            margin-bottom: 20px;
        }

        /* 动画效果 */
        @keyframes slideInFromLeft {
            0% {
                transform: translateX(-100%);
            }
            100% {
                transform: translateX(0);
            }
        }

        .animated-row {
            animation: slideInFromLeft 0.5s ease-out;
        }

        /* 鼠标悬停反馈 */
        .custom-table tr:hover {
            background-color: #f5f5f5;
            cursor: pointer;
        }
    </style>

</head>
<body>
<form onsubmit="return false;" class="form-row">
    <div class="container">
        <div class="title-container">
            <h1>所有课程信息</h1>
        </div>
        <div class="table-container">
            <table class="table custom-table">
                <thead>
                <tr>
                    <th style="text-align: center">学号</th>
                    <th style="text-align: center">学生姓名</th>
                    <th style="text-align: center">平时分占比</th>
                    <th style="text-align: center">平时分</th>
                    <th style="text-align: center">实验分占比</th>
                    <th style="text-align: center">实验分</th>
                    <th style="text-align: center">卷面分占比</th>
                    <th style="text-align: center">卷面分</th>
                </tr>
                </thead>
                <tbody id="table-body">
                <%
                    List<Course_Select> course = (List<Course_Select>) request.getAttribute("course");
                    if(course!=null) for (Course_Select courseSelect : course) {
                %>
                <tr>
                    <td style="text-align: center"><input readonly value="<%=courseSelect.getStudentId()%>"></td>
                    <td style="text-align: center"><input readonly value="<%=courseSelect.getStudent().getStudentName()%>"></td>
                    <td style="text-align: center"><input id="weight1" type="number" min="0" max="100"></td>
                    <td style="text-align: center"><input id="number1" type="number" min="0" max="100"></td>
                    <td style="text-align: center"><input id="weight2" type="number" min="0" max="100"></td>
                    <td style="text-align: center"><input id="number2" type="number" min="0" max="100"></td>
                    <td style="text-align: center"><input id="weight3" type="number" min="0" max="100"></td>
                    <td style="text-align: center"><input id="number3" type="number" min="0" max="100"></td>
                </tr>
                <%
                        }
                %>
                </tbody>
            </table>
        </div>
    </div>
    <button class="delete-button" onclick="validateTotalWeight();submitForm();">提交</button>
</form>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
    function submitForm() {
        const course_ClassTable = document.getElementsByClassName('table-container')[0];
        const formRows = course_ClassTable.getElementsByTagName('tr');
        const course_ClassArray = [];

        for (let i = 1; i < formRows.length; i++) { // 从索引 1 开始，跳过表头行
            const formRow = formRows[i];
            const inputs = formRow.getElementsByTagName('input');

            const weight1 = parseInt(inputs[2].value || 0);
            const score1 = parseInt(inputs[3].value || 0);
            const weight2 = parseInt(inputs[4].value || 0);
            const score2 = parseInt(inputs[5].value || 0);
            const weight3 = parseInt(inputs[6].value || 0);
            const score3 = parseInt(inputs[7].value || 0);

            const grade = (weight1 * score1 + weight2 * score2 + weight3 * score3)/100;

            const studentData = {
                studentId: inputs[0].value,
                studentName: inputs[1].value,
                grade: grade
            };

            course_ClassArray.push(studentData);
        }



        $.ajax({
            url: 'http://localhost:8080/teacher/updateStudentGradeCheck',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(course_ClassArray),
            success: function (response) {
                alert('录入成绩成功');
                window.location.href = 'http://localhost:8080/teacher/showAllCourse_Grade';//创建成功，放回创建页面
            },
            error: function (error) {
                console.error(error);
                alert('录入成绩失败');
            }
        });
    }

    function validateTotalWeight() {
        var weight1 = parseInt(document.getElementById("weight1").value);
        var weight2 = parseInt(document.getElementById("weight2").value);
        var weight3 = parseInt(document.getElementById("weight3").value);

        var totalWeight = weight1 + weight2 + weight3;

        if (totalWeight > 100) {
            alert("错误：占比总和不能超过100%！");
            return false;
        }else if(totalWeight < 100) {
            alert("错误：占比总和不能低于100%！");
            return false;
        }

        return true;
    }
</script>
</html>

