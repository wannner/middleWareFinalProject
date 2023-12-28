<%@ page import="java.util.List" %>
<%@ page import="com.example.finalproject.vo.Class" %>
<%@ page import="com.example.finalproject.vo.Student" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.example.finalproject.vo.Course_Select" %><%--
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

        .class-info {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
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
        <%
            List<Course_Select> course_selects = (List<Course_Select>) request.getAttribute("studentSelect");
        %>
        <%
            if (!course_selects.isEmpty()){
        %>
        <h1><%=course_selects.get(0).getCourseName()%>教学班成绩表</h1>
        <%
        }
            else{
        %>
        <h1>该教学班暂无学生!</h1>
        <%}%>
    </div>
    <div class="class-info">
        <span>班级人数:<strong><%= (int) request.getAttribute("studentNu") %></strong><span id="classSize"></span></span>
        <span>班级平均分:<strong><%=(BigDecimal) request.getAttribute("averageGrade")%></strong><span id="classAverage"></span></span>
        <span>不及格人数:<strong><%=(int) request.getAttribute("failedStudentsCount")%></strong><span id="classFailCount"></span></span>
    </div>
    <div class="table-container">
        <table class="custom-table">
            <thead>
            <tr>
                <th style="text-align: center">学号</th>
                <th style="text-align: center">姓名</th>
                <th style="text-align: center">成绩</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Course_Select courseSelect : course_selects) {
            %>
            <tr>
                <td style="text-align: center"><%=courseSelect.getStudentId()%></td>
                <td style="text-align: center"><%=courseSelect.getStudent().getStudentName()%></td>
                <%
                    if(courseSelect.getGrade().compareTo(BigDecimal.valueOf(60))>0){
                %>
                <td style="text-align: center"><%=courseSelect.getGrade()%></td>
                <%
                }else {
                %>
                <td style="text-align: center">
                    <span style="font-weight: bold; color: red;"><%=courseSelect.getGrade()%></span>
                </td>
                <%
                    }
                %>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>

</html>
