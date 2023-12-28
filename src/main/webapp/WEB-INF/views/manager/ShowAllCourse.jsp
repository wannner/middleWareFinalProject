<%@ page import="com.example.finalproject.vo.Course" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: 28657
  Date: 2023/6/15
  Time: 20:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>所有课程信息</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/css/bootstrap.min.css">
    <style>
        body {
            padding: 20px;
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
<div class="container">
    <div class="title-container">
        <h1>所有课程信息</h1>
    </div>
    <div class="table-container">
        <table class="table custom-table">
            <thead>
            <tr>
                <th style="text-align: center">课程名称</th>
                <th style="text-align: center">删除</th>
            </tr>
            </thead>
            <tbody id="table-body">
            <%
                List<Course> course = (List<Course>) request.getAttribute("course");
                for (Course course1 : course) {
            %>
            <tr>
            <td style="text-align: center"><%=course1.getCourseName()%></td>
            <td style="text-align: center"><button  class="delete-button" onclick="handleDelete(<%=course1.getCourseId()%>)">删除</button> </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>

<script>
    function handleDelete(courseId) {
        // 在这里进行页面跳转的逻辑处理
        window.location.href = "http://localhost:8080/manager/deleteCourseByCourseId?courseId="+courseId;
    }
</script>



</html>
