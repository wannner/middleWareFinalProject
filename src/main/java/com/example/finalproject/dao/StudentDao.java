package com.example.finalproject.dao;

import com.example.finalproject.vo.Course_Class;
import com.example.finalproject.vo.Course_Select;
import com.example.finalproject.vo.Student;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface StudentDao {

    @Select("SELECT * FROM STUDENT WHERE STUDENTID=#{id}")
    public Student findStudentByStudentId(@Param("id") String id);

    @Select("SELECT * FROM STUDENT WHERE CLASSNAME=#{className}")
    public List<Student> findStudentByClassName(@Param("className") String className);

    @Select("SELECT * " +
            "FROM course " +
            "JOIN course_class ON course.COURSEID = course_class.COURSEID " +
            "WHERE course_class.TERM = #{term} " +
            "AND course.COURSEID NOT IN ( " +
            "    SELECT course.COURSEID " +
            "    FROM course " +
            "    JOIN course_class ON course.COURSEID = course_class.COURSEID " +
            "    JOIN course_select ON course_class.COURSE_CLASSID = course_select.COURSE_CLASSID " +
            "    WHERE course_select.STUDENTID = #{studentId} AND course_class.TERM = #{term} " +
            ")")
    @Results({
            @Result(property = "course_ClassIdID", column = "course_ClassIdID"),
            @Result(property = "course_ClassIdName", column = "course_ClassIdName"),
            @Result(property = "statue", column = "statue"),
            @Result(property = "teacherName", column = "teacherId",
                    javaType = String.class,
                    one = @One(select = "com.example.finalproject.dao.TeacherDao.getTeacherNameById"))
    })
    List<Course_Class> getUnselectedCoursesByStudentId(@Param("term") String term, @Param("studentId") String studentId);

    @Insert("INSERT INTO course_select (COURSE_CLASSID, STUDENTID) VALUES (#{courseClassId}, #{studentId})")
    void addCourseSelection(@Param("courseClassId") int courseClassId, @Param("studentId") String studentId);

    @Select("SELECT * FROM course_select cs " +
            "INNER JOIN course_class cc ON cs.COURSE_CLASSID = cc.COURSE_CLASSID " +
            "WHERE cs.STUDENTID = #{studentId} " +
            "AND cc.TERM = #{term}")
    @Results({
            @Result(property = "grade", column = "grade"),
            @Result(property = "courseName", column = "courseId",
                    javaType = String.class,
                    one = @One(select = "com.example.finalproject.dao.CourseDao.getCourseNameByCourseId"))
    })
    List<Course_Select> getStudentGradeByTerm(@Param("studentId") String studentId, @Param("term") String term);

    @Select("SELECT * FROM course_class")
    List<Course_Class> getAllCourseClass();

    @Update("UPDATE course_class SET max_number = #{maxNumber} WHERE COURSE_CLASSID = #{courseClassId}")
    void updateMaxNumber(@Param("courseClassId") int courseClassId, @Param("maxNumber") int maxNumber);

}
