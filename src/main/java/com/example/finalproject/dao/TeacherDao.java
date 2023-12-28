package com.example.finalproject.dao;

import com.example.finalproject.vo.Course_Class;
import com.example.finalproject.vo.Course_Select;
import com.example.finalproject.vo.Student;
import com.example.finalproject.vo.Teacher;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.math.BigDecimal;
import java.util.ListIterator;

@Mapper
public interface TeacherDao {
    @Select("SELECT * FROM TEACHER WHERE TEACHERID=#{id}")
    public Teacher findTeacherByTeacherId(@Param("id") String id);

    @Select("SELECT * FROM COURSE_CLASS WHERE TEACHERID=#{teacherId} AND TERM = #{term}")
    public List<Course_Class> findTeacherCourse_ClassByTerm(@Param("teacherId") String teacherId, @Param("term") String term);

    @Select("SELECT * FROM course_select WHERE COURSE_CLASSID = #{course_ClassId} AND GRADE = 0.00 OR GRADE IS NULL")
    @Results({
            @Result(property = "studentId", column = "studentId"),
            @Result(property = "student", column = "studentId",
                    javaType = Student.class,
                    one = @One(select = "com.example.finalproject.dao.StudentDao.findStudentByStudentId"))
    })
    List<Course_Select> getStudentsWithNullGrade(@Param("course_ClassId") int course_ClassId);

    @Update("UPDATE course_select SET GRADE = #{grade} " +
            "WHERE STUDENTID = #{studentID} " +
            "AND COURSE_CLASSID = #{course_ClassId}")
    public Boolean updateGradeByStudentIdAndCourse_ClassId(@Param("grade")BigDecimal grade,@Param("studentID") String studentId, @Param("course_ClassId") int course_ClassId);

    @Select("SELECT TEACHERNAME FROM TEACHER WHERE TEACHERID=#{teacherId}")
    String getTeacherNameById(String teacherId);

}
