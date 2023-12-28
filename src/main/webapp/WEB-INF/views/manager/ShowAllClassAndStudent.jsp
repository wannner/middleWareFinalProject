<%@ page import="java.util.List" %>
<%@ page import="com.example.finalproject.vo.Class" %>
<%@ page import="com.example.finalproject.vo.Student" %><%--
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
    <title>班级学生信息</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/css/bootstrap.min.css">
    <style>
        body {
            padding: 20px;
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
        <h1>班级学生信息</h1>
    </div>
    <div class="table-container">
        <table class="custom-table">
            <thead>
            <tr>
                <th style="text-align: center">班级</th>
                <th style="text-align: center">学号</th>
                <th style="text-align: center">姓名</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Class> classes = (List<Class>) request.getAttribute("class");
                for (Class aClass : classes) {%>
            <tr>
                <td style="text-align: center" rowspan="<%= aClass.getStudents().size() != 0 ? aClass.getStudents().size() : 1 %>">
                    <%= aClass.getClassName() %></td>
                <%
                    if (aClass.getStudents().size()==0) {
                %>
                <td colspan="2" style="text-align: center; font-weight: bold; color: red;">暂无学生</td>
                <%
                    }
                    for (int i = 0; i < aClass.getStudents().size(); i++) {
                        if (i==0){
                %>
                <td style="text-align: center"><%=aClass.getStudents().get(i).getStudentId()%></td>
                <td style="text-align: center"><%=aClass.getStudents().get(i).getStudentName()%></td>
            </tr><%--这个班级只有一个人的情况--%>
            <%
            }else {
            %>
            <tr>
                <td style="text-align: center"><%=aClass.getStudents().get(i).getStudentId()%></td>
                <td style="text-align: center"><%=aClass.getStudents().get(i).getStudentName()%></td>
            </tr>
            <%
                    }
                }
            %>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>

</html>
