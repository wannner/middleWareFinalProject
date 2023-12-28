package com.example.finalproject.dao;

import com.example.finalproject.vo.*;
import org.apache.ibatis.annotations.*;

import com.example.finalproject.vo.Class;
import java.util.List;

@Mapper
public interface ManagerDao {


    @Insert("<script>" +
            "INSERT INTO student (studentId, studentName, admission_year, className) VALUES " +
            "<foreach item='student' collection='students' separator=','>" +
            "(#{student.studentId}, #{student.studentName}, #{student.admission_year}, #{student.className})" +
            "</foreach>" +
            "</script>")
    public Boolean addStudent(@Param("students") List<Student> students);

    @Insert("<script>" +
            "INSERT INTO teacher (teacherId, teacherName) VALUES " +
            "<foreach item='teacher' collection='teachers' separator=','>" +
            "(#{teacher.teacherId}, #{teacher.teacherName})" +
            "</foreach>" +
            "</script>")
    public Boolean addTeacher(@Param("teachers") List<Teacher> teachers);

    @Insert("<script>" +
            "INSERT INTO course (courseName) VALUES " +
            "<foreach item='course' collection='courses' separator=','>" +
            "(#{course.courseName})" +
            "</foreach>" +
            "</script>")
    public Boolean addCourse(@Param("courses") List<Course> courses);


    @Insert("<script>" +
            "INSERT INTO course_class (course_ClassName, courseId, statue, term, teacherId, max_number) VALUES " +
            "<foreach item='course_Class' collection='course_Classes' separator=','>" +
            "(#{course_Class.course_ClassName}, #{course_Class.courseId}," +
            "#{course_Class.statue}, #{course_Class.term}, #{course_Class.teacherId}, #{course_Class.max_number})" +
            "</foreach>" +
            "</script>")
    public Boolean addCourse_Class(@Param("course_Classes") List<Course_Class> course_Classes);

    @Insert("<script>" +
            "INSERT INTO class (className) VALUES " +
            "<foreach item='class' collection='classes' separator=','>" +
            "(#{class.className})" +
            "</foreach>" +
            "</script>")
    public Boolean addClassCheck(@Param("classes")List<Class> classes);

    @Select("SELECT * FROM MANAGER WHERE MANAGERID=#{id}")
    public Manager findManagerByManagerId(@Param("id")String id);

    @Select("SELECT * FROM CLASS")
    @Results({
            @Result(id = true,property = "classId",column = "classId"),
            @Result(property = "className",column = "className"),
            @Result(property = "students",column = "className",
            javaType = List.class,
                    many = @Many(select = "com.example.finalproject.dao.StudentDao.findStudentByClassName")
            )
    })
    public List<Class> showAllClassAndStudent();

    @Select("SELECT * FROM COURSE")
    public List<Course> showAllCourse();

    @Select("SELECT * FROM TEACHER")
    public List<Teacher> showAllTeacher();

    @Select("SELECT * FROM Course_Class")
    public List<Course_Class> showAllCourse_Class();

    @Select("DELETE FROM COURSE WHERE COURSEID = #{courseId}")
    public Boolean deleteCourseByCourseId(@Param("courseId") int courseId);

    @Select("DELETE FROM course_Class WHERE course_ClassId = #{course_ClassId}")
    public Boolean deleteCourse_ClassByCourse_ClassId(@Param("course_ClassId") int course_ClassId);

    @Select("SELECT * FROM CLASS")
    public List<Class> getAllClass();

//    @Select("SELECT s.* " +
//            "FROM student s " +
//            "JOIN course_select cs ON s.STUDENTID = cs.STUDENTID " +
//            "JOIN course_class cc ON cs.COURSE_CLASSID = cc.COURSE_CLASSID " +
//            "WHERE cc.COURSEID = #{courseId} " +
//            "  AND cc.TERM = #{term} " +
//            "  AND cs.GRADE < 60")
//    List<Student> getStudentsWithGradeLessThan60(@Param("courseId") int courseId, @Param("term") String term);

    @Select("SELECT c.COURSENAME " +
            "FROM course c " +
            "INNER JOIN course_class cc ON c.COURSEID = cc.COURSEID " +
            "WHERE cc.TERM = #{term}")
    List<String> getCoursenameByTerm(@Param("term") String term);

    @Select("SELECT * " +
            "FROM course_select cs " +
            "INNER JOIN course_class cc ON cs.COURSE_CLASSID = cc.COURSE_CLASSID " +
            "INNER JOIN course c ON cc.COURSEID = c.COURSEID " +
            "WHERE cc.TERM = #{term} AND c.COURSENAME = #{coursename} AND cs.GRADE < 60")
    @Results({
            @Result(property = "grade",column = "grade"),
            @Result(property = "student", column = "studentId",
                    javaType = Student.class,
                    one = @One(select = "com.example.finalproject.dao.StudentDao.findStudentByStudentId"))
    })
    List<Course_Select> getStudentsWithGradeLessThan60(@Param("term") String term, @Param("coursename") String coursename);



}
