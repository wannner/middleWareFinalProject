<%@ page import="java.util.List" %>
<%@ page import="com.example.finalproject.vo.Course" %>
<%@ page import="com.example.finalproject.vo.Teacher" %>
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
    <title>新增开课班级信息</title>
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

        .form-container {
            background-color: rgba(196, 221, 255, 0.8);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
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

        #class-table {
            animation: slideInFromBottom 1s ease-in-out forwards;
        }
    </style>
</head>
<body>
<form id="class-form" onsubmit="return false;">
    <div class="form-container">
        <h2 class="form-title">新增开课班级信息</h2>
        <div class="form-row">
            <label>
                <input type="text" name="className" placeholder="请输入开课班级名称" style="opacity: 0;">
            </label>
            <label>
                <select name="course" style="opacity: 0;">
                    <option value="" selected disabled>请选择课程</option>
                </select>
            </label>
            <label>
                <select name="status[]" style="opacity: 0;">
                    <option value="" selected disabled>请选择课程状态</option>
                </select>
            </label>
            <label>
                <select name="semester[]" style="opacity: 0;">
                    <option value="" selected disabled>请选择开课学期</option>
                </select>
            </label>
            <label>
                <select name="teacher[]" style="opacity: 0;">
                    <option value="" selected disabled>请选择上课老师</option>
                </select>
            </label>
            <label>
                <input type="number" name="max_number" placeholder="请输入开班人数" style="opacity: 0;">
            </label>
            <button type="submit" style="opacity: 0;">移除</button>
        </div>
        <hr>
        <div id="class-table"></div>
        <div class="form-actions">
            <button type="button" onclick="addRow()">添加</button>
            <button type="submit" onclick="submitForm()">提交</button>
        </div>
    </div>
