<%@ page import="java.util.List" %>
<%@ page import="com.example.finalproject.vo.Course_Class" %><%--
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
    List<Course_Class> course = (List<Course_Class>) request.getAttribute("course_Class");
    String term= (String) request.getAttribute("term");
%>
<div class="container">
    <div class="title-container">
        <h1>报表界面</h1>
        <label for="select-course">选择学期:</label>
        <select class="form-control" id="select-course" onchange="handleCourseSelection(this.value)">
            <option value="">请选择</option>
            <option value="2021秋季学期" <% if (term != null && term.equals("2021秋季学期")) { %> selected <% } %>>2021秋季学期</option>
            <option value="2022春季学期" <% if (term != null && term.equals("2022春季学期")) { %> selected <% } %>>2022春季学期</option>
            <option value="2022秋季学期" <% if (term != null && term.equals("2022秋季学期")) { %> selected <% } %>>2022秋季学期</option>
            <option value="2023春季学期" <% if (term != null && term.equals("2023春季学期")) { %> selected <% } %>>2023春季学期</option>
            <option value="2023秋季学期" <% if (term != null && term.equals("2023秋季学期")) { %> selected <% } %>>2023秋季学期</option>
            <option value="2024春季学期" <% if (term != null && term.equals("2024春季学期")) { %> selected <% } %>>2024春季学期</option>
            <option value="2024秋季学期" <% if (term != null && term.equals("2024秋季学期")) { %> selected <% } %>>2024秋季学期</option>
            <option value="2025春季学期" <% if (term != null && term.equals("2025春季学期")) { %> selected <% } %>>2025春季学期</option>
            <option value="2025秋季学期" <% if (term != null && term.equals("2025秋季学期")) { %> selected <% } %>>2025秋季学期</option>
            <option value="2026春季学期" <% if (term != null && term.equals("2026春季学期")) { %> selected <% } %>>2026春季学期</option>
            <option value="2026秋季学期" <% if (term != null && term.equals("2026秋季学期")) { %> selected <% } %>>2026秋季学期</option>
            <option value="2027春季学期" <% if (term != null && term.equals("2027春季学期")) { %> selected <% } %>>2027春季学期</option>
            <option value="2027秋季学期" <% if (term != null && term.equals("2027秋季学期")) { %> selected <% } %>>2027秋季学期</option>
        </select>

    </div>
    <div class="table-container">
            <table class="table custom-table">
                <thead>
                <tr>
                    <th style="text-align: center">开课班级名称</th>
                    <th style="text-align: center">开课状态</th>
                    <th style="text-align: center">操作</th>
                </tr>
                </thead>
                <tbody id="table-body">
                <%
                    if(course!=null)for (Course_Class courseClass : course) {
                %>
                <form action="http://localhost:8080/manager/generateGradeReport/showAllStudentGradeByCourse_ClassId">
                <tr>
                    <td style="text-align: center"><%=courseClass.getCourse_ClassName()%></td>
                    <td style="text-align: center"><%=courseClass.getStatue()%></td>
                    <td style="display: none;"><input type="hidden" name="course_ClassId" value="<%=courseClass.getCourse_ClassID()%>"></td>
                    <td style="text-align: center"><input type="submit" value="生成成绩报表" class="delete-button"></td>
                </tr>
                </form>

                <%
                        }
                %>
                </tbody>
            </table>
    </div>
</div>
</body>

<script>
    function handleCourseSelection(term) {
        window.location.href = "http://localhost:8080/manager/generateGradeReport?term=" + term;
    }
</script>


</html>
