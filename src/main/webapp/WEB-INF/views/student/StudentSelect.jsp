<%@ page import="java.util.List" %>
<%@ page import="com.example.finalproject.vo.Course_Class" %>
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
    String term= (String) request.getAttribute("term");
%>
<div class="container">
    <div class="title-container">
        <h1>所有课程信息</h1>
        <label for="select-course">选择学期:</label>
        <select class="form-control" id="select-course" onchange="handleCourseSelection(this.value)">
            <option value="">请选择</option>
            <%
                Student student = (Student) session.getAttribute("student");
                Integer admissionYear = student.getAdmission_year();
                int i=0;
                if(term!=null) {
                    String substring = term.substring(0, 4);
                    int number = Integer.parseInt(substring);
                    i = number - admissionYear;
                    i=i*2;
                    if (term.substring(4,5).equals("秋")) i++;
                }
            %>
            <option value="<%=admissionYear%>秋季学期"  <% if (term != null && i==1 ) { %> selected <% } %>><%=admissionYear%>秋季学期</option>
            <option value="<%=admissionYear+1%>春季学期"<% if (term != null && i==2 ) { %> selected <% } %>><%=admissionYear+1%>春季学期</option>
            <option value="<%=admissionYear+1%>秋季学期"<% if (term != null && i==3 ) { %> selected <% } %>><%=admissionYear+1%>秋季学期</option>
            <option value="<%=admissionYear+2%>春季学期"<% if (term != null && i==4 ) { %> selected <% } %>><%=admissionYear+2%>春季学期</option>
            <option value="<%=admissionYear+2%>秋季学期"<% if (term != null && i==5 ) { %> selected <% } %>><%=admissionYear+2%>秋季学期</option>
            <option value="<%=admissionYear+3%>春季学期"<% if (term != null && i==6 ) { %> selected <% } %>><%=admissionYear+3%>春季学期</option>
            <option value="<%=admissionYear+3%>秋季学期"<% if (term != null && i==7 ) { %> selected <% } %>><%=admissionYear+3%>秋季学期</option>
            <option value="<%=admissionYear+4%>春季学期"<% if (term != null && i==8 ) { %> selected <% } %>><%=admissionYear+4%>春季学期</option>
        </select>

    </div>
<%--    <div class="table-container">--%>
<%--        <form action="http://localhost:8080/student/studentSelectCheck">--%>
<%--        <table class="table custom-table">--%>
<%--            <thead>--%>
<%--            <tr>--%>
<%--                <th style="text-align: center">课程名</th>--%>
<%--                <th style="text-align: center">课程状态</th>--%>
<%--                <th style="text-align: center">任课老师</th>--%>
<%--                <th style="text-align: center">剩余名额</th>--%>
<%--                <th style="text-align: center">操作</th>--%>
<%--            </tr>--%>
<%--            </thead>--%>
<%--            <tbody id="table-body">--%>
<%--            <%--%>
<%--                List<Course_Class> courseClass = (List<Course_Class>) request.getAttribute("course_Class");--%>
<%--                if(courseClass!=null) for (Course_Class aClass : courseClass) {--%>
<%--            %>--%>
<%--            <tr>--%>
<%--                <td style="text-align: center"><%=aClass.getCourse_ClassName()%></td>--%>
<%--                <td style="text-align: center"><%=aClass.getStatue()%></td>--%>
<%--                <td style="text-align: center"><%=aClass.getTeacherName()%></td>--%>
<%--                <td style="text-align: center"><%=aClass.getMax_number()%></td>--%>
<%--                <td style="display: none;"><input type="hidden" name="course_ClassId" value="<%=aClass.getCourse_ClassID()%>"></td>--%>
<%--                <td style="text-align: center">                    <button type="button" class="delete-button"<%=aClass.getCourse_ClassID()%>>选课</button>--%>
<%--                    </td>--%>

<%--            </tr>--%>
<%--            <%--%>
<%--                }--%>
<%--            %>--%>
<%--            </tbody>--%>
<%--        </table>--%>
<%--            </form>--%>
<%--    </div>--%>
    <div class="table-container">
        <form action="http://localhost:8080/student/studentSelectCheck" method="post" id="courseForm">
            <table class="table custom-table">
                <thead>
                <tr>
                    <th style="text-align: center">课程名</th>
                    <th style="text-align: center">课程状态</th>
                    <th style="text-align: center">任课老师</th>
                    <th style="text-align: center">剩余名额</th>
                    <th style="text-align: center">操作</th>
                </tr>
                </thead>
                <tbody id="table-body">
                <%
                    List<Course_Class> courseClass = (List<Course_Class>) request.getAttribute("course_Class");
                    if(courseClass != null) for (Course_Class aClass : courseClass) {
                %>
                <tr>
                    <td style="text-align: center"><%=aClass.getCourse_ClassName()%></td>
                    <td style="text-align: center"><%=aClass.getStatue()%></td>
                    <td style="text-align: center"><%=aClass.getTeacherName()%></td>
                    <td style="text-align: center"><%=aClass.getMax_number()%></td>
                    <td style="text-align: center">
                        <input type="hidden" name="course_ClassIdddd" value="<%=aClass.getCourse_ClassID()%>">
                        <button type="button" class="delete-button" onclick="selectCourse('<%=aClass.getCourse_ClassID()%>')">选课</button>
                    </td>
                </tr>
                <%
                        }
                %>
                </tbody>
            </table>
        </form>
    </div>

    <script>
        function selectCourse(courseClassId) {
            // 构造请求参数
            var params = "course_ClassId=" + courseClassId;

            // 创建隐藏的表单元素
            var form = document.getElementById("courseForm");
            var input = document.createElement("input");
            input.type = "hidden";
            input.name = "course_ClassId";
            input.value = courseClassId;

            // 将隐藏的表单元素添加到表单中
            form.appendChild(input);

            // 提交表单
            form.submit();
        }
    </script>


</div>
</body>

<script>
    function submitForm(courseClassId) {
        // 设置隐藏域的值
        document.getElementById('course_ClassId').value = courseClassId;
        // 提交表单
        document.getElementById('selectForm').submit();
    }
    function handleCourseSelection(term) {
        window.location.href = "http://localhost:8080/student/studentSelect?term=" + term;
    }
</script>


</html>