</form>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function submitForm() {
        const course_ClassTable = document.getElementById('class-table');
        const formRows = course_ClassTable.getElementsByClassName('form-row');
        const course_ClassArray = [];

        for (let i = 0; i < formRows.length; i++) {
            const formRow = formRows[i];
            const inputs0 = formRow.getElementsByTagName('input')[0];
            const select0 = formRow.getElementsByTagName('select')[0];
            const select1 = formRow.getElementsByTagName('select')[1];
            const select2 = formRow.getElementsByTagName('select')[2];
            const select3 = formRow.getElementsByTagName('select')[3];
            const inputs1 = formRow.getElementsByTagName('input')[1];

            const course_ClassName = inputs0.value;
            const courseId = select0.value;
            const statue = select1.value;
            const term = select2.value;
            const teacherId = select3.value;
            const max_number = inputs1.value;
            const studentData = {
                course_ClassName: course_ClassName,
                courseId: courseId,
                statue: statue,
                term: term,
                teacherId: teacherId,
                max_number: max_number
            };
            course_ClassArray.push(studentData);
        }

        $.ajax({
            url: 'http://localhost:8080/manager/addCourse_ClassCheck',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(course_ClassArray),
            success: function (response) {
                alert('开课班级创建成功');
                window.location.href = 'http://localhost:8080/manager/addCourse_Class';//创建成功，放回创建页面
            },
            error: function (error) {
                console.error(error);
                alert('开课班级创建失败');
            }
        });
    }

    function addRow() {
        var table = document.getElementById('class-table');
        var row = document.createElement('div');
        row.className = 'form-row';

        var inputClassName = document.createElement('input');
        inputClassName.type = 'text';
        inputClassName.name = 'course_ClassName';
        inputClassName.required = true;
        inputClassName.placeholder = '请输入开课班级名称';

        var selectCourse = document.createElement('select');
        selectCourse.name = 'courseId';
        selectCourse.required = true;

        var optionCourseDefault = document.createElement('option');
        optionCourseDefault.value = '';
        optionCourseDefault.selected = true;
        optionCourseDefault.disabled = true;
        optionCourseDefault.textContent = '请选择课程';
        selectCourse.appendChild(optionCourseDefault);

        <% List<Course> courses = (List<Course>) request.getAttribute("course");
        for (Course cours : courses) { %>
        var option = document.createElement('option');
        option.value = '<%= cours.getCourseId()%>';
        option.textContent = '<%= cours.getCourseName() %>';
        selectCourse.appendChild(option);
        <% } %>


        var selectStatus = document.createElement('select');
        selectStatus.name = 'status[]';
        selectStatus.required = true;

        var optionStatusDefault = document.createElement('option');
        optionStatusDefault.value = '';
        optionStatusDefault.selected = true;
        optionStatusDefault.disabled = true;
        optionStatusDefault.textContent = '请选择课程状态';

        var optionNormal = document.createElement('option');
        optionNormal.value = '正常';
        optionNormal.textContent = '正常';

        var optionMakeup = document.createElement('option');
        optionMakeup.value = '补考';
        optionMakeup.textContent = '补考';

        var optionRetake = document.createElement('option');
        optionRetake.value = '重修';
        optionRetake.textContent = '重修';

        var optionDeferred = document.createElement('option');
        optionDeferred.value = '缓考';
        optionDeferred.textContent = '缓考';

        selectStatus.appendChild(optionStatusDefault);
        selectStatus.appendChild(optionNormal);
        selectStatus.appendChild(optionMakeup);
        selectStatus.appendChild(optionRetake);
        selectStatus.appendChild(optionDeferred);

        var selectSemester = document.createElement('select');
        selectSemester.name = 'semester[]';
        selectSemester.required = true;

        var optionSemesterDefault = document.createElement('option');
        optionSemesterDefault.value = '';
        optionSemesterDefault.selected = true;
        optionSemesterDefault.disabled = true;
        optionSemesterDefault.textContent = '请选择开课学期';

        var optionFall2021 = document.createElement('option');
        optionFall2021.value = '2021秋季学期';
        optionFall2021.textContent = '2021秋季学期';

        var optionSpring2022 = document.createElement('option');
        optionSpring2022.value = '2022春季学期';
        optionSpring2022.textContent = '2022春季学期';

        var optionFall2022 = document.createElement('option');
        optionFall2022.value = '2022秋季学期';
        optionFall2022.textContent = '2022秋季学期';

        var optionSpring2023 = document.createElement('option');
        optionSpring2023.value = '2023春季学期';
        optionSpring2023.textContent = '2023春季学期';

        var optionFall2023 = document.createElement('option');
        optionFall2023.value = '2023秋季学期';
        optionFall2023.textContent = '2023秋季学期';

        var optionSpring2024 = document.createElement('option');
        optionSpring2024.value = '2024春季学期';
        optionSpring2024.textContent = '2024春季学期';

        var optionFall2024 = document.createElement('option');
        optionFall2024.value = '2024秋季学期';
        optionFall2024.textContent = '2024秋季学期';

        var optionSpring2025 = document.createElement('option');
        optionSpring2025.value = '2025春季学期';
        optionSpring2025.textContent = '2025春季学期';

        var optionFall2025 = document.createElement('option');
        optionFall2025.value = '2025秋季学期';
        optionFall2025.textContent = '2025秋季学期';

        var optionSpring2026 = document.createElement('option');
        optionSpring2026.value = '2026春季学期';
        optionSpring2026.textContent = '2026春季学期';

        var optionFall2026 = document.createElement('option');
        optionFall2026.value = '2026秋季学期';
        optionFall2026.textContent = '2026秋季学期';

        var optionSpring2027 = document.createElement('option');
        optionSpring2027.value = '2027春季学期';
        optionSpring2027.textContent = '2027春季学期';

        var optionFall2027 = document.createElement('option');
        optionFall2027.value = '2027秋季学期';
        optionFall2027.textContent = '2027秋季学期';


        selectSemester.appendChild(optionSemesterDefault);
        selectSemester.appendChild(optionFall2021);
        selectSemester.appendChild(optionSpring2022);
        selectSemester.appendChild(optionFall2022);
        selectSemester.appendChild(optionSpring2023);
        selectSemester.appendChild(optionFall2023);
        selectSemester.appendChild(optionSpring2024);
        selectSemester.appendChild(optionFall2024);
        selectSemester.appendChild(optionSpring2025);
        selectSemester.appendChild(optionFall2025);
        selectSemester.appendChild(optionSpring2026);
        selectSemester.appendChild(optionFall2026);
        selectSemester.appendChild(optionSpring2027);
        selectSemester.appendChild(optionFall2027);

        var selectTeacher = document.createElement('select');
        selectTeacher.name = 'teacher[]';
        selectTeacher.required = true;

        var optionTeacherDefault = document.createElement('option');
        optionTeacherDefault.value = '';
        optionTeacherDefault.selected = true;
        optionTeacherDefault.disabled = true;
        optionTeacherDefault.textContent = '请选择上课老师';
        selectTeacher.appendChild(optionTeacherDefault);

        <% List<Teacher> teachers = (List<Teacher>) request.getAttribute("teacher");
        for (Teacher teacher : teachers) { %>
        var option = document.createElement('option');
        option.value = '<%= teacher.getTeacherId()%>';
        option.textContent = '<%= teacher.getTeacherName() %>';
        selectTeacher.appendChild(option);
        <% } %>

        var inputMax_Number = document.createElement('input');
        inputMax_Number.type = 'number';
        inputMax_Number.name = 'max_number';
        inputMax_Number.required = true;
        inputMax_Number.placeholder = '请输入开班人数';

        var button = document.createElement('button');
        button.type = 'button';
        button.textContent = '移除';
        button.onclick = function () {
            removeRow(this);
        };
        row.appendChild(inputClassName);
        row.appendChild(selectCourse);
        row.appendChild(selectStatus);
        row.appendChild(selectSemester);
        row.appendChild(selectTeacher);
        row.appendChild(inputMax_Number);
        row.appendChild(button);
        table.appendChild(row);
    }

    document.getElementById('class-form').addEventListener('submit', function (event) {
        event.preventDefault();
        var form = event.target;
        var formData = new FormData(form);
        var data = {};

        for (var [name, value] of formData) {
            if (!data[name]) {
                data[name] = [];
            }
            data[name].push(value);
        }

        console.log(data);

        // 发送数据到服务器的逻辑
        // ...

        form.reset();
        var table = document.getElementById('class-table');
        table.innerHTML = '';
    });

    function removeRow(button) {
        var row = button.parentNode;
        row.parentNode.removeChild(row);
    }

</script>
</body>
</html>
