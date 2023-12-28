<%@ page import="java.util.List" %>
<%@ page import="com.example.finalproject.vo.Course_Class" %>
<%@ page import="com.example.finalproject.vo.Student" %>
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
    <title>所有开课班级信息</title>
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


        .form-control {
            width: 30%;
            height: calc(1.5em + .75rem + 2px);
            padding: .375rem .75rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #495057;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: .25rem;
            transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
        }

        .table-container {
            margin-top: 20px;
            overflow: hidden;
            /* display: flex; */
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
<%
    List<String> courseName = (List<String>) request.getAttribute("courseName");
    String term = (String) request.getAttribute("term");
%>
<div class="container">
    <div class="title-container">
        <%
            List<Course_Select> student = (List<Course_Select>) request.getAttribute("student");
        %>
        <h1><%=student.get(0).getCourseName()%>课程</h1>
    </div>
    <div class="table-container">
        <form action="http://localhost:8080/manager/generateGradeReport1/showFailedStudentGradeByCourseName">
            <table class="table custom-table">
                <thead>
                <tr>
                    <th style="text-align: center">学号</th>
                    <th style="text-align: center">姓名</th>
                    <th style="text-align: center">班级</th>
                    <th style="text-align: center">成绩</th>
                </tr>
                </thead>
                <tbody id="table-body">
                <%
                    for (Course_Select student1 : student) {
                %>
                <tr>
                    <td style="text-align: center"><%=student1.getStudent().getStudentId()%></td>
                    <td style="text-align: center"><%=student1.getStudent().getStudentName()%></td>
                    <td style="text-align: center"><%=student1.getStudent().getClassName()%></td>
                    <td style="text-align: center"><%=student1.getGrade()%></td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </form>
    </div>
</div>
</body>

<script>
    function handleCourseSelection(term) {
        window.location.href = "http://localhost:8080/manager/generateGradeReport1?term=" + term;
    }
</script>


</html>
