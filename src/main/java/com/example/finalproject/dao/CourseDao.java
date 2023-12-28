package com.example.finalproject.dao;

import com.example.finalproject.vo.Course_Class;
import com.example.finalproject.vo.Course_Select;
import com.example.finalproject.vo.Student;
import org.apache.ibatis.annotations.*;
import org.springframework.web.bind.annotation.RequestParam;


import java.math.BigDecimal;
import java.util.List;

@Mapper
public interface CourseDao {

    @Select("SELECT * FROM COURSE_CLASS WHERE TERM = #{term}")
    public List<Course_Class> findCourse_ClassByTerm(@RequestParam("term") String term);

    //查询该班级的所有学生成绩
    @Select("SELECT * FROM COURSE_SELECT WHERE COURSE_CLASSID = #{course_ClassId}")
    @Results({
            @Result(id = true,property = "course_SelectId",column = "course_SelectId"),
            @Result(property = "course_ClassId",column = "course_ClassId"),
            @Result(property = "grade",column = "grade"),
            @Result(property = "studentId",column = "studentId"),
            @Result(property = "student",column = "studentId",
                    javaType = Student.class,
                    one = @One(select = "com.example.finalproject.dao.StudentDao.findStudentByStudentId")
            ),
            @Result(property = "courseName",column = "course_ClassId",
            javaType = String.class,
            one = @One(select = "com.example.finalproject.dao.CourseDao.getCourse_ClassNameByCourseId"))
    })
    public List<Course_Select> showAllStudentGradeByCourse_ClassId(@RequestParam("course_ClassId") int course_ClassId);

    @Select("SELECT COUNT(*) AS student_count FROM course_select WHERE COURSE_CLASSID = #{course_ClassId}")
    public int getStudentNuByCourse_ClassId(@RequestParam("course_ClassId") int course_ClassId);

    @Select("SELECT AVG(GRADE) AS average_grade FROM course_select WHERE COURSE_CLASSID = #{course_ClassId}")
    public BigDecimal getAverageGradeByCourse_ClassId(@RequestParam("course_ClassId") int course_ClassId);

    @Select("SELECT COUNT(*) AS failed_students_count FROM course_select WHERE COURSE_CLASSID = #{course_ClassId} AND GRADE < 60")
    public int getFailedStudentsCountByCourse_ClassId(@RequestParam("course_ClassId") int course_ClassId);

    @Select("SELECT * FROM course_select WHERE COURSE_CLASSID = #{course_ClassId} AND GRADE < 60")//获取成绩小于60分的学生信息
    @Results({
            @Result(id = true,property = "course_SelectId",column = "course_SelectId"),
            @Result(property = "course_ClassId",column = "course_ClassId"),
            @Result(property = "grade",column = "grade"),
            @Result(property = "studentId",column = "studentId"),
            @Result(property = "student",column = "studentId",
                    javaType = Student.class,
                    one = @One(select = "com.example.finalproject.dao.StudentDao.findStudentByStudentId")
            )
    })
    public List<Course_Select> showFailedStudentGradeByCourseName(@RequestParam("course_ClassId") int course_ClassId);

    @Select("SELECT COURSENAME FROM COURSE WHERE COURSEID = #{courseId}")
    public String getCourseNameByCourseId(@RequestParam("courseId") int courseId);

    @Select("SELECT COURSE_CLASSNAME FROM COURSE_CLASS WHERE COURSE_CLASSID = #{courseId}")
    public String getCourse_ClassNameByCourseId(@RequestParam("courseId") int courseId);



}
