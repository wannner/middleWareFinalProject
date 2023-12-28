<%@ page import="com.example.finalproject.vo.Manager" %>
<%@ page import="com.example.finalproject.vo.Teacher" %>
<%@ page import="com.example.finalproject.vo.Student" %>
<!DOCTYPE html>
<html lang="en">
<%--
  Created by IntelliJ IDEA.
  User: wannner
  Date: 2023/6/13
  Time: 11:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vertical Collapsible Menu</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.2/css/bootstrap.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.0.2/js/bootstrap.bundle.min.js"></script>
    <style>
        .sidebar {
            background-color: #E0ECFFCC;
            color: #000;
            width: 200px;
            padding: 20px;
            transition: width 1s ease;
        }

        .sidebar.collapsed {
            width: 80px;
        }

        .sidebar .sidebar-brand {
            padding: 10px;
            font-size: 1.5rem;
            text-align: center;
            margin-bottom: 20px;
        }

        .sidebar .profile {
            text-align: center;
            margin-bottom: 20px;
        }

        .sidebar .profile img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-bottom: 10px;
        }

        .sidebar .profile p {
            margin: 0;
            color: #000;
            font-size: 14px;
        }

        .sidebar-menu .nav-link {
            color: #000;
            padding: 10px;
        }

        .sidebar-menu .nav-link:hover {
            background-color: #e9ecef;
        }

        .sidebar-menu .sub-menu .nav-link {
            padding-left: 40px;
            border-top: 1px solid #000;
        }

        .sidebar-menu .bottom-menu {
            position: absolute;
            bottom: 20px;
            left: 0;
            width: 100%;
            padding: 0 10px;
        }

        .sidebar-menu .bottom-menu .nav-link {
            padding: 5px;
            color: #000;
            font-size: 12px;
        }

        .main-content {
            padding: 20px;
            transition: margin-left 1s ease;
            flex: 1;
        }

        @media (min-width: 768px) {
            .container {
                display: flex;
                height: 100vh;
            }

            .sidebar {
                position: fixed;
                left: 0;
                top: 0;
                bottom: 0;
            }

            .main-content {
                margin-left: 200px;
            }
        }

        @media (max-width: 767px) {
            .container {
                height: auto;
            }

            .sidebar.collapsed {
                width: 100%;
            }

            .main-content.collapsed {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="sidebar">
        <div class="sidebar-brand">
            菜单
        </div>
        <div class="profile">
            <img src="https://img.zcool.cn/community/01ee3758158d4ba84a0d304fbe062e.png@1280w_1l_2o_100sh.png"
                 alt="Avatar">
            <%
                Student student = (Student) session.getAttribute("student");
                String studentName = student.getStudentName();
            %>
            <p><%= studentName %>同学</p>
        </div>
        <ul class="nav flex-column sidebar-menu">
            <li class="nav-item">
                <a class="nav-link" href="#submenu1" data-bs-toggle="collapse">管理</a>
                <div class="sub-menu collapse" id="submenu1">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="showPage('http://localhost:8080/student/studentSelect')">选课</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" onclick="showPage('http://localhost:8080/student/showGrade')">查看成绩</a>
                        </li>
                    </ul>
                </div>
            </li>
            <div class="bottom-menu">
                <a href="#" class="nav-link" onclick="showPage('http://localhost:8080/changePassword')">修改密码</a>
                <a href="http://localhost:8080/login" class="nav-link">退出登录</a>
            </div>
        </ul>
    </div>
    <div class="main-content">
        <iframe id="page-frame" src="" frameborder="0" width="100%" height="100%"></iframe>
    </div>
</div>
<script>
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');

    document.querySelector('.sidebar-brand').addEventListener('click', function () {
        sidebar.classList.toggle('collapsed');
        mainContent.classList.toggle('collapsed');
    });

    function showPage(pageUrl) {
        document.getElementById('page-frame').src = pageUrl;
    }
</script>
</body>
</html>
